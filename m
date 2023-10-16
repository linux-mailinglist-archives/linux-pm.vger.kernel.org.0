Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFA87CA63F
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjJPLF4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 07:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjJPLFz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 07:05:55 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C4283
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 04:05:53 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57e40f0189aso2322765eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 04:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697454352; x=1698059152; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ENcxuEdqZVuHuNDeDYTthdY6xmNNsGtNg5YaX8ZazDQ=;
        b=cFgh+VX4DhDYzJBGsLAX9TU3y0SP5eQ24iuoTia4F8gfCDz6X6a5sbIJECgKXF6jUZ
         v8OA3HgBNrA7El+pL5QkP8XmoFEWYrLFyDjjkz2FeM13vsk/j/sAccFpSyLeEh5WJQQQ
         AFIE9uhNt9eboGtYpJhRjH2qVTGbGcpzG4ySt7rCTNVZgSfLgrn4pgXuvBz9m6FNG1wx
         moKDMxOPcGQR6+KZUxN2RHFomC51swVIaHEeyGCSQwQmbIxmTxfjCOR7jDdEKlGVRDL6
         A5bbhlbFks42b8yQipv54A7IAg8LGYCUWWkN1qkgDR+mRI5+1sfweNoL/MiGqRBXlTSQ
         EA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697454352; x=1698059152;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENcxuEdqZVuHuNDeDYTthdY6xmNNsGtNg5YaX8ZazDQ=;
        b=l4YLt0Pymxb4iEsJWX5/XQu9fFUukO5aSK2Ld0Qq8N3TQ5fU7z0PehDD68Vy1QmJOM
         QQe9HlakOF+TL/x1cdWT+sig/aPHJ8yfGMxR/6HnERTsHjSmtkMaQbRWKWPxFMFpEuSR
         AWB/UNYpFpUSNhj4+AAjIfxFUnV87/IAsr9YBJ1DznIFU3QOHkGw9EWpJICjRaIxbSbm
         RcOiyuZomcCl57Qy7MmLYg+306m7cyeG+kMx35pvzB3jJSGrJK1z2NbyKSNAMU1ouxKS
         f/l7BUgA/FN1vpgsB6SYB35HB9hOVo68Toc81KxZ6ZL4D2Z4EBo+SPAiN/L4NuWYXEt1
         1VwA==
X-Gm-Message-State: AOJu0Yw9NIorCYXvfC+1Kn+3Qq04ryLYa9LuEWGJuyciy3tF+x8thVln
        xhc/9a3Mj8NJUP5ssWiyxW+kw/XCqGpiB+HKR4+RNQ==
X-Google-Smtp-Source: AGHT+IE8yH8rwPuP0cEyrr7N70+IUDtE4HlzQOnkEl7MiOIwf49RZvIyXjVC8L4xAyCspU2cXFbOdA==
X-Received: by 2002:a05:6358:785:b0:143:82e0:8cbc with SMTP id n5-20020a056358078500b0014382e08cbcmr40728175rwj.1.1697454352565;
        Mon, 16 Oct 2023 04:05:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l8-20020a63be08000000b00588e8421fa8sm6667529pgf.84.2023.10.16.04.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:05:51 -0700 (PDT)
Message-ID: <652d190f.630a0220.59c80.1ece@mx.google.com>
Date:   Mon, 16 Oct 2023 04:05:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc6-156-g701ff0817fdda
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc6-156-g701ff0817fdda)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc6-156-g7=
01ff0817fdda)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc6-156-g701ff0817fdda/

Tree: pm
Branch: testing
Git Describe: v6.6-rc6-156-g701ff0817fdda
Git Commit: 701ff0817fdda8d4fc8de43d1a314958273b3b33
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
