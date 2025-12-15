Return-Path: <linux-pm+bounces-39545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAC7CBD771
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 12:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D3C4300DE9B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 11:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F64330321;
	Mon, 15 Dec 2025 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZw6m+Ak"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D39333030A
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765797203; cv=none; b=TnR5QPA3l51cm7FPMnlfuUjSfcgW77XV+dPVieh20CEuFrypHAqlV82QME6dIUGFhQr+VQawUDoFRCcKbFN+ZikNMczUS0PvNcjj/QQu+cjR+fZZzJI7XMJB9qg1joXDsjDO8YTBx81iFlrTCe6DX9hsezhTaogmDLlGPX/1uXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765797203; c=relaxed/simple;
	bh=mFBv7/p1qtHmoa8ciETZ0TPhey+pk8XzCJTHr2br7BA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NoliiWxi/MTCad7PBtbUVjsoYLG34/llI3XDaE/hNocruS1p62S8kP4f+akkxeNTt1t4DGLASeTBPVTNNp3UMwzcXNOyObkDDoBvI0+sNlX4bWVPERc17ICIqFyVS4qq4/K8msyQ4vzh/LII4Qg/Fts+hRSSFwKj3TvBaOzRd+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZw6m+Ak; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-598f8136a24so3453877e87.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 03:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765797198; x=1766401998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/NT3rwCElRxmHKWyV7gegKGV0H/7i7/84NBXcMNDm6I=;
        b=JZw6m+AkXoaXXfmT5kEz2dQCRggZrldfQ/D1cAidICbCnAU4/ukzjRmznTxPffIE9B
         T73otOnMPpoC45S2X+TXKaMyCDXFMTbRpkjwLU0ZsMmy8L2B2ILc9eLZqc7xYHVSUBT9
         J4jXMyebz35c+CwI3Xcuudsb0MaXRq+5eClrYZj1MCFlVC09klTo69hEzCKu9BGDE75D
         E93Y49xXA0fTpYLqbkA/FYgg+/8nYlZ0c6fjuhGQnoDW6ZX0Y1dHEtGnPH2bXnH4dLv8
         Vgha1aDF8afInjPa6C8s19Uc8E9+btc7BJeIfFnLduY0pLTWdm1s5tvCFy4TZiLcPaVA
         rmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765797198; x=1766401998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NT3rwCElRxmHKWyV7gegKGV0H/7i7/84NBXcMNDm6I=;
        b=q5vMaJ6SiAusDb18EWEFFz9XgCCrALSOdRVjwE95q0cpLQBvO7KRNgNcciVJk7esNG
         6KOtytvCZ+pdMF2KwpNvN2pbnpE5Y2zvQVzgRMYvgbd9bvYhdKzwA1u9vBz2Eduk/h0T
         wGhMd+F9OA3mJGQDgoUD66shnH649Xd+6eiv1/M2d6aZY0s4CluQsBP0u8f3dxlfhOcT
         pv/hpzQ0ONtHokCNfYV2SQ66wGdQMcRanrU4lu/m3pItiGvrQh/zC2o6u/EK6NQzzuQ0
         pe4FtTkmVDrkEAZvc9JjOUspXGHgkitLxPb2/cKSAxF+bWUNyGTjQtagxPcDhahAC35C
         siDw==
X-Gm-Message-State: AOJu0YwYr12+nFbI5DmZEG5AFu7ZBFN96QefIx/FaBAM5vTo3T+Ghd+W
	tJYNSDavYaN2c2LTCXFgJVHF57nOixwOnYsf978Qzw0dv8ko+02F8FUW
X-Gm-Gg: AY/fxX5EBq50ScjTZf5bq/E+v/+jQIOIAhMBbZDgaBKQqPbWozR0zH7S7yaJAXGM6Lv
	7Qa+Yjti2euZpVXoSIMenC7ZHBsV/PPfeDtcTVy1eFTjQc5xy1zz9NcCL/THKOcfE247NBJi3SF
	Th8G2+aSrghT0AcLYwcZvPIKlBKEuc7SCurDdWYXfgkYwWf0r64hHVrCN6BUx2Xj18T7GTiSgm+
	Fa4FGn8sI95AqFg1rAAjB/reLkyDQnA7/JnOfEN1uRBd7ycaTph/Mm77CBoQJgW+Cm1RNYK2a31
	DslA2t447iNPWRKgiZxR3SLRxyWbfovrcTwmiEHoQTod43u2jKb30ByDPI9DUBJDLlKCV64wnx4
	t2z3WXva1iTrAhixyk78MPJU0R6aWw57L5liSm/z4kDRJlCIMPbRBquwakGBaKi5Zfd2xWFF2dG
	BGf+Q2eQiEkVTyrLfJePX7B5Hrkd4c3XIa598q8XGrdIH790UlTFwZhBBQBCZlVkSX53W//uyo7
	6gL+Sc=
