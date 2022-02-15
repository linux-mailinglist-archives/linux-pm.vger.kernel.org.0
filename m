Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327754B5FFB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Feb 2022 02:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiBOB0H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Feb 2022 20:26:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiBOB0H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Feb 2022 20:26:07 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10781106CAB
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 17:25:56 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id l19so26423379pfu.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 17:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ocQqnZ1NswPN2ounoNUde7K3VTDZRZLzeJ0DD0XRPf8=;
        b=CliyXr3sjPreaSMnJT69IXTTU4m+vZPnJXG0y1bsbKdAViyRdMaeXGXkDXkPgs3RYo
         GWvDn24RIrdislBF+r58SIMGcNApsbXCgB6ARM/2hixOn+3h7tRBfYZmrIX6PtUtDGSx
         JHE3QT60hUWW8SHQXtXQTxbQ2onAZtESeaxNWsQxaz5AQX0WprdboyKoo2XncUVwJZzO
         kUS3quNdbIO/r2XpvldmLOrWcB3hly4w72f60qNh0c553u4GLRd0gO+P7c0aQW4Z2nRZ
         EqmesyLZG4heHX226piiqX9w/hNdKntGLbVNYMV7KfDAnbRty1cH+gXNqyo8EkEfb87d
         1nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ocQqnZ1NswPN2ounoNUde7K3VTDZRZLzeJ0DD0XRPf8=;
        b=AAWTDJjNVm+5Nce3PcZ0beP0ObGeLUd+dd8h2a2vqqolWwJeiWuXsSsCfghriBZTIv
         7ot4BFMWqa9TIwB05kRH2vnSkUGn0Kfq1OHJd48fZ/DuMK1t9onYjWCmXcZA8ERxm8Vw
         IgkyJj1fUjTeu7hYvzIskramwkbY2gRBtyLRTV1qDSpklnOpYCsd/NIDhN6r9SLKWkoy
         tBBa0KYwUX0+oI7FNT5p0vd2Hf9NX47z5xUeDq6MkQ1Clwz+dZbL3W9RBSqVkGR0ogF2
         cGqXnv23jlb6oLHYB1Iaj9/Eruj1Ws4/ZYdY5dUxJBk6M4aiUIUDiiROqjQrGWH9kcbv
         ZR1g==
X-Gm-Message-State: AOAM5322Zei3jE8RX+R3hS4q65Brrg2W+2OOTLfJaoUXPKZTus+EI2yn
        2ikeU3m3hexOsYwvAtOfvI+Pj4W5fXRMA27T
X-Google-Smtp-Source: ABdhPJyBfOSWyl1ajrOIxBR3rQviMbKg2Otz28HNplVvjoh7fBYbxY4AbFNtNIg/p9Y17DXBTDa/sQ==
X-Received: by 2002:a63:2b49:: with SMTP id r70mr1511008pgr.111.1644888355550;
        Mon, 14 Feb 2022 17:25:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p17sm38591534pfh.59.2022.02.14.17.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 17:25:55 -0800 (PST)
Message-ID: <620b0123.1c69fb81.9d929.0366@mx.google.com>
Date:   Mon, 14 Feb 2022 17:25:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc4-37-gd4e043a4af96
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc4-37-gd4e043a4af96)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc4-37-gd4=
e043a4af96)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc4-37-gd4e043a4af96/

Tree: pm
Branch: testing
Git Describe: v5.17-rc4-37-gd4e043a4af96
Git Commit: d4e043a4af969c8d992f8abb3aca811380201cfb
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
