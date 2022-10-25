Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EA860D06C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 17:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiJYPX0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 11:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiJYPXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 11:23:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308916C95B
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 08:20:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ez6so11183950pjb.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 08:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XOrM+2zL2xgJGbqxS2MOA2UOwgmtVQsQd8SjAIZ5aNM=;
        b=WzUNpbWXNTFstNtFIHXvpvD7kI9voepHyS3J7YUBgCK+NQuOMcrXQgWgalOygtQskJ
         rHaPFHQD09PHqhcvt2mQP1M+LaWhZDGT8B5mUjW5zdgZ+gSpSL5mgglOj3getglC/tgG
         8hNNXV9fsqIuwJVH73GkAaCdB9nIFzJYn91b+AYJ8Q6H/OMfLF3P2BBUoD/g040matMd
         Fz/+lgju96cacdIwVDDabrYhMJH9od567g88cyX5BpkNcYpv7GGWzzJCIYHBDnwVLjuY
         h6Kd/eGGwpqs67P0sty5XGRzMaOr8rp7UPKeyi1TtpfoI0N2jWyBPtqPIHFDFSAosfiy
         8QNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOrM+2zL2xgJGbqxS2MOA2UOwgmtVQsQd8SjAIZ5aNM=;
        b=k/Rxmg2uyvWCRbEeLB/Sb2RpuwHmok/O9xE0Q3866cg5NYZw73A4ktwsxJjWh0mVlR
         v3Zb/O8V3n/hhOQyXS2lNWhxuoPCsuo+FTrb4YAGfn221hk5Hm7+WWZ1cSdncOap9pi6
         3v0h4066n7Uanp0tIZHKfXBD3eUepvKdWuRfKOVjSGiZxSi7/Gewh+Y8YeqlkdmpaomS
         J/R36RMNGqYIqmuFFL/997NVpWBvOGkMYA/civHigUrFsfAsLpf0HPeSmak+EvqN0sUQ
         8sUX6JWeoDk2v/Kh1cieoIu11Ybd7z+iEFVS8VEWmC0r5FaOzoUGgwg8mDLrlEmpYBVr
         9knA==
X-Gm-Message-State: ACrzQf0kDVjCE/mxWQ6lAS842X0j/4I74+GhWNYTj48BMSwJJ7ebUftd
        +hfYwCQ6PssQBUQfw8SMbf3WlQ==
X-Google-Smtp-Source: AMsMyM6KIiwb73UGt5FFTkHmBu/XwZG4rzKONAADR5pVWPZyZ/9ae9qCY6kQMjo2zjgK2eCo8FSE1g==
X-Received: by 2002:a17:90b:1d04:b0:20b:cb40:4b3 with SMTP id on4-20020a17090b1d0400b0020bcb4004b3mr44356402pjb.215.1666711243142;
        Tue, 25 Oct 2022 08:20:43 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902e48b00b0018157b415dbsm1359790ple.63.2022.10.25.08.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:20:42 -0700 (PDT)
Message-ID: <6357feca.170a0220.d4370.2de1@mx.google.com>
Date:   Tue, 25 Oct 2022 08:20:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc2-3-g49c6629f06a33
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc2-3-g49c6629f06a33)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc2-3-g49c=
6629f06a33)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc2-3-g49c6629f06a33/

Tree: pm
Branch: testing
Git Describe: v6.1-rc2-3-g49c6629f06a33
Git Commit: 49c6629f06a33addd2d77936d3069e58dc31c5d2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
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
