Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705D6295ACF
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 10:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508401AbgJVIqa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 04:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506224AbgJVIqa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 04:46:30 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4478C0613CE;
        Thu, 22 Oct 2020 01:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uBCdrEFF9TsGphpledx/KbcInbWr+mZ9pT6EU7jIkE0=; b=eyaRgsYa7arPPaGxNWa00kV0Th
        okVDAs8qc2hp2I5An6w9oB6MPH/sZmEWYkSnIC8uo+d1M5VTJfXENhNAiUCEY+tOvMfK3KYlKqWeF
        xBXTO97OKSrdt2vkoPxUAJT8zpsR2I78obWlJYmNdKOnWNqk8yvk8c5QlBtzwhYTM4tbD3BfZ12ys
        CI1YSoSMebUHEVnpl2uXBGFuPPTtVhemk7mKx1AZqSlLgFgIjwSz3UtjD2uRP3AjHiyg3b5b3lPFi
        Yimg1DzAixSD2emJZNg6HNe1wZ8yaYySakD8yOBrw6l7Gz7GeYNZCxUNtu8DIo/yD2c9sELHCwNFy
        CeX/iahg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVWEo-0005d7-6g; Thu, 22 Oct 2020 08:46:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B6573011C6;
        Thu, 22 Oct 2020 10:46:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7908A2B7802F0; Thu, 22 Oct 2020 10:46:18 +0200 (CEST)
Date:   Thu, 22 Oct 2020 10:46:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v2 1/3] x86, sched: check for counters overflow in
 frequency invariant accounting
Message-ID: <20201022084618.GU2628@hirez.programming.kicks-ass.net>
References: <20200531182453.15254-1-ggherdovich@suse.cz>
 <20200531182453.15254-2-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531182453.15254-2-ggherdovich@suse.cz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 31, 2020 at 08:24:51PM +0200, Giovanni Gherdovich wrote:

Hi Giovanni!

> +error:
> +	pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
> +	schedule_work(&disable_freq_invariance_work);
> +}

I'm getting reports that we trigger this on resume. Would it make sense
to hook into tsc_{save,restore}_sched_clock_state() (or somewhere near
there) to reset the state (basically call init_counter_refs() again to
ensure we're not having to deal with crazy ?
