Return-Path: <linux-pm+bounces-11471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C67A93E07D
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249F51F2190B
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F6D187325;
	Sat, 27 Jul 2024 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUanx3pn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6086126
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104810; cv=none; b=olnscdoH3pzrfCY5IKuj7Eca27qyFPxaO53p9Qxc74zYH8UIUqfQinZBPf1+L/NH+6hhJWDZNF9hnVoGQz4PPlsJPQfk2SR790vDTSoLyx/d24Apk1IV/AyZykQo3AUEDE+o8soZ70TkmfCCADkQuWxvX+4gvymjfehOtwZt8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104810; c=relaxed/simple;
	bh=9r7Xc+IIVx1GOCLeaKz6dsETKUPQUFb8hGXyTe2RgO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWUGCMCEBLKk6g+JaaWN4QcAFmg6sR0OtTwYMZoHuJoG5G7JMpGxG6HqYPCJ6RUxUIZPyxmBBT9FfYrXhK1JYYzM9xidbBN6sW2GwaMdca77wV3eBSsQcYvHs+e/Y8Pign8JHIWDcSDqYvbEZHnLeM51jDtfixmsC4oOuRNIrzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUanx3pn; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70944dc8dc6so373332a34.3
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104808; x=1722709608; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySa3u7lnIkoSFfuSyIRaZF20zQX08qeTJIJ+oMjs784=;
        b=cUanx3pn82Bleiclh37Pz2+Qf2QsYAfhzZgXf+bj+kmGdYgkiXSYlcYtfIIDlKGGVa
         3FCkbDmI+PJoUK1hyltlL2GM6eaempFad27O+ymKh5xSNr26JjBaEASPHt4NcJMClLYS
         scip/bKrmBnKGJQVBiyQYcN5nkMmsC7IJOWKZzUNCfLyvMM/FYvu+MFirfL86kNFBamK
         XMMZ/ne9VWxAPjydrcDO93Ka2bSLeMogQP3wWKp+RfkJDtS41UNHMgpqSFdMsFncFHWq
         orhL7uAFh9y2oMs36S+BCVhUbP7PL+Urxt0FKKfFsD/n/HCZATLNFSl+ISX83q5Bj1by
         KFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104808; x=1722709608;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySa3u7lnIkoSFfuSyIRaZF20zQX08qeTJIJ+oMjs784=;
        b=pLCaSwnnmjd/wpsPz9BkB2HO6TJohmbuScT8jmp8a3j9PHjx2Q7EDF1Rf9e2seHy9Z
         DDuwSqIwfXqzluqKOomJDINGThlXogvWWKZjPpbHd1mm+5zmzPnTCxzf8b93Gh/jbLLu
         83GB1dGBavncFeUZ0RsTYK/VJM3N4dj91vTHkqh7cGmMVvU02UNPywfkzi4H+gjvodK/
         7QrfP0AdIXmHwT/IKTIVf0ms9zaC3BclE51rD0oTgNrvLXDs0esVuqTUddq6eJwjRkb4
         JWO7IiVBZEXYOdpd2udK2i6RapVpTpgwuQqmLQJEjtcPNKDPs1/3AZ1FFnkizEG53Wgw
         jNqg==
X-Gm-Message-State: AOJu0YxluRW5oFlBh9RyyB+PRsXMOoasYFxRPhgSPpGYxqLeW3oVwWZx
	eapRzWwxhqwosjRKIxuawRI1HfaZq8iTbpoPsN9udUHA2W9OBbFejJD71g==
X-Google-Smtp-Source: AGHT+IF7rgfGfQyi+seELzHfQRw/DutvvJ2gtO1ncWb4jwR9n6tmaZ33idCbKki8UPpxXyTCiuoezg==
X-Received: by 2002:a9d:4f11:0:b0:703:61ea:f289 with SMTP id 46e09a7af769-70940ca9967mr3871002a34.28.1722104807702;
        Sat, 27 Jul 2024 11:26:47 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:47 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 01/18] tools/power/turbostat: Switch to new Intel CPU model defines
Date: Sat, 27 Jul 2024 14:23:27 -0400
Message-ID: <1b3bf0747d4f1a963e59c26e602868bdce195318.1722019621.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240727182641.414886-1-lenb@kernel.org>
References: <20240727182641.414886-1-lenb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Tony Luck <tony.luck@intel.com>

