Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFA1750853
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jul 2023 14:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGLMcz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jul 2023 08:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjGLMcy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2023 08:32:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56A6B0
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 05:32:53 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e97fcc60so4748132b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2023 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689165173; x=1691757173;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1rACnE74/tBBUilSh2kkRHaq0GaO9MP6PZWokReeRas=;
        b=jVUGgf6FXmqcO5IMP0cD0CQEcHYnKqxOmEPhAAY9uAop0DYirNcDVunSXGBG8RdELj
         ftR2y5f8bfXvLmpNllpl6gcn5/ipFPbjn+bU41MTJK0L6Uu96mNEu2D9jS3tNgqt2QC+
         SdDfNQkZkhsm7KSubQFN3YwwYAOTu05aXbCL/D9Nf3Vwg4kvyn3FRm9tZYFzVWTNA27T
         pLB9x+hTASECvJyuuLiUtDVp8h3WGWDsD7JDcKH0CHEUoO9j5vf7gDt9+Oxy5un+NjQU
         n3o6HA87jYoGFl7mr2aC/g75pN0qHprTz8XRjpBvqvpqSgb3YUKSWSlrnL1l+7k9wCZH
         AAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689165173; x=1691757173;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rACnE74/tBBUilSh2kkRHaq0GaO9MP6PZWokReeRas=;
        b=JhpsFZCUUFSie8XPWFLDdk9tTEg1vCg7YFLVqhYBYSstwQrwYV7ZSYFu0RiV23oG5h
         8n9VqhSb3/AcCTEto4E/WBTNGM7nJuvoW8Gp8Q26Bv72SiDZRQD2Q8WYfHFFnOAGcRdD
         vucAkp8wBU4XB4qEWmooMyCDDrTmAJKdSXtH6vNrPV8388aBp2yinOmWwUZhHhroufX2
         95ophs5SYVZwm0Wou/fchqZHYDLQ9MxZDnMFECGqPEwsZ5lAMGxD22b/hTOTlU8qMyqE
         bl9omXdwFEi/9hw8iUUN7feovFUfbLxm03T/j2H3hTYtm54vjaHzFX1TgJ31UhE4yILC
         bDaA==
X-Gm-Message-State: ABy/qLYPceleG+z4y4pCjspH0M6gUwR8r9VKfEFaw8obXmlosmPycGh/
        MbKRpNpUHfngEIiXeWzlG7dbGQ==
X-Google-Smtp-Source: APBJJlGTN6moix+7kTB6f3AFjZiuU3kefD+6UmHoGMMLPOx30M14vMDtuJPgzdhZToz9tRQ1BkRNrg==
X-Received: by 2002:a05:6a00:b47:b0:671:4b06:4ea7 with SMTP id p7-20020a056a000b4700b006714b064ea7mr18644718pfo.15.1689165173329;
        Wed, 12 Jul 2023 05:32:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h3-20020aa786c3000000b00682af82a9desm3614283pfo.98.2023.07.12.05.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 05:32:52 -0700 (PDT)
Message-ID: <64ae9d74.a70a0220.46695.72d0@mx.google.com>
Date:   Wed, 12 Jul 2023 05:32:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.5-rc1-21-g3c61a03588dd8
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 7 warnings (v6.5-rc1-21-g3c61a03588dd8)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 7 warnings (v6.5-rc1-21-g3c=
61a03588dd8)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc1-21-g3c61a03588dd8/

Tree: pm
Branch: testing
Git Describe: v6.5-rc1-21-g3c61a03588dd8
Git Commit: 3c61a03588dd8486041f484e9b6c48b2c9a69b92
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
