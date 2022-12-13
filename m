Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D523764BF9C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Dec 2022 23:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiLMWqb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Dec 2022 17:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbiLMWqL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Dec 2022 17:46:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7696B233B0
        for <linux-pm@vger.kernel.org>; Tue, 13 Dec 2022 14:45:58 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so5149876pje.5
        for <linux-pm@vger.kernel.org>; Tue, 13 Dec 2022 14:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=565UcnDeH/yj+bbP0W3kx3kiTHhqHfX9kMoQldk9UvU=;
        b=N4V/f9Ulp1Pp96W1GEPHge2YklmsVc/K+vKKfpg79i0uJjuiTJlaQ44tSe9Dq4blEf
         QkZBIHp5wwxF4aHVzuK2xpSpuHbc94oU3jGZR1fXEPEU7lSdUd/sHAFr3VD5UXS2bfuv
         8B5EeGvh7Pchs6aGo/rQUjmiWJXRSDdicZ9ASYjkP+2jWaeVeBSK3+jGXlJYgVSBkUEc
         B1odtcZxkHA4hTvU8cX3NtiY/cmQUJXjexz2HxWI9Q28ebp0cjM6+sNJks2HVzU0TOKv
         gdiBGQyPKWKE6KCQr6j2/RoNtfdEWJP488Vgl6Hg6wNVE5ur29khTAn5NpgH0Ianne0m
         T7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=565UcnDeH/yj+bbP0W3kx3kiTHhqHfX9kMoQldk9UvU=;
        b=wd8g4uCI7C4A95uRbT9XdoadaXD/6SRGu/rBroDqpRG3QNyvEhRrX/77c91GZqaWyr
         y4vXq8dMOG4R4E2nI+AvDHl9PMdTFto86BuTTz/mTzDan8k4BME+XUJ2gpVSyE6nbFrI
         ItSbp4hIA3iwkhye9GJXmscyv3LJ/3XQJ7FGOd/tfogzCTF7XA72s899ZKHwrr6XRH+d
         cRsfDkd+8WJ+zAqyAdDsz/S5mUOkTkY1OSbNWplaZhOw6IkU2Z79WsihrHke33cMYUsz
         TRJ1C/fPG5jnVEcFdWcfGw5NmdvIYzYGDiHbYSPCTVTr2rhyzUl8q1rgeZb+e0eluxR3
         G9wQ==
X-Gm-Message-State: ANoB5pmC84/eAQkjTeN93fBE1wDLOafTNf/8hUsTc4pR/hetVVnxW3hL
        Po63G/deMTDLA69dJFSSzYHsuw==
X-Google-Smtp-Source: AA0mqf4MoH1HSqNJA4ePtfA3fPwshx9iksWo7cqliR5+Khm/4ty1EjBkEzzd3n/3CAwsiWwxaKaI6g==
X-Received: by 2002:a17:903:555:b0:188:8cfc:6ba7 with SMTP id jo21-20020a170903055500b001888cfc6ba7mr19416206plb.68.1670971557982;
        Tue, 13 Dec 2022 14:45:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902e74600b0018f6900a183sm399967plf.140.2022.12.13.14.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 14:45:57 -0800 (PST)
Message-ID: <639900a5.170a0220.6d0b5.160b@mx.google.com>
Date:   Tue, 13 Dec 2022 14:45:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc8-256-gcaa56805aa43
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 5 warnings (v6.1-rc8-256-gcaa56805aa43)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 5 warnings (v6.1-rc8-256-gc=
aa56805aa43)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc8-256-gcaa56805aa43/

Tree: pm
Branch: testing
Git Describe: v6.1-rc8-256-gcaa56805aa43
Git Commit: caa56805aa4387838eba9fc5577a055b81c8433f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

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
