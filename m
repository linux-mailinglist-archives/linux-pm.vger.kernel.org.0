Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D82E63483A
	for <lists+linux-pm@lfdr.de>; Tue, 22 Nov 2022 21:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiKVUc5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Nov 2022 15:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbiKVUc4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2022 15:32:56 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF18F599
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2022 12:32:54 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so8943677pjc.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2022 12:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jMJItYMF29YfMh/OsZNI6VCCgORdvfB51lyo6jNy2Zc=;
        b=nh4Eom95rOeFdNvSiGhaLb+5ZIXcTBbgAVqeiUlUmjxsPFF7ReUySznDatdiEmItJY
         7Ut3a7PDtdIQRiZJWt4FKGKjG/KvG7j0PJRyVGC0+TTU+IxzJAN/iA/0oSBHJ8ntlE3Z
         duY39XaLbr1wY1etSMgm2MKW6iuU3+erAhMCqD3Q9seq9YZcGIwLJH7QivgTXoivFTuq
         niCufs7kKpCgBb9W2tcueiJS9DFEA/abYaxmsH/ur9jQs+1b7hIAavuWe80cG+g31ll2
         JS5H2cTrhv18TNTSlhJN9fPKeCWRbyDG9aAmiDblAJzf/ppBwIZc6ggz9U6Q/I0+HMSr
         3wZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMJItYMF29YfMh/OsZNI6VCCgORdvfB51lyo6jNy2Zc=;
        b=CH1AmRkHG2cc9i4LijfVzlbkTOdqsW9QoL2ngpGEgA3gAhC1dlwFsk8lioCeRZF4oS
         D/RLQiT7pvzE62bs+Fdm3V+o/SSVjTd28X0UsjeVmbkOX4/+bw9c2NqgDEUZkhNDuWmJ
         JPnEOPy/fiWIKpbeIATBTtFtk79NP8wkPyjjv++raNUiiKHsw6bKRcePLiHZ4RDRNQZJ
         bFbQe/ZLylX+yz/7k7nTgOUBCPISPqOy/s2N0JZ0+WPZ0s9BY7++dCxwFxdXsmCkzUqC
         S0va6XyEsHzZQCksUFwYZZVe1uk1xwQ1bYX4VrrXJb0SKGSX0D0+sseOHf24uiXsfCZY
         c29A==
X-Gm-Message-State: ANoB5pkS1X7aVAzu3AkdFeGarfSq2IdiG5eJPw0P1MwoQB+8puceSU2w
        SGIy71dFzEoQs7pYobY953WZHh9Qz+6MwedYkdc=
X-Google-Smtp-Source: AA0mqf74c7flzT/PVmG6Fl9BIBA/54pe8OLtrIaKldc2GJCI4n1uCv+XBUsaQaw28HFo63JYLvTjcQ==
X-Received: by 2002:a17:90a:9c18:b0:212:fa9a:12df with SMTP id h24-20020a17090a9c1800b00212fa9a12dfmr33552866pjp.231.1669149174077;
        Tue, 22 Nov 2022 12:32:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w13-20020a63fb4d000000b0046b2ebb0a52sm9466363pgj.17.2022.11.22.12.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:32:53 -0800 (PST)
Message-ID: <637d31f5.630a0220.8661a.ec2e@mx.google.com>
Date:   Tue, 22 Nov 2022 12:32:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc6-89-g611bfa6eb1e00
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc6-89-g611bfa6eb1e00)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc6-89-g61=
1bfa6eb1e00)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc6-89-g611bfa6eb1e00/

Tree: pm
Branch: testing
Git Describe: v6.1-rc6-89-g611bfa6eb1e00
Git Commit: 611bfa6eb1e00510c7f77ac569929d470984366a
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
