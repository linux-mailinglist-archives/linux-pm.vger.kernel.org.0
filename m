Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B8659D01E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 06:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbiHWEj3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 00:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHWEjX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 00:39:23 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E104D241
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 21:39:21 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s206so11272101pgs.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 21:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=tLPif5IZVtf2238BGbc0Lk5Ah2P//dhT4MZLzRLGmkQ=;
        b=ZasH2hBzSQfYAPDPiVf3AWnE9sd1DIT306lJ7j4qyK4XEBaP8IBwzfQBEHzA9zJJiz
         c5Ih1N5z9nM3ejQJG0+1of1CtZl/Lh8V3k3J5TIqn/wSj+XRW3peA4VpBN75c5IkPEu4
         7nDD8Bz6a5nB+m+1ojnS8OEYTKzujQ0XjfpSJCoQX8z6x0Uar4AkhszxnLEqCrfd+iQm
         xj4kpRuFascPemTApEABSFc6N+AceSVOesi6UBKWhvWuAha5V7khGPFXBPjNvTqhOgNs
         Kj57CtDQ4sslvpuRcZJJSBq+LKaAmL80SY0+kJlmXSS/QL+ZTSDuo+NPmHNVtIkPTyhp
         40ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=tLPif5IZVtf2238BGbc0Lk5Ah2P//dhT4MZLzRLGmkQ=;
        b=a3AFZZSgMAZVFKcgyKEmup3Ob722legx2LBhc10ae2lpF3YhdfgFeJyozX1WwoSD0/
         YK8xjAqk+T8TKrcVB0lGXufIxrQv0hVMpYjZrayOS53wOYh22BW6+Hx7vdI4g2jGK2lb
         wPosuGBkiFl+tQkZW0M3rciw8BYIdAhR2LN295HWZYHcm06BzuuWK49mjrXBIEHhv6MW
         kh9DeEU1+29HB6IgIZpbdRfrqdKNWj6zA5g5Dnkcd3OycPX3hTUbX97Jus600cDWp6yp
         QCbaSYXMVKtDaU6iqNWfFH7SGhXG9rBW+wSMd8KQcRJqkeXfQrOrR6Ba6OVkXMfhYCkj
         dYjA==
X-Gm-Message-State: ACgBeo2s7hiYoKjfBdT7SydsQgEyvw3DTmvK6i3MqrHFA4EHl72vhOgU
        OcpcUYAk8yIwMcuRThwuLoZWLg==
X-Google-Smtp-Source: AA6agR5KOmBtOtcBo4+GkfZQ5vnZueq4nmbjS2Zijxcxyr+z3srfSjcRmkVSEI8cgqJ5pshLBqNOyA==
X-Received: by 2002:a63:231a:0:b0:429:fb01:3c5d with SMTP id j26-20020a63231a000000b00429fb013c5dmr18794629pgj.583.1661229561522;
        Mon, 22 Aug 2022 21:39:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709027fcf00b0016c1e006b63sm9278217plb.64.2022.08.22.21.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 21:39:21 -0700 (PDT)
Message-ID: <630459f9.170a0220.7d44c.1158@mx.google.com>
Date:   Mon, 22 Aug 2022 21:39:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.0-rc1-6-g977346c02019
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.0-rc1-6-g977346c02019)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.0-rc1-6-g977=
346c02019)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
0-rc1-6-g977346c02019/

Tree: pm
Branch: testing
Git Describe: v6.0-rc1-6-g977346c02019
Git Commit: 977346c0201990e55abf89a202849e71ba88c6c8
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
