Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87135AC166
	for <lists+linux-pm@lfdr.de>; Sat,  3 Sep 2022 22:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiICUyJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Sep 2022 16:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiICUyI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Sep 2022 16:54:08 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A5053008
        for <linux-pm@vger.kernel.org>; Sat,  3 Sep 2022 13:54:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso8744904pjk.0
        for <linux-pm@vger.kernel.org>; Sat, 03 Sep 2022 13:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=/rFzywqKjiIOens/YJ3g1taxOCLDC+PdKAJH6Oo3/10=;
        b=CQqYKhtNfpoKCnXIJiSWeSIfXbrWaSt2NSCR0/TB3YW2XxeCtRL61WQbXEE5DTV5AS
         o7hyIhx/w5weq14AUSgVzlnnCOTNCRIt8qW6zMajvsk3LVQ8V0LmiDrbC1wbtCnc1btY
         O1JY90+kId01awAi5nGp9fT0LW4YGqS+y/4SjrAv0XUeoLL6MyCns6jTLHXWoAtlnI7C
         pVLIeA325Le76i2vVbKUcrzOYdL9UMmwx8mIzXCwsiuLGvAh6ZHgYER/nMTSjbHpyn75
         4ge4QnyODCf0Z7co0mxkkVXhsErzFAGuvIFfkjPr9zN8KXx+OSndF5pXcwDrUMNa2g/5
         K2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=/rFzywqKjiIOens/YJ3g1taxOCLDC+PdKAJH6Oo3/10=;
        b=gscN5EmLc1p6F12KeMxYbvcPlt+VL4fXGJEEJ9cMzRN/31DBqwumceb2prpN7Ju/Qq
         0CIHMObpz6bt+ce1xoLQuYYEInUZUc7iCiuKOHME5t7+3BO7yPFLpkL5Oa1DFOtj8qhS
         TnWvwFdG+uULvAnOay93Gsn8WIifyIe9rZknSfNAHBKOROZRcZkDs8eeuoMXtYeaK2Td
         MHi3ff/PbWkuEV6FJcLQT5YBEshrc7mQgnRjOmxQSkrBXu8eCLmMLksUoOd4PV7jo6x1
         /ffO/IieWSa0wlm/J7t8MtDmXIyi5yQfpxJyMDKbfE5IuwL0fa6Llb93ibVcZL0d9ZjC
         BNJw==
X-Gm-Message-State: ACgBeo2HPIAyivt8T5mxwhdH4HYsX3m5nw7uW6XvzXB+0bW4C2/1trzh
        DRS3XX/30buqLu+0QTzkHIIeWg==
X-Google-Smtp-Source: AA6agR4usIpzXPTNneMQ5GmvM1Qe5V6x+9TJKDIK0BT9XgCocX+svQ5SQnZ2TcwYjEjoHlcSP+qYVA==
X-Received: by 2002:a17:90a:5988:b0:1fd:6a33:abf with SMTP id l8-20020a17090a598800b001fd6a330abfmr11539161pji.69.1662238445849;
        Sat, 03 Sep 2022 13:54:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p129-20020a622987000000b0052e6d5ee183sm4369372pfp.129.2022.09.03.13.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 13:54:05 -0700 (PDT)
Message-ID: <6313beed.620a0220.17b92.6a93@mx.google.com>
Date:   Sat, 03 Sep 2022 13:54:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.0-rc3-85-gf6f4c123bfbc
Subject: pm/testing baseline: 96 runs,
 4 regressions (v6.0-rc3-85-gf6f4c123bfbc)
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

pm/testing baseline: 96 runs, 4 regressions (v6.0-rc3-85-gf6f4c123bfbc)

Regressions Summary
-------------------

platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
imx6ul-pico-hobbit    | arm   | lab-pengutronix | gcc-10   | multi_v7_defco=
nfig | 1          =

kontron-kbox-a-230-ls | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 1          =

kontron-pitx-imx8m    | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.0-rc3=
-85-gf6f4c123bfbc/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.0-rc3-85-gf6f4c123bfbc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f6f4c123bfbc88ef6d4aa7ade3c70d57e1cbbcfa =



Test Regressions
---------------- =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
imx6ul-pico-hobbit    | arm   | lab-pengutronix | gcc-10   | multi_v7_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6313b65eb692561082355651

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc3-85-gf6f4c1=
23bfbc/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico-h=
obbit.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc3-85-gf6f4c1=
23bfbc/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6ul-pico-h=
obbit.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6313b65eb692561082355=
652
        failing since 36 days (last pass: v5.19-rc8-79-gb3f10ca8bf191, firs=
t fail: v5.19-rc8-92-ge240a33f1bc48) =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
kontron-kbox-a-230-ls | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/6313b5629812699eb1355679

  Results:     94 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc3-85-gf6f4c1=
23bfbc/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc3-85-gf6f4c1=
23bfbc/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.mscc_felix-probed: https://kernelci.org/test/case/id/63=
13b5629812699eb1355682
        failing since 88 days (last pass: v5.18-rc7-183-g45785e0ed597, firs=
t fail: v5.19-rc1-2-g6a8964e282382)

    2022-09-03T20:13:05.695524  /lava-163634/1/../bin/lava-test-case
    2022-09-03T20:13:05.695883  <8>[   20.065733] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dmscc_felix-probed RESULT=3Dfail>
    2022-09-03T20:13:05.696123  /lava-163634/1/../bin/lava-test-case   =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
kontron-pitx-imx8m    | arm64 | lab-kontron     | gcc-10   | defconfig     =
     | 2          =


  Details:     https://kernelci.org/test/plan/id/6313b560e2cc3b0113355674

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.0-rc3-85-gf6f4c1=
23bfbc/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.0-rc3-85-gf6f4c1=
23bfbc/arm64/defconfig/gcc-10/lab-kontron/baseline-kontron-pitx-imx8m.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.imx6q-pcie-pcie0-probed: https://kernelci.org/test/case=
/id/6313b560e2cc3b0113355682
        failing since 11 days (last pass: v5.19-rc8-92-ge240a33f1bc48, firs=
t fail: v6.0-rc1-6-g977346c02019)

    2022-09-03T20:13:04.522325  /lava-163630/1/../bin/lava-test-case
    2022-09-03T20:13:04.522705  <8>[   19.315965] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dimx6q-pcie-pcie0-probed RESULT=3Dfail>
    2022-09-03T20:13:04.522952  /lava-163630/1/../bin/lava-test-case   =


  * baseline.bootrr.intel-igb-probed: https://kernelci.org/test/case/id/631=
3b560e2cc3b0113355684
        failing since 11 days (last pass: v5.19-rc8-92-ge240a33f1bc48, firs=
t fail: v6.0-rc1-6-g977346c02019)

    2022-09-03T20:13:05.559956  /lava-163630/1/../bin/lava-test-case
    2022-09-03T20:13:05.560327  <8>[   20.360479] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dintel-igb-probed RESULT=3Dfail>   =

 =20
