Return-Path: <linux-pm+bounces-36944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF61CC12ED0
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 06:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE4F34FAB2A
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 05:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF4123EABE;
	Tue, 28 Oct 2025 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9stHjbq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67F225413
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761628679; cv=none; b=hp7vCHQbJBzhW9k1WNISN00CDuFGr4NHjwhtXEp7rkzoQ/8Cbstdu0U4Bga7QV56vg4sTO5iI+ZihEZd5pYeccUlVlANNxzaEk3wuHMvV2twNNI05DepQOVjkZZq5CwnBhk6/vsxLnZfiWL6pv+Fd3fJRGLTF1PVHXesqvQ/T7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761628679; c=relaxed/simple;
	bh=mSWrQwu/EQHyKKQu1finUKhTGmPOq2GRexotMXZWbDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q+IIJjuMdIuRLcx9V0vWAMij11D7gv7Q/hTUWySFWeucWa4wpiWNfoqCp6OpoBN2RSCXtFPBtNmMgO7cEQ6if1I9t5KmiZ+0FGHuC6D0xOZfsDdHWiMsWPaN3mZ3Fjf4wMna9vuUaYiqZYRCe6Melzy+JCNrTZHIxU1Df1JI1F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9stHjbq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761628678; x=1793164678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mSWrQwu/EQHyKKQu1finUKhTGmPOq2GRexotMXZWbDs=;
  b=B9stHjbqJzqcGZ27wuO0LjhsI5Z2sJuOFkfxA+dPek0djL+gILK1gtRy
   /WD/fiS6YyQ6XhEaXiTaPCBAJ4w/8VH2oZ/NZkqnE3ZiexE/1MWzyh29k
   N1w/YGrKWkLm83ZRbAxgb+6IcOP9HX6OSKGiXp+N6o9EcjvOcupE4YTSU
   8igFbbf1oGbQlvXI7cQybmjDXpQ3aEbz4DDciaVbL/MvbyudVv0yxs69m
   fSiMqkjkqQbqcU65hByPsQNSGsgR8eS8OMRMfFzItmvlfQTjm45gLiz+f
   HxKdWWGxmn0v7EMBojYqJu6Thtro9x7gYBr6OIhNjlJPIyEfojjxgEiGc
   g==;
X-CSE-ConnectionGUID: UPzKM4PlS/aIFS46qzZSbw==
X-CSE-MsgGUID: QGCPR+2VTYmIEI3oTe7RSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89188809"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="89188809"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 22:17:58 -0700
X-CSE-ConnectionGUID: FBVYTKFvQGKsED6cxagWcA==
X-CSE-MsgGUID: WFl0eh8xTKaZv5hNxl0F2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="185705447"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa009.fm.intel.com with ESMTP; 27 Oct 2025 22:17:55 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v2] ACPI / DPTF: Use ACPI_FREE() for ACPI buffer deallocation
Date: Tue, 28 Oct 2025 10:45:54 +0530
Message-Id: <20251028051554.2862049-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree() with ACPI_FREE() in pch_fivr_read() to follow ACPI
memory management conventions. While functionally equivalent in Linux
(ACPI_FREE() is implemented as kfree()), using ACPI_FREE() maintains
consistency with ACPI coding standards for deallocating ACPI buffer
objects.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
Changes in v2:
- Clarified changelog: convention adherence, not functional fix

 drivers/acpi/dptf/dptf_pch_fivr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index 952216c67d58..8d7e555929d3 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -41,7 +41,7 @@ static int pch_fivr_read(acpi_handle handle, char *method, struct pch_fivr_resp
 	ret = 0;
 
 release_buffer:
-	kfree(buffer.pointer);
+	ACPI_FREE(buffer.pointer);
 	return ret;
 }
 
-- 
2.34.1


