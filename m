Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD46C709CA7
	for <lists+linux-pm@lfdr.de>; Fri, 19 May 2023 18:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjESQqM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 May 2023 12:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjESQqM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 May 2023 12:46:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C3D2
        for <linux-pm@vger.kernel.org>; Fri, 19 May 2023 09:46:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d24136663so1398869b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 19 May 2023 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684514769; x=1687106769;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Fnc/qY1paOy/nrJCJwq3b7NFx+VGdz8mF7EmLC+CHU=;
        b=BZ7i46cy5/uq+AXcdE3wGxih0kvLLuT8fSg845sV7r0SCvwKciu5peR6ReOPSwrOHp
         qPxsICUcn1uJ00J0TjhIyG+q1mU+9f/mPK5fz0zuVh7jKX6i6IS5RHny0ASEPBIT7UyI
         spx45hJVaCHAVOCwOuyEkkEnfHlxAhWg7JJGEY/f95sqbapbYR8NP+j0j7L04IcCcY15
         CJkVROwudUWiA7AZXqHIdzYGc7QvfF0XgIwYc+/LbAyEAcPhixP81gi1fqBqM0Ly9JAU
         XqlNMOvubl6WHvpoKALBUDyb/oXy3g4QZfBIghHQdr+HmpiPGw8u3Qltv15jBLk3s/8g
         sr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684514769; x=1687106769;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Fnc/qY1paOy/nrJCJwq3b7NFx+VGdz8mF7EmLC+CHU=;
        b=SjL93QMXpJrPj8Tp65h5cO0eeJ0Gr6uN5vuUCDVLoHvkRPAXEhn0oePixKfPqeZKD7
         5znDTSG5AtzsToIt8VtKCmwVqlrz/nSfYN37GLGqGTObHkK5LatsT06btK30Obi5xJk1
         8X7BMt2gU6yBjpdeSZmoQToHRATB6yee6GfMB6H7pyPtYv1iXmEByUEQxtOFckgcETNh
         4bKoWyo/nfYv7kh8AZO7FovEKQOUr5YZCy3+1pGrDgV/Fv0/qeIsY2kpgyFchXuhydKt
         VAl68gYZKm3QAsaEsW2VsHcXcCH5FHP+EWrEoi/kglhp7LOdGFHgc4Ih+q3GM4i+INvo
         rVXQ==
X-Gm-Message-State: AC+VfDyyMI9jefjMYDGR+BHvoa/DJUVFy29OoklJ0Odyt9rr3dB7InVw
        sCN8QGGubHZF9tC7gbfhB2jipqVMfE3k6psb3658Yg==
X-Google-Smtp-Source: ACHHUZ4QOefGsYsQ631+iZwk5t+VXK+iK8+6VRoNclvXywwL/eicZDWFjwB2i0qh1YmqLMxL49TqMQ==
X-Received: by 2002:a05:6a20:d90b:b0:105:dafa:fec2 with SMTP id jd11-20020a056a20d90b00b00105dafafec2mr2229138pzb.53.1684514769590;
        Fri, 19 May 2023 09:46:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a31-20020a630b5f000000b005134fc049d7sm3230806pgl.31.2023.05.19.09.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 09:46:08 -0700 (PDT)
Message-ID: <6467a7d0.630a0220.d8829.5acd@mx.google.com>
Date:   Fri, 19 May 2023 09:46:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: acpi-6.4-rc3-14-gf677d4bc2b910
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 52 runs,
 3 regressions (acpi-6.4-rc3-14-gf677d4bc2b910)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 52 runs, 3 regressions (acpi-6.4-rc3-14-gf677d4bc2b910)

Regressions Summary
-------------------

platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig |=
 2          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-6.4=
-rc3-14-gf677d4bc2b910/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-6.4-rc3-14-gf677d4bc2b910
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      f677d4bc2b91058f37c5fea5c3bd7485db31f794 =



Test Regressions
---------------- =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
imx8mm-innocomm-wb15-evk | arm64 | lab-pengutronix | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/64679d9c6e5d1e7b6f2e86a1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-6.4-rc3-14-gf6=
77d4bc2b910/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm=
-wb15-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-6.4-rc3-14-gf6=
77d4bc2b910/arm64/defconfig/gcc-10/lab-pengutronix/baseline-imx8mm-innocomm=
-wb15-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64679d9c6e5d1e7b6f2e8=
6a2
        new failure (last pass: v6.4-rc2-7-g150ab364fade5) =

 =



platform                 | arch  | lab             | compiler | defconfig |=
 regressions
-------------------------+-------+-----------------+----------+-----------+=
------------
rk3399-rock-pi-4b        | arm64 | lab-collabora   | gcc-10   | defconfig |=
 2          =


  Details:     https://kernelci.org/test/plan/id/64679dcc973f8e13d32e85f3

  Results:     3 PASS, 3 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-6.4-rc3-14-gf6=
77d4bc2b910/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b=
.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-6.4-rc3-14-gf6=
77d4bc2b910/arm64/defconfig/gcc-10/lab-collabora/baseline-rk3399-rock-pi-4b=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/64679dcc973f8e1=
3d32e85fa
        failing since 4 days (last pass: v6.3-rc7-189-g704d7a52a540b, first=
 fail: v6.4-rc2)
        2 lines

    2023-05-19T16:03:00.939294  kern  :emerg : Internal error: Oops: 000000=
0096000006 [#1] PREEMPT SMP

    2023-05-19T16:03:00.939806  kern  :emerg : Code: 97fca110 f9405680 5286=
4a61 72a686c1 (b9400800) =


    2023-05-19T16:03:00.940145  <8>[   19.529590] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>

    2023-05-19T16:03:00.940460  + set +x

    2023-05-19T16:03:00.940768  <8>[   19.531462] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10391016_1.5.2.4.1>
   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/64679dcc973f8e1=
3d32e85fb
        failing since 4 days (last pass: v6.3-rc7-189-g704d7a52a540b, first=
 fail: v6.4-rc2)
        12 lines

    2023-05-19T16:03:00.911197  kern  :alert :   ISV =3D 0, ISS =3D 0x00000=
006

    2023-05-19T16:03:00.911715  kern  :alert :   CM =3D 0, WnR =3D 0

    2023-05-19T16:03:00.912088  kern  :alert : user pgtable: 4k pages, 48-b=
it VAs, pgdp=3D0000000078c65000

    2023-05-19T16:03:00.912382  kern  :alert : [0000000000000008] pgd=3D080=
0000078c6b003, p4d=3D0800000078c6b003, pud=3D080000007910e003, pmd=3D000000=
0000000000

    2023-05-19T16:03:00.912663  <8>[   19.503079] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D12>
   =

 =20
