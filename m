Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED939709BF4
	for <lists+linux-pm@lfdr.de>; Fri, 19 May 2023 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjESQDL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 May 2023 12:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjESQDK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 May 2023 12:03:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFB1E54
        for <linux-pm@vger.kernel.org>; Fri, 19 May 2023 09:02:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2533ed4f1dcso2426705a91.1
        for <linux-pm@vger.kernel.org>; Fri, 19 May 2023 09:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684512173; x=1687104173;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rfm/FGUzQdVarUHdYxKLNGZn0PqUyOmIcL4mG9U8ljg=;
        b=MA6PWk57KcWsLs2HkR2GWLiRyeAXVK4bpllmM7Urwx0tfdaAPOn30nBK7DV+43lyEE
         wnNyvIA3sllu/+hdvyDx0g+i3GImhfZ+OaEQqPMdT1FEIP7Lspxq4ZyXpITGBqdIXuqV
         //WiEKZB7I6UI5DyV2nXp/tUgx3nsHzz3b+sYYnHvKCDjekbgSZgO2VjnSmEa90XBaxk
         1GABt+/kaVIlJaoS2ZY/zpu4gH1yJ0OVih05QTETP1jC9koEyKecKcxLAVd93Ls79l6T
         PuxM8yP2o4aCWz2I/bBuYYBdZmH91NyEykwSkLl7eBCd+BBTE1xKutVVhbufGbjQg5HS
         opfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684512173; x=1687104173;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rfm/FGUzQdVarUHdYxKLNGZn0PqUyOmIcL4mG9U8ljg=;
        b=Fr4czaokO4ct9ahqnPsweyMzK0U2GI6CA0FR5qMR2yZ/HYQ4RTHAvpcKYNbIFdYNGE
         27qLzRPVPbQ85MuCNjKvB92t/oFFATwaTEOgHdYtw/w7ufU/CMfAUpMIZP0/a0BC/qj9
         rHU9yKy+vSwi7gufr17arSotIicr634jvqjmK25rWy+SFt1QIwDMAP2I42gk2eTZBYeV
         qawlD7PL67IrTbe69YrvfUBpWFmuQrLFy4rSpplUNaydtDdN/Ai1MeiQqbEDUyLv7IqU
         WVVni1BtuoAnswSndVPSd+a8Tkrxklf5YXe57kkyi4+w86Zwd0J/0ERQ4qEnQ8Gt8/bl
         FoPw==
X-Gm-Message-State: AC+VfDxuPm+9fvW4NyHCk5FU3/TY7O8YG7OiFwMSRaIjkvd8F7sO1fmM
        7pV7YbV2VWgCmF63z05nbYPc5A==
X-Google-Smtp-Source: ACHHUZ6AAlZ6G6TRA3qKrglEgO3J8OHdaQTY4+7u0zOKjyWXraJkFScJoMOnA6WYpRvxOLy6usM/pg==
X-Received: by 2002:a17:90a:6484:b0:253:971b:dd1a with SMTP id h4-20020a17090a648400b00253971bdd1amr594033pjj.9.1684512172651;
        Fri, 19 May 2023 09:02:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x13-20020a63db4d000000b0053449457a25sm3249006pgi.88.2023.05.19.09.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 09:02:52 -0700 (PDT)
Message-ID: <64679dac.630a0220.e35a0.5dd7@mx.google.com>
Date:   Fri, 19 May 2023 09:02:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: acpi-6.4-rc3-14-gf677d4bc2b910
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 7 warnings (acpi-6.4-rc3-14-gf677d4bc2b910)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 7 warnings (acpi-6.4-rc3-14=
-gf677d4bc2b910)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-6.4-rc3-14-gf677d4bc2b910/

Tree: pm
Branch: testing
Git Describe: acpi-6.4-rc3-14-gf677d4bc2b910
Git Commit: f677d4bc2b91058f37c5fea5c3bd7485db31f794
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
