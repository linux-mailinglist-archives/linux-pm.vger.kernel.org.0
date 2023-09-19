Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF1C7A62C2
	for <lists+linux-pm@lfdr.de>; Tue, 19 Sep 2023 14:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjISMXN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Sep 2023 08:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjISMXN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2023 08:23:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2DFF4
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 05:23:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c09673b006so41153895ad.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 05:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695126186; x=1695730986; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OEnHedXqF71k0DnzKMfj8JX+rAIeY+7p1wBprmZ10sk=;
        b=thraN59P+Je1Lhb4KXy0iUwbpHtyW+A3qA9OT34aEJyDJN2xabOqSuS4bwvoSPNYvf
         i1LmmVvV0q/aXMT9XUXESdTENE+py6bY9NGvvOATBw0Bup2RNEoCAyWEgRa7lqdp0j6v
         f6p/Gcz9U+cXWUhgOMQHA/g0a+TqOicCPEpuDzXY5C1cwUAqnVy27NbWhYiZABbhhy2w
         9yviATjrcMIVVk9tSklQ1dtvSmC9Bnur1FRmBPhh67p2GBrkL557vfwer5Jl4RAsZI6P
         MzG2mqnaSCUrV7+8QbH3peW7I4110PpIyP5ROKwSD4oJ/Ncl+yJdg6v7X69NUoAI3b1T
         NnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695126186; x=1695730986;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEnHedXqF71k0DnzKMfj8JX+rAIeY+7p1wBprmZ10sk=;
        b=SiOQncBVFKnRXzipIM+jj1bQlElzo2G3nz4816jk9d4DMMSpAYhFoBN7miNSxARfXl
         IK9983NFRuvELxP/xw01I0PNsZHf6jin3tlySuyh6ImvZVBocNjUAgybG0SPVMXMmTbK
         YWORGGcklzu3xMH72hiTJoYdsfIU8xN1ICE9OdbM+Jw43Cz5MGBgjt+c5xugshOuE52v
         k9YzM2XQEDP7PYmsQ0UrUud2FBIfJopzM8rKLHbh2909tBW80FYUuc6roaM0ojfSFzah
         A9fJ+4hmIpTnJq72cG25hokCSiJtolqFWhqsDJMHyZaix7XhapSiPyUJwWLZ9PTTgPqL
         /V+A==
X-Gm-Message-State: AOJu0YxWb7CyGt7hGA0ErI7xHIaF9BiqBQUI/Ss2rH0O7buTkd99vsRO
        ggKaYYD8qUCUtpRuCCUmRCEIfRXm0AfSe3Rt3IEzYg==
X-Google-Smtp-Source: AGHT+IGRg6wmPGgyDraeVaV2wxvH+IXcua8Bwfj/MCmC52y8riGNMQPDa36pyjDhS1Kkg6R1hcV+Qw==
X-Received: by 2002:a17:902:e552:b0:1c4:32da:2037 with SMTP id n18-20020a170902e55200b001c432da2037mr12397954plf.64.1695126186374;
        Tue, 19 Sep 2023 05:23:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m2-20020a1709026bc200b001bc0f974117sm5688076plt.57.2023.09.19.05.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:23:05 -0700 (PDT)
Message-ID: <650992a9.170a0220.2c41d.ff75@mx.google.com>
Date:   Tue, 19 Sep 2023 05:23:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc2-21-g23aa512f7cfb
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 47 runs,
 3 regressions (v6.6-rc2-21-g23aa512f7cfb)
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

pm/testing baseline: 47 runs, 3 regressions (v6.6-rc2-21-g23aa512f7cfb)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =

imx8mp-evk               | arm64 | lab-broonie     | gcc-10   | defconfig |=
 1          =

r8a779m1-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc2=
-21-g23aa512f7cfb/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc2-21-g23aa512f7cfb
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      23aa512f7cfb35df3681128dba3b9bef597fcd6c =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6509888e41867d55e08a0a5a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc2-21-g23aa51=
2f7cfb/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb15=
-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc2-21-g23aa51=
2f7cfb/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm-wb15=
-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509888e41867d55e08a0=
a5b
        new failure (last pass: v6.6-rc2-10-gb34108fa27bd) =

 =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mp-evk               | arm64 | lab-broonie     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/65098b494f1139108e8a0a50

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc2-21-g23aa51=
2f7cfb/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc2-21-g23aa51=
2f7cfb/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65098b494f1139108e8a0a59
        failing since 6 days (last pass: pm-6.6-rc1-122-g07b618ec9d7a, firs=
t fail: v6.6-rc1-5-gb5eda4c9c923)

    2023-09-19T11:51:16.559480  + set<8>[   28.261682] <LAVA_SIGNAL_ENDRUN =
0_dmesg 117126_1.5.2.4.1>
    2023-09-19T11:51:16.560074   +x
    2023-09-19T11:51:16.668826  / # #
    2023-09-19T11:51:17.834766  export SHELL=3D/bin/sh
    2023-09-19T11:51:17.840955  #
    2023-09-19T11:51:19.339962  / # export SHELL=3D/bin/sh. /lava-117126/en=
vironment
    2023-09-19T11:51:19.346007  =

    2023-09-19T11:51:22.069636  / # . /lava-117126/environment/lava-117126/=
bin/lava-test-runner /lava-117126/1
    2023-09-19T11:51:22.076391  =

    2023-09-19T11:51:22.078964  / # /lava-117126/bin/lava-test-runner /lava=
-117126/1 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
r8a779m1-ulcb            | arm64 | lab-collabora   | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/6509889f960f3a6a648a0a7e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc2-21-g23aa51=
2f7cfb/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc2-21-g23aa51=
2f7cfb/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a779m1-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509889f960f3a6a648a0a87
        failing since 61 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-09-19T11:41:55.211655  / # #

    2023-09-19T11:41:56.291769  export SHELL=3D/bin/sh

    2023-09-19T11:41:56.293527  #

    2023-09-19T11:41:57.784797  / # export SHELL=3D/bin/sh. /lava-11570434/=
environment

    2023-09-19T11:41:57.786724  =


    2023-09-19T11:42:00.512783  / # . /lava-11570434/environment/lava-11570=
434/bin/lava-test-runner /lava-11570434/1

    2023-09-19T11:42:00.515149  =


    2023-09-19T11:42:00.520043  / # /lava-11570434/bin/lava-test-runner /la=
va-11570434/1

    2023-09-19T11:42:00.583957  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T11:42:00.584449  + cd /lav<8>[   28.573578] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11570434_1.5.2.4.5>
 =

    ... (39 line(s) more)  =

 =20
