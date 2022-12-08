Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6564B64777F
	for <lists+linux-pm@lfdr.de>; Thu,  8 Dec 2022 21:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLHUso (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Dec 2022 15:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLHUsm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2022 15:48:42 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1385450A5
        for <linux-pm@vger.kernel.org>; Thu,  8 Dec 2022 12:48:40 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso5926155pjt.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Dec 2022 12:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xRiXkXIn1D4OIPWOOyfSvNStoYLvpRZSuQmUTNM0/r4=;
        b=bnpVDgsQITZ608FnP/h2uVlL6y/1pjU9kHo7ibY3KAe9SecpeXCSKuEvn34reQ76BT
         RoC1BApWOABHbla1twSWxA1fOQMWiQCVJQIPV7c5H6j80yR7EDGUzt3a2m98JbmKpnGt
         4soun2LVN8st2DMZYyFYFkY4RQ3XYCt3yl5FOfiai3XCErnuYj6ThrXueIOiDZI7mh9M
         8ysnQgK+g3hVgSemuWoYTPNOLCLctuypl+ysM1sdDB4skwk1NvZQ+R42HoxPob92IxwD
         cBCWDJyNe1xuaVlY+l5mDmjCu7OHmCOBG0l3aZ1LkIBlyJ9elmuiOuxEPg4un7U+hDrz
         KsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRiXkXIn1D4OIPWOOyfSvNStoYLvpRZSuQmUTNM0/r4=;
        b=eh/9bd8pEPvr8BEOazP9D8jST8hggyh131y6NRA3u7DxBfccxvgkm32kZYSug5x/j7
         E82pc4sU1O48ExcZEAwQGUqJLpbXqh5j6tD/kmJ/GPGVLMfU8Rrc/N68O5q3GCYbW0yJ
         K0Rj4v4Y6rI/Ji1ixNcxTskjVFS/RkmpHLyeEYfqpfQAz75dE/ogr4mpeFVgUd7k6Wik
         kNIJ4i+/F5zvIQ0rwoa160SxRDQsuiYXkfiafCC35BMw/V34C5FhdVtdLIp6FpvtIh5z
         NrYW2l/PThRlcOeLfvtnCklSXj3S1Kc+HF4gUs2e6x9iK8Q0VvWSp8Jr+t+GEi0XNvt3
         W8dQ==
X-Gm-Message-State: ANoB5pmCNMCCIq1Dxd0dWtpfkjuAdA/2Kcd1RBhrCRTuWz2zJK8wF5Oa
        tcDpVQs/VKfCxbTB2LK/O0LvwA==
X-Google-Smtp-Source: AA0mqf7QYam2+3EjuGQupKMZsm78MxVoAhKEcrb4leJccLY281gMHfQfoWm+XqK+tag8qZn+IIdykA==
X-Received: by 2002:a05:6a21:1084:b0:a7:8e19:e59d with SMTP id nl4-20020a056a21108400b000a78e19e59dmr3284892pzb.24.1670532520401;
        Thu, 08 Dec 2022 12:48:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w81-20020a627b54000000b0057255b7c8easm15728445pfc.33.2022.12.08.12.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 12:48:39 -0800 (PST)
Message-ID: <63924da7.620a0220.b38c4.fc87@mx.google.com>
Date:   Thu, 08 Dec 2022 12:48:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc8-176-gcb06e36a6532
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc8-176-gcb06e36a6532)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc8-176-gc=
b06e36a6532)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc8-176-gcb06e36a6532/

Tree: pm
Branch: testing
Git Describe: v6.1-rc8-176-gcb06e36a6532
Git Commit: cb06e36a6532c9040ad4118ca3857d6e96d30c40
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
