Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673FB76F64D
	for <lists+linux-pm@lfdr.de>; Fri,  4 Aug 2023 01:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjHCXyQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Aug 2023 19:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjHCXyO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Aug 2023 19:54:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0619C3A9F
        for <linux-pm@vger.kernel.org>; Thu,  3 Aug 2023 16:54:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8ad356f03so10947885ad.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Aug 2023 16:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691106853; x=1691711653;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DhzMCMHBxl+jHto/BpfCbmy/tvKGbsqkDX2D5X5gQ18=;
        b=frCwroRpEGo/y2kPTno24aecHZ/FknZgW10dCPbxTL1aL7z0inX5bpaE+M7pt9WP9S
         KqBpS0QHu64t6BJ5jVR/j2R0k7vR+/WRE2YlE+vkKQvqCKKn9IkCSgxLXvcfgbJwE199
         UrbjNWTAkEyzjm0M7ftbpbiEsRaqfNTbz0kq/oPdEK1EE+2Xtd2ptr5TyWlCNkUMgF61
         ARJDy7+h8YXFPHzJ7cXsdXFA4DIbq1r0xdu0gFg9WjocjA6Nr1QJO6W1vhcxz8s7csRb
         dJY67SOLVNZOviEdslf23kagtmNJWaL9AZInE/ysQoH+c9MetdCWPvnrGiYG59xC8o4H
         LOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691106853; x=1691711653;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhzMCMHBxl+jHto/BpfCbmy/tvKGbsqkDX2D5X5gQ18=;
        b=MkRK+iZadzVmwodmvBIb9cX4ZNgBfVMmrOQNak3kCwHkP6tLm0HFuFajfKy9qu9ZE3
         dRFTNds299PJGjbZSF01AOABwWw0Zblx9M73WRVZtFAuD9Qm+BROAP8j9og6X2vmljO5
         4unPyq7abYRL9VMeTdw+JPbeN96JwskLdGg2RHWYF3S7VZPOMPnq5TVqq1phxm2ieLuO
         JjbaFnpP2m6ATz6D1lQgiw8Vor1rylraljzU1OLvYeGJqX+fWhKKLmjet9ed8JIxKAw+
         /HRSCITjjfjIIS/QrtNht7YlaT+NCLhZ0oigkhZ/PLjTRPhoN4tAPCWr7stybU/mrNWI
         2sPw==
X-Gm-Message-State: AOJu0Yyi9c4Of4Q4ThsGN8P2TAVy9/q5rgBamlijNIRfv5RrS1F0s+xc
        DNqLv1GPIkcCNYEJyfU1aEFpKlAE7HH8lWVobXj7LA==
X-Google-Smtp-Source: AGHT+IEzQz5jb8fCU1AGZtgkgvdY2zXyuavSFJh7rv53+cUsaf1eC7JlGhRzmLI3slWrJwGGuq64Eg==
X-Received: by 2002:a17:902:db06:b0:1b8:9552:2249 with SMTP id m6-20020a170902db0600b001b895522249mr187436plx.43.1691106853519;
        Thu, 03 Aug 2023 16:54:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001b869410ed2sm404482plz.72.2023.08.03.16.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 16:54:13 -0700 (PDT)
Message-ID: <64cc3e25.170a0220.fb232.19f7@mx.google.com>
Date:   Thu, 03 Aug 2023 16:54:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.5-rc4-68-g8a3c19975d99
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.5-rc4-68-g8a3c19975d99)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.5-rc4-68-g8a=
3c19975d99)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc4-68-g8a3c19975d99/

Tree: pm
Branch: testing
Git Describe: v6.5-rc4-68-g8a3c19975d99
Git Commit: 8a3c19975d99406f6494a292ea1fc6ef57be9183
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
