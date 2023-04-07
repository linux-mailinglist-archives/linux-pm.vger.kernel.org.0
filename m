Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C53A6DACD3
	for <lists+linux-pm@lfdr.de>; Fri,  7 Apr 2023 14:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjDGM4v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Apr 2023 08:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjDGM4u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2023 08:56:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707407683
        for <linux-pm@vger.kernel.org>; Fri,  7 Apr 2023 05:56:49 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id r7-20020a17090b050700b002404be7920aso41456201pjz.5
        for <linux-pm@vger.kernel.org>; Fri, 07 Apr 2023 05:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680872209; x=1683464209;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XcT/LsCG7pL2XUkxyKEoC0zgj29aQqEEpqAjcM609pk=;
        b=kbSagej5pZyXE1BZlCtlWwZLGY70Hz+zdo62AIcTAHSvzOoK9jz0KGT9dOGUA8u4Or
         eLMMx5yTcV20jldhtG8hwZwjeKZUM5wpFC2qsOkkDEY9ViIJMRFTdSSns55NTiqsfvYj
         5J/ypqmBXnBFNLd15y5dk6NIUq3WQm6hUnJNTP2DTX1IJg8h5Db+UGlxDnCdSv+tu4o5
         hMYL3cn9OboA3+Bk1Xl7BwqZpHNlCOqjHhmTuLoL92HXpGMDTHVf27MtV8j7umI8ZQMw
         m9LrZoHdUi2IPsSuJF4hpspWaHBDO/TJMk8QPwYEmuIy5k7prUKzIP98xC1i2u/wmk0u
         38aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680872209; x=1683464209;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XcT/LsCG7pL2XUkxyKEoC0zgj29aQqEEpqAjcM609pk=;
        b=YXdTCFKGVmO2QwjmuykdwSP2CAc1nh0JvlU+yiOg+lA/JgxeUNOJlyUeQpmIwByzAC
         YHfOK3yssOUiPu+istIP/r5Fgcd2TD1sm8RlFI3TFhZA0QaaYO/aNxxBben/75FLia7d
         cKn92zZubDgg9yQrZoF96mRqV4SuMQ6E1MoIWzmkiwpDAbG4gPTxVpvjLx7jgsSjWych
         JK7niv14b4GpFnoHkFq/2/66GjP/FcGjyFhVSo61wbr5FdzP7MtnJfIobvby0pzNKa+M
         Ff2aevdwmsNvPpPpb4n9zv1BQhN5LD83UXbDAbrCleQ93IXjbi6hDwu2NN9WjRwSnEkD
         F7Eg==
X-Gm-Message-State: AAQBX9cYv5R3tY3DuzXVdHpGEm5EI5uhPw12Xe9ZzsC5zGQzEiJo17I5
        ajRLjh1nSioK47HL9yUOcl4MZbQ8y9ij7PJO2M+MSbyV
X-Google-Smtp-Source: AKy350YCXcW8zTmZh3UlX/nWIyB7d2w5YXjLQKQVk18rhM3BnGJBus0BK+re3sqtR7GNPYV/hb5epw==
X-Received: by 2002:a17:902:db08:b0:19c:c9da:a62e with SMTP id m8-20020a170902db0800b0019cc9daa62emr3081613plx.54.1680872208919;
        Fri, 07 Apr 2023 05:56:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v4-20020a1709028d8400b0019c13d032d8sm2864860plo.253.2023.04.07.05.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 05:56:48 -0700 (PDT)
Message-ID: <64301310.170a0220.c475.6241@mx.google.com>
Date:   Fri, 07 Apr 2023 05:56:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: acpi-6.3-rc6-124-g5eb08f42cafd
Subject: pm/testing baseline: 55 runs,
 1 regressions (acpi-6.3-rc6-124-g5eb08f42cafd)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 55 runs, 1 regressions (acpi-6.3-rc6-124-g5eb08f42cafd)

Regressions Summary
-------------------

platform        | arch  | lab     | compiler | defconfig | regressions
----------------+-------+---------+----------+-----------+------------
fsl-lx2160a-rdb | arm64 | lab-nxp | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-6.3=
-rc6-124-g5eb08f42cafd/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-6.3-rc6-124-g5eb08f42cafd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      5eb08f42cafd07b31a459e90c745945372d4f6e8 =



Test Regressions
---------------- =



platform        | arch  | lab     | compiler | defconfig | regressions
----------------+-------+---------+----------+-----------+------------
fsl-lx2160a-rdb | arm64 | lab-nxp | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/643008524e9b36fd4279e925

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-6.3-rc6-124-g5=
eb08f42cafd/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-6.3-rc6-124-g5=
eb08f42cafd/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-lx2160a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230324.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/643008524e9b36fd4279e928
        failing since 22 days (last pass: v6.1-rc5-55-g60453df62d30, first =
fail: v6.3-rc2-33-g1240ce78c05e)

    2023-04-07T12:10:49.175079  [   12.076797] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1195773_1.5.2.4.1>
    2023-04-07T12:10:49.279616  / # #
    2023-04-07T12:10:49.381596  export SHELL=3D/bin/sh
    2023-04-07T12:10:49.382253  #
    2023-04-07T12:10:49.483790  / # export SHELL=3D/bin/sh. /lava-1195773/e=
nvironment
    2023-04-07T12:10:49.484345  =

    2023-04-07T12:10:49.585702  / # . /lava-1195773/environment/lava-119577=
3/bin/lava-test-runner /lava-1195773/1
    2023-04-07T12:10:49.586526  =

    2023-04-07T12:10:49.587957  / # /lava-1195773/bin/lava-test-runner /lav=
a-1195773/1
    2023-04-07T12:10:49.613409  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =20
