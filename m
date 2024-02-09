Return-Path: <linux-pm+bounces-3680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8703384F4D7
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 12:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95331C21324
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 11:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043634689;
	Fri,  9 Feb 2024 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="f8E2HzCR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395E33CCC
	for <linux-pm@vger.kernel.org>; Fri,  9 Feb 2024 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479488; cv=none; b=lPthcHC5oVBY9KoOmpnov8nR24AK3XOGhywMOJ232sQ8ZZh6fekE43t6r9J4LMvM04QJJekd/jUo/GUcPA9r6lQHI8GgJYJiBRMwTPQUsxXQPvl+GDvZS7jauubdHmIIN5ce0rx8Fkg7+QW/AGBpRseIWcJjYy9VS1iohOvqD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479488; c=relaxed/simple;
	bh=YnEB0ALLodxyMA/F9eswuLP6u3Wg0T8+sHFSbKkLYyU=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=f2ZeMWR7j05UM1a4KpORznBUf8DwJwpAikgCHcQSXYeLE5DMPad1ssaptuTczYI6IDKKYLOs02VW0gO9jMI32yZepQhn9aalLkxR1peInOREWRPfywj+rp6rlFXKZQINaXPtBXSER5RQ8CQRAeKNGZ8rUOPHoQp31D8yMv+7Q0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=f8E2HzCR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e0944e909eso164710b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Feb 2024 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707479486; x=1708084286; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tG+0FqXl9zVNoFzL9MfpguVvxHf/EAXXHVtNIjqwCDM=;
        b=f8E2HzCRbO7wmt/7pMq4tJGmel/ucLIuW3BuJTYjC0FaWeXD/edayy66ErhBNucjm6
         a0tO5xTUT4Jo3afvqKPfIgEKcDkkIQi40Sd4/CKrhqtMLgm2NeZ9yfS3iy9QYNYpGar0
         fMe7ftqkeEo9wxi/7eTnMb4MPGrzMX9/vJrgLUujGAvkyW62wl30kfmkPHflhBg0ttxy
         lOzV4PuhNmu51ajYNXzkGfH358rctCKl7KnF4MLFohcI4H8C5WsifBakCLxcb926/hfJ
         6sbXAt/Na4+k7YYPbQ/pWNeyCCtFKQOz+hiuXOIcoQcy1mF/tEinOmCAVAEiC9D60Xkr
         L4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707479486; x=1708084286;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tG+0FqXl9zVNoFzL9MfpguVvxHf/EAXXHVtNIjqwCDM=;
        b=Di0lbUe49m1i+cqRaBRbsZjJRk1m7zuMjKGtWMTpv+2AQggOhK6wDKsaEUXASiUNGx
         9p5f8cyp46G6ocuv3zTt02H7sF3sS+hMTo6uvC83v9J/C9K5FMfCmlMLwSJr4WYYymTi
         MvhCfOEnwggiVlAojKP7XBSBfZysph/yW0oZD8yipHnkacwqWPrwxQcMhx7N0AAnRD2B
         iZtAbDlrcXu7tvWriFHHhqhXx6OJlpEVl9xmbY0aAC9iYuhIWeeSwHVVgWfyp4o6SGc2
         CpxvCi89TEMMEe444rjzTttJWrPv7bAC6b3Q6LIWRO3WHzB0BR8RXHsWEDB09fCD/Ggh
         vkGQ==
X-Gm-Message-State: AOJu0YwVCCw/0a/4VkbElPau7+ZPO59xEIp+qm/DA++8FezZPqiKpiCO
	zWDH30uTcwg5LGfXpOmj/FPrmopi6FONC2cEvqbv/InI4b1yF7IcTi4u3BvycoI=
