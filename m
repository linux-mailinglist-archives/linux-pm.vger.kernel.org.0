Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F3959ECF0
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 21:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiHWT5S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 15:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiHWT46 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 15:56:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1957B088C
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 12:06:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e19so13638242pju.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=4pkZk9PsezWQV6A60JZshv0YIMDrk1QHb8KMSkWApS8=;
        b=EK9NqnAaS6eHjM40ifzlCQT0IM/y+gEsmU9xkAZlEauA9qnmmFTIu6ywG0hC0zqY7G
         LGc6utTr6sQNMX63kTa9Bg74THwqf10ddzwN0Tgz3oNgSdgh+++FWS9KGwiNB6krfA4A
         Ikr8yAO8oKPa5nEfDPwcJntPXrOoozSdHhFaraO8hxJ22EVqIeUVJm8CcYZXJCLz5kst
         pDXRu9vPR3fxnHQE2rbQkmG6AJ3YXR1Zh9bd/XoYNYve3x5VlU13FI1ZKIk5S9rb/1We
         DglL+Tr4z1m7yZAB/Kc1aztjf105ixrABQjSu590k1oqeTNvx2BxuwXaKbzs54er4Sfx
         3bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=4pkZk9PsezWQV6A60JZshv0YIMDrk1QHb8KMSkWApS8=;
        b=igzefOR4cjwV44JS6OEcQqGnJPMp2ZfU3R0RUx3hEkdX5ZYhzESIxZEmobQ9DWY0eb
         NJP264zg/yjzebZpj3snSRhJGm0RSJF9Px0rjZqXe8lNKwMJ1P5mo4DnIGPumroOKDdO
         9s6N28d6x8N2FJDIbe0qSs/PzBd6E4TUogpEewHbyhTks9xYtIdJcOYXFwgk03zVyZm0
         24vcJo7WIOM1GKa+S6y1y2XpHzriIDUUUCIiU/39IQuaVvr2JZW4oYH0zEOxRD/61oVr
         lSa4kkRncSgJv5gZ8t1PCPDuTkiIe+tiZtWeSb5eCpK8t8L/1u27/LM3zkFGW5lVcBpV
         S+Xw==
X-Gm-Message-State: ACgBeo0kMEAvvR1hTvquv38WXq+gQVCjGOSdcgkdqR0CZ8qj8ur3gUIL
        Ytv2BVdLsni4rikdIkPP/zx7SQ==
X-Google-Smtp-Source: AA6agR4rAJid5nln0/PtSiuKhYKmWILJT7tb7LpzfXsKHBm9dKTHv0K+oYsXxUEEYqYq/Z+OK1+Vzg==
X-Received: by 2002:a17:903:22cf:b0:172:f12b:c697 with SMTP id y15-20020a17090322cf00b00172f12bc697mr8696499plg.98.1661281585202;
        Tue, 23 Aug 2022 12:06:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b00172dd10f64fsm6083761plg.263.2022.08.23.12.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 12:06:24 -0700 (PDT)
Message-ID: <63052530.170a0220.45ab8.b660@mx.google.com>
Date:   Tue, 23 Aug 2022 12:06:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.0-rc2-7-g6e877492c466
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.0-rc2-7-g6e877492c466)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.0-rc2-7-g6e8=
77492c466)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
0-rc2-7-g6e877492c466/

Tree: pm
Branch: testing
Git Describe: v6.0-rc2-7-g6e877492c466
Git Commit: 6e877492c466c6118cfc1829cb122d69a16b8d03
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
    sparc64_defconfig (gcc-10): 3 warnings

x86_64:


Warnings summary:

    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"
    1    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.

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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
