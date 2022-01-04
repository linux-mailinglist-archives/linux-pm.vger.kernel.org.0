Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7446483A0C
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jan 2022 02:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiADBzw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jan 2022 20:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiADBzw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jan 2022 20:55:52 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B394C061761
        for <linux-pm@vger.kernel.org>; Mon,  3 Jan 2022 17:55:52 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso26073968pje.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Jan 2022 17:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=NFzh4Tih/teDjraUq5b4D1rBRc/bS7NtnvhOTHb2NHk=;
        b=e86ZU8Jl7qYAOdD2dRQlCfXtZZZRuthZV8xn4/LHUdisqax/yRyP113Fx7K8JrUkh0
         qMk1bpXLheIeVNV9hu0DljwOEVUc47xljFnW8H6Jsa1n72HPlSSVeD1Sa9FhjGQjBhpI
         S0NHk7bzU6hWr5gF2w6IlTXJnM7G3et70h2Lt+vdculF8TdiS+WOi546Wz+U4yJkxzjS
         2KGNBPRK39X2+5aYsUm2jhPrEw6tLpR4kI03KXdSZS9qJzTBffIeJbbURePfk3jvuaXz
         kwlR8gn4xo2kZTiTCbr+N1MT3KodyvFojV5znVa07yoMHv1VsFl6qjIhiKiEeAvY+S2C
         xQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=NFzh4Tih/teDjraUq5b4D1rBRc/bS7NtnvhOTHb2NHk=;
        b=ElbmjksBmlb0D/GSupt9jdEN8ePrBx+8L5zXe+19l4QSfDB3Iz603hhBgUlQxSvJ5M
         WwxVwCbpCQe38NTPbhppwxfO0IyS0xLS5sIUP8PxhOs+/yxru6JyeFV6TMk0Tu4kTiPN
         vSqyyCfZc+7XkBkRMSIckoddDSWTmvZQR6UMJ16iWcZnt7QKHoQZ6F1o5jJH2pQK1xUI
         PH2F/vkfu8sHThm9P3eHZ1U//2SlpoTewS0zq1HmY3+vscvMVCbHJ8cgc7fAjI21BL2q
         yNnhMD08xsPwz2suaSnBk8KzkwVh1lEPufJWjwqkAKusKt2bxTsYvIo9mpPu/B32NEJb
         c7Uw==
X-Gm-Message-State: AOAM5306hwF9yittn8gb3D+0OzKYTEvP0sI9yvwAOObahpbXH7uyzOz2
        j14nAZp+nn3MNOcKatG4AR1dkg==
X-Google-Smtp-Source: ABdhPJyPKjti3c/ozVpHrA5SEyP+dSzteq4xElPt3TEyARNXEoC5XpnFdYxV4uoPtI6LpmWNm8BTkg==
X-Received: by 2002:a17:902:9343:b0:148:a2e7:fb5f with SMTP id g3-20020a170902934300b00148a2e7fb5fmr50092789plp.160.1641261351914;
        Mon, 03 Jan 2022 17:55:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id pf7sm42468548pjb.8.2022.01.03.17.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 17:55:51 -0800 (PST)
Message-ID: <61d3a927.1c69fb81.f66d4.1f35@mx.google.com>
Date:   Mon, 03 Jan 2022 17:55:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.16-rc8-156-g3d72f8341423
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 7 warnings (v5.16-rc8-156-g3d72f8341423)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 7 warnings (v5.16-rc8-156-g=
3d72f8341423)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc8-156-g3d72f8341423/

Tree: pm
Branch: testing
Git Describe: v5.16-rc8-156-g3d72f8341423
Git Commit: 3d72f8341423038eaf304155884dda9989a2fc58
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:
    defconfig (gcc-10): 2 warnings

arm:
    multi_v7_defconfig (gcc-10): 4 warnings

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:


Warnings summary:

    1    sound/soc/sh/rz-ssi.c:1023:2: warning: ignoring return value of =
=E2=80=98pm_runtime_resume_and_get=E2=80=99 declared with attribute =E2=80=
=98warn_unused_result=E2=80=99 [-Wunused-result]
    1    drivers/reset/reset-rzg2l-usbphy-ctrl.c:140:2: warning: ignoring r=
eturn value of =E2=80=98pm_runtime_resume_and_get=E2=80=99 declared with at=
tribute =E2=80=98warn_unused_result=E2=80=99 [-Wunused-result]
    1    drivers/crypto/stm32/stm32-hash.c:965:2: warning: ignoring return =
value of =E2=80=98pm_runtime_resume_and_get=E2=80=99 declared with attribut=
e =E2=80=98warn_unused_result=E2=80=99 [-Wunused-result]
    1    drivers/crypto/stm32/stm32-hash.c:816:2: warning: ignoring return =
value of =E2=80=98pm_runtime_resume_and_get=E2=80=99 declared with attribut=
e =E2=80=98warn_unused_result=E2=80=99 [-Wunused-result]
    1    drivers/crypto/stm32/stm32-hash.c:1003:2: warning: ignoring return=
 value of =E2=80=98pm_runtime_resume_and_get=E2=80=99 declared with attribu=
te =E2=80=98warn_unused_result=E2=80=99 [-Wunused-result]
    1    drivers/crypto/stm32/stm32-cryp.c:545:2: warning: ignoring return =
value of =E2=80=98pm_runtime_resume_and_get=E2=80=99 declared with attribut=
e =E2=80=98warn_unused_result=E2=80=99 [-Wunused-result]
    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    drivers/reset/reset-rzg2l-usbphy-ctrl.c:140:2: warning: ignoring return=
 value of =E2=80=98pm_runtime_resume_and_get=E2=80=99 declared with attribu=
te =E2=80=98warn_unused_result=E2=80=99 [-Wunused-result]
    sound/soc/sh/rz-ssi.c:1023:2: warning: ignoring return value of =E2=80=
=98pm_runtime_resume_and_get=E2=80=99 declared with attribute =E2=80=98warn=
_unused_result=E2=80=99 [-Wunused-result]

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 secti=
on mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 se=
ction mismatches

Warnings:
    drivers/crypto/stm32/stm32-hash.c:816:2: warning: ignoring return value=
 of =E2=80=98pm_runtime_resume_and_get=E2=80=99 declared with attribute =E2=
=80=98warn_unused_result=E2=80=99 [-Wunused-result]
    drivers/crypto/stm32/stm32-hash.c:1003:2: warning: ignoring return valu=
e of =E2=80=98pm_runtime_resume_and_get=E2=80=99 declared with attribute =
=E2=80=98warn_unused_result=E2=80=99 [-Wunused-result]
    drivers/crypto/stm32/stm32-hash.c:965:2: warning: ignoring return value=
 of =E2=80=98pm_runtime_resume_and_get=E2=80=99 declared with attribute =E2=
=80=98warn_unused_result=E2=80=99 [-Wunused-result]
    drivers/crypto/stm32/stm32-cryp.c:545:2: warning: ignoring return value=
 of =E2=80=98pm_runtime_resume_and_get=E2=80=99 declared with attribute =E2=
=80=98warn_unused_result=E2=80=99 [-Wunused-result]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
