Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C7E6CF01B
	for <lists+linux-pm@lfdr.de>; Wed, 29 Mar 2023 19:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjC2RFz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Mar 2023 13:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjC2RFv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2023 13:05:51 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E5F4C33
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2023 10:05:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id iw3so15572638plb.6
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2023 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680109548;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4mRc/BEFgQg1VtRSgRcMJUt1R0yc+3GsW0Lo0tWcZ34=;
        b=r37VQuNRDpl5UBcpaDS++HPX9Ltltgw4nKF1QQeXnhOAE3c9XW8g32sN+oMo5KKJf9
         7bPUNeBaRqulLxWhRFyuC7jXEcQP+QrCWuCSSbzL6ZqeXiI5mTt6CDZZAM7R4q6wiNTy
         Dr0TV7cY+tzpIKWvJMQVRghL/fgpWefhWJRh5rpIoTyQY5EwiV3xo4pu9U5+RmWARKII
         f5OtUUuJcOm+EXDLwNFSru1VMHJCEbxDKOwCPDwdD5gfM2AIvIoonxyFro0pIQGDMo7J
         SpvNvPL0AsEPCX4yGC0nG0ssVrSxbrgZiLgXx5LjhfxUtwnZg0fS3IhgHC1SHbxgIQIT
         I+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680109548;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mRc/BEFgQg1VtRSgRcMJUt1R0yc+3GsW0Lo0tWcZ34=;
        b=HC0FkJpJlT4yHAC1WBVi+8qVTr6mrCBh7+X7bpn2+T81GvxRMNbMwC/M6nshg/I4rx
         84LRyUWjjRV+70wPsHPgWc7B36+tZNXBo6q+nMWCuGy8FG6NLk/Bx3sNjuIF2XAI8nil
         bTIC7CrQ/ZJ2Hl6IOBPmlJzoue1r7bMo/L0laoIoX+e1Cf/YpMJ93LqZj5PF0xHTqqf9
         UBAf1BqtElvBXTWT8tEjdVFmoh+jgXTlVMQYc7XNhMfIL9hPGrEpHH0SA8I+WMDeG+Fi
         ABYdYpX4uZnvC7x9nGoE+XKs82/z3YwG4sQa455dxldKlAUBMZT0Vr6zyEDe4pL7SU6Q
         o9Ng==
X-Gm-Message-State: AAQBX9cl7EnVeUNTnBlpzsAD700i0OkTPLNa9jh8diNwVUZyAJcha1Yd
        vggyLWuQi+SR9C1po6zjojptQvYIU/1NkFo9AvGg1A==
X-Google-Smtp-Source: AKy350Y0CjX4zGtfV67LaR0XEZnfq4WvCWuhMOaR2HwXfyVKRDezTtYJhZHQzK5EUlUSvLyARBGZTA==
X-Received: by 2002:a17:902:ea0e:b0:1a1:b65c:dea7 with SMTP id s14-20020a170902ea0e00b001a1b65cdea7mr23743111plg.47.1680109548630;
        Wed, 29 Mar 2023 10:05:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bi11-20020a170902bf0b00b0019f11caf11asm23309370plb.166.2023.03.29.10.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 10:05:48 -0700 (PDT)
Message-ID: <64246fec.170a0220.faced.b6cb@mx.google.com>
Date:   Wed, 29 Mar 2023 10:05:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.3-rc4-59-gb6c50a785821
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc4-59-gb6c50a785821)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc4-59-gb6=
c50a785821)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc4-59-gb6c50a785821/

Tree: pm
Branch: testing
Git Describe: v6.3-rc4-59-gb6c50a785821
Git Commit: b6c50a7858215b7aea9958979c0c15f2f98de0fb
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


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
