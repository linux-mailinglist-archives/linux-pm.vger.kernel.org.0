Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61517D1A8F
	for <lists+linux-pm@lfdr.de>; Sat, 21 Oct 2023 04:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjJUCa3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Oct 2023 22:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUCa3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Oct 2023 22:30:29 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080EDD71
        for <linux-pm@vger.kernel.org>; Fri, 20 Oct 2023 19:30:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ca816f868fso10159285ad.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Oct 2023 19:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697855422; x=1698460222; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1qAT/k0d0dwlk/nR41CGDYlYvHmhmzcbYGCXa7mtC1A=;
        b=SyjIE2X5S/nZPKi6oZIB5p7DELSQGTp/zWcV6+UQPlaxC7cQqVKXExCd1dPeFDSvAM
         RryGx/HVfO4BdX+UfSSfwk5vBzXPK47Tqn/toRu47sSFUGiNTFlOFhA/oleIofQB/MgW
         RJCsephvgaZaT/RAaUtaI9rd6txTu7umjTlEokjydLddrmtrALbxyf5QPem17k/xj/FA
         v3SVaqRfdMmvIa3gyMZCPbPOyl4VG+dZ4wUMDNHbJ4V7OOE/EKSlqWWhx7I5JNdPHpXc
         t42ezbfxxtfPXcHFtRmLI9o+0JPfNZzrb/BP5cVmk1NOqySoh6aJqZc82x8o0BqKE42S
         DwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697855422; x=1698460222;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qAT/k0d0dwlk/nR41CGDYlYvHmhmzcbYGCXa7mtC1A=;
        b=fF8w+uDmaEP18BBVd/ANtApe6AnkOVuHrcCaFF7IAA+0bspo2VDKAPi85EIVIJsSix
         6gPKQqLITPojFzy1DNwCC3am60JBXKxHNsPPYHK2oC2/+rzwN3JKerrnhLV6FqWfrbc/
         9QeoDuB5W31m8+OJGxD20bBvbR2YpmJKVE5AWXbhJBHOWeB2L/qF4pDYdVGY6IpCuxbi
         brLa2x/4fNg0AbFTpXRTVBzuo7B3gAjjVsIfJCOymnhDEp9yu5swOvhOdEJYZqIPhGkh
         duYRaOBNbRKtzMKq5FPBW/yfoYH0bPPVcPOpM3rShmoDM3/tvM3rDqSKjnoXTEmEjojX
         832g==
X-Gm-Message-State: AOJu0Yz86WG4j48yiSGOnyBj69V/FMTB7DtPk47MkWMx/ztDDZyUzQ1l
        75gX9OYKulDhrGWsYxRvoFOKk9moJU+lhK6dDmbx9w==
X-Google-Smtp-Source: AGHT+IGjd7FEaVDGPODDhajgI7cVceECXmELxXUGl9nnqP/22uFZbKIASTQVWS4dw0urcboWPiVCGg==
X-Received: by 2002:a17:902:b7ca:b0:1ca:8b74:17f2 with SMTP id v10-20020a170902b7ca00b001ca8b7417f2mr3434302plz.6.1697855422535;
        Fri, 20 Oct 2023 19:30:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902bccb00b001c613b4aa33sm2139381pls.287.2023.10.20.19.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 19:30:21 -0700 (PDT)
Message-ID: <653337bd.170a0220.6f2ee.8345@mx.google.com>
Date:   Fri, 20 Oct 2023 19:30:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc6-164-ga1b138ca64c6
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc6-164-ga1b138ca64c6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc6-164-ga=
1b138ca64c6)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc6-164-ga1b138ca64c6/

Tree: pm
Branch: testing
Git Describe: v6.6-rc6-164-ga1b138ca64c6
Git Commit: a1b138ca64c60d10549cc4641488e75bf9554902
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
