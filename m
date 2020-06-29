Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEDA20D74B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 22:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgF2T2g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 15:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732749AbgF2T1n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:27:43 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38962C0307AA
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 08:52:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l63so8464951pge.12
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=O7sIHXeq9javydgPa4kkSbbJduAe1ZtNE3KpkpyN1M0=;
        b=VYMLb/s9Us5ceNtmBLYQSBLKuoXcWKMN/lu2yfULUISWVJJTp86tOTMfJ3DoNjJfLT
         s6AoWxOJIqBs9AxUj0O9RdD8eVM3oyAEkoVRT0xdY8d+ItmXwCv5Lq6pkrsPOYq/nvgJ
         JF9LSEIIG5HTA37tnlSFKA90gXabDAm6mePAEfWWctxeF6+yUhDlwRK1XNSMTv5Z3KAD
         bBrAcLrv9z5m3E2dRh3JN+haNQrPckQy9ke8DuRR/9PoafYfGvEDQoij4UbGIW5CVfFt
         uZRYG1aD/hl0VT+lYj3PZ/Qy0ErcTJJYTfzvAt4NrRev4I7Rg3yw8ROXptZ86O50Vb7g
         JTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=O7sIHXeq9javydgPa4kkSbbJduAe1ZtNE3KpkpyN1M0=;
        b=GcHqRO7Ehor9qy2Oouiyv8Hi4AAZk2apJMUQpVAsa6+KgwDpjKDE6CdkLrRvEEQXh1
         y2EkU/bio4cbQ/nIeLPw4MlIjZgJIo8XqGCQWoLdzTaNycWTA4XXO7t2kl42nUc8vIuI
         cCQ52ey8P7/+PLyIUKSoMvr+mixia8oO+u6WAO8x8WBJ/aX0RRz65c5b7svv9DZjVScS
         bfuBO0EKqNO0c9u7Z3X8Ve6zpp+DavYgo7k6qwH9kKsyWNJVfPM2eks1sICfCALS0eTd
         9hWcdCZLbEjTU4dKW5ShSarpObly+6sz0j2nL3H+PR+eNmzA2H6Nlk8y5SaZ5DlaOHro
         Y40g==
X-Gm-Message-State: AOAM530dCy0Hi3lN4dxiGn5cCDA3jtTpHluvt4O/kMpY8d2xEPrBGxs4
        VuK4nCmz5mr7mgM8nKSdi/ED7ZYvLmI=
X-Google-Smtp-Source: ABdhPJzCqVt5iaGjpTADjIp6sM/qiPJ3AYeVdocTRdq87dWRkQVWmSHDhhiylIc1384vQ+MtkTiG/Q==
X-Received: by 2002:a65:4c0b:: with SMTP id u11mr9054792pgq.383.1593445928778;
        Mon, 29 Jun 2020 08:52:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a3sm191462pgd.73.2020.06.29.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 08:52:07 -0700 (PDT)
Message-ID: <5efa0e27.1c69fb81.3ce31.0870@mx.google.com>
Date:   Mon, 29 Jun 2020 08:52:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc3-20-g4ebdb176f4ab
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 6 builds: 0 failed, 6 passed,
 8 warnings (v5.8-rc3-20-g4ebdb176f4ab)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed, 8 warnings (v5.8-rc3-20-g4e=
bdb176f4ab)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
8-rc3-20-g4ebdb176f4ab/

Tree: pm
Branch: testing
Git Describe: v5.8-rc3-20-g4ebdb176f4ab
Git Commit: 4ebdb176f4ab253a2f7eb2b924dd3dba9fa3bc1d
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-8): 8 warnings

i386:

mips:

riscv:

x86_64:


Warnings summary:

    3    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Wa=
rning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but=
 its #size-cells (1) differs from / (2)
    3    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Wa=
rning (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but=
 its #address-cells (1) differs from / (2)
    1    arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: Warning (dma_range=
s_format): /soc:dma-ranges: empty "dma-ranges" property but its #size-cells=
 (1) differs from / (2)
    1    arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: Warning (dma_range=
s_format): /soc:dma-ranges: empty "dma-ranges" property but its #address-ce=
lls (1) differs from / (2)

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
    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Warning=
 (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but its =
#address-cells (1) differs from / (2)
    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Warning=
 (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but its =
#size-cells (1) differs from / (2)
    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Warning=
 (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but its =
#address-cells (1) differs from / (2)
    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Warning=
 (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but its =
#size-cells (1) differs from / (2)
    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Warning=
 (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but its =
#address-cells (1) differs from / (2)
    arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi:7.3-14: Warning=
 (dma_ranges_format): /usb:dma-ranges: empty "dma-ranges" property but its =
#size-cells (1) differs from / (2)
    arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: Warning (dma_ranges_for=
mat): /soc:dma-ranges: empty "dma-ranges" property but its #address-cells (=
1) differs from / (2)
    arch/arm64/boot/dts/qcom/ipq6018.dtsi:127.3-14: Warning (dma_ranges_for=
mat): /soc:dma-ranges: empty "dma-ranges" property but its #size-cells (1) =
differs from / (2)

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
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
