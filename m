Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CE833D653
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 16:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhCPPCb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 11:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbhCPPCO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 11:02:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DBEC06174A
        for <linux-pm@vger.kernel.org>; Tue, 16 Mar 2021 08:02:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bt4so10772730pjb.5
        for <linux-pm@vger.kernel.org>; Tue, 16 Mar 2021 08:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zJoI5PZsVo1slqsSvIa/KZHBxixmSVN7XKq89Unn3KM=;
        b=PBtWE65x2Amg4pxbmYoAXAGBpHLtVn28mtQ39Ld2/OhNREbeaCq2KGBGn0HndjcGrV
         UTqDgzzZJfuK8B9IUMQBtAQft+xjwKiumhTFT0pOzqUX0Gbauke5tJ6yUIKTdDNh8dCY
         l5BNxmmVYTEvRF8TiR92IlMHoXiSA1CFA+rgrSSckhGDb/nGkuhnhaJhphbQ5AWMn5Z9
         Cv20L2Uf40xj3w0VzVEkpyG2CFxkPVGijjUUrgYPZ9sZtxink8XCKTdqH+c1L6gNTdZD
         I13oQ2cGRn4Zro3K7Xr5IHGBK7uZap81KNSZ6iQBCRKcw5NHT9B8x5mV0h8SWnH0QAFS
         rS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zJoI5PZsVo1slqsSvIa/KZHBxixmSVN7XKq89Unn3KM=;
        b=f2DjmLK2FiQqA/dBo6gyCRebfXk/UHVsB3t2jLfbLrEJddPhqXrjNyNExTi6wLsKTV
         5nctR9PQX91fB2xynLJ+Akjb1z48/1mqBEDZTF5PfvJQ4rtBOqzzwaxj0Xl+AUhwugAC
         A+C7St0NlM64dYkqCgQWvhTP0tNVhXpeH2jAy/2+y0cUPWzTxotwrX8RoxP4i0j33Vlo
         wPzpXHntzOW4CH91W6jG+evsqmySxwLe0rpxMgDKR1mqYaBzRl9VsJJAXLY2P3jpCO/R
         mFBl03ZTaaz0g6YxmQ5sYWqFndVaph4AhlLmW0is50+rwjVe6ZZBvkKl+0bZnADra8bP
         1ACw==
X-Gm-Message-State: AOAM531MkGlOHyi8oIk/q6C0EEItq4UpSXj52bRnSeuNHvKQBmW5kyZq
        4cyoUu9MCosqp0O04cgb1FVR/A==
X-Google-Smtp-Source: ABdhPJw9tDOCcJwGN4yyyo9Es3XT3PkMjIQhW8KZ/CXp8FebxsMh959Ih8ZJ4xNV6ciVZ14gPBETew==
X-Received: by 2002:a17:903:3093:b029:e4:7e03:d618 with SMTP id u19-20020a1709033093b02900e47e03d618mr17034616plc.54.1615906934054;
        Tue, 16 Mar 2021 08:02:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p11sm3418553pjo.48.2021.03.16.08.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:02:13 -0700 (PDT)
Message-ID: <6050c875.1c69fb81.33547.84a7@mx.google.com>
Date:   Tue, 16 Mar 2021 08:02:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.12-rc3-19-g1a7a93e88ae21
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.12-rc3-19-g1a7a93e88ae21)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.12-rc3-19-g1a=
7a93e88ae21)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
12-rc3-19-g1a7a93e88ae21/

Tree: pm
Branch: testing
Git Describe: v5.12-rc3-19-g1a7a93e88ae21
Git Commit: 1a7a93e88ae21b39d09117d5a0dde26db783ff92
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

riscv:

x86_64:


Warnings summary:

    1    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved sy=
mbol check will be entirely skipped.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol =
check will be entirely skipped.

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
