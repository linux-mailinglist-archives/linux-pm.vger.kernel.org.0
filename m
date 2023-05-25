Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E510711899
	for <lists+linux-pm@lfdr.de>; Thu, 25 May 2023 23:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjEYVA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 May 2023 17:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEYVAZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2023 17:00:25 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C5F195
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 14:00:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-25533eb3e5dso168847a91.0
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685048424; x=1687640424;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=swKmr+zPlqFk0w2HEdubha8oHaV+iGC//6H4l1unchs=;
        b=IXmFgKVWC8u8moP6qd8UD27c87Zt7/37TZUU2oy/+k5qTjIAGa7Mx7r9zpyIhjicCs
         zhW+0udAhbb86ZyUNbHBzVFgaPHN3BBoE6svQ/2e9R3LUvn9N3YXBzZ2obb7+ErmUJpM
         cvqn55nVDNMOHHBbMn3I5i3FHctz4XoWBXwgTgI0d+mUQCRBBHPQQYhEijlJ3CZrdknx
         yuXoZBzu4+XuitcVQnbDMekLPjSlHhr+cqNOlCs7HpwQ491BpFJxh7/CapIsN74/7o6n
         VLlzG20lgLpldvWOb0Lo24cam7gTXxIhfyK/b7aiNWMlawcLEBaodhVENRcK+XjhIHlK
         IijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685048424; x=1687640424;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swKmr+zPlqFk0w2HEdubha8oHaV+iGC//6H4l1unchs=;
        b=h4tZvT7L0f4G46/BQFhqlSCq21DC/1hnwtm7PzxUAVReEzN9bKr0I4HjNSB/UyLzVS
         03nSuLeWxy2keQsL9C1APo54LP2dMMzAv5HLIMS7hUhCqzmXKmOWAjFIF7BIfCDTRChQ
         d/b7aZlbTkUcHl34OGZK11EnSu9Nnw4//DewDtYR8QNSgJvOTKgEAQz/J3pGas6J6rQ2
         LnvJBVd1k/BdiEwWYVVKuMp6dpBXm9o1F26mSa9UEGB38bxTgTwMCAUbBzusSv67rpF8
         vmDAh2vh8LlwRiwsnvTm4iXgEdQq8cuwn9569S8ANMQnR+ovudzUlxtgm0Yyn1eJloCQ
         HtKg==
X-Gm-Message-State: AC+VfDyAHLYMTNgggIfBSHjPZsg0KdZf5GKMxBso4htaWjcL6BcP6PUF
        Z2StRKsDXuXtek0eJiTAOZYh8Q==
X-Google-Smtp-Source: ACHHUZ48uYIZmcM99bLQE/QjrgvfCxeXZQoApR3zMj5TIWWLRxVt3sb0WYzvrWYHMnjaLxXMc3YoEw==
X-Received: by 2002:a17:90a:d591:b0:253:8a50:1bcb with SMTP id v17-20020a17090ad59100b002538a501bcbmr3219255pju.25.1685048424036;
        Thu, 25 May 2023 14:00:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k93-20020a17090a4ce600b00250334d97dasm3622008pjh.31.2023.05.25.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:00:23 -0700 (PDT)
Message-ID: <646fcc67.170a0220.f013f.7c7d@mx.google.com>
Date:   Thu, 25 May 2023 14:00:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.4-rc3-33-g1ef93b68531a
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 7 warnings (v6.4-rc3-33-g1ef93b68531a)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 7 warnings (v6.4-rc3-33-g1e=
f93b68531a)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
4-rc3-33-g1ef93b68531a/

Tree: pm
Branch: testing
Git Describe: v6.4-rc3-33-g1ef93b68531a
Git Commit: 1ef93b68531af36f2eb776dc3a123ab2604b2672
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

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
