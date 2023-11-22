Return-Path: <linux-pm+bounces-87-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD3F7F4BE8
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 17:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2673D281079
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 16:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA81857890;
	Wed, 22 Nov 2023 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Zk0338VW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D912892
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 08:05:59 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cf63ca9b1bso25780855ad.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 08:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700669159; x=1701273959; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3sz9ZrvxzKKpNgkvWhW8D6VZSV6iZtontIMsmhXVEwM=;
        b=Zk0338VW1diEvPafxMjmBzbkRAfo0IEV5LKbC8FAiwkrrhOypn9ZqN5yVZ2nREZp7I
         gXNwp6vHHyAJhJ/Bx3OrkksXDTagxMqegufTmf5ZfE5PQrn5Kgy/n+MlEKbZrDg/aEPY
         hyAwSlkpwaZ5Tw0TGXk3EudsawidNponx2zHAtygQjirk9iwB+SPjKs2pXNtBAS+pch6
         Xk3kbOcmjmW/6DWjTUCC1RSFxq7Rw9K6R6sXE9wp/LduI7Xs0Ppm7UHtuncAFkT0FFIP
         NleqPMHk7W4CIcQZqhCV/7yTpDd+3RSDpY6dkGsLfY39bZsTKqvpFqz8/E1llveFwKj6
         BsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700669159; x=1701273959;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sz9ZrvxzKKpNgkvWhW8D6VZSV6iZtontIMsmhXVEwM=;
        b=RU3idi3Z3NU/eL4jfw1f9qBdpjj7aK9hgS9fibc5sWHOqZc/fSOxhzBZylJWzpuGBC
         khO5n8dEPaR+hTj9Z4WK4+B9GlxUlW9h6Psg/a6HlNlzdgvH2fZRcTWdhe58M4/Iuzes
         t/RCXKNIX+NNOVn+gP7EIJBvr+ireO+FWRya779pDrGMWQ7ni9PkGP0F1Xe+XqMCOrGv
         GARuiK8LTK5kEc7DzBXFhiGW+TMy9hAxnB2mmVwBv/zENn5knjc7yo2YyNT5nPVcQ4R5
         SEh/jXPhq7l385CGkFQnKfSLNeHOdGy125tLQiW9VkY05KYTFANoWbtS0fEbUAtSCwWt
         oVjg==
X-Gm-Message-State: AOJu0YwKuKz6zn0YkYiYCRx+fE2CRSbVLXQ1e6p7+miRqRKECVQIrpIl
	soiuu+ja6rf31NKKAqok3NdazQ==
X-Google-Smtp-Source: AGHT+IEA0wTVBvZ7sLuN5OneLNM8PikSGFwMUG0OabiO641KS+CJQeU6aCUNs+ireGVUkeTlZPMRwQ==
X-Received: by 2002:a17:902:d34d:b0:1cf:6de1:699c with SMTP id l13-20020a170902d34d00b001cf6de1699cmr2917872plk.53.1700669159273;
        Wed, 22 Nov 2023 08:05:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001cc46240491sm9927495plh.136.2023.11.22.08.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 08:05:58 -0800 (PST)
Message-ID: <655e26e6.170a0220.cbcd7.b89e@mx.google.com>
Date: Wed, 22 Nov 2023 08:05:58 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc2-30-gd0c8835944e4
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc2-30-gd0c8835944e4)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc2-30-gd0=
c8835944e4)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc2-30-gd0c8835944e4/

Tree: pm
Branch: testing
Git Describe: v6.7-rc2-30-gd0c8835944e4
Git Commit: d0c8835944e426a4a3d51eb8c49b0f64a10d3824
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

