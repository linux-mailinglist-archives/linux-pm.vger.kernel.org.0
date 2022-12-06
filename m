Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE8643B9D
	for <lists+linux-pm@lfdr.de>; Tue,  6 Dec 2022 04:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiLFDCf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Dec 2022 22:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLFDCd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Dec 2022 22:02:33 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E272253E
        for <linux-pm@vger.kernel.org>; Mon,  5 Dec 2022 19:02:31 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id h33so12180202pgm.9
        for <linux-pm@vger.kernel.org>; Mon, 05 Dec 2022 19:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gJdmdYqPsQhqsZwzyouEKHpkv31OANLnnv8Kq2hGmcw=;
        b=EEAPb/arO0mo3m7mVu9kOEkKgFhpFxLdvYMHTXPwVjkAG4Urs1O/BJWPcuMVU8v2jh
         CrcxuckmukCpoy6nlUvo3U9/9Opns+gOlZSmbO6fGrj2ZhYDVeDnzvDuLtk/ejtU60Wn
         cszOk0oqa4SepvpVQwJEET4gVUNbvmwuSnOW+TJBYIHwTQn+3crUBipZQ8C5fA5tva0/
         3ChZ0ECVBlmqaxqB9Dyk8wrKCn9aAxwJAeyD00fa0nnHe+UjASJVZheZEQweq0Sahg9a
         iUcahSSCgzUxEfm5gdEyjI02VE2vx+bGLWPJcROoFNYFMNRC+HXxKn8pLZvcCKpLcU6c
         /LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJdmdYqPsQhqsZwzyouEKHpkv31OANLnnv8Kq2hGmcw=;
        b=R91eZ06Mr9zvLwlsBEXm0N2NVyS24aj0PZrB6zD9OTZmBS8VivuI/IdLtkJ8y8hzN9
         1BDgyD2On89VlKZzXxugd6ujYDtgdyuuoegyZ3cuZ3qqVY0yT785euiQr+XntcjZCJUJ
         nzzmkoBlxw2sIGReu28MxgYxUTfgTMqVf+PbmA9gzS8exO2nt1x9J6zcGx9LfgpIK6eA
         HZpSJyiC3/VMM3WO9IGbU2ykvqGdHqm/Kkviw6+KR1642ImJyVwzYq0txt6dIHFSQ3NW
         Ji9jqSDOicmWrshMVAGVvNz9o7noswTpAxOtHzPXlaTxZTUCEd/Pipym1oWzdIsyIt1C
         FuaA==
X-Gm-Message-State: ANoB5pm5spjnij4W/mvY1fwV5nWWUKZpvpZyWDdRMf+h0t8UaG4uKfKQ
        sJAG8mIRYVWqYLsa25PLVughzr8kob7Cu1IJOZ+aIQ==
X-Google-Smtp-Source: AA0mqf6LjJ7B1P3fgI4/O9YdfSdVnhIY2w64j5Z/5gLpgsNMeL+NiKqS3iugJ8mwAa0J/jEhcbNYvw==
X-Received: by 2002:a63:f545:0:b0:477:e3ce:739c with SMTP id e5-20020a63f545000000b00477e3ce739cmr45180948pgk.363.1670295751243;
        Mon, 05 Dec 2022 19:02:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b00176a2d23d1asm11261056pla.56.2022.12.05.19.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 19:02:30 -0800 (PST)
Message-ID: <638eb0c6.170a0220.fef0a.51ea@mx.google.com>
Date:   Mon, 05 Dec 2022 19:02:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.1-rc8-130-gd1f5732ae3e3
X-Kernelci-Report-Type: build
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 5 warnings (v6.1-rc8-130-gd1f5732ae3e3)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 5 warnings (v6.1-rc8-130-gd=
1f5732ae3e3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
1-rc8-130-gd1f5732ae3e3/

Tree: pm
Branch: testing
Git Describe: v6.1-rc8-130-gd1f5732ae3e3
Git Commit: d1f5732ae3e3170a8bace96bd51be6896d566d33
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:
    32r2el_defconfig (gcc-10): 1 warning

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
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
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 s=
ection mismatches

Warnings:
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
