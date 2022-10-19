Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DF6604936
	for <lists+linux-pm@lfdr.de>; Wed, 19 Oct 2022 16:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiJSO2c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Oct 2022 10:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiJSO1r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2022 10:27:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AC119DD90
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 07:12:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o17-20020a17090aac1100b0020d98b0c0f4so98390pjq.4
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 07:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PgVmODZmFsiRPEkfBZLorZMtIv/xztHQaWuUE6+qnj8=;
        b=7SwTzUhn3peUm0SHvT1752xh+I113A92zeloflnYASXYNZaGPaESV3uPRWCzDbWhQb
         y1jSz5LQJYmxB6CWKL8Tej2zkVj2W11ga42+pTqGHPXU1MCDph+RqkTdNZWwL8dhLGXK
         A4FpTDbo6EYbMjLJVXI22Bri1KBnMpy/7pw3bdOoTLlcgS8AanD7V4D/sdgfH44SILmO
         x8iy9bt225pLnRiVxET/rUnaeWlCvlNrifnjVW5+gF+kPRxZVvWCZG/DfiZedsfS1l4J
         iG4VJr4FxzNkHnr4+2klcSkvAqK8fMDPCPoAP/AdrAnVLMd+gCGusgFq0D/hANMU5ND5
         Gn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgVmODZmFsiRPEkfBZLorZMtIv/xztHQaWuUE6+qnj8=;
        b=fNLbCwfSN+lwMa5VU8szLcLRxvK2LLd07S82SlNGbnWIZ7YP/XKW2tNBLERLw2YoqK
         DD2yRfqXBuFiI1Zi1gSyHmZzM7xSGhvnwI2B8n/DpKdYEo5VDc7aZdCJPtVHbsNZJqGf
         sulRCFeU2KB26cbC6j5pqTiTF2bKu/eHoTGIUfUP4rWV9znojSCW8Sdxk5bxaAjPrN72
         XYiay322PHY+yeSKA8c9Gp9ODQZVjbGB44ONvsjN6LXkvP1gEdEh0xZShQoNlTL7Rnem
         k1sS8rZat4hD17jeznhXaPgPD4Sz5ZVV+A+glQWwice1wEpVz2j/4MKs787XBm1OeC8P
         eMgA==
X-Gm-Message-State: ACrzQf3htObmkwneTjb4wX46ekVhcNgwBMc2d7IGCTKXdLe7XzvwQDZH
        uGhbkZTWGXnQUQTtbdklWN3xeLQHRPMPIoBI
X-Google-Smtp-Source: AMsMyM54P76/i3apgnu+gdALbc/04Ko1G2Gw1zkIzurbp6IIP44Gorcsc6mPtLeOT0AAncLrFol36A==
X-Received: by 2002:a17:902:f693:b0:17f:6974:cf90 with SMTP id l19-20020a170902f69300b0017f6974cf90mr8874771plg.62.1666188692011;
        Wed, 19 Oct 2022 07:11:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o125-20020a62cd83000000b00561c179e17dsm11412633pfg.76.2022.10.19.07.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:11:31 -0700 (PDT)
Message-ID: <63500593.620a0220.414c4.52f3@mx.google.com>
Date:   Wed, 19 Oct 2022 07:11:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc1-20-g1c24b2556ca7
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 1 failed, 7 passed, 1 error,
 5 warnings (v6.1-rc1-20-g1c24b2556ca7)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 1 failed, 7 passed, 1 error, 5 warnings (v6.1-r=
c1-20-g1c24b2556ca7)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc1-20-g1c24b2556ca7/

Tree: pm
Branch: testing
Git Describe: v6.1-rc1-20-g1c24b2556ca7
Git Commit: 1c24b2556ca732f37204db7e4ab5970ccef9196e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Build Failure Detected:

riscv:
    defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    defconfig (gcc-10): 1 error

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:

Errors summary:

    1    ERROR: modpost: "riscv_cbom_block_size" [arch/riscv/kvm/kvm.ko] un=
defined!

Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
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
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section mi=
smatches

Errors:
    ERROR: modpost: "riscv_cbom_block_size" [arch/riscv/kvm/kvm.ko] undefin=
ed!

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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
