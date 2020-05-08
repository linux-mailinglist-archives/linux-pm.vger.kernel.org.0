Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07111CB170
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgEHOKY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 10:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726792AbgEHOKX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 10:10:23 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BD8C05BD43;
        Fri,  8 May 2020 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0S9YlEMp9Fll1gT9k7DjCjsWQkPxcTbl7fnb3cKQ7G4=; b=fBiQd9Iz1busnHlOGBKJ5hWfHK
        VcHIwfHaTUDN8GUwzo86b71ehk4KpZzkjb4rK+QFmyAc2eVLTeKpJL6ygT4xq/the3Ue2hL4CLhch
        CR4i7CXFLkj20SB4bc8yqzgddId1ZbU8dVEoznPe96yFCNi0acypBXqbeF4ceXz4e72fXzwxCWxvL
        BixOPAZb50ASIYtxi/EoQ7gTMzIKYPe/cvob6kwUYwyF9L3anypR6ASURchw0+OEZL8ewvZN69TN/
        LCfyP21Y/Lj/ph0jTnnhURUZ7/opiQQu5XBoPhbrFKcxY+Tqa6C+avK3qRpxwmYgSbzn/ibn0PKBO
        xME49MLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX3h8-0005Ij-AE; Fri, 08 May 2020 14:09:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2712E3079EB;
        Fri,  8 May 2020 16:09:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A42C28688AB1; Fri,  8 May 2020 16:09:39 +0200 (CEST)
Date:   Fri, 8 May 2020 16:09:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, sudeep.holla@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        fweisbec@gmail.com, tkjos@google.com, kernel-team@android.com
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200508140938.GA3344@hirez.programming.kicks-ass.net>
References: <20200507181012.29791-1-qperret@google.com>
 <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com>
 <20200508111612.GA252673@google.com>
 <20200508113141.GB5298@hirez.programming.kicks-ass.net>
 <20200508130507.GA10541@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508130507.GA10541@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 08, 2020 at 02:05:07PM +0100, Quentin Perret wrote:
> So, all in all, I don't think the series actively makes schedutil worse
> by adding out-of-line calls in the hot path or anything like that, and

Do note that (afaik) ARM64 (and Power and probably others) has modules
in an address space that is not reachable from regular kernel text and
needs those intermediate trampolines.

While that's probably not a very big deal, it does increase L1$ pressure
and things.
