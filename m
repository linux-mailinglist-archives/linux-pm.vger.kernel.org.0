Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0652425FA2
	for <lists+linux-pm@lfdr.de>; Fri,  8 Oct 2021 00:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbhJGWEz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 18:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbhJGWEy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 18:04:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05EEC061570
        for <linux-pm@vger.kernel.org>; Thu,  7 Oct 2021 15:03:00 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k23-20020a17090a591700b001976d2db364so6292586pji.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Oct 2021 15:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=1BkA73GmGx4Jb43i0VGm2FvwNRrT6siyBt5gKlC8ubs=;
        b=jVg7TyYvEK0OoAI2OwMnrWmqRr/sVnFF2ugLb/mcwRFr+o9IN/45hb7IUJogdV4SSh
         mOA3sICCl52K5YnLQeZ9u8Bj4T+vYYV5H7MoTPKciiNJefKbCEvLhILhcMd0BgaCxSAu
         yZQSVRdD79Df155E/7htF4ihXDDj+mjN0uMjUNoXWqRBm95pCqdjtc6I31piviObOlDR
         bNeZJW9cc4K5HtlL+vfn9xtY2ZCzwv92ZA8AUCqtHgtnTmE8+jJHv5IHC0xhKmmOePS/
         hNSRYNE96dyientttRCyVC3fyMmZi3woTS0WO8705tT0JkLjG5Zeo89InHgTP6isU9x9
         6mTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=1BkA73GmGx4Jb43i0VGm2FvwNRrT6siyBt5gKlC8ubs=;
        b=Zr4XzsaffPmBdlo3Ew6qU1ls+6ts1Vvy+/RN2TOmov6w04HV2CLjPd2UfwfDJyO7MV
         JsuVsJy8wO6Q88ouQZkl5BgjClYNtVufPR4Vj/e/j2y8ByBuNVJ/HIVnXJQHqIKeBuxz
         4PU4D2La9Awk+XL0g1V3ybMbATE+fO509e+koOmYAtqMhXVNzpqUnMZgrcw5do4cY+b6
         meMiL3IasMZTxPdq1E53Dz2iy67sQrF4o0b7/t/wZgx2Ht5LoOx2iB+Y8zmI+gr0CSBf
         uIP7rprPFBF23Hv9cFFcZbWkto538mL6eN61ViGFT0k54+xEq/9PjYgVWLf2jkh7o0BV
         nKIA==
X-Gm-Message-State: AOAM533O59hFPUGXzwUJWgBwZts4ZzNhlV2+gvzdmKlik4wGyxDtrKwV
        1eCGuVXzgI65OQyN89yT14XqmQ==
X-Google-Smtp-Source: ABdhPJyPUGVE6Q2G8G7N1ujBdcDZrfkr8dboFwHpHqW9R5SvVGIZybzO7WZRUiVYZZFsjIMY92Y58g==
X-Received: by 2002:a17:902:db04:b0:13e:f118:54de with SMTP id m4-20020a170902db0400b0013ef11854demr6215738plx.44.1633644179181;
        Thu, 07 Oct 2021 15:02:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lp9sm230982pjb.35.2021.10.07.15.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 15:02:58 -0700 (PDT)
Message-ID: <615f6e92.1c69fb81.eeab4.115e@mx.google.com>
Date:   Thu, 07 Oct 2021 15:02:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc4-42-g574167bf7ed8
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 67 runs,
 1 regressions (v5.15-rc4-42-g574167bf7ed8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 67 runs, 1 regressions (v5.15-rc4-42-g574167bf7ed8)

Regressions Summary
-------------------

platform  | arch | lab          | compiler | defconfig          | regressio=
ns
----------+------+--------------+----------+--------------------+----------=
--
beagle-xm | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig | 1        =
  =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.15-rc=
4-42-g574167bf7ed8/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.15-rc4-42-g574167bf7ed8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      574167bf7ed8e12be9710fc84442c5e23775f75d =



Test Regressions
---------------- =



platform  | arch | lab          | compiler | defconfig          | regressio=
ns
----------+------+--------------+----------+--------------------+----------=
--
beagle-xm | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig | 1        =
  =


  Details:     https://kernelci.org/test/plan/id/615f640b20e512f09099a2da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.15-rc4-42-g57416=
7bf7ed8/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.15-rc4-42-g57416=
7bf7ed8/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-beagle-xm.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/615f640b20e512f09099a=
2db
        new failure (last pass: v5.15-rc4-24-g8e0efc215fb1) =

 =20
