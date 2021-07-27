Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058B83D7C6F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhG0Rnz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 13:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhG0Rny (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 13:43:54 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F03C0613CF
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 10:43:54 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t128so261596oig.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=r4QUHu4frIdHijvzTmPRFAGSy3R7tZiWw1IQcm22Anc=;
        b=UMnNJV3G+NYhLLNbxE9PaEg/eL5MyESXCP2BC+EwC7YNfafABXfSQbVyKbgThddrPf
         6NDDAsh/KdxobbVf1b3einnCMzyWjSr5djb5JSO9dzZsFr1oEByvNwWTKmrPvPHccyNG
         dk+tp5An4sLTyN6+XkmQFOsLX3P+MmSS/fTS/r96B20qKm3DuuJk3Fz6VRvhahVEMjvL
         u2eTLggdkveT8dvZq8ytAJKEsrKCaogzuuRDaK9YnQa3n3QGxcsyZNkr0Sk5JGwGzkzE
         /vJ801AxYYCbfNfPkvEzRxX/1acXXjS/S99s3z3MH2RdYTgenG7UpUS7XCzYa83GITIK
         T0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=r4QUHu4frIdHijvzTmPRFAGSy3R7tZiWw1IQcm22Anc=;
        b=W9NEChQGb7eor6XqMrEiKJksy9jvwgjVTBFoVqTRStPn43M0IJeV+0Gp6bMk6Ncdli
         s2IsZbPDmz8SQ9TwBp12cNKGg2fZafmU67/xuerDvMOEHsqgx6NIt6ulPszcVjoVzIqk
         xCJjfDavDaUOdmmzzEEsYSSs7qooj4A6tUUpsg4V/fGe9T0MhkYq12Zh57PnXEGhasr+
         dgNOCG/V6ejPT6ZZZoLyLki7RKfnTtMZmX2tdjxp9fRR8wwRMzY2ulkKq47QbD/3OLoH
         bEJ95u1TiklBnM7zAZrBsiFBB6LhFk543acbsAtFdHyLiVyff5BGRrCqkDtziT4n/hG5
         fECQ==
X-Gm-Message-State: AOAM531SOiTNhOHq6jiGpmMSDy3g1p5k3yj8B/dGLJiJN7HYLeFkCcK9
        rIyX9hJSnIL12w/E++QVIoWsBQ==
X-Google-Smtp-Source: ABdhPJzlJJJxB3rHg+lqAM2nOyBdKpN2vY1CxhcgGGstQXNBb0+yec80VRFGc9CQedbE3ObLC7ytkg==
X-Received: by 2002:aca:31d8:: with SMTP id x207mr3738097oix.144.1627407832573;
        Tue, 27 Jul 2021 10:43:52 -0700 (PDT)
Received: from MacBook-Pro.hackershack.net (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id n21sm599926ooj.22.2021.07.27.10.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 10:43:51 -0700 (PDT)
Subject: Re: [Patch v3 0/6] Introduce LMh driver for Qualcomm SoCs
To:     Thara Gopinath <thara.gopinath@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <c630a7a0-d1d0-d04c-8abf-2490c0932661@kali.org>
 <adfe4d6d-7433-23f2-bc57-d6fba2d8725b@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <ff6fc8d4-38e9-86ea-f689-609668c53196@kali.org>
Date:   Tue, 27 Jul 2021 12:43:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <adfe4d6d-7433-23f2-bc57-d6fba2d8725b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/27/21 10:29 AM, Thara Gopinath wrote:
>
>
> On 7/21/21 11:14 PM, Steev Klimaszewski wrote:
>> Hi Thara!
>>
>> On 7/8/21 7:06 AM, Thara Gopinath wrote:
>>> Limits Management Hardware(LMh) is a hardware infrastructure on some
>>> Qualcomm SoCs that can enforce temperature and current limits as
>>> programmed
>>> by software for certain IPs like CPU. On many newer SoCs LMh is
>>> configured
>>> by firmware/TZ and no programming is needed from the kernel side.
>>> But on
>>> certain SoCs like sdm845 the firmware does not do a complete
>>> programming of
>>> the h/w block. On such SoCs kernel software has to explicitly set up
>>> the
>>> temperature limits and turn on various monitoring and enforcing
>>> algorithms
>>> on the hardware.
>>>
>>> Introduce support for enabling and programming various limit
>>> settings and
>>> monitoring capabilities of Limits Management Hardware(LMh)
>>> associated with
>>> cpu clusters. Also introduce support in cpufreq hardware driver to
>>> monitor
>>> the interrupt associated with cpu frequency throttling so that this
>>> information can be conveyed to the schdeuler via thermal pressure
>>> interface.
>>>
>>> With this patch series following cpu performance improvement(30-70%) is
>>> observed on sdm845. The reasoning here is that without LMh being
>>> programmed
>>> properly from the kernel, the default settings were enabling thermal
>>> mitigation for CPUs at too low a temperature (around 70-75 degree
>>> C).  This
>>> in turn meant that many a time CPUs were never actually allowed to
>>> hit the
>>> maximum possible/required frequencies.
>>>
>>> UnixBench whets and dhry (./Run whets dhry)
>>> System Benchmarks Index Score
>>>
>>>                  Without LMh Support             With LMh Support
>>> 1 copy test     1353.7                          1773.2
>>>
>>> 8 copy tests    4473.6                          7402.3
>>>
>>> Sysbench cpu
>>> sysbench cpu --threads=8 --time=60 --cpu-max-prime=100000 run
>>>
>>>                  Without LMh Support             With LMh Support
>>> Events per
>>> second                  355                             614
>>>
>>> Avg Latency(ms)         21.84                           13.02
>>>
>>> v2->v3:
>>>     - Included patch adding dt binding documentation for LMh nodes.
>>>     - Rebased to v5.13
>>>
>>> Thara Gopinath (6):
>>>    firmware: qcom_scm: Introduce SCM calls to access LMh
>>>    thermal: qcom: Add support for LMh driver
>>>    cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support
>>>    arm64: boot: dts: qcom: sdm45: Add support for LMh node
>>>    arm64: boot: dts: qcom: sdm845: Remove cpufreq cooling devices
>>> for CPU
>>>      thermal zones
>>>    dt-bindings: thermal: Add dt binding for QCOM LMh
>>>
>>>   .../devicetree/bindings/thermal/qcom-lmh.yaml | 100 ++++++++
>>>   arch/arm64/boot/dts/qcom/sdm845.dtsi          | 162 ++----------
>>>   drivers/cpufreq/qcom-cpufreq-hw.c             | 118 +++++++++
>>>   drivers/firmware/qcom_scm.c                   |  58 +++++
>>>   drivers/firmware/qcom_scm.h                   |   4 +
>>>   drivers/thermal/qcom/Kconfig                  |  10 +
>>>   drivers/thermal/qcom/Makefile                 |   1 +
>>>   drivers/thermal/qcom/lmh.c                    | 239
>>> ++++++++++++++++++
>>>   include/linux/qcom_scm.h                      |  14 +
>>>   9 files changed, 570 insertions(+), 136 deletions(-)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
>>>   create mode 100644 drivers/thermal/qcom/lmh.c
>>>
>> I've been using these patches on a 5.13 kernel
>> (https://github.com/steev/linux/tree/linux-5.13.y - while trying to
>> track down a different issue, while playing a video on youtube, as well
>> as compressing a 9.2GB file with xz, I got the following
>
> Hi Steev,
>
> Thanks for testing this. I was unable to reproduce this. I have posted
> v4 moving the interrupt handling in qcom-cpufreq-hw to threaded
> interrupt handler and hopefully this should fix the issue. It will be
> great if you can test and let me know.
>
Hi Thara,

I've been testing v4 for a little bit here, and so far I can't seem to
get it to reproduce anymore.  I will keep trying but fingers crossed
that that did the trick.

For setup, I'm using https://github.com/steev/linux/tree/linux-5.13.y
with the "distro_defconfig" configuration here on my c630s.  I'm also
running https://github.com/steev/scheduler as a systemd service.  So far
I've been able to sleep/suspend without issue while running "make
-j$(nproc) deb-pkg" in those kernel sources as well as `xz
--memlimit-compress=50 -T 4 imagefile.img" on a 9.2GB file at the same
time.  One system is running the Budgie desktop on top of Xorg, and the
other is running Gnome 3.38 on top of Wayland.

-- steev

