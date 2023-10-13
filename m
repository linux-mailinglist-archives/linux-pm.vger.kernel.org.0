Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9777C8473
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 13:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjJMLeg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 07:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjJMLeg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 07:34:36 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9A3BE
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 04:34:34 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c4e38483d2so1326085a34.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697196873; x=1697801673; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xKEQIcOM3MdjvO2j/p0Wbp17RHXs4ZX0D3r8r2bGeK4=;
        b=jcL/gaWqn/SxGbLvzveLdNMj0jSYmi4pMCrPdlQTjcIffZ/ra2rd3wENmRgrdivLbN
         qLrKp+Rm3hUlQMNlpksDBhbdMTiYEXMg2gTLTWEV/e3W1vsbm8d4mb7R4e2ZbQbhx6ci
         pN0emus1gSyJ+/fG53EHkzwWpf2+5QBvgfFfMdny9rcjsNtrlrVEGLLEla5yQW2pcbFp
         hLtJVReDcaeSkyQhjqqJ/G3eyOcefH0LsCQXw0XCD7W83NrZ4SImoClxhsm8Bromeq4q
         cJWKktbqj7jHPfEjKxMfPGPAIHRKQZIbxK+8LuGxu7py3dmyAlTMSncoqYGtCg0CjOvN
         L7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697196873; x=1697801673;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKEQIcOM3MdjvO2j/p0Wbp17RHXs4ZX0D3r8r2bGeK4=;
        b=meuGve5z+uoiKdenZ/VHN9wJESy6KlIlpCaiAaCYAcB6hztisRT9OTU/WS4n8pkoDP
         zG848wqFWGS2Asl6Nee9+j5YU095CPO0yoNgKAEDN9AkIGRqTEju9HZN2Phlz2xoo4LQ
         ICBzilflaDk/8YwwUbwLVyMoHL0X2Jh9k3Hv4wWh3x+UpwJRyMWUrfB5Gd8nv36yO8m9
         6AqqP9BC81rR5Qy27qonw1Q1j6PhLo2b7asjMQdfhL+2uX0nL0CnZkNslgxszPfbRbak
         Q+xYT1iNQgsoJtoC6RgjziNDPfDascaenHjsIiLr+158jnMGldeC4d4ZFKfOb2QaEY4Q
         fv+A==
X-Gm-Message-State: AOJu0YwfjRJj6oSv8Rkmk/+I8FfeIr24JyVQPHoYhZa+5MdSDXyJ24c3
        fBaA3nsPYmh2aR/2WWcfMzheyg==
X-Google-Smtp-Source: AGHT+IHqrTB50Y0L+sDZdxCqWqILF0fACndqcpa4ci726HLCidVT8IigB7mdLPPMNy3fFF3jnmayUA==
X-Received: by 2002:a9d:6e09:0:b0:6b9:ed64:1423 with SMTP id e9-20020a9d6e09000000b006b9ed641423mr29059670otr.2.1697196873751;
        Fri, 13 Oct 2023 04:34:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a5-20020aa794a5000000b0069327d0b491sm1173786pfl.195.2023.10.13.04.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:34:33 -0700 (PDT)
Message-ID: <65292b49.a70a0220.b4e54.2a57@mx.google.com>
Date:   Fri, 13 Oct 2023 04:34:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.6-rc5-157-g8134843f53ba
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.6-rc5-157-g8134843f53ba)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.6-rc5-157-g8=
134843f53ba)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
6-rc5-157-g8134843f53ba/

Tree: pm
Branch: testing
Git Describe: v6.6-rc5-157-g8134843f53ba
Git Commit: 8134843f53ba0826c8d090964f9bedeeea19c665
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
