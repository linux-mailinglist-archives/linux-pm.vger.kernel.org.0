Return-Path: <linux-pm+bounces-42910-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HiRFI0nmGlqBwMAu9opvQ
	(envelope-from <linux-pm+bounces-42910-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 10:21:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF22616622D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 10:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 138CC3069AED
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 09:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB53242DD;
	Fri, 20 Feb 2026 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="iaAcC00L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CED2320A0C
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579158; cv=none; b=N0Mn5nwMFv9R0BqIqrC1F34+KfzsxhClqKb9vkWRtRRE1BaXdwsPFwe5TSwYtOuCbUNWwx4g2wT0bRvXThC4OsXsUTF7WCeLjxyRA05pmqR31Mh8BRKfTHJmW+uoJBII5kSDxBj5iL5LCVjf2G5TdEsKIWBFojnR0+HpHkk3lIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579158; c=relaxed/simple;
	bh=C+wsarVI55ZZRQ3B5XA+RMI2p40E5xuzn687URb4gIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WeiU9Hy4n7pcSideEWdX1jeDcSqzX4yH3e1mfYeFCoM3f2k45ZRsWgWgg/oguP4sp5SA3KrNYbtKa7sIf3IBldfvRXkK2UL/y97ORDKdESUFDa7F/PvGCUwFPn3fGvA1bvNZPOOV0QkdDpnweTyrNRiE/iJVVN84wZ62g8GJqow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=iaAcC00L; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b884a84e622so291445066b.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 01:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771579155; x=1772183955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6F37dsCD+l3Kjiw05UW38NxOXviWKT0380mYL15ak4=;
        b=iaAcC00LodtDz/r4vB+VTwoeWfpGCyQrFsYFj91kPksn2uYUwl0oLdm1Y3bJuQcmyh
         /t7R96eK34WUvAtIxI42JeW0vhs8RpFvOqN5alRsbzuSTda5dlC28zuuER/aQ8MzpaEI
         ULeGO9eD1iTZQOYoFo5XhemBGdl28Q9jRUZeTJqrfBMzwWFZYoa26eYhF9u8+KHEXHyl
         E0BTC6WpeiCX/f3EE6GgSRB1B8dSROAoyr4rd3gy1DxGXCCcup2LKE0xUFq14OpVsS56
         5NyHf26vXjju4yn0eLFUj4F6uEuCl2jFgi8nBGkVrW/w2c8iw1B8GRPRvNI4Y/fzC3KM
         uKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771579155; x=1772183955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u6F37dsCD+l3Kjiw05UW38NxOXviWKT0380mYL15ak4=;
        b=MxTOlTay0ioJ1hyfPPUlGKXVytVOAwnc7lu7RVLprzlvttnF/U92L8ADeYr8JSzYto
         agCLs8l3W/yFw9fQ+/ACAm7IoOg4hcXYnu1JiJp7nLcmEPDsX3fieDJ0AEXLrAWRxtH7
         IQNFPvEqZBr/tSYip0E38bHRr1hp7WERq4cYffeMOjNtNbQkBZuqpF71YvOT99b+68FW
         oGJxsaZ8ThGD9F3QoLR8rrdAybdQNNxTe9bvZf1AQLLN09v3udpGcYdWrKlFCYSmwEOK
         tv1ct3TZr6ieF8mF7tRgqI9IO2U5+PcwXt5gxtIlCD5ZO7FHw03TqLwUwuorg7fBY4c2
         B+5A==
X-Forwarded-Encrypted: i=1; AJvYcCWpbW6RKDCfyM9XzbBZRa17poO4ZLxfhKeMb45tBMhE9LTpYC6vc9lLpR71B8aloEbNYVmyFeYJYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxez89qaCOV+bKqN3XefYfppq+Otbrk+tHuLKf6/XNsThGtRvl7
	KI3qJzcQMUo3ENjJMm6xhHsDyIXAYTAH4lJ8Udv0H7kUMP1UmM4CIYsjEV/5d67arag=
X-Gm-Gg: AZuq6aI1dqTqaJYcssm0Yf1WP9LnIqBpH5H3Hs/+q6XoYBtBu0PkQ0ijvdRZIzn1sYk
	NNUT6dcvBMSS0yz/fkiLf9NGoXTFucKVmJ3nUbp30bAoMbGlaHLVEs99SO08vDGRy074M9ps5K2
	gsVzUNshwQBOtH0BNbHTb8w0lF/UHGXWicGf7ag/R38VnmG5XDcuM4T7oxd782iyjsVoy7zD/zM
	CQtUX5PGQo7FoqIxmtHbZd4ECAwJQMPhnr6FWeToOkbin+Q5Gmkwn+pSw2yxaozWrUdiRdLlBmr
	gG5/cFV9nXGBJ6oCijSb/5C8di9qOXF5NcWJtTXKNAUIiaxsFDUVigFRmyengjLU4blH8XmXE1M
	NiCVymaZ4eSD5cHAoqrZG//RSzFiREp8iRG0qRKWCWmWgYhKWugpWxX7+k275fBp54ZOrop9Gcu
	9OmA8hBsCimWPl9AuISVztbCB+dP/wE57fSlieP5+5M0m3O32DsK2h16WcTs/v0XvTCj+PfCuHK
	w/xSQ==
X-Received: by 2002:a17:907:86ac:b0:b87:3c4a:e68a with SMTP id a640c23a62f3a-b9072e7a717mr62188166b.9.1771579154631;
        Fri, 20 Feb 2026 01:19:14 -0800 (PST)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc769111fsm667098666b.57.2026.02.20.01.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 01:19:14 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Feb 2026 10:19:08 +0100
Subject: [PATCH v2 4/5] arm64: dts: qcom: pm7250b: Define battery
 temperature ADC channels
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-bat-temp-adc-v2-4-fe34ed4ea851@fairphone.com>
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
In-Reply-To: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771579150; l=1351;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=C+wsarVI55ZZRQ3B5XA+RMI2p40E5xuzn687URb4gIE=;
 b=T4QbfcfFNBuzPHyJEr/F2U8LVosN8lPbSUjMYubLbaa2KgB748SbdekHcjXI0agmKW1SoNgGy
 vLJ7EthvVKhBSFCWTH42xcBLl0ss7sWNlc20UjjFtalqtW2vF3aSf04
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42910-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[fairphone.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.83:email,1e:email,fairphone.com:mid,fairphone.com:dkim,fairphone.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,4b:email,2a:email,6a:email]
X-Rspamd-Queue-Id: BF22616622D
X-Rspamd-Action: no action

Add the definition for these ADC channels to the PM7250B definition.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm7250b.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index 0761e6b5fd8d..c96089520548 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -156,6 +156,22 @@ channel@1e {
 				label = "chg_mid";
 			};
 
+			channel@2a {
+				reg = <ADC5_BAT_THERM_30K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_therm_30k";
+			};
+
+			channel@4a {
+				reg = <ADC5_BAT_THERM_100K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_therm_100k";
+			};
+
 			channel@4b {
 				reg = <ADC5_BAT_ID_100K_PU>;
 				qcom,hw-settle-time = <200>;
@@ -164,6 +180,14 @@ channel@4b {
 				label = "bat_id";
 			};
 
+			channel@6a {
+				reg = <ADC5_BAT_THERM_400K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_therm_400k";
+			};
+
 			channel@83 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,pre-scaling = <1 3>;

-- 
2.53.0


