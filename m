Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0078324253
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 17:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhBXQnQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 11:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbhBXQm5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 11:42:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D00C0617A7
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 08:41:39 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id z7so1521764plk.7
        for <linux-pm@vger.kernel.org>; Wed, 24 Feb 2021 08:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=jtv3ywV7w+Bn4pmt21dvFoSUIpyi/wlSAxMMGh/woaM=;
        b=arho5n/cLLzlNDgs+Ns+90yzUAWJ/DANESeneDwC+4LP7nl1cRVH9Jhrr8fpza/NBl
         LLfGXPUL/jHLNIDJOHNkc/tHK8xHMem+IHQZ+2x4UGVzqUoTXwMkPWEZcaa4hATSx1WA
         YMrF0de6pvju9eFQrigoPfpalSleznRhF/ORrzRY7UjZ1KthSiruEY+OZT1D5DDSp0B2
         9olptu2pyg1UdBoZGxlsU17xOSLkDUgn4qYoOOBHCx0ONCoNXfwKh3dKJumsELhEV0Dv
         1/DNPvDQsLGp/yKQ1n9tz0naBwNm/02iq0yatz12wnFzoUwEGaHHdB7DbEoR7KKVFaeG
         Jfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=jtv3ywV7w+Bn4pmt21dvFoSUIpyi/wlSAxMMGh/woaM=;
        b=b7KYIwXcvx+PWwMoawkvDhvJWxUmpexE1vATHBAoCsfx8swiwP18kz1wdHiU1gj9Ho
         60j7QSlzcj1pBxI88Ccg6asQ14/VH/VwciidGMValqeNlQhUjiDsMkslg5FebOoQIEwS
         DAaCIhJ9P0bFNd540WfUHjLVZCLY9msWBynu2kYaxf7F5F7GHx52mmTvxhBMZhHhg2Xz
         9UPzaCogv3Bme7THfS94Y7H9YEzae0ba8Ynfg/25EnxSmPBJPBISHZGanNU0r+xu6ZR/
         o9f1MQDmtbOsj9UBYEy59m1mImIdESVkZLkto+qUsAWPB7w+WAHfgyHfvxb+Tx7yRyss
         DCSw==
X-Gm-Message-State: AOAM530tmGjCnVZKZUHctexExuMkswi4BYScIBB3m0TO8pCtxPyvyE+6
        +31KkonWkYyjFh25nSTkVQY6oQ==
X-Google-Smtp-Source: ABdhPJwlobVJcpVHaCu8z5+wI3i4AqHlp4+owTOkVrS6KDL5Zg+Cb2Vnq0Pjk6kk+q86Z5C+GkhBBg==
X-Received: by 2002:a17:902:c24c:b029:e3:f6cf:36c7 with SMTP id 12-20020a170902c24cb02900e3f6cf36c7mr8353588plg.60.1614184898560;
        Wed, 24 Feb 2021 08:41:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p26sm3444110pfn.127.2021.02.24.08.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:41:38 -0800 (PST)
Message-ID: <603681c2.1c69fb81.17e19.71c3@mx.google.com>
Date:   Wed, 24 Feb 2021 08:41:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.11-168-gd10b8fa0d6dfd
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 58 runs, 1 regressions (v5.11-168-gd10b8fa0d6dfd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 58 runs, 1 regressions (v5.11-168-gd10b8fa0d6dfd)

Regressions Summary
-------------------

platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.11-16=
8-gd10b8fa0d6dfd/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.11-168-gd10b8fa0d6dfd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d10b8fa0d6dfd06fb9afd44b0ceea8e904fc95bf =



Test Regressions
---------------- =



platform   | arch  | lab     | compiler | defconfig | regressions
-----------+-------+---------+----------+-----------+------------
imx8mp-evk | arm64 | lab-nxp | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6036785aff5d4a384baddcb8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.11-168-gd10b8fa0=
d6dfd/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.11-168-gd10b8fa0=
d6dfd/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6036785aff5d4a384badd=
cb9
        failing since 4 days (last pass: pm-5.11-rc8-201-g8b72d3aa065c, fir=
st fail: pm-5.11-rc8-205-g4475f0291af9) =

 =20
