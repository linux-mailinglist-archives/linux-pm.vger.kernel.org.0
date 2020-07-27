Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F4722F419
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 17:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgG0PuH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 11:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgG0PuH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 11:50:07 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145A3C061794
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 08:50:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s189so9826321pgc.13
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=iuDKg6eFIqWR8KiidrQCDIastXGFYpVIckgaBm3FzlA=;
        b=HmA0drLm4yEFT5fG5JP3KgUu+Rq7+u7+IUIEEHJzXYeYKWpqotxLsjxd3lKYFzoOB5
         I/dndyTUpOGQ4J8RZ2VGk/6qhw5QAyX/dcpXniX+bQ1JI2IBwO3Ybg6fzWOdpYhcDwyi
         EDKkMdsYFwWP6jvN7ZQ4tjwaJ6bbC4exsAsGzPeRoReinXP8bU/h+tGZ9QRz9y25W9VH
         H075gcdcnagBGVnhCQ96QgnRZP2sNpD6dNIYsjayzknwRE8e6/F2QHPcRxVd+YDYqfq3
         Hhu84oGvuWR2LX/B3hi5tbdtOn3zbaccT0KNOpFupxq1BMOrm6LmQGyCUVwtYtpAs9c4
         I1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=iuDKg6eFIqWR8KiidrQCDIastXGFYpVIckgaBm3FzlA=;
        b=MgpXq5WmYRNmKWL0G7jf2aU+aTk7Q8rX6ZLbU/nLK18exa+UzlCnil/Bb0gjODSoQN
         NQQacBF1S/R70O4wp70Ze0ZtrgzV5kNR755mokrxSaclZWiJWDVUSA5xyJqNUVyRJu1Q
         on4+YsgBXKAqgj+z0GAJt/V+abvaFYda2TQTK9tGaP6rzptryz9MeBAIjgcq/cN2yl/Y
         ZjYnlF+PBnEHsNK7vqYVdgs0JBcDE05palm3cAS0IxSK4UanyNP5dukBLBB++BPJkQpb
         7cUS/tPYWGvLkBOD9A6DLP+no4QONcgaH07Pm4YkgBijItAu7HZ/XSHCXyZ8gFfIvHH1
         6kfQ==
X-Gm-Message-State: AOAM533g1DBTdcvbbaPyxYb8ggtGCHODaZARajnZGvfkjH64S8aPe8fC
        wk4DOTuesYddUG7EvdqSK1+YNA==
X-Google-Smtp-Source: ABdhPJyjxtbNl4amz5O8Yy3WAx7+u4CUnmJwy2EjeLqYmxT05+jCJRza/O4mm6t/pEDL3Dhcah4vHQ==
X-Received: by 2002:a62:3582:: with SMTP id c124mr20846632pfa.288.1595865006603;
        Mon, 27 Jul 2020 08:50:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k8sm16889442pfu.68.2020.07.27.08.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 08:50:05 -0700 (PDT)
Message-ID: <5f1ef7ad.1c69fb81.b4ce6.864c@mx.google.com>
Date:   Mon, 27 Jul 2020 08:50:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc7-60-g7f7b2e358b1b
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 8 warnings (v5.8-rc7-60-g7f7b2e358b1b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 8 warnings (v5.8-rc7-60-g7f=
7b2e358b1b)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
8-rc7-60-g7f7b2e358b1b/

Tree: pm
Branch: testing
Git Describe: v5.8-rc7-60-g7f7b2e358b1b
Git Commit: 7f7b2e358b1baa106afe6dec6dacb539d520dc6b
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
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

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
