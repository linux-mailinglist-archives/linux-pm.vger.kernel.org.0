Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C3F731E91
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jun 2023 18:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjFOQ7Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Jun 2023 12:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFOQ7P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jun 2023 12:59:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C735511C
        for <linux-pm@vger.kernel.org>; Thu, 15 Jun 2023 09:59:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-66615629689so2418746b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Jun 2023 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686848354; x=1689440354;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p8eJqGDDZQQkpVTH7Qi6O0PKLIL+YaaevCASUEfH9dI=;
        b=HX2sI+ZXoO4yLMkvS8dLjzuf3DIpV59xzvcJmhOZ2kzBDhTy4Hy6EuG2l1jJLb9mEV
         5vSnD6t+nPx+n6r3HC2oPkXaW/RCQVGpAULVvzphrIhGv9N7YBhVSLMf2p6X+UnzNUFX
         nukXBrMI3/d1gHLrIIlsBq4A3+0n6PtS723FL2vQvZTKsXBn7wNT5CB3OBSqY+tu83PU
         RnRcn8m8yLLWCTQc0GV0cNHXoa52xe5aQ13OUJYbXSUFAP6ElsDzkgL0z4IlS1s+NjX5
         +ooti0R+5ymM01aKdfTbAdGGvokLnLaBnRIEiGySF/WVMaUQHIcgCZeaoEv6B6Vvsgw7
         qBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686848354; x=1689440354;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8eJqGDDZQQkpVTH7Qi6O0PKLIL+YaaevCASUEfH9dI=;
        b=S0Zr4cI7OFoXAhFBz66MmwGsQw+79WMkMPytVFrcn1SHg/UgFqusxKhmPnNpTCMKGZ
         L/RsqWi98wCywLD54TsvHEH29E9/yRKzhkvdy1OydWXjvAH1URT8C1Y4IuwgWUhc9pVt
         igi5hDPdfzBte0L7T6agDWUCnmQ3jk7IHtv29us6zDF5NI3kTgJNK4QK1X44IzDbrPou
         P9QGFUKIpXpshI2VkW31OP2wdQ6M5UwXO3zxDDSSZXhiklbKue5tqSeCz5/U5bFvqOYe
         +JU9NFBQofY8USXfQAD4Z/tEOrVe0tUXk2Xo7MVipRzW66KhwAZ6KtA6gHwN9ffnpFtH
         vc2Q==
X-Gm-Message-State: AC+VfDyMGaji9I1O4bem4Sc3LbFe78LsUz+uRUXvAqs2Wjgzfn0cEIwg
        Zcd9aG0YrVMOgxPXPTidYorpyQ==
X-Google-Smtp-Source: ACHHUZ5NYpxxjc7oQzj4im7S3yc9VVP2bUeHJ/nTSRxTuIQw14qhOkftJHaDYRW7uN98wtg61ZdNJg==
X-Received: by 2002:a05:6a00:1405:b0:665:cbe7:b2e0 with SMTP id l5-20020a056a00140500b00665cbe7b2e0mr7278070pfu.0.1686848354172;
        Thu, 15 Jun 2023 09:59:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c9-20020aa78c09000000b0065fd8075ba0sm1164241pfd.212.2023.06.15.09.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:59:13 -0700 (PDT)
Message-ID: <648b4361.a70a0220.999fd.1fe5@mx.google.com>
Date:   Thu, 15 Jun 2023 09:59:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.4-rc6-65-g06c8e224e0039
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 7 warnings (v6.4-rc6-65-g06c8e224e0039)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 7 warnings (v6.4-rc6-65-g06=
c8e224e0039)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
4-rc6-65-g06c8e224e0039/

Tree: pm
Branch: testing
Git Describe: v6.4-rc6-65-g06c8e224e0039
Git Commit: 06c8e224e003919993b1ea1c7ef6fd648725b004
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
    1    vmlinux.o: warning: objtool: .altinstr_replacement+0x17a8: redunda=
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
    vmlinux.o: warning: objtool: .altinstr_replacement+0x17a8: redundant UA=
CCESS disable
    vmlinux.o: warning: objtool: iovec_from_user+0x88: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled
    vmlinux.o: warning: objtool: __import_iovec+0x147: call to copy_iovec_f=
rom_user.part.0() with UACCESS enabled

---
For more info write to <info@kernelci.org>
