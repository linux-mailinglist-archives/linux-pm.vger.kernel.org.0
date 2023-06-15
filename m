Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4FD731F72
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jun 2023 19:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbjFORnL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Jun 2023 13:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbjFORnJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jun 2023 13:43:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A0B1BDB
        for <linux-pm@vger.kernel.org>; Thu, 15 Jun 2023 10:43:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b512309d18so10801395ad.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Jun 2023 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686850983; x=1689442983;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qLpeAehfQ+AAX0YVMvdMifpMuL79tb5eQODiRXIAv7M=;
        b=luXcQvxFv0IxePi5yO7PbjpMgMFXO4u3bBbyXnzjKJid9TI93K/fTSn79PidBzoc0J
         2cxMU7Unsp0y+dBQuYIR7PD3GTen6CsmKyYkgtjr7zPVFQryD4pNkyumk4Ea1Jxn6DHY
         ZOZ3+kv6NkRGZneTll/4Iu+MOSskxBPnYghQX0MGuWkRcr5E5nwRO2k4RH6/+2kZORhx
         xLIV4jiAFLDmFH7X3Z+3Cr2bP0an6J1IO5HWq1K0sDPlm1pP/BlzHqEXU4m+XL73xH5L
         L2yx19t9MDC/xfrCj/jw7AsTxOZTiOajNLrhvPp/OuSuynr81DAXhUnHlD0CbtoRekFa
         Wklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850983; x=1689442983;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLpeAehfQ+AAX0YVMvdMifpMuL79tb5eQODiRXIAv7M=;
        b=Nk91lw3huxUk09eKottQ8Tic1yKhx16s5EYAqBTv17ud2ASMg3MWneNqMtzoaQ8/+B
         BKVg2C6vZU/Dxv4TiJWU1PVTP8XetCohSFneE0OCWpcVQ6uHsjxdTxXmLR0qvUc6JLRp
         s1787bdJThqBkvPAxzUKHSpXDKXJItol/OicfeG5wnvb6cEHZ/6sObi30pZph/gcv9kw
         JjLiJo+0TqxU/zHGhLV6vSjF+e/OYtsI+a24GlaS6GZczpfEskRtnv/keTa8M7dHhtvy
         30QJOegPCbhJx0cp/EIW/ZlQ5wuo+XrmUUuWBNvI9ljfgnA0s2nElh69CEgxpVeWZ2Bs
         sQhQ==
X-Gm-Message-State: AC+VfDxYBvo+jfj9B7m/ZzVhOZ3t9lVv29xXMUKYl/zIj8vkKKTR8wiX
        RoqrmjcUS/p7EE89UuhZ2ljs5w==
X-Google-Smtp-Source: ACHHUZ6+t4m3D7z81hz4yONkBxWRhhunOwz+vFt0otJm6waUsiGgPE150gl0yxZAHQdf8yHn0GATlg==
X-Received: by 2002:a17:902:a983:b0:1b3:e6ba:1575 with SMTP id bh3-20020a170902a98300b001b3e6ba1575mr6903948plb.16.1686850983389;
        Thu, 15 Jun 2023 10:43:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c16-20020a170903235000b001b0395c3ffasm14383100plh.180.2023.06.15.10.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 10:43:02 -0700 (PDT)
Message-ID: <648b4da6.170a0220.1e46f.db62@mx.google.com>
Date:   Thu, 15 Jun 2023 10:43:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.4-rc6-65-g06c8e224e0039
Subject: pm/testing baseline: 59 runs,
 2 regressions (v6.4-rc6-65-g06c8e224e0039)
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

pm/testing baseline: 59 runs, 2 regressions (v6.4-rc6-65-g06c8e224e0039)

Regressions Summary
-------------------

platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.4-rc6=
-65-g06c8e224e0039/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.4-rc6-65-g06c8e224e0039
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      06c8e224e003919993b1ea1c7ef6fd648725b004 =



Test Regressions
---------------- =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
imx53-qsrb                   | arm   | lab-pengutronix | gcc-10   | multi_v=
7_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/648b444bdc5f9d905430616b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc6-65-g06c8e2=
24e0039/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.t=
xt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc6-65-g06c8e2=
24e0039/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/648b444bdc5f9d9054306170
        failing since 138 days (last pass: v6.1-rc8-156-g0a9e32afe717, firs=
t fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-06-15T17:02:44.909964  + set +x
    2023-06-15T17:02:44.910141  [   13.162086] <LAVA_SIGNAL_ENDRUN 0_dmesg =
978695_1.5.2.3.1>
    2023-06-15T17:02:45.017720  / # #
    2023-06-15T17:02:45.119411  export SHELL=3D/bin/sh
    2023-06-15T17:02:45.119836  #
    2023-06-15T17:02:45.221098  / # export SHELL=3D/bin/sh. /lava-978695/en=
vironment
    2023-06-15T17:02:45.221555  =

    2023-06-15T17:02:45.322866  / # . /lava-978695/environment/lava-978695/=
bin/lava-test-runner /lava-978695/1
    2023-06-15T17:02:45.323583  =

    2023-06-15T17:02:45.326959  / # /lava-978695/bin/lava-test-runner /lava=
-978695/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab             | compiler | defconf=
ig          | regressions
-----------------------------+-------+-----------------+----------+--------=
------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64 | lab-broonie     | gcc-10   | defconf=
ig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648b4516dad72fd7b1306157

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc6-65-g06c8e2=
24e0039/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all=
-h3-cc.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc6-65-g06c8e2=
24e0039/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-h5-libretech-all=
-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230609.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/648b4516dad72fd7b1306=
158
        failing since 58 days (last pass: v6.3-rc6-135-g5235219c59f8, first=
 fail: v6.3-rc7-153-gbc538c8be4bd) =

 =20
