Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05451CA5C1
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 10:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEHIMa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 04:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgEHIMa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 04:12:30 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071CC05BD43;
        Fri,  8 May 2020 01:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3ahC++fEwMzmLLM2QpP2jvwJMwZREpXt88C4KYJBX2U=; b=u/BuPo7WsiFvewU2RMhJpL7PNC
        3/dZzUXyh/eiYNNFsAgV0nNEpU6QXz3cLsV+fb4rcK3VQ7FTjKBNe3/ArFyBBYY4QEStYjxEaPv2q
        zkToNxMIkliWpH5z1CmXlsPYGFUEohVtY9/xQLwafuXbFqV+okSh7+KJyWfwpZlJ1eu1or5oK4hw5
        4z2RoIQXsiuyOdeUzbAiCAG/QbdlzbGmshvf2DP4bEtzaeMo5ZrZxpAt7TvIRaakE4KCHS6Yva8oj
        ikC+7/+sr/MFvTh5oLOxsFrtzO08ieBJeoM0nWN7HcqrIWfVA2D8iaeUZZdK7LFAhCxVPVqltkP5u
        EAKiGU8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWy6V-0003Fp-Jk; Fri, 08 May 2020 08:11:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B060A301A80;
        Fri,  8 May 2020 10:11:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C4892038FB83; Fri,  8 May 2020 10:11:28 +0200 (CEST)
Date:   Fri, 8 May 2020 10:11:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        fweisbec@gmail.com, tkjos@google.com, kernel-team@android.com
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200508081128.GM5298@hirez.programming.kicks-ass.net>
References: <20200507181012.29791-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 07, 2020 at 07:09:58PM +0100, Quentin Perret wrote:
> One challenge to implement GKI is to avoid bloating the kernel by
> compiling too many things in, especially given that different devices
> need different things. As such, anything that can be turned into a
> module helps GKI, by offering an alternative to having that component
> built-in. This is true for pretty much anything that can be made
> modular, including drivers as well as other kernel components, such as
> CPUFreq governors.

The idea is to move to 1 governor, schedutil. Also, I abhor all the
exports this thing does. Modules have no business touching most of that.

Look at every EXPORT you do and wonder ask yourself how you can abuse
it. Modules are not a good thing, they're horrible pieces of crap.
