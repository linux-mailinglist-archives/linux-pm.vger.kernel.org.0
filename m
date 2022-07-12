Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2ED571BEF
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jul 2022 16:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiGLOGP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jul 2022 10:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiGLOGK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2022 10:06:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C0827154
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 07:06:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g126so7577450pfb.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 07:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=6gh4QUvDsd0DsxRF/OcAKaDDHpmaIQsoMZ/l7RrbP5I=;
        b=7d7JrX67ftxrriezRcg70hH/ZQ5P0hEB+812jm8NzWSmktl8XiiitLKURON9/vFyQY
         fpzefwR9o8FdySFXYmaK2e20i15JfaNS9tbr7TmbfybW4F9Ug6c/2LV6OFj2Q1B6JnZN
         Vzp2Ejdeu2AXu7VWiFSpknx400zewsCQ/j99sIChd5BcmutRQpVUUA3tMs3G1QQzGDWM
         AX6TkhzFBqiISWkzrknd9mS1zfwD1pLAUnj+SKfgoVEw96zRH5XAEucDUK3JPVw566tb
         os5U6ge3099r1v8Y9jYEjbJTUNFBpQTYE9tUJFTu9SnJeJgW7Lto/lhyFcVixubHunP9
         relQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=6gh4QUvDsd0DsxRF/OcAKaDDHpmaIQsoMZ/l7RrbP5I=;
        b=gsfzpvctFSt815Mc1qENnV6q4Wbqv4g/JIWSWh2C47pQAoHoCu5xg0zEFgklrIPJC1
         k/Li1AQWrbJjdFO8ezC8FAl7Ll2M5fN7CCL3LRrJiFUbS0GNDK3DyOTxbPzwcqwlOhr8
         8s3NqMkSTAPwF947oiEvipAy+vD3+C5itcBni+QPOX3MN2DBBlpsNwL3trbPn0hUpbRz
         RqKpQ93hrm3icDVXgL+16xAlCl9pBBIDzdva1yBMUyVJIFJXvfRsh5idGZ43vHv7zb8y
         6NUeskt4o6GNXFD2bUXTDEQLNhVaEMTmOUlxOV/UnLgqyjJ7dmemdngyZQTH9Vl7eE1r
         HRlA==
X-Gm-Message-State: AJIora/kZzTMqFvfPDMyY0QtkmFNQGSgp3afk/7qeAJdpKISlZB4y2tp
        6jeAeGhdZElNuX4ZHSt0OyJws4KJ+u2fnKO6
X-Google-Smtp-Source: AGRyM1vnUhYPHPLedR2lEwN3jOrWhNa9AePIQCybaiTic+CdhP5DQozYB+96QN9qzVZIC8KiWK5aWg==
X-Received: by 2002:a63:314a:0:b0:412:b42c:693d with SMTP id x71-20020a63314a000000b00412b42c693dmr20327654pgx.20.1657634769322;
        Tue, 12 Jul 2022 07:06:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902ec8900b001636d95fe59sm6889929plg.172.2022.07.12.07.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:06:09 -0700 (PDT)
Message-ID: <62cd7fd1.1c69fb81.74214.9cc2@mx.google.com>
Date:   Tue, 12 Jul 2022 07:06:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc6-53-ge71c5921cc50
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc6-53-ge71c5921cc50)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc6-53-ge7=
1c5921cc50)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc6-53-ge71c5921cc50/

Tree: pm
Branch: testing
Git Describe: v5.19-rc6-53-ge71c5921cc50
Git Commit: e71c5921cc5005d866e7acd0b501faff1f548897
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
