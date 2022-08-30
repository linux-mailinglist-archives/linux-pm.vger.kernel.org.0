Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3655A6EAE
	for <lists+linux-pm@lfdr.de>; Tue, 30 Aug 2022 22:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiH3Ux1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Aug 2022 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH3UxZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2022 16:53:25 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F4E6FA33
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2022 13:53:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u22so12250894plq.12
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2022 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=6MjwdKeM3FD+9HeicCwYVFBY7lohnBulu4A0ZpaOGkE=;
        b=AL3Ggv/+QmRoZAs5RldGvOI+4FPG09jwUR78bTHG/vpWpnWNXT+GosTuMc9h2eBqIB
         Qo47dqFylEcyAm/gcSghi8v+WR+8maaq9TQ/NVPL9BkGIYqyu53eORJehN9drFVkdsLI
         FsKd84M/LmaMyGi0Tn9rgmWAZgSnHK0gBs2A7WGMqWzzqxEqJC+Pj+S0ZLi3bVxrleJ5
         KQRncAuKjwZB3XnhCSv4UjQu+lnlg+SPdntW691z9oh+NZJX7INGjyvgxotl9kv0U0Gk
         8YxKDfwi5HkeyNK5+xbkp+VCstGQYpTiwmG3IrbN1tBpB8XM6iFjuwwlJYc4mV8pW1X8
         cUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=6MjwdKeM3FD+9HeicCwYVFBY7lohnBulu4A0ZpaOGkE=;
        b=rt1h/z6xUoSA/i/0Rue3PBMK9YnvpqIoou+PUa7aJ2dm14EOTa8NR85XI5WP0zN3dz
         nj7jGy5V4N0ozayRkl/ctkp3fQY2IbaVMU+cOOxu54rlI7ug1qvHdkOSD7YDvH/HRvx9
         sHUI3+rqz7HzSxjYWrx5JJvHM23X0TiLKPDuLn9Zc6VkltW2kGZSyeufpWHATw5uswB8
         mvJJsaqVWHjrOi7isrsp/60QD0Bnqys4FarkRvHUg5TCsVcOitCBYBdAoyQis2XNCl7i
         oq26UaNLjlZw1jFrpQZiA5rJOvgwFjFuPfsP9WhIjWqdMb4hSQx1VNu2C8GRoZrC3ppT
         UjgQ==
X-Gm-Message-State: ACgBeo32CTCQVm56gbqR3k7ypU70MeORiSXNRg2zywiFG5EztctFHZe6
        UouAkpjwcsFGSYdeFmbVZtjj9obrJhrivP0vcak=
X-Google-Smtp-Source: AA6agR68CyLj/p3MuGZ7rf6zG0OfprfPhovwb2czOF2dmcC8QoagD9FveeT9BqHGMM/S6ne+Zh5aXg==
X-Received: by 2002:a17:902:ef45:b0:174:3ad8:7aec with SMTP id e5-20020a170902ef4500b001743ad87aecmr22855694plx.128.1661892802320;
        Tue, 30 Aug 2022 13:53:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w185-20020a6230c2000000b00537d0207b30sm9251628pfw.184.2022.08.30.13.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 13:53:21 -0700 (PDT)
Message-ID: <630e78c1.620a0220.dfeed.fcde@mx.google.com>
Date:   Tue, 30 Aug 2022 13:53:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.0-rc3-72-g41607487f81c
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.0-rc3-72-g41607487f81c)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.0-rc3-72-g41=
607487f81c)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
0-rc3-72-g41607487f81c/

Tree: pm
Branch: testing
Git Describe: v6.0-rc3-72-g41607487f81c
Git Commit: 41607487f81ccdf20e796adacc277483ecc9c234
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
