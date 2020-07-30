Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6839233736
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 18:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgG3QzT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 12:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3QzT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 12:55:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DEBC061574
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 09:55:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ha11so5078046pjb.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=aFzfAYL+zJxLzB7qgzJ8PaXdKwJZoqVblsD99yzJMnk=;
        b=Ur1Ci8joVjaboq4r3YG5FgpVwJdA90QNbASV4STWxAd80m9TdLMFFQbgO4Hl/4YYn1
         thBjqp5sMRvdgIHaSoP3TvIb6Tt3H6gYfOoK2ayj+QzjEn49T6d+jMfHCIuoBQ2OblRh
         wcucpmuKMo6TlNI3truaVrfWvRq2oX98FzredsfaWLdfJj5w9hNgzEbSULJlYYiB5L3n
         nS38FpO2vMZfKUdDCkB86jjKDbi/mgHSpAWjekPcJWNPOMuULU2AGwijXbRronzlphtD
         dIJHD9PkbCmBndPKIhoA1ZX0ioQyWxr6gssFj3KHINBpwLBcCKOfKYRE5nTGBEiA6u/E
         q3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=aFzfAYL+zJxLzB7qgzJ8PaXdKwJZoqVblsD99yzJMnk=;
        b=Fsfzc03z8BHPTbwiZA2fYstO1Q75WSi38vgdUAr67THC9OfOHG8/AXmwQ5+FC7jfFP
         0cOaICLQ4A0gqIQIwKRGpjtLJ8eDF6RGTiqNd4WwAJC0a/Z//xSgzGrX4rJHvNgXXS6w
         BhVSpXWeEAVqTuTwYQFQZ9BAaBFJHzoNDxqVVxVh3vaXpYcL8zg9PBYNVx0H8uwi1Fdp
         63/YR7Sgn1rby8RAKWOEfd8/0HDaF2absAGNiU5bdRQOhH7SqWi99ddm5UgDa8wMLCC0
         jNRaSKZlpYp87w/xCysoqd4O/61CuGWIXAqaRml5HtDjOnT/HC54FJkx9PSIzW7eqFN/
         OHVg==
X-Gm-Message-State: AOAM533ALmk9oWnjZkvC5g5i12gEDJZ8uPhxetO7iXFLBYWy0IYkpfe2
        W/3ei1NDgWHm/KIboRpZFC/IqQ==
X-Google-Smtp-Source: ABdhPJxgQyJG5LTCP+gRkzf0E4O5gRnFJuWQTWZZiiA8ZJ3Xp6xXsa+RNkKDmKb7sbbYIDUy/h4T1Q==
X-Received: by 2002:a63:1208:: with SMTP id h8mr4472173pgl.128.1596128118820;
        Thu, 30 Jul 2020 09:55:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t63sm6756290pfb.210.2020.07.30.09.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 09:55:18 -0700 (PDT)
Message-ID: <5f22fb76.1c69fb81.de087.1e3d@mx.google.com>
Date:   Thu, 30 Jul 2020 09:55:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.8-rc7-94-g89beac5dc8d0
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 12 warnings (v5.8-rc7-94-g89beac5dc8d0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 12 warnings (v5.8-rc7-94-g8=
9beac5dc8d0)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
8-rc7-94-g89beac5dc8d0/

Tree: pm
Branch: testing
Git Describe: v5.8-rc7-94-g89beac5dc8d0
Git Commit: 89beac5dc8d02d24cb8dd1ce3eca00ac594ce31b
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
