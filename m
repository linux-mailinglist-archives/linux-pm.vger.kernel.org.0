Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F123A234847
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 17:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgGaPRm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 11:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgGaPRm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 11:17:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5208EC061574
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2020 08:17:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id c6so7589171pje.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2020 08:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ROmKFJHVfBoZNghXufcJ6RjR20v2TGxgpUWO6bRrinE=;
        b=atEZ1d3OjX8XLbxqBT6VJBRxrguUUDkkdNm7jvpc2k4svD8CEQ4iuXQIpF7uVhlSLj
         T65Blos4n5qhHSNIPOwEW25jjEGS7vAU70q5q81N5XNnrPpf+vfq5w59dCpvY/9/D43n
         DfHzObbdPTchefwUlE0uukvnwK0bVBQScdbjA5SIXuc/m11FCJvGQRjP+xhTWlgDcRri
         HO4xuykzmxHfMpVRK8kmhQqWqZe1kI+9cncLo3TU1lxyTpJ3N1+c2gBxCkurA94qUZS4
         KzXiRb9fkX9mkkOoTy/Hs7LBh3eQFJsEWGb+N2vmgUDo+LDqdNF4gDiLwtgHmFYykk3T
         iGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ROmKFJHVfBoZNghXufcJ6RjR20v2TGxgpUWO6bRrinE=;
        b=PSee0nvp2z3fSp7wg8ZdCd9QtpyOrKcSn/KF/MV1QIAC+Ps/Q/HgsQs5NxQr+MmWXJ
         +AS9R2mLfvHZkRnXMyz7sEOZGzZ6ppmdwrd51qPocoyUcvhvP72byzRbqqo0LjZaHozv
         fCce5aCXZHAuqkiVaVk4GgU6zBNwGznc0Wg5sTme+hPMbfxuzRhml3rxLmeJXdl2ES86
         28sidTQ+9wgujpZj8eXcE/UbllluvajLGF/aig8yiwr8ALKnnuE2L5OkGv/ZJPqcsGKV
         bOYCMJUdlEzi718tt9p3FHayogQMKpLQ7GOSFboVCGxY+ByDKztyCiz9+Xb8F5YTuv94
         /AdQ==
X-Gm-Message-State: AOAM533xMQhpefWxmVjCmj2WQcg6p3UFQEt9rNG9nlGDrxRQTYWUEeFI
        g6eZwTjxmvJkxEELwZJt6VhPyQ==
X-Google-Smtp-Source: ABdhPJxpPcgbH7J2OGlo5UTMXD3iqL/MCFRUjG1gM8x1Y7F7VQdX+WwblxLrNcFQHe/t8RdjbHOSCA==
X-Received: by 2002:a17:90b:4d0d:: with SMTP id mw13mr4726283pjb.159.1596208661548;
        Fri, 31 Jul 2020 08:17:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j4sm10515360pgk.4.2020.07.31.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:17:40 -0700 (PDT)
Message-ID: <5f243614.1c69fb81.ecf3.afb1@mx.google.com>
Date:   Fri, 31 Jul 2020 08:17:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.8-rc7-109-g86ed8b05f597
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 8 warnings (v5.8-rc7-109-g86ed8b05f597)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 8 warnings (v5.8-rc7-109-g8=
6ed8b05f597)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
8-rc7-109-g86ed8b05f597/

Tree: pm
Branch: testing
Git Describe: v5.8-rc7-109-g86ed8b05f597
Git Commit: 86ed8b05f59717b20b75cd2a4a17cbd26788183a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-8): 8 warnings

arm:

i386:

mips:

riscv:

x86_64:


Warnings summary:

    3    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.=
dtsi:7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-range=
s" property but its #size-cells (1) differs from / (2)
    3    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.=
dtsi:7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-range=
s" property but its #address-cells (1) differs from / (2)
    1    /scratch/linux/arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: War=
ning (dma_ranges_format): /soc:dma-ranges: empty "dma-ranges" property but =
its #size-cells (1) differs from / (2)
    1    /scratch/linux/arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: War=
ning (dma_ranges_format): /soc:dma-ranges: empty "dma-ranges" property but =
its #address-cells (1) differs from / (2)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 8 warnings, 0 section mi=
smatches

Warnings:
    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:=
7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" pr=
operty but its #address-cells (1) differs from / (2)
    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:=
7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" pr=
operty but its #size-cells (1) differs from / (2)
    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:=
7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" pr=
operty but its #address-cells (1) differs from / (2)
    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:=
7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" pr=
operty but its #size-cells (1) differs from / (2)
    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:=
7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" pr=
operty but its #address-cells (1) differs from / (2)
    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:=
7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" pr=
operty but its #size-cells (1) differs from / (2)
    /scratch/linux/arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: Warning =
(dma_ranges_format): /soc:dma-ranges: empty "dma-ranges" property but its #=
address-cells (1) differs from / (2)
    /scratch/linux/arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: Warning =
(dma_ranges_format): /soc:dma-ranges: empty "dma-ranges" property but its #=
size-cells (1) differs from / (2)

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
