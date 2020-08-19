Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4702624A70D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 21:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHSTn1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 15:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSTn0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 15:43:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EFBC061757
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 12:43:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id k13so11308609plk.13
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 12:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gI3hcMWyUPQDhi2ZIsQbH3p8/jKBLT2qB4OCxT7orTA=;
        b=zkJ+itN6mYFX6MfsOKNjDiagFofhW0tEozF6P+iy1wFMdFr2fL2f7ONcQe1gd1AieU
         jviOOiw/Oh5WPpNfwyca+oD+9r+SW9ioDm5PLd/dGsfU8rYzcwjeQx47ynOTq8Tu0Yyq
         /iljQnN/7gmprZCwbQJcJLEDMNJfTojVvIgNhvpmiZSLiwRZlj9C8QmtXwNUqadMjip5
         1hdJbsb+9Ik4ahGZcGnZE3yu0DnIuomJGntdEAyxCfvG8VaPVmWXUPElZGAR58aRsr7Q
         tYhofZviAlFBX/pDJaG7LRjHIGt35R9IUuspmcwg5zkklvj5S+ow0S3ydimjcfIXLCXR
         8QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gI3hcMWyUPQDhi2ZIsQbH3p8/jKBLT2qB4OCxT7orTA=;
        b=KBx8Rvjd9D7FZjwnueRYftZ3j1ObZe2GZsmMvUpQt3GSLgfAz6O1KYfxEuq1z6RFn8
         lEfwf/UtAUeo4QIP9WxMnr2EMTY+kdKvVbRWYaUk+1TbihQaH+CK2JSSCOKMJOigQYhE
         YcrOS0uRBT4YPRHi9CP+jdJif7vB2s6I1aFQrWMj4bGbiyLwhvrMFNwaK4tjzq2O4Zrp
         AcfvtICHMcG7l5sonyMhfr6ezxkbp4ZA/rjJn49NMY0FXmJauwDP76tBB7A3sVwj1okD
         Lhn9XTQoiMf5aOcljGY4dpiPw+aC2qsEgEsEkoIMQJXGCybMRvTz6RXHN+bHkbGMY4Wx
         OAZA==
X-Gm-Message-State: AOAM530fHeo7aAvFv0wzyBB8JCVuzQ7Sm59y3EbeaKXT1eJAnWXeQ4U9
        JfuTxP7eJMRPxKnXUQ1IPBvSOA==
X-Google-Smtp-Source: ABdhPJy8mMZbbuZu8SPX+Rk2apDZKErVvKTEZQFMDkIQRw8S/ZnQ2FxJkZ8urhgI+CHSHg0CNAeI2w==
X-Received: by 2002:a17:90a:f3c8:: with SMTP id ha8mr2539987pjb.116.1597866205636;
        Wed, 19 Aug 2020 12:43:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v5sm3731551pjz.33.2020.08.19.12.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:43:24 -0700 (PDT)
Message-ID: <5f3d80dc.1c69fb81.962dd.8a8c@mx.google.com>
Date:   Wed, 19 Aug 2020 12:43:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.9-rc1-4-g1f08d51cd57f
X-Kernelci-Branch: testing
Subject: pm/testing sleep: 7 runs, 1 regressions (v5.9-rc1-4-g1f08d51cd57f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing sleep: 7 runs, 1 regressions (v5.9-rc1-4-g1f08d51cd57f)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.9-rc1=
-4-g1f08d51cd57f/plan/sleep/

  Test:     sleep
  Tree:     pm
  Branch:   testing
  Describe: v5.9-rc1-4-g1f08d51cd57f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      1f08d51cd57fddbecc396183e544b1d6df98cbfa =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig | results
----------------+-------+---------------+----------+-----------+--------
mt8173-elm-hana | arm64 | lab-collabora | gcc-8    | defconfig | 0/1    =


  Details:     https://kernelci.org/test/plan/id/5f3d6bef1acb1e7978d99a39

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.9-rc1-4-g1f08d51=
cd57f/arm64/defconfig/gcc-8/lab-collabora/sleep-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2020=
0814.0/arm64/rootfs.cpio.gz =


  * sleep.login: https://kernelci.org/test/case/id/5f3d6bef1acb1e7978d99a3a
      new failure (last pass: v5.8-107-gb72b3ea38c81)  =20
