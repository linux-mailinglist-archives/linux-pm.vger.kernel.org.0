Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686F352DD3B
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbiESSzf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 14:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiESSzf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 14:55:35 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1EA5EDCF
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 11:55:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 31so5830617pgp.8
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Vcq7tyUgjjfj36Z7GAL4pyiZhPzRJuU5K1Deejv3s+c=;
        b=RpcDGn0zUuRRSzMHg/2vbH38olCzCTLs9CXXAABQO5PRI95DcHTmOPL2A7KA/EdyWP
         k3fVNWxzTgQOCvVf9rLlirWpxvWje5isWigtqnZ8jdkSvm7MimOPxJQKKfoi6BU1/TXL
         4fcwKQAMqnWPBoOFF8JdCgkoDleuQUayDCwPWLpdwXMoxIKf+ebgqkYm95AC4P373jSP
         KMsM5PXtyzxxOU/cu3/ccCQQwuAIN61kgLP3KNBX4Eg6igzvtKEKB5JdLLmmgNEho04l
         R97nDSUDSdI9kSS1UtWddFBuYa2b3Iut2MygZoy6eJ46fDFA6SqscYIarRLTwosxBYdB
         SGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Vcq7tyUgjjfj36Z7GAL4pyiZhPzRJuU5K1Deejv3s+c=;
        b=Pfo0KXKBnur2CRj7jzvyXCICJVRlOcIOTBXgHaesO2aCNw0qhwivCCefKActGT8mx7
         FD5fkC8Y9zl81TRGkYdmNLRBxgUUhCk6DIMKpOkh/Y+Et8qS3xAcH1hqmTVpdigLO+RY
         VOujiVpn4ryT0FkLtxs32AyAFutCTf7qON3MQy+12idpNDa9Ee3ji+mXlZc3P6PzrZdr
         KSXM3RWEoYu52hR7nR1hlnJPMhTkvCiUExmNGE2bGXVtJqu1t8daOG5qVy+jd4KHbL6t
         LyKQ5QAKXwInxDS6TWtluWlwuFu/oo0cZynotXiMCGhvsVo8vqUHdI90rXcTQ/7CqJch
         idCw==
X-Gm-Message-State: AOAM531RGos4JrGukcjrPIMYubbf0s76iDBCUeoijmSJyZoppXrBDIec
        PmgxnrD6Q93FH+Rb8xUE0/vzSVJX9tQAQHJbE0s=
X-Google-Smtp-Source: ABdhPJyCAxXsEe3KapjAs/t2PrP/+Xk/1JiDGoheTaAC9W0DnaWcfAPLP8UIViEHXVW0d58/dNtK+w==
X-Received: by 2002:a05:6a00:ad2:b0:4f1:2734:a3d9 with SMTP id c18-20020a056a000ad200b004f12734a3d9mr6029772pfl.61.1652986533384;
        Thu, 19 May 2022 11:55:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q22-20020a17090aa01600b001cd4989ff5esm139132pjp.37.2022.05.19.11.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:55:32 -0700 (PDT)
Message-ID: <628692a4.1c69fb81.1c36f.085b@mx.google.com>
Date:   Thu, 19 May 2022 11:55:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.18-rc7-185-g0f360c018be3
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.18-rc7-185-g0f360c018be3)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.18-rc7-185-g0=
f360c018be3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
18-rc7-185-g0f360c018be3/

Tree: pm
Branch: testing
Git Describe: v5.18-rc7-185-g0f360c018be3
Git Commit: 0f360c018be30741d75f746467daf173c05ef1f7
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
