Return-Path: <linux-pm+bounces-43805-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCW5FE7EqmnhWwEAu9opvQ
	(envelope-from <linux-pm+bounces-43805-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:10:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F722203C1
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 619BC303E328
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 12:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5339D38E5DD;
	Fri,  6 Mar 2026 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm/F7Yry"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C702E38E5CC
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798831; cv=none; b=KPjnJpQ+x2WqIs2wxjKjArLwt+NgXAXD0zLtyqxjClzCW5nLXLWTvXdBs9uzxSew2hmNKSNK7KWlnQxlfMjiAoslS4vHv4HxKgeqQXY099vnp+SHh8q5B+W7Sn70sSW5OIlvruhpbB216wC8fMGp3xA1hovNx0MFHQC8oU9Jmlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798831; c=relaxed/simple;
	bh=fW2pEq4Cji8dD0Hh/gE2qYrgIEWkc9Og8y/3NnzjrqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRMadHQrZwzGCayQr3Uz9/tRhX5WXMKYQsy5lzvi+lNw/neyDJSRBOjiOTd4aF7F5UftRT1v0R+2vclThg8w55eyKQCVsibkPe3vQikdEhWHO18X0FQ67SAbMeYgBFT407G0RlYZmFd2kCyb5FTw7slE2uOLXJ99EjKRcblpkK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm/F7Yry; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b73f4ab4so5978251f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 04:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772798828; x=1773403628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlP4+/T8HO4OS9CBYj2Xq6DuqZPRSrnhT+fSfVGyrPw=;
        b=Lm/F7YryunauMMLTkTo65VhtI5x0hNm7SE9fuj24ABjoqOir9dFoHrNTJkN8Fd9DJq
         2683aUI7jAe9c6eZHsroKuwqW1pfxm8libTDcL2MftNj9ul6OS8R11GA7Zsl9wpu8HVh
         PNPIMj0jBgiZj0Ki8+fid0qyL5vt6/bMfh/BDpAzToOR6PKpp51iXo8Ye8ML69n9z3V/
         /FCExhrLoHkjIWSPyK68Ehypx/XFFYXYQdDLBxzqdwxb20zJrk1BQLsKuVsoMaG55J8o
         GR4XLQwguxQx5j9sA5lv4L0L7cSD69BrrL7pc7URry5yJiYitTI+Y1ch/PuOKkTvAywp
         ARvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798828; x=1773403628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SlP4+/T8HO4OS9CBYj2Xq6DuqZPRSrnhT+fSfVGyrPw=;
        b=jepmkvw/Z7FJEKGZFEvGDW1vjajjtytUQFv1Dcvg8s62YOxGQZaqMCQshwx5iKVbDL
         9SNMtyKDJIz7OFXgAi3VtB226pun5OqxNUJni2lvxvkSmipkpKD68XhdpW6PR55DVvcG
         HlGv/PC0VyMFdEQ/mJ0lSKKzUqRxwHy4DrWCrM8r+qFljQYKLbmpQ7kaqw8AmTuLwlCu
         KYG7d5rCJqBdKnFHzWDMQWPzhCf+JCsb9fUjDNpcGd4mctqkB1uGAKsampXRytJNprH5
         xSoN6tH07ZmZYFzAJn9Oz6z9znPkJX/MJ0QkepZPQdX4fL1PGmruEbmEwjpLIHXkBBH+
         p23Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwC8z8GQMD0vIcid4KL0QjFP/KQuVBdlwdcHFqehr9Z/hdG1Yj43P6iXQuUysCSOi/bdS6WU7PmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfbXPEI81EsM444iTgueolAtzdtlJ/mIMOsI1cE0k8X6t3sovl
	gjm8d2MsJHWTdSwaNzt1MKm0/5wq3Iz4Y3BnJHk35xF4SF4NPdFhhd2h
X-Gm-Gg: ATEYQzz/ZDHL5tsGRFd67mKNKyJqUAWIGWSza8uL4x0dLmLvYhjipfEypOdPCs/eIHk
	gWwZoECW22ivePJrsp+dt4VTlB0Ni/1DZvrgRmMFsXxrZTHfnETc3808IE5joW47iYTP+Bu8XXR
	a5NNwcaFaQUNl7bux1Kkqxp62KCK8SxcXcNpt8z8ASPXznp8x3ZnfpPO37IhUuESeHxIt9i7R4g
	wywxJ8MVxBbVmW+SUP1Gaw+jd63rC2iIAlmYBD448Z/PeFywRQTO0tdG+WksqJ+thNvdK6lXGyb
	gFAln/KPogzwg+2NlYv7DEbjo2ZM1gXtp4arO2zv4Cln8KveTh/2NMfoWv+r7uUCpGez7eSWwV1
	1QdxXwdurtqbSstxKCiX70LZyNwOOtfj1rguxkHoZfHK97+9MNlSqk/FM6a08wA9i+B8Ccb+zRo
	r1LXrdxY05FUxFDHDQf+I=
X-Received: by 2002:a05:6000:4205:b0:439:c9d0:5fd4 with SMTP id ffacd0b85a97d-439da656affmr3257347f8f.16.1772798827969;
        Fri, 06 Mar 2026 04:07:07 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9d8sm3457225f8f.21.2026.03.06.04.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:07:07 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 7/7] arm64: dts: mt6392: add mt6392 PMIC dtsi
