Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F473D7C77
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 19:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhG0Ro1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 13:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhG0Ro1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 13:44:27 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB1DC061757
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 10:44:25 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id a5-20020a05683012c5b029036edcf8f9a6so14317736otq.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Y/+MCbnZk05ggDpvY1i7Lbdsr/ovIErfJLvCgHutWNQ=;
        b=OPtNfnB1pT+J68uFQFd/MI8NZL4n2Ypi8nsTYbcp+S6RjHDOJueaIakgvcr2ftC3w/
         S6HL7uljSVeLCNeEHSZEmP51yu860qhP2kYgfnQeusk+uVvvrHpzxcRDKhQ8W5MzUCH0
         XRCwyQkczJ1tTpC/d0rY06+61RQxO+z85xLf537+P4KDPRvfJBxPH07JoAOY17tjK68w
         SdCfBMYFbm8QyEoyMXnzaa9f1TR5ZuF4mKdt1qMxiuFAnimPbT8SOmmXzJRsHIvQkwye
         DkldLk4IzYPMibqotPiVnm2YKxqL5i+iwDSGWUfgmoqLl/67lGYfhUHGxfu4Qinrulj0
         J+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y/+MCbnZk05ggDpvY1i7Lbdsr/ovIErfJLvCgHutWNQ=;
        b=gbH1ddGQM4zRy9AyPwVO8xGyXsyPue47dP1bme/7AdKUycssBc4GuJLZmmmke8so5p
         xsKx7W/3LlyzGX3zcPHIWZymWVWZYKSUHpQI0oOqObvnCOQwD8AsAtoQTfAs4HSi2UOw
         BkGBLhNZsW3OFLNYZrHinsfS0HogwYT+3ADzsyomi5qeLTWDOOdeeFnQBm5dM1Nskms0
         n20AFXG4knjvxkR2HgaDEXoSY9wluixsBFq/QdLWqunP3Bcwc5Ko27DyiQJrOgelCfmA
         zD2NEeS33Yeo3uLJjU+XPgl82JLTSvrPL80GkTkEcULXGYZbnvNYDcwK8qDEH5K6iTGP
         IORw==
X-Gm-Message-State: AOAM531+0E7GKPPqJoZt8YFsPjCwDkZ8WJjLRzS43VA0SEEaCNNhgykr
        0zbI3eReClpKJeFl64+LWloVdg==
X-Google-Smtp-Source: ABdhPJwZDS4EDCal0AqhM7KeCVq39vcBPLwoNHsOlg3W85cbce6PTyY8OCAMPx0+yOxIMSmLgVdeHQ==
X-Received: by 2002:a9d:174:: with SMTP id 107mr16146775otu.179.1627407862384;
        Tue, 27 Jul 2021 10:44:22 -0700 (PDT)
Received: from MacBook-Pro.hackershack.net (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id o101sm629128ota.61.2021.07.27.10.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 10:44:22 -0700 (PDT)
Subject: Re: [Patch v4 0/6] Introduce LMh driver for Qualcomm SoCs
To:     Thara Gopinath <thara.gopinath@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210727152512.1098329-1-thara.gopinath@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <8ec8b5ff-3625-ad9b-d438-4bc37beb09e5@kali.org>
Date:   Tue, 27 Jul 2021 12:44:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210727152512.1098329-1-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/27/21 10:25 AM, Thara Gopinath wrote:
> Limits Management Hardware(LMh) is a hardware infrastructure on some
> Qualcomm SoCs that can enforce temperature and current limits as programmed
> by software for certain IPs like CPU. On many newer SoCs LMh is configured
> by firmware/TZ and no programming is needed from the kernel side. But on
> certain SoCs like sdm845 the firmware does not do a complete programming of
> the h/w block. On such SoCs kernel software has to explicitly set up the
> temperature limits and turn on various monitoring and enforcing algorithms
> on the hardware.
>
> Introduce support for enabling and programming various limit settings and
> monitoring capabilities of Limits Management Hardware(LMh) associated with
> cpu clusters. Also introduce support in cpufreq hardware driver to monitor
> the interrupt associated with cpu frequency throttling so that this
> information can be conveyed to the schdeuler via thermal pressure
> interface.
>
> With this patch series following cpu performance improvement(30-70%) is
> observed on sdm845. The reasoning here is that without LMh being programmed
> properly from the kernel, the default settings were enabling thermal
> mitigation for CPUs at too low a temperature (around 70-75 degree C).  This
> in turn meant that many a time CPUs were never actually allowed to hit the
> maximum possible/required frequencies.
>
> UnixBench whets and dhry (./Run whets dhry)
> System Benchmarks Index Score
>
>                 Without LMh Support             With LMh Support
> 1 copy test     1353.7                          1773.2
>
> 8 copy tests    4473.6                          7402.3
>
> Sysbench cpu
> sysbench cpu --threads=8 --time=60 --cpu-max-prime=100000 run
>
>                 Without LMh Support             With LMh Support
> Events per
> second                  355                             614
>
> Avg Latency(ms)         21.84                           13.02
>
> v3->v4:
> 	- Rebased to v5.14-rc2.
>
> v2->v3:
>         - Included patch adding dt binding documentation for LMh nodes.
>         - Rebased to v5.13
>
> Thara Gopinath (6):
>   firmware: qcom_scm: Introduce SCM calls to access LMh
>   thermal: qcom: Add support for LMh driver
>   cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
>   arm64: dts: qcom: sdm45: Add support for LMh node
>   arm64: dts: qcom: sdm845: Remove cpufreq cooling devices for CPU
>     thermal zones
>   dt-bindings: thermal: Add dt binding for QCOM LMh
>
>  .../devicetree/bindings/thermal/qcom-lmh.yaml | 100 ++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 162 ++----------
>  drivers/cpufreq/qcom-cpufreq-hw.c             | 142 +++++++++++
>  drivers/firmware/qcom_scm.c                   |  58 +++++
>  drivers/firmware/qcom_scm.h                   |   4 +
>  drivers/thermal/qcom/Kconfig                  |  10 +
>  drivers/thermal/qcom/Makefile                 |   1 +
>  drivers/thermal/qcom/lmh.c                    | 232 ++++++++++++++++++
>  include/linux/qcom_scm.h                      |  14 ++
>  9 files changed, 587 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
>  create mode 100644 drivers/thermal/qcom/lmh.c
>
Tested-by: Steev Klimaszewski <steev@kali.org>
