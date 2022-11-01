Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE9A614E49
	for <lists+linux-pm@lfdr.de>; Tue,  1 Nov 2022 16:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKAP2l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Nov 2022 11:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKAP2k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2022 11:28:40 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9E610DC
        for <linux-pm@vger.kernel.org>; Tue,  1 Nov 2022 08:28:39 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so19136133pjc.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Nov 2022 08:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y+yAx3do4D0R240VOD0mNZA/S3SjLvSUAYvWeMTpHc4=;
        b=h1krIrL6eZjleSsFs/KyiE7aeGTCCljMZ7ulsg9afcA7MJaZmY3ZQdxGnEnlAPiZyY
         cZUvOmf8DzLvwm7UsKgJ4krXHkiCmlxaXMcPIRFjXfIqNaaBhdEMdn8RpmkaDcF9q+Ln
         0Ps5z0VDkC1DixtNPRWmabYlMEkwU8IaFz7W/njO9rvlneNn0pKw/QedESdCEVLnyKm3
         aM8Nx+XmK2Hyj6KDDf/iIWDHReDRd3n1X57B0U0HbUqAnyIrBa1/X1uok7pZQxv0jIQL
         748PoYuCsm51xpgsoe4tqYqfRxXyP9Xc0egrp8F9o6l3YjH5dSprbipd6zEvCbISaxn/
         Mmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+yAx3do4D0R240VOD0mNZA/S3SjLvSUAYvWeMTpHc4=;
        b=ObVIOfrPpqvGvt6LUYHdKnQ6O06ok7r30ekE1DCscsSeQEYstGa2n68AOSqM1+tH0n
         vcopov2SVcVmFTT4Pli1sgiPTKdxyfLK2iF2oyff222tDLXTncJARzSSpnY/OsWNvYTi
         qHv9V0xhzK9WbXcMlc3aFMDKOjWKrCsxSTIE1XEmHbBePpnGRf0m7x4UC+x+ZGj6j4vD
         w2zK3QIu5Rzy0LlxGtRzHOqOe3kW/CyQ2CHWyHWqgtWrZXkkeCBT3CvgV7FQm7cY/6vX
         AjrYQxSa3y6S0H1ihbwFxGMR9T5YMTc1p/Elb863wJS1sBLI7vICaZx+50/MRBhJM3TB
         T/+Q==
X-Gm-Message-State: ACrzQf06Nr6FBY38hO8o44ckEyl5hcgi6o4aeBqUgC0EzJ7f27TTgZr7
        dPjRmkR78X338/a/EIAeHriVqQ==
X-Google-Smtp-Source: AMsMyM7MKJuxhxK7xR3zbXG3dhUp3X1mwY8+on+y3/SlSYV9OGK+jqzlJsEeBxt9Zk5UKi+hEfuALw==
X-Received: by 2002:a17:902:b598:b0:184:e49d:3042 with SMTP id a24-20020a170902b59800b00184e49d3042mr20177023pls.16.1667316519165;
        Tue, 01 Nov 2022 08:28:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iz18-20020a170902ef9200b00187022627d7sm6522849plb.36.2022.11.01.08.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 08:28:38 -0700 (PDT)
Message-ID: <63613b26.170a0220.e0a54.bccc@mx.google.com>
Date:   Tue, 01 Nov 2022 08:28:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc3-20-g2796af610a6e
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc3-20-g2796af610a6e)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc3-20-g27=
96af610a6e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc3-20-g2796af610a6e/

Tree: pm
Branch: testing
Git Describe: v6.1-rc3-20-g2796af610a6e
Git Commit: 2796af610a6e38c46ae5480190ff2360f9605654
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
