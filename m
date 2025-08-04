Return-Path: <linux-pm+bounces-31887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351DB1A12F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 14:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4CC6207DE
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 12:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6473C260568;
	Mon,  4 Aug 2025 12:18:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002EC260563;
	Mon,  4 Aug 2025 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309895; cv=none; b=jo4gtiYfhuiiv2hWfGU1ki8UTnd4B4aO6leH6IPPaOjlwqJFXktqdHUZj8gbaWPH7dR8K1R3ahl/5eonJKuA+u+Amo5aA+bg22n0tBUWyupP2ym/f7AcaK1s88tyjljxTErF1+AuOzWRBbR7tvSL1EaGKiQkYMfQ+XbttK8PUpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309895; c=relaxed/simple;
	bh=mPy4thA1/du4dFbNzpx58/qAyPaMN57d2szGheSzUuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sFwHA/f1KFjjs9eUi3Ht1pMTO7ofuseIlPTJVvoebdYXAVdIIBnZB+etpfa657VmllxovALW1OMkCtv9x+qjh3m31IU0UceBM12XKjAaaHBXG8hOt8cHEYTSGJYCbiPMcwlg/0uE3/84EeyaF6/rv0UYe75/sgdAbwoklfC9yB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68E24150C;
	Mon,  4 Aug 2025 05:18:05 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C183C3F738;
	Mon,  4 Aug 2025 05:18:09 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	anshuman.khandual@arm.com,
	robh@kernel.org,
	james.morse@arm.com,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	ry111@xry111.site,
	Dave.Martin@arm.com,
	ahmed.genidi@arm.com,
	kevin.brodsky@arm.com,
	scott@os.amperecomputing.com,
	mbenes@suse.cz,
	james.clark@linaro.org,
	frederic@kernel.org,
	rafael@kernel.org,
	pavel@kernel.org,
	ryan.roberts@arm.com,
	suzuki.poulose@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH 11/11] KVM: arm64: expose FEAT_SCTLR2 feature to guest
Date: Mon,  4 Aug 2025 13:17:24 +0100
Message-Id: <20250804121724.3681531-12-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804121724.3681531-1-yeoreum.yun@arm.com>
References: <20250804121724.3681531-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

expose FEAT_SCTLR2 feature to guest.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 24881b7248b5..3f82ef1a8eb0 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1644,8 +1644,8 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 		val &= ~ID_AA64MMFR2_EL1_NV;
 		break;
 	case SYS_ID_AA64MMFR3_EL1:
-		val &= ID_AA64MMFR3_EL1_TCRX | ID_AA64MMFR3_EL1_S1POE |
-			ID_AA64MMFR3_EL1_S1PIE;
+		val &= ID_AA64MMFR3_EL1_TCRX | ID_AA64MMFR3_EL1_SCTLRX |
+			ID_AA64MMFR3_EL1_S1POE | ID_AA64MMFR3_EL1_S1PIE;
 		break;
 	case SYS_ID_MMFR4_EL1:
 		val &= ~ARM64_FEATURE_MASK(ID_MMFR4_EL1_CCIDX);
@@ -2961,6 +2961,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 					ID_AA64MMFR2_EL1_NV |
 					ID_AA64MMFR2_EL1_CCIDX)),
 	ID_WRITABLE(ID_AA64MMFR3_EL1, (ID_AA64MMFR3_EL1_TCRX	|
+				       ID_AA64MMFR3_EL1_SCTLRX  |
 				       ID_AA64MMFR3_EL1_S1PIE   |
 				       ID_AA64MMFR3_EL1_S1POE)),
 	ID_WRITABLE(ID_AA64MMFR4_EL1, ID_AA64MMFR4_EL1_NV_frac),
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


