Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29DC4B7587
	for <lists+linux-pm@lfdr.de>; Tue, 15 Feb 2022 21:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiBOUIh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Feb 2022 15:08:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiBOUIh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Feb 2022 15:08:37 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B630BB0A79
        for <linux-pm@vger.kernel.org>; Tue, 15 Feb 2022 12:08:26 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso200191pjl.4
        for <linux-pm@vger.kernel.org>; Tue, 15 Feb 2022 12:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=HKP+SP12GZvjH5VwCUKOYe9BFReuexX9EPQuM6gBJZ4=;
        b=M/aDw4/ZY/g2D6doWqAGLfmcbHZdndgBtm6H5cfPQVMLe2bLLwYXwipEW/3WS3nbz5
         UNG0c6fvGFHIagouMlKVluT+mPADisrM8bnjWn08touQ/b/942J93THkGng91uPfvUnR
         pS2O3Nitd36Jfpc7qXXiRQFu/RZLkT/ssld5ujdJFnECvHA9d49mJdYz4qCcHjZjiBo1
         t7Yo45Y0fmsRuunC+uI5VjZ1sduBOka46q6umR7/jF13Nz7e48d5uKr8HJyekEJbD071
         zGJ+byDi1oYojnh/lg890vx7bZcoLHJigLXbrXwHH7dcs5RPznY0k6gwpYQkh7d2tgwB
         xMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=HKP+SP12GZvjH5VwCUKOYe9BFReuexX9EPQuM6gBJZ4=;
        b=hDK42NXD7lw1mZjNiaY7vv3CZZ3q11Z95K69aIPA0cDsCMvM3Crm4ISTL0Vfob8bCo
         RNt1Chcn1u52J7cXlgppwTFaXOVyatfUJoZsiW3cMIg5cfT4OTByg40f3pIzjONAPRZP
         XSYMxWo+RviXEBfB0XSgxYC3sb/XGVF6NhM5GwkWMpwhxCDefc0qt0gA4NJMBIMfrnV5
         XxrhGUJE6InM6LZTuaA5xpYkU3Hgjkuu3xwOf/OWIVFVfAU9amjkZb4UYYOjTfYCnQhT
         1GsLzjjbmAuHMcCywUReJukrqFYPoV+vnjL7iKFKMYu9I/yjZn0pLgDcuwK9rC3P1mPw
         LaUg==
X-Gm-Message-State: AOAM532nVaIfCD12BVbSOp6ea4u6PR53+H/WVWFYSni5T4NVBLsOTpSr
        ugomGwwOAgj3JWyuvbFqivuVLQ==
X-Google-Smtp-Source: ABdhPJynAWFO+4ZxAJw0eO8ULMmjTF+3bCgVPv4Ojqy/PjdykXbxkdhWE0BAjcc9959Lg6BhF6FWYQ==
X-Received: by 2002:a17:902:dad0:: with SMTP id q16mr376865plx.41.1644955706271;
        Tue, 15 Feb 2022 12:08:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z13sm42234197pfj.23.2022.02.15.12.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 12:08:25 -0800 (PST)
Message-ID: <620c0839.1c69fb81.73451.802d@mx.google.com>
Date:   Tue, 15 Feb 2022 12:08:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc4-49-gbe8b582111d6
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc4-49-gbe8b582111d6)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc4-49-gbe=
8b582111d6)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc4-49-gbe8b582111d6/

Tree: pm
Branch: testing
Git Describe: v5.17-rc4-49-gbe8b582111d6
Git Commit: be8b582111d67263006ded4f1b88f9ff28bea49e
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
