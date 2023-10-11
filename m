Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21917C59C9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Oct 2023 19:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjJKRCa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Oct 2023 13:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjJKRCa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2023 13:02:30 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D96A9
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 10:02:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-692ada71d79so5646388b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 10:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697043747; x=1697648547; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B9uLSotFNX2kJGBltE1RswsvT9pPA8o63WsK6BGd/8I=;
        b=STcDJDh7DJ0uuGoJ9vGdutoMt05VPKfulrn35g6SqyDbsm1DItFkK1jjFvg9FGynAO
         KnQFj4qqVEems/iT2rn7HdAlr9neDHFX8bzkPeKdkl8Zq1ZDwP+bwLIh7gjUixmU+Z1e
         fugY34xHPdM1OjqOk1fXEXTdVxEVTv/y6LThI5pPB5iKwFyG1YEV6bN/rz9+mlA7pcVv
         kA4ODhshOnB4VfoGVWD4T4qWb4STJjXdYbHHgjZmkB71R0FcpZlI0WY/plXA4FWuogZN
         mcy5ZSg0gyqQj24Dg3Fe0q5Q3htBfMerRNNsg4YtVOnoIPfyHJLpmNNpfF6FDihqcejO
         Yh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043747; x=1697648547;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9uLSotFNX2kJGBltE1RswsvT9pPA8o63WsK6BGd/8I=;
        b=LUTpCe1FQbeev02wsdVFe6NiFPBBKBmR203y3BTAC741hy99D1cW0xVjNX2BLGSIVw
         8SX8HaLfhhh7XYpX7/LcXoTdUr8fPSpaWNnYUnJzHvRjswBQWRUzlKO297TsmzPocWsU
         RidwLeZtBgGa8ecnISsGzcma/BVsVg+76DEgdpR/EWxiz7H66gE2Cx7mHNawHiNyh9gV
         cvfOeICRqT5JqjMp3BNMtipXnkYaXayGQu0JOUiTsudyfG+Prbk//GKDJbwQ1ldeleGF
         50cSAYNsu9jrNep2rOw2YlxINMANJWV0L5E6J8fFQv5KJLxTTG+xVMI3akxfbJ5WIuPp
         nfdg==
X-Gm-Message-State: AOJu0Yx/NQRQDdCXDa0z5iahFjAijQ3LmWmgrSlcwEmuNdsQIri7Bj3Y
        yRuBF6YSYANaWqD//EqRP/DDcw==
X-Google-Smtp-Source: AGHT+IGa7lfIpVrLLcDY9GmFiDIL4CJEYcGuR8FekImYI3fBVWXhwabcK0YhAuFLE65bNC0uZEqyFw==
X-Received: by 2002:a17:90b:1b4c:b0:267:fc61:5a37 with SMTP id nv12-20020a17090b1b4c00b00267fc615a37mr18478798pjb.39.1697043746715;
        Wed, 11 Oct 2023 10:02:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pt4-20020a17090b3d0400b0027d0de51454sm161072pjb.19.2023.10.11.10.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:02:25 -0700 (PDT)
Message-ID: <6526d521.170a0220.c1f08.0d89@mx.google.com>
Date:   Wed, 11 Oct 2023 10:02:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc5-141-g45db6c21c12e0
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc5-141-g45db6c21c12e0)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc5-141-g4=
5db6c21c12e0)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc5-141-g45db6c21c12e0/

Tree: pm
Branch: testing
Git Describe: v6.6-rc5-141-g45db6c21c12e0
Git Commit: 45db6c21c12e0b3fc5f5909c46d34911ceb42285
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
