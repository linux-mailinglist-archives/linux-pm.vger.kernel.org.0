Return-Path: <linux-pm+bounces-38836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A0CC8FFB9
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 20:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F09E4E539C
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 19:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4637F302155;
	Thu, 27 Nov 2025 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="Vv4DYNI2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD2279C8;
	Thu, 27 Nov 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270202; cv=none; b=EawYjJvxXaARc7vyQllj8BYpcaSWbhX4gxLiRfERdbH3lnH69cYyWQb087WcM5fALzuaWMF9CAGO2mUabHBRTopiJHcla8j8xTJvXRXvEOcrGPB8O3nIZZ5CTWQMGqIAEKG/2ywOMcHBtSF8uMeXw/Dh5aFUDbSzZnjGBefOGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270202; c=relaxed/simple;
	bh=wfgiRGOQLwiLM+4FUs/uJ61GxSLx10RXTN/JQQ7sn5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3S0rugkPSRXRpajkQqXAGUYr0KLLJQjVN3aJROKuDC1yExKitQbNnpTu/X1Xyx7lvyAR+gKhIaItrc9DtHxEdef4+/A+jLVo4Mmlgt1Dqdttdeu5IaV0+jjc5K0+RVvUKYoC/GDhAc/7R3NMMROnjT8l9dlxI82cvLiALfd8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=Vv4DYNI2; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560+5C/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1764270177; x=1765570177;
	bh=12NHg5mpkkfFuDbyCvK5djSM2M++P/Z48X9ciVtOpl4=; h=From;
	b=Vv4DYNI2rWg9QpBcBsDdAWrqJa5Wu67LMVgifVZOx5r4yu6PrSmW8afuQu5z7TMSJ
	 xnyrJvrsGi1/oOI7eVkD1IvZgzzkjgtpYdoJSctWaM+YodaneOmndrblSKjP5IysgI
	 zgjs5d/+jl8nZRwBIv5OYvk4xyz3RY+RlZcezbGwuZ7g6U3LbwV5qCNoJWOVQAZJOV
	 /nzojzoFyRQHF4Dwugu/1Z+dmRyWs75j4yobsFKv8HO9Ci7veMLN4tlKDoKin45PtP
	 KUc39RlSwV6RYes+Af14y/bk7fCpn5mgum03Mt2ZMZktr/smAXGKhOEgc6XdPyTGb6
	 ojQ0UMV4XEcbA==
Received: from localhost (nat2.prg.suse.com [195.250.132.146])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.18.1/8.18.1) with ESMTPS id 5ARJ2tWM008160
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 20:02:57 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>
Subject: [PATCH 2/2] pmdomain: add audio power island for Marvell PXA1908 SoC
Date: Thu, 27 Nov 2025 20:02:03 +0100
Message-ID: <20251127190237.745-2-balejk@matfyz.cz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251127190237.745-1-balejk@matfyz.cz>
References: <20251127190237.745-1-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****

Define power domain which needs to be enabled in order for audio to work
on the PXA1908-based samsung,coreprimevelte smartphone. In the
downstream code, this power-on method is marked as specific to the ulcx
series which is likely some variant of the board or some part of it. No
other audio components needed for sound to work on this phone are
currently available mainline but some successful testing was performed
with the vendor variants of the respective drivers and with the domain
forced always-on.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 .../marvell/pxa1908-power-controller.c        | 38 +++++++++++++++++--
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/marvell/pxa1908-power-controller.c b/drivers/pmdomain/marvell/pxa1908-power-controller.c
index ff5e6e82d3f8..e32eb227f235 100644
--- a/drivers/pmdomain/marvell/pxa1908-power-controller.c
+++ b/drivers/pmdomain/marvell/pxa1908-power-controller.c
@@ -29,7 +29,10 @@
 #define POWER_POLL_TIMEOUT_US	(25 * USEC_PER_MSEC)
 #define POWER_POLL_SLEEP_US	6
 
-#define NR_DOMAINS	5
+#define APMU_AUD_CLK		0x80
+#define AUDIO_ULCX_ENABLE	0x0d
+
+#define NR_DOMAINS	6
 
 #define to_pxa1908_pd(_genpd) container_of(_genpd, struct pxa1908_pd, genpd)
 
@@ -59,9 +62,13 @@ static inline bool pxa1908_pd_is_on(struct pxa1908_pd *pd)
 {
 	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
 
-	return pd->data.id != PXA1908_POWER_DOMAIN_DSI
-		? regmap_test_bits(ctrl->base, APMU_PWR_STATUS_REG, pd->data.pwr_state)
-		: regmap_test_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
+	switch (pd->data.id) {
+	case PXA1908_POWER_DOMAIN_AUDIO:
+		return regmap_test_bits(ctrl->base, APMU_AUD_CLK, AUDIO_ULCX_ENABLE);
+	case PXA1908_POWER_DOMAIN_DSI:
+		return regmap_test_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
+	}
+	return regmap_test_bits(ctrl->base, APMU_PWR_STATUS_REG, pd->data.pwr_state);
 }
 
 static int pxa1908_pd_power_on(struct generic_pm_domain *genpd)
@@ -123,6 +130,22 @@ static inline int pxa1908_dsi_power_off(struct generic_pm_domain *genpd)
 	return regmap_clear_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
 }
 
+static inline int pxa1908_audio_power_on(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = to_pxa1908_pd(genpd);
+	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
+
+	return regmap_set_bits(ctrl->base, APMU_AUD_CLK, AUDIO_ULCX_ENABLE);
+}
+
+static inline int pxa1908_audio_power_off(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = to_pxa1908_pd(genpd);
+	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
+
+	return regmap_clear_bits(ctrl->base, APMU_AUD_CLK, AUDIO_ULCX_ENABLE);
+}
+
 #define DOMAIN(_id, _name, ctrl, mode, state) \
 	[_id] = { \
 		.data = { \
@@ -159,6 +182,13 @@ static struct pxa1908_pd domains[NR_DOMAINS] = {
 			.keep_on = true,
 		},
 	},
+	[PXA1908_POWER_DOMAIN_AUDIO] = {
+		.genpd = {
+			.name = "audio",
+			.power_on = pxa1908_audio_power_on,
+			.power_off = pxa1908_audio_power_off,
+		},
+	},
 };
 
 static void pxa1908_pd_remove(struct auxiliary_device *auxdev)
-- 
2.51.2


