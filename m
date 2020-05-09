Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDEC1CBC9B
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 04:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgEICnU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 22:43:20 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:57012 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728158AbgEICnT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 22:43:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588992199; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=BbVz6HqHAyRslwozCCsKDEZmBFDN7DsxKLsJrjVuGuQ=; b=MgYyVZSF5aeQIyUQKEAQcwRSEtMJhDNsjAXYCQ9iq894eRNCYNYxR8mEXfM9YSUAPOrVJx3u
 7Ik7DaoVictmhNodU6Wrtn7JafQ7+NGO9s7XjEymKWWniwTPrurIDtJIaO/UswyV0gcpadVy
 queGhOhe++8J/v5wApTK2dkroRs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb618bf.7fa3de2345a8-smtp-out-n05;
 Sat, 09 May 2020 02:43:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 66861C433BA; Sat,  9 May 2020 02:43:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DB18C433F2;
        Sat,  9 May 2020 02:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DB18C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Sat, 9 May 2020 08:13:00 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com
Subject: Re: [PATCH 13/14] sched: cpufreq: Use IS_ENABLED() for schedutil
Message-ID: <20200509024300.GO19464@codeaurora.org>
References: <20200507181012.29791-1-qperret@google.com>
 <20200507181012.29791-14-qperret@google.com>
 <20200508053053.GG19464@codeaurora.org>
 <20200508132129.GE10541@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508132129.GE10541@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 08, 2020 at 02:21:29PM +0100, Quentin Perret wrote:
> On Friday 08 May 2020 at 11:00:53 (+0530), Pavan Kondeti wrote:
> > > -#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> > > +#if defined(CONFIG_ENERGY_MODEL) && IS_ENABLED(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> > >  	/* Build perf. domains: */
> > >  	for (i = 0; i < ndoms_new; i++) {
> > >  		for (j = 0; j < n && !sched_energy_update; j++) {
> > 
> > Now that scheduler does not have any references to schedutil_gov and cpufreq
> > has want_eas flag, do we need this CONFIG_CPU_FREQ_GOV_SCHEDUTIL checks here?
> 
> Right, they're not absolutely required, but given that sugov is the only
> one to have 'want_eas' set I guess there is no need to compile that in
> without it, no?
> 
Right.

Since you removed all compile time dependencies on schedutil, I thought the
#ifdef check around schedutil can be removed too. 

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
