Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60D04D3A50
	for <lists+linux-pm@lfdr.de>; Wed,  9 Mar 2022 20:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiCIT0Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Mar 2022 14:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiCIT0X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2022 14:26:23 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63E0E4A
        for <linux-pm@vger.kernel.org>; Wed,  9 Mar 2022 11:25:24 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id g1so3168842pfv.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Mar 2022 11:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=cPpcboxvTQI+9B95oWxtMEmMfku6NbnlcBgxPyKaJ9c=;
        b=CDEYHdmi+1S2LOi8gSdmgsn/i1Ll6qRzeITTDLA7eEDajK+y5Jj4WTTYObzZkY6tDc
         EWsfai0WYf5gjvdPhGl7JH3amh11rfkSrCnxdvZg74fhomPA0TBMzw6zy69thnfyumRw
         EdXoLA1q8UuT10BcltXe0nZO5Ceduyd69EuEcp1WhfEfi2ByOyom2t/Vr+GkmYsCwm0q
         ma+q6c3vWBcQyZRLDlG1rz0KlL8rEeIAvPWZqXBI1gYcaELM0bpjS5xoyUddTHMRmj5J
         aX1MiL9o1+HRxw6N03eAIZnJOLs0847Z6h4jgtUT+q6SEO98cumnGDn/HCCn6Zeqr+JZ
         Ng+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=cPpcboxvTQI+9B95oWxtMEmMfku6NbnlcBgxPyKaJ9c=;
        b=evb+hgqXHzauO83R2tNeRYeHiZC+HaTOI/AH3Td9NxEFIYmPbV2OrmlU9N2/emvr6g
         xbnE/tRMb/Z7wgrKG/yyfjgMXe91chE7iN9yLazczaEnAgZ3Zse2ZM4+z7Z1/uyPRSDt
         XUYJFWIXMVX3dCEnrTTHeIzZbrcTocR/Qq0bvISZePE8x5cQuM2rZtxYIBPz8EkXxbmq
         YH95/5AYboySr0TnVcevEPa80nTz5TpgnzYdnKMkbQ2pibS8CtxZ1uYN0XgKosWhPAbW
         aXfYaNMJgzi+opxYStErQO0v1qu8KrrJpTFKr0npLWA7Qpa3p9pzxzaN8VsHBJUdaH5I
         lEQA==
X-Gm-Message-State: AOAM531E88gdwcSkTQIOqlc66Wk2EQu+NYWZQx+FqvXhBekR7CzXCJ/y
        e+H21Td+dXYCtj+kFF1i1/TwuA==
X-Google-Smtp-Source: ABdhPJzRzbRRrgo4BKPRBdxmCQHtBwHXEyvI3RrT0uCNWXryNc4MH0PUrDk5sgGOqjE/+7gCZbXNpg==
X-Received: by 2002:a05:6a00:1a42:b0:4c9:f270:1f39 with SMTP id h2-20020a056a001a4200b004c9f2701f39mr1068059pfv.50.1646853924267;
        Wed, 09 Mar 2022 11:25:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q8-20020a056a00088800b004bca31c8e56sm4050579pfj.115.2022.03.09.11.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:25:23 -0800 (PST)
Message-ID: <6228ff23.1c69fb81.94e15.a1be@mx.google.com>
Date:   Wed, 09 Mar 2022 11:25:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.17-rc7-144-gcdd758e337cb
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.17-rc7-144-gcdd758e337cb)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc7-144-gc=
dd758e337cb)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
17-rc7-144-gcdd758e337cb/

Tree: pm
Branch: testing
Git Describe: v5.17-rc7-144-gcdd758e337cb
Git Commit: cdd758e337cbe7a5d889d428137e3bca054d82a1
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
