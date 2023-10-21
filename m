Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23B7D1A9B
	for <lists+linux-pm@lfdr.de>; Sat, 21 Oct 2023 05:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjJUDNn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Oct 2023 23:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUDNm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Oct 2023 23:13:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5B6D76
        for <linux-pm@vger.kernel.org>; Fri, 20 Oct 2023 20:13:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27b22de9b5bso1048337a91.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Oct 2023 20:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697858017; x=1698462817; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X8pVTOWTjdunB1NvNkXtep12DQLh34k8CGyRklQEdKc=;
        b=qcY7sZ40AwSXTj00IfgetchdEClqn6R4h/psegyp/2KqHGNrznE/kwNdGogX5yaYXH
         /YNNfsJCY/EkP8L6VmP6CEl6QtVAMak9RSbNpgbE4awWDgzegM2WS3OWh+jMESDBcd9u
         W7W+9sP7JYz3Q1Ri7YvSvTT3Oj6pgyBDlW0DkoekK2ngBlHpkm+uUSonviMyt/QC8la+
         HnnEmLMoS0vAdw7O3yYs/zYlaEnwLsTy8/QmGxZYXIcVaQRAg/XsjLEU7qMAqAopiFNU
         8Crcw1Zv8a0mPdLGuJUbvrz0kXPhugaQGTYPky87IpbGDA8sZrjeS3c6S8W1oFrHNapz
         IV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697858017; x=1698462817;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8pVTOWTjdunB1NvNkXtep12DQLh34k8CGyRklQEdKc=;
        b=LvpfBdimwFDR9wATztUIbSx+fQ0l0bnUKSt270bISgXOloHu/PFvSWjfFXtt6V+PX7
         an3EtYBsUzYM5PFcTxyExPXMTfL8qobH0BT4b5jJkYhp2XohYZ+FDgsnxxNgi0Lvgd1q
         rc4OC97GnLfzZR+YxfPk7d3d0VDNezLzJtXqE8mRyV+7WUvbU3HDGGZVlPMxW1oWUNMb
         yrWzHFQi+nCA34w0/I86L3yu09R4nKs3GHaRqGE86ppYLMtN+qedrx0cPXHHwoFY2Hij
         oQGZsSR9eFP3k+cw0aG8IywtV4ohKTwycRf72SAQRK/+qzW9iXcI4FqHsEFNPansXZUQ
         5rRQ==
X-Gm-Message-State: AOJu0Yz1St/bUmkO0o8SxiGGW80bFQjvdLAtT55xFAmuTaX4pABsxJH4
        2GYFVOuJY0IuKZqMJljdIokTuLbi8oNMETHELxVZMA==
X-Google-Smtp-Source: AGHT+IGo4cHPji84v4WFeNlDOJj9q+bNw4iXZJLO5ET/PfLNqakjeqLs52PznQY32TK3gNaQbQl17Q==
X-Received: by 2002:a17:90b:3a8c:b0:27d:dc9:be7a with SMTP id om12-20020a17090b3a8c00b0027d0dc9be7amr3379036pjb.7.1697858017472;
        Fri, 20 Oct 2023 20:13:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 63-20020a17090a09c500b00262eb0d141esm2333115pjo.28.2023.10.20.20.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 20:13:36 -0700 (PDT)
Message-ID: <653341e0.170a0220.32594.8f90@mx.google.com>
Date:   Fri, 20 Oct 2023 20:13:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc6-164-ga1b138ca64c6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 47 runs,
 2 regressions (v6.6-rc6-164-ga1b138ca64c6)
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

pm/testing baseline: 47 runs, 2 regressions (v6.6-rc6-164-ga1b138ca64c6)

Regressions Summary
-------------------

platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =

r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.6-rc6=
-164-ga1b138ca64c6/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.6-rc6-164-ga1b138ca64c6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a1b138ca64c60d10549cc4641488e75bf9554902 =



Test Regressions
---------------- =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
imx8mp-evk    | arm64 | lab-broonie   | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/653337a953ced7192befcfb2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc6-164-ga1b13=
8ca64c6/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc6-164-ga1b13=
8ca64c6/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/653337a953ced7192befcfbb
        failing since 38 days (last pass: pm-6.6-rc1-122-g07b618ec9d7a, fir=
st fail: v6.6-rc1-5-gb5eda4c9c923)

    2023-10-21T02:29:39.740582  + set<8>[   28.451450] <LAVA_SIGNAL_ENDRUN =
0_dmesg 183533_1.5.2.4.1>
    2023-10-21T02:29:39.741214   +x
    2023-10-21T02:29:39.849653  / # #
    2023-10-21T02:29:41.012642  export SHELL=3D/bin/sh
    2023-10-21T02:29:41.018721  #
    2023-10-21T02:29:42.512845  / # export SHELL=3D/bin/sh. /lava-183533/en=
vironment
    2023-10-21T02:29:42.518793  =

    2023-10-21T02:29:45.232952  / # . /lava-183533/environment/lava-183533/=
bin/lava-test-runner /lava-183533/1
    2023-10-21T02:29:45.239520  =

    2023-10-21T02:29:45.243431  / # /lava-183533/bin/lava-test-runner /lava=
-183533/1 =

    ... (11 line(s) more)  =

 =



platform      | arch  | lab           | compiler | defconfig | regressions
--------------+-------+---------------+----------+-----------+------------
r8a77960-ulcb | arm64 | lab-collabora | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6533379d53ced7192befcf95

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.6-rc6-164-ga1b13=
8ca64c6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.6-rc6-164-ga1b13=
8ca64c6/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6533379d53ced7192befcf9e
        failing since 93 days (last pass: pm-6.5-rc2-210-ga648a2d354da, fir=
st fail: v6.5-rc2-44-g6384f300e9f3)

    2023-10-21T02:34:03.380411  / # #

    2023-10-21T02:34:03.482735  export SHELL=3D/bin/sh

    2023-10-21T02:34:03.483500  #

    2023-10-21T02:34:03.584889  / # export SHELL=3D/bin/sh. /lava-11834548/=
environment

    2023-10-21T02:34:03.585651  =


    2023-10-21T02:34:03.687051  / # . /lava-11834548/environment/lava-11834=
548/bin/lava-test-runner /lava-11834548/1

    2023-10-21T02:34:03.688318  =


    2023-10-21T02:34:03.689431  / # /lava-11834548/bin/lava-test-runner /la=
va-11834548/1

    2023-10-21T02:34:03.754416  + export 'TESTRUN_ID=3D1_bootrr'

    2023-10-21T02:34:03.754600  + cd /lava-118345<8>[   19.265014] <LAVA_SI=
GNAL_STARTRUN 1_bootrr 11834548_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =20
