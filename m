Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC507AD69C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Sep 2023 13:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjIYLEL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Sep 2023 07:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjIYLEK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2023 07:04:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD839C0
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 04:04:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5c91bece9so43770555ad.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 04:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695639843; x=1696244643; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fQYObVs3EbetHESYRYx0+A6xbJFoUDrXxI3b1W4T7ko=;
        b=WlucahGuNGIWK6uQ2a/JpLZoFHDTJL+CRzTX+unFlCOpFYD7vGhyQ+QW4vYyFyZyLg
         V+lcG4Z33Qzfe+5vjKt093ZArp+l70YZtdiFeZHcreXhL8oAzqvQOUPZyU/BGato0+Nl
         DwzirfB+QowvLPs3i2b0rAovOmrGvo4V/dkZKdOOc/DPUN8reEiwZnU43w3ZBqXcAieB
         7XkVWs/Uf2rpy+hZ9zzom00ESoa/e3nCyjQGDzaT3a5khqzACCg73CYDwWtSVFy1BH10
         /US+ZEgjLsuKNMk0XQC0HwS93gYrZPFXftyVlmcgNC5eXLrlHW7D0DRjmYxyN/a+uD87
         mHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695639843; x=1696244643;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQYObVs3EbetHESYRYx0+A6xbJFoUDrXxI3b1W4T7ko=;
        b=FkNhhXlN+zfmuaq6BxCdyxGXh32ZKs3DgelPuoiBKm1n+ip5LEhtCZ4ErHzyokRTWP
         1aYuwMgn60RXzuErpgmNJWDGTAErMqE7cB0/lwxDopctDjfZMaGuH+VWzj1SLaFg21yo
         GxIeRqmBlATTSs2hP+apLtYI9fLyXKgnx9imi8+yJExJueA1VXoL+Dd5jsOAl36MSlzE
         Gex2GMXPqSAXp07Pv4kJF4NCy+wOe2gwAQWtBGfv31q4H2gynbCRF/96xleK97r2P9UA
         L9b45RZWhi2bLOOUZ9P7k53adKlJel/MUIP252TtCkX9mOzVeaOfRgu7OY4gn6yqcsW4
         a8Tw==
X-Gm-Message-State: AOJu0YyyIyM8Jc1jHQILN+VXztoHVQOU4lfQZIxcSWOiei07XuO/XiKf
        L+sxvv8l2zBRkDSh4bUY0F52KbYtf0WyBEBEDRiaVg==
X-Google-Smtp-Source: AGHT+IGxq6XagPnAp7A4op+sUSyDa1YxOux6QY3PMZVizPv1auTgnk4Z5YCS2p5p+0yP6NloyS/NwA==
X-Received: by 2002:a17:902:c211:b0:1c3:2ee6:380d with SMTP id 17-20020a170902c21100b001c32ee6380dmr3756973pll.48.1695639843203;
        Mon, 25 Sep 2023 04:04:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id je15-20020a170903264f00b001ab39cd875csm4787990plb.133.2023.09.25.04.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:04:02 -0700 (PDT)
Message-ID: <65116922.170a0220.4e8ff.27f9@mx.google.com>
Date:   Mon, 25 Sep 2023 04:04:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.6-rc3-36-g6e2207203652
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc3-36-g6e2207203652)
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

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc3-36-g6e=
2207203652)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc3-36-g6e2207203652/

Tree: pm
Branch: testing
Git Describe: v6.6-rc3-36-g6e2207203652
Git Commit: 6e220720365264d94eccc7916ef936d8d39e3040
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 8 unique architectures

Warnings Detected:

arc:

arm64:

arm:

i386:

mips:

riscv:

sparc:
    sparc64_defconfig (gcc-10): 4 warnings

x86_64:


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

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
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

---
For more info write to <info@kernelci.org>
