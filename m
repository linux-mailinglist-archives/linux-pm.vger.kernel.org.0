Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F72B233960
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 21:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgG3TyF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 15:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgG3TyE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 15:54:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B1DC061574
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 12:54:04 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so15132845pls.5
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pJZpBqmNtZt8oWm2tkD+ZtaXFZZ5rEeIVhxi4WEtmxw=;
        b=TDstOAz4R4yxpB7ZLYqD1GSZoEC7VyPd1SJfoNlvcWPupTvxkZVJgfkDzvInP/Giyk
         6YTzvXLWxw7d1ytMVFxFJe8Z0/9+SgHNxN5Am6o36pzFBLIQU1U/RG8F6Dak6+1Ymkkt
         KDVMWPk+Cuwg3MwHgBcKtSMumeBdNY6+/8B5KzpFBKSl3Ex8+vrN8W0vJYTZtCm82XkP
         yaXDWwopF0CqtjSOQdFeXpECyyldutAAEu/QipuS01Uxd62Sy9bXp2px8EOXG2MtX3Cl
         yDXbO+8if4v5VK2yEFano216/Ldr8QomQYj4Jp7ctnqSGVD8LAXa1n8uB5IE925Kotie
         V7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pJZpBqmNtZt8oWm2tkD+ZtaXFZZ5rEeIVhxi4WEtmxw=;
        b=GmLk0Vx206lFwnN3wgDGvbvKMbXbStnE0tGNbkKE3THbgD6n6AxXJz4u80ERhRuZoG
         Wt1AUlmc2ET+IGWacRXYx3zNTsLJzf2iYkgjwLe1eetyLlrINdCsVuCH9kmTSubSkQ9d
         8l3bbSfew9y1rOWiD69JUWDutNahpjlEC39phaJfKevubUY2ATpNkfG9Umf1SRLpxkl+
         AFVs1p4Rp3HIvxLtieYj7GxbxHDvlgFXqLtQnHE7kvUMk62t31Ig69NHxXe4e8Tr+Y+G
         o+2NxImn/R3XEKnXOGqAjQzHnH+mIS8/if8/mPe4l9p9TvNk+TL7wGwUuwE1OM6/hXwv
         ClMw==
X-Gm-Message-State: AOAM530tFX4gXr+tMB++PLhbOrr28u0xZ+ksmsgDuHritepRhnS2Ac+v
        1VXEGQ+9tQKsRQ1U+hdacLbabQ==
X-Google-Smtp-Source: ABdhPJxsMWTbb0LpGl4e6TX51UzgPqmGQ4shGC6+pNjUPxB8WBj6joBDxNqq/Drp0m27kz0H9toweQ==
X-Received: by 2002:a17:90a:2d7:: with SMTP id d23mr708718pjd.57.1596138844144;
        Thu, 30 Jul 2020 12:54:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b78sm7277298pfb.144.2020.07.30.12.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 12:54:03 -0700 (PDT)
Message-ID: <5f23255b.1c69fb81.884b6.4713@mx.google.com>
Date:   Thu, 30 Jul 2020 12:54:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.8-rc7-107-g97987ea7f86a
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 12 warnings (v5.8-rc7-107-g97987ea7f86a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 12 warnings (v5.8-rc7-107-g=
97987ea7f86a)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
8-rc7-107-g97987ea7f86a/

Tree: pm
Branch: testing
Git Describe: v5.8-rc7-107-g97987ea7f86a
Git Commit: 97987ea7f86a35284fd54efc7412db246f178666
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-8): 8 warnings

arm:

i386:
    i386_defconfig (gcc-8): 2 warnings

mips:

riscv:

x86_64:
    x86_64_defconfig (gcc-8): 2 warnings


Warnings summary:

    3    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.=
dtsi:7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-range=
s" property but its #size-cells (1) differs from / (2)
    3    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.=
dtsi:7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-range=
s" property but its #address-cells (1) differs from / (2)
    2    /scratch/linux/drivers/acpi/processor_idle.c:670:4: warning: =E2=
=80=98return=E2=80=99 with no value, in function returning non-void [-Wretu=
rn-type]
    2    /scratch/linux/drivers/acpi/processor_idle.c:666:4: warning: =E2=
=80=98return=E2=80=99 with no value, in function returning non-void [-Wretu=
rn-type]
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
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 2 warnings, 0 sectio=
n mismatches

Warnings:
    /scratch/linux/drivers/acpi/processor_idle.c:666:4: warning: =E2=80=98r=
eturn=E2=80=99 with no value, in function returning non-void [-Wreturn-type]
    /scratch/linux/drivers/acpi/processor_idle.c:670:4: warning: =E2=80=98r=
eturn=E2=80=99 with no value, in function returning non-void [-Wreturn-type]

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 2 warnings, 0 se=
ction mismatches

Warnings:
    /scratch/linux/drivers/acpi/processor_idle.c:666:4: warning: =E2=80=98r=
eturn=E2=80=99 with no value, in function returning non-void [-Wreturn-type]
    /scratch/linux/drivers/acpi/processor_idle.c:670:4: warning: =E2=80=98r=
eturn=E2=80=99 with no value, in function returning non-void [-Wreturn-type]

---
For more info write to <info@kernelci.org>
