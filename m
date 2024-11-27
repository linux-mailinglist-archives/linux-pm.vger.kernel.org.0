Return-Path: <linux-pm+bounces-18166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEA29DAB93
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 17:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B83DB22246
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BDA200132;
	Wed, 27 Nov 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOaUIeOP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E86288D1;
	Wed, 27 Nov 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724146; cv=none; b=aCK5g7KNacGx5T7p1Yf8CjIimYNbJIeBjEUxwKsyr0mqsXE+kZcR75oGnhjrbIbVfCJ8lEvOP6n/WCLwslW0asOBWW6qFnZ+M8aaESSNsuczb3Sm+oWemFkdphn0bhzthFBn18Vole38cArkSZ3cgBRRyjObajes8cDlqCO3cn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724146; c=relaxed/simple;
	bh=YWlkXJIsGagPzo4kTE5UAbAO9a3MxHYvMz18T+D5YWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPXZgFkSU26rWJkG6pmbKfouMNEJxxV39PeicG4AwFCYTCbfoOXF0HqLanjwJy3Z+fC5oLaDKhW0lVhgpDxdlK8HiiinjVHL4DKTK7I7G7bPXybgK0BCEQNaxGrEewCg3qFi++JPryeyQBZe+PD0dL1GswJBjk85H/M7s7AoPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOaUIeOP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732724144; x=1764260144;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YWlkXJIsGagPzo4kTE5UAbAO9a3MxHYvMz18T+D5YWk=;
  b=KOaUIeOPgk/vGLB1acRslIP2tFUYKR80B9SM3Kb66ltlxNCXzcY5Tbho
   iwypywIQiUV6TUhwcCn10d+3Kf6IfVJzHUwJzRXQoxusK0bt80rm2M9ZX
   52nx6sTpTLFFDYERu2uOIJnWixISfXt1DqjdJzSaWXBdazPpdO/i7TDO5
   y8gXvY0eURSCMZzJPFm++5BqIeH6a3KVbgaqP21jugxQnhxiq/Q0G+jyY
   lm7BHp66vQ8UPnG0SkOy24U8ctSKvuPW2QUkcS3uFLf496zeSd90abVeK
   5Kw77D5XMM9N7vDHZHEF03c7tAKGSXsHjFt1Fc+x3W2H0D1cWt8/xDgR9
   A==;
X-CSE-ConnectionGUID: iVb6yPxLQmGtIOLs9hTxdA==
X-CSE-MsgGUID: vJDpwgCESua5IvV5e2MY3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="43597578"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="43597578"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 08:15:44 -0800
X-CSE-ConnectionGUID: IKn7hU2CSfOWkyIXB3QiIQ==
X-CSE-MsgGUID: 35A76Us9QT+Ik5IuGeyfjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="97042399"
Received: from mlehtone-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.148])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 08:15:40 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com,
	tglx@linutronix.de,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v6 0/4] SRF: Fix offline CPU preventing pc6 entry
Date: Wed, 27 Nov 2024 17:15:14 +0100
Message-ID: <20241127161518.432616-1-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v5:
 * Split 1/3 from v5 into two commits, as suggestem by Gautham.
   1/4 splits wait_play_dead into mwait_play_dead_with_hint.
   2/4 and 3/4 uses the new mwait_play_dead_with_hint
   4/4 removes mwait_play_dead and calls cpuidle_play_dead right away

 * Reword 1-3/4 changelog slightly.

 * Move changelog from v5 1/3 into v6 4/4

Patryk Wlazlyn (4):
  x86/smp: Allow calling mwait_play_dead with an arbitrary hint
  ACPI: processor_idle: Add FFH state handling
  intel_idle: Provide the default enter_dead() handler
  x86/smp native_play_dead: Prefer cpuidle_play_dead() over
    mwait_play_dead()

 arch/x86/include/asm/smp.h    |  4 ++-
 arch/x86/kernel/acpi/cstate.c |  9 +++++++
 arch/x86/kernel/smpboot.c     | 50 ++++-------------------------------
 drivers/acpi/processor_idle.c |  2 ++
 drivers/idle/intel_idle.c     | 18 +++++++++++--
 include/acpi/processor.h      |  5 ++++
 6 files changed, 40 insertions(+), 48 deletions(-)

-- 
2.47.1


