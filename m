Return-Path: <linux-pm+bounces-17202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AE99C1CF8
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 13:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792531C221D1
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 12:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AE31E7C17;
	Fri,  8 Nov 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvvJLRt0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567C1E631B;
	Fri,  8 Nov 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068968; cv=none; b=e/Y4IGKMmoYqyPu9jEt4/+mxNZJhpHSAzVuZE8TlhsZw1MgBfy/DR+gLDbbjGM5RG+t0cl/6guAh74gYpV331k8SPA/nKtZM/T/JhFKcr8bNJ75qc9XDvF4hT2wUk9hdGpkXRY+I0dKp+1O9vfp4LnuyGk8g9POE/QQML7JncBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068968; c=relaxed/simple;
	bh=Ptq1/Or31/2/hXiMkSLK127y6Z9IZ9cpgbVlnI5kYd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eI4YTpEfI10ub7KmzFSVLFc5XIFPrl04dLsFsgwnDEVCtueK1aXBdhoWxYif/viXpwFT/n3btYMuUeWnK7xMhEVzIDU4b5f14sYBqlCddXdQ2gVuB6VYsKze1fvinyPqXGsVxtgXNkb4vYbq569pfh+RJ0gg6xK2LaEYm8ENXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvvJLRt0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731068967; x=1762604967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ptq1/Or31/2/hXiMkSLK127y6Z9IZ9cpgbVlnI5kYd8=;
  b=VvvJLRt0njKIpRRYU3rvdsHiLdPojc32LR9XlOMQ9gYCK3i9s64NFg94
   km7VEalSfAR2LWpUfLcYftuNvrY6mmp5Y+v2DrWEpdpePStD/FrSw+iMV
   eo057TE2ZjA3t3xerr/wIaN0nMGjhb1C/zrrf9ON+gJ4UFxLSVEB4bZHl
   VI6uO+JiB86Tf33CDdWQdF8hR0QEuv6enFaTMMTxUUPGLKFMf/y4eZ0JS
   ovd/aqXACPjUcHR2Nb84gd44ZSlM4GMn6mYQ3ZLbBYVVJKRCirvDW94HI
   dkNjbS6/Ao+HmtpKZ228N/Rx4Eldmma5br4Vx9/JW4Kt4R2ATDM7KDX3g
   Q==;
X-CSE-ConnectionGUID: DcC/AIQuQKmbg+rA9EIG6A==
X-CSE-MsgGUID: 80nDfHnpThehmkrSlK226A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53510342"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53510342"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:29:26 -0800
X-CSE-ConnectionGUID: HQ7xgfSIQLeq7++bfzcrmQ==
X-CSE-MsgGUID: VMXkSuMUQtq4xCaUxLnEGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85920976"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.89])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:29:24 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v3 0/3] SRF: Fix offline CPU preventing pc6 entry
Date: Fri,  8 Nov 2024 13:29:06 +0100
Message-ID: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applied suggestions from Dave and Rafael.

Because we now call a smp function, we have to have ifdefs for
CONFIG_SMP or rely on mwait_play_dead_with_hint to return immediatelly
with an error on non-smp builds. I decided to do the later, but maybe we
should return -ENODEV (or other error constant) instead of 1. I am open
for suggestions.

Removing the existing "kexec hack" by bringing all offlined CPUs back
online before proceeding with the kexec would make it even simpler, but
I am not sure we can do that. It looks kind of obvious to me, but for
some reason the hack exist.

Changes since v2:
  The whole approach changed, but there main things are below.

  * Split mwait_play_dead (old code) into two parts:
    1. Computing mwait hint based on cpuid leaf 0x5
    2. Entering while(1) mwait loop with "kexec hack" handling

  * Prefer cpuidle_play_dead over mwait_play_dead by reordering calls in
    native_play_dead.

  * Add implementation for enter_dead() handler in intel_idle that calls
    executes old mwait_play_dead code, but with the mwait hint from the
    cpuidle state table.


Patryk Wlazlyn (3):
  x86/smp: Allow calling mwait_play_dead with arbitrary hint
  x86/smp native_play_dead: Prefer cpuidle_play_dead() over
    mwait_play_dead()
  intel_idle: Provide enter_dead() handler for SRF

 arch/x86/include/asm/smp.h |  6 ++++++
 arch/x86/kernel/smpboot.c  | 29 ++++++++++++++++++++---------
 drivers/idle/intel_idle.c  | 16 ++++++++++++++++
 3 files changed, 42 insertions(+), 9 deletions(-)

-- 
2.47.0


