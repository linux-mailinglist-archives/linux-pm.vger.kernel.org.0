Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE0D45B1D1
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 03:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbhKXCNg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 21:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbhKXCNc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 21:13:32 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5C8C061574
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 18:10:23 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id np3so1127553pjb.4
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 18:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+C4qmPrMSxtWstuLX2jfIVQDuK3KmBwkOx4UKk/idm0=;
        b=xxwUY0LF3/kNpgOBWUyFg1akfeq9Z59W/wKS9iq3P6IAM+KaMeyPr8chTiJ2tomffp
         O4t8ti2iTKuMwZOy077HqXSFwhp+OFkkVmMBfP/tsM6PuEqxJruYqUuFdkx91f+30/5m
         I0NS6os1Y8h0GfQ3dLhEQnTiVUB/euEc5P0gawnDndQAR+XWs1NNF7i+h54+xK52O5n/
         VZ9ohW4dYHdmwnTbMb0U9XFofEtJ1f2Omk3AmO0aVqwwvJJl3qACTtrGBZObOUp576fA
         5cXC0znvC+fNpFN6OHmTRKnBoDpN8SJpk5BhhFfqGf3N266ljf+eBYI7N1kE1HEREhJ0
         bMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+C4qmPrMSxtWstuLX2jfIVQDuK3KmBwkOx4UKk/idm0=;
        b=KeIXPtAl9AXVXX2G9cJ9YsbK7BkQ74hWb+5LixiJHk1r+2XcG4rj/Ysq9hIHBUvO1w
         gU2BMkQyfW/uADF0rhN7Vf8AKKsUbyzktlCgCteMm0m5KOqeyvhPA+RoRIhWG7Kjvjut
         89jNjOUhrcPKrT734GDbx+Ft0PMQksk5t6r9lGr3XlJfD8CJz2F+MDpP8tdEi6pCgRyY
         mYeUZNwNvAjck2VH8SIm96oH96P6xFA11B9AR9ZXVkXzZ4AG91DS0KoRFBAj938j8Dnd
         9D7K4Y+VA/IB91DSlpLVNgDEAQi5WSMU29kx/5W+LoKEAeehjukJJ3ceqD9CdZiL8dSi
         cnFg==
X-Gm-Message-State: AOAM5323/sZFveHo/L66aPkY8YpJSL7neKnoj2OZBGstou/9s+8TVN70
        Vz6QsGaJobLQlQgzA5AMaNbaGg==
X-Google-Smtp-Source: ABdhPJw6tXPYRQSC7Si7Ae6a59m3/3CWURXykz2/K35awS9vDbFxWNgojoHL2XIsH0ynUIfZWbOhXg==
X-Received: by 2002:a17:902:8d85:b0:142:892d:bfa with SMTP id v5-20020a1709028d8500b00142892d0bfamr13010388plo.76.1637719823482;
        Tue, 23 Nov 2021 18:10:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l21sm14486232pfu.213.2021.11.23.18.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 18:10:23 -0800 (PST)
Message-ID: <619d9f0f.1c69fb81.43aa.8d33@mx.google.com>
Date:   Tue, 23 Nov 2021 18:10:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.16-rc2-12-gf9efc61a2f28
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 6 builds: 0 failed, 6 passed,
 1 warning (v5.16-rc2-12-gf9efc61a2f28)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed, 1 warning (v5.16-rc2-12-gf9=
efc61a2f28)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc2-12-gf9efc61a2f28/

Tree: pm
Branch: testing
Git Describe: v5.16-rc2-12-gf9efc61a2f28
Git Commit: f9efc61a2f28fa650741ece02d2c2d1901e519c5
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm64:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:


Warnings summary:

    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
