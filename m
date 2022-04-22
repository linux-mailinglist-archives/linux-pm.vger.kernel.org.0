Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B4050BE94
	for <lists+linux-pm@lfdr.de>; Fri, 22 Apr 2022 19:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiDVR3q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Apr 2022 13:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiDVR3l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2022 13:29:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A15BE9D4
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2022 10:26:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b15so8614729pfm.5
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2022 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ytepwVz9feX+eauigx5Qr9cdulgHrvxDTe79XrfHxQ0=;
        b=MedPESmUeXmutJJDJCmlGbBifjv1dy6JIgfRwjt43oXNUwL+397fUdCWmKje/bnM6Y
         e8SsGsxmLaYkrHxICnJfbIBQ+M1F4pIShkyZV4u0sTkNbIYJOfqq/f+9bXxn8HcbPzrT
         sTtfiqZ9tWir7dhqFus3/8X63ntIqzB7Hy8FwaQqvotfo6SZ68GgXBEfnFUnQ6B3JSfk
         70D8B14cHvuXQdwdKUEGaMq47SOXAwEEDiAE8Op8S4fWAOYBdtsQflZV6q02liBapATL
         sfXTSLH1UA7Csj4j6dabVsHaT2+9TsQwk/Hcw5jEwPYfqNwghL/1xLXCcEnLgxAtWSF+
         ppgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ytepwVz9feX+eauigx5Qr9cdulgHrvxDTe79XrfHxQ0=;
        b=kyaY9NG0mPMHNUni7aR6GAaNOso1Sc2bXzH0WLFZYgjKgSt7aTW8wvwS+wsYZahYSh
         kd/h+qB9GaRo4h9pxuABDiMfrr1gUEeKkjWcK3GS7XA3x4NMIfQkU8vffCB16PNvT3wW
         yZvLKYLLN305k++eqYGsvkF5ijUaTE/Ueb7C3Sxlq9GlGDHPy9WPcSgSzGeAxzGHtQAK
         pTV0kvrvNCK3/DYEWLOOV5ihxc7I/3slE2UzrNzLaX7z2XWAiZfnf8Yf5kj0VUBI9G4a
         pcIaKiAm8ozMtUtvi0DFrnyoq5yB2QBc8G78x0svU8jikm3VuesOhc2Xm78THZ6zXYsH
         9jGQ==
X-Gm-Message-State: AOAM530GaMvUW3RlpS/CA+G5MHSg4Dv71dbzG9x6pSmpOkBVdWsMjexT
        WGLsloDa/nYrr416DUmRsJqBkg==
X-Google-Smtp-Source: ABdhPJyiQqXeUWdxig2zut3t+OUcwPj4m6/WKHy2AEKHIeLwrVwrOvfGwJarcexdX/Z6e6lbZ0MmXw==
X-Received: by 2002:a05:6a00:16c7:b0:4f7:e497:69b8 with SMTP id l7-20020a056a0016c700b004f7e49769b8mr6036752pfc.6.1650648248116;
        Fri, 22 Apr 2022 10:24:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 5-20020a631045000000b0039d942d18f0sm2649483pgq.48.2022.04.22.10.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:24:07 -0700 (PDT)
Message-ID: <6262e4b7.1c69fb81.f0642.6b9c@mx.google.com>
Date:   Fri, 22 Apr 2022 10:24:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.18-rc3-93-gc15e061fb0ab
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.18-rc3-93-gc15e061fb0ab)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.18-rc3-93-gc1=
5e061fb0ab)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
18-rc3-93-gc15e061fb0ab/

Tree: pm
Branch: testing
Git Describe: v5.18-rc3-93-gc15e061fb0ab
Git Commit: c15e061fb0abc59bfd50b710deb61b4329392a3f
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
