Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7591222B17
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 20:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGPSik (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 14:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPSik (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 14:38:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A394C061755
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 11:38:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q17so4085675pfu.8
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=hCgewKYCXGDJX11hJ9nu5ZAFKaPZZtnp/UzTfSmGc4c=;
        b=I6TEoCqfH+peZYtaLn7eL0vCs4EryEaQkI2xyIhQGh6u870NpkHp+qrtDJ/vxys231
         FDaHNbQl4Ajfe2P2aAfJA8FKPvuMhXUnAFcPca+Q+IdMeshnxB8OBnZW2nYVywPnB0ZN
         xH8HM99szDp0XRm7vct18iPf+nkLLp1yznL+hWHcXuGXiTtXPtn+mAxm/e1w0GaUAw0i
         PC1uGgrdnKNnzJ73JbNl7slyGex4TRP+rx77ai0pmZ4A1oJVLJg1sc17SbYh2VYELF53
         nZynMg2kee3684hbEnDQ18uAqKoqRI/eaVRjRkvHYNwCeW/z3E1KbZzVGbGUo6SjLWhX
         TU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=hCgewKYCXGDJX11hJ9nu5ZAFKaPZZtnp/UzTfSmGc4c=;
        b=HyAYukidpifZkB1ScB2AKEMVSpmfpMXatj5RFuJEJDgnGPZinb65C2xWfXXMagwrKB
         CzCyrtPMxNXEljhE0ifgN3At8xPPguZBAC4jDgJkdgAcP75QNdNTFi6j2PWWagCDN+aW
         djGEFXwdbaKFQMupoqoeuT+rYpmGv7B9iu7KPwPjbL0FlpBoqlk4+Nx4PbP+CdTaLiOa
         L1q24jC94bKUpbn4QqFJPaXedjOgpz+PN2JwvHZNJ62P2fJqKKHvHiDKMZnU4wWTMfnK
         lwfrJmacdaNhhGx/0dpff/Jdu8bSfUg8e1eOcf5onGT3DuB+MAMpzwtZ3LLH+aa90wbO
         ofKw==
X-Gm-Message-State: AOAM532F8c800v6U6uN1BzPH4zgnvgepSPsaFvvLXUcP9Gw3Ge64AT4p
        1x04SZgxZEYH4COQPAcZY0dCMQ==
X-Google-Smtp-Source: ABdhPJyLlyBUD/0z2+FWkYa9V9sZOn8GCcdhol/Qru06P7Vi74UtZaHXplAVDPMJfpZ3mhST3qNspA==
X-Received: by 2002:a63:4b44:: with SMTP id k4mr5601974pgl.305.1594924719344;
        Thu, 16 Jul 2020 11:38:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 64sm5989585pgb.63.2020.07.16.11.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 11:38:38 -0700 (PDT)
Message-ID: <5f109eae.1c69fb81.ca226.108c@mx.google.com>
Date:   Thu, 16 Jul 2020 11:38:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc5-62-ge1f8d84fc3fe
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 8 warnings (v5.8-rc5-62-ge1f8d84fc3fe)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 8 warnings (v5.8-rc5-62-ge1=
f8d84fc3fe)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
8-rc5-62-ge1f8d84fc3fe/

Tree: pm
Branch: testing
Git Describe: v5.8-rc5-62-ge1f8d84fc3fe
Git Commit: e1f8d84fc3fe27530af068400101f20b67c33664
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