New CPU #defines encode vendor and family as well as model.

N.B. Copied VFM_*() defines here from <asm/cpu_device_id.h> to avoid
an application picking a second internal kernel header file.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 165 +++++++++++++++-----------
 1 file changed, 95 insertions(+), 70 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9f5d053d4bc6..02312e62c857 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9,6 +9,30 @@
 
 #define _GNU_SOURCE
 #include MSRHEADER
+
+// copied from arch/x86/include/asm/cpu_device_id.h
+#define VFM_MODEL_BIT	0
+#define VFM_FAMILY_BIT	8
+#define VFM_VENDOR_BIT	16
+#define VFM_RSVD_BIT	24
+
+#define	VFM_MODEL_MASK	GENMASK(VFM_FAMILY_BIT - 1, VFM_MODEL_BIT)
+#define	VFM_FAMILY_MASK	GENMASK(VFM_VENDOR_BIT - 1, VFM_FAMILY_BIT)
+#define	VFM_VENDOR_MASK	GENMASK(VFM_RSVD_BIT - 1, VFM_VENDOR_BIT)
+
+#define VFM_MODEL(vfm)	(((vfm) & VFM_MODEL_MASK) >> VFM_MODEL_BIT)
+#define VFM_FAMILY(vfm)	(((vfm) & VFM_FAMILY_MASK) >> VFM_FAMILY_BIT)
+#define VFM_VENDOR(vfm)	(((vfm) & VFM_VENDOR_MASK) >> VFM_VENDOR_BIT)
+
+#define	VFM_MAKE(_vendor, _family, _model) (	\
+	((_model) << VFM_MODEL_BIT) |		\
+	((_family) << VFM_FAMILY_BIT) |		\
+	((_vendor) << VFM_VENDOR_BIT)		\
+)
+// end copied section
+
+#define X86_VENDOR_INTEL	0
+
 #include INTEL_FAMILY_HEADER
 #include BUILD_BUG_HEADER
 #include <stdarg.h>
@@ -367,7 +391,7 @@ struct platform_features {
 };
 
 struct platform_data {
-	unsigned int model;
+	unsigned int vfm;
 	const struct platform_features *features;
 };
 
