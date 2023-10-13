Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394DF7C8578
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 14:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjJMMRz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 08:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjJMMRy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 08:17:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D141A9
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 05:17:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9d922c039so16603645ad.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 05:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697199473; x=1697804273; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4AwMSpiv3KS3pMCdcICHuzkNHaAuRUN5g3wFTY8UVOc=;
        b=q+5J7QbuQK91Qjoba/OEU9rY2WTgyFL6um98MTCC96lEEHIGDCc4tUP6n2jsv4prYF
         PCtT2R2PylsFEQwVi8NCCoyYCX3VhyBzLrD/pfdp66I1w+FKk73H17Y0Z8rXmnU4+fHo
         RgNffLS8YOiVGLVNJ9iFxa8JDErwC9hVjNkbs1ou3mJHwng1UTy/SM4slsuJQtdq9EuI
         bvJlsekO0HOfjk/L7qdMV57pOz97N7p2ycldEzgrRzwFO9JkKTsXIhc9bHwVWq8sku9n
         ySDqjZJf76FKb/JaPs6sTJ4yUk+vYAYe5aJc6P4fzS+7S6MXNg+QYYQ0Bg3ciKV4n6Qw
         yzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199473; x=1697804273;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AwMSpiv3KS3pMCdcICHuzkNHaAuRUN5g3wFTY8UVOc=;
        b=i+rt3oeumhs1wcYfNR9meaFOp1TkEc2RyXcDzunlLixh88Tp7dFBvSZmjjaqjqXk1p
         xQsD29uOfh1zC5j1oGoeB7yvVgsls9aJYmalNhT+U5KR10SRmRghggSalqQ0cLhfTPuj
         YhFZxB7GnOSd6Teq54Fn6P+XDbmxYXmfHln6IM+8ccVvTqEXmykPVzTQHrQxBcJwKQjK
         oACEZKt42YYUjB7LRbNYd7socZRsQSk+cz/XwTtnYE5mM+Xd8tsei/nYrq83KcFQM/Sl
         rWKgDm4MZQkuqbLqyB/mbDukAAv5otFyXeObTr0P2ptn1ZBFxEVkuk73Lh5hP/XZmIXg
         Y7Vw==
X-Gm-Message-State: AOJu0Yz5pTLkbv3MvDhVw0022FPvuIRSHHJvq/74udcKoD57l8dFiXwa
        Eq66owE8TE657UCkkOh9dLWqfQ==
X-Google-Smtp-Source: AGHT+IHDuULhSAns5MWBg7S5Mt11Ti+pylRhc6Pz+t1cjTIORRrK6pPN1XZ2VObF1RTpWgV/zgipzQ==
X-Received: by 2002:a17:902:9885:b0:1c6:117b:7086 with SMTP id s5-20020a170902988500b001c6117b7086mr25536458plp.5.1697199472690;
        Fri, 13 Oct 2023 05:17:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902d2cf00b001b06c106844sm3733822plc.151.2023.10.13.05.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:17:52 -0700 (PDT)
Message-ID: <65293570.170a0220.a91e8.b5a1@mx.google.com>
Date:   Fri, 13 Oct 2023 05:17:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc5-157-g8134843f53ba
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 47 runs,
 4 regressions (v6.6-rc5-157-g8134843f53ba)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 47 runs, 4 regressions (v6.6-rc5-157-g8134843f53ba)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
imx8mp-evk         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc5=
-157-g8134843f53ba/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc5-157-g8134843f53ba
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      8134843f53ba0826c8d090964f9bedeeea19c665 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
imx8mp-evk         | arm64 | lab-broonie   | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65292bbd7dcce85d0fefcfc1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc5-157-g81348=
43f53ba/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc5-157-g81348=
43f53ba/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65292bbd7dcce85d0fefcfca
        failing since 30 days (last pass: pm-6.6-rc1-122-g07b618ec9d7a, fir=
st fail: v6.6-rc1-5-gb5eda4c9c923)

    2023-10-13T11:36:16.418942  + set<8>[   29.002352] <LAVA_SIGNAL_ENDRUN =
0_dmesg 169036_1.5.2.4.1>
    2023-10-13T11:36:16.419547   +x
    2023-10-13T11:36:16.529630  / # #
    2023-10-13T11:36:17.695958  export SHELL=3D/bin/sh
    2023-10-13T11:36:17.702106  #
    2023-10-13T11:36:19.201315  / # export SHELL=3D/bin/sh. /lava-169036/en=
vironment
    2023-10-13T11:36:19.207334  =

    2023-10-13T11:36:21.930846  / # . /lava-169036/environment/lava-169036/=
bin/lava-test-runner /lava-169036/1
    2023-10-13T11:36:21.937620  =

    2023-10-13T11:36:21.953555  / # /lava-169036/bin/lava-test-runner /lava=
-169036/1 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65292b37c5015119f0efd0f1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc5-157-g81348=
43f53ba/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc5-157-g81348=
43f53ba/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65292b37c5015119f0efd0fa
        failing since 85 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-10-13T11:38:25.669894  / # #

    2023-10-13T11:38:25.771989  export SHELL=3D/bin/sh

    2023-10-13T11:38:25.772694  #

    2023-10-13T11:38:25.874108  / # export SHELL=3D/bin/sh. /lava-11759913/=
environment

    2023-10-13T11:38:25.874817  =


    2023-10-13T11:38:25.976261  / # . /lava-11759913/environment/lava-11759=
913/bin/lava-test-runner /lava-11759913/1

    2023-10-13T11:38:25.977358  =


    2023-10-13T11:38:25.994316  / # /lava-11759913/bin/lava-test-runner /la=
va-11759913/1

    2023-10-13T11:38:26.043417  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-13T11:38:26.043956  + cd /lava-117599<8>[   19.408697] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11759913_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
r8a779m1-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65292b58511dbd86e2efcefc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc5-157-g81348=
43f53ba/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc5-157-g81348=
43f53ba/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65292b58511dbd86e2efcf05
        failing since 85 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-10-13T11:34:59.625586  / # #

    2023-10-13T11:35:00.705557  export SHELL=3D/bin/sh

    2023-10-13T11:35:00.707304  #

    2023-10-13T11:35:02.190950  / # export SHELL=3D/bin/sh. /lava-11759908/=
environment

    2023-10-13T11:35:02.192211  =


    2023-10-13T11:35:04.913481  / # . /lava-11759908/environment/lava-11759=
908/bin/lava-test-runner /lava-11759908/1

    2023-10-13T11:35:04.915625  =


    2023-10-13T11:35:04.917424  / # /lava-11759908/bin/lava-test-runner /la=
va-11759908/1

    2023-10-13T11:35:04.980779  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-13T11:35:04.981262  + cd /lava-117599<8>[   28.531525] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11759908_1.5.2.4.5>
 =

    ... (38 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig | regress=
ions
-------------------+-------+---------------+----------+-----------+--------=
----
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65292c3bea46f82057efcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc5-157-g81348=
43f53ba/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc5-157-g81348=
43f53ba/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50i-h6-pine-h64.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65292c3bea46f82057efc=
ef6
        new failure (last pass: v6.6-rc5-141-g45db6c21c12e0) =

 =20
