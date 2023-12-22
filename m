Return-Path: <linux-pm+bounces-1544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC4481C347
	for <lists+linux-pm@lfdr.de>; Fri, 22 Dec 2023 04:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0E41F25486
	for <lists+linux-pm@lfdr.de>; Fri, 22 Dec 2023 03:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0190EB8;
	Fri, 22 Dec 2023 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Ks0zm/lR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52625468B
	for <linux-pm@vger.kernel.org>; Fri, 22 Dec 2023 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d2f1cecf89so9086205ad.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 19:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703214453; x=1703819253; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WSYtQPXKWBhiP2AKDbvLSpER0DB4mRWZjOJMYq33N0I=;
        b=Ks0zm/lR6J0RKxbICuYx9S5X89IwtylJCNWMAy4/R/uL04t/sUBN2YBaZFt1Qq7lIK
         EIBmqgmCLPWBVZoyLuIBZyIOVuSKAfnNAoWxM1yzmz/M5el3arj9tWAGA7atYNtIFWx+
         gsvvY0BIp2ufgWfegSZnwwkjl0pDzSLmJor3dRsDIOYNBbHzaDHluqnsrAv9zlFhLsPZ
         yQuGcKYMsQ+KKH9P/Jgt8Ev49UDJxS/qSxnAFcyRJafoXtu2QWOsCcRBhvBzw4ZbexXe
         8AseLKlWlMryt0eLZdfkd62HjVGhIbuTJY62MyS3d7k2Zs8WnXWdVQyEXEhNrhhTbniH
         BRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703214453; x=1703819253;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSYtQPXKWBhiP2AKDbvLSpER0DB4mRWZjOJMYq33N0I=;
        b=ltlIuxSVJSUv4nEtAZ0JO7RFnvwrOcrby+uYQ73h34/ckYRyhYSb4uTd5EVhlWs+kR
         TVgpA8VY/j424gOHvJsd98qhe0XoYtU6S7LAqr3HRBufldmsWPRK76S0KGBjkrbSoUmB
         7MJQ2wwmbpmD8ApYcl+4W9rprBksnEtA9PcoRvkQQPh3Clnq1n7e7MPpCNT4UdxPG1ZB
         fGNSPp0WGHXaMH40CrFBWW2i8RiR3J58wqGEw9rO8nDlIJs+tEznZ3OhBLxP2IALK0t+
         IjQk2/K4rq9HgH6JWgnja0C0/BCqnbjpYgICzuP6lJnUt1B5pZALVn24Zo/Z2JTUg7Mz
         Gk1g==
X-Gm-Message-State: AOJu0Yzg49B0jmsU/1htROkV9aSpM6vjVMaLvLIoieCf3smLmTl4kPmM
	t5ywQ1EoVXxPe7mQnMOyH2r6CEvhi5b3jDksTpVS3gTkOcA=
X-Google-Smtp-Source: AGHT+IG6h4tSzY9pH5CIisoj7YKbFzwXkEHuweBDFPezQF5Jh+5CqRHUUU2p3IYDu4E4L8bD/n0Qvg==
X-Received: by 2002:a17:902:bd81:b0:1d3:39fd:9043 with SMTP id q1-20020a170902bd8100b001d339fd9043mr477743pls.13.1703214453588;
        Thu, 21 Dec 2023 19:07:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bh10-20020a170902a98a00b001d4160c4f97sm569178plb.188.2023.12.21.19.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 19:07:33 -0800 (PST)
Message-ID: <6584fd75.170a0220.b461d.3201@mx.google.com>
Date: Thu, 21 Dec 2023 19:07:33 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc6-100-g6a473ae3ce709
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc6-100-g6a473ae3ce709)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc6-100-g6=
a473ae3ce709)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc6-100-g6a473ae3ce709/

Tree: pm
Branch: testing
Git Describe: v6.7-rc6-100-g6a473ae3ce709
Git Commit: 6a473ae3ce709c1b9fb544f105559f195814535a
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

