Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AB3708B9E
	for <lists+linux-pm@lfdr.de>; Fri, 19 May 2023 00:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjERWdA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 May 2023 18:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjERWc7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 May 2023 18:32:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69067E5F
        for <linux-pm@vger.kernel.org>; Thu, 18 May 2023 15:32:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so19214295ad.3
        for <linux-pm@vger.kernel.org>; Thu, 18 May 2023 15:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684449178; x=1687041178;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y81dxSurzr/6BJOX+enk54MuXqHcM390d6nqFQydEdk=;
        b=qYaV6LDeQAcgZCKK6LU206GvoxZqThHgIEhi7IXp5PczZQgwf/CroFJwLO24ynJlUO
         T9m7zUrHUPWe+oBw3QE26OrPwqA1x9gM1CopbNscXqEXtrsYWN5R8mhpeM3nYahRScYz
         vVZqpOy8AP11WXO9aLtiFASvrKhfoHYzJ5M+UAFxZZiaCuuUPik2kRwCVOy4cvwPerIF
         L6aIfhB9oMcZ8pFPpwMh6hVHHxSrMkmB0QoasALyXvf/MBSon0qL6YAkdtlq89zPSvHp
         TJFXciRx924PbY3efVtaB/J9okxoeG0OokiP56v/lHvIBSkywuLbEnl0nDBkrUHGSxR8
         /F8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684449178; x=1687041178;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y81dxSurzr/6BJOX+enk54MuXqHcM390d6nqFQydEdk=;
        b=Ioc9QcIjgDAh0rswY7cJxULdvl+E4s3PmNDh5e2eDjxT2rCw2K1CVm53jnKLDK92nX
         BSvUPafBLZjqWEGjk954Zd6QeqUvPKqgBGI4T7rU2EThyxdhmTmS/BfSAvJPL9Y/YiQk
         a+d8bSHHgd+aEHWPMkc/ZiqlMZnrAqdfzYLzuYtpjC6ElhX2P6XRL7bGHvfF8YAyXwaQ
         PUBryyyubGRMJ5l0sx6xfuLpRdWcIVN+rlZOIZoUU2lsvr/gJlWJ6y/+Pi3mAOnasYfb
         1FBxHKvuc54dkkOB7YCFIEVuhlDPQcwr/qvxkgUUhTy9nDsELMMB+Rw5HXCdYucDI6bu
         ZmPg==
X-Gm-Message-State: AC+VfDxjRvHmY0N6zYANgA564paNMvBZc/yz2AJaoyEfDwYjDQzHGU39
        7Jb8j6u0v5zpeQY3x9bxJ8cEyQ==
X-Google-Smtp-Source: ACHHUZ6rSUHHPJk2TvrCCMzhpxt8/YHqvKhwUWZjiwgdlmPQnz8JCRUOR9wcB6ew6KiJncKN+FSssA==
X-Received: by 2002:a17:903:1d1:b0:1ac:8837:de9 with SMTP id e17-20020a17090301d100b001ac88370de9mr820564plh.3.1684449177894;
        Thu, 18 May 2023 15:32:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ja19-20020a170902efd300b001a6ff7bd4d9sm1996229plb.15.2023.05.18.15.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:32:57 -0700 (PDT)
Message-ID: <6466a799.170a0220.5d5c8.3b9c@mx.google.com>
Date:   Thu, 18 May 2023 15:32:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.4-rc2-7-g150ab364fade5
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 51 runs,
 2 regressions (v6.4-rc2-7-g150ab364fade5)
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

pm/testing baseline: 51 runs, 2 regressions (v6.4-rc2-7-g150ab364fade5)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
rk3399-rock-pi-4b | arm64 | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v6.4-rc2=
-7-g150ab364fade5/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v6.4-rc2-7-g150ab364fade5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      150ab364fade572a52bfef4cb6526b441cbce352 =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
rk3399-rock-pi-4b | arm64 | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/64669a1de00008a4442e8665

  Results:     3 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/v6.4-rc2-7-g150ab36=
4fade5/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v6.4-rc2-7-g150ab36=
4fade5/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/64669a1de00008a=
4442e866c
        failing since 3 days (last pass: v6.3-rc7-189-g704d7a52a540b, first=
 fail: v6.4-rc2)
        2 lines

    2023-05-18T21:35:07.889778  kern  :emerg : Code: 97f81510 f9405680 5286=
4a61 72a686c1 (b9400800) =


    2023-05-18T21:35:07.890226  <8>[   22.083200] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>

    2023-05-18T21:35:07.890573  + set +x

    2023-05-18T21:35:07.890896  <8>[   22.085875] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10379517_1.5.2.4.1>
   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/64669a1de00008a=
4442e866d
        failing since 3 days (last pass: v6.3-rc7-189-g704d7a52a540b, first=
 fail: v6.4-rc2)
        12 lines

    2023-05-18T21:35:07.846857  kern  :alert :   ISV =3D 0, ISS =3D 0x00000=
006

    2023-05-18T21:35:07.846948  kern  :alert :   CM =3D 0, WnR =3D 0

    2023-05-18T21:35:07.847020  kern  :alert : user pgtable: 4k pages, 48-b=
it VAs, pgdp=3D0000000078de1000

    2023-05-18T21:35:07.847087  kern  :alert : [0000000000000008] pgd=3D080=
00000790b2003, p4d=3D08000000790b2003, pud=3D08000000790b4003, pmd=3D000000=
0000000000

    2023-05-18T21:35:07.847152  <8>[   22.061026] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D12>

    2023-05-18T21:35:07.847246  kern  :emerg : Internal error: Oops: 000000=
0096000006 [#1] PREEMPT SMP
   =

 =20
