Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E616116FC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 18:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiJ1QHO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 12:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiJ1QGt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 12:06:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DD01DE3D5
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 09:06:00 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c24so5213944pls.9
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fcQaevsjRfO+W5RAjncKOm4xdkPjE8glulZFKh4Ab2w=;
        b=afkEYK+KWOFm18xOQ2COYDOrKb98ORr97ImSJ/2gNdu5LTGMoDgh+GlcFOUDHu2UbJ
         UI8Oy6bnL+KkQ9ZGelUEMz1mYHaVRCtS2J7KVAOrs31vu6q25NXnCusN0tE/muBdjTyj
         e2e4vaWc5q0JHJ02HB0BvoU3/uUmUMNRI6pqAjAZiOwBf1pqZv5fjcpm9RSh0h8OZG8O
         TGmVzSTALUkjRg0zZHa7UBTaNQsuzsWi/ULTWuomxw2jlzmqB5k+cz9XRD2G7fOsFJP0
         NSGSKgQnkjwhF1wn3YEa51x7VKCoUGPMTuSzDi3rOn9XHcXcK5IE7D1ePFTzi+45t02/
         mNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcQaevsjRfO+W5RAjncKOm4xdkPjE8glulZFKh4Ab2w=;
        b=Lb75uIcgx2yJELO7iXpC7RJZj3/pM/an/UqDzeE+OTnS+cloyElrVQULSkbH/N8Rbf
         /EiT166fjN/rKEBKOeibv4gwvx4d3gcuTZ9pj9ZlZKjd9txjN6uWPWooUE+ntH3gyPML
         eDb2jykpIN+TbNlxd5IcIBR832KnjAD80y32gvgiJxxmog+sB2zc/Yd2tt6dDa6BwDpX
         /47Zvp4X4BF7mUraw3cEYe6xLWYpcsv2DuvkgF1PLOK5fOxbaVDK1KlRVBcADKwUcnGF
         NAoCNYqlNguRFxRyiLSVQ+6j+4c6k72GoMXKiEHLXhrRHiPVhX36W+oAmbSYPw5r/7rg
         XPhw==
X-Gm-Message-State: ACrzQf25nh5TBzvyEHlKUPBnn03+jCWTK+N8MZX9XlefNPuhy4mbhJnX
        yus5GM1y4QIGSJFWYgMdOujT+Q==
X-Google-Smtp-Source: AMsMyM6UBdUKVERXADxfKkaSI5b9wrKz7T3JioXTveJUmMZfTpkTJxx8weSZsfwQ1mHBp2kuVlBZgQ==
X-Received: by 2002:a17:90a:4d04:b0:212:ee1c:b0ec with SMTP id c4-20020a17090a4d0400b00212ee1cb0ecmr17212950pjg.66.1666973159730;
        Fri, 28 Oct 2022 09:05:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e15-20020aa7980f000000b0056bcf0dd175sm3017896pfl.215.2022.10.28.09.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:05:59 -0700 (PDT)
Message-ID: <635bfde7.a70a0220.f562.6062@mx.google.com>
Date:   Fri, 28 Oct 2022 09:05:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc2-18-g111ae903a8e62
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc2-18-g111ae903a8e62)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc2-18-g11=
1ae903a8e62)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc2-18-g111ae903a8e62/

Tree: pm
Branch: testing
Git Describe: v6.1-rc2-18-g111ae903a8e62
Git Commit: 111ae903a8e6222057b042648ac9b64ffd4adb63
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
