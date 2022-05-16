Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDD2528DD7
	for <lists+linux-pm@lfdr.de>; Mon, 16 May 2022 21:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbiEPTV0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 May 2022 15:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345352AbiEPTVZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 May 2022 15:21:25 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2145F7641
        for <linux-pm@vger.kernel.org>; Mon, 16 May 2022 12:21:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g184so15002191pgc.1
        for <linux-pm@vger.kernel.org>; Mon, 16 May 2022 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=IH9bOwJ+BbZrjkmCkcWB7QzSKchnSAnxAZ/b0wLpk8E=;
        b=FjJ0sZ/2UkLlIkW7c2J1DR7Df39E/bvJsYlDW5c3G9KEKEum7EZOaoMn8I3EDu1Wdj
         mfPGmgc+2OPfTzfQnjnrPb8f0dlNkTV+L6nRT73UVejsXZBgF4klEdnDPmoWicTKtj4C
         LRHHDYSPh9MhlxG7hBmBilfwISLxXoM+9515mdyvERdoTm8LxMlG4Ev0Sp8n8gse7IsJ
         Xc56CC//uJDgp2C8vcWMl+ZGrhuWH3oF9Jr4VmwTjS3jtogdkqwxMZqV5Hz70jyTPr38
         i3IIhenpQkf7DGSyUN2umrhgMjv88NSCljlfRIToulznp7UzN0aLWk6UHlZVdSnNT+JF
         JPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=IH9bOwJ+BbZrjkmCkcWB7QzSKchnSAnxAZ/b0wLpk8E=;
        b=cGtKIxaB9Xb/vfU47bGDGxaeUhVKJjIf5yatNtzLye2yYl2HUq3hvEsw19nkT4BM6S
         7keNZrsVuFLPrcTBcaTeqsuXYji7xQd5RP0WB9si/STyWq/6QVEjXVOP/cT0XsNWzk38
         LZLukCad7x9ea6rtEIyPuFxEa0oHe9VIW31q29szBqDDgkqeKshriX2q1rY2FrHiCLDl
         ICFumBeaMwbmStu3RQ6aKC/OkuOCQac+TjBnOHhQRZQJfeJDTLSQKGPDv9ic79gYsbLd
         6GnEc5Ve+1yTqaQymsIOpp8sAoVCdWCkFeKfx8M9dsJWx/+g1vzDLp/zMD1TSuCS22fu
         eo0g==
X-Gm-Message-State: AOAM53338YbP3xPevi5cRwomveBnnVSwKfhDE3s+pkquEsPP5pKoZkbX
        E7UZAAipWCjgohRpG9CH1/5SPA==
X-Google-Smtp-Source: ABdhPJzE05N9ef3h/EyPvS3y3bSp0Md5B3uYMsRNnSuSDi7iIYdCLeHCo7yxFL64F4HE9Ljrm418YA==
X-Received: by 2002:a05:6a00:10d0:b0:4f7:5af4:47b6 with SMTP id d16-20020a056a0010d000b004f75af447b6mr18880938pfu.6.1652728883649;
        Mon, 16 May 2022 12:21:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b0015e8d4eb1bcsm7826692plh.6.2022.05.16.12.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 12:21:23 -0700 (PDT)
Message-ID: <6282a433.1c69fb81.7e728.33ee@mx.google.com>
Date:   Mon, 16 May 2022 12:21:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v5.18-rc7-126-g6b601767c503e
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 1 warning (v5.18-rc7-126-g6b601767c503e)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 1 warning (v5.18-rc7-126-g6=
b601767c503e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
18-rc7-126-g6b601767c503e/

Tree: pm
Branch: testing
Git Describe: v5.18-rc7-126-g6b601767c503e
Git Commit: 6b601767c503e2488f8e4ce6ce06ad67573797dd
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
