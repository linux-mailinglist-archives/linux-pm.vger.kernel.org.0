Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA03255ACC3
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jun 2022 23:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbiFYVUX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Jun 2022 17:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiFYVUX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jun 2022 17:20:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D425514024
        for <linux-pm@vger.kernel.org>; Sat, 25 Jun 2022 14:20:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q18so4967915pld.13
        for <linux-pm@vger.kernel.org>; Sat, 25 Jun 2022 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=avhifSXVipzXEO0Tuo5+QTyJrG88QVVq66bQeQR3zHc=;
        b=dsuOEaGRAozEPdUQfSpyOD37385iTNh4DSWkOkCaVRby80cO5qyfNKav+6IUMG9vO3
         V96lo7+pAdE2xUlDzt4VahwChfEVweXCqsi7X1f68ZMXnJNpKBMNgnfLfuyp87Z7iwPs
         C0aU7+WSqqJxzxgGbAoaeBQYOqvUjJluD7S2Kc2+l2BuUx6v5tEmEojh5KdNfX+S2s1/
         qlt+Uh/rkMyWJFXmGTrddPbAmn5ymIZlT3TLuo30Kulejej3atzul1gChd6SQfFqDLGU
         1olRTG4z5czsjKgqyQ/P8J+f33HpXFObiK1oAr7zw9iPGARGZEGVCbWtCPR0kpGWjCwS
         8eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=avhifSXVipzXEO0Tuo5+QTyJrG88QVVq66bQeQR3zHc=;
        b=C2k9AoGSeLHc43MXHvYWmVniW3V18WrDez+/869iqiw0F/4vS7jPrboWNMkMpFxsgR
         fZ9kll9UqRggh5A36boATyiijEyIAlwrjzaIUyamsgNexLG5CEDKM1mMpqqR1yAUEBpV
         4qyRRsOhLHMmNBOmTL/3rn7RSu9kfWSGnxgJ+6rUfNXcxu2mFj+r119NrPFf9JBPXsZ4
         Qv3y54iBayakLRFYMtUw9TItg397uhDC7R1NjdKHTG68Ej1408eWIKYv9LfGsVA3d6ii
         f4UEeiX/lfnEafhwx22tc1W+k/sN8VnqJXQMxanCGZNMnOPo8OeBWhrTSKcihiF3yV9H
         QATg==
X-Gm-Message-State: AJIora8QW59JIzAB8kwsxcgffZmNIudiBzQU23bmSiVTO2Dg/QK9FIXT
        RiYQXm54jU7Yt5wuE3GUq7tqIg==
X-Google-Smtp-Source: AGRyM1v/iZzUaRcQJYpcYIzPGunleMJkZYGhGv6NEhECDyGgObbGdDqtAuhEntEK9q+uXGYPq54OkQ==
X-Received: by 2002:a17:90b:240e:b0:1e0:775b:f8fc with SMTP id nr14-20020a17090b240e00b001e0775bf8fcmr6525432pjb.132.1656192021357;
        Sat, 25 Jun 2022 14:20:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d40500b0016a13bd845csm4127485ple.165.2022.06.25.14.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 14:20:20 -0700 (PDT)
Message-ID: <62b77c14.1c69fb81.d6bcd.5c54@mx.google.com>
Date:   Sat, 25 Jun 2022 14:20:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: pm-5.19-rc4-25-g616372937415
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (pm-5.19-rc4-25-g616372937415)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (pm-5.19-rc4-25-g=
616372937415)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.19-rc4-25-g616372937415/

Tree: pm
Branch: testing
Git Describe: pm-5.19-rc4-25-g616372937415
Git Commit: 616372937415f1ba2165bfbb0831d318572d9eae
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
