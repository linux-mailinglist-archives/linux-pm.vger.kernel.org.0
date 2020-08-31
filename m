Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AC9257848
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 13:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgHaLZb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 07:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgHaLX1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 07:23:27 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C1C0619CF
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 04:14:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t11so2872059plr.5
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2020 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nzvu9JSHr7RK/LFEk+l7520aORfzy7sOwYYyoim9rCI=;
        b=r5H/s/s7DpXIflWMEZE0METpZNKTTtMqR482C8ot3WSiqkfTqGf12SQ1Fmb11YWCNN
         Hb+z7P+aWkkrBMme+lps94SiFkupZib9Y1PKOWSChOSPbWegOm1Npn65lZyxxgpUP5ll
         DU9i3gIFliaBeoCxCpHzl8rM5qotA4dX2erVDpK7lWkcezAb6o0GK31t4Gp9+gH8kMrI
         k0qoVFUcFInyQ1cjuiaw/Ipekr2njnpgXkW+qzPMN5ibsmOMRJZ+X6ltcpoFRiMvfnQa
         zcfRiayeD2WP8pQ5mTGaDjJGqNRKpym0PbTJ7S8E6RyVVwVKO2bNIGd45NCSSDIltL3N
         x5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nzvu9JSHr7RK/LFEk+l7520aORfzy7sOwYYyoim9rCI=;
        b=JTshjapkeGE2UGSp3JOspMqS/ZRxZBXqXpWM1DTb1lcWdECNdY0YVowTm/7xu529IA
         p3SBC3Pn2qfN3+ge+l9DJhVeqeJWsBv82k8Oil7m1OBq/MYwPehiHwY7mB7AVg/vihkc
         3XRaHeeMy/YVeIAsNoU/xdcUM83cSPBJrj4GawGvsW3Pr3O5bokkb/HXPQ74Wcf4jsPB
         chJKapgR2KO3JShhFcDpMX8MBcKXhvKxnS+NHOD4dvqyo6ei4nA/NmkaT9n0Q0CVaFEK
         24tx5XAafGa0bcpLVsn/89Xyav6FH56VFouF77Z3mpZuvmQ3D5AuC4/rkV1H/J/8sztC
         1eng==
X-Gm-Message-State: AOAM531SoBNfQS7XRVtppdAdado8RfUXF18X8iVfAgqJYI7gQgadLSLl
        HzILZT7vcNyTxGs+ntK14FWvUuTlbdbbRw==
X-Google-Smtp-Source: ABdhPJyDeeogBk0lluDOhsC09yle3T1/VPEb4FU+vPpigkNdXZMXQ6VkP/LotNnjrlzNiG8DXywloA==
X-Received: by 2002:a17:90a:5609:: with SMTP id r9mr939358pjf.194.1598872450748;
        Mon, 31 Aug 2020 04:14:10 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id e13sm3819332pfl.44.2020.08.31.04.14.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 04:14:09 -0700 (PDT)
Date:   Mon, 31 Aug 2020 16:44:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] cpufreq: report whether cpufreq supports
 Frequency Invariance (FI)
Message-ID: <20200831111408.a2q22cqaxjkbmw6v@vireshk-i7>
References: <20200828173303.11939-1-ionela.voinescu@arm.com>
 <20200828173303.11939-4-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828173303.11939-4-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-08-20, 18:33, Ionela Voinescu wrote:
> Now that the update of the FI scale factor is done in cpufreq core for
> selected functions - target(), target_index() and fast_switch(),
> we can provide feedback to the task scheduler and architecture code
> on whether cpufreq supports FI.
> 
> For this purpose provide an external function to expose whether the
> cpufreq drivers support FI, by using a static key.
> 
> The logic behind the enablement of cpufreq-based invariance is as
> follows:
>  - cpufreq-based invariance is disabled by default
>  - cpufreq-based invariance is enabled if any of the callbacks
>    above is implemented while the unsupported setpolicy() is not
> 
> The cpufreq_supports_freq_invariance() function only returns whether
> cpufreq is instrumented with the arch_set_freq_scale() calls that
> result in support for frequency invariance. Due to the lack of knowledge
> on whether the implementation of arch_set_freq_scale() actually results
> in the setting of a scale factor based on cpufreq information, it is up
> to the architecture code to ensure the setting and provision of the
> scale factor to the scheduler.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 16 ++++++++++++++++
>  include/linux/cpufreq.h   |  5 +++++
>  2 files changed, 21 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
