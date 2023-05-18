Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC83C708AB8
	for <lists+linux-pm@lfdr.de>; Thu, 18 May 2023 23:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjERVtP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 May 2023 17:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjERVtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 May 2023 17:49:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8156818F
        for <linux-pm@vger.kernel.org>; Thu, 18 May 2023 14:49:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae408f4d1aso20586125ad.0
        for <linux-pm@vger.kernel.org>; Thu, 18 May 2023 14:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684446553; x=1687038553;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iqx+9pV/YF/b/kDTwKh2bTt8NX/PCVLKC1HVp4fvZVo=;
        b=rzcgIxzDs93HjZci2UY9/fVNE6wr6i9iR/knLUvVwJT84MTCWd9+s5ndTRcBFzArC7
         gQ4cwihooRbJlh714OS3WYHJcTFarLo+POppQ1C6PjPPgXKGAIUJrh2QI4IogtEKIgZS
         qybKLiObFGsspxxj+WNC66sXTnS7PeKI8OgqQQWhGWynN1qgtm+J3ZwoanbYDW9VpRju
         gksuUMvlFX/bPGfHUihrnf8W+jp4rUlFssMuU8M5yYpi+1BAdSe8FlDgTgKHR/v+YR2c
         PVXcVANEwdD9FiSP+UuNy5E8aUTajmDdKWgN5z4QSGLlyiR1K5UDa+B//e/TSKACL86u
         V90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684446553; x=1687038553;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqx+9pV/YF/b/kDTwKh2bTt8NX/PCVLKC1HVp4fvZVo=;
        b=MIbszLQG+lgRvmVpBHk1dBsUruUu1s4JEAphwVDG4R8SoDl4AB/0VX4mSh0yamSYGt
         xO4/b9k6hgIe11dbxQzPnz+B3Xm4JwZoJm6stc3vnzEqOCt3ez/owVTilit9t3fwNwgZ
         fDET7K60e/tK+6jnnnXdhGy41Y01cj1unrQAzNda5ZsAk+QuZHuIYH8U003l5UnSecyn
         Nb0eHLWz0mHlM7hHO1fuQ8DXh6mZKf9IcHRTqWpc70v8NTN7JH0SWYtyIrHD7sKsjMBM
         7oHKgR8PtTL5kQuRDDCHY0r8cIM/ZH2+91NDqm0b0yuV3W0xk0KnkA7kiSR4pxRBWwnp
         bShg==
X-Gm-Message-State: AC+VfDyFjVOlHoviK/VzdzFwxyC+7EC29iubiV9JbHZ+1eD8oSozFQnY
        mI3IcmVNMmbvZa4f7ZLN3cTKtg==
X-Google-Smtp-Source: ACHHUZ6gVTyvI1pnnXfyguOz0f/f+oJQ9pib65fzjy99ooAnm/cF1R7cJCCJiFHDQxn+IN2XX02AcQ==
X-Received: by 2002:a17:902:e749:b0:1a6:3ffb:8997 with SMTP id p9-20020a170902e74900b001a63ffb8997mr536801plf.42.1684446553025;
        Thu, 18 May 2023 14:49:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jc6-20020a17090325c600b001ab09f5ca61sm1950596plb.55.2023.05.18.14.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:49:12 -0700 (PDT)
Message-ID: <64669d58.170a0220.38b00.391b@mx.google.com>
Date:   Thu, 18 May 2023 14:49:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.4-rc2-7-g150ab364fade5
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 7 warnings (v6.4-rc2-7-g150ab364fade5)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 7 warnings (v6.4-rc2-7-g150=
ab364fade5)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
4-rc2-7-g150ab364fade5/

Tree: pm
Branch: testing
Git Describe: v6.4-rc2-7-g150ab364fade5
Git Commit: 150ab364fade572a52bfef4cb6526b441cbce352
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
