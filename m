Return-Path: <linux-pm+bounces-1485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F79281B571
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 13:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BC31F2455B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 12:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911D36D1BF;
	Thu, 21 Dec 2023 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cvUZu78q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A46E2B0
	for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3ad3ad517so3717325ad.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 04:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703160337; x=1703765137; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kF12I4nLvX8usAxW07lBYcwQ8oEcLNU3sy4oq6YAZHs=;
        b=cvUZu78qmaMwRZ97V0fb7YEo9XL/0+VhTVlJ6bvbjW5G76jugFR6UePIpDV81tXgvf
         DRk7bApy94vSzXuo4QugHuNdKm9g47KTtZ14VAAsaWjICwq99gJe19CJEKFmNcBnUI/V
         h8V/+i8ASp49bJaYYvG8GlrLTySq3ovhWdrMw3VY5TO3egf4FYQY2L3ibJcW/DcK6Yzi
         yDuCWZPxcRBQAVw4H0nm5IGnIT0TCrRuXQ8FDWxEzQIjnLTiFcEs01RGckfRhwbVNITV
         +hnu2dnG/yGNn/3sz1D29qwKJ+avmfdrw7GB6qGXW0ywl5mGbIu8ABu+W4lnhS6w5Ajm
         iY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703160337; x=1703765137;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kF12I4nLvX8usAxW07lBYcwQ8oEcLNU3sy4oq6YAZHs=;
        b=mzv2jZj9b/I+efKk5KdUsYu+U0UIkmo6Pau2qYvUpxaVwACMDj2SQmhkTYFGYNFKYD
         r2m5R4AaUmDtUNUo4mYos4fib2sbw/0wZDaOTjHuR0OssE20FHbsh2hG9iL6g/OB6Z6Z
         vrO2CYBB4k+mOM3Vf26dVuUAocC2NTu+SLxhHF0tsILaYvZGD0DmwOVOAc5xwbh2R165
         IBxtqOB5xKvqnvxkVttP9BoeRPN2sWeAGzIC0fpCPMDvygAnQTFzudIqzCqO+Kgr9Ino
         ampBQ4774eY+VW9Scpd4y1XLw/HW4/JbsrX+u7X57l+Nk8Y+1bK87h7xg9PRyrNv7RTp
         IY+g==
X-Gm-Message-State: AOJu0YzUDpngH9Hpxz8ObjHIl2LFmydzN6F/HXIu1xFwLDqHyCLR50lN
	YgZPIU+aVJ8w8aoZ2NqQGefZrezluMSLZsuMmvY=
X-Google-Smtp-Source: AGHT+IHVEwxosfPiX9AZ3ut9ptV8G0a9dk6BbXMDdqo8n0UQhgyqaHxbkxuC4e5dfd5A9WGYIQ9jog==
X-Received: by 2002:a17:902:b195:b0:1d0:6ffd:adf1 with SMTP id s21-20020a170902b19500b001d06ffdadf1mr10235078plr.88.1703160337041;
        Thu, 21 Dec 2023 04:05:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902d3c400b001d3e8a5755csm1478678plb.48.2023.12.21.04.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 04:05:36 -0800 (PST)
Message-ID: <65842a10.170a0220.1f673.3e5e@mx.google.com>
Date: Thu, 21 Dec 2023 04:05:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.7-rc6-95-g52227a1b24640
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc6-95-g52227a1b24640)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc6-95-g52=
227a1b24640)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc6-95-g52227a1b24640/

Tree: pm
Branch: testing
Git Describe: v6.7-rc6-95-g52227a1b24640
Git Commit: 52227a1b24640361bf68926fe12e60ab76004c7d
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

