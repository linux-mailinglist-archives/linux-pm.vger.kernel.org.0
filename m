Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EC868E2A7
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 22:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBGVH5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 16:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBGVH4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 16:07:56 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C767D7EC2
        for <linux-pm@vger.kernel.org>; Tue,  7 Feb 2023 13:07:53 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id r17so2395944pff.9
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2023 13:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K0sAjzUGmo+GwipT5P925u6oD+JMe71MuM6syTSsH6s=;
        b=5baEN6jN7yRCnbtApFj7IvInvj39C2tkTL34BTmvNWRqyaEdUJDqiwF+lsvdo0hi2r
         KicZdpu4YvsjS+85KqynTZ+thfXFw6usAoWZgRpPiuURkyc6gAOdEsTU7HtvDNmTdr4+
         EziQpPSLEFNX/o+PIlWJKyNT7g5svv6DNedaWOcBkuiip66k7X5o8qGQ85QvzocjE26o
         mdSmIvzfcK3kBL4g7yPa6C0nnBKWX7x7DqQx1x9ziH44Ro0iHt+Z0E339x1tZMRy449L
         XmIQqq7HgjpBIfIsBYNqhoKtBxntXt2ig7s0LLfy3T9qLYSTJDUudIzGExhk7eL5iBdj
         v2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0sAjzUGmo+GwipT5P925u6oD+JMe71MuM6syTSsH6s=;
        b=QDzHaqrTW4ZsBH5bWBmxMrENfKg8wbEX6K+ytdCiWAWBEVw2r8VPG+ClZYlWVYOawV
         afSRyASPwBYTlOIHFWuLsKKheEbip+qF93ZQ4rSHRr1X03HejDP6f+sqizHte1nIow53
         ee7cDCckn47D/U3BFX53vk/mCsFPP8eWzBzuez894iO3YElqFJbjnG8amnxu7oWrYrHX
         xGtzEPXJtinFw7eLWUHPME7+UcxgFrbWhppjF5VVSNeJrnfK8mVQV9srMXT3058KAZDu
         Jiy6gatm20mmEhVbxr62ti+lokRMsbdrqx+sLUImH+b7HOX+Xz6cPX4u4SHy6n/2juw2
         ZdPQ==
X-Gm-Message-State: AO0yUKUuixoJwoyy9zO8UVbF7yU+KHQiAA8aJDGkpuC6/AzfVU1H+WF1
        aSkx+0aOjdGTPHQjN+XNNZO61A==
X-Google-Smtp-Source: AK7set8E6SJAI3NHg3IDkirqEQ6KqAvVVegaenPXGcP19asyRllPWWDvWK0nz8QkyuIjIRfx0Dqjig==
X-Received: by 2002:aa7:9603:0:b0:593:aa46:3ab7 with SMTP id q3-20020aa79603000000b00593aa463ab7mr4542913pfg.5.1675804073379;
        Tue, 07 Feb 2023 13:07:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a23-20020aa78657000000b005a75d85c0c7sm2157592pfo.51.2023.02.07.13.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:07:53 -0800 (PST)
Message-ID: <63e2bda9.a70a0220.9fc5a.48fc@mx.google.com>
Date:   Tue, 07 Feb 2023 13:07:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.2-rc7-181-g1904ca445dbb
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc7-181-g1904ca445dbb)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc7-181-g1=
904ca445dbb)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc7-181-g1904ca445dbb/

Tree: pm
Branch: testing
Git Describe: v6.2-rc7-181-g1904ca445dbb
Git Commit: 1904ca445dbb8585fc136e8c0bf2c3b0cbf2c64c
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