Date: Fri,  6 Mar 2026 12:03:11 +0000
Message-ID: <20260306120521.163654-8-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306120521.163654-1-l.scorcia@gmail.com>
References: <20260306120521.163654-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 52F722203C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43805-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[packett.cool,gmail.com,kernel.org,mediatek.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lscorcia@gmail.com,linux-pm@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,packett.cool:email]
X-Rspamd-Action: no action

From: Val Packett <val@packett.cool>

Add the dts to be included by all boards using the MT6392 PMIC.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6392.dtsi | 134 +++++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
new file mode 100644
index 000000000000..c7e54c30bc3a
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Copyright (c) 2024 Val Packett <val@packett.cool>
+ */
+
+#include <dt-bindings/input/input.h>
+
+&pwrap {
+	pmic: pmic {
+		compatible = "mediatek,mt6392", "mediatek,mt6323";
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		regulators {
+			compatible = "mediatek,mt6392-regulator";
+
+			mt6392_vproc_reg: buck_vproc {
+				regulator-name = "vproc";
+			};
+
+			mt6392_vsys_reg: buck_vsys {
+				regulator-name = "vsys";
+			};
+
+			mt6392_vcore_reg: buck_vcore {
+				regulator-name = "vcore";
+			};
+
+			mt6392_vxo22_reg: ldo_vxo22 {
+				regulator-name = "vxo22";
+			};
+
+			mt6392_vaud22_reg: ldo_vaud22 {
+				regulator-name = "vaud22";
+			};
+
+			mt6392_vcama_reg: ldo_vcama {
+				regulator-name = "vcama";
+			};
+
+			mt6392_vaud28_reg: ldo_vaud28 {
+				regulator-name = "vaud28";
+			};
+
+			mt6392_vadc18_reg: ldo_vadc18 {
+				regulator-name = "vadc18";
+			};
+
+			mt6392_vcn35_reg: ldo_vcn35 {
+				regulator-name = "vcn35";
+			};
+
+			mt6392_vio28_reg: ldo_vio28 {
+				regulator-name = "vio28";
+			};
+
+			mt6392_vusb_reg: ldo_vusb {
+				regulator-name = "vusb";
+			};
+
+			mt6392_vmc_reg: ldo_vmc {
+				regulator-name = "vmc";
+			};
+
+			mt6392_vmch_reg: ldo_vmch {
+				regulator-name = "vmch";
+			};
+
+			mt6392_vemc3v3_reg: ldo_vemc3v3 {
+				regulator-name = "vemc3v3";
+			};
+
+			mt6392_vgp1_reg: ldo_vgp1 {
+				regulator-name = "vgp1";
+			};
+
+			mt6392_vgp2_reg: ldo_vgp2 {
+				regulator-name = "vgp2";
+			};
+
+			mt6392_vcn18_reg: ldo_vcn18 {
+				regulator-name = "vcn18";
+			};
+
+			mt6392_vcamaf_reg: ldo_vcamaf {
+				regulator-name = "vcamaf";
+			};
+
+			mt6392_vm_reg: ldo_vm {
+				regulator-name = "vm";
+			};
+
+			mt6392_vio18_reg: ldo_vio18 {
+				regulator-name = "vio18";
+			};
+
+			mt6392_vcamd_reg: ldo_vcamd {
+				regulator-name = "vcamd";
+			};
+
+			mt6392_vcamio_reg: ldo_vcamio {
+				regulator-name = "vcamio";
+			};
+
+			mt6392_vm25_reg: ldo_vm25 {
+				regulator-name = "vm25";
+			};
+
+			mt6392_vefuse_reg: ldo_vefuse {
+				regulator-name = "vefuse";
+			};
+		};
+
+		rtc {
+			compatible = "mediatek,mt6392-rtc",
+				"mediatek,mt6397-rtc";
+		};
+
+		keys {
+			compatible = "mediatek,mt6392-keys";
+
+			key-power {
+				linux,keycodes = <KEY_POWER>;
+				wakeup-source;
+			};
+
+			key-home {
+				linux,keycodes = <KEY_HOME>;
+				wakeup-source;
+			};
+		};
+	};
+};
-- 
2.43.0