X-Google-Smtp-Source: AGHT+IGMtFGZmsC1XichOI2iZDe3T1XMPAoXQAkUuewIJZRjIzulB8tv9E1KpmocqL7LCDg+U4ZktQ==
X-Received: by 2002:a05:6512:3a82:b0:595:910c:8f03 with SMTP id 2adb3069b0e04-598faa84069mr2741936e87.36.1765797198286;
        Mon, 15 Dec 2025 03:13:18 -0800 (PST)
Received: from abityuts-desk (2001-14bb-ab-c176-62a0-4b37-648c-102.rev.dnainternet.fi. [2001:14bb:ab:c176:62a0:4b37:648c:102])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f2fa7fedsm5324084e87.73.2025.12.15.03.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:13:17 -0800 (PST)
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH resend 1] intel_idle: Remove the 'preferred_cstates' parameter
Date: Mon, 15 Dec 2025 13:13:00 +0200
Message-ID: <20251215111300.132803-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Remove the 'preferred_cstates' module parameter as it is not really useful.

The parameter currently only affects Alder Lake, where it controls C1/C1E
preference, with C1E being the default. The parameter does not support any
other platform. For example, Meteor Lake has a similar C1/C1E limitation,
but the parameter does not support Meteor Lake. This indicates that the
parameter is not very useful.

Generally, independent C1 and C1E are important for server platforms where
low latency is key. However, they are not as important for client platforms,
like Alder Lake, where C1E providing better energy savings is generally
preferred.

The parameter was originally introduced for Sapphire Rapids Xeon:
da0e58c038e6 intel_idle: add 'preferred_cstates' module argument

Later it was added to Alder Lake:
d1cf8bbfed1ed ("intel_idle: Add AlderLake support")

But it was removed from Sapphire Rapids when firmware fixed the C1/C1E
limitation:
1548fac47a114 ("intel_idle: make SPR C1 and C1E be independent")

So Alder Lake is the only platform left where this parameter has any effect.
Remove this parameter to simplify the driver and reduce maintenance burden.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

Re-sending, for some reason the first submission did not arrive to the linux-pm
mailing list, I cannot find it in the archives.

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index aa44b3c2cb2c4..2d67a091ed3f0 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -70,7 +70,6 @@ static struct cpuidle_driver intel_idle_driver = {
 /* intel_idle.max_cstate=0 disables driver */
 static int max_cstate = CPUIDLE_STATE_MAX - 1;
 static unsigned int disabled_states_mask __read_mostly;
-static unsigned int preferred_states_mask __read_mostly;
 static bool force_irq_on __read_mostly;
 static bool ibrs_off __read_mostly;
 
@@ -2049,25 +2048,6 @@ static void __init skx_idle_state_table_update(void)
 	}
 }
 
-/**
- * adl_idle_state_table_update - Adjust AlderLake idle states table.
- */
-static void __init adl_idle_state_table_update(void)
-{
-	/* Check if user prefers C1 over C1E. */
-	if (preferred_states_mask & BIT(1) && !(preferred_states_mask & BIT(2))) {
-		cpuidle_state_table[0].flags &= ~CPUIDLE_FLAG_UNUSABLE;
-		cpuidle_state_table[1].flags |= CPUIDLE_FLAG_UNUSABLE;
-
-		/* Disable C1E by clearing the "C1E promotion" bit. */
-		c1e_promotion = C1E_PROMOTION_DISABLE;
-		return;
-	}
-
-	/* Make sure C1E is enabled by default */
-	c1e_promotion = C1E_PROMOTION_ENABLE;
-}
-
 /**
  * spr_idle_state_table_update - Adjust Sapphire Rapids idle states table.
  */
@@ -2174,11 +2154,6 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 	case INTEL_EMERALDRAPIDS_X:
 		spr_idle_state_table_update();
 		break;
-	case INTEL_ALDERLAKE:
-	case INTEL_ALDERLAKE_L:
-	case INTEL_ATOM_GRACEMONT:
-		adl_idle_state_table_update();
-		break;
 	case INTEL_ATOM_SILVERMONT:
 	case INTEL_ATOM_AIRMONT:
 		byt_cht_auto_demotion_disable();
@@ -2532,17 +2507,6 @@ module_param(max_cstate, int, 0444);
  */
 module_param_named(states_off, disabled_states_mask, uint, 0444);
 MODULE_PARM_DESC(states_off, "Mask of disabled idle states");
-/*
- * Some platforms come with mutually exclusive C-states, so that if one is
- * enabled, the other C-states must not be used. Example: C1 and C1E on
- * Sapphire Rapids platform. This parameter allows for selecting the
- * preferred C-states among the groups of mutually exclusive C-states - the
- * selected C-states will be registered, the other C-states from the mutually
- * exclusive group won't be registered. If the platform has no mutually
- * exclusive C-states, this parameter has no effect.
- */
-module_param_named(preferred_cstates, preferred_states_mask, uint, 0444);
-MODULE_PARM_DESC(preferred_cstates, "Mask of preferred idle states");
 /*
  * Debugging option that forces the driver to enter all C-states with
  * interrupts enabled. Does not apply to C-states with
-- 
2.52.0