X-Google-Smtp-Source: AGHT+IH7tDxGENZVp72tOodjn1UKvTstTxy0Go0hfubQt1npui5jY2tUHKM5hKiQfU7nGLkL9cBH9w==
X-Received: by 2002:a05:6a20:9392:b0:19a:4e56:d81b with SMTP id x18-20020a056a20939200b0019a4e56d81bmr1476858pzh.27.1707479486211;
        Fri, 09 Feb 2024 03:51:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYdsrhf45KSkOz8aB7wAJscd6RTKIY4iVpTk5cPQVKPut240U/JN/UUNbWkk9DmK7bcfU8uaxnwdggwft/eAGTQ2RsJcByk7Q9KuZ7vpbarufXCmZr6D45Pz8Lg6BTMoEYXjeDYeTpf0EZgNV3iZPYvzTLLqaqB+zLV1rmELWVvx4Nh9X2QuwikhoL
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y63-20020a62ce42000000b006e048853e1esm282340pfg.215.2024.02.09.03.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 03:51:25 -0800 (PST)
Message-ID: <65c611bd.620a0220.a3877.0a91@mx.google.com>
Date: Fri, 09 Feb 2024 03:51:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: pm
X-Kernelci-Branch: testing
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v6.8-rc3-33-g0ef1b1ae082a1
Subject: pm/testing build: 3 builds: 1 failed, 2 passed, 1 error,
 27 warnings (v6.8-rc3-33-g0ef1b1ae082a1)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 3 builds: 1 failed, 2 passed, 1 error, 27 warnings (v6.8-=
rc3-33-g0ef1b1ae082a1)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
8-rc3-33-g0ef1b1ae082a1/

Tree: pm
Branch: testing
Git Describe: v6.8-rc3-33-g0ef1b1ae082a1
Git Commit: 0ef1b1ae082a1631e8658a6b771aaa2816faea6b
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 3 unique architectures

Build Failure Detected:

x86_64:
    x86_64_defconfig: (gcc-10) FAIL

Errors and Warnings Detected:

arm:

sparc:
    sparc64_defconfig (gcc-10): 26 warnings

x86_64:
    x86_64_defconfig (gcc-10): 1 error, 1 warning

Errors summary:

    1    security/security.c:810:2: error: =E2=80=98memcpy=E2=80=99 offset =
32 is out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    1    cc1: all warnings being treated as errors
    1    arch/sparc/vdso/vma.c:246:12: warning: no previous prototype for =
=E2=80=98init_vdso_image=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: warning: no prev=
ious prototype for =E2=80=98__vdso_gettimeofday_stick=E2=80=99 [-Wmissing-p=
rototypes]
    1    arch/sparc/vdso/vdso32/../vclock_gettime.c:307:1: warning: no prev=
ious prototype for =E2=80=98__vdso_gettimeofday=E2=80=99 [-Wmissing-prototy=
pes]
    1    arch/sparc/vdso/vdso32/../vclock_gettime.c:282:1: warning: no prev=
ious prototype for =E2=80=98__vdso_clock_gettime_stick=E2=80=99 [-Wmissing-=
prototypes]
    1    arch/sparc/vdso/vdso32/../vclock_gettime.c:254:1: warning: no prev=
ious prototype for =E2=80=98__vdso_clock_gettime=E2=80=99 [-Wmissing-protot=
ypes]
    1    arch/sparc/vdso/vclock_gettime.c:343:1: warning: no previous proto=
type for =E2=80=98__vdso_gettimeofday_stick=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/vdso/vclock_gettime.c:307:1: warning: no previous proto=
type for =E2=80=98__vdso_gettimeofday=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/vdso/vclock_gettime.c:282:1: warning: no previous proto=
type for =E2=80=98__vdso_clock_gettime_stick=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/vdso/vclock_gettime.c:254:1: warning: no previous proto=
type for =E2=80=98__vdso_clock_gettime=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/prom/p1275.c:52:6: warning: no previous prototype for =
=E2=80=98prom_cif_init=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/prom/misc_64.c:165:5: warning: no previous prototype fo=
r =E2=80=98prom_get_mmu_ihandle=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/mm/init_64.c:2644:6: warning: no previous prototype for=
 =E2=80=98vmemmap_free=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/uprobes.c:237:17: warning: no previous prototype=
 for =E2=80=98uprobe_trap=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/traps_64.c:253:6: warning: no previous prototype=
 for =E2=80=98is_no_fault_exception=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/traps_64.c:2153:6: warning: no previous prototyp=
