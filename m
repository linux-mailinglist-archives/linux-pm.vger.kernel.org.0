Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E77143E5EA
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJ1QS1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 12:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhJ1QS1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Oct 2021 12:18:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD110C061570
        for <linux-pm@vger.kernel.org>; Thu, 28 Oct 2021 09:15:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id r5so4800386pls.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Oct 2021 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=HII5y0iXXl8rJFD/oGD52H+qeqfyWn9V7dJ1oY7NCTE=;
        b=kDT9F/GRhe7KjfnN0ZOdQOZoUXcEidzdoOLkRNQ4EtbnfA9NOkdFx43Xkm1yXheZkD
         5Pgs9vYZD5+ddUyChxhlL5QwzHuDS4YRVA1hhmfd+N86uSqBw4yL6WywBcNEY/HUJQdh
         9rXNi6vjBAhMscKxFMACrhggs70Gg9JTqXAFAzJVkGmjFJ60hREUJk7+lmn0o//1cVjP
         FL0yHK1Qe2c5vyzBHEZOsAwayvjHiImQCEdJmhMG18hk8GDNjmrPv1jUDD8KC8z7GeIw
         FXnsxKH6BPdzpxlBtmKZkOE3VYmIViJoaHCr2102zdtdBdqywfbaEYA80lsOygbs1e+Y
         sAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=HII5y0iXXl8rJFD/oGD52H+qeqfyWn9V7dJ1oY7NCTE=;
        b=KqRS5fETSEsSDyD3tYfsGKoovYN+jyARnOzEy9otGldhcixjlG1BcHc42pq1GOr0fK
         LHluWtTOqmADW7dLlxdUkGV8p9wmNG+iJ7LQz0DUok2nS1qZAWyD+oNuwHJ04Q2bBvDH
         IN7VmYaPIWGYNBKsyzjPHZcy5pzqPTgrbZ3DwTyImC//qvh5pTPmqjjXI9fmpnD4IMPA
         iemSiPuOeCKxWheH242/s32/VtqSkr0y8jUk1aAC9UyY4A6fNKcmxAjuPPLvnQEVldAq
         0MFeiO1u3N8vwej1pqg9YQx1zqZgR12VPZkjV5du82Eryfj4/OmdyZCoXAjMMdMHkgOC
         3iaw==
X-Gm-Message-State: AOAM530AmX6ADWLboSet2IsO6DuUbBwlDIjxEW0H79sz/yeUjGQej1aG
        PmbR9EuJSo/BF9joK7a5ebr5mw==
X-Google-Smtp-Source: ABdhPJy6PnjWoJ3kU7BG+lPuZbUpCzQ/ca/PzH8mmZNqKlIVe0pBOOpDZiglIIuPkEvxs6TCUFGU0A==
X-Received: by 2002:a17:902:7243:b0:13f:505b:5710 with SMTP id c3-20020a170902724300b0013f505b5710mr4697025pll.36.1635437759335;
        Thu, 28 Oct 2021 09:15:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f2sm4381pfj.99.2021.10.28.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:15:59 -0700 (PDT)
Message-ID: <617accbf.1c69fb81.8e99b.0045@mx.google.com>
Date:   Thu, 28 Oct 2021 09:15:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.15-rc7-120-g1eb4f10091ca
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc7-120-g1eb4f10091ca)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc7-120-g1=
eb4f10091ca)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc7-120-g1eb4f10091ca/

Tree: pm
Branch: testing
Git Describe: v5.15-rc7-120-g1eb4f10091ca
Git Commit: 1eb4f10091caba528d8f81e0e14e9f6be1b22427
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:


Warnings summary:

    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sect=
ion mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
