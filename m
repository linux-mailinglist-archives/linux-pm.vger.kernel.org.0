Return-Path: <linux-pm+bounces-43229-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICQ6Ng3gn2lLegQAu9opvQ
	(envelope-from <linux-pm+bounces-43229-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 06:54:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 849251A121F
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 06:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8687130A3CF6
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 05:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915C038B7BD;
	Thu, 26 Feb 2026 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T/ZXRGEQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6E838A738
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772085201; cv=none; b=lkJSOsEE1mhgM5lfJkHCyWl5XRvW8oeNFwZBRammI1MYwG9oIO3rxP4ErH4/9D2ST++SyoReGak+9KcCF2BJynORKjnoflOGNCG2c4wDVEjbDg1wCKKcvpeX+zxZcu0I9rGRzb/1gVMJ6yKBzablBlyKpGA0lks0JNxCfgyK4dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772085201; c=relaxed/simple;
	bh=LfhQDPGS3jOh7xhVxS4sehprRV4qazzcCsUCb66y5Hw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NHi8VDkxtNmB8xZLmM8Xac3BeqTOknEiBJkAIbn2P+v4XRROROF5L4eQ0mPf9A1vKys3vXxCt0ukesc0raqKtorOplIjb+/SAD2MD6aTaySEQ/6ikmjgtCNB3I0PpTpO8eq3L4nRESLWDkFU0raQUnUnxZ7Y6OFi2PUk4bh/NWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T/ZXRGEQ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1273886efc6so505249c88.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 21:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772085198; x=1772689998; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cFC9qEvebwSLDfjL8YA0PaUI3cLmvAY/JQ63j4juSKA=;
        b=T/ZXRGEQCXFViHtJ/BlxD3SE5ElWDg44jPLsIVzvsmgzj0S6LG5JwFT6R3wjQhfmGd
         9gL8cvfKXakRiQCoc1KE7h0/0ooP/nfGAeSgFJGnWVwseBjSlAFCK7e80wmga8/ouTEy
         ziacAg7vSWFWOOFWOg9+itkYXzD8k9Tzw7AnIL14HoRdLVQFlS81tCaz0F0a98J0O/vz
         xfxf5N20a8zcgldplHKM0PYgV80BOKF/TG4dFnNUxi2NQOGXQlzvffmmHXVQW9bMFiVc
         +AVmKwHPyEtHuHFgogSjBjAL21U/h4dFgPf0IMJyfifPD25V8N6zqG+E/qNwZRArmFWW
         xZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772085198; x=1772689998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFC9qEvebwSLDfjL8YA0PaUI3cLmvAY/JQ63j4juSKA=;
        b=K630dhM6rFYwJSBetaICS+W0WsAovlfFSSoQlFHcZjBDMS9X5M9o6r4JSMU91NLSmT
         EZJFeOfHkG3u+CcN2UciYYxAQWQ6HOhFuHZKrHQLMAbtLFDMy6C+C+dq/R9Sw5HOSntO
         hZjSt2mikv+68P6xlVwu9O4JRwYN6vi5kOJJIcMbmMJXcjrj2xlJpmFIVoo80dZCrToI
         DexNW8BzGPvxlvxrTEQo4cyDwPy+3HdMUkQ4g77oRUZHBwbFfPYB3sFc8w8UC0OKv5E4
         nqYU+xgGiNlhDlPBR27cSPLsNyzhhpMC/BOx58qNbMK1ptvTU2/NPAesbU99PF/5/fy5
         MufA==
X-Forwarded-Encrypted: i=1; AJvYcCWFPPzWCRAU9XSDu+ogbfaL3kjXj0Ly3pohq6ZT2emzSR22JpNKFfbZ650vQPS8gs+kb3/NF4zGnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvn6Ae0G1Sl1FWzXhJdCF7gluhQ7DO9lc5l8LqGtHG8Ymo+H8v
	Lw7F1CmwYI1zbsLMEJPQe+fVSzDVuGL5YeNhPP/ugQInmGPvxoij4Va05lMCrgDdx6zEXFgIyDH
	SrueBeQ==
X-Received: from dlbcm15.prod.google.com ([2002:a05:7022:688f:b0:127:335b:9077])
 (user=badhri job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2216:b0:124:b11f:67ec
 with SMTP id a92af1059eb24-127869c256cmr1193427c88.39.1772085198007; Wed, 25
 Feb 2026 21:53:18 -0800 (PST)
Date: Thu, 26 Feb 2026 05:53:09 +0000
In-Reply-To: <20260226055311.2591357-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226055311.2591357-1-badhri@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226055311.2591357-2-badhri@google.com>
Subject: [PATCH v1 1/3] dt-bindings: connector: Add SPR AVS Sink APDO definitions
From: Badhri Jagan Sridharan <badhri@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Sunil Dhamne <amitsd@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43229-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[badhri@google.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 849251A121F
X-Rspamd-Action: no action

USB Power Delivery 3.2 introduces a new power supply type SPR AVS.
Add macro definitions for the USB Power Delivery (PD)
Standard Power Range (SPR) Adjustable Voltage Supply (AVS) as a
Sink Augmented Power Data Object (APDO) in the device tree bindings.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 .../bindings/connector/usb-connector.yaml      |  5 +++--
 include/dt-bindings/usb/pd.h                   | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 901986de3e2b..a00b239960a3 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -364,8 +364,9 @@ $defs:
           "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
           Sink Capabilities Message, the order of each entry(PDO) should follow the
           PD spec chapter 6.4.1. Required for power sink and power dual role. User
-          can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
-          in dt-bindings/usb/pd.h.
+          can specify the sink PDO array via
+          PDO_FIXED/BATT/VAR/PPS_APDO/SPR_AVS_SNK_APDO() defined in
+          dt-bindings/usb/pd.h.
         minItems: 1
         maxItems: 7
         $ref: /schemas/types.yaml#/definitions/uint32-array
diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
index 6cff2339bda3..1e64a1f563f9 100644
--- a/include/dt-bindings/usb/pd.h
+++ b/include/dt-bindings/usb/pd.h
@@ -60,6 +60,7 @@
 	 PDO_VAR_MAX_VOLT(max_mv) | PDO_VAR_MAX_CURR(max_ma))
 
 #define APDO_TYPE_PPS		0
+#define APDO_TYPE_SPR_AVS	2
 
 #define PDO_APDO_TYPE_SHIFT	28	/* Only valid value currently is 0x0 - PPS */
 #define PDO_APDO_TYPE_MASK	0x3
@@ -85,6 +86,23 @@
 	 PDO_PPS_APDO_MIN_VOLT(min_mv) | PDO_PPS_APDO_MAX_VOLT(max_mv) |	\
 	 PDO_PPS_APDO_MAX_CURR(max_ma))
 
+#define PDO_SPR_AVS_APDO_9V_TO_15V_MAX_CURR_SHIFT	10	/* 10mA units */
+#define PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR_SHIFT	0	/* 10mA units */
+#define PDO_SPR_AVS_APDO_MAX_CURR_MASK			0x3ff
+
+#define PDO_SPR_AVS_APDO_9V_TO_15V_MAX_CURR(max_cur_9v_to_15v_ma)		\
+	((((max_cur_9v_to_15v_ma) / 10) & PDO_SPR_AVS_APDO_MAX_CURR_MASK) <<	\
+	PDO_SPR_AVS_APDO_9V_TO_15V_MAX_CURR_SHIFT)
+
+#define PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR(max_cur_15v_to_20v_ma)		\
+	((((max_cur_15v_to_20v_ma) / 10) & PDO_SPR_AVS_APDO_MAX_CURR_MASK) <<	\
+	PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR_SHIFT)
+
+#define PDO_SPR_AVS_SNK_APDO(max_cur_9v_to_15v_ma, max_cur_15v_to_20v_ma)	\
+	(PDO_TYPE(PDO_TYPE_APDO) | PDO_APDO_TYPE(APDO_TYPE_SPR_AVS) |		\
+	PDO_SPR_AVS_APDO_9V_TO_15V_MAX_CURR(max_cur_9v_to_15v_ma) |		\
+	PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR(max_cur_15v_to_20v_ma))
+
  /*
   * Based on "Table 6-14 Fixed Supply PDO - Sink" of "USB Power Delivery Specification Revision 3.0,
   * Version 1.2"
-- 
2.53.0.414.gf7e9f6c205-goog


