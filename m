Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0744A31CD90
	for <lists+linux-pm@lfdr.de>; Tue, 16 Feb 2021 17:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhBPQI2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Feb 2021 11:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhBPQI0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2021 11:08:26 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70FFC061756
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 08:07:45 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id my11so8685pjb.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Feb 2021 08:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=slQ1piw6bzMTSVjr5Hc+XsCD+RtdXeNdGN/pX1+QrYk=;
        b=GxAQACuEp5zZ4zg8urLb/kQAJtbJfLTFvZG8By9Y3FrRRM4csB4w6OZWTL69IQgFX0
         7/iHHSkWrojLa0Qnfu2TOx9QVVhryg9xmDnDP8PlEpjg80+scphpMvozHktLNvENHI5K
         IVzJQGXFZPoAO/x3+tANUwhExkYN4UMMTEPGxIsp5aOk6u1F0obkVEJQIuVlWjPbMeMO
         6HVZULgaa1p7IPvP0qtvu26i1rssg79KD3qkh+pUkgBjT1hD1caAkBJA1nSkha2JAviQ
         5O4QfOVw4ALKoWQvURlimV+C7ESANDeis0ZK/BcnV23yLJMBqdXj/DAmk6a5VVAtxb/t
         91sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=slQ1piw6bzMTSVjr5Hc+XsCD+RtdXeNdGN/pX1+QrYk=;
        b=NrgDlut/sidanVL5utN+j/RAyy3zBh4qeykO9qVjKd/OfeVpNIvXuwFieeoWl1AlpW
         7fEiYY4p3yj4zUHg/w+SyXzWJm746BuXujxq1RdUYAa3JSTPZzSxa4k/HPqlg+wgSaVS
         R/NJ+PBnm008WprkZkIvoYbPISIFrU5bH6tZZ7e7J2M1lJ5KML77GtNq23MJjqtUNrUg
         uuSreS90rzpYdhmwhIcidSmS7mwRo3VQ/XxgDqp6radGvw8QeOlTCVP35af0zO/XY9xO
         qW7iZEqr9PdnbSbvKsw6xMLSttFXEBDuxOMVV+1mumv6eKePvG1Kj9iYLdEjkFkwd6Z0
         qncQ==
X-Gm-Message-State: AOAM531LDrvxBvOB7NAohdbZ9ssKMShCggM4nPaXO93oOOOs2gqWXVd7
        UXMB7bmClYbbtfLT8TQVBE+r+w==
X-Google-Smtp-Source: ABdhPJxqiAQ+DyDvBfVljtiieo4BtW8U0Lz9LB3anQcMPaFxm3rC7S55IdWxKNdw1qPB9YpaHcCXpg==
X-Received: by 2002:a17:902:8687:b029:e1:601e:bd29 with SMTP id g7-20020a1709028687b02900e1601ebd29mr20462458plo.47.1613491665302;
        Tue, 16 Feb 2021 08:07:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z11sm3149043pjn.5.2021.02.16.08.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 08:07:44 -0800 (PST)
Message-ID: <602bedd0.1c69fb81.e4b26.6f24@mx.google.com>
Date:   Tue, 16 Feb 2021 08:07:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: pm-5.11-rc8-155-g606a19484587
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 59 runs,
 3 regressions (pm-5.11-rc8-155-g606a19484587)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 59 runs, 3 regressions (pm-5.11-rc8-155-g606a19484587)

Regressions Summary
-------------------

platform                 | arch  | lab          | compiler | defconfig     =
     | regressions
-------------------------+-------+--------------+----------+---------------=
-----+------------
imx6q-var-dt6customboard | arm   | lab-baylibre | gcc-8    | multi_v7_defco=
nfig | 2          =

meson-gxm-q200           | arm64 | lab-baylibre | gcc-8    | defconfig     =
     | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/pm-5.11-=
rc8-155-g606a19484587/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: pm-5.11-rc8-155-g606a19484587
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      606a1948458764ff9a1ffa47a3d68749b9b93041 =



Test Regressions
---------------- =



platform                 | arch  | lab          | compiler | defconfig     =
     | regressions
-------------------------+-------+--------------+----------+---------------=
-----+------------
imx6q-var-dt6customboard | arm   | lab-baylibre | gcc-8    | multi_v7_defco=
nfig | 2          =


  Details:     https://kernelci.org/test/plan/id/602be3761230348ea1addcb1

  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.11-rc8-155-g60=
6a19484587/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-imx6q-var-dt6=
customboard.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.11-rc8-155-g60=
6a19484587/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-imx6q-var-dt6=
customboard.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/602be3761230348=
ea1addcb5
        new failure (last pass: pm-5.11-rc8-133-g5352de4c92b3a)
        4 lines

    2021-02-16 15:23:04.155000+00:00  kern  :alert : Unhandled fault: align=
ment exception (0x001) at 0xcec60217
    2021-02-16 15:23:04.156000+00:00  kern  :alert : pgd =3D (ptrval)
    2021-02-16 15:23:04.158000+00:00  kern  :alert : [<8>[   38.907168] <LA=
VA_SIGNAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASURE=
MENT=3D4>
    2021-02-16 15:23:04.158000+00:00  cec60217] *pgd=3D1ec1141e(bad)   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/602be3761230348=
ea1addcb6
        new failure (last pass: pm-5.11-rc8-133-g5352de4c92b3a)
        26 lines

    2021-02-16 15:23:04.214000+00:00  kern  :emerg : Process kworker/3:2 (p=
id: 81, stack limit =3D 0x(ptrval))
    2021-02-16 15:23:04.215000+00:00  kern  :emerg : Stack: (0xc3497eb0 to<=
8>[   38.954819] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Demerg RESULT=3Dfail U=
NITS=3Dlines MEASUREMENT=3D26>
    2021-02-16 15:23:04.216000+00:00   0xc3498000)
    2021-02-16 15:23:04.216000+00:00  kern  :emerg : 7ea0<8>[   38.965994] =
<LAVA_SIGNAL_ENDRUN 0_dmesg 731144_1.5.2.4.1>
    2021-02-16 15:23:04.216000+00:00  :                                    =
 1e9b10fe e4901ab2 c3496000 cec60217   =

 =



platform                 | arch  | lab          | compiler | defconfig     =
     | regressions
-------------------------+-------+--------------+----------+---------------=
-----+------------
meson-gxm-q200           | arm64 | lab-baylibre | gcc-8    | defconfig     =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/602be4a39e4ad390beaddcb6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/pm-5.11-rc8-155-g60=
6a19484587/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/pm-5.11-rc8-155-g60=
6a19484587/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/602be4a39e4ad390beadd=
cb7
        new failure (last pass: pm-5.11-rc8-133-g5352de4c92b3a) =

 =20
