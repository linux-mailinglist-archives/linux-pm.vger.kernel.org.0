Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE854804C6
	for <lists+linux-pm@lfdr.de>; Mon, 27 Dec 2021 22:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhL0VQE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Dec 2021 16:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhL0VQD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Dec 2021 16:16:03 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFF2C061401
        for <linux-pm@vger.kernel.org>; Mon, 27 Dec 2021 13:16:03 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id h1so8938561pls.11
        for <linux-pm@vger.kernel.org>; Mon, 27 Dec 2021 13:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Frzr3aXePT9v9LqKT5/n4+BGp+CAACBvbGIvPyliUNg=;
        b=W3zx13dK/kldmD3cnvDk9PrZmOMT3g/FbVSOXpWytnUSKmOsvflytlWT+5ZjDazNca
         Eg7joZc57n5pfzFgJRCOCv0nULMftwzvuUQaksFCxXEyZL+JBWoyeVtPma0QJHYjrS2t
         Lh6xc4TqNpM0N2lRQYpLZTD9RcJgJtIjKLRcqp0CA8dO/Ngb/toAXuNZBAcTKyLqhFiU
         wiWSDOdTg+d5zfGekHfoqcYQrgNSouWc7g8rGR2UDFaSqXLhxtFqr/b77iOpHIsT62as
         yRCUjtc2Du2SiG7AW+Ihwdwm4sCd6Fh6c+MTewPSL/AETZ368g0RJsa+bkdHi5voPU0K
         3UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Frzr3aXePT9v9LqKT5/n4+BGp+CAACBvbGIvPyliUNg=;
        b=yiagVvwLzFLMtLZr0EEPe/Cms54sSSYHSdf6WMJCCXjDJAfoW20p0vJisnzDjY18DV
         HqFbUm0YGnxcQDwI7hEAD+H/w1t8pGKeIsEkTN4kCVbcCUPMA0lGL4mIPFfVx2noxB6c
         c6UMCnRMDBn0S9kxKjSMssB3/S1RweU6iR4TxFSF/FTLcaSlhFYGGjyubEKjZL8b2ZFk
         57U207JbUB4VpRY86ZvzwksjV/CRNbPvFTcWRwt4m04lskB9akVewutdFgdc0VBUzKj+
         HIGvaUB/Y4e3h6es9CPtXl/RhFErNwxTaVno/pWNG4Q7JaD9cJo6vj6T/DOQ1jy2PBZq
         ASNw==
X-Gm-Message-State: AOAM533evYFJBXXzhYOKLJTYK7KOyNtHVIACFupP+vRkVGEstuPf4avL
        cljG6O27fcGhKNOlb3YE6UzJBdwxJ7N7lIb9
X-Google-Smtp-Source: ABdhPJyB43NWli+2j2syDBomoZ9s3TZm0/I2PDGrgsSjAoKlme8/9/koFmTJkPGRo07AFMltzt9Uig==
X-Received: by 2002:a17:90b:384f:: with SMTP id nl15mr12049448pjb.91.1640639763243;
        Mon, 27 Dec 2021 13:16:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n13sm9394273pfa.197.2021.12.27.13.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 13:16:03 -0800 (PST)
Message-ID: <61ca2d13.1c69fb81.28849.b3be@mx.google.com>
Date:   Mon, 27 Dec 2021 13:16:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.16-rc7-85-g16448069b96c
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc7-85-g16448069b96c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc7-85-g16=
448069b96c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc7-85-g16448069b96c/

Tree: pm
Branch: testing
Git Describe: v5.16-rc7-85-g16448069b96c
Git Commit: 16448069b96c511c9ac06af8b9975b8f2b1f37ca
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

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
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
