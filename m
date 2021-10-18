Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771CF431312
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 11:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhJRJS3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 05:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhJRJS0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 05:18:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B8C06161C;
        Mon, 18 Oct 2021 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vp/9tbDt+u2+sZpQokequu0uJ3PAIfwBSiCgHpUgdOA=; b=h/G5/eJqjajNwGI+Ryhs04ZyI0
        cqjMYuAQszoeX9StonOmLtaYRa4J0gsf5t0wnmWIvLKT1B2DeTanabuStNsjcHOQ5KX1wN1sfxOz7
        sr7qsmzI0RkBfMdb84/HOlXg9A1pEZ/gs6wkJH6O2mQvNanPGcuv13kizrMpelcWu5PeOhYLRkPSJ
        9JlP2+6miHuDSGfQT96+nYmW/E8l6C3myv9C0KmtbLTopuacEzRGeK0z7JzdXjq1X1pxZusV8AhjH
        58gTs2lUEB23dgwHhM3unoEDzpbo78iHwLUprdOiVczpPK8WKbyJyDt+sYBL/06q56hNuwsNnrCWj
        7ymy9B3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcOk9-00AWJv-HQ; Mon, 18 Oct 2021 09:15:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2EFC2300221;
        Mon, 18 Oct 2021 11:15:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11F292CDA89B2; Mon, 18 Oct 2021 11:15:40 +0200 (CEST)
Date:   Mon, 18 Oct 2021 11:15:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, rafael@kernel.org,
        len.brown@intel.com, linux-pm@vger.kernel.org,
        sfr@canb.auug.org.au, gor@linux.ibm.com
Subject: Re: next-20211015: suspend to ram on x86-32 broken
Message-ID: <YW07O8ZPLVnbGLR7@hirez.programming.kicks-ass.net>
References: <20211017093905.GA3069@amd>
 <20211017102547.GA3818@amd>
 <20211018071349.GA16631@duo.ucw.cz>
 <20211018081300.GA18193@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018081300.GA18193@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 18, 2021 at 10:13:00AM +0200, Pavel Machek wrote:
> Hi!
> > It said
> > 
> > commit 8850cb663b5cda04d33f9cfbc38889d73d3c8e24 (HEAD)
> > Author: Peter Zijlstra <peterz@infradead.org>
> > Date:   Tue Sep 21 22:16:02 2021 +0200
> > 
> >     sched: Simplify wake_up_*idle*()
> > 
> > is first bad commit.
> 
> And reverting that one on the top of -next indeed fixes resume on
> thinkpad x60.

Can you try with just reverting the smp.c hunk and leaving the sched
hunk in place? I've got a hotplug lock related splat in my inbox from
late last week that I didn't get around to yet, I suspect they're
related.

