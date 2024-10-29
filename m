Return-Path: <linux-pm+bounces-16653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC29B467B
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 11:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E8D1F239B0
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 10:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01328204037;
	Tue, 29 Oct 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCxAohzZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98A1DFD80;
	Tue, 29 Oct 2024 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196934; cv=none; b=DEfHUB2vq6lIagS/+DLBWnRfIv6QmldTrMbgCtKOoUaovnwGa4Z4DYzSEZgrYDno1UAxWAm1qD2kcwfqBb0USNRjEh9JLj/BpGq/yNJb7V7MIKrxOP24rUAxOEfFfeabRIr+wyW8lv9xXmB0MznfIjDdHQ9jWJ4Ue1phfY8hdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196934; c=relaxed/simple;
	bh=fsoz2c8n5Yz0qI+Xhi9ZQHb1+SwCTWOwOy1APM1A8T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MCUrleomFqiE3/LwH7Plh1F1YIinGo+g5zCGveal6nB6ymys/M/u43iumzInq/JFaGc7T+9ZPyV96XS+QWofVph1ZWM0agNpMBpkPnbrREx1+cyNBwSRcv7UPfE19ZMrLaFgclacoCniOc8VhQidryjp9RXVUnqhKgFdI6BbSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCxAohzZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730196933; x=1761732933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fsoz2c8n5Yz0qI+Xhi9ZQHb1+SwCTWOwOy1APM1A8T0=;
  b=aCxAohzZmb2HglDXPIKxvGn8A9xyNoLctgK60c+PKp2e1pw3rhqq5dpp
   tRg9LvD/IGhjKnLzxNU2SrWvC/o5OYoHx0aSh+ZsB6HtKfUDeP6NKtEe4
   lEYVHi2/Bvx/kt75Qhe37XnYuF+mur2aSV0JmL6k0TO5ElZKlt4I5Y7Po
   dUhui2S3KUuZSk741bqnN4yVDnPT2YQKonWh8PWTulp4JTCrIJ4tbr+7j
   C2qZdw4EFCdWj0fzVCxPAjSK2FNNu14mLqiCuwyNDHYYm5qu+VMJTEVX3
   UCuduqdYS14KaGnTv/ZF5ysacIVZGH2qLpMJShLgJkiebfxhhQTsEUg1c
   Q==;
X-CSE-ConnectionGUID: vHTRcKk+QzydTXCSCmCaxg==
X-CSE-MsgGUID: II/ChAWrQRS5orTnDjDbKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="33624072"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="33624072"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:15:33 -0700
X-CSE-ConnectionGUID: sEHCMEShREKBYpCHbkjGPg==
X-CSE-MsgGUID: tFTJQ4PpQcOVCWGgKs0STQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="119375270"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.58])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:15:29 -0700
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v2 0/3] SRF: Fix offline CPU preventing pc6 entry
Date: Tue, 29 Oct 2024 11:15:04 +0100
Message-ID: <20241029101507.7188-1-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sending a tiny change in response to a suggestion I got off-list.

Changes since v1:
	* Remove explicit assignment to global, play_dead_mwait_hint as
	  suggested by Dave Hansen off-list, to prevent compiler from
	  moving it out of the .bss.

Patryk Wlazlyn (3):
  x86/smp: Move mwait hint computation out of mwait_play_dead
  x86/smp: Allow forcing the mwait hint for play dead loop
  intel_idle: Identify the deepest cstate for SRF

 arch/x86/include/asm/smp.h |  3 +++
 arch/x86/kernel/smpboot.c  | 54 ++++++++++++++++++++++++++------------
 drivers/idle/intel_idle.c  | 12 +++++++++
 3 files changed, 52 insertions(+), 17 deletions(-)

-- 
2.47.0


