Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDD860521E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Oct 2022 23:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiJSVkJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Oct 2022 17:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiJSVkH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2022 17:40:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A83BF07C1
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 14:40:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o17-20020a17090aac1100b0020d98b0c0f4so1405377pjq.4
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2022 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KGQtdue61STOGh0BAJ3SzQlzb9LbubNM3pHQNRjugp8=;
        b=S5A0Slgxa5i8V/F0eumGClZrSbqR/eqJaelyZeg/uAVps2MOQvPw4PYQhA+BacjPVm
         G1LZhiz5E1gyH/ASs+kgMkYBuaCDhZQSTn6tfhDagjFxfmJlp4hbV/sLhi6o7cxRIQ9c
         U9ZnYqNNRIyVSt2s90dye9wW240ZAKD8Ywv0VZc/SW9yloTc2hu6MY04dwqTKbU/LD5Z
         g6P6cEfEvCo0+xe3CkUyKHJgLA/6hI5nDqfRNZiL20xCjV6yFK/uFUE3T0PmoPpzrz1r
         5TgeucsVjbW2UsU/nZf0kHxtfjSBzE8VU+nWzLPj/waiYyWCiDLMMfxzAeaqbEw29mkB
         3NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGQtdue61STOGh0BAJ3SzQlzb9LbubNM3pHQNRjugp8=;
        b=yBJqYiHEiQY1tfG93V8EuSUJQtXNwZQ7RRkawiWN7ZVqG9vRunwRsDd7uoWTtCXAxy
         nDGy0mskuEgtt4U7fVblRZxdRntCvj+cZhzqiGYrQQ05i5MmqzCQGByO3zIW/bzvcDGD
         rN6N3DaXYH0APT1yUQXHxYbLAB4TUGFY+7qgfOYm85N69kEFxEjEM8BPhM5rILM37L0/
         +iHU2cDUrBJ6KqnWWmquMMRLS8RkhddZU1uzwuY8cIqSLAk/2hLQxnQnFYAEa5BoBmR5
         uvbWqm+SiLe6I/NwOXEilBwlSrYcZLf+v6G8S7YNxtX2ocu1nK4407XkGWRgDv4qhutX
         GyWA==
X-Gm-Message-State: ACrzQf1PLZs0pcLJYt/fB7hTI19jE3BhFG4DKfdb0vJRqs6zyKwLcd95
        6201+j/jUvAvfWjRZsumjQ9AfQ==
X-Google-Smtp-Source: AMsMyM5Mz+CF7RKs0+9x10BeBNfLRvMNngk6EHAMGc9QXdYpT2NSYdkzlQVMiViT1fngvovTqM/+0A==
X-Received: by 2002:a17:90a:c782:b0:202:c73e:5488 with SMTP id gn2-20020a17090ac78200b00202c73e5488mr46947980pjb.202.1666215601009;
        Wed, 19 Oct 2022 14:40:01 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d48300b00178b6ccc8a0sm11249925plg.51.2022.10.19.14.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 14:40:00 -0700 (PDT)
Message-ID: <63506eb0.170a0220.f7c1a.5e19@mx.google.com>
Date:   Wed, 19 Oct 2022 14:40:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc1-22-g89871b5c10a0
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 1 failed, 7 passed, 1 error,
 5 warnings (v6.1-rc1-22-g89871b5c10a0)
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

pm/testing build: 8 builds: 1 failed, 7 passed, 1 error, 5 warnings (v6.1-r=
c1-22-g89871b5c10a0)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc1-22-g89871b5c10a0/

Tree: pm
Branch: testing
Git Describe: v6.1-rc1-22-g89871b5c10a0
Git Commit: 89871b5c10a0504b364a83363f47a069578ae1f9
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Build Failure Detected:

riscv:
    defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:
    defconfig (gcc-10): 1 error

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:

Errors summary:

    1    ERROR: modpost: "riscv_cbom_block_size" [arch/riscv/kvm/kvm.ko] un=
defined!

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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 section mi=
smatches

Errors:
    ERROR: modpost: "riscv_cbom_block_size" [arch/riscv/kvm/kvm.ko] undefin=
ed!

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
