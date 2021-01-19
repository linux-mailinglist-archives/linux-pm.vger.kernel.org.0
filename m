Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4972FBBF6
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 17:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389138AbhASQHb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 11:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391224AbhASQD4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 11:03:56 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CADAC061573
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 08:03:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id g15so158300pjd.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 08:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=yq46fU2UhqS8M9Zthah4LUZ0vX50wKV+7yazyHD9svE=;
        b=jPBHWhROQhfq7p+X9RRpS85+ysvGnpMnCihtAMQ2qf9d9Wzi6ir6tagJfjM2n36wUF
         6wa8rkGfSoEfLtxJpW83RZXJMFxBtH+VxSsIBcTx8Q6AZqvZVb3hrvY+wshijRpnWAZx
         vBhV7L/5uZdYJqn/+p+ZpVJ1PRs8ZlJjbjW+u2tJw6qX/45G+yB5m+DeLABBcuEy14v8
         +iubq2xaERhiaGWqZXfMMiB8Rloj9kUqxfdu/2B256xo4Z7C0eqJZRJhZdipe9PLjLgR
         qQ5eRrAvz/RmqpI9mivc2tbKX79+nrOFl7PVguN86tWP1OESymWxOoP9AloEGqvbJjTR
         ArkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=yq46fU2UhqS8M9Zthah4LUZ0vX50wKV+7yazyHD9svE=;
        b=fdcnZdpwVkWqB5JN+hM8uelT0x2ehZp/Y3D2fcKTtjxUx1B8rk4g1tEiB5UpMaQEDS
         GYn3gqyRzK5CfAudE00/Rsxoohkn8Kq8o8gtU7qXM1gx9uHiMHt7CDtvNZh9gghJa5HR
         qQFpMlsnctckHQ8kLq/+Kv/9HEYR6RlWvONWYQbUp9X5U2mAag5jCNF6OiVIkFcSNk3k
         TZCRlkVmukOuhxwHkXpiAbijt+XkI3t6yewXy5U9i6dA+OiSgPukcR3soyzfFxVHyoxa
         Uj3tk/+JAFYeSZXDS8fwu44o7JU93JXMwxjgLZFbclMR2bAmY/JNucYHF9edFn47XjQi
         Smjw==
X-Gm-Message-State: AOAM530QYeJhfdGy1PxroAlLvTws7hpXux0NrIeV95HxXWT2T0QRPElm
        raNM8qA1uxczTdZAssK2GfvT6Q==
X-Google-Smtp-Source: ABdhPJwIHbAwz43j8CiUN6CPz1D70j9N4FAEqnVg6ROq1rrk7yaI/M3WSe9wsWh0+wcLqc2xfPOcgA==
X-Received: by 2002:a17:90b:3507:: with SMTP id ls7mr374483pjb.208.1611072179744;
        Tue, 19 Jan 2021 08:02:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 11sm18945070pgz.22.2021.01.19.08.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:02:59 -0800 (PST)
Message-ID: <600702b3.1c69fb81.112c1.db08@mx.google.com>
Date:   Tue, 19 Jan 2021 08:02:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.11-rc4-16-g192963bcaa64
Subject: pm/testing sleep: 2 runs, 2 regressions (v5.11-rc4-16-g192963bcaa64)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 2 runs, 2 regressions (v5.11-rc4-16-g192963bcaa64)

Regressions Summary
-------------------

platform            | arch | lab           | compiler | defconfig          =
| regressions
--------------------+------+---------------+----------+--------------------=
+------------
rk3288-rock2-square | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
| 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-rc=
4-16-g192963bcaa64/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.11-rc4-16-g192963bcaa64
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      192963bcaa64826582bed29644e2a54b81c0fb9a =



Test Regressions
---------------- =



platform            | arch | lab           | compiler | defconfig          =
| regressions
--------------------+------+---------------+----------+--------------------=
+------------
rk3288-rock2-square | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
| 2          =


  Details:     https://kernelci.org/test/plan/id/6006f615015073c434bb5d17

  Results:     2 PASS, 12 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-rc4-16-g19296=
3bcaa64/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squar=
e.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-rc4-16-g19296=
3bcaa64/arm/multi_v7_defconfig/gcc-8/lab-collabora/sleep-rk3288-rock2-squar=
e.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0118.2/armhf/rootfs.cpio.gz =



  * sleep.rtcwake-mem-4: https://kernelci.org/test/case/id/6006f615015073c4=
34bb5d1a
        new failure (last pass: v5.11-rc3-19-g9f0b1e583eac)

    2021-01-19 15:08:58.844000+00:00  ake: assuming RTC uses UTC ...
    2021-01-19 15:08:58.890000+00:00  rtcwake: read rtc time failed: Invali=
d argument
    2021-01-19 15:08:58.891000+00:00  1 RESULT=3Dfail>
    2021-01-19 15:08:58.891000+00:00  rtcwake: assuming RTC uses UTC ...
    2021-01-19 15:08:58.891000+00:00  rtcwake: read rtc time failed: Invali=
d argument
    2021-01-19 15:08:58.891000+00:00  CASE_ID=3Drtcwake-mem-2 RESULT=3Dfail>
    2021-01-19 15:08:58.891000+00:00  rtcwake: assuming RTC uses UTC ...
    2021-01-19 15:08:58.892000+00:00  rtcwake: read rtc time failed: Invali=
d argument
    2021-01-19 15:08:58.939000+00:00  IGNAL_TESTCASE TEST_CASE_ID=3Drtcwake=
-mem-3 RESULT=3Dfail>
    2021-01-19 15:08:58.939000+00:00  rtcwake: assuming RTC uses UTC ... =

    ... (2 line(s) more)  =


  * sleep.rtcwake-mem-5: https://kernelci.org/test/case/id/6006f615015073c4=
34bb5d1b
        new failure (last pass: v5.11-rc3-19-g9f0b1e583eac) =

 =20
