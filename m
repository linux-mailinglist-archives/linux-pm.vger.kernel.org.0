Return-Path: <linux-pm+bounces-926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3B780E42B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 07:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE3A1C219D3
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 06:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DCC156F3;
	Tue, 12 Dec 2023 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Qlm3v7zz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07202BE
	for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 22:10:41 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ce26a03d9eso3299880b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 22:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702361440; x=1702966240; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jdWnhTkho+4lg4nSWhSWpekvOrdohKnpaU1vJWRt6QE=;
        b=Qlm3v7zzmnCY6Vxf6GhsITjO6jCPaAKxRRnb2NAheahbXxTIEauORA5DhUToy38r9O
         wSjBjIhZ/fImV2Te81s7CJ9hdaQXEh2RYdUZMHEZOjNn5vq6gBm70tImqMblofkbVDHx
         q4abFwELtEZuXYkFhWg6iroubhZA4mPBpPzpveT/3OLWAiwoZXR5hGITHBCQSeL0UApT
         HEuxKhSICVDSxsuc3bI+/msNNlhLiZO/zGKf3tUiOjDJLZNkT+bCa7RqInQQhG/FEDaV
         OtBg2q6gtTGJXtTEDydcJnuGHp3ayZmeblLCgeF6Qa526cOhwDRoHwGAdUkaCrmXWImn
         Aacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702361440; x=1702966240;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdWnhTkho+4lg4nSWhSWpekvOrdohKnpaU1vJWRt6QE=;
        b=vJjZ2/c+u2ca9vxHHGseXMmMrdFIim7nGcWXi0ojlgwAKDgShkkdkvH9XM1sCsC+G2
         v4cYoaHe3mjZtWYR7ahUMmAF68lxpx1qGc5k232baV8lAb7xmse9SfOpgcYbT7t2tmYO
         CrF7q1dOW1rB8OgaBVok5iaB6gJ2foEwpHkp8gM3T2PnygNaLLUxdGj4Q8Brjo2AuAVi
         bujj6yqNUuSeX8udEF2HhsPwfBJrA8TW35nNKpsbHHANZKXcaROPx4E97+Sj148Juos6
         wyHT4pLJRtidcMMTkJQhPF4ThumsStfpC1tD+oZv+eR8EeN01goravRqa20p/rxXAATs
         1IfQ==
X-Gm-Message-State: AOJu0YxV/b2t3oS+wAB2Bjy5F6ZsRjJKVn+IKEd2XfVS6uY2eOLNot9i
	SNXImllZLBhdjoTc4dwoTwK3UQ==
X-Google-Smtp-Source: AGHT+IFeDWYk883Wojm8jy2p54ggMOPcbkbi55EDKth1Vp7mJ/XvaZhuHrxFp5lxjThhcYrqApT3pw==
X-Received: by 2002:a05:6a00:d77:b0:6ce:2732:28f with SMTP id n55-20020a056a000d7700b006ce2732028fmr2489716pfv.62.1702361440440;
        Mon, 11 Dec 2023 22:10:40 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c23-20020aa78817000000b006ce358d5d9asm7560493pfo.141.2023.12.11.22.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 22:10:40 -0800 (PST)
Message-ID: <6577f960.a70a0220.31318.6027@mx.google.com>
Date: Mon, 11 Dec 2023 22:10:40 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc5-62-g5173d2be59b3d
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc5-62-g5173d2be59b3d)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc5-62-g51=
73d2be59b3d)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc5-62-g5173d2be59b3d/

Tree: pm
Branch: testing
Git Describe: v6.7-rc5-62-g5173d2be59b3d
Git Commit: 5173d2be59b3d85bac70339074548dd738fd6034
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

