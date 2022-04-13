Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E33B4FFC45
	for <lists+linux-pm@lfdr.de>; Wed, 13 Apr 2022 19:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbiDMRXK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Apr 2022 13:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbiDMRXJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2022 13:23:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C012062BE5
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 10:20:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c23so2558871plo.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8ADwkKjxDJozF17IqN9N4HQa8Gjbxx1i43g6WbYLDow=;
        b=sLADV1iyZOPR98VR4mcmIcD9uBHZPPZ5qoYf2d30VRvppdRtNRDmDm9lgsaaq8SMwD
         NxZHfJjmEMt9+Cp6nrMglSuYTblb9HV516VtUGdMrbV+gMcNl5M4SDhXJQID7UAVg+ql
         8nRc6yBKkLCxCmG4LYb29Qr2pLmAPxfIBpO5YWmD5MXy+VQ72tOBVxoLm5IDxcvE/tQx
         J4AFGTjBsqW4zImeuJczRkIo4K3GoWWU9w2uT65CFjYkteeecZfAv5b+Dk5RFDZYmyR8
         jUAOdQMLwF+uK9CKQ4tsmrnbkHZlE3nFEa6WS4K1Z+BIQPH23IAmO6XL9zkLJmq6rxLx
         7Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8ADwkKjxDJozF17IqN9N4HQa8Gjbxx1i43g6WbYLDow=;
        b=PKj1YwGZYutJNQwwPR98TvpCCqEWHth5kj5HDNZwPA4CgRVfpnxVZVYXi6Om4xpt6J
         MjMtg3TLhvVZ2JNL07UKi30yAkEcOCS77s8nKCsTc7I/Ir/MdL1cCcWZsLZQvjY1HiI0
         cLCmednH62Jj7vSvfMuHN9Lf7qgUPnrhScp9/K8ZUFZr3yhOpBOFY5RshlqpXE37Pi8g
         wS/KTcCTpCEzOzaL7Cl+iOQPl2SYchn/raYf6ieF4qf06DlmbYhIJjpNkEzG4ncHZL8W
         L7RhQaW21nE06X57Os6WyIcbW0lpESSFRQkS4/bOF/ZNjK6njlYQl+miuZTTcGbYn5hL
         zc7Q==
X-Gm-Message-State: AOAM5339/QFwMorJ9X9kb6xgcj0Na2tS4329er/L9F0pBILyBEqyZbF7
        kkt52zeDHk1WPIX2Uzzq6sbCEQ==
X-Google-Smtp-Source: ABdhPJzbAwyD4e40yOhdZ2j3/AKvmtmy3iS5YKeEZHDMy80DD5PZiyERJb1gGLUAuHaIlfrmEz3Jsg==
X-Received: by 2002:a17:903:41c5:b0:158:6bde:1d8b with SMTP id u5-20020a17090341c500b001586bde1d8bmr15025877ple.74.1649870447257;
        Wed, 13 Apr 2022 10:20:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bm27-20020a656e9b000000b0039e5d327f78sm62116pgb.44.2022.04.13.10.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 10:20:46 -0700 (PDT)
Message-ID: <6257066e.1c69fb81.52621.039f@mx.google.com>
Date:   Wed, 13 Apr 2022 10:20:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.18-rc2-13-g781d19cfe317e
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.18-rc2-13-g781d19cfe317e)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.18-rc2-13-g78=
1d19cfe317e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
18-rc2-13-g781d19cfe317e/

Tree: pm
Branch: testing
Git Describe: v5.18-rc2-13-g781d19cfe317e
Git Commit: 781d19cfe317ed1ef69f192771ea9a714dd75289
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
