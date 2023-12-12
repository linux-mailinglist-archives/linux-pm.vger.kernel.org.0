Return-Path: <linux-pm+bounces-990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEA680F364
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 17:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0EC28142B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 16:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D311278E98;
	Tue, 12 Dec 2023 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="U8lqp5tZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2FC112
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 08:42:29 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c6ce4dffb5so2948932a12.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 08:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702399348; x=1703004148; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TmSuMwW9z0NfQ/MRD27NLKc5SsZ6f4CUuZJ/fdf42bw=;
        b=U8lqp5tZ5r/A0fA2rxNbqXQvFSE+FEsC2pDoVrtdeRJlfgeIa6awswyt66Tmp7xhoW
         bpNjPzNtj6Gzpk7rho+lTw0kNiZNu4G9PGaNYI//rAlMWPwkV6B/Y9rYDMKZIJrV4l67
         yACth5MbS6nVFRw5pSj8nBEE+b3yzN2wj7gDQCB8hFoHx3L8FO5koQ1IDEkS9GQJY2ow
         kGYGymiFaaC4Pl9YTgsljvVjT6RSbwWZgMcYWtx4dRnoOm9mKjvtkIAXN5MKwj3y2iX3
         22c4z43v7oORDkGUU/aRrwyvCF6R+Tmi1uwn0tZLCoVq7oTXl4f1C4URuKjIMB5FCxbF
         AqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702399348; x=1703004148;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmSuMwW9z0NfQ/MRD27NLKc5SsZ6f4CUuZJ/fdf42bw=;
        b=o0IOIIVQH2LKsNHmbhpj4F18BlQ5y3ekWe1S6sGzMtpoNqPga7GSBNZlcekxs2YWnk
         foXNUyY6Cr+WgJ62TyPNvLI4cUILdR1yoFFzApjDNK67wEocACLeJWGn/D9ZfnzlMWRI
         ziEKfFc24itSorbhSKfyGeOcb4+MuY8a332uJhzCBa5hBA48SrzsRHZ/9xapxXQQs2fc
         F4DwWGgi2XavxopnVCzlvIm4leMdSpfl+FCmPlvtMAG0saKrQ0Cdj6QO2h/diBSJH5MS
         MF7RSaUxh/vvCVEQ93LMDSuOe/wclpYIVgDS6c2yxRQpelRZMWQmSgfaWZM0W/Ap1/9Z
         p8Nw==
X-Gm-Message-State: AOJu0YxJJsipv7n2p9BaliPwJrnMbunrd/05poUA5crBoU5GJ4gGU7sw
	npmvgE46U9qCYoAenqPuE6cccg==
X-Google-Smtp-Source: AGHT+IH703I1+pVrSHQREopqFOHplH0sPVMX3uNv1UDMJeBA6vXsaXDSPL9a4r1LEWyHIp7irwgnuQ==
X-Received: by 2002:a17:90a:6607:b0:285:a163:c25b with SMTP id l7-20020a17090a660700b00285a163c25bmr3374854pjj.5.1702399348318;
        Tue, 12 Dec 2023 08:42:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id pa8-20020a17090b264800b0027df6ff00eesm9349353pjb.19.2023.12.12.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:42:27 -0800 (PST)
Message-ID: <65788d73.170a0220.dcd24.bafc@mx.google.com>
Date: Tue, 12 Dec 2023 08:42:27 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc5-71-g15c1f7c6e0578
Subject: pm/testing build: 8 builds: 0 failed, 8 passed,
 4 warnings (v6.7-rc5-71-g15c1f7c6e0578)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 8 builds: 0 failed, 8 passed, 4 warnings (v6.7-rc5-71-g15=
c1f7c6e0578)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc5-71-g15c1f7c6e0578/

Tree: pm
Branch: testing
Git Describe: v6.7-rc5-71-g15c1f7c6e0578
Git Commit: 15c1f7c6e0578df001fc5972e1cb64a6b306c3a1
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