@@ -910,75 +934,75 @@ static const struct platform_features amd_features_with_rapl = {
 };
 
 static const struct platform_data turbostat_pdata[] = {
-	{ INTEL_FAM6_NEHALEM, &nhm_features },
-	{ INTEL_FAM6_NEHALEM_G, &nhm_features },
-	{ INTEL_FAM6_NEHALEM_EP, &nhm_features },
-	{ INTEL_FAM6_NEHALEM_EX, &nhx_features },
-	{ INTEL_FAM6_WESTMERE, &nhm_features },
-	{ INTEL_FAM6_WESTMERE_EP, &nhm_features },
-	{ INTEL_FAM6_WESTMERE_EX, &nhx_features },
-	{ INTEL_FAM6_SANDYBRIDGE, &snb_features },
-	{ INTEL_FAM6_SANDYBRIDGE_X, &snx_features },
-	{ INTEL_FAM6_IVYBRIDGE, &ivb_features },
-	{ INTEL_FAM6_IVYBRIDGE_X, &ivx_features },
-	{ INTEL_FAM6_HASWELL, &hsw_features },
-	{ INTEL_FAM6_HASWELL_X, &hsx_features },
-	{ INTEL_FAM6_HASWELL_L, &hswl_features },
-	{ INTEL_FAM6_HASWELL_G, &hswg_features },
-	{ INTEL_FAM6_BROADWELL, &bdw_features },
-	{ INTEL_FAM6_BROADWELL_G, &bdwg_features },
-	{ INTEL_FAM6_BROADWELL_X, &bdx_features },
-	{ INTEL_FAM6_BROADWELL_D, &bdx_features },
-	{ INTEL_FAM6_SKYLAKE_L, &skl_features },
-	{ INTEL_FAM6_SKYLAKE, &skl_features },
-	{ INTEL_FAM6_SKYLAKE_X, &skx_features },
-	{ INTEL_FAM6_KABYLAKE_L, &skl_features },
-	{ INTEL_FAM6_KABYLAKE, &skl_features },
-	{ INTEL_FAM6_COMETLAKE, &skl_features },
-	{ INTEL_FAM6_COMETLAKE_L, &skl_features },
-	{ INTEL_FAM6_CANNONLAKE_L, &cnl_features },
-	{ INTEL_FAM6_ICELAKE_X, &icx_features },
-	{ INTEL_FAM6_ICELAKE_D, &icx_features },
-	{ INTEL_FAM6_ICELAKE_L, &cnl_features },
-	{ INTEL_FAM6_ICELAKE_NNPI, &cnl_features },
-	{ INTEL_FAM6_ROCKETLAKE, &cnl_features },
-	{ INTEL_FAM6_TIGERLAKE_L, &cnl_features },
-	{ INTEL_FAM6_TIGERLAKE, &cnl_features },
-	{ INTEL_FAM6_SAPPHIRERAPIDS_X, &spr_features },
-	{ INTEL_FAM6_EMERALDRAPIDS_X, &spr_features },
-	{ INTEL_FAM6_GRANITERAPIDS_X, &spr_features },
-	{ INTEL_FAM6_LAKEFIELD, &cnl_features },
-	{ INTEL_FAM6_ALDERLAKE, &adl_features },
-	{ INTEL_FAM6_ALDERLAKE_L, &adl_features },
-	{ INTEL_FAM6_RAPTORLAKE, &adl_features },
-	{ INTEL_FAM6_RAPTORLAKE_P, &adl_features },
-	{ INTEL_FAM6_RAPTORLAKE_S, &adl_features },
-	{ INTEL_FAM6_METEORLAKE, &cnl_features },
-	{ INTEL_FAM6_METEORLAKE_L, &cnl_features },
-	{ INTEL_FAM6_ARROWLAKE_H, &arl_features },
-	{ INTEL_FAM6_ARROWLAKE_U, &arl_features },
-	{ INTEL_FAM6_ARROWLAKE, &arl_features },
-	{ INTEL_FAM6_LUNARLAKE_M, &arl_features },
-	{ INTEL_FAM6_ATOM_SILVERMONT, &slv_features },
-	{ INTEL_FAM6_ATOM_SILVERMONT_D, &slvd_features },
-	{ INTEL_FAM6_ATOM_AIRMONT, &amt_features },
-	{ INTEL_FAM6_ATOM_GOLDMONT, &gmt_features },
-	{ INTEL_FAM6_ATOM_GOLDMONT_D, &gmtd_features },
-	{ INTEL_FAM6_ATOM_GOLDMONT_PLUS, &gmtp_features },
-	{ INTEL_FAM6_ATOM_TREMONT_D, &tmtd_features },
-	{ INTEL_FAM6_ATOM_TREMONT, &tmt_features },
-	{ INTEL_FAM6_ATOM_TREMONT_L, &tmt_features },
-	{ INTEL_FAM6_ATOM_GRACEMONT, &adl_features },
-	{ INTEL_FAM6_ATOM_CRESTMONT_X, &srf_features },
-	{ INTEL_FAM6_ATOM_CRESTMONT, &grr_features },
-	{ INTEL_FAM6_XEON_PHI_KNL, &knl_features },
-	{ INTEL_FAM6_XEON_PHI_KNM, &knl_features },
+	{ INTEL_NEHALEM, &nhm_features },
+	{ INTEL_NEHALEM_G, &nhm_features },
+	{ INTEL_NEHALEM_EP, &nhm_features },
+	{ INTEL_NEHALEM_EX, &nhx_features },
+	{ INTEL_WESTMERE, &nhm_features },
+	{ INTEL_WESTMERE_EP, &nhm_features },
+	{ INTEL_WESTMERE_EX, &nhx_features },
+	{ INTEL_SANDYBRIDGE, &snb_features },
+	{ INTEL_SANDYBRIDGE_X, &snx_features },
+	{ INTEL_IVYBRIDGE, &ivb_features },
+	{ INTEL_IVYBRIDGE_X, &ivx_features },
+	{ INTEL_HASWELL, &hsw_features },
+	{ INTEL_HASWELL_X, &hsx_features },
+	{ INTEL_HASWELL_L, &hswl_features },
+	{ INTEL_HASWELL_G, &hswg_features },
+	{ INTEL_BROADWELL, &bdw_features },
+	{ INTEL_BROADWELL_G, &bdwg_features },
+	{ INTEL_BROADWELL_X, &bdx_features },
+	{ INTEL_BROADWELL_D, &bdx_features },
+	{ INTEL_SKYLAKE_L, &skl_features },
+	{ INTEL_SKYLAKE, &skl_features },
+	{ INTEL_SKYLAKE_X, &skx_features },
+	{ INTEL_KABYLAKE_L, &skl_features },
+	{ INTEL_KABYLAKE, &skl_features },
+	{ INTEL_COMETLAKE, &skl_features },
+	{ INTEL_COMETLAKE_L, &skl_features },
+	{ INTEL_CANNONLAKE_L, &cnl_features },
+	{ INTEL_ICELAKE_X, &icx_features },
+	{ INTEL_ICELAKE_D, &icx_features },
+	{ INTEL_ICELAKE_L, &cnl_features },
+	{ INTEL_ICELAKE_NNPI, &cnl_features },
+	{ INTEL_ROCKETLAKE, &cnl_features },
+	{ INTEL_TIGERLAKE_L, &cnl_features },
+	{ INTEL_TIGERLAKE, &cnl_features },
+	{ INTEL_SAPPHIRERAPIDS_X, &spr_features },
+	{ INTEL_EMERALDRAPIDS_X, &spr_features },
+	{ INTEL_GRANITERAPIDS_X, &spr_features },
+	{ INTEL_LAKEFIELD, &cnl_features },
+	{ INTEL_ALDERLAKE, &adl_features },
+	{ INTEL_ALDERLAKE_L, &adl_features },
+	{ INTEL_RAPTORLAKE, &adl_features },
+	{ INTEL_RAPTORLAKE_P, &adl_features },
+	{ INTEL_RAPTORLAKE_S, &adl_features },
+	{ INTEL_METEORLAKE, &cnl_features },
+	{ INTEL_METEORLAKE_L, &cnl_features },
+	{ INTEL_ARROWLAKE_H, &arl_features },
+	{ INTEL_ARROWLAKE_U, &arl_features },
+	{ INTEL_ARROWLAKE, &arl_features },
+	{ INTEL_LUNARLAKE_M, &arl_features },
+	{ INTEL_ATOM_SILVERMONT, &slv_features },
+	{ INTEL_ATOM_SILVERMONT_D, &slvd_features },
+	{ INTEL_ATOM_AIRMONT, &amt_features },
+	{ INTEL_ATOM_GOLDMONT, &gmt_features },
+	{ INTEL_ATOM_GOLDMONT_D, &gmtd_features },
+	{ INTEL_ATOM_GOLDMONT_PLUS, &gmtp_features },
+	{ INTEL_ATOM_TREMONT_D, &tmtd_features },
+	{ INTEL_ATOM_TREMONT, &tmt_features },
+	{ INTEL_ATOM_TREMONT_L, &tmt_features },
+	{ INTEL_ATOM_GRACEMONT, &adl_features },
+	{ INTEL_ATOM_CRESTMONT_X, &srf_features },
+	{ INTEL_ATOM_CRESTMONT, &grr_features },
+	{ INTEL_XEON_PHI_KNL, &knl_features },
+	{ INTEL_XEON_PHI_KNM, &knl_features },
 	/*
 	 * Missing support for
-	 * INTEL_FAM6_ICELAKE
-	 * INTEL_FAM6_ATOM_SILVERMONT_MID
-	 * INTEL_FAM6_ATOM_AIRMONT_MID
-	 * INTEL_FAM6_ATOM_AIRMONT_NP
+	 * INTEL_ICELAKE
+	 * INTEL_ATOM_SILVERMONT_MID
+	 * INTEL_ATOM_AIRMONT_MID
+	 * INTEL_ATOM_AIRMONT_NP
 	 */
 	{ 0, NULL },
 };
@@ -1003,11 +1027,12 @@ void probe_platform_features(unsigned int family, unsigned int model)
 		return;
 	}
 
-	if (!genuine_intel || family != 6)
+	if (!genuine_intel)
 		return;
 
 	for (i = 0; turbostat_pdata[i].features; i++) {
-		if (turbostat_pdata[i].model == model) {
+		if (VFM_FAMILY(turbostat_pdata[i].vfm) == family &&
+		    VFM_MODEL(turbostat_pdata[i].vfm) == model) {
 			platform = turbostat_pdata[i].features;
 			return;
 		}
-- 
2.43.0


