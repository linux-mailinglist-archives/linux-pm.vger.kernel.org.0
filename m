Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6F545FC54
	for <lists+linux-pm@lfdr.de>; Sat, 27 Nov 2021 04:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347090AbhK0DYA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 22:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhK0DV7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 22:21:59 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0517CC08EAFB
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 18:09:37 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u11so7758654plf.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 18:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4QnL0A3Nw73BcOMccKZeItFTtJqkxejmtto0llNGwgc=;
        b=3tcRnO5Ip4COMk2kPTJAMQp/vaC7BMtlw1bdJ1dnSnNAo2dFQdFDU4mS93HS6h5A03
         QH7yeXGYbnmavr4hfm4oaZ/AeQ9cCuirhbNpTfODxQRUgVY6t9mnHVyScOk1q+z4y/aK
         EubjOHihoRAZXg2qBIrkSj/aw2wdIgLISgQCty9w/XVB1Ofkc6+vWHBMYZQfOlk3aWGT
         JyE8GaxFD+fOIrF+kT3tixhfj3a0S6L6VSkMIGLyFID7Ee/kLeNZoTD578Gk8E9pGuZh
         SZ9kxmnasaOLar0P1tgD6V9CDK7cyXph7xY2h/z/BmQjs77zEPEvh76HLErqBLWRf64T
         DjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4QnL0A3Nw73BcOMccKZeItFTtJqkxejmtto0llNGwgc=;
        b=V0ctAlxasMnBdamDFIlpoU9wtu0XAOwVLBRSCo488t/NhCsNIcxhumJJ9+VdDyMmet
         esP0AkzJ51RdG5C1o5prgjK9yjIIWRjtmE1453TC/dVCcWoycZX/duT3DkSLcFI4V+Bl
         yVb8h1TIo/qGoGUpANbPuV2CBQgGERMaUx9YHMx63Yt9HQ3jxfAfE4561GvUDXcfdsP3
         xCzZ+1YZM+dI8aDAnxL2TeGU/lP6NjfRDfdbSBuXYyDtK2rWfJnUIworFi4qDoBSpwqI
         ztgVVBoR6EsTURdG9ctRe7JEQ2MgVQjrsQBBwkSrgvfHi+oa7GOqVpYN7obyaFJ9OWew
         RDhg==
X-Gm-Message-State: AOAM533W+fpulfw2iO3PZItJN1Dib8rxDgwqJwelV27EGElM1aocQCBh
        061brCSjL/F32SjXl1qWss3/2w==
X-Google-Smtp-Source: ABdhPJx5DUYy4pXUglwpngfH/1QQRC5myM/HsBUihZ335R1S7JyLGXMzuDkuuUjxP3Y8AWe2Zeqjag==
X-Received: by 2002:a17:902:6b07:b0:142:852a:9e1f with SMTP id o7-20020a1709026b0700b00142852a9e1fmr42382200plk.29.1637978976522;
        Fri, 26 Nov 2021 18:09:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l3sm681893pgr.11.2021.11.26.18.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 18:09:36 -0800 (PST)
Message-ID: <61a19360.1c69fb81.19850.307a@mx.google.com>
Date:   Fri, 26 Nov 2021 18:09:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.16-rc2-31-g7975c7f139bb6
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc2-31-g7975c7f139bb6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc2-31-g79=
75c7f139bb6)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc2-31-g7975c7f139bb6/

Tree: pm
Branch: testing
Git Describe: v5.16-rc2-31-g7975c7f139bb6
Git Commit: 7975c7f139bb692861600c15d89034a24e467aa9
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
