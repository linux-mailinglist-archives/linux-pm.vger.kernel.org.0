Return-Path: <linux-pm+bounces-1831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5995F824679
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 17:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F6B281DF7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88AE25574;
	Thu,  4 Jan 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="1MWDGBZV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D79E28DBC
	for <linux-pm@vger.kernel.org>; Thu,  4 Jan 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso522276a12.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Jan 2024 08:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704386435; x=1704991235; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KbyW8hTJ6ZCfZdFPWkJYcxj36C3D9c2y15Xd3uWMIWg=;
        b=1MWDGBZVpO8wOk+INDjCZtaulBDODcJzCqFfpM7acYs7lpU9sQTDPLgCsdbY7mVibD
         PK/CggP8dm6mDKwleKLpWJHd9YUzFOkXYDYqcwe3FO3sRCuOvIZY5n8gL+dj8yUaOjkZ
         +AWufXdDlPE6tvszcxq9PNM7d7Qhw6isA4diPzToKLwWh/r8d2fE0Xs5wZ7TKS/g7ujQ
         XpZPn7pN3OGHJ5jb50CVedjQr7eA8cRfssWrRqZR7vSc3j1gG2eRjeJthS5phuuIaviD
         0VjhXUMg0YMEKz6uZ21O7UNSUFRdCgZlBKugnEWaVbYITL/PFc8vu52NtZUns/auP2FL
         4Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386435; x=1704991235;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbyW8hTJ6ZCfZdFPWkJYcxj36C3D9c2y15Xd3uWMIWg=;
        b=uJ8CB7l9/9RlY7B+USnc5f4qGeB+kwBMmmJwBzeit+kXEBKPdqR7eimTxwUxGXjS9K
         7BQBxTin63aCg0+92WMuentlvCQqf7xhd3QOJQJ16kE6Ml0oj0J8dZsM6QNAKRseDGJ4
         hcuVFxBCqkI1OuG6aXygBbLBCbBbl0wKQoCSxlB9v4xPwDjXdyKtTrVwDJ2GwwCsISwL
         GV8/f9eR8IEH32BDTJo6bMWKA3HE0/Drm9/UeHsVt+JzrTzW8NX/JzH1rN7yT+9KJdKl
         zq+7u4xNo4mG0xn1koL4aXh5vUmC8f6kbjXumMFu6XkjxIGBH6nLzY7CoGzmoJJ8bUOB
         vg7g==
X-Gm-Message-State: AOJu0Yz5RwMZ5n8ztQzvNZSJrRQ2GvWYPRieUfWRuc07rssrHJEq4qNi
	DrNVbeEgJfFDFCvhIrkYfnssmdNj5ldyIw==
X-Google-Smtp-Source: AGHT+IEkLYma9lfYVrqfUn8eUxffpYtmWAy6DVIKYRTAlNXHRzrIaxrYc/0BGKCPiXH3szzDtNKacA==
X-Received: by 2002:a05:6a20:1399:b0:196:f06e:bdce with SMTP id hn25-20020a056a20139900b00196f06ebdcemr707671pzc.113.1704386435501;
        Thu, 04 Jan 2024 08:40:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id gx9-20020a056a001e0900b006d9a0694f93sm20935720pfb.205.2024.01.04.08.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 08:40:34 -0800 (PST)
Message-ID: <6596df82.050a0220.25abb.a336@mx.google.com>
Date: Thu, 04 Jan 2024 08:40:34 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc8-163-g1252bfff1b1e
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc8-163-g1252bfff1b1e)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc8-163-g1=
252bfff1b1e)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc8-163-g1252bfff1b1e/

Tree: pm
Branch: testing
Git Describe: v6.7-rc8-163-g1252bfff1b1e
Git Commit: 1252bfff1b1e8718037202ef2d16fecdfd31ead7
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

