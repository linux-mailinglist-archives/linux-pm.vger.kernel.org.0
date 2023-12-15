Return-Path: <linux-pm+bounces-1204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F415A81495A
	for <lists+linux-pm@lfdr.de>; Fri, 15 Dec 2023 14:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DC71C23C05
	for <lists+linux-pm@lfdr.de>; Fri, 15 Dec 2023 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB152DB8E;
	Fri, 15 Dec 2023 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="t4sElNh+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000D2DB86
	for <linux-pm@vger.kernel.org>; Fri, 15 Dec 2023 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6cebbf51742so451471b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Dec 2023 05:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702647222; x=1703252022; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oLGsZCDgMoXBBKy2bRzfl+/SAF+9vZzW3vWo/eXcoT8=;
        b=t4sElNh+isx1i+yuT0487ITpHZ80Ec1W8E4/mB5woIwgYObKlKEjBGvA2rmbrv958+
         FvHwdLqll6vnHxlKvDOhHM0hpr+31X8ja6FkqMIhVhjgbF9dGFHTs7No/YwIsfDfdomV
         Nd+bawXC/D0lTYcUx0adAg+ClXhupu0dzMxrCFgxBMbVmZxEE96IiqXrpsQKLzlMEOh1
         Ve1BGK3xiCCpEecK3g6HPIhn20yxlV04/8EXhSXELkbiso82tZ9WpNYQLt3A4rQm7exF
         uI+POkYY9aH4h10bIRHEzGpAam51oAUp9FuB6FJ4792szFoCACK+fwl7EV1CY9h0+ScZ
         IWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702647222; x=1703252022;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLGsZCDgMoXBBKy2bRzfl+/SAF+9vZzW3vWo/eXcoT8=;
        b=vX4WDe/6Fx7E+T3/GkImqhGWgoAEsoDJPh1bTQS5gRODG4Be4VitASt3b+lUHQitm6
         Ox+BENNMObRjq8wzxqqcHgcRqjQfN0mg9+xlFmYGoKBMONTXGklw881GaiQa0UCi/pj4
         Yp88oA5j3pzKqS8SyqfdD3Z3Po8e705wLHAur3zg+5mNOqjBBp8moHeVyrLBZy0XUH0v
         syd3YkpC/AJkEpTO5iIrbM/sxApGpFMbiqOKYPBb/ROpjF9XMyOc+MXJ9md8kH63x3+P
         BkMMehVLaS9ZRxqE8nKLwqUIjQOj9EWM0R56D0C8B0ao4r/gRZKJhOC56ggEfi8J95gx
         sLtA==
X-Gm-Message-State: AOJu0Yy6vLf9DJjnHw8kcN1TMPvyqfmF1nQfv+bd0yskoVZF4Us9lkRV
	sXgIJFFpplTM12SwTXLi5anwTg==
X-Google-Smtp-Source: AGHT+IFIED/MtqEM6IaX9IO8PrWjxNI5KAYPctSt1cJRt6+lq0dO1vZvWr4WMd70pGpCkCyLV7xKWw==
X-Received: by 2002:a05:6a00:2303:b0:6ce:945d:80eb with SMTP id h3-20020a056a00230300b006ce945d80ebmr16430243pfh.2.1702647221049;
        Fri, 15 Dec 2023 05:33:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o3-20020a655203000000b005c68e0c83a6sm11636580pgp.43.2023.12.15.05.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:33:40 -0800 (PST)
Message-ID: <657c55b4.650a0220.f9a07.1dd7@mx.google.com>
Date: Fri, 15 Dec 2023 05:33:40 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc5-91-g3b6de08083e1f
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc5-91-g3b6de08083e1f)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc5-91-g3b=
6de08083e1f)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc5-91-g3b6de08083e1f/

Tree: pm
Branch: testing
Git Describe: v6.7-rc5-91-g3b6de08083e1f
Git Commit: 3b6de08083e1f132679a930ff88ecea6d992fe75
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

