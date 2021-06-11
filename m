Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7562B3A3E46
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jun 2021 10:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhFKIuQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Jun 2021 04:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhFKIuO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Jun 2021 04:50:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1F1C061574;
        Fri, 11 Jun 2021 01:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BHB0MsTGbUVUhvNVmFXvgWSz+NQYW3zX/BAZ/e3SbK0=; b=BpzgG4YmXEem2/NVRIsXxMcgIE
        kEZ1P+GXuuLDvbqbxX46cc146/b24RARQyxsrVoVyK2NW5KvivPHUNawVXas2oW6LxdsR/8pDwe/j
        9l0KwvXfGZPnp49tMBJdBzsTJvGQWSkl5PdGHHVPJ+ErHKNuARIJNwlq/VBRY6Ga+mJrbFfChY97s
        m5l3RCScHIJa2coSN/NnGNDpig/WTn1WzObj22mb+PGuuNrB9ESAeF7OagKMYtyWGoATYmRI2Geef
        OnV58/v31laTdClzK4gO22ewZ+aEsdDBOF7SnjHON07dRtlTa4NDKt6OGncOhpCdQ/TUpj3Lk83PK
        DbGs1J5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lrcnv-002aGa-3U; Fri, 11 Jun 2021 08:46:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDE5B3001E3;
        Fri, 11 Jun 2021 10:46:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AEFD92BC12DA3; Fri, 11 Jun 2021 10:46:14 +0200 (CEST)
Date:   Fri, 11 Jun 2021 10:46:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] freezer,sched: Rewrite core freezer logic
Message-ID: <YMMi1pG+FwyhZ9b7@hirez.programming.kicks-ass.net>
References: <YMMijNqaLDbS3sIv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMMijNqaLDbS3sIv@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 11, 2021 at 10:45:00AM +0200, Peter Zijlstra wrote:
> @@ -52,41 +52,67 @@ bool freezing_slow_path(struct task_stru
>  }
>  EXPORT_SYMBOL(freezing_slow_path);
>  
> +/* Recursion relies on tail-call optimization to not blow away the stack */
> +static bool __frozen(struct task_struct *p)
> +{
> +	if (p->state == TASK_FROZEN)
> +		return true;
> +
> +	/*
> +	 * If stuck in TRACED, and the ptracer is FROZEN, we're frozen too.
> +	 */
> +	if (task_is_traced(p))
> +		return frozen(rcu_dereference(p->parent));
> +
> +	/*
> +	 * If stuck in STOPPED and the parent is FROZEN, we're frozen too.
> +	 */
> +	if (task_is_stopped(p))
> +		return frozen(rcu_dereference(p->real_parent));
> +
> +	return false;
> +}
> +
> +bool frozen(struct task_struct *p)
> +{
> +	bool ret;
> +
> +	rcu_read_lock();
> +	ret = __frozen(p);
> +	rcu_read_unlock();
> +
> +	return ret;
> +}

Oleg, this bit in particular we'd like some feedback on, if possible.

Thanks!
