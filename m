Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371F578B29A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 16:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjH1OID (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 10:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjH1OHg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 10:07:36 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80770114
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 07:07:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a3cae6d94so2814791b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693231652; x=1693836452;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ve0utH9aRLXgDul2QQzlV5PL5KVO5A7dq2FT7NpTEUo=;
        b=cQdyZctLxOt1C6AQOCTBCDvLc4dH7qEJD9KQwMZ5VtfpQYcOWpDQTLAVE0ZVlWQs1d
         AcMSL+ZjP5cn2Oxh8p9x4qtVtAXoQUmCF/fYBSegxIafsUw33pD5Xmzc0QvGJ2lB9OAn
         qOXlgsjLyhVK9RoO6cHjgf8/5ej6AWPQnVGBu20gN4EoBLmOoRV5UCWKxFUmHKbqgFJi
         4yhrLTBo/pU4ScNNuIOtyrkZ+WyjOu22pobY5IJsDWwvMAiJBVonXiEiMOjjtMLx4Dxv
         bViWcXAGqUslXgD2ebDiASGady2ud9ho2QsqGFMn6ZNn+wQP9bblyviRiMKKhWzX7r71
         5lkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693231652; x=1693836452;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ve0utH9aRLXgDul2QQzlV5PL5KVO5A7dq2FT7NpTEUo=;
        b=iyzNFwT4VSlx/WZuS7/y3SDErqwSLiKlsooL7/elMyEKON5OQWPSB1Sz/+mJjo6UtP
         1Fd3IFbj+mkPCqcEfKrq6aRBk3IEI2OgiDgHLUFtTli2aht1hABLXrgzEtWd+i/U+sGN
         17JcA8C9FVCLZAZQEcDbyRdOXgMWLF/Cv2D0gG0ZQNc0JECgEjXhI7wRoxsIlXNG4rvy
         Id8EnFBdqzGLypO2dJ2X0ftao5GcIDn/bl9HVbjFswZgfZ7hMRvZBpWTtI69mGfInZi9
         ea5RNZ6fpMa6AwULFCWD6we0/J9+xNx+Em5p90cLnWrKk1eRCjOQgDreViuTdGRUzQLg
         9fcA==
X-Gm-Message-State: AOJu0YyIbGuKfkJ2AD6RhHUfhk3MQDuVB4HFnQLA4VUDHENuiRgXB8CS
        PaN5fUzMEJhfsMmCddF6DGEhrzETiyJYmhpUSDk=
X-Google-Smtp-Source: AGHT+IE0yFC1jRmIt/U+anSIMFO+aJenS0Qx0cBXKjXBhB3WYJppc8dGO7NKOg6lL1pyhLDzLDte7w==
X-Received: by 2002:a05:6a00:150a:b0:68a:6d1a:b812 with SMTP id q10-20020a056a00150a00b0068a6d1ab812mr22480373pfu.9.1693231651914;
        Mon, 28 Aug 2023 07:07:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z31-20020a056a001d9f00b00689f3ae4ca8sm6642567pfw.112.2023.08.28.07.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:07:31 -0700 (PDT)
Message-ID: <64ecaa23.050a0220.1fa23.a15f@mx.google.com>
Date:   Mon, 28 Aug 2023 07:07:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: pm-6.6-rc1-122-g07b618ec9d7a
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (pm-6.6-rc1-122-g07b618ec9d7a)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (pm-6.6-rc1-122-=
g07b618ec9d7a)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
6.6-rc1-122-g07b618ec9d7a/

Tree: pm
Branch: testing
Git Describe: pm-6.6-rc1-122-g07b618ec9d7a
Git Commit: 07b618ec9d7a09b421b8233f594632e379de0308
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
