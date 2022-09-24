Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E885E8EC2
	for <lists+linux-pm@lfdr.de>; Sat, 24 Sep 2022 19:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiIXRDt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Sep 2022 13:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiIXRDk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Sep 2022 13:03:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB33B96FEB
        for <linux-pm@vger.kernel.org>; Sat, 24 Sep 2022 10:03:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id v186so2881506pfv.11
        for <linux-pm@vger.kernel.org>; Sat, 24 Sep 2022 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=fv8w4rX9pDIX6HkTOJy3QoL7TmIg5qGpNe0ew7oW3tQ=;
        b=vqJ/0uuhaanJkKc8A78w+fPCMeNVw7RSm5rLUsw2XsSxf63L++Z1NU8Dh/Y7FJt02z
         MU71BACQlXe7+EUm+znZjzCMn7ludG+4hTLC/E9HJSfJ5hpSbFK7d380rN6diNggZ2yX
         dSw9KlNnH4T0sTwnJ/FuZl8APdxXW1JCM4YubrB5AtMDliqBfWWAwLCb7xa6sp8coF45
         YR/6QhEWHX2jk2PiSBTY/cvucZD1M9YCc/yiUMZkTA6Kbc4CmIC94hlHDY6nZzJHswQu
         act4copBcjVINPjgiG9qTHFcA4wCQzABUyXi3QOgaBOjjnxBqr2mxDDbgGTpWFqGy8KA
         oJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=fv8w4rX9pDIX6HkTOJy3QoL7TmIg5qGpNe0ew7oW3tQ=;
        b=GJuteEWD9VvQrEkfYMUr9w0ZLYZ2A4nqKtJraawGn+P/1RstktUVXyFdXd2MM4PXA/
         JMXYNpjywsd/Iz7mk3LHnwiPhi9vvOoW4/Y4ZUkcpmRVKa4158y44oiRO0e4GB44Lg3v
         F8v9dNPeBM6rxpG0U6SdYjpNyTZmyVmpBWnz9rJkWIlrsLZlV8AF4eHxIs2p+C0WUAJR
         N+bwn1b7Br+5SDY0aGcUwp+jLtMWtE7CF4we1euQJg2EJu+Kw01eIegniAf8aj0rwZlc
         O8Wyqn/y7fuRsTT6MfZOyrG/2S8Ak2vud6PbnyQMUzzA4wfoDXn4wMVCp/kB1mz9SNLz
         OmkA==
X-Gm-Message-State: ACrzQf2DrL8LDUadaUUPqdo1PcXFWEmwvr185Kqt0xW7Aotb4wAceYXu
        BPAbRKDvpv0Txj/6c9MqnD6gyP1Z8f5zPTt0hgM=
X-Google-Smtp-Source: AMsMyM4HIza1pgAeRA0G7JaXhiJloz+dXy1Zd7b1/ojsA+Uyb6lt6Q+C8NewzjosXWk8XoJoWiwnTg==
X-Received: by 2002:a62:84c6:0:b0:538:3c39:5819 with SMTP id k189-20020a6284c6000000b005383c395819mr15033911pfd.4.1664039019305;
        Sat, 24 Sep 2022 10:03:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c79-20020a624e52000000b00553b37c7736sm7624893pfb.25.2022.09.24.10.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 10:03:38 -0700 (PDT)
Message-ID: <632f386a.620a0220.72c83.e583@mx.google.com>
Date:   Sat, 24 Sep 2022 10:03:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: pm-6.0-rc7-143-g00674ddf1b594
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 4 warnings (pm-6.0-rc7-143-g00674ddf1b594)
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

pm/testing build: 7 builds: 0 failed, 7 passed, 4 warnings (pm-6.0-rc7-143-=
g00674ddf1b594)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/pm-=
6.0-rc7-143-g00674ddf1b594/

Tree: pm
Branch: testing
Git Describe: pm-6.0-rc7-143-g00674ddf1b594
Git Commit: 00674ddf1b5943bf978927923f3a8f00e2cad255
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

sparc:
    sparc64_defconfig (gcc-10): 3 warnings


Warnings summary:

    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    1    arch/mips/boot/dts/img/boston.dts:128.19-178.5: Warning (pci_devic=
e_reg): /pci@14000000/pci2_root@0,0,0: PCI unit address format error, expec=
ted "0,0"
    1    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.

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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]

---
For more info write to <info@kernelci.org>
