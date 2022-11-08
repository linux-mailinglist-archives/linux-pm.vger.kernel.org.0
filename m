Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A02621BA1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Nov 2022 19:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiKHSOP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Nov 2022 13:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiKHSN5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2022 13:13:57 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA442314A
        for <linux-pm@vger.kernel.org>; Tue,  8 Nov 2022 10:13:50 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y4so14895373plb.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Nov 2022 10:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BzhISj0xFOxeC678WwyEuL8xdpn1PR8WGUq1GBoxBx8=;
        b=rL6Q+Qx5pzFU3B0HVcPiEZ0lMcPuoQJyI/ljrERCmRJz/c2dw92jWCxNqxadJglNzE
         m8QI4+lvn7HcnsoBTr+xsJB67DKO65mbgYIXaXqz8VQcab72KBbECvlQNcHkAdhA+Df4
         8PCkcFYSZfj8dWcff7aGeWZVs+Nhzw+pqLjPBX1q5VaTRtLSSg40d8ptfEdyWMTL9AiA
         IVRJS/rMxm63GZjrQ9l+sMAz+rga5KojWE839D4XF7bRwKOJBybMqC9zBcOIlsMy1QPG
         iHM7IbDviuaMfv3ZuAkqL8Yzm2csZn6bg4nwOLfpDhEE5m6aiX6tiHFcOnU5YdCwRln8
         AiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzhISj0xFOxeC678WwyEuL8xdpn1PR8WGUq1GBoxBx8=;
        b=xPgbcTfEtartLHxYNA0GL+QAzCNZKzMNVd+hlvE1JSMvPz0YtezdcOyLJhOnBuB0XZ
         kAVNvez9BBFssc4wNhKRbP6erys2sm3puEg2cn2kSGi+k9is8ybejwgG8E37UnxrXIzL
         PTcuZJB/qoSfRbKotKLoYktKjdoqDRpjxj1DxdsN9PM2Rved3S1V5evnMlSAH6a6p4yf
         Jdyav8waQ+qUCGus5bl6sOQb0t0PuHNta59ERSMCEazKvseHxwjNgK01ZyKGuF7VqjVM
         SsvJe8XQTO2xLGd7bi+ZjAm2xh7t0r/QSM2faI/ci4Hy7l5798sHpc5n/QigmpFeSZ/3
         T8TQ==
X-Gm-Message-State: ACrzQf223qyHqWRexw11dZBMZyXrkSiypp7JuIhz+pEjUgHsAlAMRYJ3
        c+xGXQ4JOHTEu7P4ESZ3D0l6V/aRyaOQkqii
X-Google-Smtp-Source: AMsMyM51H/IeedkbWjZLScI/ZU02xJYkAEoVTCR5s4GQSBEVmph4po7Cz/uutwY6pGqE8TvivHeMNQ==
X-Received: by 2002:a17:902:720c:b0:186:fb90:573e with SMTP id ba12-20020a170902720c00b00186fb90573emr57216356plb.160.1667931229590;
        Tue, 08 Nov 2022 10:13:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h37-20020a635765000000b00412a708f38asm6047285pgm.35.2022.11.08.10.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:13:49 -0800 (PST)
Message-ID: <636a9c5d.630a0220.d0f53.9d7b@mx.google.com>
Date:   Tue, 08 Nov 2022 10:13:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc4-48-gfd856f9c4ef3
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc4-48-gfd856f9c4ef3)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc4-48-gfd=
856f9c4ef3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc4-48-gfd856f9c4ef3/

Tree: pm
Branch: testing
Git Describe: v6.1-rc4-48-gfd856f9c4ef3
Git Commit: fd856f9c4ef381398466a06b3480549368d90e2d
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
