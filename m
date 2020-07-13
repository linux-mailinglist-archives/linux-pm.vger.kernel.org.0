Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7757821E12C
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 22:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgGMUIs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 16:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgGMUIs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 16:08:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED5CC061755
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 13:08:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a14so6515428pfi.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 13:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4vaf406CthGW87H4kIjkzqzX5WM3WJzb4YLwJ8bvjMA=;
        b=s4qnwQHwwpUaHTUVfkonllBq8SU30RBJb2yRqkBOKPxS60cpzMYHJomVotPUSra+kF
         RKQ5M99EtJUqPHvGXeKKMKbaDJ4N+yLgOAeSuRCI4unNxJQho4vxbNPihtPoEa3F7OCV
         Oo06rpC3RxmDHjEhSNYuPlqRu/nzFluIbHROMjCPOwgdvGcH2SLp0Ye0Sgj3Ort0hdvH
         qB6JgCg5dFlHd6ll3tz2v9a+3gWB5uloNuO03J/08GZoGNSUZE7JzzMtuhfe0icZLw6U
         DtcaCU3OUmwU3IauQBKp1E1azI2oTumywcJb0STzpbgg1Dr1Qi7dqTWP9dtieNHXcvia
         +Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4vaf406CthGW87H4kIjkzqzX5WM3WJzb4YLwJ8bvjMA=;
        b=qHvCahxSeayq9XUsiADh76k82qEkDolzQm3/2egqwTm3T1mc62pW3BWI89cs/JmrtM
         2/qa70io0P+8A8pGoP67mN0LktP1WVBPLBsfFBy0ezI+WKd2Fbr0o5C8VA3jTcQIfc7B
         oiw7AQQaYpASY7lOT2rlsxqeYKClsTmcBiw0OJIf+RSXEKGAKT2tYNCcUibsFxnxrHPy
         vRmiKtxmPoA5EHxUXsyzeyYjYZK427WAGDvteqcb6uz7wO8h+ExgibYTMmad1eYaidKP
         QJkMTZjxsdqKXnxHDX0XDsTBa/jyz1VIruHH56M90hX9qGqJk7eX7PLZhYEL2jL+fRNE
         KQ6g==
X-Gm-Message-State: AOAM533AOB+c5GHPEIvC/svn8gqsVOI4WaGU77Gni2xWGJLb+xhYy4es
        oPBoG27P1+Xem3PxAGtzK2hA+w==
X-Google-Smtp-Source: ABdhPJwAoI5NoWsBKYZFaSohOrjbr+P9aslUs23JPPnRp4BTL8OXhu4ULWnfbdug3b0kj1zGQHVQYA==
X-Received: by 2002:aa7:9d9a:: with SMTP id f26mr1344195pfq.26.1594670926341;
        Mon, 13 Jul 2020 13:08:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h15sm15459557pfo.192.2020.07.13.13.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 13:08:45 -0700 (PDT)
Message-ID: <5f0cbf4d.1c69fb81.b1f24.543d@mx.google.com>
Date:   Mon, 13 Jul 2020 13:08:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc5-39-gf2eae871177c
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 8 warnings (v5.8-rc5-39-gf2eae871177c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 8 warnings (v5.8-rc5-39-gf2=
eae871177c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
8-rc5-39-gf2eae871177c/

Tree: pm
Branch: testing
Git Describe: v5.8-rc5-39-gf2eae871177c
Git Commit: f2eae871177c5c62003e6a961382f098afeabfe6
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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
