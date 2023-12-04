Return-Path: <linux-pm+bounces-684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCA1803A1F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 17:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41ACF1F20D44
	for <lists+linux-pm@lfdr.de>; Mon,  4 Dec 2023 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2F12DF83;
	Mon,  4 Dec 2023 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cQumsgbF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F44AAC
	for <linux-pm@vger.kernel.org>; Mon,  4 Dec 2023 08:24:56 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cdea2f5918so2942609b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 04 Dec 2023 08:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701707096; x=1702311896; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jwwpKMkPfQF8wyCmEPWsGJOwEJpZgOYWgThBEJcmCAI=;
        b=cQumsgbFaUiM4fHU7g/CtzTrnKdBDEAD9HNiETFYxJ+fyPkxsxFouzR2vQkpwS8oFV
         EB8S0QZxGOHk5+JEyKDggamY6qanvkGdJVRYhc5UFh8OMUiJyYfm13y5moPRlgG+hUrj
         zcA+kySH0+aq9rIeE1m18A+zPoLiJx2uQcepT+sUKo2sVoO32KT1oa2ceIHIqa2McCUG
         3X5vu26VcvpxCaFFClGuUPW9jUO+eb8LLMk/lO08+nTvcykrKqVKpo/Fd53F+ZckhkcU
         dnda/nzSDQmHZi69BZ8wYnQrQrIUZlhr6gmK1OAp0nROrgySSxGAoecasUdueLsyLJ0x
         p53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707096; x=1702311896;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwwpKMkPfQF8wyCmEPWsGJOwEJpZgOYWgThBEJcmCAI=;
        b=IJarjgg377YCxjIQpnrjiYIWtTqSJclsljA8LONklCR+EYBvSroU+3VsowQw6yHFP3
         GAR04cozPT451tLqb4sHmrWOjC2cpbJ62rH/m/EvrpndGuPxgbfyPz0jzmoxE2LPNFoT
         kxUaG3Mynv6N6u0W0jXLeIZHZB8mm6NQU26+EWSzNhe1WO3wu1ZZ/2IWkZ5B3G5/2xrZ
         1xUKzjQTggXAP0dpU+CC0710jcQgRI13v1f14wKQvATC1MJY2FJczD/4JAs18dZloExf
         tmxwjm5c8JH1SPHjfFox8gT6VrQ7cmZ8Q9Qy1/KD+xZO4D0bezdwCgDIf6G/jzEGoSOT
         l9ig==
X-Gm-Message-State: AOJu0YyYBlGIvkHT/gXR+WfDE9UkarcEIq7q0jsJysHZgjk3QAwCx5ZP
	v6O5XSAHFVUBxkpqi8AI8c068DToix8Gbaod6KN3uA==
X-Google-Smtp-Source: AGHT+IH0pbY6GJyKjjgk7w33U0fuIq3DjGdQgRUWXjaMQewsWvKBsut+DpZeg06R0lF5G0S9ilGG0w==
X-Received: by 2002:a05:6a00:b46:b0:6ce:2731:7a06 with SMTP id p6-20020a056a000b4600b006ce27317a06mr1508026pfo.60.1701707095930;
        Mon, 04 Dec 2023 08:24:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d3-20020a631d03000000b005a9b20408a7sm7752492pgd.23.2023.12.04.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:24:55 -0800 (PST)
Message-ID: <656dfd57.630a0220.7fd5a.5ab6@mx.google.com>
Date: Mon, 04 Dec 2023 08:24:55 -0800 (PST)
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
X-Kernelci-Kernel: v6.7-rc4-42-gded74510ac4ba
Subject: pm/testing build: 7 builds: 0 failed, 7 passed,
 4 warnings (v6.7-rc4-42-gded74510ac4ba)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 7 builds: 0 failed, 7 passed, 4 warnings (v6.7-rc4-42-gde=
d74510ac4ba)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
7-rc4-42-gded74510ac4ba/

Tree: pm
Branch: testing
Git Describe: v6.7-rc4-42-gded74510ac4ba
Git Commit: ded74510ac4ba22b6c9d4731a869c22b4eb31acc
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

