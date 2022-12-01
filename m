Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B0963FA8B
	for <lists+linux-pm@lfdr.de>; Thu,  1 Dec 2022 23:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLAW06 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Dec 2022 17:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiLAW04 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2022 17:26:56 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6AB5AE3D
        for <linux-pm@vger.kernel.org>; Thu,  1 Dec 2022 14:26:55 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s7so3002225plk.5
        for <linux-pm@vger.kernel.org>; Thu, 01 Dec 2022 14:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3OB2gxc6zE/eDGAkTZ84q/Ynk0mkqUy8h0mwl/rBk5Y=;
        b=LNpfCUfwefO50A7FL81mSyfyOzj9zHgyBEkGYZcqUfWIu4gGcE76uaJSA3mehLaCdZ
         UBmoeVe1jkm/mwvkz50qFDy8GhOXVVOPOhvMO/59Pm52zIMtSNIu0mb3jfTqgsVZIW0c
         P6kGGnGLvsh33ebRS6MED7567w0a0JBu/pbCZf3seXLe2pbOXIQCVigJFYD3MiTH0zp0
         T5F32pNk82PrCPIe8xHmAc0jpjVZq2kagxDA0QKIsCWauz04NRE/Daapd/NFqxoR0mv/
         AxdIWgXI37yiUFbUEREOBAvBu+YolsGqpfbVvDViLrkMkAqigAnzqLQQY1yGQiZ5HdpG
         05vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OB2gxc6zE/eDGAkTZ84q/Ynk0mkqUy8h0mwl/rBk5Y=;
        b=TPsGFcZziwT2KlIEV7SEIRwGy2Pvp53jZJ4tADcc0Dpv8bwZSekdruzGPhXl6+5DUd
         aZ5s7cqUd712+c/jZa4GhJL9vDk9lHo+e0CJvY66XkD/IJbJa+AiNfCPjSBQr4zeGi5q
         WzIEcnHFvZKgP3c/rIVtV9HnfdAuoU/hwWE7yIq2lSBifXPvB+iSZmtTh2k9mmB1ZYDT
         YjdDpda+X3PQc/Ffg6ih+vVl+b64Lpd3aHEF36amDLPhEWEBvoDho6ZzJ3xL/OJ5vL0+
         HVJWVhHl6r7gfn31MSCxbAZIEgA28iQyjk1O3S0YVNv3P4Lro8EY0/FFKK6DoJpBMtvj
         u20g==
X-Gm-Message-State: ANoB5pmJfT802Sq2eZ9K6dQdlnST4KZHJiPkIh/RMseEoOWeX7D/rFic
        z6sv2jDiq/9obtFKToVYjPuwpg==
X-Google-Smtp-Source: AA0mqf7NNn3mTVS5I4uVyN+nO2jRcO1Kt0wIsUx23cqrsdwg/26fzc68+176tezXPp/HpKqq7r7Qag==
X-Received: by 2002:a17:90b:2642:b0:219:55d5:f30a with SMTP id pa2-20020a17090b264200b0021955d5f30amr14807330pjb.23.1669933614808;
        Thu, 01 Dec 2022 14:26:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b00186c3afb49esm4056611plh.209.2022.12.01.14.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 14:26:53 -0800 (PST)
Message-ID: <63892a2d.170a0220.96441.84a6@mx.google.com>
Date:   Thu, 01 Dec 2022 14:26:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc7-101-g0ed70fd3fac1
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc7-101-g0ed70fd3fac1)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc7-101-g0=
ed70fd3fac1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc7-101-g0ed70fd3fac1/

Tree: pm
Branch: testing
Git Describe: v6.1-rc7-101-g0ed70fd3fac1
Git Commit: 0ed70fd3fac1e58af85c571c2d003319eb24ce1a
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
