Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE4537B302
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 02:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhELA2T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 May 2021 20:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhELA2S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 May 2021 20:28:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7370C061574
        for <linux-pm@vger.kernel.org>; Tue, 11 May 2021 17:27:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so2343162pjv.1
        for <linux-pm@vger.kernel.org>; Tue, 11 May 2021 17:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=k0nrnq5wGQpT5RbOqeUGlmz8n50VR91Mh2135Q2j21Q=;
        b=ulH6xW5V1NptBugNCDz0AgE6ON4/jaWSsGwciC4TGZNW/LiSyj2ku3v/Y8iGJMlG6Q
         9mnuyialar2VUK5HzkfoQ6EIAasBA22/6mQUHJEAmoxalY6U0xteC77GBAZ07xWaOD+C
         R6RAni65wXT73pUJcUX4OKfwiFSrAdORXHqscPIlZ2qN4vyAC6MS8SRCP4+6tII39wIM
         FvWWYJNcRfP8T+rqBhZvq0G5Ner+Xf0VCOFN9ArI3UBo9LwtzReNWNx1jscQNNpjim5o
         w34tddEJQoH3x6xDk2Q2aNBGnjrzUG5d9YAAMrCzQcqno9crIEqVds/AAisazWcQKqsd
         7cpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=k0nrnq5wGQpT5RbOqeUGlmz8n50VR91Mh2135Q2j21Q=;
        b=aSbRPAZG5rNkO/FpCKnq2KhnkzQp+X0LLc05TRbsQnEonfzQdoGDpNU/sfxXLuFF0M
         SPCNQP8ehAH1alJHiWbaAHrGXUCAF0EBzmvUHvlAupId7IgAOVxBxRUpjkmmQi/7cPjF
         3rYtL+H1QlTgDt2nxRsDtg9iMvSp5vnKgrlU4Z4AVLIN56IKUxUX+rc4tqrEtsuuRu6c
         2ev1rAjn1GCR6zJmukOR5E/NQaXzw2RYkd8188p986bQqjgBqRY19BbKCehQ1GI2qlUV
         RvBqZXODEZUdZDY9U7d+DgH3729WLlxkuLoqVukwyZnEhHGvRCnU/jQ+jp3Vv58Q3vZD
         H8Sg==
X-Gm-Message-State: AOAM5325o+c47++vgE6CBCB7z/tVnNcdIhI9ZzOfTPHTN3BnDLvBWm67
        ZxSTLMgSMtueQhLEU5bmiaxOkQ==
X-Google-Smtp-Source: ABdhPJwBZHHAqHLLF16IHym+9dv0K2c9QMMft/md/rleDbFQS7jIKZ1RnDKSqlYLGhyxCW9aVP+tZA==
X-Received: by 2002:a17:90a:2802:: with SMTP id e2mr7679935pjd.29.1620779231413;
        Tue, 11 May 2021 17:27:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a16sm14511186pfa.95.2021.05.11.17.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 17:27:11 -0700 (PDT)
Message-ID: <609b20df.1c69fb81.6678d.d1d9@mx.google.com>
Date:   Tue, 11 May 2021 17:27:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.13-rc1-9-gcb7accda3e01f
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 109 runs,
 3 regressions (v5.13-rc1-9-gcb7accda3e01f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 109 runs, 3 regressions (v5.13-rc1-9-gcb7accda3e01f)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 2          =

imx8mp-evk      | arm64 | lab-nxp      | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
1-9-gcb7accda3e01f/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc1-9-gcb7accda3e01f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      cb7accda3e01f71abfb7a987f8733e8c2d2d911d =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
bcm2837-rpi-3-b | arm64 | lab-baylibre | gcc-8    | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/609b16bee1b7c0f1a0d08f48

  Results:     3 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc1-9-gcb7acc=
da3e01f/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc1-9-gcb7acc=
da3e01f/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.dmesg.alert: https://kernelci.org/test/case/id/609b16bee1b7c0f=
1a0d08f4e
        failing since 1 day (last pass: v5.12-rc8-168-g3c44d15e5ffdb, first=
 fail: v5.13-rc1-4-gdc9d574fa82fc)
        11 lines

    2021-05-11 23:43:42.016000+00:00  kern  :alert : Mem abort in[   21.676=
561] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines=
 MEASUREMENT=3D11>
    2021-05-11 23:43:42.017000+00:00  fo:
    2021-05-11 23:43:42.017000+00:00  kern  :alert :   ESR =3D 0x96000006   =


  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/609b16bee1b7c0f=
1a0d08f4f
        failing since 1 day (last pass: v5.12-rc8-168-g3c44d15e5ffdb, first=
 fail: v5.13-rc1-4-gdc9d574fa82fc)
        2 lines

    2021-05-11 23:43:42.021000+00:00  kern  :alert :   SET =3D 0, FnV =3D 0
    2021-05-11 23:43:42.022000+00:00  kern  :alert :   EA =3D 0, S1PTW =3D 0
    2021-05-11 23:43:42.023000+00:00  kern  :alert : Data abort info:
    2021-05-11 23:43:42.023000+00:00  kern  :alert :   ISV =3D 0, ISS =3D 0=
x00000006
    2021-05-11 23:43:42.058000+00:00  kern  :alert :   CM =3D 0, WnR =3D 0
    2021-05-11 23:43:42.060000+00:00  kern  :alert : user pgtable: 4k pages=
, 48-bit VAs, pgdp=3D000000003a42b000
    2021-05-11 23:43:42.060000+00:00  ker[   21.716465] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>   =

 =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
imx8mp-evk      | arm64 | lab-nxp      | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/609b187d12f8a56b4ed08f41

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc1-9-gcb7acc=
da3e01f/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc1-9-gcb7acc=
da3e01f/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/609b187d12f8a56b4ed08=
f42
        new failure (last pass: v5.13-rc1-4-gdc9d574fa82fc) =

 =20
