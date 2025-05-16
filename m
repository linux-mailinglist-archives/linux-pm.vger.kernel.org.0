Return-Path: <linux-pm+bounces-27255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4872ABA677
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 01:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D97A0185C
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 23:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C068F280309;
	Fri, 16 May 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnLsFJei"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953D0280039;
	Fri, 16 May 2025 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437701; cv=none; b=dF/Gk0+aSx5dIRQjv2vLVEtnzfC2Gw/YH5wZywtKu4wwRlOQFdjXlTNKdjVinaOYvBBkf8SZnKpvviv5AFZWZL/6MVlwWiSWzubfwmldTXTfBAlxXem+/C4yxqkYGDE7uugHFQqhduBYmLJjSfeRlADWAp8+1LvSLbYJgIwi3cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437701; c=relaxed/simple;
	bh=e1V1pY03oCpsIuuhhQkGl6HJfVOxmgaj7taaKNoalKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGRCgizdfLI5EgXrEmfvMHlU0Z0GfVYTpWI5Ze3+bYlfSe16IkikzgrBa0V05X5YVdigmiqLLnVc7iYc35H3DGP0G9OPHrMIXw8h0guUfiZXiJMF+07XL4JsuFIRXHdbrJkSq5evFk/3aGJmUAsx3tXZ32c8OwgKTR/zH2wj1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnLsFJei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDE9C4CEE4;
	Fri, 16 May 2025 23:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747437700;
	bh=e1V1pY03oCpsIuuhhQkGl6HJfVOxmgaj7taaKNoalKo=;
	h=From:To:Cc:Subject:Date:From;
	b=bnLsFJeivXx9AhpRKcNYoe8LxpYKnDr5NoBzJ8mjEBLVmCLl3Dp+Lwgz0+on8Waok
	 28Insh5NwBymW6BwVR2afBjvv0EgacFDSDo1wcGePcvrnE75Kh+NR/aWGsS4R0AyyX
	 yhcl+yPdQCgUJ0sl6qEC5bl8zf2pPM8Z+ohet6ozqsQDrOB/dC3r4kSZLvvgHs+0sp
	 C1Rgxw4fX7VxhK2YJ8hYi0Z+7pN42MTCh/aziw+TDrHRFBqbefqrX6lqcXSax+oRWI
	 7ekvIoE12+QIHoOW9CIoaaIBc7nDfHemhsYOFKrqGhsxxYA+U74A1wosJ3brG4eNJQ
	 jFsZvfhiozb7w==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ayush Jain <Ayush.Jain3@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/3] x86: Don't support kernel-mode FPU with hardirqs disabled
Date: Fri, 16 May 2025 16:18:55 -0700
Message-ID: <20250516231858.27899-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series returns to my earlier suggestion to make x86 not support
kernel-mode FPU when hardirqs are disabled, aligning it with arm64
(https://lore.kernel.org/r/20250220051325.340691-2-ebiggers@kernel.org).
To make this possible despite the use of the kernel-mode FPU functions
by __save_processor_state() (which I mentioned at
https://lore.kernel.org/r/20250228035924.GC5588@sol.localdomain), I've
changed __save_processor_state() to use a new function instead of
(mis)using the kernel-mode FPU functions.

This slightly reduces the overhead of kernel-mode FPU (since the result
is fewer checks), and it fixes the issue reported at
https://lore.kernel.org/r/20250516112217.GBaCcf6Yoc6LkIIryP@fat_crate.local/
where irq_fpu_usable() incorrectly returned false during CPU
initialization, causing a crash in the SHA-256 library code.

Eric Biggers (3):
  x86/fpu: Add fpu_save_state() for __save_processor_state()
  x86/pm: Use fpu_save_state() in __save_processor_state()
  x86/fpu: Don't support kernel-mode FPU when irqs_disabled()

 arch/x86/include/asm/fpu/api.h |  1 +
 arch/x86/kernel/fpu/core.c     | 92 ++++++++++++++++++++--------------
 arch/x86/power/cpu.c           | 18 +++----
 3 files changed, 62 insertions(+), 49 deletions(-)


base-commit: 8566fc3b96539e3235909d6bdda198e1282beaed
-- 
2.49.0


