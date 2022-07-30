Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A5258578A
	for <lists+linux-pm@lfdr.de>; Sat, 30 Jul 2022 02:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiG3AXo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Jul 2022 20:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiG3AXo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jul 2022 20:23:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C8F275C2
        for <linux-pm@vger.kernel.org>; Fri, 29 Jul 2022 17:23:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p1so5884970plr.11
        for <linux-pm@vger.kernel.org>; Fri, 29 Jul 2022 17:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=keGYl8dO4pT8+19W8D5f5HMmyaoYEfBCBPlRHXFxc0U=;
        b=gka2t1/Nbil1MdOg09+dBZoLCz0nvj9Cey558debRVLsAmDVTxidHlgK0tqgbFJrGi
         EN5xzduBuw4JRYIY/oUas7bfCWBRODEeVeiCfkaPgoGA7rPnh0z1OjHMgu1toiY730FE
         DZCh107ok2FC4hyxexzbkh5oiNuHOjtTBlCs7cVz5EOTHp7oLMKFLgBpcbtkYLgyEZyj
         w1YVkQk5bnrmHBrkrLy+UIigTtUElB1VJ27OOMBVfn9wGU9gA1y8lie5GGwDDBgCr/BH
         gH1NH0bjIw3599dyyTO+c0ge6s/qGt31jFKD4incwOOWK7ddtDEV36h2v7w8HYN8LDaZ
         HNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=keGYl8dO4pT8+19W8D5f5HMmyaoYEfBCBPlRHXFxc0U=;
        b=IO4x1Cb9ngJnx3PHr18sy7Hw2LOFcJhRRpnzl5qc5+8z+oQRFrOU1MRrDIKtGvAiMB
         0pj5J4QOZkAoM7WWc/TyTKj0lmA/vvv/n7hSSdP1w6GkmGl6hZtJj0uqLP3FzMr5fDV0
         1iZ076Fvg22rPkObiUjyX+hfkrQQzMOHSi+zra7MJis0D82/V9882hpdi6ghl7UdbtPc
         C8u8+KJ1ImhtNY7nWasjTwiLl/IM5DOEgXrSBGtk+vgt+NExWORPzGkhXRKW3hsD9l02
         qfIN2a3qL7PrwBT7+goyXi1WqSmzMkWKYQ47J5rNJfc+zYGLUu9xNMBgcLa1ds9x4ciM
         72ug==
X-Gm-Message-State: ACgBeo378TQHxxKL9vEblWGEyvGY34o/zopUMXo2LWhOL9CbiCgqCtTQ
        W3JwkzZg3Ng4cwsSR8XRFHmtYg==
X-Google-Smtp-Source: AA6agR6clYbmUXqZao5GyBU2O6Iyl2+rkkTJzZ5uDJEYzP9gXlXvwLa3lwNbW188flIOMLC77k38bQ==
X-Received: by 2002:a17:902:bc49:b0:16d:ac99:f96f with SMTP id t9-20020a170902bc4900b0016dac99f96fmr6245951plz.130.1659140619530;
        Fri, 29 Jul 2022 17:23:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n13-20020a63ee4d000000b0041a390f276esm3102620pgk.40.2022.07.29.17.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 17:23:39 -0700 (PDT)
Message-ID: <62e47a0b.630a0220.787bc.491c@mx.google.com>
Date:   Fri, 29 Jul 2022 17:23:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: pm-5.19-rc9-140-g4031614b39959
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (pm-5.19-rc9-140-g4031614b39959)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (pm-5.19-rc9-140-=
g4031614b39959)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
5.19-rc9-140-g4031614b39959/

Tree: pm
Branch: testing
Git Describe: pm-5.19-rc9-140-g4031614b39959
Git Commit: 4031614b3995978278db2c905fd13d5c64e060a3
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
