Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41184D1E3E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 18:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348636AbiCHRNT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 12:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348386AbiCHRNT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 12:13:19 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B69352E46
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 09:12:22 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id e13so17662875plh.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Mar 2022 09:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Ts2NsLw5sBXzLdDRu8UJXXgXcMQQ4I0kvuWW3GaWefE=;
        b=ioSixTpnfjPaduAxBwJCHbXwf2TcIgPuzr7twp399fwcWibkyCwSbcR6UzD4odPM36
         DdH6UIMlsl0IfQC0qKryZg38Ri6i2dDP1krwtDJR6spo1mzIdHFX1xqnJlB2VhxxAph1
         ibLTLJH/wJCANDluQs+eufYWGr4g69RB0e8aL4+8Ai5AAsC2FPIiCX2QBnEBDeG5Nz0p
         Rbr8etf73BAUZYIejNTfOYxERSjM+/BSbu+6BPwsH3N430sJcdY7BkP2UP+fSI4QxZcA
         fUxGXV3CQzO19iuRvWN93ZMQEi+vbZ972P4txp4xAuWmDgj2VxBNW2jEDdmPLMCb58Yp
         2NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Ts2NsLw5sBXzLdDRu8UJXXgXcMQQ4I0kvuWW3GaWefE=;
        b=o/bk9HACla2R/G0zaHxr9FDdLQiCX7tRaS3tbNs8xjB4oJsU96xPbPoJHUBVURHHG/
         RZYuxKYIdHV2h+oRjtxpjxzldJhi4rno1X9EFdFwuJtsS3aexh+bGLXDbkRRfIkNt2R8
         SIjtmoqxn17AzG87VXkBR/PyFTUDEYtVNxelqbWYvNcuxB0g9EBjZyyqaX3XHJuCfAmg
         dKQ5Z1BAcavDnhHAZ2BktmqcPYiayShpB9I6cumB7awvIQMLqpX3u3wYk3G/oeBNgHOg
         wKcIXWrtHTC+oDUwQnlGMrWC9XSZKYlxtzn2mcLXOMuGhzef6YpoGb6MMkGf9IjtMGSt
         2TJw==
X-Gm-Message-State: AOAM530cnJ7cMUDfhqVk5y/p3rOhK8oN0rylW/w+BLiTYrI8hMpMFM5L
        /0eRb0Lh9wuN0B9z6uqv8FYIm+jEC2FYXjD3z94=
X-Google-Smtp-Source: ABdhPJxq7Qb6I5dRrdqTP76WqqttNIHBrKyPYF5bJCNUH2rRFM1MzRfXegYlpBVlmSTHV4eLLM4c8w==
X-Received: by 2002:a17:902:714d:b0:151:3f2d:8b26 with SMTP id u13-20020a170902714d00b001513f2d8b26mr18595247plm.70.1646759541805;
        Tue, 08 Mar 2022 09:12:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a158800b001bf2cec0377sm4616975pja.3.2022.03.08.09.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:12:21 -0800 (PST)
Message-ID: <62278e75.1c69fb81.ca006.8a6d@mx.google.com>
Date:   Tue, 08 Mar 2022 09:12:21 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc7-126-g8a43cf068643
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc7-126-g8a43cf068643)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc7-126-g8=
a43cf068643)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc7-126-g8a43cf068643/

Tree: pm
Branch: testing
Git Describe: v5.17-rc7-126-g8a43cf068643
Git Commit: 8a43cf06864363f43917b046ab689fab61fd44f2
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

x86_64:


Warnings summary:

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
