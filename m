Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2324B19E1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Feb 2022 00:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345952AbiBJX4K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Feb 2022 18:56:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345909AbiBJX4K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Feb 2022 18:56:10 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6885F83
        for <linux-pm@vger.kernel.org>; Thu, 10 Feb 2022 15:56:09 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso10225054pjt.4
        for <linux-pm@vger.kernel.org>; Thu, 10 Feb 2022 15:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=JG0WRr0YvN4hexTQbhiLozOa7o9fEpUgnxkAuOALLgs=;
        b=MTUjKxVFpb6BzrvJc9t7DFpScjetA5/XYtTGtOd99lbS75wLWR/3V/5AkKMaCT7rfj
         om1BBIOzjwbLFy6Y3pPco1dCOQw9pnXN501S16S8qdBww63o0lb8JD2U6vUFy85wBC0w
         ZGZD1VK/gsvzfeLeZTZj2Nq9tlEQH9l9ncPwIC2QrZl4rKHcy19EkFHL6ipujDzh3DK3
         QDeF1r1stIGRh+dnXnSJD26DDl9Fa7NDrDkUsDGdmqCLDY0Y6CPkigVAifft5+DSAFh3
         iKolsRIzp5QBTDLMeSPUD7rQoy428TzFlkouyQY2n0OzQianEg1NScjKSZpBjRnMiQD8
         tLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=JG0WRr0YvN4hexTQbhiLozOa7o9fEpUgnxkAuOALLgs=;
        b=4+6K0mbZkffOduriGB6LLeC2nF5n0dXla/1em2Xlgu1tgQaZBbNaGxORqQ45uCrJ+h
         cZ4+GUh73qK5e3VFCUi03433J0DTNaWSeLD/dtt/B0LS+QK+bwjFAq98uDZJA0UPGsgl
         LY52PZrsk+s/l7FXT6MYZNtmYmycoBlbqInk5sVG1pbBaDDuXA1E9dqiZ/YnZTjUFUZX
         QzVps+JtjX7eXABfYnNmkoSCx86F13ydhTKxouRBEWfynFAymjbRZVzDk4NEnIFymfWQ
         ESuZ3q5+7ZveMieHwVrJMWlsAYlVqxpXo1SqDDp+MArhGFJB2PEFaSjM6TuNh+J5UgpO
         cnRA==
X-Gm-Message-State: AOAM533gx7tzvOhiS3HikrJf2j9FOqEo61fEIDS0ktiBu+V6wN6EX98+
        pS1I/NZdrfpcyiVThimD4GAJHy/E3XwRr1BcaFg=
X-Google-Smtp-Source: ABdhPJy/AihB1JmvU9VVElSYVAW5wYIqXbdwdtNAYzMeWn2MXYiVmzax7PScMdR0mb1Jcu8qVTmikg==
X-Received: by 2002:a17:903:2310:: with SMTP id d16mr9753798plh.39.1644537369248;
        Thu, 10 Feb 2022 15:56:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id lw10sm3713361pjb.28.2022.02.10.15.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:56:08 -0800 (PST)
Message-ID: <6205a618.1c69fb81.cf897.8873@mx.google.com>
Date:   Thu, 10 Feb 2022 15:56:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc3-39-g9b044ca4ac33
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc3-39-g9b044ca4ac33)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc3-39-g9b=
044ca4ac33)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc3-39-g9b044ca4ac33/

Tree: pm
Branch: testing
Git Describe: v5.17-rc3-39-g9b044ca4ac33
Git Commit: 9b044ca4ac33454a5fdf1254867bde83228eedcc
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
