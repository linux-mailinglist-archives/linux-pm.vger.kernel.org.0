Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DF355EAD4
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 19:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiF1RSh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jun 2022 13:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiF1RSG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2022 13:18:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE1B62C7
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 10:18:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m14-20020a17090a668e00b001ee6ece8368so7341851pjj.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 10:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=P6rQ7N4yzqjP8sqJykiKiUTvRoBQSYMiSlaiLKhJb9Y=;
        b=nJAYFMP1p0Z5hT4D2cmhdmRanaayb6fIuDMm9YCxzSqN7c+/a/6HEECcmXX0HgQ9xh
         DvpmG9kvh5Lc0a5XyJ1kheT+NGKfohQR0n2IRPNNq6+xNyjNUkfUjkbHDx8u4ON7t1fU
         SmzeIt+EQHAVtEGALyHptW6xfBZUz9+KtAB2o0cq6WbJxZnGdoCA8IVwPDI0yKmrvA4G
         itMZ+oRdiMpXS+vKUNV3Pmqy9UCWSk/pyhfgwF1E7XNZkZfvikVFSeALBxKSIjR2gZSB
         KhtHE5W8joxaaqq5Ky6TlLyuLrGpB05bmMY5KUvX0B+YFj5GcKVfog9S0ObZvCrYyhcq
         rKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=P6rQ7N4yzqjP8sqJykiKiUTvRoBQSYMiSlaiLKhJb9Y=;
        b=o0ScjoJMLjtS4JY9PMS65z/Opj1thUBxikS9pFajQXmZbi3x4/2WKuzwcIFjIv5ASp
         pnVfJrmG1yjkHFCIloz7zduJNyZDfIYJKyvDzMe9y+ykazkQikBEhhA0r7An35jehKxo
         hWMxM105ydWLmfXNSZQY+F7es2C/l0Kw0cH8zAj679q1iS/kH7xWgF5EuJuE8isFTWjV
         c/Nft97LGiHHws0MDQ/WrL9kkPJ9PnVwN6mZRaFuuDxoosJ/iZ3W9p3PBcmn8BJFKcs6
         zG8Iea7JEXf62PK1xHaHNIZ13nGN/SDNQHK0e0WwWqGgJEj4+DmjocrXk5nnWEWiF9Ki
         8dBQ==
X-Gm-Message-State: AJIora8yuJCqszoOOQ5KRL1va6rbv3psTL1SVJG4QimoHSYP26JRXUPP
        CXwpOPNZQjr9J46oEwmS9/fRZg==
X-Google-Smtp-Source: AGRyM1vIg7MwX/GprNpbwh2ujJoI18KBBXcHZX2jCLWXkORHmz/TVpCJOS7soJfongWU2NFxZaAt7w==
X-Received: by 2002:a17:903:44b:b0:16a:76b2:f458 with SMTP id iw11-20020a170903044b00b0016a76b2f458mr5995352plb.144.1656436685632;
        Tue, 28 Jun 2022 10:18:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902b78700b001641244d051sm9533075pls.257.2022.06.28.10.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:18:02 -0700 (PDT)
Message-ID: <62bb37ca.1c69fb81.d1928.d3e3@mx.google.com>
Date:   Tue, 28 Jun 2022 10:18:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc4-36-g4035647418c1
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 5 builds: 0 failed, 5 passed,
 1 warning (v5.19-rc4-36-g4035647418c1)
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

pm/testing build: 5 builds: 0 failed, 5 passed, 1 warning (v5.19-rc4-36-g40=
35647418c1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc4-36-g4035647418c1/

Tree: pm
Branch: testing
Git Describe: v5.19-rc4-36-g4035647418c1
Git Commit: 4035647418c1b31bcc12e6cfafc01f61f0c649ea
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 5 unique architectures

Warnings Detected:

arc:

arm:

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
haps_hs_smp_defconfig (arc, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0=
 section mismatches

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
