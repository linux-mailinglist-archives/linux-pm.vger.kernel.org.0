Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C467D739024
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jun 2023 21:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjFUTfr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jun 2023 15:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjFUTfj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2023 15:35:39 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624B21726
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 12:35:33 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-66654d019d4so4932650b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 12:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687376133; x=1689968133;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SaM/ARZRXmNIO1rERWCYDDqr49MtjkWt0cyQvJ+XuBk=;
        b=gUPngyPTR6AbMbomCK1wFOAw3cdvoScpER59Sb29muFsQjNoMfDFY/f+BVvAf+J3+L
         01mfi+2Q0YAfLL9x/r2Q28DBCuBzELRwwbg47CBjr9D26asdAKxHUd/2SgUFa95nyQR3
         TQjwSGOLUxycVE0yDSpo+lKTosRTdbDoHIWhvikgV1dZHsH70hQW80jicjVaZR4dyDWM
         eNczLsajPIK7fQqnn2Cvy3Amy+bH3FYCM4uI1p9OoiA8u4ZRJ0a7lQMiNvf2dmzqiv7q
         x6wWribkaywbZ04uCMld/A9rcF849lSx4jtgVP8kCucSG0yhpVsv9rXEqud4Yhhh8Ok8
         o3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376133; x=1689968133;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaM/ARZRXmNIO1rERWCYDDqr49MtjkWt0cyQvJ+XuBk=;
        b=A06wimMAsHap3AIPCtVajxa43KFxL1rwMN3RZe2ToXwPtQZi2vveeiy2iJOWt1lWs6
         tBt8bjycEMlHeYzgQuW+LoH2hDfgSWQ2RJHKIdg2Ih+uWg0kIj063V2H6bxs0V7MxWbq
         cGatgcJnT1/PhuIbGNt8JfCLDKOrhZrqCHajzE8Fe00dfw8rS9unRkpSevmgh3vfTzv2
         eHa/IhLDgFPAHXr9QQSMVGWViuxRg0mWLqYSLq8EuNiTzlxdR9aCvm8VbaXO3bNqf0B4
         na8c0KvpLt9Dd4n/ychNBxCbYtkXbtJkx0OtnCX/AQjT5ZQqqAc+GM+xZj92jWaeG0Gf
         iF8g==
X-Gm-Message-State: AC+VfDw2wFgPrBwcs6U1rwMW2+CbshJAbygEzl4u+D/Ef12K12WJOH+7
        Kt+2VfTO0+gL2e+D+72SWqsr+w==
X-Google-Smtp-Source: ACHHUZ5ugAG/fxoWFCFgAZTfqgl3f5q36S0HRqmiW/Dd+3HFfwt2vGExRqHbyzzr9YF+IkGyplw8hw==
X-Received: by 2002:a05:6a20:7da9:b0:122:9e67:1d17 with SMTP id v41-20020a056a207da900b001229e671d17mr7177145pzj.24.1687376132785;
        Wed, 21 Jun 2023 12:35:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k23-20020a63f017000000b00528513c6bbcsm3480449pgh.28.2023.06.21.12.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:35:32 -0700 (PDT)
Message-ID: <64935104.630a0220.8d3f2.8450@mx.google.com>
Date:   Wed, 21 Jun 2023 12:35:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.4-rc7-121-g3eb3368746ef
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 7 warnings (v6.4-rc7-121-g3eb3368746ef)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 7 warnings (v6.4-rc7-121-g3=
eb3368746ef)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
4-rc7-121-g3eb3368746ef/

Tree: pm
Branch: testing
Git Describe: v6.4-rc7-121-g3eb3368746ef
Git Commit: 3eb3368746efcbc37e43c73415d2ba4634d9ce87
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