e for =E2=80=98sun4v_nonresum_error_user_handled=E2=80=99 [-Wmissing-protot=
ypes]
    1    arch/sparc/kernel/traps_64.c:2035:6: warning: no previous prototyp=
e for =E2=80=98do_mcd_err=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/time_64.c:880:20: warning: no previous prototype=
 for =E2=80=98sched_clock=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/setup_64.c:602:13: warning: no previous prototyp=
e for =E2=80=98alloc_irqstack_bootmem=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/pci_sun4v.c:259:15: warning: no previous prototy=
pe for =E2=80=98dma_4v_iotsb_bind=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/adi_64.c:299:6: warning: no previous prototype f=
or =E2=80=98del_tag_store=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/adi_64.c:156:21: warning: no previous prototype =
for =E2=80=98alloc_tag_store=E2=80=99 [-Wmissing-prototypes]
    1    arch/sparc/kernel/adi_64.c:124:21: warning: no previous prototype =
for =E2=80=98find_tag_store=E2=80=99 [-Wmissing-prototypes]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
sparc64_defconfig (sparc, gcc-10) =E2=80=94 PASS, 0 errors, 26 warnings, 0 =
section mismatches

Warnings:
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    arch/sparc/kernel/traps_64.c:253:6: warning: no previous prototype for =
=E2=80=98is_no_fault_exception=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/traps_64.c:2035:6: warning: no previous prototype for=
 =E2=80=98do_mcd_err=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/traps_64.c:2153:6: warning: no previous prototype for=
 =E2=80=98sun4v_nonresum_error_user_handled=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/setup_64.c:602:13: warning: no previous prototype for=
 =E2=80=98alloc_irqstack_bootmem=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/time_64.c:880:20: warning: no previous prototype for =
=E2=80=98sched_clock=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/adi_64.c:124:21: warning: no previous prototype for =
=E2=80=98find_tag_store=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/adi_64.c:156:21: warning: no previous prototype for =
=E2=80=98alloc_tag_store=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/adi_64.c:299:6: warning: no previous prototype for =
=E2=80=98del_tag_store=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/pci_sun4v.c:259:15: warning: no previous prototype fo=
r =E2=80=98dma_4v_iotsb_bind=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/kernel/uprobes.c:237:17: warning: no previous prototype for =
=E2=80=98uprobe_trap=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/mm/init_64.c:2644:6: warning: no previous prototype for =E2=
=80=98vmemmap_free=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vma.c:246:12: warning: no previous prototype for =E2=80=
=98init_vdso_image=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vclock_gettime.c:254:1: warning: no previous prototype =
for =E2=80=98__vdso_clock_gettime=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vclock_gettime.c:282:1: warning: no previous prototype =
for =E2=80=98__vdso_clock_gettime_stick=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vclock_gettime.c:307:1: warning: no previous prototype =
for =E2=80=98__vdso_gettimeofday=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vclock_gettime.c:343:1: warning: no previous prototype =
for =E2=80=98__vdso_gettimeofday_stick=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vdso32/../vclock_gettime.c:254:1: warning: no previous =
prototype for =E2=80=98__vdso_clock_gettime=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vdso32/../vclock_gettime.c:282:1: warning: no previous =
prototype for =E2=80=98__vdso_clock_gettime_stick=E2=80=99 [-Wmissing-proto=
types]
    arch/sparc/vdso/vdso32/../vclock_gettime.c:307:1: warning: no previous =
prototype for =E2=80=98__vdso_gettimeofday=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: warning: no previous =
prototype for =E2=80=98__vdso_gettimeofday_stick=E2=80=99 [-Wmissing-protot=
ypes]
    arch/sparc/prom/misc_64.c:165:5: warning: no previous prototype for =E2=
=80=98prom_get_mmu_ihandle=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/prom/p1275.c:52:6: warning: no previous prototype for =E2=80=
=98prom_cif_init=E2=80=99 [-Wmissing-prototypes]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    security/security.c:810:2: error: =E2=80=98memcpy=E2=80=99 offset 32 is=
 out of the bounds [0, 0] [-Werror=3Darray-bounds]

Warnings:
    cc1: all warnings being treated as errors

---
For more info write to <info@kernelci.org>

