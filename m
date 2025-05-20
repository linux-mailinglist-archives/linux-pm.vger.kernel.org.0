Return-Path: <linux-pm+bounces-27416-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2BCABDF15
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 17:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285271895C72
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC6C21CA04;
	Tue, 20 May 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoaskE5a"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6004F10785;
	Tue, 20 May 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755059; cv=none; b=PJLjKXv2584IVD1/l/OH20I43Nb3mDkpgKrjvL3ta5Fqvf7FNwWNbd/rywgiK3ggqC1GhwTuKx4k+6/qmfhvr7sok1C+joB8VwPwUd27AbVHLV23/BPlGy1NoSspXnZSz8FkhrAz074e0XptFO2EBSA9oIijfhsL21tlYXLPTuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755059; c=relaxed/simple;
	bh=8QuMfgUWEBlpjoRNSEka1bX0eoS7zBDoQTiDZd+pO5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVVhUqS2ogwfAfZ7P8aKGU37dImpIWAGl/CgdqzW4SGgArCTCD2XKOyGt7hChkm6OWanK9HapHUdw7Y+LixxvaEpwENv0dHuRKKEI5mxvwCBJcJH/N/b8fe4biI1N0x30Qe3DdIc/CaOhbIYoLvsZOisQioCaHdYZbh19MuHz8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoaskE5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9711BC4CEE9;
	Tue, 20 May 2025 15:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747755058;
	bh=8QuMfgUWEBlpjoRNSEka1bX0eoS7zBDoQTiDZd+pO5I=;
	h=From:To:Cc:Subject:Date:From;
	b=eoaskE5aP7FB1HEzHw26H/vk/euYgqd3B04iKz2AAjaWbhqlmkYjoOZiB/on/Bkwa
	 p0f66U76zmW+uDYEquES+foXOzsfrWe+EL1fxqHZXTNM4hva+FMonRlht7HjZp8ahX
	 KRR4/ForJQdWIMREIwSNBjCLU1ZTh+50JW9K4cIQyF+ru1xzJAxeBROCBvzR7NxmoJ
	 HPUx6J2P7uotjDu0jXEkJL5NoddG7s4uHZiN65bPSZdP+4Ed3cfC4GARkdemToFkZL
	 lDQk6tGS5Dd4n8iZ0RCoXttBHcqpljWGXIjz32r6g43aOjP6SySsyfFXH4ydwq8FCe
	 0pEG+ZG+Qcknw==
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
Subject: [PATCH v3 0/2] x86/fpu: Fix irq_fpu_usable() to return false during CPU onlining
Date: Tue, 20 May 2025 08:29:36 -0700
Message-ID: <20250520152938.21881-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a crash in the SHA-256 code during hotplug CPU
onlining.

Changed in v3:
  - Split into two patches, as requested by Ingo.
Changed in v2:
  - Add WARN_ON_FPU when kernel_fpu_allowed has unexpected value in
    fpu__init_cpu() or cpu_disable_common().  Since WARN_ON_FPU is
    defined in fpu/internal.h which should not be included by smpboot.c,
    made cpu_disable_common() call a new function fpu__disable_cpu().
  - Added Tested-by.

Eric Biggers (2):
  x86/fpu: Replace in_kernel_fpu with kernel_fpu_allowed
  x86/fpu: Fix irq_fpu_usable() to return false during CPU onlining

 arch/x86/include/asm/fpu/api.h |  1 +
 arch/x86/kernel/fpu/core.c     | 34 +++++++++++++++++++++-------------
 arch/x86/kernel/fpu/init.c     | 13 +++++++++++++
 arch/x86/kernel/fpu/internal.h |  2 ++
 arch/x86/kernel/smpboot.c      |  6 ++++++
 5 files changed, 43 insertions(+), 13 deletions(-)


base-commit: 3ee84e3dd88e39b55b534e17a7b9a181f1d46809
-- 
2.49.0


