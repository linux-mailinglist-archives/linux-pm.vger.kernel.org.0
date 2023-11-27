Return-Path: <linux-pm+bounces-316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71697FAD99
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 23:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DE21C20BCF
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 22:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2953EA9F;
	Mon, 27 Nov 2023 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="wp2KEdx9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D72A5
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 14:38:34 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cf80a7be0aso40677325ad.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 14:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701124714; x=1701729514; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kEbY7J3L+mkAtd3S0ZaTWPHnRWB7faqVxxNyXRWUYbQ=;
        b=wp2KEdx9NAAFb6racuice7z2kio22+wI5m8T87eE6FHdy1Vrda6Dy5nZpR9Thkyq0f
         FMHipYNK4pOdz62ip3mrMGj3H/5hUhAfc8Xe75CvrjstHELY7sK827D5U0J892HIdUPo
         ln1n7aS16HvC6PYDYX6+G3jKpSo5Phs0yq1sBC2l2+hT2FEjICFNxl6bdcrvxQSz63td
         B7jXkZEKu7m0ldloWs97SFQ10/dr4JRbwnvhXA3hmRX0JZ0q4fXilw/SMVmj53XNiG6q
         HfiZNlC7mv3qpKVQyNDKsQI7P/ikEH/qyKVIe+7emRBDdYhVGJlrXt6dqNyeLBWYqO6A
         RK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701124714; x=1701729514;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEbY7J3L+mkAtd3S0ZaTWPHnRWB7faqVxxNyXRWUYbQ=;
        b=Oqp0aD4l2g+S371I6paxbxdNtUbUEFx+qieIEY6axM5ImaHPY6ud9mtKBOSyuS0Hc6
         ZM2Lo9yf79adP2IF3bwmynska6F5WcpMUzflIDTtDvvyaNuw9oNqtuQMHPad4L6n5ZwF
         X1fIjNYiXJlT9fN+RMGW1nbAPqc+ufj93GlcvYcnvk8KB/Y8x0d03Gbx9AWUECWzR47s
         R0hb7aGSG54jErI/TRthNiy7DaBa/fpdf6+9BeDqRZF9JUby/5sN2VjLjZQ2DkYdPZaE
         xoA+Do9VRxqhZOh9D1YLSBc+wDUDIaHmsYe7ydAd46+SBytrRU+781/LRJ0Q9GnrmnhS
         zzMw==
X-Gm-Message-State: AOJu0YxKhOkOzX0zbHE38MZYuyLUiaPQytfcUZ/TpJaEl6Mmg4NQaXEi
	oPYKsd34RcwOH7kAQq9TZCRH/w==
X-Google-Smtp-Source: AGHT+IERuqU7kxgpqtWKl/jQRmt39VJ0yh4j8dETn5XNWgtZUSDdtuz0NCq7vqbaO5lfsx/SUksZTA==
X-Received: by 2002:a17:902:d489:b0:1cf:f7c3:1e32 with SMTP id c9-20020a170902d48900b001cff7c31e32mr52772plg.27.1701124714015;
        Mon, 27 Nov 2023 14:38:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 26-20020a630d5a000000b005898e4acf2dsm8161966pgn.49.2023.11.27.14.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 14:38:33 -0800 (PST)
Message-ID: <65651a69.630a0220.babae.4320@mx.google.com>
Date: Mon, 27 Nov 2023 14:38:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
X-Kernelci-Kernel: v6.7-rc3-33-g381d926a5d2dd
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc3-33-g381d926a5d2dd)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc3-33-g38=
1d926a5d2dd)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc3-33-g381d926a5d2dd/

Tree: pm
Branch: testing
Git Describe: v6.7-rc3-33-g381d926a5d2dd
Git Commit: 381d926a5d2dd2c205c9c2b7045c2c80987cf651
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

