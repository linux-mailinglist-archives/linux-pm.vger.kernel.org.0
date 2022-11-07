Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2295761FBA3
	for <lists+linux-pm@lfdr.de>; Mon,  7 Nov 2022 18:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiKGRju (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Nov 2022 12:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiKGRjt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2022 12:39:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162941A383
        for <linux-pm@vger.kernel.org>; Mon,  7 Nov 2022 09:39:48 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so11001913pji.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Nov 2022 09:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8auklnNafru0DFKwyfbFzu2Ulp12T06u4WCPID5Xfyo=;
        b=TJOGRYS9JM6vP2NT6evWUfrdXudwV84+RCTxsGWriLxozBnA0wRr9lPdT3+4itOaoz
         WsSRqqbMokNyi6vEJJSEeJJMDn10xQuYXx+o4AkIHzsmcFF7h4pl5AXh+MmcV0zBE7RN
         zXnvTQRn7gD+n2B2DON0iyU5J2VTJsXaOEQe+S60qpH1GV5RyTLhG+x6UNJyIyjVo2RO
         sLcyQu80MdA6k42SW+ZAhnHHWm9wSTXTVBv3wO4YIsMXNj8OyqIMnF3YFzw85eP/Gynv
         ZdzghttFOlhkkp5W8o4pZpzMsESoRSTvgK1H2sloQefoiD62R/UZ5XxSeu9IF87UySRL
         hFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8auklnNafru0DFKwyfbFzu2Ulp12T06u4WCPID5Xfyo=;
        b=jYUfpixTpuetYF3SxVftX2sjluqaAXnvI0AEIFlGFa01b5g7o9gedKyiIlKBe/GIxs
         OpX1ekOGhhxBsp0CeNPW2+I6OQG5uAsK655kDT70wvVYxE8citppt8c6jHbuv7epuPsO
         /ka9/1GrSjyepOZCQuHlw0IqFrwJPpGvc4C7dViraeG6m4y72VzzCMc5UuIcj06knzW9
         78ESBe3+NLtjfhxLV974rIs9I0vFqnfrjQz2lfJShINN+IPI+1V821e3Fw8d76QAgF+1
         snejx7GdTkAwPNGWsHuQIM00F2UcS0CfYZTSMdtCuK1j+p+ps8deI8jur+Mh7YTYEzrN
         EoNg==
X-Gm-Message-State: ACrzQf1dwCQc+4iR8sQK0ic/K4CKkWaTYW4sn+vCQ4RJozlXxCu25ysA
        GbW+2FmqtwKvOKvvdKHkI+HB6kVfCvip7w==
X-Google-Smtp-Source: AMsMyM6idxQ8M87fBMV6EiA43Sh2fnVTPWSCT/RsUpv6i0J0o7Mdv0ZnUmWVCqkhNqE30of36MIdaw==
X-Received: by 2002:a17:902:f7d4:b0:188:505b:529 with SMTP id h20-20020a170902f7d400b00188505b0529mr26187779plw.173.1667842787616;
        Mon, 07 Nov 2022 09:39:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b00172fad607b3sm5257108plh.207.2022.11.07.09.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:39:47 -0800 (PST)
Message-ID: <636942e3.170a0220.70a56.7bec@mx.google.com>
Date:   Mon, 07 Nov 2022 09:39:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.1-rc4-46-gef614051a953
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc4-46-gef614051a953)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc4-46-gef=
614051a953)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc4-46-gef614051a953/

Tree: pm
Branch: testing
Git Describe: v6.1-rc4-46-gef614051a953
Git Commit: ef614051a953a2de0c3b962e6baf3637c5a9d63a
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
