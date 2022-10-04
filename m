Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DD15F40DA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Oct 2022 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJDKb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Oct 2022 06:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJDKb1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Oct 2022 06:31:27 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB07724951
        for <linux-pm@vger.kernel.org>; Tue,  4 Oct 2022 03:31:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 129so12363276pgc.5
        for <linux-pm@vger.kernel.org>; Tue, 04 Oct 2022 03:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=utvgK1UY0RK2HHZyKhoNnFeR107WRrt8jpicmnYxvgU=;
        b=XqdfsMe2SYxuXvG3vWpK19uF4GCU4DVg5ZpkIZOxOYaKnuO+gpTX2eUKBotTAzAROl
         XZNkvn/DfHlyn27LOGvt1Whg9evUM0+eFdZeK2ya0lSq7Y9SIFGF3cZzrEbJy37HYm+E
         rtzefMuyV8+Sm2bbxdh2BjnGeABqLisFOZbKDHnQe8j06p+y+qPfytxH8B1+8xd6SAc3
         53JOeMAeuLmz9NEDdAL8tEnlAM/JoAD8+tXfQb9cYkuBzJnagklha4pvPeOvpip8DJS0
         HL4yHC0A41FjGbbMhUAtazdhJoSsnvfa48QuWaEsWY7Y14fTHlYUT1OnmmY2bShcClL8
         GEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=utvgK1UY0RK2HHZyKhoNnFeR107WRrt8jpicmnYxvgU=;
        b=sPczPeGhoQs5fWwDxVYLr7ktALuWUSa2I0eiiQ0tojDF7gtbdUj9EpownM1BlYJa4+
         RlznAgbsjjmu3DSvr7dIGIkELSqRBuTlCHzJKomqVMbSdf439oqXOg1Gtf2tyeoZtVht
         mcUwTRpMA/Lohn4MXT+o+QztVxHAsqYeU6xXd+Fb4af8QIHL2tVwJAkbIWnoP/mpdSgP
         HNiyhwaRFiOW2POqS6UDSnJON6+DPU03ntIh0AOC4ZcIvjmH+Phcwc/nJ+6J5UE2Ow6G
         FNwFy/dCAYPWkkjddkCbegIUVvS3nR32/udyqfbX14PSsTEd/MmUSzZrwGIbPElmFT9O
         wZQg==
X-Gm-Message-State: ACrzQf3VW+KJ1bckjii5i3v55c4EKCX7LQHWFG0r05v2et0hwSqLfa2I
        tKu1IK4A2IIKPUFB2k9Svs2M/g==
X-Google-Smtp-Source: AMsMyM6IPjqrwcL1ZH9XVLUsFVfWKL6DxduEFko8rOHncSZWSikbj2VLzsQpMrusO4drR9azu6AcEA==
X-Received: by 2002:a63:da4f:0:b0:43f:6af:74ed with SMTP id l15-20020a63da4f000000b0043f06af74edmr23076341pgj.290.1664879486244;
        Tue, 04 Oct 2022 03:31:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x188-20020a6263c5000000b005366696b735sm2775043pfb.77.2022.10.04.03.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 03:31:25 -0700 (PDT)
Message-ID: <633c0b7d.620a0220.e562.4d73@mx.google.com>
Date:   Tue, 04 Oct 2022 03:31:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.0-rc7-188-g34ec1a3f2119
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.0-rc7-188-g34ec1a3f2119)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.0-rc7-188-g3=
4ec1a3f2119)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
0-rc7-188-g34ec1a3f2119/

Tree: pm
Branch: testing
Git Describe: v6.0-rc7-188-g34ec1a3f2119
Git Commit: 34ec1a3f211900baecef2b655ab1017719b7b411
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

sparc:
    sparc64_defconfig (gcc-10): 3 warnings

x86_64:


Warnings summary:

    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"
    1    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.

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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
