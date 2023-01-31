Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10D7682A88
	for <lists+linux-pm@lfdr.de>; Tue, 31 Jan 2023 11:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjAaK3x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Jan 2023 05:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjAaK3t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2023 05:29:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29592E809
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 02:29:47 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so3622443pjd.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 02:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YskwDm45SjS44l97atx5lvuJnNQrrONYobnEgOE/jKg=;
        b=NTOFC5O8N0edbb8MvYRRNOVGZ2tRM8CJVGb8OoftWR9GmgELmE0r51wNb34tHF390S
         5MAtINVoWxtlAr8qn+quwrUtC8rPu96Z1i6ZxPaWXGttaRoqHNDSSNlukBswWkfLyt5V
         GZaWaU1ocDNAlmQzxMuUwjLDtQVJfdNZMEhYPbH30S1GeKYmWN35DmRL5jefXU9uW6H4
         onMFnzuBpPIVERZ3K6kCkwvxZ1Bg1e0vXKR5mQeOc1ZvkqiH2KMNKwbhk7pnzUKgXh6e
         cMXZS2/YKTuG386Flfs70RH8zqk7WsqN3aPjU9/CZNY1n6PSIgAfeNqeV1aBEO9cLTK0
         BqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YskwDm45SjS44l97atx5lvuJnNQrrONYobnEgOE/jKg=;
        b=egP4tQk+y+1r8D0Z6FyNOzU+mVjSPLjcOt+wzayjFfDG/yYHW2E5miK2k+8a8lX2vC
         ivSzN5hKyhBFt/n1dukqGYE6Rei9bOhkUwXyMUTlXl+H6WFzXtPWB1n21GUecHt3pG/r
         CsRyQgE5JVKmg8aBz5Lwa6dVsVWcVsmrcqlHGLZQVOhrOJjGs4zawTbK5vfNSFyY0O4d
         RGTwYxP/12XiArywJyEwzTx2NgLKvE6ekv8qhle6GRpAnUlBTYNwkarNTgOl37/j2lHr
         Y/a8DMjJMkAOJVBc1g6WmL+7+/lMXZ2lB3IgTiIXZ4N/Jve7jPsu1xRR9oFa75Eyv/qw
         SEIg==
X-Gm-Message-State: AO0yUKU1sr31bqUm16MHwhSEAkDP2gZLboMUVClqfdJs+D5Zloc0t2bB
        /VDtOShLx3h0RiG/dXmIBJ/824b6XQ0Y17CvCZBxQw==
X-Google-Smtp-Source: AK7set9pUnAIdRCv/SF8omXhqWumRQDmG7YUxSACE7cAR2qqkbk4Lzb+fna9m/dXq9acBSX6mBYCpg==
X-Received: by 2002:a17:903:246:b0:196:288c:d35b with SMTP id j6-20020a170903024600b00196288cd35bmr12552238plh.10.1675160987480;
        Tue, 31 Jan 2023 02:29:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090302cc00b001743ba85d39sm9437856plk.110.2023.01.31.02.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 02:29:47 -0800 (PST)
Message-ID: <63d8ed9b.170a0220.8498f.f50a@mx.google.com>
Date:   Tue, 31 Jan 2023 02:29:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc6-139-gab970ed365c9
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc6-139-gab970ed365c9)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc6-139-ga=
b970ed365c9)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc6-139-gab970ed365c9/

Tree: pm
Branch: testing
Git Describe: v6.2-rc6-139-gab970ed365c9
Git Commit: ab970ed365c92d08f201e4652270de915f965378
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
