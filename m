Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7C26CDA0C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Mar 2023 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjC2NGk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Mar 2023 09:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjC2NGj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2023 09:06:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F54EF2
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2023 06:06:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so18491617pjp.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2023 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680095169;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u73tZ377b6xE9nGdafuPLwuocr22/5eSxEh0UWluNqo=;
        b=LohcdaDhhjcOz7O2xTbbNQ8Y49+P6EphtEM2omW8VSV8H7zgLr6Hqu38PPH8Q9NA8z
         yeD7rSEYWmGUj9+Q9IqjvEpC1uxsN0DBcz7rMJjZqae6GE0JFu0t9PmQ4tXB1tSFORmo
         4cXXvGYE9Q+Kz1RU6EWUktMy7P5oO1U2pF5IhEjyp1hTOHaxBofkzv7VQxh/wVSb3Yc0
         xqEn66zvGxEEVwBFuBZu00hffaLoID9BwrDdK4Ep4UXL4j8VQda3jr3d+RIW3d548cgw
         Ic88mYafeTxgQsNiPbAl0NhHogjNJb34uA6KUqSFSECsyee8KM7RgO9XfLh3tSGlKmF6
         0VlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680095169;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u73tZ377b6xE9nGdafuPLwuocr22/5eSxEh0UWluNqo=;
        b=NjS94ljmHfWDVHW9Ca1HJQwIoEyCoXVRzMO9SDLWyn34yr1dwsqOUPgWny4tLunj4V
         1GnYoy0ixhg9jQ/+c/Rabvu8fJ+4cXt7u1kdJFAvOL7ZOUYmVrYAd+HAhmnySKH3Bs6X
         uP0wIR9sELAw1gWRZpaxg2dIQjNdtN8XT+PQGatiWkBeii96Spyr9iQtoN0G6M7DMaud
         imwReGVFc71oiS25mRRhkd6fQH+zXVHwXuqKYWWSG8OA4QRZpOM8gbd0BcHQ5uNpSonP
         wd9ei1zKF1TlRqa8Nt7YwHv8QqqZLVl0fwr5l/ZVVy1kSLGVGhASt4AU5yybPaMNk946
         3z/g==
X-Gm-Message-State: AAQBX9eoRXDp/+tY2Q2P/UJfYFmg3WkfwdCxcn+zLqzlF9WOWX+ik9JG
        jrXS/m6f5b3ychS4Isuyp/TINfQEb2juBDeI1ES/2Q==
X-Google-Smtp-Source: AKy350Y41i36EeyHITdjzdB/B0ciJS7SSNc/vV3VBe6VbPVvQPZ9V6zV3OWoVud+d+m38Fo9hJ2v3A==
X-Received: by 2002:a17:902:fb4b:b0:1a1:924d:19f6 with SMTP id lf11-20020a170902fb4b00b001a1924d19f6mr16477228plb.66.1680095168413;
        Wed, 29 Mar 2023 06:06:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902900300b001a060007fcbsm22964240plp.213.2023.03.29.06.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:06:08 -0700 (PDT)
Message-ID: <642437c0.170a0220.28eaa.9efd@mx.google.com>
Date:   Wed, 29 Mar 2023 06:06:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.3-rc4-57-g2a0bc4026820
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc4-57-g2a0bc4026820)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc4-57-g2a=
0bc4026820)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc4-57-g2a0bc4026820/

Tree: pm
Branch: testing
Git Describe: v6.3-rc4-57-g2a0bc4026820
Git Commit: 2a0bc402682085328f33e102245b49ffc51ca4a4
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
