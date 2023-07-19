Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23F375A031
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jul 2023 22:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGSUvK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jul 2023 16:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGSUvJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2023 16:51:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398C81FC1
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2023 13:51:08 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-67ef5af0ce8so31352b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2023 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689799867; x=1692391867;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jSkaGOQsHq6BSGNOSrtfXde78PEWclvfuGzFU9ARFJ4=;
        b=pPXs1vh0RhADyXQWcNtjRkvbIk0DJOkYhQTEZ4OHLhoqNUizsI3Deh6SElrShVs9VB
         oG20VNHMjmHsTywFAKf6k+PbflWT8/pXSG9f6Y8lArGkiPJ1jeCgZqyIaswAkKAE9oeK
         on/7tKSyYylBRWkeROwpkzN4mhIkHQDKRzlv/WEQtUpK2QDTYKb7L3r7oM9WVC1Fz7Iw
         ixzd8T3jbPNk6bAJJDc3NB6J0uOny4H/3ZsZQeg1IrXCixMzXbkZATHLVei3CV5T2l3u
         OpAi6sJidcGP2jXxtsbuyf6unxHBYgTslEHsTOgsP+UdpBUTOsHtgujmjmb5sMF95eUj
         LO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689799867; x=1692391867;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSkaGOQsHq6BSGNOSrtfXde78PEWclvfuGzFU9ARFJ4=;
        b=X9jeDhX9WH4pI3ZMUt64oFmv7bodZ9jOe/OdIsp1GNqHHeUdwtrPAeF6iclGv/bL3j
         Kuex7d9A2qvqxNBuvvvZeIYhbOs+Ca7317WvnWG3yvJUQ3aVA4kBuo7itGAaW7qClbK7
         aKCG2WtAnN7rWlSlPJe2NtYlFTUQNPa26/1N/Za97hrpEc57SQmHTaYJFrTWxzYA6iui
         cFzKaeIEJ7nH0z9vwF8RM0gqOUAWM2RwmVCnrML/yzZdKolNWCUd2KgQrIY5S0U9xisD
         yP1NwqhEP0oIAEZ9WhdfyU4m/N511ituPI4NThdGfrJYDw1ZN4U9WJUsSmwgjGUhZ6aL
         pIqA==
X-Gm-Message-State: ABy/qLa0XMTkUiEyBCCumBAGNtcxVZ6/0tyIJ4l8Wh5PPYtW4tmFYYRQ
        v/p2UYd3HktON9EuSW8jJckLBA==
X-Google-Smtp-Source: APBJJlFwFG1Gs5kpLSMS6QQu0LEH+IvhUQ2XLY1EItQelKszuW1oFIi677/s2hKv6IiQk7vZaZ+U+w==
X-Received: by 2002:a05:6a00:1683:b0:677:c5bf:dcc7 with SMTP id k3-20020a056a00168300b00677c5bfdcc7mr4661522pfc.17.1689799867647;
        Wed, 19 Jul 2023 13:51:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fe27-20020a056a002f1b00b00682a27905b9sm3823482pfb.13.2023.07.19.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 13:51:07 -0700 (PDT)
Message-ID: <64b84cbb.050a0220.63eb9.917b@mx.google.com>
Date:   Wed, 19 Jul 2023 13:51:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Kernel: v6.5-rc2-44-g6384f300e9f3
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.5-rc2-44-g6384f300e9f3)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From:   "kernelci.org bot" <bot@kernelci.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.5-rc2-44-g63=
84f300e9f3)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
5-rc2-44-g6384f300e9f3/

Tree: pm
Branch: testing
Git Describe: v6.5-rc2-44-g6384f300e9f3
Git Commit: 6384f300e9f3c5baed9ea999c386cf95c9dc6ba0
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
