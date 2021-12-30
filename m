Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3439481DE2
	for <lists+linux-pm@lfdr.de>; Thu, 30 Dec 2021 16:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbhL3P4a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Dec 2021 10:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbhL3P4a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Dec 2021 10:56:30 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375E3C06173E
        for <linux-pm@vger.kernel.org>; Thu, 30 Dec 2021 07:56:30 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v25so21768419pge.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Dec 2021 07:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=5JtJxfzgWXREJNVRQweKsmMUML7D8pwiMG7VLXd2Beo=;
        b=yhU8cg4JbWvwEzfoP1oJmUcQcuMy8r2UuE9hFCv9gmlz9E3LCcjS21Pmv8rbA10+4s
         Y5az6Hf68CpQlPdOqgkn8ajB4ZVTfTal3DqmDrnmQAkx39ylCbi2AW5HEyZruo48eusB
         Nz9AjJWGqYMBAT/1FhcaMzDkj/28unb3TjJzzWLOE979Zfj6IZwPkbYtH3oI4/A0py5k
         vjuLTNLlg35NvD/axJyp+aayBSPdjwltpeZUjiI6vIlSlsqUPbhgdW8O9eeL4yB3v/2E
         EqCuy0LbZNFgx+61lLBw564l2ZkJ4g7nxTBkp+x43iYXXLeDx/ejbgFYHhs9hN1qFPkq
         1QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=5JtJxfzgWXREJNVRQweKsmMUML7D8pwiMG7VLXd2Beo=;
        b=AvznmtmvDaFc5GGvt1dxmoaB44XTEOI/9cyumiPc135lhzfHQRRbz5cL0nC3K9/Gy4
         h2A8D7bx7tQ4ervtE8s+cwYqCcOgY5QUO6m1v+9xfSFSy8XXp+n289OcBD2U8+qgqewi
         3SMAYx4+r7A9MlwzGK+Jr1PbvnAfQFKu9fvC2R9KdNg8v3InXIXc4tr33SHOcLshzHDx
         +Pc1xfPDrMqd0sfVwTkW9SiGLZWyCWVWhYnzHhjactpjMlvxS4Ct4QBU/+tVeVfNKuCl
         rW/uiIvZQs5sgxWdf76A3G0mMYwLWAWGi4hIPes6GdR0mFQkQ4BmpS9cUcSGZWP4O7Zk
         t62Q==
X-Gm-Message-State: AOAM531x2pI5e7MqlanZgKUjieZFfHLtxST/MqEu5cJ1KE93taqL0/8S
        lEKUylc5HH8nhA0JuFQC5CitYA==
X-Google-Smtp-Source: ABdhPJxE+ivRFnilv6mm9T9xQkfz2kfB1X/FTgUyHOSf3KIF6d+lQunQrMWgjWZT8h9jAfcPVsrbPw==
X-Received: by 2002:a05:6a00:174b:b0:4ba:c9f4:d4ee with SMTP id j11-20020a056a00174b00b004bac9f4d4eemr31956655pfc.3.1640879789837;
        Thu, 30 Dec 2021 07:56:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h17sm24006608pfv.217.2021.12.30.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 07:56:29 -0800 (PST)
Message-ID: <61cdd6ad.1c69fb81.f74c7.fe69@mx.google.com>
Date:   Thu, 30 Dec 2021 07:56:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.16-rc7-138-g143d2aca78e4
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.16-rc7-138-g143d2aca78e4)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.16-rc7-138-g1=
43d2aca78e4)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
16-rc7-138-g143d2aca78e4/

Tree: pm
Branch: testing
Git Describe: v5.16-rc7-138-g143d2aca78e4
Git Commit: 143d2aca78e4249800d88ccb216e94db20d56fd1
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
