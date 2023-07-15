Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D7D7546EF
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jul 2023 07:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGOFZy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Jul 2023 01:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOFZx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Jul 2023 01:25:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0BE3A9D
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2023 22:25:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6687446eaccso2614984b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2023 22:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689398752; x=1691990752;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vdo+C+1fWXjk8Ohj5yRKTaLmvSu1rejI+vRCMhnzhFk=;
        b=KxszXb3YYtZAsj93sJF4mxy9/cs0xKF8WZqG+AoqaCMkJQxuDl443J1hsQjcr6uk5H
         H6SLg3vtXOvD3Zk1olzE3n6Pqv3Bq5PGaIUkWaXEbiVNwisaCKaWqC7puAC8/S5X+28x
         0zxFdu1sCdk3oRgIDV2FYYeG30p4MY222SSZOuF0+/g1gsUM5HBCiCQkoyAjjcXFsepK
         FlH3/+W9JHMgUQQUeiTwOugC5/6dn1WOwBrvKlPTflNTy8207mN7mWepejPDQjHHZwmo
         xtlJ6ku7YJUE2UPFqUh0LMIzb1wTHT1KECKLDR3eufj50jTC98NCF5J/0qERZh4l7r6M
         mrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689398752; x=1691990752;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vdo+C+1fWXjk8Ohj5yRKTaLmvSu1rejI+vRCMhnzhFk=;
        b=kJT0SvsFheWF5IkletFYQEyANp3XFgJjsi3vmbr1i++DS1HXoJz2f3PgQZpcgRQOV+
         lA50I9ta5naE19MmvTSyCTMj0NOf7KVuuSa027gfxOHCY2Oh02C3+GcoZApB7Fsy7wHp
         +A2VH2UkUXLV+mk3QzB4oyzvfuCcgkVFvZySxlf1fuGlJYwW2Qlciu45WlyPiIzyRzJp
         pRGchDg2YuiTPxDQ7kiJ1LNvEmhlZyLXQcTLCHJs6Zew5I30G1HuTy0GonHATOYDSCgM
         2+jxIA8y1nhh3RywuVntQUVCv/A/9qpUeiISBtDqOXJvX5yrA223fTgpeamhapBT3jwq
         Zzvw==
X-Gm-Message-State: ABy/qLYkmZ62AOPysV769Gkevp+EEn7zKiMliRbDOeNFeU2Dz99q/+2J
        Wj7XgKmzeOUZi4/5k1MNTfs2dQ==
X-Google-Smtp-Source: APBJJlHbhMvZe8eAX3cgYqJjdhkmuL36hxbcrhBYCr34ou+Hfn7e5PnVpj4i47DIVsSvUke9MP0XoA==
X-Received: by 2002:a05:6a00:2e05:b0:667:85e6:4d1 with SMTP id fc5-20020a056a002e0500b0066785e604d1mr9118545pfb.33.1689398752113;
        Fri, 14 Jul 2023 22:25:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u15-20020aa7848f000000b00663ab37ff74sm7951796pfn.72.2023.07.14.22.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 22:25:51 -0700 (PDT)
Message-ID: <64b22ddf.a70a0220.919bd.194d@mx.google.com>
Date:   Fri, 14 Jul 2023 22:25:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: pm-6.5-rc2-210-ga648a2d354da
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 7 warnings (pm-6.5-rc2-210-ga648a2d354da)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 7 warnings (pm-6.5-rc2-210-=
ga648a2d354da)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
6.5-rc2-210-ga648a2d354da/

Tree: pm
Branch: testing
Git Describe: pm-6.5-rc2-210-ga648a2d354da
Git Commit: a648a2d354dadbc6ccd5336fc81df66c06d80d87
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:
    x86_64_defconfig (gcc-10): 3 warnings


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    1    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_io=
vec_from_user.part.0() with UACCESS enabled
    1    vmlinux.o: warning: objtool: .altinstr_replacement+0x178b: redunda=
nt UACCESS disable

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    vmlinux.o: warning: objtool: .altinstr_replacement+0x178b: redundant UA=
CCESS disable
    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled
    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled

---
For more info write to <info@kernelci.org>
