Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA0B513C91
	for <lists+linux-pm@lfdr.de>; Thu, 28 Apr 2022 22:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242797AbiD1UVR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Apr 2022 16:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiD1UVQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2022 16:21:16 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D778B1AB0
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 13:17:58 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r83so4877359pgr.2
        for <linux-pm@vger.kernel.org>; Thu, 28 Apr 2022 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=LwywbVA49JdmEQsKXeYVbI0V1iZaTMjM4KgH+8zNNPM=;
        b=S4f6J7ZJPUq8rKZ58lQ6Ok1JiDdGJdmLtGPVEfBAlQHshULybUxb2FhYDrtSMmBnBB
         haTOyt9RH7MrV6Sx7A6JVG4xAXt6KmqUk5okGjEino+7iDdnUKaJ6rOoVd3AKTb3+JvM
         lfnG8cZRuprintBqSrm5xFXiaVJZ7k0kAbGPwdByVr8C1UyEpri/9vuLfOYRoEWmsODI
         9TVI8nMAycJ7ps1Jbwnq5I3LFO3idL4wk/81+uwEa5YRdSwRcfGYEFuAZJ+YGMCzbZxC
         lr+OuEWYDkIPg5oVS3kOzZCc/PNddtCy7lZgY5nLgRr+v4CssaHDiw8AcC+qCh1/sQ8E
         6Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=LwywbVA49JdmEQsKXeYVbI0V1iZaTMjM4KgH+8zNNPM=;
        b=bN0DgRQLOhxsDWYtsO1pc9r58Cpxl0zb4uvoq27f/nnW1qrMd4wT96rVt19dIT/4cM
         nJe2VXpEYWiADLH6o2Li9LyNVG1oQpPKufiresnVDFxxGT3GTJ5FGm7/9iifDluVeeL2
         uTpTw0M+vUxvcDJfroao4KsShMJfOBYhrzTRhOClkt4l90cauMGW4mmELbXE8BBQnqcC
         GrxtAPVJgrWsJIy8gKdT/lN6+bxTnstlwD5vwgZ9RfSaf5Rv60r9v63jHb81dM0S41QY
         w+/HIZNOeGf+SlAcOHOBfyIndK6qhdbTsOgKASZZzZbkKgBtrPrBIku+N/fu3lOE2gxJ
         d5kA==
X-Gm-Message-State: AOAM530EXgmsStdmMQt0CnsyNxK17cSKRhzZAqpv6gaLLUreJY9cR1Ry
        VSzCaS9igoUirmeTdUlrhLtB0++ROdYUxBzEkrU=
X-Google-Smtp-Source: ABdhPJx2qwUbLv2y8PaDG9UqXE46RZ7piQB5KnxnWpo9uy8xzWbpKwivPWBTZR7hfux2tUBY1tTSYw==
X-Received: by 2002:a63:80c8:0:b0:3c1:8351:303e with SMTP id j191-20020a6380c8000000b003c18351303emr3204619pgd.307.1651177077709;
        Thu, 28 Apr 2022 13:17:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g12-20020a056a001a0c00b004e1307b249csm671013pfv.69.2022.04.28.13.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 13:17:57 -0700 (PDT)
Message-ID: <626af675.1c69fb81.44f18.1f26@mx.google.com>
Date:   Thu, 28 Apr 2022 13:17:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.18-rc4-115-gd3fa656ae5f38
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 54 runs,
 2 regressions (v5.18-rc4-115-gd3fa656ae5f38)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 54 runs, 2 regressions (v5.18-rc4-115-gd3fa656ae5f38)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.18-rc=
4-115-gd3fa656ae5f38/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.18-rc4-115-gd3fa656ae5f38
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      d3fa656ae5f38da2890e3c0d538b397d9afacea2 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-baylibre  | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/626aec128b3174da4bff945f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.18-rc4-115-gd3fa=
656ae5f38/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.18-rc4-115-gd3fa=
656ae5f38/arm64/defconfig/gcc-10/lab-baylibre/baseline-sun50i-h6-pine-h64.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220422.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/626aec128b3174da4bff9=
460
        failing since 13 days (last pass: v5.18-rc2-13-g781d19cfe317e, firs=
t fail: v5.18-rc2-76-g5675fd487f2b2) =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/626aec0b8b3174da4bff9459

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.18-rc4-115-gd3fa=
656ae5f38/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.=
txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.18-rc4-115-gd3fa=
656ae5f38/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220422.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/626aec0b8b3174da4bff9=
45a
        failing since 13 days (last pass: v5.18-rc2-13-g781d19cfe317e, firs=
t fail: v5.18-rc2-76-g5675fd487f2b2) =

 =20
