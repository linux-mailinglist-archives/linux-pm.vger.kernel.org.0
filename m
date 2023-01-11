Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF136665AE
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jan 2023 22:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbjAKVhy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Jan 2023 16:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbjAKVhs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2023 16:37:48 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A9F3F44B
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2023 13:37:47 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id a184so12411615pfa.9
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2023 13:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bVaFMzNKf8Lxejsh7BV26sOjxFDGZNEixsNn+JLv/pY=;
        b=bJziFMhRtM0FdIVwCtFNWqo+j01RSRo7tHkuPtoEqfNO0kFb0FPL8NdQtREuQ5OiH9
         yw5C15JY5ApujcUD9cNPfLjJM9i7IHWRzL4fwnW/81v+PIGUMS0Q99cdD6Wphkw9CRbD
         KW+t2yTmNNBrjGb6oLE+bp+F0AGdIob8IElCfyner/DrDXZ2IZzoxR4d4Kol5BN+p8GR
         /QrOYkHTd5sydijrUuOYDlFBpDa8rvwN0osxRRdL87znPpJH2GjNTaGU0nssXd9nqDPw
         QmEG+YnpIH5xr/5Jvqo55CML8mPy+PHxo6hR7qhyV/UfFfwp/YkBT5giOImrXgLOEx+3
         /yyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVaFMzNKf8Lxejsh7BV26sOjxFDGZNEixsNn+JLv/pY=;
        b=Wcd+ezjS7DDQd6k1zJZ/1I1oukaLFE7iPIO8+tw1xF6sTQBSGFJl9i7Ituvh9IqNLI
         NQvq5HOPrTVmR3IZ/AEYL85bqsdKdbjK3ESuSqZcO5ixX16zXfqZhjo+Kjemb5DBnN5C
         xbcLxREWgk25yLNh2JMWm3D4B6x2oECDre+7pY+MwmHPFHW67j6BsWZGI76Og+gapA6a
         49IJCf218ZJul6lPIdvlt+fJ/De+eL3zpikr9jxgkqcP1uhjoBjWvwkJIJWXVmM9YP84
         /eqYgZXG/CjIy8Le5mXSAlTH5QcxxA2doJXcR40NQt/S/G3Qx324PojZhlNZFieeVdq2
         kL6w==
X-Gm-Message-State: AFqh2kqyn8YvoJbdBH231ehulAIzuCUq8PFL/nddHhlWAfLAgs8d0n66
        Hncn1+qkfiLI7oOPALmuQeT7IA==
X-Google-Smtp-Source: AMrXdXvpsFjoAE+Z7XbJgnAfQcxebbnEkCeXEeUwYdeiDatCEhde/rLRDrAlwdBvL8Mr0/Br73efIg==
X-Received: by 2002:aa7:9143:0:b0:580:cfbd:3fd3 with SMTP id 3-20020aa79143000000b00580cfbd3fd3mr68116335pfi.26.1673473066604;
        Wed, 11 Jan 2023 13:37:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i11-20020aa796eb000000b00576df4543d4sm10364889pfq.166.2023.01.11.13.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 13:37:46 -0800 (PST)
Message-ID: <63bf2c2a.a70a0220.e5016.18f9@mx.google.com>
Date:   Wed, 11 Jan 2023 13:37:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.2-rc3-79-g837dc62247d5
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 53 runs,
 1 regressions (v6.2-rc3-79-g837dc62247d5)
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

pm/testing baseline: 53 runs, 1 regressions (v6.2-rc3-79-g837dc62247d5)

Regressions Summary
-------------------

platform         | arch | lab             | compiler | defconfig          |=
 regressions
-----------------+------+-----------------+----------+--------------------+=
------------
imx6dl-riotboard | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.2-rc3=
-79-g837dc62247d5/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.2-rc3-79-g837dc62247d5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      837dc62247d5e50a0724af2001f070962300c87e =



Test Regressions
---------------- =



platform         | arch | lab             | compiler | defconfig          |=
 regressions
-----------------+------+-----------------+----------+--------------------+=
------------
imx6dl-riotboard | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/63bf25416741837f011d39c2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.2-rc3-79-g837dc6=
2247d5/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotbo=
ard.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.2-rc3-79-g837dc6=
2247d5/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx6dl-riotbo=
ard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63bf25416741837f011d39c7
        new failure (last pass: v6.2-rc3-50-g4f0d85674885)

    2023-01-11T21:07:59.599254  + set[   14.978961] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 877504_1.5.2.3.1>
    2023-01-11T21:07:59.599561   +x
    2023-01-11T21:07:59.705581  / # #
    2023-01-11T21:07:59.807354  export SHELL=3D/bin/sh
    2023-01-11T21:07:59.807877  #
    2023-01-11T21:07:59.909075  / # export SHELL=3D/bin/sh. /lava-877504/en=
vironment
    2023-01-11T21:07:59.909615  =

    2023-01-11T21:08:00.010978  / # . /lava-877504/environment/lava-877504/=
bin/lava-test-runner /lava-877504/1
    2023-01-11T21:08:00.011659  =

    2023-01-11T21:08:00.015006  / # /lava-877504/bin/lava-test-runner /lava=
-877504/1 =

    ... (11 line(s) more)  =

 =20
