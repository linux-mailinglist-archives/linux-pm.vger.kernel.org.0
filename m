Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1618576C0A
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jul 2022 07:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiGPFbl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jul 2022 01:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGPFbk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jul 2022 01:31:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC6642AFF
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 22:31:39 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso7974135pjo.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Jul 2022 22:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ufXQLgvxfQATp+6B9xk3/GngBY38LwvZE1w0CMC8btg=;
        b=7AF528bJ81mqzahl/zWOFg5bj4j5lgcC18NKdMKX9KFdCL9fllbTBIRF1xZWtossSp
         39nwSAxhJpMfmvmPEdPpOCZddJ5wuc4kQUhbzJYsnIY0rRnuICjQi7zIENWzeZ17KEYD
         Lqi2PHNofMR+QNBD0y5K9eU5WsWgpJBPHTRuOTfiYYj4ed1VZ0fUQ5mWDURdo0xcLAfS
         Aesu7YqCstqshWBnRz2xMwkL4xY33SGZYs//SFe9C8qBOIr3y5PUp/i7Uwtc4HcwXmk+
         +hlwA/VuwtuBI52JLVpTBk7HxtYN8sIuy+e2g7rm9S0Bs+UuqpOwsnbnJKexE50rLuv+
         JGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ufXQLgvxfQATp+6B9xk3/GngBY38LwvZE1w0CMC8btg=;
        b=vdXzomPxRNWOVnIJvzIzPsnWm5zwDVCcNjM1CEIh+fvKDu03mX7QgFxJXx2wzcwriF
         W2c8z1PnJT2mamdmVlT2APzPShWT16j3dMJ1Ujcl+uHhzG/FLZaBJeRwzI6q0Uiyc7hF
         GlzRM3Cvk60wGGX8g62XeSrpXD3dR5qqCJyTUoWg+yjG7e1FiPJWMSu6H7TDeIeV7N7T
         IK3lMCb9WrKGQQwCO6cnA4MthgGR+VtjKY1H76exqLVwJT/won9cazxm1xfJGc+lfAy8
         yiZlMdpGoWpmZPT4B5kM44+xY5yT2NCqnZBxBAAP24QN4s732aczfUikPiMz4BnZR5sc
         hQtQ==
X-Gm-Message-State: AJIora+8IQlzDC1ehOOA5Hb42WHfYG9gm0bvKNOVsBsiaVJ5sixuAcZy
        zJKuYBAXdRZJBT1wseqR3ffCfg==
X-Google-Smtp-Source: AGRyM1uC6u+AYENUusLTvjTF21t/2tBdPMzXu+Al0x8EYMzWLkfcH0iUZyLZkMJlkxQPwIrrg53EzQ==
X-Received: by 2002:a17:902:c411:b0:16c:28e3:c33d with SMTP id k17-20020a170902c41100b0016c28e3c33dmr17377724plk.126.1657949498729;
        Fri, 15 Jul 2022 22:31:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y184-20020a6264c1000000b00528d7d27211sm4919059pfb.178.2022.07.15.22.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 22:31:38 -0700 (PDT)
Message-ID: <62d24d3a.1c69fb81.6446b.824d@mx.google.com>
Date:   Fri, 15 Jul 2022 22:31:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: pm-5.19-rc7-63-g1b41824f2ecfc
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (pm-5.19-rc7-63-g1b41824f2ecfc)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (pm-5.19-rc7-63-g=
1b41824f2ecfc)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.19-rc7-63-g1b41824f2ecfc/

Tree: pm
Branch: testing
Git Describe: pm-5.19-rc7-63-g1b41824f2ecfc
Git Commit: 1b41824f2ecfca03c667d33921100965fe537722
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
