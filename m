Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2305C480CE3
	for <lists+linux-pm@lfdr.de>; Tue, 28 Dec 2021 20:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbhL1T4g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Dec 2021 14:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbhL1T4f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Dec 2021 14:56:35 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC845C061574
        for <linux-pm@vger.kernel.org>; Tue, 28 Dec 2021 11:56:35 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id g22so16760170pgn.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Dec 2021 11:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ZfSn2w+VUPweqbWieXkwolBRb6NdOvFOjGxZdl/hYX4=;
        b=hvcPYvzItf+lOtxN3Xe5MSPMDeFLDoBkUn4nsj47EHMElGY7zkNq58w+Mbu4Vcvx+d
         E4w3bzwpsiMqd+/Nn+tqO9JdMVXq5ypH/ghLMIsq75Ok0eH2LXEnGpgCAhqYCAUEzqO2
         Zi+dfiU2QcXhxScZ2NzswdcXGmVtzHpSDsNL05G1HtqGR2UvGpWjgUI0qRCpe+SVjs7R
         peow7EIZknMQZJ4LnA16vWSdrz9hOUQMQyHnOe4BtXG7LBGATHDH7l/4tH9hXM5KK6zK
         JD2pI7rr3F8CIfOkyaLN1UXaS74GT44LK+mvaI2x0/xXxjEUoWfukwCjlmoOQUVaTOD9
         444A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ZfSn2w+VUPweqbWieXkwolBRb6NdOvFOjGxZdl/hYX4=;
        b=WLX4OgLSeicwtAukKBDwe9IoOreKf+6R+p9TH5KRONpbegVIvkyPnypkXtC97sjFiQ
         EiOoylgaf1Nvko1T3TeT+JeE5UIWFaokGAgvpNi6gaagN1pJqz1Sjea90FtY/A2je82h
         VAKMzZYXTCLh1wYUqBSqkNdpmAg/YJYTv+EMpEkibBx3jhUWrzDcjdfpPXvDgKbMgRMq
         DRqT6OEWwMPRYBmm7s6Nkgbr2jF/XF2SQo0mHYM+jRU3+A8tNPt+mRW0BNrNqZuPgoP6
         HCuZAq/n6hm8bWaWqkXoeW7rJB46uklOQS/7Qcv6VxK/pU4BPQrs4eEJaaa22/8AQzj9
         UKPg==
X-Gm-Message-State: AOAM531U/TgFQPd3CiCLYkaNeADfefzE3mxkrQsrJNt+pExSyogvCo/f
        jclSVePx94Kl3AYTTHwDPkoIxt8MrjMcvnfG
X-Google-Smtp-Source: ABdhPJxVALtXCyYjTX0zP2bYOs5TZb2g5r55NCEJRXfeBXV9GLqcZ4biov9HmmlQRm1n5RPndxtKRA==
X-Received: by 2002:a63:8c0a:: with SMTP id m10mr20755811pgd.142.1640721395215;
        Tue, 28 Dec 2021 11:56:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y11sm20440043pfn.7.2021.12.28.11.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 11:56:35 -0800 (PST)
Message-ID: <61cb6bf3.1c69fb81.e8827.a92b@mx.google.com>
Date:   Tue, 28 Dec 2021 11:56:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.16-rc7-119-g63b95bce9ea4
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc7-119-g63b95bce9ea4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc7-119-g6=
3b95bce9ea4)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc7-119-g63b95bce9ea4/

Tree: pm
Branch: testing
Git Describe: v5.16-rc7-119-g63b95bce9ea4
Git Commit: 63b95bce9ea451b7ef88e1cc09a0896473beb896
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
