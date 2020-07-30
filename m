Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDEC232BD7
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 08:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgG3GR0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 02:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbgG3GRZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 02:17:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AA0C061794
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 23:17:25 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k27so15964445pgm.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 23:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=31NygmaD4/NgK4vvhtDzZ+1Imv930LEPgqMtHdOKftc=;
        b=EhlUNOj+4bUWl2VuwPk63vrRyxk9Uy2fA4BwE5/cjUmlNinZS2J7ebS/WTepY2AYa7
         jd8hBsEw0wV0t4tWGUzlgfq9IH9a1bXmNnsbhj1qi/x+TEaC5z0h4IsKbhSxfB0gm9Oy
         UWRDGGnvGC3ZHto2Y0dtE74s/3g5EyZR6oA3oR/t/iiA7Vd+itpftFsw3gPcF5Z+ierr
         Q6dJ0B+VG5sISDXkF9qJW1qPwscT8tCIfenefW0inbD88ExUffJCAmrIfV15FwihBBEC
         V3iVqGcaYZ4Rc311h2C3hEDAKn69ni14uOXdu6rrW+rQPpSVXKAK5fOw5l8MdACjZxQc
         jN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=31NygmaD4/NgK4vvhtDzZ+1Imv930LEPgqMtHdOKftc=;
        b=gpm7pIoW+hZLnYMypQgSOJ8oEYUUYISnU1VkyyxIX7zuScExNYxBOLyzmx+LwIkA5W
         XV405t3+6dMNJX4VhDYGieA30v/q7PUeXHBhDWcngTlb5UfQLT6ai12qEhkWxsNokGdi
         Md7lpTRevvFhBawTtWMXUh+zBXSSjmdiJEQbRYzuxIPVYeN+he8Ao2RcDhFhVLvjn8+B
         4tHR0Egxhwv2d2lEkJB59G5vh0d2qw4MWzMfz8GA++1TRbZacKseFTNh7aTp+j1OmWQs
         0jUaSXyzkEUP0y2QxC5hnt0HkNQGNJP8tep9PSLEjsS0tEzfWt2V8n2Q667Jycc61yaA
         BMPQ==
X-Gm-Message-State: AOAM530yMdXBE/LjXLhLIjnHnm0g7VDIfJS2jTSalIWIaVteTyejeoti
        34jIDA8bcF5MnbPp41jFfuRjkw==
X-Google-Smtp-Source: ABdhPJwlIgdWMP/4VCxpNYiTguVntoNvULVJXsgh29XrDI1vJfnzn9WaJGV9VId36ChBS7ouZ1QdgA==
X-Received: by 2002:a65:418b:: with SMTP id a11mr32419230pgq.399.1596089845289;
        Wed, 29 Jul 2020 23:17:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h23sm4586394pfo.166.2020.07.29.23.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 23:17:24 -0700 (PDT)
Message-ID: <5f2265f4.1c69fb81.b929a.eb32@mx.google.com>
Date:   Wed, 29 Jul 2020 23:17:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.8-rc7-89-g78b38a56af0f
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 6 builds: 0 failed, 6 passed,
 10 warnings (v5.8-rc7-89-g78b38a56af0f)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 6 builds: 0 failed, 6 passed, 10 warnings (v5.8-rc7-89-g7=
8b38a56af0f)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
8-rc7-89-g78b38a56af0f/

Tree: pm
Branch: testing
Git Describe: v5.8-rc7-89-g78b38a56af0f
Git Commit: 78b38a56af0ffa05ba414ce6be1123f7c799aafd
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 6 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-8): 8 warnings

arm:

i386:
    i386_defconfig (gcc-8): 2 warnings

mips:

riscv:


Warnings summary:

    3    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.=
dtsi:7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-range=
s" property but its #size-cells (1) differs from / (2)
    3    /scratch/linux/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.=
dtsi:7.3-14: Warning (dma_ranges_format): /usb:dma-ranges: empty "dma-range=
s" property but its #address-cells (1) differs from / (2)
    1    /scratch/linux/drivers/acpi/processor_idle.c:670:4: warning: =E2=
=80=98return=E2=80=99 with no value, in function returning non-void [-Wretu=
rn-type]
    1    /scratch/linux/drivers/acpi/processor_idle.c:666:4: warning: =E2=
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

---
For more info write to <info@kernelci.org>
