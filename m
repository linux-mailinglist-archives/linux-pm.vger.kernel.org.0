Return-Path: <linux-pm+bounces-10900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F3D92C7FB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 03:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B297B21408
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 01:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF70C10FF;
	Wed, 10 Jul 2024 01:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="udR0wP7T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3D5CB8
	for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2024 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720575258; cv=none; b=TFSrcPyeVvAYCS5LwUsAKNkPa7LTZb6mgX+viPTvqDWH//+xGLCMYeAke4vVHB9YqxCKEe9aM6uXCnhwuoMM1zE4lwExfsdpC2hFz1eFNskLVk3tIU2G3rfyQvccCrKurMlDksCtFxLIfInBlOeWTjuVYsmlE76fR2H1uh/52O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720575258; c=relaxed/simple;
	bh=ldeuoc7v8GrRu6PJEgWUzqhA9hGwmeELxMXSbyehjhQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:Subject:To:From; b=F+ibjE6URYi4ADR0EPmmWNYY7ZhCFOTHCLEvEBe2r7ZdreFicJMSaqwNBIpUJ3H2YZEehPHCYLo9nnGL69BnVjrR29+FzfL/fMF6jiktwMKrYCwdCyyKsvzrjkifbB7ZVY0p88knRcn3QvOqdItO6dzdF+qsn0a293bEwdJQm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=udR0wP7T; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-375f713a099so21319665ab.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 18:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1720575256; x=1721180056; darn=vger.kernel.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i06YfrhxXFXKJ0o/MddqS2E4l+TdpaD0POisD3yKlyE=;
        b=udR0wP7T58tIlTubTuex0NtoIE3v8wCyHZpcdFb6QWLHFB4nMqSqmdRWEbkevKYle1
         NKlif2VXBOYbtNHhKHqC/B9KJ9JHdQFErmxkaGEoxEmB2kNrwvRIawfPLiFzNczW4wWo
         AJfsdEUo/ueVY2OTNjKVfc6OiP8X7TM7REWsfWgnVeXkBxyOeZH+aNginqFJLE0CmYVu
         PR7sJ+mCij1REc08y1i+yYQyBcRbsbHMI2f9cc3piHdLTyvT4Vplu6yW7HmgpX1AYa9B
         jTblF/d3YImRibHwepHUtpHuMFhAcLFn90kaIC0XX1Qu2En+gN9O8p0ywkrTkSST2w+P
         jhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720575256; x=1721180056;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i06YfrhxXFXKJ0o/MddqS2E4l+TdpaD0POisD3yKlyE=;
        b=go2XM3F7c9Y++w3JATKUQxIrIwRP08ihARMc1OoWEFpa3RNdFhI3jyVY9+0yrnYb5U
         hcBdxpXnSbLNdCLBRCzF0Vu04LvUpQVVLnqgGJ2TTJvBIHMu47DritDZcx1nfa801lvK
         hghsJ79WAmXCwLYYXNAgTK8ulw5pcBxJGQHJ9catkrgxUvJZYg36eO0D4sPhlUcBBMD4
         m1tqt/4v8SIPIc9eEyyQHw8SMaUnVUh2PLfMjquF0da1URVeHMuEyhJvs2ap5E/UpmNx
         06L3627JemcSXqCGQ30a4GDdJWXWaaqrpkICck1QYnRZY9hsdlvWrL3PtDZlrLYxRLt0
         AnlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSSwygMfc+B84RKm9c14z6+cXyGZs6Xa4nsAMGa4IeSZuYr/xKe/7TEjiojin/PEXEeHyrTD2N39h9H6wTPw3mA6iZG5Nu+s8=
X-Gm-Message-State: AOJu0YyzZyP9vFNLjM+QGZu0WTFssggQfjkSEHRJVhfoyENL7tkqOG3B
	XAcN4AqdmadW7RqCPzxKn+sjYIJZmQ/eX6yOuPbtiCr0WYTWIcyjNeqCk0aLelI=
X-Google-Smtp-Source: AGHT+IFS0UHhZpvraDainCEvnEPHQzGsFck6SfsVUhGphAIpMZOsxGfJ0ee2QIpimXWs/mjhJcOqRA==
X-Received: by 2002:a05:6e02:19cc:b0:375:a282:c96b with SMTP id e9e14a558f8ab-38a598b39demr44696035ab.27.1720575255987;
        Tue, 09 Jul 2024 18:34:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b0401sm2575435b3a.170.2024.07.09.18.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 18:34:15 -0700 (PDT)
Message-ID: <668de517.050a0220.467c1.c7a3@mx.google.com>
Date: Tue, 09 Jul 2024 18:34:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.10-rc7-171-g72d2d9b52a2d8
X-Kernelci-Report-Type: build
X-Kernelci-Branch: testing
X-Kernelci-Tree: pm
Subject: pm/testing build: 1 build: 0 failed, 1 passed,
 16 warnings (v6.10-rc7-171-g72d2d9b52a2d8)
To: rafael@kernel.org, linux-pm@vger.kernel.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>

pm/testing build: 1 build: 0 failed, 1 passed, 16 warnings (v6.10-rc7-171-g=
72d2d9b52a2d8)

Full Build Summary: https://kernelci.org/build/pm/branch/testing/kernel/v6.=
10-rc7-171-g72d2d9b52a2d8/

Tree: pm
Branch: testing
Git Describe: v6.10-rc7-171-g72d2d9b52a2d8
Git Commit: 72d2d9b52a2d897a42ac5e306d3d7b12d584f589
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
Built: 1 unique architecture

Warnings Detected:

sparc:
    sparc64_defconfig (gcc-12): 16 warnings


Warnings summary:

    2    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version genera=
tion failed, symbol will not be versioned.
    2    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [=
-Wcpp]
    1    sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso32/vdso-note.o:=
 missing .note.GNU-stack section implies executable stack
    1    sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso-note.o: missin=
g .note.GNU-stack section implies executable stack
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

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
sparc64_defconfig (sparc, gcc-12) =E2=80=94 PASS, 0 errors, 16 warnings, 0 =
section mismatches

Warnings:
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
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
    sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso-note.o: missing .no=
te.GNU-stack section implies executable stack
    sparc64-linux-gnu-ld: warning: arch/sparc/vdso/vdso32/vdso-note.o: miss=
ing .note.GNU-stack section implies executable stack
    arch/sparc/prom/misc_64.c:165:5: warning: no previous prototype for =E2=
=80=98prom_get_mmu_ihandle=E2=80=99 [-Wmissing-prototypes]
    arch/sparc/prom/p1275.c:52:6: warning: no previous prototype for =E2=80=
=98prom_cif_init=E2=80=99 [-Wmissing-prototypes]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.
    <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
    WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation =
failed, symbol will not be versioned.

---
For more info write to <info@kernelci.org>

