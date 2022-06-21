Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA6C5528DE
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jun 2022 03:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbiFUBEW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jun 2022 21:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbiFUBEV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 21:04:21 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9CD12D32
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 18:04:20 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i64so11651342pfc.8
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 18:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=MRGo7zt71/hKq28pWtzbOjxkmCg5+znm/YHXNNGmYkE=;
        b=sFfmrQezCOqGoADN28e9lxegjlqAIfEhT1vSmRFMSoQP5PCTo4CROHc6+ttp9BJcpF
         D0l87PhDsid/ARZ01b2U4U4mdXNPiq0x2gO+FRog34Y2y9p4nBrQZYZMTLIlWQzMy9cq
         ZxB7Ot6f6TlpFykAU9g7i9n2TU/esceQacnwTYZl3Ih/Jh5c8IT5teJWX1oEUPTHHK5V
         Per3x4jVMUPUQLCkZ3ucM+GzWX7tJk/7Gp4mPN76oWMO9Xg697AToJSgwCYhHKPcsJ0w
         hsr+9dz0GH7Yls7RXpILfRNbHiVlsZx5LqRd1y8IyiOH5sCqviyMtXmVTa6IH1t29obM
         jRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=MRGo7zt71/hKq28pWtzbOjxkmCg5+znm/YHXNNGmYkE=;
        b=eF4gUcSXmQ9LIpYbwRN28bFklt5lt2MKoBSBuSE69rEvqEIY59tm6jINQlKJn+NBGp
         +bfe6aH1RH2C2QX+yQ33F6nsKVhyH05a3hQVWGqBvFPg43qnjEUEyb+9NkmKp1MqqGK5
         4Uhx8YtXJ11eX0X3RSQcafxw34MdBxeSAFSJw7yngmQtpyaX/z06Icn1dvAqbPDUlezV
         HHBgrvrWr1xqFfwv66IwSXgYlNT7ZxDQyuYlAbQfp2DEtV+n8IlaRib9se7/N2u/kX5I
         xf/AVhSOjNcpmP29pgWwtj318fEcvXYcXLwNN4+UaANCQDv1FPVTaio5rU4+dnT01f1s
         1owA==
X-Gm-Message-State: AJIora+rWgCSYXtcTST1EfdKXMXwQrNl1zTNX707/L0Hsmfb7sgpmCQV
        MwS/uoRP0p+7OgxnNCkkJBcs8w==
X-Google-Smtp-Source: AGRyM1t9bBabb3xBOd2y9KB1qGAshyjHmtOpm3S7I35RMQQ7Ac7DCp3WIx+pTx4HzX1/ETGA9s3oHQ==
X-Received: by 2002:a63:3848:0:b0:40c:8ad3:d170 with SMTP id h8-20020a633848000000b0040c8ad3d170mr12031088pgn.175.1655773460134;
        Mon, 20 Jun 2022 18:04:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f4-20020a056a00228400b0051be2ae1fb5sm9901260pfe.61.2022.06.20.18.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 18:04:19 -0700 (PDT)
Message-ID: <62b11913.1c69fb81.3b17a.ddea@mx.google.com>
Date:   Mon, 20 Jun 2022 18:04:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v5.19-rc3-9-g4abf3e80fc980
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.19-rc3-9-g4abf3e80fc980)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.19-rc3-9-g4ab=
f3e80fc980)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
19-rc3-9-g4abf3e80fc980/

Tree: pm
Branch: testing
Git Describe: v5.19-rc3-9-g4abf3e80fc980
Git Commit: 4abf3e80fc9800c4a666e3167d102c34050a1615
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
