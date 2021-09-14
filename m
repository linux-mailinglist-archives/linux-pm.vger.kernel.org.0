Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EED40A1C5
	for <lists+linux-pm@lfdr.de>; Tue, 14 Sep 2021 02:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhINAKW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 20:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhINAKV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 20:10:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677F6C061574
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 17:09:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m21-20020a17090a859500b00197688449c4so1388543pjn.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 17:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gu+7oHYy09P9EhN4ez+S9Sz+xy/ZtKNHKdD/fmTzduc=;
        b=y9UzPrGiZTkIP5FmtQTZgM/15Z/okV5e0Qnlm85umeGc+KxTNrSROW2jutoXH3f6LC
         dvD8gjZBZWjcoGP/SHa0ZtKoneDg51YzQEVOhtqCcp0lvYTI3WPPEOdPtBMkZY75bVsN
         h/lOl59u7HFiu2OFICIV2MYqDaLR4ITqgF2TIHaEVEro0Q9VFseFfAWZ4479bqyoHffq
         RLZ2QDliqONfi5B+Xn7rNvRZR7+CGTjcyqX1D+T6jALMOyOefcpVXN9MeQJMp2cMsDmg
         CjFL/M0u9bvKzbQOTuGeRznIOkd1jH4pk6W8QB1bhwKok3kMErlNeOfF15fytb+oj+Na
         RCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gu+7oHYy09P9EhN4ez+S9Sz+xy/ZtKNHKdD/fmTzduc=;
        b=ia61vtIMR/QrPf/xrHlIWp66ubKBldpHoCjxElGJLuToiOY7KQMAWdvTH1v3G/oipk
         c3Wz9FVjlrMe5V8mc8EKBIw6TA006yHBqMwzhOxJrOxYFCgXLwy+qchviim0aLNV8c1D
         AWwPT4xB61sAddNl005jvs9jZ2AJ8j8qBzBRzoCfbxfEaxAhSWWQ8TX4W7PZWkuNnk+T
         3CH9ePDkoqsO7WddH4m7tiDS4546uOlNe8XOTk4iVQfyb8ShgOW0yqYURZbwcH6V1tCy
         d8pY8TYBTic+p2Pb+EyCoTs2OLa7ES+RagIy3YExA0WxEC8dz/UKWgOxmJ5ReRTwscBp
         sOtA==
X-Gm-Message-State: AOAM533/T2IY/LitTrYWL2o3eAv4EZWP0xxe9xXANYbtwFK9fhHmEpbS
        vSs2w4+xbW1COoX9C1VYdLAj2A==
X-Google-Smtp-Source: ABdhPJzjrqOZpc2xKlZfr/SSTEPVQUkLG62FpTjzP4ayFJGCGy8lQ1gACBCd1iuNV7O8frOWCdKiUQ==
X-Received: by 2002:a17:90a:a513:: with SMTP id a19mr2472584pjq.26.1631578144846;
        Mon, 13 Sep 2021 17:09:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z9sm8066210pfa.2.2021.09.13.17.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 17:09:04 -0700 (PDT)
Message-ID: <613fe820.1c69fb81.18fac.7ef4@mx.google.com>
Date:   Mon, 13 Sep 2021 17:09:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc1
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc1)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc1/

Tree: pm
Branch: testing
Git Describe: v5.15-rc1
Git Commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
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
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

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
