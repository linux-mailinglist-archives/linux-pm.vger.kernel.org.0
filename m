Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C23581CDD
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jul 2022 02:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiG0A4C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 20:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiG0A4C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 20:56:02 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6678E11A01
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 17:56:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bf13so14566446pgb.11
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 17:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ey7prdBXERmdD80QzyvhYsSLXCwrwCQGq6xbNu6iQ9c=;
        b=H/GHDYBe/MO1vUSiMZOJvLglocGL8Eb9KCYI0ynC4+7AQ4BnB1vHlVHpzezmwnFXWX
         wVCXpeXCNp+PgZkMLv8FOXRu3wWibrIJ0rsGfEG7MMRvMzwCaRMU7DPwy6zDrg2BPTzQ
         AyFxwsgSYF6ODiBCzsyFT8Oy4FtZwZRrX57d0N5rR44XPcO8hRENIuSzJ+FJGCE1y/bH
         vBzCyfXwkK/WRWft57W+DK916f1IXwBUlQxVsNc7y34ymCGst5x+UV9thKRb6ZmOiaEv
         GKbTEdVsOJxWovNjnlNxys/0BJHhmC08E81xEXgDHgjKcqPK0NU1oHnG8iqgndZ/BcU+
         6etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ey7prdBXERmdD80QzyvhYsSLXCwrwCQGq6xbNu6iQ9c=;
        b=3esqfB3whHus/4KBwVtwuZGTPGaVOWO0aEph555l4KTR5v8IBZXl7SetN/nwai56iw
         3PysXzdkRrMqyoovvoqVCZsHEF9UFuX1sCrgVMADWfy20CI84BP7N5Muh7qOFgUHIexz
         3PH7G+SA00Rx2htGiCJm8IzhFCkn8RT1oCiEGb6QtXLpap0e949diJmM06kU2NflEdqd
         3PA182xedL4aT4A458yeVgCnUFZiI8wCZuL9gyfX8zDoGKJMtTGAtZnxaBWIBIkufXAq
         Ufxqgl3CaUxjtz8A7CNMLrMpE7Hilsl/UTw/T1nwmqeYeDKmyFO/CQEjS9Wa2RiHZaJu
         gjbA==
X-Gm-Message-State: AJIora+WTbHOohsibXjJXJfe83KwtjM63xw4qTlo7ErGnXrXNAg6rDTT
        /V82nG5ADMVqejxpiG8UQccUdNYuxpT2U6tj
X-Google-Smtp-Source: AGRyM1uOEQrfwkqb3yXoLnCZIJeKO2UgeIDOKb8SYM2HTH4DrbWMpHkKDED6hI+KtYx5fZ/Ggus7Ag==
X-Received: by 2002:a63:1a4c:0:b0:416:1821:733d with SMTP id a12-20020a631a4c000000b004161821733dmr16484215pgm.444.1658883360884;
        Tue, 26 Jul 2022 17:56:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a410400b001f2e20edd14sm210531pjf.45.2022.07.26.17.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 17:56:00 -0700 (PDT)
Message-ID: <62e08d20.170a0220.22664.0846@mx.google.com>
Date:   Tue, 26 Jul 2022 17:56:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc8-85-g8cfc5f8d77b2
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc8-85-g8cfc5f8d77b2)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc8-85-g8c=
fc5f8d77b2)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc8-85-g8cfc5f8d77b2/

Tree: pm
Branch: testing
Git Describe: v5.19-rc8-85-g8cfc5f8d77b2
Git Commit: 8cfc5f8d77b21e9bd808b1ac3efc795f8afc635e
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
