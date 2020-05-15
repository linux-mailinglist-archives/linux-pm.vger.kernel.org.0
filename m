Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056101D593D
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 20:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgEOSmB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 14:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgEOSmA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 14:42:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDFCC061A0C
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 11:42:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z26so1255455pfk.12
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=lL8pAZjSlnYf0khYaqRm7TrxuhYrtZ5rDHp6ebKkdQw=;
        b=O9FP1a03UIQLoCSj2/Lwl6YnP5b5LY2D4jQmqLOJ1TAL0tzB7rxfA+2eRQhzc830jI
         isx2C6US+bE8DKB5OhiCiwXoGPeSMh7MwfkuUPQT9OPuUW6zGKdD8WkJ93rCsRu/9CVn
         5Kijes2tD5A63GywAK+m57pu6PF2XUUKwmmpr0Pt0TExON8UZx24YhsFR2C4PKca/+kJ
         1IbToAHlIevVe1PMdvdwP3u0wbuCZyc7GDXIe3Ir+A8xrCiU/+qV4OThw45NBomUXk5w
         v6OQKrR4XI3iQJRdGlcTCDms+PEgSqD2a+T+W0yy6oJNm6aEUGdtYCu/JWp8r9BlhD8p
         WTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=lL8pAZjSlnYf0khYaqRm7TrxuhYrtZ5rDHp6ebKkdQw=;
        b=t4ah4pkw3wI3UeZtv7C5DXLDAANdWEiIteTYydCbA1W1isHt7M1Je7zvopoyOuXSIE
         4ILPi/7FLJ35znRjlYzFkLA9cpoMaeyQxeEqrQPiTl5Sd7dAH0vEXY47GtauoIYFBFu8
         NNDPt2wbDcVffig+qepfcQmK8vMR7XI5+QG2fJMhZ5N/avIZv9ZBZU267g7LqXMgBuKd
         3UnnujN4LcDF9ooNX9fwTFBBcHaZSV9ANifIE3c77ilcNUPYPlf9vMbpeYwlnV2k4Yej
         CCCcoKZCk6jGMsR5+TjUV1oqryupaMVOSvSF11Nq6Cu16kCpq0jA1TVy/mxFvGg4Baqx
         GkHg==
X-Gm-Message-State: AOAM533r5tauHa0vm1HKuWWOGsUPuLEYkzinqRSRaQ3IOZl5V0vl+s6S
        uX7BO6P/MzvPfXK0oIZ+MebvhA==
X-Google-Smtp-Source: ABdhPJwhBb/E5x2JcIBki9KgjX7HwRpAgzUIrrwsMyjUWXuk5VASJR4OqrO0G9tbevUP4b1J7D+L8g==
X-Received: by 2002:a62:528e:: with SMTP id g136mr5488246pfb.165.1589568120102;
        Fri, 15 May 2020 11:42:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n16sm2537568pfq.61.2020.05.15.11.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 11:41:59 -0700 (PDT)
Message-ID: <5ebee277.1c69fb81.e88a0.7c49@mx.google.com>
Date:   Fri, 15 May 2020 11:41:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.7-rc5-57-g8ef6544598d6
X-Kernelci-Report-Type: boot
Subject: pm/testing boot: 66 boots: 2 failed,
 63 passed with 1 untried/unknown (v5.7-rc5-57-g8ef6544598d6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing boot: 66 boots: 2 failed, 63 passed with 1 untried/unknown (v5.7=
-rc5-57-g8ef6544598d6)

Full Boot Summary: https://kernelci.org/boot/all/job/pm/branch/testing/kern=
el/v5.7-rc5-57-g8ef6544598d6/
Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
7-rc5-57-g8ef6544598d6/

Tree: pm
Branch: testing
Git Describe: v5.7-rc5-57-g8ef6544598d6
Git Commit: 8ef6544598d61aab12b6b4613971bf53256b14eb
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Tested: 58 unique boards, 16 SoC families, 3 builds out of 6

Boot Regressions Detected:

arm64:

    defconfig:
        gcc-8:
          meson-gxl-s805x-p241:
              lab-baylibre: new failure (last pass: v5.7-rc5-53-gfbe093dd16=
f4)

Boot Failures Detected:

arm64:
    defconfig:
        gcc-8:
            sun50i-a64-pine64-plus: 1 failed lab

arm:
    multi_v7_defconfig:
        gcc-8:
            bcm2836-rpi-2-b: 1 failed lab

---
For more info write to <info@kernelci.org>
