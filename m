Return-Path: <linux-pm+bounces-2171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CD082C4AB
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 18:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1477284D33
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 17:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E1D22623;
	Fri, 12 Jan 2024 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="GABH7ejv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A4175A3
	for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d4ab4e65aeso49499505ad.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705080459; x=1705685259; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2duZKaxsaHQ68Xx59jZoDxknnqNuJLKUI4y9M31y1y8=;
        b=GABH7ejvXoPBSwFUA7g+MHrmq75k5kQid9R1ZUAMRaqQG4jR/zGrX5PUP2rBQ8WHu9
         inWPwQlLH8s6p+kNIZPvweSpxI1g6Rl0zSxl8AVfnQy7TwoFQ6TiK8+Ne8tXKKKnFQyn
         Q92hPWYXbZ0l5RbN7/NvsnWlUJy/ZvnXd986uuXAZY66yKTY12CAMWdfidJvH4YXV6jX
         kNnag0rtue0utv3+2bEz/PYLoMXq0xN5AyZngANSVYU1Eka8QcUvcM31+FrQpxY2kGk9
         E5TJdaDGscZv5adgws3kW7S5+5OZrD9TIQIVEs7gJfbCLK1V2GjKNQCJO5CzIjCAbyIe
         BTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705080459; x=1705685259;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2duZKaxsaHQ68Xx59jZoDxknnqNuJLKUI4y9M31y1y8=;
        b=mtaJYOmNiPpWoQLgAX0By9XU1sa7Ts0FePS1kXcyW7dvmPBWOvdXYobigpkI3vUWiP
         hb2Ck0hjxeDbQyqWRP+a2omS4AhDerDO0gULscY7X3x+bUU1WOaWNtSv2EpF1vtrNmYk
         u+BAoX4inmvgw1DRsrxMVn0QenL1dFv/02L1HJkU3MzMYJfDG8xjYoHsPRwuj/9n24vi
         keDQzBRpKJEBSyXyk3szsdQ9XDEg4J3s95C7jcXoF8PELbo2JyXKcGjk3QLSmmv+NP2q
         /JhePzDNkG8hXXSq6y1BrMNlf+a0wzL9xQOaBPubEZaZ9Yp+7zqKldt235yE+vU5e/Hw
         JedQ==
X-Gm-Message-State: AOJu0YyeOzZw6+Z7T5mxWz8Nm2yKAg0iNP2Xx2hIzKQa3zkbnlA0xRhb
	pEB+HvjyNS1EKcElvvGbr0qkGPplDf3ebA==
X-Google-Smtp-Source: AGHT+IFmKpBOLnklmzxm7XHZRfBdtqsckMNXk1LeBPQ4Oy73N149hT7N4OGQr8jFNWbxSf4fz8omLg==
X-Received: by 2002:a17:902:a3c9:b0:1d3:485a:833d with SMTP id q9-20020a170902a3c900b001d3485a833dmr1659823plb.39.1705080458708;
        Fri, 12 Jan 2024 09:27:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b001d4e04b4938sm3400284plg.85.2024.01.12.09.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 09:27:38 -0800 (PST)
Message-ID: <65a1768a.170a0220.8c7c8.a8cf@mx.google.com>
Date: Fri, 12 Jan 2024 09:27:38 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc8-185-g477a23656d9b1
X-Kernelci-Report-Type: build
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc8-185-g477a23656d9b1)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc8-185-g4=
77a23656d9b1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc8-185-g477a23656d9b1/

Tree: pm
Branch: testing
Git Describe: v6.7-rc8-185-g477a23656d9b1
Git Commit: 477a23656d9b12a2a847465dd1d96a4c6f9500f8
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

