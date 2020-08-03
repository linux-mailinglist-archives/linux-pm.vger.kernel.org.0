Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324D223ADF0
	for <lists+linux-pm@lfdr.de>; Mon,  3 Aug 2020 22:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHCUJJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Aug 2020 16:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCUJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2020 16:09:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABC8C06174A
        for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2020 13:09:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id c6so642395pje.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2020 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=6g9W2NEYgHvux1GXDh5UGff+G2y+TQHLfCYxnV7dGbk=;
        b=g1Bs1DsGl1A9IzSdec8tXbTIFcK4nFb764kbHOETeiJZZnhxlxhMc+9vWQUwuYcDlc
         I1FqyLcrffEAHnejGTXcybk8WEOD2Ja6rSO2RqwDg05mIfyvTRhFWzDXob3U7mKfpEjs
         quOQf7xxJCbwnyekJFwXof9yWajpv2+CiGmN6x5/mVO7RcicIlMyKQK6q6P7bykeK8kc
         T+s4/Q8vfv5vAcogFZAL6k537EjUjQJcvhen8fhZZg9GDTlhu+ssu/LUtoUuqas5HqKd
         QjwVbSX0BgLsgPoG9MPJyTkOK9c/XTOtzr2COlG3wyEMa7nMwGQGhGvjTcU/ELQI2Xu+
         iGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=6g9W2NEYgHvux1GXDh5UGff+G2y+TQHLfCYxnV7dGbk=;
        b=jGRFWvY/6RLlA9x/JPhaFsU1iWsRPhgBmQ0IEkLpzQls/WHbuqObomnJAf75y3AJS0
         7OlNnZyZoRrtCNhchOhKULKVqsp1AsDQm4znoccCJFfYt8UIElLcTtlBhhocZ9lvsBuM
         dF5mrhP9IDZuzsgNFHFBwVlEp7/RL+OvAqBxWZ6j2OohzxDvkioQTMfU5Gfm29OL2AMh
         j9rs4eOc+FXRJ0hfJUj3448NHfFiTlZphSuDNcXTnUQGxUFr8hVIsFs6RxgHEeFrWBVR
         ymdUbQCS5A7s/18EXpGs/VnmJTyoms187yLI3ugEX1TIgLR8tYSsFKBhR62joym4gYjy
         A7ow==
X-Gm-Message-State: AOAM530+3+Y9WJrN8j0q+lplb+jfVxwN6EP7n9x4jrUCxgjZP6fnq9/e
        B0OcXNH736BE8KF28YGtSdsNkg==
X-Google-Smtp-Source: ABdhPJy92FJFZtKpzIyIn1SQWcxCypMAV99AvRFk/tnK9fjd4+szr4Z0o7npQh/Fc03EAAMWupCpBw==
X-Received: by 2002:a17:902:422:: with SMTP id 31mr15456319ple.202.1596485348573;
        Mon, 03 Aug 2020 13:09:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 124sm700490pfb.19.2020.08.03.13.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:09:07 -0700 (PDT)
Message-ID: <5f286ee3.1c69fb81.a13f0.1d7d@mx.google.com>
Date:   Mon, 03 Aug 2020 13:09:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.8-107-gb72b3ea38c81
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 8 warnings (v5.8-107-gb72b3ea38c81)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 8 warnings (v5.8-107-gb72b3=
ea38c81)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
8-107-gb72b3ea38c81/

Tree: pm
Branch: testing
Git Describe: v5.8-107-gb72b3ea38c81
Git Commit: b72b3ea38c81d6f9585d8e47c6cfa70efa383698
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
