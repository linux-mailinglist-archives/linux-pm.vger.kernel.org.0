Return-Path: <linux-pm+bounces-808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8770E809560
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 23:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA97A1C20B23
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 22:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB526563BB;
	Thu,  7 Dec 2023 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ueJG7TQa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8449D11C
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 14:31:21 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5be30d543c4so1141794a12.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2023 14:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701988281; x=1702593081; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r9rPpmgyQRsHfEJYWo8E9D7jgxmzwGtoZyCeXmg9gI8=;
        b=ueJG7TQaycysfF+BLfM8n3u+XE+q2GJrcJ2afs3cKCt1btcns6gdlBHy4ijWivzbaY
         jJgn/JcOqlkxGgzeETlOaPcMbWclLO0Ukaxnz8AdIxo/hPFrC3LIFQpjhPqMoYGddVzJ
         aPxg8IPRS/6DFOwpeBzcS7mZXOpHNDpDPMIB1+TMfiutFD8g+wqtMK+c5GuEQMG1cziS
         NUGJX43MnCLDaZWGaaCl8o7aY90QMJbTBmhiwCZmTAzxwjqGBXvxdZs3qzQbfyWRyU+d
         5AJK66CUDPmXasv7s0wbx0r1j5sDym/AkvH8872a7NRf6Xf4AdvkPn2sM2TItA8O43Zt
         +FeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701988281; x=1702593081;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9rPpmgyQRsHfEJYWo8E9D7jgxmzwGtoZyCeXmg9gI8=;
        b=DrOxHOHaVFVclW6cOAPk3b/spmlFIcA1pkmJRwBG0h6RmVHGZdF/6qdSxR9IBHremZ
         XhCZ3VIFp8zGRciQ6byUTn1o6wuYlnA6oPl6VBYDbi1Hl03roWRInXIGgmyGwJS6xQ8o
         cmYUdMFhNB9YZHwqHnTGoRvXObNu4dlUKYF6Uxu1E+M2W2z43vinN+DXqzhF2KE/pTsj
         k5nFxs07jXOMCeKqBtEaql0K1x6ebsw4tsM9JQrrRRFuvaIezTHmifcfcj8+FSrlHRgN
         R08P/WM6W6P0nkVE6cdzd8O52aj7z2Qw+aPTCmvazVLsBdmLqQv4wZI1/lZ4Go1r7DPm
         7Row==
X-Gm-Message-State: AOJu0YxHN8fOMLKKzI/VIpvSvVuuAg9wrV7JL3i1VyZ9KXjsr8fUFhGO
	Cdqd961LnC2qLk4OOmVqFXN2CA==
X-Google-Smtp-Source: AGHT+IEaV0Aohjpg7NVE8QaBSthPzzWdv15VWGCd78sYyqjvU2/YHNZSQ/UDhZml6H52jkjdrYr8PQ==
X-Received: by 2002:a05:6a21:339c:b0:18b:480:a0f3 with SMTP id yy28-20020a056a21339c00b0018b0480a0f3mr3286746pzb.4.1701988280799;
        Thu, 07 Dec 2023 14:31:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902768100b001d078445069sm312266pll.230.2023.12.07.14.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:31:20 -0800 (PST)
Message-ID: <657247b8.170a0220.d4afa.1cf5@mx.google.com>
Date: Thu, 07 Dec 2023 14:31:20 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc4-67-g169769cb3761a
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc4-67-g169769cb3761a)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc4-67-g16=
9769cb3761a)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc4-67-g169769cb3761a/

Tree: pm
Branch: testing
Git Describe: v6.7-rc4-67-g169769cb3761a
Git Commit: 169769cb3761a9d80809ad64ed85e9b1f5b3a810
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

