Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC2C486C12
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jan 2022 22:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244369AbiAFVpI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jan 2022 16:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244268AbiAFVpI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jan 2022 16:45:08 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C84C061245
        for <linux-pm@vger.kernel.org>; Thu,  6 Jan 2022 13:45:07 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id z30so235952pge.4
        for <linux-pm@vger.kernel.org>; Thu, 06 Jan 2022 13:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VX3mIDIkdqQ8VpapDA1BFJtm8lw/XhGYrl73131cKII=;
        b=DxApNcVR7wXnssZM8ls9cVSjdiB4stijxljvkVTQ8IpDvjilflyUUyyQRr12GaDrGX
         F+rbiScl+tIlXTmE0bzsBVMbItjNSLfTmbt5Uu1kyEyMF8ezkxHZKEkUUdo9WaK69qI4
         svokQx3hxUgW9pado2LF38eN0eexmKPh/vWi1r/tbCj1p83enAy+IsAep3QJx7URWuF8
         IFBytOTfESb1BNRlsYLUxkKqyaim+vx8d4rUAJzTuwganb/VYh+It7HcWxOc0NOA2DR1
         PnY/lTRzUkALrCKkWjhwa3VSLE07fiIurSZ/1DmUrmkgvexRhWD9APUHeoyiKALYgWKv
         HP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VX3mIDIkdqQ8VpapDA1BFJtm8lw/XhGYrl73131cKII=;
        b=w4O5qNiazX07aUb2oIVj+MUypRH7qu4AV699y4XPRq/86TG1k7+8ut1YRhaUto6Yx0
         mKgV5pv1VUX/bh7tE2U0pBDjK6/NPlFq69nDcdl61adThw1983LzVX8KoojFDEX/zc4R
         rYXTPUOC4loc4E1eO4Dl50Zca9MLeb5tX0Q7w8QH0vJ++X2iJBpL/OXO2NK+r8j1ROL1
         NW3QR8Jv1VgSoa72WzBYTuBZMGeC8n7koW6B2wKG6+LbixbFqGILqcWQmF35/3Vk2XfM
         PSCQTzuFiAnaSJwIzIIyKzqpxf6rGFCMhBACEK1M6DBgOtClSCDgRQ4NcvmNAwcXWxLu
         KCsQ==
X-Gm-Message-State: AOAM533QWvoLze++n1/GXYH2zfiAyaL3UTesz4LlzLLLsBsa2begM5OA
        ZwrjQjBD2TiN5cd+S17KGRZJOjSxwB8YeHG8
X-Google-Smtp-Source: ABdhPJzE2EmiFWef/JM/+920afIorQnVpXcmgWodA2bI5nIGiHS2/ycEEr08K708DXFnGW8xkw7SEg==
X-Received: by 2002:a63:36c1:: with SMTP id d184mr44862035pga.102.1641505507443;
        Thu, 06 Jan 2022 13:45:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h22sm3378264pfv.1.2022.01.06.13.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:45:07 -0800 (PST)
Message-ID: <61d762e3.1c69fb81.6a9a4.8b0e@mx.google.com>
Date:   Thu, 06 Jan 2022 13:45:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.16-rc8-171-gf099fd60c342
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc8-171-gf099fd60c342)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc8-171-gf=
099fd60c342)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc8-171-gf099fd60c342/

Tree: pm
Branch: testing
Git Describe: v5.16-rc8-171-gf099fd60c342
Git Commit: f099fd60c342d8d8265202ce01b4375358913072
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
