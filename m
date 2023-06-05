Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC08372335D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jun 2023 00:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjFEWyJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Jun 2023 18:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjFEWyI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2023 18:54:08 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AAE98
        for <linux-pm@vger.kernel.org>; Mon,  5 Jun 2023 15:54:07 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-39a55e5cfc0so4949275b6e.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Jun 2023 15:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686005647; x=1688597647;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WsPMTcswNy4k7rfZLCLEN6RCgwuvg5FWm2ASvqcwXHQ=;
        b=QN2XqkPGrcQq9Sla0PVJWnhjXY3rm6RinhOCFerUWJhQFGndKEPOPi7br5HnFNgWjx
         O3GWJC5jrgCLJnNadHu7Mjip7zplp6exYdrvi0Aej0UkFLssro+nemNWYyEDqFyPy/e2
         RSRST/L7kJztP5AttR4PoySX0K9To3XjB3ENTxwfJkS6DLig2ho29HPtiH6kBRQsBgoQ
         yI5G84k06QMFfD3SrC5N6AmKMGbkd39/H8bACBOyW12HhN4bDsZN/rSAYSmUEi8uHuZe
         yqDuQ64s2hoGMnmKaUuGeh0Q45UxbzrWKq4ntKsgyy7fdBHMgZn12131xCvJ5jYIPh2p
         agug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686005647; x=1688597647;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsPMTcswNy4k7rfZLCLEN6RCgwuvg5FWm2ASvqcwXHQ=;
        b=j6JdbOGbKBGl2NmUYcjdEktTZufh0m5VsUnDgG1Sy+OOfKfIUYZPxD8pW2Bu6Pyo22
         oImPy9hZeD7frMu/i82Nql4h9iRmmE7cBQqmiYMTsuvf1j1B6jKq1hj1XR5sf/fW+qcl
         uIOiyQ06PN5rl6WQBKCaYG86MGC/JbFKidh87AS4ukfn7E0oQRAViD3iPDREq/YBLW1w
         Na3wbfAlxcvk7S/ZM4R2urr2OjG18DecGOsmyjsLgXUxqntZFkHRpVRIgg4TzFTorJCX
         CrgR6G5qIOQqeycZ6XgAmPGquoBuEjiHHzfZGkTGMmPAbPiHG2zd45CPvWYhoO0Tux7n
         yYRw==
X-Gm-Message-State: AC+VfDyCVojf8uOPDQqJWEcCN15DoK3zALoR5fV1xVTHbqWziHP3Yu9q
        2Jixie4NnpOsflZK5fqj/Tbua5uagnAoNvDXNT1jrg==
X-Google-Smtp-Source: ACHHUZ4TAjUSk54nZLKCEqYqDK2VuHe7jBpupXCRBYIaaN8VpulKX37JALJF1UGje4GvIdp0ksIvPQ==
X-Received: by 2002:a05:6808:919:b0:397:f6c7:c5b3 with SMTP id w25-20020a056808091900b00397f6c7c5b3mr59585oih.16.1686005646856;
        Mon, 05 Jun 2023 15:54:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a62be0d000000b0064b0326494asm5603662pff.150.2023.06.05.15.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 15:54:06 -0700 (PDT)
Message-ID: <647e678e.620a0220.de3d7.9d1a@mx.google.com>
Date:   Mon, 05 Jun 2023 15:54:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.4-rc5-28-geb13f81a5367
X-Kernelci-Report-Type: test
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing baseline: 37 runs,
 1 regressions (v6.4-rc5-28-geb13f81a5367)
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

pm/testing baseline: 37 runs, 1 regressions (v6.4-rc5-28-geb13f81a5367)

Regressions Summary
-------------------

platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
imx53-qsrb | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.4-rc5=
-28-geb13f81a5367/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.4-rc5-28-geb13f81a5367
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      eb13f81a53677b4a4d8e953f4d66145cf6b01cad =



Test Regressions
---------------- =



platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
imx53-qsrb | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/647e5bebe565ff0cc0f5de3d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc5-28-geb13f8=
1a5367/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc5-28-geb13f8=
1a5367/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/baseline-imx53-qsrb.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/647e5bebe565ff0cc0f5de46
        failing since 129 days (last pass: v6.1-rc8-156-g0a9e32afe717, firs=
t fail: acpi-6.2-rc6-146-g628c61874ffd)

    2023-06-05T22:04:04.019455  + set +x
    2023-06-05T22:04:04.019746  [   13.131441] <LAVA_SIGNAL_ENDRUN 0_dmesg =
968290_1.5.2.3.1>
    2023-06-05T22:04:04.127470  / # #
    2023-06-05T22:04:04.229029  export SHELL=3D/bin/sh
    2023-06-05T22:04:04.229563  #
    2023-06-05T22:04:04.330862  / # export SHELL=3D/bin/sh. /lava-968290/en=
vironment
    2023-06-05T22:04:04.331252  =

    2023-06-05T22:04:04.432471  / # . /lava-968290/environment/lava-968290/=
bin/lava-test-runner /lava-968290/1
    2023-06-05T22:04:04.433103  =

    2023-06-05T22:04:04.436724  / # /lava-968290/bin/lava-test-runner /lava=
-968290/1 =

    ... (12 line(s) more)  =

 =20
