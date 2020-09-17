Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5376126D1B7
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 05:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIQD2C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 23:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgIQD2B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 23:28:01 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA69C061756
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 20:22:28 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w186so888694qkd.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 20:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KcbOfWlEFuul00HQqd8oilYbvxROka4ZC4SJrI4joOI=;
        b=ZoAZr1W5Oy5cf66eKQDQmN5f8ior/qPaBYuhUSTkzttNy0/O9TEdGWW4csN2pa49hh
         id6Fmyh9QZCKAH0LJv0YPxZGf8vB/Itcyb+O/nYPdnbtGUhdBnRYcDkntbur9LKRXaQc
         wj53IAzDyNAzQFKT2B9CkUV0rX5xEsCfMERavdq1QiHUHPoIZu5B+99HQgYDEnTp1Ykh
         7zKTNEG9VaH025rt4wOluXioXoDuWzGUh4DNamII+pIl2TcaS9XZyfQhFEsqaPIN/9aA
         CqwwYu7Z6KiZaYLWHss70WCO1qEl1UGGACL5OWYmfdGeRSCEWjQoTbfbs1s3MM3DSVuC
         z4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KcbOfWlEFuul00HQqd8oilYbvxROka4ZC4SJrI4joOI=;
        b=h4GHpdpHd+RZ6gvrikpoKL4/DwhoMMzZcKByoOLbxlQR5jAwFUOFpENiMwdTl5ZcL7
         zkwWddObYevCNalmqiyMi5kkRCS83AKRalAaGEFa2Gg/B2nW1MY/ZE9OLYafH0FS8vz4
         4SIOaYP+yW+jLyp0jvmb+SI81P55jHPFWEEyUyoato+dd4q7qXdppO5Tpf0fFfv5EZUR
         YidKoSvevCaM1bzGzijSPBL0Pip22gqzhxjz6+abE0Qalay5Q15OmmEFV5RuLeYeqr5s
         qITaNpPgN6kC/qKlcNFg4MiNzeAEcdrdaK0jbRWMndOHRGGDlLZERTIWSm7rgK4X1tY1
         lhsQ==
X-Gm-Message-State: AOAM531ve+zfm5/eBYcTVh101jVPghrFlzUbU4tdLyeAYUbtj/7fXATn
        4M9+fjvZZgNwuuc79Zl9C7dSoA==
X-Google-Smtp-Source: ABdhPJycdE9iUoUS8L8EAQ9dflosqsZ4aHX4wg/fxy61biNVVViV9GA9A6GsEun9aHQ6DekgpsepBg==
X-Received: by 2002:a05:620a:2082:: with SMTP id e2mr25150130qka.421.1600312947892;
        Wed, 16 Sep 2020 20:22:27 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id g45sm21370801qtb.60.2020.09.16.20.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 20:22:27 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lukasz.luba@arm.com, amitk@kernel.org
Subject: [PATCH RFC 0/8] Introduce warming in thermal framework
Date:   Wed, 16 Sep 2020 23:22:18 -0400
Message-Id: <20200917032226.820371-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thermal framework today supports monitoring for rising temperatures and
subsequently initiating cooling action in case of a thermal trip point
being crossed. There are scenarios where a SoC need warming mitigating
action to be activated if the temperature falls below a cetain permissible
limit.  Since warming action can be considered mirror opposite of cooling
action, most of the thermal framework can be re-used to achieve this. The
key assumption in this patch series is that a device can act either as a
warming device or a cooling device and not as both.

In order to support warming three extensions are needed in the thermal
framework.

1. Indication that a trip point is being monitored for falling temperature
and not rising temperature. We discussed two different ways to achieve this
during LPC. First option is to introduce a new trip type to indicate that a
trip is a cold trip(THERMAL_TRIP_COLD). The second option is to introduce a
new property for trip point that will indicate whether a trip point is
being monitored for rising temperature or falling temperature. The patch
series(patches 1-4) chooses the second approach since it allows trip points
of any type to be monitored for rising or falling temperature.Also this was
the preferred approach when discussed during LPC. The approach that
introduces a new cold trip type was posted on the list earlier as a RFC and
can be found at [1].

2. Extend the exisitng governors to handle monitoring of falling
temperature. The patch series(patches 5 & 6) extends the step wise governor
to monitor the falling temperature.Other governors return doing nothing if
the trip point they are being called for is being monitored for falling
temperature. The governors' mitigate function is called "throttle" in the
thermal framework and with this patch series it is a misnomer as the
function is called for both throttling and warming up. Ideally
"throttle" should be renamed to "mitigate" to improve readability of code.
The renaming is not part of this series.

3. Finally, the cooling device framework itself can be reused for a warming
device. As stated before a device can act either as a warming device or a
cooling device and not as both.  With this the cooling state in the
framework can be considered as mitigating state with 0 as the state with no
thermal mitigation and higher the number higher the thermal mitigation.
Again what affects the code readability and comprehension is the term
"cooling" which is a misnomer here. Ideally the term "cooling" should be
renamed to "mitigating" and hence thermal_cooling_device will become
thermal_mitgating_device. The renaming is not part of the patch series as
even though the renaming is a simple search-replace, it will change a lot
of files.  The patch series(patches 7 & 8) instead introduces a minimal set
of _warming_device_ apis to register and unregister warming devices which
internally is identical to the _cooling_device_ counterpart.

1. https://lkml.org/lkml/2020/7/10/639

Thara Gopinath (8):
  dt-bindings: thermal: Introduce monitor-falling parameter to thermal
    trip point binding
  thermal: Introduce new property monitor_type for trip point.
  thermal: thermal_of: Extend thermal dt driver to support
    bi-directional monitoring of a thermal trip point.
  thermal:core:Add genetlink notifications for monitoring falling
    temperature
  thermal: gov_step_wise: Extend thermal step-wise governor to monitor
    falling temperature.
  thermal: Modify thermal governors to do nothing for trip points being
    monitored for falling temperature
  thermal:core: Add is_warming_dev and supporting warming device api's
    to the cooling dev framework.
  soc:qcom:qcom_aoss: Change cooling_device_register to
    warming_device_register

 .../bindings/thermal/thermal-zones.yaml       |   7 ++
 drivers/soc/qcom/qcom_aoss.c                  |   6 +-
 drivers/thermal/gov_bang_bang.c               |  12 ++
 drivers/thermal/gov_fair_share.c              |  12 ++
 drivers/thermal/gov_power_allocator.c         |  12 ++
 drivers/thermal/gov_step_wise.c               |  62 +++++++---
 drivers/thermal/thermal_core.c                | 113 +++++++++++++++---
 drivers/thermal/thermal_core.h                |   2 +
 drivers/thermal/thermal_of.c                  |  22 ++++
 include/linux/thermal.h                       |   9 ++
 include/uapi/linux/thermal.h                  |   5 +
 11 files changed, 226 insertions(+), 36 deletions(-)

-- 
2.25.1

