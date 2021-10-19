Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A050A433F80
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 21:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhJST7N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 15:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhJST7N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 15:59:13 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E74C06161C
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 12:56:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d9so913205pfl.6
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xO1I/riTEvxQXc+p0ueLA/UBlgGCBk6cpJ8mfk1SWig=;
        b=YeYvu4Idfba1eKNH2Ibun5T7F22KJs6VrgNuXXtjAXQ4h4qwbw2PG2E1dkhxfMHcvz
         JQrBZ7YNSvICVNxiRNRvtU4nnvw2kjJuIYf4mn4RXqanENXhiFRllR58Q7c8rUDTqopi
         ondxw7YqjhlKptIPnOa8Ex9PgUD46kOUTDoWPOCzMiYDXQjFkamocUaiGtFMEwMoELCR
         8Xru1cEdyJATcPmYMG4w/y4BL50Pso38K7mYefNnDSXzFG81dEt802+lfFdYmyCkNJRV
         0cseBsKaPs1fJ3cPQvjaY18/RiyFIryBFR3FykGxGC5tLsS7dxnV18d/JQWtP5Bq+anF
         dHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xO1I/riTEvxQXc+p0ueLA/UBlgGCBk6cpJ8mfk1SWig=;
        b=3IREXy0q+oYDu6AfhI3GTr2VFLoO86VELmP8cS3uhHdkAvEcWHgJXxfx9s6X7q3NOF
         NbiB8Mgc0rlWd05AEYJn8fIO9+EKKBQm2+tSXJy8KgaI/hSHI31cvlQrSxJrrffJAn62
         wSqEzE460m8qAqKz1KjCFnjpV+aTft8VmXCBPEexmiFx1Agh0anS4mNK1WNHgVJnPYzE
         GKingsnhzm3ZcreZvQJHwsgob9wjW6m75VN7mYoBUlhn6XDlqtz/p3CFiIuTh966KfDg
         Jm1gDJljMI4/rYMYDq/N95GF60P3WJTKMoxxdL0cjE+Dr2m5lQTgfk2CPMsLnNk7OxNj
         r+Tg==
X-Gm-Message-State: AOAM5324cNz+0V0e+zICKR802g1iGZO+ptT1MAttmYef+d1u7qeFqqjx
        XPSsBk/s/tDl1NGRNJ1MNF+Zg1B7qaIHtcBL
X-Google-Smtp-Source: ABdhPJyO1TEpsoz9ODVumDgc4KqmqqTb7QU3+0muurdImzhxRSR0Jk4hBQk4JVhDepM6cgF9t48jCA==
X-Received: by 2002:a63:fe41:: with SMTP id x1mr30446445pgj.272.1634673419429;
        Tue, 19 Oct 2021 12:56:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t38sm58265pfg.102.2021.10.19.12.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 12:56:59 -0700 (PDT)
Message-ID: <616f230b.1c69fb81.9fc07.0457@mx.google.com>
Date:   Tue, 19 Oct 2021 12:56:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.15-rc6-60-g548e1842f9d7
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc6-60-g548e1842f9d7)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc6-60-g54=
8e1842f9d7)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc6-60-g548e1842f9d7/

Tree: pm
Branch: testing
Git Describe: v5.15-rc6-60-g548e1842f9d7
Git Commit: 548e1842f9d7cdeb2eda8f16ae9ae7502d0d4049
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
