Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109334C374E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 22:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiBXVBL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 16:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiBXVBL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 16:01:11 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4625D2399ED
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 13:00:40 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so3065167pjb.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 13:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/VzKl2GJWyQ52BAWkSuQDh7SjIkojgpmUWyew8njn4M=;
        b=YqM5SL2WBxc8w8VuY23YuYPfqVPFm45wTXFQDCRDDFLL4epnrNsbLCvDjvSwRjUiJU
         OGgp2QNzZsqxskkR878WmXKe3Uelm+fB/gny0n/9yNE1WPmgdVJMxx3fxMoYAKK1C9TE
         rLVgoHBycDagKSJgY6xo1yhFApEFMF6/ilG67iJDeo6Gz7OYZtxqGLnL3+jap5+CvarA
         +LAp8vFsSyawh1UdzNXrlBS+GV4GIHXRgelvQyBpvfi8xs0BR6RlnDECS1n/Vz2chT0s
         +SH0h+Py3ptz/Km+j8oBXr75b0KJTYdFN5hl8lNTo9NR3tSLHY5GW1atI7N+Uww9FHnY
         jFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/VzKl2GJWyQ52BAWkSuQDh7SjIkojgpmUWyew8njn4M=;
        b=qi6z7AKVEgdupke5jS5IheMlCfxz83sH9Kp1ZbzfMXmEbiGpOLXLELa1tXMtAfGP2+
         FZ+AeckkFKKgI4Xyr5y98GQw97SD15qfKNpbBlYE6zb9Cobp7Gflr1CrhUs6gnEl5SE9
         u8P7x24Fa5CYWJ0Jf/1tuOreuSgrGU3E+Fk1hRYQNL4WCOznDPr9NRLj7r+Owd5DlZIT
         12XUkeU7x29qYp6sisI6qJGB8geXNdWT4b7rVH6Yzie5I+0A6gn/TxciuSMoanG9wEHv
         JUbIa8KTnswhA3MR5pmnLZu8A29Z1H9owoFNa1vBLi/20LLqfvXXOh9AxRdaZZgo6wxs
         0LSg==
X-Gm-Message-State: AOAM533tVNqm0LFyZRWhCDATTNrnRBUH2cKX9Y0WlZoU/IfC0+VAsvKG
        d2BAKx511t2p9hlQxt8ovGTttw==
X-Google-Smtp-Source: ABdhPJyHnKV4hrvkZoyMcVqr2tRMA347R780bvwXdOTuihMtOStPZzBNHTKSPgLMYP64Q4c02xNl9g==
X-Received: by 2002:a17:902:c105:b0:14f:c977:f718 with SMTP id 5-20020a170902c10500b0014fc977f718mr4124097pli.48.1645736439747;
        Thu, 24 Feb 2022 13:00:39 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u19-20020a056a00159300b004e1590f88c1sm346048pfk.220.2022.02.24.13.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 13:00:39 -0800 (PST)
Message-ID: <6217f1f7.1c69fb81.793cf.1888@mx.google.com>
Date:   Thu, 24 Feb 2022 13:00:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc5-57-gfc4232749306
Subject: pm/testing build: 7 builds: 1 failed, 6 passed, 9 errors,
 1 warning (v5.17-rc5-57-gfc4232749306)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 1 failed, 6 passed, 9 errors, 1 warning (v5.17-=
rc5-57-gfc4232749306)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc5-57-gfc4232749306/

Tree: pm
Branch: testing
Git Describe: v5.17-rc5-57-gfc4232749306
Git Commit: fc4232749306d2fb9341c4c6d17c489ab657a67e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Build Failure Detected:

i386:
    i386_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:

arm:

i386:
    i386_defconfig (gcc-10): 9 errors

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:

Errors summary:

    1    arch/x86/include/asm/pci_x86.h:97:8: error: unknown type name =E2=
=80=98raw_spinlock_t=E2=80=99
    1    arch/x86/include/asm/pci_x86.h:174:40: error: expected =E2=80=98=
=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=
=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98pci_mmconfig_add=E2=
=80=99
    1    arch/x86/include/asm/pci_x86.h:167:20: error: expected =E2=80=98=
=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=
=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98pci_mmcfg_arch_free=
=E2=80=99
    1    arch/x86/include/asm/pci_x86.h:166:19: error: expected =E2=80=98=
=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=
=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98pci_mmcfg_arch_init=
=E2=80=99
    1    arch/x86/include/asm/pci_x86.h:146:19: error: expected =E2=80=98=
=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=
=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98pcibios_init=E2=80=
=99
    1    arch/x86/include/asm/pci_x86.h:145:20: error: expected =E2=80=98=
=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=
=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98pcibios_irq_init=E2=
=80=99
    1    arch/x86/include/asm/pci_x86.h:138:19: error: expected =E2=80=98=
=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=
=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98pci_acpi_init=E2=80=
=99
    1    arch/x86/include/asm/pci_x86.h:134:20: error: expected =E2=80=98=
=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=
=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98dmi_check_skip_isa_a=
lign=E2=80=99
    1    arch/x86/include/asm/pci_x86.h:133:20: error: expected =E2=80=98=
=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=
=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98dmi_check_pciprobe=
=E2=80=99

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
i386_defconfig (i386, gcc-10) =E2=80=94 FAIL, 9 errors, 0 warnings, 0 secti=
on mismatches

Errors:
    arch/x86/include/asm/pci_x86.h:97:8: error: unknown type name =E2=80=98=
raw_spinlock_t=E2=80=99
    arch/x86/include/asm/pci_x86.h:133:20: error: expected =E2=80=98=3D=E2=
=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =
=E2=80=98__attribute__=E2=80=99 before =E2=80=98dmi_check_pciprobe=E2=80=99
    arch/x86/include/asm/pci_x86.h:134:20: error: expected =E2=80=98=3D=E2=
=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =
=E2=80=98__attribute__=E2=80=99 before =E2=80=98dmi_check_skip_isa_align=E2=
=80=99
    arch/x86/include/asm/pci_x86.h:138:19: error: expected =E2=80=98=3D=E2=
=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =
=E2=80=98__attribute__=E2=80=99 before =E2=80=98pci_acpi_init=E2=80=99
    arch/x86/include/asm/pci_x86.h:145:20: error: expected =E2=80=98=3D=E2=
=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =
=E2=80=98__attribute__=E2=80=99 before =E2=80=98pcibios_irq_init=E2=80=99
    arch/x86/include/asm/pci_x86.h:146:19: error: expected =E2=80=98=3D=E2=
=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =
=E2=80=98__attribute__=E2=80=99 before =E2=80=98pcibios_init=E2=80=99
    arch/x86/include/asm/pci_x86.h:166:19: error: expected =E2=80=98=3D=E2=
=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =
=E2=80=98__attribute__=E2=80=99 before =E2=80=98pci_mmcfg_arch_init=E2=80=
=99
    arch/x86/include/asm/pci_x86.h:167:20: error: expected =E2=80=98=3D=E2=
=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =
=E2=80=98__attribute__=E2=80=99 before =E2=80=98pci_mmcfg_arch_free=E2=80=
=99
    arch/x86/include/asm/pci_x86.h:174:40: error: expected =E2=80=98=3D=E2=
=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =
=E2=80=98__attribute__=E2=80=99 before =E2=80=98pci_mmconfig_add=E2=80=99

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
