Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D304659EA88
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 20:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiHWSHC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 14:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiHWSGl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 14:06:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0100BC13
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 09:15:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p9so12835158pfq.13
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=UX2innPI85KryRsSCB8wot+Cq0A2VN/Xc0YRONGm6Qg=;
        b=o7hZE49kVwJubQsgikXZdv1Ogqh9kYbUKLvB1j/zupOj4be/wRhY4QCDXM90mFx7oj
         yk05uwm1OPnv1Sbj+jSTo9o6Ek42iFR4dKewiY3NHSbrFKeL3pSFx63+7NZlWyEFPns5
         6et1ALX2zNob5xb8ZmIMfrt05eOyqR+2PTH/cDMRSMPnMWVgtzNBeqjAs6wPuoy+9EPm
         c2V9IQEjPQ4RN2AdF9UNlvqqDO3U1Vlwk9JwueyKMyPdAGmVwOA5i/uxYTxClx2jDcEq
         hAcgcGiSbPHU73zpIj09HTHhRMKV7dqszVoB4MRVMmoBTls8V/BBW8yRHaruymyY5UNm
         VyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=UX2innPI85KryRsSCB8wot+Cq0A2VN/Xc0YRONGm6Qg=;
        b=7c5Nn6kSfavZZFnW5CsmfddkwxAH4D4CC17Ri1JgsOkADZA3esc+7KVFUJ6MK2B/yu
         UgyK9kz9kytc3Ll/Cow/0xEBnYF/Bjdt44QxsAZL3sVA2iO6BLo6zCG8cfXUM27D0F0H
         LcFAm8Dne1IEawFX25LLvBmvdSHxOxuALzLQSGBnuCTxXjSttDpN2Y3dNI1hkXHA2P/d
         5eVHpfoG/2eEvgmccwMCiABNiff1y6WZ2xjwzTDlGAmzSbqzT3W/D16OVblXiRUR0Xyy
         KorQ8YrxtzpG/jKiojblwvGpjx87nHHYoJlW16qJskY3ACW/uNuS46e2PTk1BlLuh68z
         +00w==
X-Gm-Message-State: ACgBeo0t6qxfaClsQUlMfqHQmM3/ntSLfWTB8wH9Jyr1QdzYkvVGFddM
        FqxpewQT+PnuBO5pejTNxSnc+1QroqY9aigY
X-Google-Smtp-Source: AA6agR6X3K60uAlw4GncJWqxCE8QQF53Cb/O/qxZPpRBnRyz50nMBhjJPyQt4U3K33z39yVsrLep2w==
X-Received: by 2002:a05:6a00:98a:b0:536:4469:12e6 with SMTP id u10-20020a056a00098a00b00536446912e6mr17234963pfg.9.1661271326454;
        Tue, 23 Aug 2022 09:15:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709027ec900b001690d398401sm10646131plb.88.2022.08.23.09.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 09:15:26 -0700 (PDT)
Message-ID: <6304fd1e.170a0220.16c35.2f2a@mx.google.com>
Date:   Tue, 23 Aug 2022 09:15:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.0-rc2-7-gce20aaef438b
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.0-rc2-7-gce20aaef438b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.0-rc2-7-gce2=
0aaef438b)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
0-rc2-7-gce20aaef438b/

Tree: pm
Branch: testing
Git Describe: v6.0-rc2-7-gce20aaef438b
Git Commit: ce20aaef438bb6033b9e42bdebdcbc2f854f1967
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
