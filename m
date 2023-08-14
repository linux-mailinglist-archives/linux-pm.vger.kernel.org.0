Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37F77B530
	for <lists+linux-pm@lfdr.de>; Mon, 14 Aug 2023 11:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjHNJKS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Aug 2023 05:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjHNJKC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Aug 2023 05:10:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711C612D
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2023 02:10:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bdb801c667so22874195ad.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Aug 2023 02:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692004201; x=1692609001;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tg/ct15gON+aTuCTb3gmEuKuRcR3lbNSrQqYTTUKA0Q=;
        b=PY8PsXiJgR058hDbgF/CSrKr333ogYBCodtDHBLiKvhjYyLkGSvTbhicdHiMpbFby9
         WOLRUmZ7VZA0VR3y8RH1GEXs5wV5X3ZhG2pKB8+ZCs9oAeEYMnlzoxi3tpIhxu32HJWa
         PQuQP6b18JKExV8kSyjQA17qHCJi35W5MeH7HoZ16pkwZ4QhXwJBSudhadBvCu8Pzy3H
         H8zmlx5B2SuF4eMp/aWEGUhfKLAFD88RbBMPQlOwORMN18bAd3/H6Y0odtSvn6JSJJr9
         WaGK9FXIBrDRqmGtnTAfB9w3dfqIsGOWnR655/+S+Or3QUrtunbm7lbD4YjjudfTFVvv
         UG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692004201; x=1692609001;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tg/ct15gON+aTuCTb3gmEuKuRcR3lbNSrQqYTTUKA0Q=;
        b=D9m/UC+ylLeP4CFdwQphbzcA/ZslMqFoTsk+20/crlxlhgdW6hWI2qygHGzTGeHeKj
         sRtSyJFm0CarholHj5MqexBfgzEAwgIU320Aq2R27azgdX/KNSZ7aZbjohUjJjydSAnq
         e0kjP3GM+pcVusaLy2af1UXO2K9/oItNcVve/ZH1giFWuczFMWoJMuhdRdWAMjIRsWMs
         OPbVQgaAc82uNQFz8zsIYZV4X+Jdm8/zXt2haoIKDjWsnP9Y6/RRU+da/hWCTHXLm8Zh
         DW2KYv7FOUpx/MTRuOwDWDQr8C/eJ1KW3DY0JZZ2DD/C24K1txoKVPorR7pdzB4CYJ/A
         yJ8w==
X-Gm-Message-State: AOJu0YxRM/EIIjNCN8XRppYOg5Y+3OjfjIgeLwqDUoprRG6AU721DHUb
        9dEXZdK3ODH0JKSN1LV/BGKLUg==
X-Google-Smtp-Source: AGHT+IG8L54tvNH67pLfTqJqvUmx734k9lRaX3graMLtA1ViY9bAjnH423ULIAtLPfEOK6syM4T3sQ==
X-Received: by 2002:a17:903:41c6:b0:1bc:2f17:c628 with SMTP id u6-20020a17090341c600b001bc2f17c628mr12377646ple.56.1692004200788;
        Mon, 14 Aug 2023 02:10:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jb15-20020a170903258f00b001b8a3dd5a4asm8914137plb.283.2023.08.14.02.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 02:10:00 -0700 (PDT)
Message-ID: <64d9ef68.170a0220.fee41.f11d@mx.google.com>
Date:   Mon, 14 Aug 2023 02:10:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.5-rc6-81-ge8cde28ba5123
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.5-rc6-81-ge8cde28ba5123)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.5-rc6-81-ge8=
cde28ba5123)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc6-81-ge8cde28ba5123/

Tree: pm
Branch: testing
Git Describe: v6.5-rc6-81-ge8cde28ba5123
Git Commit: e8cde28ba5123d05b6d2639ba8e0a3e0b96b37e0
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
