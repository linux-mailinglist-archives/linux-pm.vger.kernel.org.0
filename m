Return-Path: <linux-pm+bounces-1568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE70681CECB
	for <lists+linux-pm@lfdr.de>; Fri, 22 Dec 2023 20:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933DE1F2371B
	for <lists+linux-pm@lfdr.de>; Fri, 22 Dec 2023 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D90F2C1A1;
	Fri, 22 Dec 2023 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="F1QZ/x32"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5382C84B
	for <linux-pm@vger.kernel.org>; Fri, 22 Dec 2023 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3f2985425so12763165ad.3
        for <linux-pm@vger.kernel.org>; Fri, 22 Dec 2023 11:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703273817; x=1703878617; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Nm4XRlcF8S+NUPa7q/MYsPf+z9SUoo9lKAcdHXD9ck=;
        b=F1QZ/x32Az7liKmkxeJz9CgpDsTK1MI3V8u0Lc9eJXyzAiI3QFO0WY0K3GsPhQ0IQr
         SkjCWYe0OpU7MYWUyVcx3h4DwEudM0ZKLsbB6EtslxzvJHv5uvSoF8f0QSyq5+hVPiEe
         4OzmxvoQ5LzNBvh4UTx01wmZD/reEDHinPAiXNTRiFn8cPjiW6b2mIkcF3dRNm42HgZ4
         MIefJUWp09p3MCkDDRoICYGYoiUomtAh/PqbmlC+wR+8jlt6Oa9w2VbWEiCh/wQ+PYwT
         1VBgE7cSN13mVnQMLNOiJWYLn6+UatDcQxwtIxEbJm4GyPFLFz1N5S8xt+4GoZgPqGaR
         iBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703273817; x=1703878617;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Nm4XRlcF8S+NUPa7q/MYsPf+z9SUoo9lKAcdHXD9ck=;
        b=rj6LSmphVbV/9ZBYA28u5OZom1F9FZuxXmJ8Cd0TtWWjgCoMKI8LnlMIb0Llje7S5X
         eg2tO4c0RGWhOP9PK1K+xB8gMYjfE25eMUJ5zkm37mFBqCjdJoHlfzzdmP0U9iEdhhDt
         P9UXKJ0wAjT6DyvYETXDyWSs8AXT3W/hyAKc97L4i61k/PIs/2rKkTXjIjMbxYD3cqPY
         Vn5/3EbXd02eu8AMU2+HXAmhWCkhDzW7WBO2sV0hJWIg/En4xS2BVNPZ552UcLE8XFQx
         j0dQ5uAbiprj6niPKJYKjN2unB+D3r4dpVWAH3HkxzkaWxZ0MuVSlSvFeMg43LRgjsXi
         D7Cg==
X-Gm-Message-State: AOJu0YyhrWbp60/eNFRrf5GQdPsaMQF8iYL0OK/aR4n4iwby3SH3c5iH
	QzsSo2pPA0JnVWLbZTG40QHGj4LHFZhn2iobFLSoU3xHc3o=
X-Google-Smtp-Source: AGHT+IEJvINsi/llX4EtIIWu+gd7mmeNrRwiPDrR9mqKEcnqfwGDUuUmsMmjGPRhHsehHmgFGYUmGQ==
X-Received: by 2002:a17:903:11cd:b0:1d3:6411:73cf with SMTP id q13-20020a17090311cd00b001d3641173cfmr967344plh.112.1703273817442;
        Fri, 22 Dec 2023 11:36:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v7-20020a170902b7c700b001c9c5a1b477sm3791542plz.169.2023.12.22.11.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 11:36:56 -0800 (PST)
Message-ID: <6585e558.170a0220.1ecf1.cd71@mx.google.com>
Date: Fri, 22 Dec 2023 11:36:56 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc6-104-ga120e0487dc9d
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc6-104-ga120e0487dc9d)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc6-104-ga=
120e0487dc9d)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc6-104-ga120e0487dc9d/

Tree: pm
Branch: testing
Git Describe: v6.7-rc6-104-ga120e0487dc9d
Git Commit: a120e0487dc9d19cd669176373e5da5d987f88d8
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

