Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BFF690CC1
	for <lists+linux-pm@lfdr.de>; Thu,  9 Feb 2023 16:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjBIPUE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Feb 2023 10:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjBIPUD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2023 10:20:03 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C950270F
        for <linux-pm@vger.kernel.org>; Thu,  9 Feb 2023 07:20:02 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id n2so1541869pfo.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2023 07:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEQxxihcqCdWjmpUHdPGQq1bICTTszHLlEfi6tMRg68=;
        b=Ht3DUc9iXP3RIyflysfWrRnuFN5eUSk1dLVoiGAdLS+A13Nbor3x2Gx2B9Gv7X/7iE
         GsvxCEhq/Qy5e20TBCLIGSTpKrxxpdCGPhgLX+PNzhKvjZ1YQa+MKBCqCn+oGEz4Y0iR
         tPYAIR2HXwmsfxv9bCEG/8vCprvrbsb6QqJ8dqIrRAS48E9J1pAaF386ZwO63ZuufM2Y
         B7iTg+ZO3y/dqRH4mRne68/uaE9x7Q+n3mOKtOd99OhWaCDnDaZW0heJit7pAX8Az0eV
         fPXs45BZ9Xk53phoEJE3rA1zwAId5O6A29znYlrX8FZgNSuBsUAlnx1twUUGVwhBLNDB
         afkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEQxxihcqCdWjmpUHdPGQq1bICTTszHLlEfi6tMRg68=;
        b=cOt0qCetPZUwM02jqd3GqXIYECd9SwlkWEod3J0UGWiv9E7hqhBeY5E+xrEOfPSFCn
         68MpMhxsEbkLX4fRVabQmhKTYzSd34an9oESYcKW1EqUiN7cT2W/dvtw74EkinhsOSP2
         u7h7+LTCLgUA2DC4i6YIo+qECTedMINr55Can14pJ9Ubzhucd9/3zyOHIj+rZOR9DylV
         BFzlypAZoYw1wutKsnhHxmdPU/cvbGBguAr3/MUANoEROwBuE5qOn4gJYrNHvDLr/0XS
         34pTOdqICYFlC2i8SGkdOScikz+npuc+vH1kBpsMfCFgEn0mcEqjI/okfoKVL/J1aMtE
         eqGg==
X-Gm-Message-State: AO0yUKUMREtllKvBaoeRv9+JL2WiTqEvq5VMIIhm4zqUyYSWrPu8b9I1
        p1RT4jamsQfGMRHJgMrPBnAlkjh0LoJhObmMvjgePg==
X-Google-Smtp-Source: AK7set8O09Q/P4ET9ZwOh0RO951Q+PJbh9SnZkTRfPVYmU5xPAq7iWSUaHygVCqXwaqVJXwV0BcUYQ==
X-Received: by 2002:a05:6a00:189c:b0:594:1f1c:3d32 with SMTP id x28-20020a056a00189c00b005941f1c3d32mr5794593pfh.7.1675956001801;
        Thu, 09 Feb 2023 07:20:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h9-20020a62b409000000b005a84e660713sm1546693pfn.195.2023.02.09.07.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:20:01 -0800 (PST)
Message-ID: <63e50f21.620a0220.3dffe.254f@mx.google.com>
Date:   Thu, 09 Feb 2023 07:20:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.2-rc7-185-gbe3ba1769837
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.2-rc7-185-gbe3ba1769837)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.2-rc7-185-gb=
e3ba1769837)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
2-rc7-185-gbe3ba1769837/

Tree: pm
Branch: testing
Git Describe: v6.2-rc7-185-gbe3ba1769837
Git Commit: be3ba1769837f7763b8d7019498af49f08aca3e1
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
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
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
