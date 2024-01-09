Return-Path: <linux-pm+bounces-1999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31978288AE
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 16:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683871F2595D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A822439AE7;
	Tue,  9 Jan 2024 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="E+4iflTp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3239AE3
	for <linux-pm@vger.kernel.org>; Tue,  9 Jan 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so2022278a12.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2024 07:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704812612; x=1705417412; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uR8fO2umBfnt1xS4i8S3Ta3Xw3ZNtPIgA9eF2P4lYWM=;
        b=E+4iflTpqMnkPeebodYUQZEP0coFERDcqMSOQQeWAnqb3PPbmFv59cb4onUkUwlVy6
         C0Zwon4p7ElLSRrr1eMiNgrWukjsv1OwSQmfIiqnooDw9YC5fpstznOyLDwkql6vbNTy
         XTP4CoX4wqD/igYxvi24kWYa793H6+TW7+FNAX7rGUKkClfbg4PKLBThytVEOsttKg9B
         n1I6/1Ljg4IHERbs7opNS/EHhTYm9U7xnn5PVmTRn5YrMMGtk2wk4oKvbcwq52fMOxwg
         KhclOB4UyWGUbbk2FAU/Z1RxS3/FvKCgYOtZ/kLE19ozEknQajJBksZZq4itvi4pf0um
         +bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704812612; x=1705417412;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uR8fO2umBfnt1xS4i8S3Ta3Xw3ZNtPIgA9eF2P4lYWM=;
        b=EZM4sE6bq5srZR1Rojs/4j/ATRA5aSBwMc0FjRn2uV27sDA48zOPZeKWz3Qan3m4Bd
         Nt9d0beX9KedGLaSe38vtKwvw3RFHVeThssaZTKuhOwzgBLdlLGrd1LnDvzbP/1NCYUh
         Qx44DoC9UtzIlG/WJJj5EUnaynFtyD9TM7i9aF0tG3CjYrBu0zuOzdsZCBwyRAnHRWDZ
         /jMK1og28YNVNosUuPPYSTZ6W56MAbIVlqaJEBfvvMxOrBJmRlX6Oi/nN6yDZi4fLbmI
         4kbwRc35hGAfpseDbgRILEYTcJ0l+t/n3ll093fGAqPUYZl3krwXM/li6yV+4Dmx2VDe
         xbLg==
X-Gm-Message-State: AOJu0Yz1Q8NRLKZX/pvCcqmb1ekXYVQ64R9huurKx0KHyrB1cYdKHeiX
	RR8Aia2swgxkaHB15sShpP/ySLQNzdO7jg==
X-Google-Smtp-Source: AGHT+IFIkKln8XljIkP8FTH8fapw8vVBvpAbXn3hoQD6lubaiYIxN7L7d5XTqM+w6gRVvanUCDjn+Q==
X-Received: by 2002:a05:6a20:2a23:b0:199:8635:8595 with SMTP id e35-20020a056a202a2300b0019986358595mr842471pzh.60.1704812611601;
        Tue, 09 Jan 2024 07:03:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m14-20020aa78a0e000000b006d9a94a03a8sm1767660pfa.77.2024.01.09.07.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 07:03:31 -0800 (PST)
Message-ID: <659d6043.a70a0220.9260.7004@mx.google.com>
Date: Tue, 09 Jan 2024 07:03:31 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc8-168-g60367484d037d
X-Kernelci-Report-Type: build
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 4 warnings (v6.7-rc8-168-g60367484d037d)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 7 builds: 0 failed, 7 passed, 4 warnings (v6.7-rc8-168-g6=
0367484d037d)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc8-168-g60367484d037d/

Tree: pm
Branch: testing
Git Describe: v6.7-rc8-168-g60367484d037d
Git Commit: 60367484d037dcc72b64f7c4b6ec8e8066fd2d2a
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 7 unique architectures

Warnings Detected:

arc:

arm64:

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

