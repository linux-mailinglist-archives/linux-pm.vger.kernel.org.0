Return-Path: <linux-pm+bounces-1108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFB681184E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 16:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950C6281963
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C5031758;
	Wed, 13 Dec 2023 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="vlmGCYs/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8525BD
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 07:49:35 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d359f04514so2375145ad.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 07:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702482575; x=1703087375; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7OsktxtBu3SkFsXC3FA4Ieq4Ex7hD8f2ier73peY4Fs=;
        b=vlmGCYs/D7H7NbC3iKwt9Nwxe+TYb2bWTZ4BLviAzyWqVo3/NJzL/+e9TVh6ebOiEY
         KBMmY7qxXjRzPJp3svxQUt8/1zHL5xEYnVlxnrAGh+XzP5rCTxKVDThv9bcoeAgIgja+
         km4nMMLqFarBLveXq7zX/eNDqMFvJxfhfxny01xln6n6tlt1E2832fyvH86P1zJfkwzx
         Eo4W66/wywg8AFv2FyGu2F3w4VhjjruNUEbh5vYk6PJwwsd1JSAhpRTsNnS7vY2m7PzT
         s8O5VLTOZkAg8vdNnTLWrmtUVolplstT+Uw4mmIhfGoYnGU+h05EkZB8pFLy0vqrkdZx
         OShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702482575; x=1703087375;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OsktxtBu3SkFsXC3FA4Ieq4Ex7hD8f2ier73peY4Fs=;
        b=KsbljjDzKdJLbGwtvJj5uuH5J+Ph9VbD4IxzAHQO+CqxtKZ2B17zL68d/NOQrSNpk8
         sPgYLL6Y4tN2c3zxYTdIh+CcNtMjnDESdRU7lXpEh5q/6FzEDJ1e848dD/YUoMrUYUtO
         Oh5e8FFoSC08YPaeRTa9BPqzl6/0oiGyIGfkyLOEqlsSuz1DxcKXrrTPFGwnKC0TsC0Z
         GJYM9vnZvBmtg4KT5dEH1kwQetqFQoMfBQs8SIUXOxaEUrpymSicgMGSHz7pkPoUydV8
         vRIeUzjqfi3tndVGs3j0bY3rlZWpA6Fx0cTcM9ueYeRwh+53NCKNBieVaf7lowSI7AAZ
         vl5w==
X-Gm-Message-State: AOJu0YyJ1nXD1hm1AjljZn4eXawl3ZpS3ptMyqqwDDsj5r5Xuze9xETa
	YAuO0c1U+M/kra5exmcbUsiiDw==
X-Google-Smtp-Source: AGHT+IFaJ5kPjtxq9WE6hVhORKgTedvoiHixmnQRTkQm87zAdS/C7xQ/xuyAuda7AommJ2qU9aQboQ==
X-Received: by 2002:a17:903:2288:b0:1d0:1e49:3f60 with SMTP id b8-20020a170903228800b001d01e493f60mr4585562plh.27.1702482575159;
        Wed, 13 Dec 2023 07:49:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902c19100b001d352a496c1sm1402411pld.295.2023.12.13.07.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:49:34 -0800 (PST)
Message-ID: <6579d28e.170a0220.22499.37dd@mx.google.com>
Date: Wed, 13 Dec 2023 07:49:34 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc5-82-ga5166a0124480
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc5-82-ga5166a0124480)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc5-82-ga5=
166a0124480)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc5-82-ga5166a0124480/

Tree: pm
Branch: testing
Git Describe: v6.7-rc5-82-ga5166a0124480
Git Commit: a5166a012448079243a081daeea0a28e478589a7
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

