Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6647739941A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 21:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhFBUAg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 16:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhFBUAg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 16:00:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB8DC06174A
        for <linux-pm@vger.kernel.org>; Wed,  2 Jun 2021 12:58:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id i22so2302263pju.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=AWGkFiA39zs4C1QplHjpj6gZQx8JZokmyTJrmsX/QnA=;
        b=JtNv9My+aM4lSZthyprX00QZcfSl5WQW4stfMHuTS1E4JRz/fvyVYpsn9srAWEGUbh
         FRempec7X8rU9HGhZvRqCpGT3NX+zuk2vtbX/Kp/vQnKUmu7eWPGULrcQui0hHi4qrRr
         xLC1gvUlHyUYHkR2QPwPo/9mXsFWUysxQhpYqR+nVT/UoYYYd3+c2tCnUQhvKeAxo1nU
         +o382SgvD44x5doRbDcKrUfWP6dWc1Opq4EhCz0GsJlphaq5LP8ifGbkTOSIrUZO/b10
         jGJu3c8LxhN4TFrCeFoEkrZt0KlEgkFGqUxGKmqmq71uSMY2GjhTDSegrwhts9Zc9h40
         5PCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=AWGkFiA39zs4C1QplHjpj6gZQx8JZokmyTJrmsX/QnA=;
        b=ZxSpIHaqFXy1ukBf2nHVsoVVCQWfS1kyWCo02fzZoIiTW1k9cmnSYW5BCS0voEjuUw
         qpogxqiPxOV1Fv1xcME8KudoBfCgorCciol7X4+H1aINgdRELJ9O552+XGO1q6mnLfHQ
         AVOh0ztjrkimJJEPYtS/aDQDxgBZbi37aWU+dtfuXYMCp46EQYWkEoJRfU173tXBLSVh
         FvcZhbzzId9LcJUFF3m5jOOxUtqiSi+NVw+5AGW/6HpnfA0zoPNMxz6D1xB0Q53choLn
         F64FAQ7vtIxlG44HKnPQK9ZpQYmEyOYtp1jkQflvwALH27uX/y/h/vc6bp47IS04GncU
         Rx/Q==
X-Gm-Message-State: AOAM532JiuRwCWEL1vgvVvS2ETpfOuJdGCDdFvsee2GlR27Sa6+kWis3
        eKt5xQ1luqIV56+MlGG/8Ru8Gw==
X-Google-Smtp-Source: ABdhPJwxtg1IUsq/3a/gp6xIk7FUz4Uri4wXVP/2hPT/VWuHyAaWoaC3l1W/OXUYOxPCCpz++5wZSA==
X-Received: by 2002:a17:902:8ecc:b029:ef:6471:dc08 with SMTP id x12-20020a1709028eccb02900ef6471dc08mr32273308plo.5.1622663923039;
        Wed, 02 Jun 2021 12:58:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j2sm277998pji.34.2021.06.02.12.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:58:42 -0700 (PDT)
Message-ID: <60b7e2f2.1c69fb81.d63f3.1299@mx.google.com>
Date:   Wed, 02 Jun 2021 12:58:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Kernel: acpi-5.13-rc5-42-ga25ea0c642c2
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: test
Subject: pm/testing baseline: 79 runs,
 1 regressions (acpi-5.13-rc5-42-ga25ea0c642c2)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing baseline: 79 runs, 1 regressions (acpi-5.13-rc5-42-ga25ea0c642c2)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/pm/branch/testing/kernel/acpi-5.1=
3-rc5-42-ga25ea0c642c2/plan/baseline/

  Test:     baseline
  Tree:     pm
  Branch:   testing
  Describe: acpi-5.13-rc5-42-ga25ea0c642c2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm=
.git
  SHA:      a25ea0c642c2fa68ced9d7e9cfc85ed4ea470deb =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig | regres=
sions
---------------------+-------+--------------+----------+-----------+-------=
-----
hifive-unleashed-a00 | riscv | lab-baylibre | gcc-8    | defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/60b7d618ac9bb79518b3afbf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (riscv64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//pm/testing/acpi-5.13-rc5-42-ga=
25ea0c642c2/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a0=
0.txt
  HTML log:    https://storage.kernelci.org//pm/testing/acpi-5.13-rc5-42-ga=
25ea0c642c2/riscv/defconfig/gcc-8/lab-baylibre/baseline-hifive-unleashed-a0=
0.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/riscv/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60b7d618ac9bb79518b3a=
fc0
        failing since 188 days (last pass: pm-5.10-rc4-33-g52d108cd060d, fi=
rst fail: pm-5.10-rc6-75-g735f7fba25ec) =

 =20
