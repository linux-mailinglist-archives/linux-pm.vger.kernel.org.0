Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E487A570F
	for <lists+linux-pm@lfdr.de>; Tue, 19 Sep 2023 03:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjISBmt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 21:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjISBmt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 21:42:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A2694
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 18:42:44 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2768239d2f3so901325a91.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 18:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695087763; x=1695692563; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I3/j66qw/DNBra5QQaoyF6rad19WB+iRKXwymM2GvZk=;
        b=GSG0vIALNG6v99zJ3NnxVbpe82mtQgXCwVjgdDY+8yi0opVL3iNlI7CStpO7gxpJIs
         DbdPbf9gdiOBki7NNOrPw9kbxSMJvp4n9tHliiM8qowkz+SJxmCeqVL0WVPfdC8eNn/7
         E0BDUtLaev6m7NsHpkMebWJ+6YCaX2KqCDvctz9d+URkIAS69tFNAfQsriXmYvJa8KV7
         Kg46pmO0zV9OrM7BloS+HCxPf/XWt41tpL+ls7thl6L6ECGYA6B1ctTwRXTfJU0cZPhP
         G/A56Sycj1V5eY0kmPBO6DUaYwzqBHaR7VRfOj6itrVsBtmU2UWjYt4NuvkkVuhMUSAg
         rDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695087763; x=1695692563;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3/j66qw/DNBra5QQaoyF6rad19WB+iRKXwymM2GvZk=;
        b=ADMVWaPGoIx3LEfg1YrCf5MX/hMyz/3zWBJ7cvpFJKADAk74ifhHPXoNKnUloPG42B
         4HLvDsovnoADCgZoQEnUY2c5Y7GRuW4We7P6iTbml7/NOg+ipgWanKV03L6TmtNwhlam
         3cTMvbmxc2iawzQ77Uw/atZyhMbM41RvE27Z4rO4yOKvUebtOiHeJDhjnmfxwbizbp4F
         5xt0GEISiJmEKT/7h1eerj3QNqAR9TMb7497F1NatmxLcoK9wRLF2i9uRtnuBFqWx6Ew
         DqJyVZ00giQvzOTpaB2y91U7YTXPGzdpwlorhU/L7SvS/0bRZc34OwfGhfXffsHwFebR
         aeEw==
X-Gm-Message-State: AOJu0Yzftd9BPgISGKwQNcDPXonQ3dmRP91uEPUXx06ZqbXx1VPqAuIX
        llZsFVz0XoA8j76TsyDvLVNlFQ==
X-Google-Smtp-Source: AGHT+IHWV+BadNDVUbw8REzqcjDsHSsOksBTMPqu0GKXgsxWhejvutPQcDscT5iUMD+9ZkQuwXNYQQ==
X-Received: by 2002:a17:90a:43c5:b0:269:85d:2aef with SMTP id r63-20020a17090a43c500b00269085d2aefmr9607573pjg.20.1695087763469;
        Mon, 18 Sep 2023 18:42:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090b068500b0026309d57724sm2624910pjz.39.2023.09.18.18.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 18:42:42 -0700 (PDT)
Message-ID: <6508fc92.170a0220.e9d11.915a@mx.google.com>
Date:   Mon, 18 Sep 2023 18:42:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc2-10-gb34108fa27bd
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc2-10-gb34108fa27bd)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc2-10-gb3=
4108fa27bd)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc2-10-gb34108fa27bd/

Tree: pm
Branch: testing
Git Describe: v6.6-rc2-10-gb34108fa27bd
Git Commit: b34108fa27bd31c2e82b5f41c55066d83822c7b3
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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
