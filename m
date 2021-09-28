Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899DF41B1E5
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbhI1OSw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 10:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhI1OSw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Sep 2021 10:18:52 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7841C06161C
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 07:17:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s75so4825924pgs.5
        for <linux-pm@vger.kernel.org>; Tue, 28 Sep 2021 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=L+Ec6xPwpf765+2Y5GDEoovwvrMfYFq4Kod84AziMeY=;
        b=6dH5KS4f1asQicsTDBU8Z8eLqTOoymsSdVvUzXF1hqbsBsXJlVvd53JvSNqHUm4F0Z
         TiKoLx/y4wwe6SelGqfVLGVWIvhncXhD3qc6ckegFQX/4GvhB5Go4SUFeAFaVqRm0YJN
         WmpXGmR5PAFl7nlfTXnCGBDyoblxFyDmQdjw8/43EshJgaB1OnW8IpamKxUuaGJfPNag
         djEcpxbtt/QIOB8cB/ZqGmCpzVt4W+ikEQJgBe6D2TRqESsrHSdExLXgZfgyR6fsuD5F
         OFAyoflprPef23G3hst1pUVuAQPz65WajYGr/ND69tAVO170liJf9UDCNuMxxbNocJ/g
         G21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=L+Ec6xPwpf765+2Y5GDEoovwvrMfYFq4Kod84AziMeY=;
        b=uQCmvLzeD8NC9IpIPxO0NlN1ocv6Ngam+AelTwzyYIrXq/ZbfFOBcX4PJf98LVBD4g
         JKrakoge7xSesbCtK9G4TtmZbkoHmCz8dKDRG5Gjwxu039Q11ergfk0087aUmVYHVuSh
         eJqzbrES7gW7M3kuq9j42R6xGZVrNdGAp+cGU/NyXyoMlZiS50mZfLPw2VcxsSILHyGW
         cmIZdmW4VqSvm6xkwDFHrkilj4gzWg3sYO0ptR8uZWYuTzcYJSECv1OMhBHTCBIraEyc
         ddaDcYsxU3CNvRcei0ISljCx7fUsXocakZaVokT3ejdUROUmvtWGPCaIJ6iGoM5E0Zab
         QRjQ==
X-Gm-Message-State: AOAM530s1w8LLB3RkznbVXSH2sB0F//sDzoJ/bRyMxroxa1ISYAuqg3J
        i98e82/Wifcdbec/ZHMwkM8VuSVV7bi3uxDj
X-Google-Smtp-Source: ABdhPJyRHHOoTFYxPT9LkU68nCSksCTT5xBzC71u+Ai4qMuNV5XJNf0fNmFxIlSGu7WG0DsCLSBgPw==
X-Received: by 2002:a62:8801:0:b0:43e:390:295f with SMTP id l1-20020a628801000000b0043e0390295fmr5606591pfd.57.1632838632394;
        Tue, 28 Sep 2021 07:17:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i27sm20704559pfq.184.2021.09.28.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 07:17:12 -0700 (PDT)
Message-ID: <615323e8.1c69fb81.16187.2e51@mx.google.com>
Date:   Tue, 28 Sep 2021 07:17:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.15-rc3-18-g7c86bb8dfc1b
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.15-rc3-18-g7c86bb8dfc1b)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.15-rc3-18-g7c=
86bb8dfc1b)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
15-rc3-18-g7c86bb8dfc1b/

Tree: pm
Branch: testing
Git Describe: v5.15-rc3-18-g7c86bb8dfc1b
Git Commit: 7c86bb8dfc1ba1e8f6fef352555cf21a37ea2bc3
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-8): 1 warning

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
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 1 warning, 0 secti=
on mismatches

Warnings:
    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_device_reg=
): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expected "=
0,0"

---------------------------------------------------------------------------=
-----
defconfig (riscv, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section mi=
smatches

---------------------------------------------------------------------------=
-----
haps_hs_smp_defconfig (arc, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 =
section mismatches

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sectio=
n mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
