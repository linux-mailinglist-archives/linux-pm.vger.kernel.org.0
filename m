Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF86C5624AF
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 22:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiF3U6Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 16:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiF3U6Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 16:58:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B94217AAA
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 13:58:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 65so525482pfw.11
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=6HuV91LDAuu/cffdaq+/3YuWXqpRFJmhUkOOKlokfC4=;
        b=cm4fohvPp0TTL/zzJebEtI5pqdUfPRmpZmGGnYaOo1hlD7Tyq4IlieGfcV2ni5gE/z
         a3wSPlcDEud1YN+29EnNSQRriIQHV6UwhAlKCb1slkuOz44yhxZiktplNWnb2JjXJL/q
         YbkhIwW2EFgW8TbGwvLpR6USvKKReKm8ON/n2YcrOW/ksvuCyeyftFB98SwQyu3tqcQN
         pqynOPJGZWiEcoO2JAblr+ZF/EIzLsYkpa62aWkme3yFcgXpCXgVzR0dBq6q6D1/MCSq
         0YP30F26E0zWuAp908CLgmgAV6iNwjqmYxyYHC5eKC1YL2IvtTECoij8m5Rw69FQ92mX
         w+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=6HuV91LDAuu/cffdaq+/3YuWXqpRFJmhUkOOKlokfC4=;
        b=qD7H1aPoKcItlZMbXteKFm1QFNe4SvVJnubKW7W5cbPoJJfw0n+3YuA/lUD+iHteav
         Oj51EEnYIRqqMYdum2crn2Q68dXm9gHaDSp3HMrYQLFFHcPvR8mts3mSARulRWLuPtFF
         xQ4hgLJY46zWjtjzr5E29+9O5bWFr1XeTccnp5pyYSUS9Slo194b4KeCGNFW50BHRvI/
         EZ8Q0onxEP0LK5DaaBwzj11Li34yRx2KV78uQfBJlX6gsDCN2U1SxLVkLHDlTKqxsSf3
         vdCJtFpeLUzeZBHVcJGCUL5VI2veM4qG9982JSsjaC1RJoU3K9Ay6xwLNdj0pHntlMIj
         rObQ==
X-Gm-Message-State: AJIora97/bcq9a7W9CFDe1suR4Pt4+nvaY0scHFNpnaCUpSjl8/yJjIP
        ckYEMlR6kjdiWDwcjFHQnGj+oQ==
X-Google-Smtp-Source: AGRyM1s8JxePGTmjSt78kiFGpZ5hyuVv3pAg6btswcnBpKUhlcQKBDsyAyd+zSkSgj0H4yHzO8eRFQ==
X-Received: by 2002:a62:f846:0:b0:51c:17b2:60de with SMTP id c6-20020a62f846000000b0051c17b260demr17688421pfm.76.1656622702720;
        Thu, 30 Jun 2022 13:58:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z20-20020a17090abd9400b001ece55aec38sm4951996pjr.30.2022.06.30.13.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 13:58:22 -0700 (PDT)
Message-ID: <62be0e6e.1c69fb81.1cad7.7b62@mx.google.com>
Date:   Thu, 30 Jun 2022 13:58:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc4-63-g5a03ffb415cc
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc4-63-g5a03ffb415cc)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc4-63-g5a=
03ffb415cc)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc4-63-g5a03ffb415cc/

Tree: pm
Branch: testing
Git Describe: v5.19-rc4-63-g5a03ffb415cc
Git Commit: 5a03ffb415cc385a45feeacdb7fefba77519321f
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
