Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FF468CF2B
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 06:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBGFyz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 00:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBGFyy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 00:54:54 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCF4DBF6
        for <linux-pm@vger.kernel.org>; Mon,  6 Feb 2023 21:54:53 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id f15-20020a17090ac28f00b00230a32f0c9eso6223378pjt.4
        for <linux-pm@vger.kernel.org>; Mon, 06 Feb 2023 21:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l09oKm/qyymSUulZB5ZKboBcXuXF8JnLrqDoDR8Ba/c=;
        b=imla90iv6FmULbPznCWK2NW/tijsSgyyOupxJtoWBqQ+uqU6BChkKkdHZF2tEY41MY
         d93un66Ttv24cqiRRPRaHxHuRwXZi9Jf2n5COwwxZ7AAI4vCCC7p/92J/1e/5k8S4zN7
         YK8A3yWUTwoXS9oldlKSwalRoULa2Z8vVLHNkScTVlJQs6TThVVJSnqQ//MBQDMGm1uB
         zl9ettnzOYPWaIwwgGuVcBUJ/MCjFQgjvDBXjwrq5jgKssTChP3XAYqkT4xsmKCNa9jb
         lKEtDLUK10bjPWR/tiN0ulCKCELJ14z0ejdRCe9pNSqc0T0BoG+pwDLA/47F9zfDXiYN
         89KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l09oKm/qyymSUulZB5ZKboBcXuXF8JnLrqDoDR8Ba/c=;
        b=2CEXPtK4rW/UTqspZz9OSVT3WNFqEyiJJbSX3UVJBSUPm5T4KZ1BtOOeTiG3t3SM7e
         HWp2iufJD3ABMpNmtMAdCC5MExzYgxM6cdPEliTtSrEL5esJSUtWcFKuXjS7m38Ux2HM
         E1Zs+oZR2xHxVZngvd8Uwy6bpXLFFHwdS+GfwxFSGuHZjUvk7DBZ4twIDUbyFTTuIsH4
         oVW7PrD3vdV7rpPSanXvTNlrQhEVfwTuEPnRyOa86IW+N92Jc6hD8fNU8a5wJXhFKDuI
         TCcg6cMdt14SX5q7/i1PnjHukB5rJBJ0SMrdZSh0T3UVd2bEjw6VgSWP3MLFb42tZFJZ
         QIhQ==
X-Gm-Message-State: AO0yUKXVAcKBpEut8nYYu3UfomLPjHiIO8fU6xqFHSp58s+/8GxvqaFb
        fsFD0RahbMqU8xC/Yhfjv2ZuMA==
X-Google-Smtp-Source: AK7set/OBZlUsz++lEEk4vAQ4kJnowvAmR6AjmMIuqh9f3v6URSKv1FE3xh6EEtNC+ugp6prdpYapg==
X-Received: by 2002:a17:903:138b:b0:196:76ca:fbce with SMTP id jx11-20020a170903138b00b0019676cafbcemr1257423plb.53.1675749292983;
        Mon, 06 Feb 2023 21:54:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902cf1100b00198a1d5a7cdsm7935084plg.78.2023.02.06.21.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 21:54:52 -0800 (PST)
Message-ID: <63e1e7ac.170a0220.b9de0.d6a4@mx.google.com>
Date:   Mon, 06 Feb 2023 21:54:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.2-rc7-179-g929367dbdffe
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc7-179-g929367dbdffe)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc7-179-g9=
29367dbdffe)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc7-179-g929367dbdffe/

Tree: pm
Branch: testing
Git Describe: v6.2-rc7-179-g929367dbdffe
Git Commit: 929367dbdffe4babaaa4710344c3988dd9e90e51
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


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
