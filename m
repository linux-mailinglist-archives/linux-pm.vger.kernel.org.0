Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEAE425E86
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 23:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhJGVVJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 17:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhJGVVJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 17:21:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BDBC061570
        for <linux-pm@vger.kernel.org>; Thu,  7 Oct 2021 14:19:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n2so4722652plk.12
        for <linux-pm@vger.kernel.org>; Thu, 07 Oct 2021 14:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=KixwJ9LOPu1ph9bL2gX/WFMglwp8fxr3VUm04GIPuGg=;
        b=jZL9vwU+kw4euWHX1Z60nlk7eOhOTvKrcntdPdZmWZ3McPkZVJXbhd4hi6EZFk09i8
         0qyX/0uEsGMQkqAmxivpgDo4FElEn8iAelIRIS8MchSa66+EutHO2E0sRYnaz5Np11Ts
         st1fcHSdcbrV6cJgeWOg4hB986ei+rpbumQ4S/hNc01iSqqCVRWf1q0EPpFcz3ImG9gt
         W2/e630tEp+eb/nfiSk2+qvbxUXknPgRVZt75TKlr98XC/xaqEbsye/pXmo0BePODeAT
         h9ELZzhQHsuU+0xYcKG4BIEH3O0Sxuj7VdCt7sardoEacV936O0oLVYBMN+6GNuAUAqy
         cL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=KixwJ9LOPu1ph9bL2gX/WFMglwp8fxr3VUm04GIPuGg=;
        b=k5vf2qLBSvTwFiKr765QD3V1J5vheaas0I4nx4u+XuqoxthtSJzkSobR+pPG1XqGl3
         J+ef/fBkwUPWoxX6ckt86+NZVwVBIbEEDKWZgpq0zW478f+MrvgZLjh78HPXT4ZDV5gG
         ETM584pPkX6N4Efdd9iP1PuBe+qViJKVoRW6UBP0Ci+c7xXmtELFxL8MhFTVuKQTP8e2
         ANrmifpkM8ZCj52VGH8FAJA0CcmUC3M98c66Lo2Hqcq4Bca7zFkNGnMnECBpk9O4Uz30
         yTc1/H+MwMepBDJKzbjZiKkHIw7ZWGURfxDOyVFqZMLaVchuT2l0qQrVwUe2r+roWLpF
         YNpw==
X-Gm-Message-State: AOAM531o1678EI9XufJSNnM+WGvs6wG9CVgZJgGxo/TFFwKTu4nQqcIs
        iLaXMDdmEOYv/4QMytXH6dM/sg==
X-Google-Smtp-Source: ABdhPJxiOxb6/Oa8UA4qvCGHmEF0nYYNDpDPNCkE/BrLDAFxQmLd7vJUIJrjLtokt+rOh2FVGPxWFA==
X-Received: by 2002:a17:902:e9cc:b0:13e:8b79:6216 with SMTP id 12-20020a170902e9cc00b0013e8b796216mr6125405plk.74.1633641552719;
        Thu, 07 Oct 2021 14:19:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n66sm346356pfd.21.2021.10.07.14.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:19:12 -0700 (PDT)
Message-ID: <615f6450.1c69fb81.9a58f.17fb@mx.google.com>
Date:   Thu, 07 Oct 2021 14:19:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc4-42-g574167bf7ed8
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc4-42-g574167bf7ed8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc4-42-g57=
4167bf7ed8)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc4-42-g574167bf7ed8/

Tree: pm
Branch: testing
Git Describe: v5.15-rc4-42-g574167bf7ed8
Git Commit: 574167bf7ed8e12be9710fc84442c5e23775f75d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

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
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
