Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1C45808B0
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 02:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiGZAON (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jul 2022 20:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiGZAOL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2022 20:14:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4B727FFD
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 17:14:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q22so6605471pgt.9
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2022 17:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=VPN8fxP/FdsRrDDoRfWW9vaTaIfQXmkyR3QR5hydx3s=;
        b=SQh6bRB6Kb+13Z6gkFWtFxy9zk1FsTWFZaZj2BJkOfApGZb7A99WLFXRrE/FRzN2x4
         W2eXCbs5rHHWv2z1EMMyNC1txcSr/eEKTOZLvLAC5t/V3QBDK3WJk2gHsf/yKLCqz4Jk
         MWLgSipu2wyOb6naTWmER3aSxn6IQZR2xKZ403KrydNeJSBbBfajEMfZQbtu3HUMwt9Z
         YxOniKe07jwNSZJc/V2x2W6PG3TAPW55ST1gsRrr+YdmTDRX+ppNxZUg5WfWdLpaHo7t
         IKT5pQYqahnJz9M2539RutB4v7sLRgYOkWDu6OVjN+PrtCJFLN+aDuX/ZvfEFqMcBtCH
         I41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=VPN8fxP/FdsRrDDoRfWW9vaTaIfQXmkyR3QR5hydx3s=;
        b=e+kdBkxd7+1pzGGgVdY9g0kib1UzURKqCTe6nbjt9stTGW4gKBW2LXv4DIM3QiQyb0
         cvhAlWHlKn2rWti54H0nToeu9dKNtvfaOgbH08I7jjWk4f2GVRkLGBi7wOmTNKzAZ5V2
         zER/xawqvV/0sxomCrbe+7f9HMxXjq4tKupgzorLSeibqLS4ho+RAloSOiK2JWtLrx1i
         WTaTERrD8I4ky5rSa3HnN/82UlnUwf0E2GMaYmy7R0MnBAFPju70bpL/7OLQnx2cUSfd
         qX7PpBPGC6t4cvOPdiBY6E8cCvUs00TnbAvuUx+Cf7oh2hIZZX7SuMpWV3IJ9IGKHD3H
         ud1g==
X-Gm-Message-State: AJIora8k19ozFasSheFuuF7d0e2cPKw4oR3S9LGbFB9p3Ij41/gfSnN+
        wBwklVFEdJ0kzWc9lWjOL2CJ3OKPsuOVPa5t
X-Google-Smtp-Source: AGRyM1tjCG3pd5TFAC9x+Hsz5OFeRMhP4urGTuDyzwzAkyDaM94Lcnht9QyQxTXmrDIAhusJ8GzflQ==
X-Received: by 2002:a63:68c7:0:b0:405:1da9:ab69 with SMTP id d190-20020a6368c7000000b004051da9ab69mr13165253pgc.233.1658794450660;
        Mon, 25 Jul 2022 17:14:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c09e23b18sm9818372pli.154.2022.07.25.17.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 17:14:10 -0700 (PDT)
Message-ID: <62df31d2.1c69fb81.4c619.f84f@mx.google.com>
Date:   Mon, 25 Jul 2022 17:14:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc8-79-gb3f10ca8bf191
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc8-79-gb3f10ca8bf191)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc8-79-gb3=
f10ca8bf191)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc8-79-gb3f10ca8bf191/

Tree: pm
Branch: testing
Git Describe: v5.19-rc8-79-gb3f10ca8bf191
Git Commit: b3f10ca8bf191b812bf40c0911a22ce8ce67d13a
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
