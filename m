Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0796E5EA7
	for <lists+linux-pm@lfdr.de>; Tue, 18 Apr 2023 12:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjDRKYi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Apr 2023 06:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDRKYF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 06:24:05 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97622902A
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 03:23:51 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b62d2f729so1301599b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 03:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681813431; x=1684405431;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eYNhea+/zB4CxtCeDnVb9v0HM4zMAkhmmLs+48g4bIU=;
        b=RpB5l9N/AEzXc26sclkqo+6UpTRGny1TLKCyWW4Rt1uVFrBI/0W4YHapeLB5i/Okqf
         FW6SMUe1RGyY5Lqj76bRz7V3WYATp2zqbIbC0x2vlWJILYEnEgzH41Il1w+4ayr2xhE7
         hoCYplI/bgWDJq6SBv8n3bjfpja4QN0ImzdXpg07Q6HuPi6oWUdHKjFpVBb5wn6jUuEr
         LR9rhmJUv5pYX3Zn6TLFAf9Ohmfc91d5pCtQhgXKLc5L6BHYPPc/tnYjc99QH/tssQJj
         XTA6dU7F0TlOFSIhScN46SLpOk5h/otwdsR83nCPBrn6cOxZVWqwPFTpipiSd8NAWlXy
         XLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681813431; x=1684405431;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYNhea+/zB4CxtCeDnVb9v0HM4zMAkhmmLs+48g4bIU=;
        b=S0fIxWS9IeNN0uESNK4VqkjG6ALX3QE9UgIDBUWgw3OiTtN8LK9+9rIvor8i/cRJ7Y
         FhzQj80UpA+fQcNCI9asZv+TJQY119uBI0Wt+qOIPmlnn1KtQPRUhuf1NHkTyR0rNMaX
         7RdIkdO0B4CtHBVAtwXWp59CsFBaTin2YUIKdZSsXYxWq475YQOr08jDlkwDShBWJrjF
         kHDvSuwtjCz2tY6aAEJnsJSmsr4xzSPHk5nUQ5awHu6zxETaV/ouJ5jUMLkRbjAbr6wu
         uEWDMTW8pBmFQZBpR1ntW9+5FGCoHHFAlOO+xqoK+60G4Uw/9m+7jAK628lcSd3r9OCC
         e6Sg==
X-Gm-Message-State: AAQBX9eEfW84jo2/LO95qslq/eXSDlrJ88awjWAKIpE7uyg/2c4GiGGH
        6PelaQ2BqdvDpfqLsQKJ8qfB1w==
X-Google-Smtp-Source: AKy350byN4BbhHXwYGRkZNdLhIVLrZSXmc1QpVZ5uwRu1sQoGOIBKjyq8pUEQc19Grmkl2IoM51z8Q==
X-Received: by 2002:a05:6a00:1892:b0:63b:859f:f094 with SMTP id x18-20020a056a00189200b0063b859ff094mr15133397pfh.20.1681813431037;
        Tue, 18 Apr 2023 03:23:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h1-20020a62b401000000b005ccbe5346ebsm8973622pfn.163.2023.04.18.03.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 03:23:50 -0700 (PDT)
Message-ID: <643e6fb6.620a0220.e6736.3162@mx.google.com>
Date:   Tue, 18 Apr 2023 03:23:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc7-153-gbc538c8be4bd
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc7-153-gbc538c8be4bd)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc7-153-gb=
c538c8be4bd)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc7-153-gbc538c8be4bd/

Tree: pm
Branch: testing
Git Describe: v6.3-rc7-153-gbc538c8be4bd
Git Commit: bc538c8be4bd17479f88f2e1a78d5b76b5523319
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
