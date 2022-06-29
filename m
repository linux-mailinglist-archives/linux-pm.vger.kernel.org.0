Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F3C560682
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 18:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiF2Qqz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 12:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiF2QqX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 12:46:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836803D4AC
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 09:45:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id n12so15713231pfq.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 09:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=qbgxVjSNUSEJIFEXApWGFpryJbcZ7S92Ar7niRetWos=;
        b=WhYjJT92akcESAMtpaWOEXR2nHKOZ0Ua8GyjcCpUZQrEwfuSw78fIcD+qRY4IgncNd
         K9tNJdGaTyiKiZ3x0sGnchq2J8J16eeVpm2+UMX3TVWVRuHQBaJVymE1jkw/WMC55IWM
         gwDzB+r6YA3mPhWPgaMBGMzP2XwPp5dezwWAW/Gks4UdtPEnIAdDbR7+XlGAcN7i6kCd
         cGOxIOO0EkLlA8EYwlIoOOpVwj4srdGjZjsrnQMLodlzQD/WPQPKRJpBIwqGfojsUUGo
         Bn3gfUM+l4bGBQFDBai1o7zxWwZmKAaLN+M6ZcLoSeo5qvkYytx5OJ1phZZgNTwqyZlQ
         9rLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=qbgxVjSNUSEJIFEXApWGFpryJbcZ7S92Ar7niRetWos=;
        b=JbP4UtQRRp9RaTtplfpYyY8lznmzzJ/bFI7wOQxEModVdrikB7zLdA5ZmJpDezu56s
         2Cjiq6pjcgLyegWlR6tDTGsyXeAy9w3f+M7n9Yje3XsAIMvNZgxPSWi1qGgNDJ3dDAwe
         NUyrwqt0cjD7WZEbraq+Xxh55LpcE15nNWmhncP2TIt0ek8uTO6tsDQ4ConqjV+40Qm6
         VUwLpUuPt7bMKL7sErGGbqof9olABWNl7v/ibUQQUBPOTjL7FL6Zb8+31QVA/0yTDzcF
         kGZBIwnggsZP/Tj2kD+zMPg5nnp+oWfqRdoFkbsC9gTApcauqhKU6Ky7Sy9GLtK5dIvF
         iUZA==
X-Gm-Message-State: AJIora8pQJZMtQ0B2OXjT4+J6jxxNyUH+88Zo+kZgQ74PMQW/CBFsjs8
        +jjtC3hoybYjRw7M7k3DmjAtng==
X-Google-Smtp-Source: AGRyM1tsOTTZfaihphwrShkEzOlhxP9AjbYsK9KGeh9PRRSXMZtS7+zglWXcwxPoDNLT0t4lCNWZBQ==
X-Received: by 2002:a05:6a00:23ca:b0:525:28b4:9e3b with SMTP id g10-20020a056a0023ca00b0052528b49e3bmr9741580pfc.43.1656521141110;
        Wed, 29 Jun 2022 09:45:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c19-20020a62e813000000b005252adb89b3sm11759222pfi.32.2022.06.29.09.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 09:45:40 -0700 (PDT)
Message-ID: <62bc81b4.1c69fb81.6e58d.04ba@mx.google.com>
Date:   Wed, 29 Jun 2022 09:45:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.19-rc4-35-g06cab9aecb43
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing sleep: 4 runs, 2 regressions (v5.19-rc4-35-g06cab9aecb43)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 4 runs, 2 regressions (v5.19-rc4-35-g06cab9aecb43)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
1          =

tegra124-nyan-big | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.19-rc=
4-35-g06cab9aecb43/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.19-rc4-35-g06cab9aecb43
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      06cab9aecb43a2bac09c7f2fa90df13f29130313 =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/62bc78a03d63e88d17a39bf8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc4-35-g06cab=
9aecb43/arm/multi_v7_defconfig/gcc-10/lab-collabora/sleep-rk3288-veyron-jaq=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc4-35-g06cab=
9aecb43/arm/multi_v7_defconfig/gcc-10/lab-collabora/sleep-rk3288-veyron-jaq=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/62bc78a03d63e88d17a39bf9
        failing since 22 days (last pass: v5.18-rc6-123-g84d13b694ebbe, fir=
st fail: v5.19-rc1-2-g6a8964e282382) =

 =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
tegra124-nyan-big | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/62bc7c6d81cb7ba607a39bdd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.19-rc4-35-g06cab=
9aecb43/arm/multi_v7_defconfig/gcc-10/lab-collabora/sleep-tegra124-nyan-big=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.19-rc4-35-g06cab=
9aecb43/arm/multi_v7_defconfig/gcc-10/lab-collabora/sleep-tegra124-nyan-big=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/rootfs.cpio.gz =



  * sleep.login: https://kernelci.org/test/case/id/62bc7c6d81cb7ba607a39bde
        failing since 22 days (last pass: v5.18-rc6-123-g84d13b694ebbe, fir=
st fail: v5.19-rc1-2-g6a8964e282382) =

 =20
