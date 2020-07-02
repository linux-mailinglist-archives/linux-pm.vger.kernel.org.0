Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5552123C3
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jul 2020 14:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgGBM4R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 08:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgGBM4R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 08:56:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE13FC08C5C1
        for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2020 05:56:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cm21so3090856pjb.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2020 05:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xDYfILhoe2EzbbEd1gqCF5mCBaos2ow1HNc7Beb34IY=;
        b=xTrsDAOpPIoGd8OjU7Zwx+L8sVU9w5dDlevizn9ibnFhu6sY+kk02eXLW9hM/qW7+6
         pHeyLwcj/h52UzswC75nPQ7sfc+5dV1+MhGtaoVDJjQjCzGFcBsMwsMJbaxtSjRVKTpv
         KP0KMgN0HX0ibAuqMB0mzD08TWqv86vWqwfSyROJQy4N5Zz58v9+48nb7gE0C+sZTf0h
         s5V8g3A1T757JbusuC0ToFmlAhxnferGgpbQeq2nG92uG+i+2MTd5B6nkcRhTKjGLv+o
         deHtL8gdHIXxn3i/kKyCAMHq1GR9VtIMtu+j0/YekIdfimC7G/Kgl2NGR/v80Qe4MlKN
         0qjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xDYfILhoe2EzbbEd1gqCF5mCBaos2ow1HNc7Beb34IY=;
        b=IeULmfOfXqTTChkWp6EbqkwgewkumpTETrY9eIm432Zj7UenQYe3UuRN7sElpObgvp
         bE7yhX4fSVOmtJ6RovJKZuKsO5oOA0S/etK+TgPBiPaq5z9TnEp6p8jIDH9fzqnyMtQK
         q+EA8Su6E4ngHxHzt7e9vjb8A/8TRgftBHislPGP3OCon4ItsN1OQOOFI/6obTU/khQD
         8Jpfa08oVrOYBGgEOdf+UmiNxLmI+kvxArCpwBr4IihjcSQg6hhSpsv7zEVEmO7VIaGH
         RUnz2EmLB1Zv0q/KiWGlZTH6nD9epU487Aag6uQgWOYSuIGJwa0Q1E3/QWG+WWBLlTKF
         ATzw==
X-Gm-Message-State: AOAM533Tg6OvryDFPBPCwvnaSq8CvRfUbU8rAolMlK8USFNjo5WjshgH
        e8c/CxPWLUUiQJ+nDG0Ftvfxkv6YgxI=
X-Google-Smtp-Source: ABdhPJzg713GZ43JB7jVmBhOCP4SoChNxU+eeXx66b3BtWsLRromJPYzvXfjIAxlYanxEHMw5qXiAg==
X-Received: by 2002:a17:90a:a887:: with SMTP id h7mr31498906pjq.0.1593694576199;
        Thu, 02 Jul 2020 05:56:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x9sm8590036pgr.57.2020.07.02.05.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:56:15 -0700 (PDT)
Message-ID: <5efdd96f.1c69fb81.77554.67d6@mx.google.com>
Date:   Thu, 02 Jul 2020 05:56:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc3-32-g504bdc71542e
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 5 builds: 0 failed, 5 passed,
 8 warnings (v5.8-rc3-32-g504bdc71542e)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 5 builds: 0 failed, 5 passed, 8 warnings (v5.8-rc3-32-g50=
4bdc71542e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
8-rc3-32-g504bdc71542e/

Tree: pm
Branch: testing
Git Describe: v5.8-rc3-32-g504bdc71542e
Git Commit: 504bdc71542edf53e93b5b2e4cf173cbbe8e97aa
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 5 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-8): 8 warnings

i386:

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
