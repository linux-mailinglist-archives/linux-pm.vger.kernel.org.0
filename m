Return-Path: <linux-pm+bounces-1733-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 214A3821D56
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jan 2024 15:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2018A1C21F2D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jan 2024 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB73101D5;
	Tue,  2 Jan 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Ar+MjtXX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009A1426A
	for <linux-pm@vger.kernel.org>; Tue,  2 Jan 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so7382213a12.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Jan 2024 06:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704204352; x=1704809152; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HTupYq3CHqniP3+VP6SL/MNo9Eu1FV2W5DREG8UHD8c=;
        b=Ar+MjtXXxBsQFVEMUCjLSKQeleH7ItWBZSKQm9NaYYWTVFWjGjDqgET4E5O7zXt0TT
         cc0Ngpe1tmpo8xR080hZPmcCEUMTiPw/cKPx51pWTOicoLIcXLeedyMx2VsZ7RtDVUJ3
         8rvgrxsPzT7F/pFC6yaCkRgIvWNDUCsu1gMoEwtUe7mrSDXQIoTxa+PM3Hmvwiqh+VKx
         4xWV/3CqzTV+dZJV3r+aEygqJko/VpoJxuqF2PNXUQQJOUq8PxpmjuCVPD+FcJP8NANZ
         pr1G8hU9s6S7YnX7YzcJUEPNtJKU0poMphazRkQMJB71L1u1WuKgj6dEDcBGIU7ICjxl
         dx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204352; x=1704809152;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTupYq3CHqniP3+VP6SL/MNo9Eu1FV2W5DREG8UHD8c=;
        b=H4bK4pYpAoDGNAPuK41B4yqYyNUZX3+M6WuUkPi5TkSeQ659Njjh8/c3W8/MGOCmxD
         /Z87F+FhRuJOpIhGiujnLOZDZCSp+3hWpNEey+nAsG7dHA6YqRg4GfeR6FmjV59hwVfY
         TGiGt6rI2lHyQaiLqTb0k37QMlJnnZMvAepyqyd78w0zJ9R877BYIBgCKwtacdP6sC2i
         9ZT8OltaKENrX8mcKQQaeF31T5LJIXZatPVggg+1+b8XJkHtI8ytj/sNfGmxXrnB3wQO
         5jqHh36GPqAU9dV062ILpwZOYM8grElMgzl9vjP+eOBcRI16UmD025yANTziK8XEjwNu
         IHqA==
X-Gm-Message-State: AOJu0Yz4wPJcqcFzNRoZhwVr80D+2NgORGFP+UpKlQqa4bCvM608UOR4
	xZCRhoeaWEDu3dDIkU7ABjOcexT92TNxAAtNgFDAJO03n7Q=
X-Google-Smtp-Source: AGHT+IE6Q7y6xG+Qx/FpLbKljIfP6lmUkvTLisjCceAIdkiLv1RiYm1BhhPGz4dO/kGuImQ4CpYBbQ==
X-Received: by 2002:a05:6a20:2592:b0:196:fd12:a4a2 with SMTP id k18-20020a056a20259200b00196fd12a4a2mr3946232pzd.85.1704204352500;
        Tue, 02 Jan 2024 06:05:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b16-20020a63cf50000000b005aa800c149bsm20190749pgj.39.2024.01.02.06.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:05:51 -0800 (PST)
Message-ID: <6594183f.630a0220.69981.b48a@mx.google.com>
Date: Tue, 02 Jan 2024 06:05:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.7-rc8-148-gc0e52ad85f5f
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc8-148-gc0e52ad85f5f)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc8-148-gc=
0e52ad85f5f)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc8-148-gc0e52ad85f5f/

Tree: pm
Branch: testing
Git Describe: v6.7-rc8-148-gc0e52ad85f5f
Git Commit: c0e52ad85f5f1a653feb451bf6483646dfdfcb24
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

