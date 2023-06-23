Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4B773BEC4
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jun 2023 21:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjFWTYW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jun 2023 15:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjFWTYV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2023 15:24:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D96E7D
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 12:24:20 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666eb03457cso631947b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687548260; x=1690140260;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ggsIjsBlxsoae5w3QKz2Dc5ZyJuWyjyAkrJ7NdwkQnc=;
        b=XcZyu0DlzXloPCE7oC5QQAyLhFh927h6Ww+in+PEInaoDIXtac5idMLYx9pnIkzF8Y
         vojQSTcT3EooEiN789HvN3LN3hoskaJCdNR/lWC7pnYRXFwH9fkjK1RFagn2+0+LFLpu
         aEfQ3BIGsZl9/w2LVAQFWoKhMQT0iguT8qRKtQztYwbC3gSsFHsdfOWX/KE7zvGDWJ8D
         ZBzLVTevZ5GhbFbPnXAn5c5J2BoiwmuN8VX44P5PpE1pdwIykYrtr1VALwOC+E8KLNSB
         ykOcp60+8ObyvTuhknQkqHnqR2ouA2ofF5ntRGGYu1LsXhLfFwHS/7W6cJKTOH6s+NrG
         Aryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687548260; x=1690140260;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggsIjsBlxsoae5w3QKz2Dc5ZyJuWyjyAkrJ7NdwkQnc=;
        b=byLazz8Ej8NW8pNMs4faSXQDbpOvSJ3tmV64pmoGGxbcMcaymphC3Y96bQ1L5O4rSM
         Mtle5X0INpQJR1zY6X8BnT7IY3e9GgXcQg3iTegEym7jnGxjgxKf1YxgJpAuzN8gO9YE
         DgvtVMYtPHEV403VhEnHjFOQO6x/o6t4LSNMCBIkQMSz50bHEdpUXOlu6vdgXjxeziwA
         LXhGm0Waipu/fZe36lvtkJnpqbvPVgB7aKfkwowwhifDFzt96CnJEYL1offb/a9eCmmZ
         a1R6+UIsFZp//2HWBUE1g8Oae0RDVcT9xAQyY7zMhO4KAdmrVXXKNckIsXp0rG+DFS6M
         v2zA==
X-Gm-Message-State: AC+VfDwgXmE8KPLWnqYtVeg8rl+LX0rm3yxsX3PY9F/2LPsnTQhEmMRP
        iPpR5+z1lsGx3fSt69XChPft74plkzLMpShs+//nWw==
X-Google-Smtp-Source: ACHHUZ7GEE+Km5HMGtC9hL/p//DzQcpy8RTSx3Ud3cX9YEWpDkag2FoPUZ+pvPwF/ve/wuS0s5NVbQ==
X-Received: by 2002:a17:903:124c:b0:1b1:dfbd:a18c with SMTP id u12-20020a170903124c00b001b1dfbda18cmr24438plh.39.1687548259739;
        Fri, 23 Jun 2023 12:24:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ea8200b001ae3b51269dsm7516672plb.262.2023.06.23.12.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 12:24:19 -0700 (PDT)
Message-ID: <6495f163.170a0220.5e2a6.13d2@mx.google.com>
Date:   Fri, 23 Jun 2023 12:24:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.4-rc7-126-gf28ec6369334
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 7 warnings (v6.4-rc7-126-gf28ec6369334)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 7 warnings (v6.4-rc7-126-gf=
28ec6369334)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
4-rc7-126-gf28ec6369334/

Tree: pm
Branch: testing
Git Describe: v6.4-rc7-126-gf28ec6369334
Git Commit: f28ec636933467d6a13cbe9f37d97a74d13484b2
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
