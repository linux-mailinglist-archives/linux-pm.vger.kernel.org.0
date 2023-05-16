Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECC5705A8F
	for <lists+linux-pm@lfdr.de>; Wed, 17 May 2023 00:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjEPW2K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 May 2023 18:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEPW2J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 May 2023 18:28:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7614B5FC2
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2023 15:28:08 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6439b410679so27588b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2023 15:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684276088; x=1686868088;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2/loL5bcJOP1ARfiWoWGdJ8uVoyyZVKs0PE9UcxpwVE=;
        b=0S3Exdt1kggvtMoGT/gUDC894QPreBMXMbv8hWO9JsSbtVpnN2JfL+hJIIDQ1gJoeS
         KPe5DdQND/k1KxKmKCmIsUsihJP6c6uWXFIm8HxZZziewq4waTbUlfNBCyS2J0sMz8R5
         5bDD0PzQaOsdqcGAFilQwMGWJ7lhQvs6lLubZkYIs9nO4zCM4GK1z4EJpBVZcH/uetyn
         /EfFcJtenba1vAX4O4tdofF88Ib18BPBPPJxB+/Qn2kH23cuZZ0zSf4Fx795dJdQW/4M
         0/uKGD0Tw1WdGEbhQnck1Xn+RrcR9SRKW+MkVw1BttB6U297eaXXAb3NwbFCn5U3YwuE
         8Xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276088; x=1686868088;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/loL5bcJOP1ARfiWoWGdJ8uVoyyZVKs0PE9UcxpwVE=;
        b=XMBfJMsPIkfQatO1sP+kJcrsHH8eyLZuCx/yU3eyekGL1QI/3ZZoDN1wQtbE0WCt8X
         YIFq6CXc9oOSEodWtRlGfY6x/UjLx0AlDAIF/go8whekjXOlP891Vp9hVJ4LWniN5cjW
         0sQ/cTIqNT3gcWSdFwT8t5AHNRk5li83Zaz27HzTJbELHPqYwrjhitVT//wW9mM60N0y
         ryKyMq6yQHemqXnekPZ3SCb1Dp/12/ncekNXSj0UINUpPKV9vp/zgziZVZbab/zplhPr
         1EBDpVpOOBLZPwFnp1afezBf6S9g7oFnAOycaVa6LtvLnBj9gxb8iUsJUORFyuemv02H
         PuoQ==
X-Gm-Message-State: AC+VfDz4O6q7WuWIPVou8yuJrU01lvh44WYSEzpH7gYG/tNeR3h7Ywn5
        uHfzMtVZZjhNLKBBuz2LMoTVFEwsqdMyOmzKHHDG+A==
X-Google-Smtp-Source: ACHHUZ7VpzFdtPXUumyYRRLSRf3+H4hcGhiALkVICsPt5+DY7MgV4rzqzOMNRcdC8OzU83LJS9nnXw==
X-Received: by 2002:a05:6a00:2285:b0:64a:5cde:3a7d with SMTP id f5-20020a056a00228500b0064a5cde3a7dmr26172642pfe.27.1684276088002;
        Tue, 16 May 2023 15:28:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7804a000000b006328ee1e56csm13979590pfm.2.2023.05.16.15.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:28:07 -0700 (PDT)
Message-ID: <64640377.a70a0220.9f087.bc97@mx.google.com>
Date:   Tue, 16 May 2023 15:28:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.4-rc2-4-ga3c2d8b60e2f
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 7 warnings (v6.4-rc2-4-ga3c2d8b60e2f)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 7 warnings (v6.4-rc2-4-ga3c=
2d8b60e2f)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
4-rc2-4-ga3c2d8b60e2f/

Tree: pm
Branch: testing
Git Describe: v6.4-rc2-4-ga3c2d8b60e2f
Git Commit: a3c2d8b60e2f540d2be15247beb23d60872eafa1
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
