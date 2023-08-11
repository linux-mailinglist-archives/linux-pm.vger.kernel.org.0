Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5683777993E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 23:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjHKVOB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 17:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjHKVOA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 17:14:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321AC171F
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 14:14:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bbff6b2679so18032935ad.1
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691788439; x=1692393239;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=amHFTIfQtGZhPXDImh7RqZ4W7f1RkaGXnp15jDh/ow4=;
        b=imOSEOc5BlhDnLHf2hdQnkcj/tgGJ0uXA2jGPjlQIEWUF+U4tbhNzR0yigmysQP8qy
         vFdekABrUHvl+swP+I7S07jQIpa4U6naXc2DAre84h3zIZIcDGVPdE38QgdzNK6256jJ
         xsNMnOncVbKrQ5h+BIJjI85PWVjdUYw2Hbt6G0lL93JsCJ5+sudTX24cx2XPHhb+u5T4
         YpRNCCZCqVyrwYnzlqQoTaSh4ls8HXVrzRwgCi7AqKOwK6tZY93AHAcVziNsaq++F/KL
         Vq85wCjFXFrk9c8EwCJXtnBpBMR3qPQxGLk2a+6Zy1YDFRiDOrw13Wum91N9gnPVvSAk
         dvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691788439; x=1692393239;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amHFTIfQtGZhPXDImh7RqZ4W7f1RkaGXnp15jDh/ow4=;
        b=kypcpWUnQ1dDlWJ+b1M/vQJucV7NE6nv/9V5dcwncN8sVg1D4UWUG9C7hHgPIIvTnG
         meN4UxEwzqRWjdbMl31lhRzRzqLl2sInfEs+vUttSCu6meH9W+sTkKMuWOYVq6o8xEO7
         PkcKaIbkKDrlOqdDjfiPO9BLlLZofkYpzgVU5GmBw/eUIjzTQl5FmkfyPY6atrfnGnYL
         st83s5pjSirOGqODr7m/VfyuNfCTyhQytzPFBkjGGLF3O+nXIcA8Wlzcd0jJU8OH4ok/
         7Efny4TzGvz4VxB6FTgrf1okm1BXMK6awc5zYKw+ilRQ0zkolEMyzVQjDR/Q3Lqp4CfM
         Y9Ow==
X-Gm-Message-State: AOJu0Yw0xmGNP+wIyft0ZB62P0wTOiYkt1QXgVhwqMK6jegJyWIZ5aZP
        YgRWROoDDJxxQQettlDk57vtLw==
X-Google-Smtp-Source: AGHT+IH+xr74yu+11aX13ZGSNP3D7DaibMYP7/yuOu+9YFpBNbEdeK4Bw5zqgCKjApc+865KQmd1cw==
X-Received: by 2002:a17:903:44b:b0:1bc:930d:4429 with SMTP id iw11-20020a170903044b00b001bc930d4429mr2309274plb.18.1691788439592;
        Fri, 11 Aug 2023 14:13:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902ea0300b001bb9b87ac95sm4371444plg.103.2023.08.11.14.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 14:13:58 -0700 (PDT)
Message-ID: <64d6a496.170a0220.7d262.8aa2@mx.google.com>
Date:   Fri, 11 Aug 2023 14:13:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: acpi-6.5-rc6-79-g9a4efd57c80c
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (acpi-6.5-rc6-79-g9a4efd57c80c)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (acpi-6.5-rc6-79=
-g9a4efd57c80c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/acp=
i-6.5-rc6-79-g9a4efd57c80c/

Tree: pm
Branch: testing
Git Describe: acpi-6.5-rc6-79-g9a4efd57c80c
Git Commit: 9a4efd57c80c7873d53315cf3d4509ff5dcebb62
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
