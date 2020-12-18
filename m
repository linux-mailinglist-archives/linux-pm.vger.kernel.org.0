Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A602DDEF6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Dec 2020 08:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbgLRHRF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Dec 2020 02:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732927AbgLRHRF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Dec 2020 02:17:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2F7C06138C
        for <linux-pm@vger.kernel.org>; Thu, 17 Dec 2020 23:16:25 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v1so824092pjr.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Dec 2020 23:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ApqerofOaEIKVsWbd43tuQ+Rw2I8tWIcPWDX1I3W53A=;
        b=UAJIKEGSbpSZkC/GgKXecPne8+PC5lwlixKKGZVu5LyQCxsHV+IMqv5fqFLMjh9vAg
         OZTlDJoBuLvNqL6EZl2KHKhRN9BNqv92+iIoeedZJAdajhD5a24yUq9sHpBIgTK1ObNI
         r8z3OwDRSTTJPg9BDvdOHnmx4czylI12E7QJjLtEd96+J7s/8MShT2syR1V4InehVVuM
         zjPbea09Ef3w73FaW6HVRWPbiE0nVAruH0ORj15ArLqMuBWbePOYVhk7OqEPHmvzksZ4
         4GinLVyg33Pm7dSLfhOjO3BeIIj9vrUrireY/e1HvK8B5hTYpdD4bfvWWzcqtn0dlKlb
         quFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ApqerofOaEIKVsWbd43tuQ+Rw2I8tWIcPWDX1I3W53A=;
        b=Rvkp0DkwLkb7vvW9rrkiUnuXnITa6k+A0CPRQ2cDgH4uKTNyTTRYHZOzTb6rVCnE2l
         DFbnukNrG4oICEoDhM5Fwm0qOtFJNt8mWx7sx4LoBYf54f5HVvs2BpbYJmxZh7oJl47a
         0XBwimV5OXNrzLeSBts7lK61JtTCC7h/mJU4cbsYm5zTZnhzd9xyruDZZba/o3IeUKTC
         jJ4HpZzWaOOnzS97o/XdoXj1ro/wk2XPpF5bNXEj542a6x6T9KYZiDDXf+UdrXhRgDfT
         dA7wBQ9sWiiAFsbUu4R1j4fQPFMVM2nqYk2CXjoTH0cMjE4jur6eQHfViVJ696HZIObp
         6tqw==
X-Gm-Message-State: AOAM530pVGvSxyDcRdL1kKnlbTfY9fT8XRBhvGa1yPegNyDxd2kqNbhu
        UgA0hT888w4ofd3AFXeWHvGpUA==
X-Google-Smtp-Source: ABdhPJwwkdb1HZhf5VmdNZ4g8n96cGhrXc8cKebn9Z8gCoxJuUr7hL/V8at4qPDw1zBoKcKg0fmzpQ==
X-Received: by 2002:a17:90a:9512:: with SMTP id t18mr3027950pjo.206.1608275784627;
        Thu, 17 Dec 2020 23:16:24 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id e5sm7794908pfc.76.2020.12.17.23.16.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 23:16:23 -0800 (PST)
Date:   Fri, 18 Dec 2020 12:46:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     bjorn.andersson@linaro.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, jorge.ramirez-ortiz@linaro.org,
        broonie@kernel.org, lgirdwood@gmail.com, daniel.lezcano@linaro.org,
        nks@flawful.org, agross@kernel.org, robh+dt@kernel.org,
        rjw@rjwysocki.net, konrad.dybcio@somainline.org,
        martin.botka@somainline.org, marijn.suijten@somainline.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 12/13] cpufreq: qcom-hw: Implement CPRh aware OSM
 programming
Message-ID: <20201218071621.i6bc2xgn6kthvmuw@vireshk-i7>
References: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
 <20201126184559.3052375-13-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126184559.3052375-13-angelogioacchino.delregno@somainline.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-11-20, 19:45, AngeloGioacchino Del Regno wrote:
> On new SoCs (SDM845 onwards) the Operating State Manager (OSM) is
> being programmed in the bootloader and write-protected by the
> hypervisor, leaving to the OS read-only access to some of its
> registers (in order to read the Lookup Tables and also some
> status registers) and write access to the p-state register, for
> for the OS to request a specific performance state to trigger a
> DVFS switch on the CPU through the OSM hardware.
> 
> On old SoCs though (MSM8998, SDM630/660 and variants), the
> bootloader will *not* initialize the OSM (and the CPRh, as it
> is a requirement for it) before booting the OS, making any
> request to trigger a performance state change ineffective, as
> the hardware doesn't have any Lookup Table, nor is storing any
> parameter to trigger a DVFS switch. In this case, basically all
> of the OSM registers are *not* write protected for the OS, even
> though some are - but write access is granted through SCM calls.
> 
> This commit introduces support for OSM programming, which has to
> be done on these old SoCs that were distributed (almost?) always
> with a bootloader that does not do any CPRh nor OSM init before
> booting the kernel.
> In order to program the OSM on these SoCs, it is necessary to
> fullfill a "special" requirement: the Core Power Reduction
> Hardened (CPRh) hardware block must be initialized, as the OSM
> is "talking" to it in order to perform the Voltage part of DVFS;
> here, we are calling initialization of this through Linux generic
> power domains, specifically by requesting a genpd attach from the
> qcom-cpufreq-hw driver, which will give back voltages associated
> to each CPU frequency that has been declared in the OPPs, scaled
> and interpolated with the previous one, and will also give us
> parameters for the Array Power Mux (APM) and mem-acc, in order
> for this driver to be then able to generate the Lookup Tables
> that will be finally programmed to the OSM hardware.
> 
> After writing the parameters to the OSM and enabling it, all the
> programming work will never happen anymore until a OS reboot, so
> all of the allocations and "the rest" will be disposed-of: this
> is done mainly to leave the code that was referred only to the
> new SoCs intact, as to also emphasize on the fact that the OSM
> HW is, in the end, the exact same; apart some register offsets
> that are slightly different, the entire logic is the same.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 914 +++++++++++++++++++++++++++++-
>  1 file changed, 884 insertions(+), 30 deletions(-)

This is a lot of code, I need someone from Qcom's team to review it
and make sure it doesn't break anything for the existing platforms.

-- 
viresh
