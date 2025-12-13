Return-Path: <linux-pm+bounces-39479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D960CBA74A
	for <lists+linux-pm@lfdr.de>; Sat, 13 Dec 2025 09:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5097530698F0
	for <lists+linux-pm@lfdr.de>; Sat, 13 Dec 2025 08:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C52F2C11C7;
	Sat, 13 Dec 2025 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="DdbAFa9h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27065248880;
	Sat, 13 Dec 2025 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765615792; cv=none; b=oT2xYUUnVGXAWg928Jd2TnN+aU/VW/J9qqfXumTaJuP5OVqTK8OtZkrAcRG5W4eJQpFRwSRadIQIOJv2Bvid/9glq2kxjX+9xB/RUHWYOGnhiag9zQfMQUjRTKYWLxDAmL5Bn2BzM0nkxW5lY+cJsE/sFaMy2CS5+suDnGgwkTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765615792; c=relaxed/simple;
	bh=BzPUFq1qO+L33vQKBf6t9fZkXo642dR1D7b6QKM2WZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZmEWLTUzpG630X0Hh+VyIT/z61V4L8jcXbt0eW+R27pi1OTDVbjbX/bHRsyIihKiISkZ8w+fVlWHFZn5ucKbO+4k4TEH0xpltZQwo06jBSgBrXfUq6wJ3p7PyYV7p31wxyTzyORwAbBrInDjoV5BK/J/L+hl1PwIDCKkq6Tb/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=DdbAFa9h; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560+5C/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1765615745; x=1766915745;
	bh=S9RqYk1apuuSaVqcDeaTaZWQ548F3KY11GTRUevi5ZA=; h=From;
	b=DdbAFa9hSPUjoXS9bXykkVGBIEWHZbxM+Ib1d0uG1vcbFmmLUAzp+zN+fuHqjVrfn
	 5IbtmafoU10o7bOb8C/hVzS5JVyDxT5M0eC/QSkWhqjWHssfLTFtflcrXPnXWj2xDD
	 e7MPIS672KpAQFm156W8xbX/J/st+sMy+fD6jEIyzYVaeqGiJ+Y7sqVQ5m5xdqhmxQ
	 /S/2nQ06BVVCW5O1kQdEKV/+Ms7Fl4C/TzLQVpKQkQQQ+6T9WoTuOa/bjv3IrRbrDB
	 l5hNee6ef+6mXwUTmKWnCNpXXFTXnwqgW4w2L/zc4dcJnypoRhqdQs1sDVLaoVsELH
	 WeJO2fjXaxm6Q==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.18.1/8.18.1) with ESMTPS id 5BD8n3tP051961
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sat, 13 Dec 2025 09:49:05 +0100 (CET)
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
Subject: [PATCH v2 2/2] pmdomain: add audio power island for Marvell PXA1908 SoC
Date: Sat, 13 Dec 2025 09:48:13 +0100
Message-ID: <20251213084843.7491-2-balejk@matfyz.cz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251213084843.7491-1-balejk@matfyz.cz>
References: <20251213084843.7491-1-balejk@matfyz.cz>
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
downstream code, this power-on method is marked as specific to the ULCx
series which is allegedly a codename of sorts with ULC1 corresponding to
the PXA1908.

No other audio components needed for sound to work on this phone are
currently available mainline but some successful testing was performed
with the vendor variants of the respective drivers and with the domain
forced always-on.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v2:
    - APMU_AUD_CLK -> APMU_AUDIO_CLK and group it with other register
      definitions. (Duje)
    - Move default function exit path inside the switch. (Duje)
    - Modify the commit message with information provided by Duje (thanks!).

 .../marvell/pxa1908-power-controller.c        | 39 +++++++++++++++++--
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/marvell/pxa1908-power-controller.c b/drivers/pmdomain/marvell/pxa1908-power-controller.c
index ff5e6e82d3f8..543e8d33ac0c 100644
--- a/drivers/pmdomain/marvell/pxa1908-power-controller.c
+++ b/drivers/pmdomain/marvell/pxa1908-power-controller.c
@@ -24,12 +24,15 @@
 #define APMU_DEBUG		0x88
 #define DSI_PHY_DVM_MASK	BIT(31)
 
+#define APMU_AUDIO_CLK		0x80
+#define AUDIO_ULCX_ENABLE	0x0d
+
 #define POWER_ON_LATENCY_US	300
 #define POWER_OFF_LATENCY_US	20
 #define POWER_POLL_TIMEOUT_US	(25 * USEC_PER_MSEC)
 #define POWER_POLL_SLEEP_US	6
 
-#define NR_DOMAINS	5
+#define NR_DOMAINS	6
 
 #define to_pxa1908_pd(_genpd) container_of(_genpd, struct pxa1908_pd, genpd)
 
@@ -59,9 +62,14 @@ static inline bool pxa1908_pd_is_on(struct pxa1908_pd *pd)
 {
 	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
 
-	return pd->data.id != PXA1908_POWER_DOMAIN_DSI
-		? regmap_test_bits(ctrl->base, APMU_PWR_STATUS_REG, pd->data.pwr_state)
-		: regmap_test_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
+	switch (pd->data.id) {
+	case PXA1908_POWER_DOMAIN_AUDIO:
+		return regmap_test_bits(ctrl->base, APMU_AUDIO_CLK, AUDIO_ULCX_ENABLE);
+	case PXA1908_POWER_DOMAIN_DSI:
+		return regmap_test_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
+	default:
+		return regmap_test_bits(ctrl->base, APMU_PWR_STATUS_REG, pd->data.pwr_state);
+	}
 }
 
 static int pxa1908_pd_power_on(struct generic_pm_domain *genpd)
@@ -123,6 +131,22 @@ static inline int pxa1908_dsi_power_off(struct generic_pm_domain *genpd)
 	return regmap_clear_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
 }
 
+static inline int pxa1908_audio_power_on(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = to_pxa1908_pd(genpd);
+	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
+
+	return regmap_set_bits(ctrl->base, APMU_AUDIO_CLK, AUDIO_ULCX_ENABLE);
+}
+
+static inline int pxa1908_audio_power_off(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = to_pxa1908_pd(genpd);
+	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
+
+	return regmap_clear_bits(ctrl->base, APMU_AUDIO_CLK, AUDIO_ULCX_ENABLE);
+}
+
 #define DOMAIN(_id, _name, ctrl, mode, state) \
 	[_id] = { \
 		.data = { \
@@ -159,6 +183,13 @@ static struct pxa1908_pd domains[NR_DOMAINS] = {
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


