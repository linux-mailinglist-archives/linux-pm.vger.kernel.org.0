Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7A672A42
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 22:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjARVTI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 16:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjARVTH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 16:19:07 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92871C306
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:19:05 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id i65so23811765pfc.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MJY9JTQwErYr22E6fzT0ci3eaWA2RBdPrzN5kwMZJ8g=;
        b=aT9NdEWr350YkE+LvmTVNsG1z6olpIcoNBaKUMZMx+XGXYyH6yI30VsW2XI4SpXn8v
         QHsNzYl8I0ryVsO1lQUxBM5xsj4xls+ZCe74craDZybAgxiJafpKQobioDGGh/tOm23e
         Mv5A3vn5MU+/UYet/pY4KyexkEo5jaRmMizddRLjKLuDxbX6flfgVtwu7U15YTKC3IjI
         FEzTGPgSooFAP9sBMEcWpaznC8tWUDqGjeaJz84Whlzx8RuY1kFzMP4fz4C7ezFV1QOU
         P54Mn4n1F/QYoK6CwuOhmz9B9j6n7O5mK2k8TbPoB+CYawc1D91tjA1BxqBmv9/KlpGO
         T8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJY9JTQwErYr22E6fzT0ci3eaWA2RBdPrzN5kwMZJ8g=;
        b=p3OD1rrkJBROM8bfeyA9YU+7W4TMXmQ8AMrm4fhAwCnFo6VPjJliDFQTyhARKpYPi2
         KciiASElK/USbDWFF3mr911puM1DybuKWHJxuBK70y41R90i8StPT1Wn56eqexjQDBoE
         or33hYPdbCyawIGWEs0bovaGGeOAO6u9+g10t/JaZH9+M9nP7Mtj1oXhJ4JjB757OzfR
         FoT6z0YIpyX0h92D3b17RDgftzfkvUQJMxxswiTqIIVR1A/h7XzKFmhkEHEQv3hXudfG
         /V2Smp3h5Kf/6lqElABAlWJZOIeYIrwo1dN/ztqlTHYP6WKUv85qDVBVMpJHcPR/iVH4
         XDZA==
X-Gm-Message-State: AFqh2kp1EpkVfm7KTeedGyuevfdqaX9uNPwFNe/WnhRSjNkxEj/N1cen
        Jn5y3gABrEGEgxCPAUR6j66k6w==
X-Google-Smtp-Source: AMrXdXvRLIm5514QqRyZdhqdrbGWjzdFTLCsG1vg7lc5cycZ9FWlN0uGNAgWLcWfthOJO8MiegG3Ow==
X-Received: by 2002:a62:cd89:0:b0:58d:acf7:9648 with SMTP id o131-20020a62cd89000000b0058dacf79648mr8645360pfg.22.1674076745271;
        Wed, 18 Jan 2023 13:19:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79f86000000b0057726bd7335sm16085516pfr.121.2023.01.18.13.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:19:04 -0800 (PST)
Message-ID: <63c86248.a70a0220.213f7.aff9@mx.google.com>
Date:   Wed, 18 Jan 2023 13:19:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc4-74-g590cffafa8dd
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc4-74-g590cffafa8dd)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc4-74-g59=
0cffafa8dd)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc4-74-g590cffafa8dd/

Tree: pm
Branch: testing
Git Describe: v6.2-rc4-74-g590cffafa8dd
Git Commit: 590cffafa8ddf08292be10169d5159ba30137371
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
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
