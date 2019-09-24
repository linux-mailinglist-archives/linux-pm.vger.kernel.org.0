Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631B0BCC02
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2019 18:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389879AbfIXQBx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 12:01:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389811AbfIXQBx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 12:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7SWbyCAQLuz6lSXDStLcWsYGPgqqeowRge5xr8uYsYk=; b=hTPOCPlOG8v9AjgWCto7xh7LO
        pCLwqJ4CwHLSWmzfmQU/lefdid+uLQ81f52vXuS178ovKik3aKpmWbxTHgBS55owRz3nCY8f79MJi
        Gh4QimWzglQxojPE3Qk0QOBTmCv7DcZN6c23Eq1E4iGkFIR33OT++XIJvx7YxPdX/VmpwEwt+3eKk
        MYtF/YvnlQh/NrPe7ulDLx7Yrp//ohasgDuAW1TT9M0vS/IprfkO3i8PWNz9SklP03BEPXyUT4ehT
        mAnECDFUcguH8vJVJtnzMc4YbbB5gzFpw+FJIa4tA0+KE7l1Cr9tkD6DXCVc5RqAcmizz+9fV8k/o
        iDjr3GUWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCnFy-0004n0-9r; Tue, 24 Sep 2019 16:01:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F90D3053E9;
        Tue, 24 Sep 2019 18:00:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01C2529E510A5; Tue, 24 Sep 2019 18:01:35 +0200 (CEST)
Date:   Tue, 24 Sep 2019 18:01:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        matt@codeblueprint.co.uk, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, pjt@google.com, vincent.guittot@linaro.org,
        qperret@qperret.net, dietmar.eggemann@arm.com
Subject: Re: [PATCH 0/2] Add support for frequency invariance for (some) x86
Message-ID: <20190924160135.GM2369@hirez.programming.kicks-ass.net>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909024216.5942-1-ggherdovich@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 09, 2019 at 04:42:14AM +0200, Giovanni Gherdovich wrote:
> This is a resend with of Peter Zijlstra's patch to support frequency
> scale-invariance on x86 from May 2018 [see 1]. I've added some modifications
> and included performance test results. If Peter doesn't mind, I'm slapping my
> name on it :)

That is fine; all I did was write some code, you did the hard part and
made it 'work' :-)
