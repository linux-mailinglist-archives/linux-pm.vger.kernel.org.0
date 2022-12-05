Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D35F642E06
	for <lists+linux-pm@lfdr.de>; Mon,  5 Dec 2022 17:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiLEQ4m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Dec 2022 11:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiLEQ4X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Dec 2022 11:56:23 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78025269
        for <linux-pm@vger.kernel.org>; Mon,  5 Dec 2022 08:55:52 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id n3so7701818pfq.10
        for <linux-pm@vger.kernel.org>; Mon, 05 Dec 2022 08:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XJb9PjPRptSUYSJAMuoGOcT1ULo4CRNzJqiA4G1Seuo=;
        b=B02amDI0uu9XZNlf7T4adJr4vzu6iheWLxhKALQ7zlTiGpEkQABPo+bNAlLFgvXZaA
         jarJFklIDpLvMwVSgBEKr1+Em31FY6PxesPQqP7jL1IkX08CHMazCHXmnMgpWR45zaYz
         FiK2GsBo0093bVX68Kxv0xvIEp2X768NvsllM+ut1OzBRpBFbtV2IEZaFvwJeJsft2uU
         kVPaZLB6+IQ8xEY9fJCSCcInXEtZNDNoYhTZM4RCkdDnhoT+5MqrzRKJ+WL91/QPb42w
         3RUg0VzSv2X/fYiTPEK2Y/xEJ2C9CYcBGFos4jnn95GriKADtLOQ+0A0iG2WiVvyi/Pa
         cLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJb9PjPRptSUYSJAMuoGOcT1ULo4CRNzJqiA4G1Seuo=;
        b=pzKXDjqkvwo4999QrrdoVIC01Dv2pLexQnu7r9qGPFHlTIcO8MLdGpHm1yCXrIqV5K
         EeC8vS2oYAsVavmu6ajqRnJD7c7vvBb9LkSZ95jqQ7CAvs49fhLij+i1EUvorRA1XgWK
         UlerCXZxcDvTrniJFoqX3sj+BqFTRo+E1ftPE8xJQ7+sppJQ5D8Xp5GBwv+YfqTBUCDg
         s9p3e1pL01KiSuqK0MYM00T9xu2eJAan1ogl/LNZYgrQ43Jg+FQY3LooP5Xc5ZaEuLs1
         A+77g4s68NNTPPYe1Noz0m+GNZEhTfUhux8rU3yOmTjT1kKnxuoCpuj9cpMEzbc3Wfnj
         sZnQ==
X-Gm-Message-State: ANoB5pl9/nYX/JUlrjo92nEBU9JtUoYxOYIJa2r7qQhedGRy/qETcD4L
        60l/bIIxxbSYq57ajzAm15TkRcdo9OME6Da8eCZ7LQ==
X-Google-Smtp-Source: AA0mqf6PxaE1b/BRYOr15RWVr8JpdAyyxWgviNgxZQRLWTCw98V5XY/TlkQfDJRx+rXrkEDdbSPveA==
X-Received: by 2002:a63:2001:0:b0:477:b0d0:bbee with SMTP id g1-20020a632001000000b00477b0d0bbeemr55666941pgg.51.1670259351893;
        Mon, 05 Dec 2022 08:55:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y69-20020a62ce48000000b00571bdf45888sm6567750pfg.154.2022.12.05.08.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:55:51 -0800 (PST)
Message-ID: <638e2297.620a0220.1455f.b12d@mx.google.com>
Date:   Mon, 05 Dec 2022 08:55:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc8-124-g280de4430124
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc8-124-g280de4430124)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc8-124-g2=
80de4430124)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc8-124-g280de4430124/

Tree: pm
Branch: testing
Git Describe: v6.1-rc8-124-g280de4430124
Git Commit: 280de4430124d84f1f90725311dfc49538ee1a19
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
