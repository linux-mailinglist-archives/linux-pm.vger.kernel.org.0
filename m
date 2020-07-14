Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D9221F5EE
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 17:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgGNPN4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 11:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNPN4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 11:13:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC0C061755
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 08:13:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p1so7151965pls.4
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 08:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=PyIXQ81WO4m/oYoicT+H4WcRYZ+ZCnsAzqAxsFszogo=;
        b=1yDZ6zscrdKNpRmdO9WDC62RNlodavclsYckIdjocmdR2zcBvTG7yEVqy2LcfgIcdS
         ufRR5PLukQ/ZT9UiDffzbHR1GPvS6gSyNStQKweL2H0GVJqMSpFLTjKJ3WHj2n3lqIPF
         XP7chX2932B0t6RocpX8puAuKtHkRW+c6KMt4mm8hN6L0X12+AV1p9rbqBJISWnaRmid
         XBwOylIZ4AzdMfVz485OG8DvRlTHFp3NmsJ2G3PaLQPKcDTX9DqZoYXQ55vwgmRXyktM
         h/A+7bCutCshGh559IRbIt1E8if8e2JbazfWwfcMKt0ihf51zKmoiLYOkRYLnzZwKAxi
         pd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=PyIXQ81WO4m/oYoicT+H4WcRYZ+ZCnsAzqAxsFszogo=;
        b=PBJPBGTcdnpE2LPM5oEtuKuISlUngwGTUEgfLqC2pg7y/IZWojcE2r+Y//oEyu6oGp
         t+eMJ2+HzSOxdX6gRz3qm/LllxLkn2hjg1U9wcMANdluteyrFf/7gNy2kVXytYCsMEvO
         0KmUXzfMGCDLHQz5C+o92Dgwe+7v5hi/jdNL100G7dQA3yeEKk4De2sem5JQ7KWO5UBE
         FMmfDCPx3DvzjXGf6WcpNwsVlqJp5PfwEhEGdWrTpbYmI5cxPp/8KeGSjSCauJamC22n
         oE6cgqTvas3L8nQiTthtgCTThEZMKjmcY/scLO+TRQxeIgPv5T/rJeXC9EjjPp19PqSk
         4TOQ==
X-Gm-Message-State: AOAM531rE2ICcfdcksWtFXw1IWQFOg4KKjL1nXw7rsHLbDCNsba8YVf0
        qKJUqOpnJVJNNflPgiRNNQykX1zjjhQ=
X-Google-Smtp-Source: ABdhPJzeUIKHkOpwcQzY94kBngke4VJrGjxZQ2LCweJJQt75gfz8eRJIGoNakxXBAsuyM0bRlBwttQ==
X-Received: by 2002:a17:90a:25ef:: with SMTP id k102mr5251818pje.145.1594739635576;
        Tue, 14 Jul 2020 08:13:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u13sm2728731pjy.40.2020.07.14.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 08:13:54 -0700 (PDT)
Message-ID: <5f0dcbb2.1c69fb81.5673f.7b00@mx.google.com>
Date:   Tue, 14 Jul 2020 08:13:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc5-44-g71865a3b9f0a
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 8 warnings (v5.8-rc5-44-g71865a3b9f0a)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 8 warnings (v5.8-rc5-44-g71=
865a3b9f0a)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
8-rc5-44-g71865a3b9f0a/

Tree: pm
Branch: testing
Git Describe: v5.8-rc5-44-g71865a3b9f0a
Git Commit: 71865a3b9f0af787f9e80943606014cb59965cc4
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
