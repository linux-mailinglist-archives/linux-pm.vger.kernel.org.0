Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188B9695565
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 01:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBNAfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Feb 2023 19:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjBNAfK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2023 19:35:10 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAC45FEE
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 16:35:09 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 16so9108578pfo.8
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 16:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xj6V7xX5UT49J4Mn9y+uxWXjOcrNSAjB82TLkPXnCbs=;
        b=w/Hd6MIy4KlhVgHD9bFH94gNRNsM6hQBcVphYI0whl1lgm/NU2Ee3OzOQg1r3nYlbH
         nY0Lfj6V1qy+HZPcKJEqBzRKj5Gkx3hyNYMZoYVTN0bi7vFfqWnykIkMY2xiEwE53mLI
         lYwiYK4raSNjeeN5xRj2eKJwr5OI0Fo+djIaHARNMMIcj2fmlp39AdcWrFOWvkKTAQ1h
         v/3hsqK3BfBExwI8PetWfYywnrZ17i6bhPdy4q8eR/mj6Dh63rpueczOJchP01EQKPJL
         15KPpsI9AvF6pVfBwRIYBruRLx4b7QPoQkX+YcjZggapyABsasgzmdC4ryI2SYhCln/9
         tMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xj6V7xX5UT49J4Mn9y+uxWXjOcrNSAjB82TLkPXnCbs=;
        b=kuL7wVD8WNVa3iRvzmFR9AhX+I6XHaZ7zbEtM5j5xHZSmYCXfdp4U8fLKS2hOrfX1f
         /bMGILUXus3TPfbRr6Ddwq9j62okde1NpytcYAqbEIypZ//5UNlaWtQ7khJdopKAJh9W
         eoouFcadIzPaTRZTYNlJf8PkTP1Tf+CLq7SRs3BoVZHv5OyUzVsw4rSqpjaiQGRZj1md
         6QhmlWxINJSRxUieKYns1UzcRDD4G6X3NzsFgbT9FhdGEHhWRYoHdiyOcdqHUdyhVaj+
         xJAFocUuwyvR6C8YeJ2QZ9Mamyq3DjfgPKsxdvYpEsBFjcbvR4d2zpa+iQ/jPKJV/YIF
         6k8A==
X-Gm-Message-State: AO0yUKUD9Be75Sx+gwXtbauiKUkPr9jvEYkPdTd4JyC5axwBeykGs1BI
        Muxtk5Dic1qL3822d+Y5teguEg==
X-Google-Smtp-Source: AK7set8HbnDPH/JAHFOH7YbwQvdDulgfy63uve191tVTpoW1x/x38zmaDii5n5/O5h2v53Bu90DD7g==
X-Received: by 2002:a05:6a00:78b:b0:5a8:cc39:fc58 with SMTP id g11-20020a056a00078b00b005a8cc39fc58mr2154413pfu.6.1676334908742;
        Mon, 13 Feb 2023 16:35:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g26-20020a62e31a000000b0058d92ff8a31sm8410049pfh.187.2023.02.13.16.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 16:35:08 -0800 (PST)
Message-ID: <63ead73c.620a0220.e94be.f4d6@mx.google.com>
Date:   Mon, 13 Feb 2023 16:35:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.2-rc8-229-g00400047861d
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc8-229-g00400047861d)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc8-229-g0=
0400047861d)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc8-229-g00400047861d/

Tree: pm
Branch: testing
Git Describe: v6.2-rc8-229-g00400047861d
Git Commit: 00400047861d75925de73c4e8929c447b1306afc
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
