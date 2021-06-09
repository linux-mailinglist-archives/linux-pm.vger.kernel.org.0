Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F41A3A1AD2
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 18:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhFIQY1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 12:24:27 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:40659 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFIQY0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 12:24:26 -0400
Received: by mail-pl1-f177.google.com with SMTP id e7so12793489plj.7
        for <linux-pm@vger.kernel.org>; Wed, 09 Jun 2021 09:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=jy5SHNQxUR7dVxxbnO07w7Wu3+o6vk2H1xR4FTbm+bM=;
        b=1tvkhTLaT4D8edVTjhAusjSigRPQXp74iN/XmHxXPzxzyD8cIHFaU43Io8o5KCRqIH
         RY4URtHxp6zNrGb0ZLqN+jZBCZokHg7mQ6AjovHeTuBC+Q3g/VaE2YB5oMQizOdczSvA
         KosFhmrlkmJ3cZM71bf/y/Pg01s/cpBbkJ1GGiY3olJUx9wMOel1vazjovgv381s0Mg1
         MUMrViNlVRsDm8DdqQCGwC6U07ofHQZmgoCdO0si4yFwqsB+otx74k4kq31ONKa6dlYD
         YFaARhMl1CpOKK+UjwwbEHPtvg0sio4ZPXn51HQLiBqyqo3byUp5lVGqAwRXYhyPKl3s
         HGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=jy5SHNQxUR7dVxxbnO07w7Wu3+o6vk2H1xR4FTbm+bM=;
        b=LLy0dWtCoPSy9NHMIy8yVA7P3+qf/cPZEBrIAg02fC5sRkSogpcfDuItnF7NUYSchp
         5pdrUd5XZs0bGd9lYrbPJqns4lCBCwNZpLv51X/NfrosR+R9+KB4gLx08rEMBz6brVdr
         X+U/+u2V78hQVdYrhzpxOZW3K0EXAXFQiTTwdFFllenohXPvuh55zPnTSK5p4rkUFcDD
         RCkMINjv1AbK6QFYLM3RVToxP+6GD8npfWaxII1qvrvFqt/Dkn8EMHAVjn3qGVQxPgFV
         blN0ClNX1LB7mJbzE9IggwifZMW8F9BRARUQk7vsX2cPHHlhj9s0+M7Jy8peOQd9f2QB
         O2uQ==
X-Gm-Message-State: AOAM533h7M4uLL3dMXotR6noby2hQ8689F2HZfel1pSQSqNDNvSPu57p
        +1TCErIJTtiEUxD81rzIFT+E+yAjpm1MEO1f
X-Google-Smtp-Source: ABdhPJwvII3d0qrwFNla5Nbm6KXxUO3s5P0X+GrSgXUnAK0lbE/pcVgfWO5Cb+Y2Z49PmeCv1HwtZQ==
X-Received: by 2002:a17:90a:4b0d:: with SMTP id g13mr316550pjh.77.1623255677070;
        Wed, 09 Jun 2021 09:21:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a20sm101416pfk.145.2021.06.09.09.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:21:16 -0700 (PDT)
Message-ID: <60c0ea7c.1c69fb81.3a92.05a6@mx.google.com>
Date:   Wed, 09 Jun 2021 09:21:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.13-rc5-97-g6d0b2a5677ed
X-Kernelci-Report-Type: test
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing baseline: 109 runs,
 2 regressions (v5.13-rc5-97-g6d0b2a5677ed)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 109 runs, 2 regressions (v5.13-rc5-97-g6d0b2a5677ed)

Regressions Summary
-------------------

platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
imx8mp-evk      | arm64 | lab-nxp      | gcc-8    | defconfig | 1          =

meson-gxbb-p200 | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/v5.13-rc=
5-97-g6d0b2a5677ed/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: v5.13-rc5-97-g6d0b2a5677ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      6d0b2a5677ed15cfa1b6ebe8206ddc621d078190 =



Test Regressions
---------------- =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
imx8mp-evk      | arm64 | lab-nxp      | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60c0e0d07179cb3c170c0e14

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc5-97-g6d0b2=
a5677ed/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc5-97-g6d0b2=
a5677ed/arm64/defconfig/gcc-8/lab-nxp/baseline-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c0e0d07179cb3c170c0=
e15
        failing since 2 days (last pass: acpi-5.13-rc5-42-ga25ea0c642c2, fi=
rst fail: v5.13-rc5-37-gfcbef3bdf3a8) =

 =



platform        | arch  | lab          | compiler | defconfig | regressions
----------------+-------+--------------+----------+-----------+------------
meson-gxbb-p200 | arm64 | lab-baylibre | gcc-8    | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60c0e14fe06f9c91810c0e0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/v5.13-rc5-97-g6d0b2=
a5677ed/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxbb-p200.txt
  HTML log:    https://storage.kernelci.org//pm/testing/v5.13-rc5-97-g6d0b2=
a5677ed/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxbb-p200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c0e14fe06f9c91810c0=
e0c
        new failure (last pass: v5.13-rc5-37-gfcbef3bdf3a8) =

 =20
