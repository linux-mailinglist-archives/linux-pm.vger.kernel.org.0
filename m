Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B0D67A258
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 20:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjAXTGn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 14:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjAXTG3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 14:06:29 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD434FCF7
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 11:05:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso14971501pjf.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 11:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KXOioyWkAlEJT0B5acBBYcejxuhPR5IYp1j7h6bybuo=;
        b=LTJiYWPXpYTQX5CtHMsptlOcNbwkRi+szfHuQ4CClTNK0wEVkvBZKLrbF3mGE122bp
         fhAZodj4+Ut/DDDWJXTEkSWshsj8alU5cqXu3jsCD6LWwEOaJX8rAqgmsZ/q4CDgB3lp
         5G8aIhZS+HC9qWyVghMRy1AcRx3zCV5bjn8qyLwv4GD7n8re99uElIZqNrMEz+VxH+9p
         +4Gsd6ZwgPmFeC0fI4ILMkAK4Gm6KVFYcHUVWFu0jwAAIFuOoqogupXU4uFlfxQVUG+q
         iv6HMOsb/EagFeNb/r1JD327O+5EFaTuAgwo9HwenSv/y2hSL64BMS3anbVfRtiIyiY6
         pzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXOioyWkAlEJT0B5acBBYcejxuhPR5IYp1j7h6bybuo=;
        b=gy4ObWEvBcZLqOCHEiE3aAFXddUzvaQ1jN6WxC+YAuNYK/GGQDbegz8MIH4UHdWBGT
         VM413y2/uMivnPZKH4yeQRuzynjqdORkKfvmp8ALuCWu1IrxGQY7W7QnB8ljV3kykd1C
         gPRZcN8UwtgU6BxPR+xt5Jh4el+Cb2mF6UT8hLl4dbp6ZVIe93TsBVPo5VoQmf3uW/Ow
         hbbry9iS+2EfvCXKpFB4PRI85V6DG7MwBFarysAc358IcIuypkGIpdRBfQb4TVMJoKGd
         WcA5s90Fm+zcwC9qiqGK4OoC+aC8HUK6dPesxrXaZrUpFgHRG2XZv5WBU9zEuftws6K6
         WKvg==
X-Gm-Message-State: AFqh2ko0vqAep+1o9VzqaVGijFAS4VTriqkDFs4x06bTrkLZLp1+p+9T
        WZNsIgb+D+ZaE7RG31XXqZu4kQ==
X-Google-Smtp-Source: AMrXdXvQfuZEuUJgfm87yDonFQqBSSjW9crRIvoyPCEzXicRgZInvNukD7zC9pnKc7fpDrQamC8swg==
X-Received: by 2002:a17:90a:19d5:b0:223:ed96:e3ca with SMTP id 21-20020a17090a19d500b00223ed96e3camr31061334pjj.28.1674587154657;
        Tue, 24 Jan 2023 11:05:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a190f00b0022be553c49esm1874802pjg.44.2023.01.24.11.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 11:05:54 -0800 (PST)
Message-ID: <63d02c12.170a0220.75adb.4316@mx.google.com>
Date:   Tue, 24 Jan 2023 11:05:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.2-rc5-95-gc37ccd838159
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc5-95-gc37ccd838159)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc5-95-gc3=
7ccd838159)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc5-95-gc37ccd838159/

Tree: pm
Branch: testing
Git Describe: v6.2-rc5-95-gc37ccd838159
Git Commit: c37ccd8381598ce7a31a9606ba2dd1c1da289990
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
