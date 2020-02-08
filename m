Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B91A31562B6
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2020 03:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgBHCYq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Feb 2020 21:24:46 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:37372 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgBHCYq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Feb 2020 21:24:46 -0500
Received: by mail-wr1-f42.google.com with SMTP id w15so1080671wru.4
        for <linux-pm@vger.kernel.org>; Fri, 07 Feb 2020 18:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=UHOD7FX5bmGy4CQPmK4moSUfcy6Iw8FiVkEQEDFki7E=;
        b=N6dWGMlw+qAPJNCWLB0OXCuHaWOp/43Axs27Mhl/J3Di8u9w22RPK4LDjY167x2Z2w
         YPRf02khx4DtATaJT3YYyGPbS/Ce0Pbg/0Ym5zP8YiCe1FckgFu7IURIQcKm39mrxZSo
         t+oTkVXxuDFO1/n8W4YTh0SpcP6cfgqyqyHBag14Qk0t9uzWdPUCEFWUXrznhYDWa9xH
         sV+Q6Zfhe+rzTNYrvY+X/JzlxurDpyGaCQI7Z7D6/O2lkoNj5RZAzjsDCRjfVCiGVGVQ
         QCr/Q6Q60zwSNIqlkT63GrNzlJiWnMFcdWdJX9EE334F2r3pQ5zATyW6RRKu9Bz65E60
         FXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=UHOD7FX5bmGy4CQPmK4moSUfcy6Iw8FiVkEQEDFki7E=;
        b=bIjtTgx/FTM/9O169vLxtRnsAeUXFH0gEc7ifQHou8K+DC2hmMPOTaPG5nw7U0oynp
         veFfgd2zC6bBx75C85lKRsLZip/6zyC6WbhS7ZBwKmhTzkJkB4fUxaQz7WemqXgd16Zh
         QErVTF1H//bcX190gsavG+sa/OztVNmQpHSGr2d4bOCJTFjxsMSOZahWJf895N5URjnX
         AVEjifLBydbnSNJ4fiIA3S377c7UvRDBaVXVLMey1HKsMTt+m5nkxzDz0bsfTWfAUBJC
         kyUdix+aOwUc2m5Ivw16XUhU/1QtVkDQxhbkgDEOvnkYilwb8XTra3M7OhLyYFsqMP0x
         2Vwg==
X-Gm-Message-State: APjAAAV5e5AtqDvde27SMr46Fc4zCrXc8QL05ubkggHRIPbviHwwl2V2
        2AC824xqBtM73/xAwCkOBhQVHw==
X-Google-Smtp-Source: APXvYqzj8Wzu2t8QEsHz4pfdOVLp+X9Xsw7M/8kjxsPHSdbnW2lgX7xa/SQzWzlrl/YcTfgCdv6U1A==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr2128326wrq.137.1581128682756;
        Fri, 07 Feb 2020 18:24:42 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 5sm6009895wrc.75.2020.02.07.18.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 18:24:42 -0800 (PST)
Message-ID: <5e3e1bea.1c69fb81.79c0.9f4a@mx.google.com>
Date:   Fri, 07 Feb 2020 18:24:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v5.5-rc7-146-g4529d29bc6a6
Subject: pm/testing build: 5 builds: 0 failed,
 5 passed (v5.5-rc7-146-g4529d29bc6a6)
To:     rafael@kernel.org, linux-pm@vger.kernel.org,
        kernel-build-reports@lists.linaro.org
From:   "kernelci.org bot" <bot@kernelci.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm/testing build: 5 builds: 0 failed, 5 passed (v5.5-rc7-146-g4529d29bc6a6)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v5.=
5-rc7-146-g4529d29bc6a6/

Tree: pm
Branch: testing
Git Describe: v5.5-rc7-146-g4529d29bc6a6
Git Commit: 4529d29bc6a6f458ae731425ce4f7e3856365bbe
Git URL: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 5 unique architectures

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
32r2el_defconfig (mips, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sect=
ion mismatches

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
multi_v7_defconfig (arm, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 sec=
tion mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-8) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---
For more info write to <info@kernelci.org>
