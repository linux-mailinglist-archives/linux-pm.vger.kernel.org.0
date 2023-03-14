Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83A56B8B6D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Mar 2023 07:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCNGmt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Mar 2023 02:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCNGms (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2023 02:42:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491DE96C16
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2023 23:42:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so19304464pjg.4
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2023 23:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678776166;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=47lArce3KPlvLO80pTT9KkPcSKriXXzajBi93MzGZz0=;
        b=izvqHeyQIP15S7Xvz91tEhMcHZI/jO7B/OQXIupglLUJKSYDB13mCsUBdi14BFLYWc
         Z44rD66VuGzNf/bYbUgJeK4G/OIHBzAwTjY3U5GfMY9/gXLm7tW+CNcYKTYV9Dt0cf1P
         rDNJ5ivTAXGnLJxNWElQ/HvDDlzRq3LEkl8YAP9A5EqSGsEiasp0P1g6vGAjIhCk1IfY
         DdY2+gxL9X2YfIcuWKm2wIPZxvphQLXGOhPVQioH1w2C3FOiyLlIM/WmT2GndszUYbBB
         b8tjHd2bZIxxKip4i7/cbkjil6VWEi2n7HAwKuWru9mDaoLjaONjGnSO/NntF1fGsyvs
         8oZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678776166;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47lArce3KPlvLO80pTT9KkPcSKriXXzajBi93MzGZz0=;
        b=OuKEQc3z7imS4uZkZ5GSqCNi5bN1Pi8Em0kOIeboT6Jmir2ukZ9co1mbyDycPr1TjP
         qiUHGjFbUedOmYvGDzATDmhSQhyz7v+NpzJoD+DUySvVznEeT2kLhHh2iwSQiiUmv/K3
         oqxrowZp4Es6Gtxg56LoAHTAYuvsVR5LZTwdklAUCOMNPDPrOdok7q1EaDQhNnbadjjQ
         Qd+gAe0+6IGqesum+Ftbj6PUd5KfNU+zEaY+ogThticJ4tXqg7qDbdX0FKQa3/V5EBJX
         cOkelXTz8UCQRIUNbz5SnuzULoYgJwcGNg+PVFI+DjcIr7CEFKnvEveaEulQ95XY5Ehw
         Ir1Q==
X-Gm-Message-State: AO0yUKXB9y4+srkQeBkomPDt8gI7S0LaAkn4qsrrpg2m1U5mEXgHTFm6
        dDTzry/hNzqdnhm1fsoU2AQaLyRemuJ6wcyfzuYvZo/U
X-Google-Smtp-Source: AK7set+4TKSJtr/Ehpf1GEFczWzd9VwBuvPiHOVJbloxrkbJQ0LPbAqqxOwHItpiGPKryvYRGNaiCA==
X-Received: by 2002:a17:902:7891:b0:19a:a267:f16c with SMTP id q17-20020a170902789100b0019aa267f16cmr34060490pll.31.1678776165691;
        Mon, 13 Mar 2023 23:42:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id le8-20020a170902fb0800b0019f3e339fb4sm914129plb.187.2023.03.13.23.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 23:42:45 -0700 (PDT)
Message-ID: <64101765.170a0220.22ca.2e63@mx.google.com>
Date:   Mon, 13 Mar 2023 23:42:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.3-rc2-28-gd64b2bdbf627
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.3-rc2-28-gd64b2bdbf627)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.3-rc2-28-gd6=
4b2bdbf627)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
3-rc2-28-gd64b2bdbf627/

Tree: pm
Branch: testing
Git Describe: v6.3-rc2-28-gd64b2bdbf627
Git Commit: d64b2bdbf6274ec9d924b31de316b819d6916ab0
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
    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
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
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
