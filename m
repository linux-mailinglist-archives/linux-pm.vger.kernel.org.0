Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD38122000A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 23:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgGNV2b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 17:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgGNV2b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 17:28:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5BEC061755
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 14:28:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so964842wmh.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 14:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6fRLYpXTjUG7Lueiak9yUWNoWwRQrJnBa6oSKFtWg8E=;
        b=GBtqBw0Em7d28Clr2HE7epER9Kd1HFANvHKbk7pStrPbKPJv6RQchJwkr9FVFWlUX+
         win/zFORjiQ5ujugNAdmZMP0H15vXjLjrBGrW/w6KcapflDra/KoIMiKaI3Jjx02G2vB
         /LiCugvUwh2//YQphHlWhh89cR3jaY6BZ7uln3kaFG27Htcg8BVUS4x82mYTG9kVA8Cn
         Kzd2L5c8NDoK5rrxTeKYlz9xG0tuD2xvjdqZrBXOpsQQzxCYa1qz2AoTjZzKpRvCd2n1
         B376DmakjeuKX9RPB414AV3RnDBp5hVV0Cy9+QeAw+deO+ZpylBpW3EdeStV6TiSztZJ
         QlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6fRLYpXTjUG7Lueiak9yUWNoWwRQrJnBa6oSKFtWg8E=;
        b=LSIfMurDju3NZV6h+MXfjX8VAcPYuYCU/Jx7zsk0PUL614fcnrlqayGLA2aawHaCWu
         86O7t8orXSQrxgj8CZrQF8LwEQzC8MQr4TCM7cgjQRSoLRw+ZVVHfbRNDZ5v7lqB7blx
         1xoMsItW4Iu5ow0w7SPaQDPCeT9lvFzm+4gpARKd3PY+kaKysv11FjOy0dt2uHfwStpl
         fgBaYBb+omisGE0tBWQfZbEhITDR6oIgt+ftcF2v2LvCUPLsLmvyYS22zMwAbS2vbR4v
         ieGKvmB8F0PsCEyE/vGxPhTPamBrPW5AVsVMdrz/X2tZhElqagWqVW7MBSATLda6jQuG
         qtxw==
X-Gm-Message-State: AOAM5313M5FwWETtEo7IRo7iQ5Rrm09J3aJRPmHoSYLbfZSbZ/+Zn4sv
        vvOK1GE8LlDklz2sJPDVDoYvn0GZ6ax/qg==
X-Google-Smtp-Source: ABdhPJzUpRcDwEsXYmLPaS6DkjCLEof0ShwsP8rsPx4113jnMsq2sgj3x5w2ZeBVI/fQ+uxbtv+gHA==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr5506692wmh.134.1594760588532;
        Tue, 14 Jul 2020 14:03:08 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm6040573wmh.47.2020.07.14.14.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:03:08 -0700 (PDT)
Date:   Tue, 14 Jul 2020 22:03:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Dirk Brandewie <dirk.j.brandewie@intel.com>
Subject: Re: [PATCH 12/13] cpufreq: intel_pstate: Supply struct attribute
 description for get_aperf_mperf_shift()
Message-ID: <20200714210306.GI1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-13-lee.jones@linaro.org>
 <CAJZ5v0jkDWD6Ea2_oEDtFfPDWh5ByphUqEa=3jE2ZbnW0DVEcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jkDWD6Ea2_oEDtFfPDWh5ByphUqEa=3jE2ZbnW0DVEcQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:

> On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/cpufreq/intel_pstate.c:293: warning: Function parameter or member 'get_aperf_mperf_shift' not described in 'pstate_funcs'
> >
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index 44c7b4677675d..f92fc69c87269 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -275,6 +275,8 @@ static struct cpudata **all_cpu_data;
> >   * @get_min:           Callback to get minimum P state
> >   * @get_turbo:         Callback to get turbo P state
> >   * @get_scaling:       Callback to get frequency scaling factor
> > + * @get_aperf_mperf_shift: Callback to get the number of clock cycles after
> > + *                     aperf, merf is incremented
> 
> This added description is inaccurate.  It should be something like
> "Callback to get the APERF vs MPERF frequency difference".

Does that mean the description of @aperf_mperf_shift above is also
incorrect?

> >   * @get_val:           Callback to convert P state to actual MSR write value
> >   * @get_vid:           Callback to get VID data for Atom platforms
> >   *
> > --

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
