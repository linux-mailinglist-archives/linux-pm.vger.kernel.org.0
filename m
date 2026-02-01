Return-Path: <linux-pm+bounces-41848-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH0sD4wuf2kZlQIAu9opvQ
	(envelope-from <linux-pm+bounces-41848-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:44:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C90C579E
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 664E03017511
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 10:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2D3324B1D;
	Sun,  1 Feb 2026 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi32/ymp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789C322B77
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942655; cv=none; b=EN/7pgZYXnt5Eijhn5ALWA9zKwggr4M52JDd6i37jbnpzq+jmFQeYg6DdTHR2VFzwK/DV2uSXBbN+P04SgnUCdILn94IQNoVR6uJFVxdfkPy/HVYw01lWd+phzu4Xlh2vQxmnqlVEmgCLQ+eLIst0nOH6MxxkZS7WY8o0nUVIE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942655; c=relaxed/simple;
	bh=UgzLW6WQiFkkdi/rFQy7Nb0uewdDPhiTeLJ7Dkher+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FW8wvBZgCUXqW/Aw/NDZSlEg45j/U3Fv8JhsfJk9P2NlkaGxskChCDflxm4yCyT1Pmk1Fal1T5tqghzfz0Nih7HMKZA2/ddYaebq2cNNqQx8sGSiWwlf5BI5ek3zD1jiypp6ZqK4TkEoRZX+jC8z2cNMQBjmjLuaePGiMPEP3+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mi32/ymp; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so2915417f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 02:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769942652; x=1770547452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P47K2h9cgKb+6dAIX40zG1TXVWmp99RTsx0ZYM/JpXo=;
        b=mi32/ympP84VZQtzjCebifnr0b+nnojEj/gnlhdcwM+DLmeUkYD1DGZNucDFJ2LNay
         Ewf0aOXHkYYYmMnAPGolNFJy2rwYe9XHlqrA2+z5YUo5/NXNH/DyhLZkSk3cL2sVJagL
         scQo1KPbjC77jq0Pr855DyS7WXszv72VjrJJa5xu+ziHOTZ3HwcZ9qpBJZr683M+yXjx
         ORrz0Ii3GQ1y1hNAbrPrdKs4NC3gwYgfuP1wUDlKGuj9a1gDFvt3C+LYokHnka1haR7y
         +0823bdpL06D8DGAC0z1FU5lM8GxmxiFws/cGf5QmPpB1Fvao/tr++000Lsq2OrlX6lt
         nz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942652; x=1770547452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P47K2h9cgKb+6dAIX40zG1TXVWmp99RTsx0ZYM/JpXo=;
        b=OSB2DSSQ0vANDDjMPDVF7QPyHwTXzUDR1oNpktjzPQ3GRxzuvpB5RVqtsB58aO3M0a
         CzoKSztz3ZqimVppDsK+v6jjJsyWdEl41LmcHX9eXIwIP1bGNvcJ9bLAPGfX3OEzbqdg
         qJyQEuts5rLsUHhJMpkknipns490/GFGAQhegTfvEOvNaAP8mVjjrei1LIzzQPYnjS67
         1BiwenfFqkws3zEa3yd2KCNPK4BxNF97bG8luhgXu5igXBH+Qq5iFw+zomJ5dFQgy4xe
         97VXMlDWKdOEljnQcoD5gkfmhhvCpo6Q42xRo5nSs0ROza/VV2B/Qdc1LIE/8p6r10Mu
         9j2A==
X-Forwarded-Encrypted: i=1; AJvYcCWvf1f9xAzwmBswMLmLsfjifXtgDvpl/xetxPTB9cesCaYVzfpVXACOIN348oNycGJkd9+cgQG/MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx77V7mZorR/GsuMTmbXuqhTnHQNkOE8uNKzgnt1NJMQv68dzyo
	SEr1EcR2numCIfHuHQjdaJDE8fKil3QYeE3USTSBbUO7yS5yn6HIU1PO
X-Gm-Gg: AZuq6aJFjlW9NiU5hku1uhVwvtoMauTOJomHzxN60G4boTo4Wrb1BmSVOqDRotvnfv5
	nO/88JujXtUhgm7z7/lzK3tmRDyTa4uUbBUyWEP9a5aLTCEsMYmx/hJxo5w6Yn5Dc1LK3u4jzLx
	ji0MCXBXsFwLWhjvzYT4xNAUZtSHXiwumiDjg2GKA2veALfgwwksbfVB0DQFU5p/26mGjD37hWr
	d34X5o0TvQ+SEt14oGvwzb6u8yyB56poxPtrI4KM68PlQ824SoZwcmG2mRnDbdDn32slsHWE7s6
	z8Uib6zkRVwOf90oFbxFht7l/o0l0JuwNUio77yVADARbteapJYg/6FNKANDpNVEsJuCvRyomA4
	nW8U4eQ0PMpyN/NnpnJ5d/DXMu8aVbimwl6Rana56gjnG9JG3BtQqNqeTFihe3QFTWOhIvLe68p
	f1
X-Received: by 2002:a05:600c:138a:b0:47e:e20e:bbbe with SMTP id 5b1f17b1804b1-482db48e4a7mr113010365e9.25.1769942651960;
        Sun, 01 Feb 2026 02:44:11 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce56490sm308947455e9.12.2026.02.01.02.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:44:11 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 1/9] dt-bindings: misc: document ASUS Transformers EC Dockram
Date: Sun,  1 Feb 2026 12:43:35 +0200
Message-ID: <20260201104343.79231-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260201104343.79231-1-clamor95@gmail.com>
References: <20260201104343.79231-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41848-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.17:email]
X-Rspamd-Queue-Id: F1C90C579E
X-Rspamd-Action: no action

Documenting an I2C device used in conjunction with the EC on ASUS
Transformers. The main function of Dockram (the name used by downstream
ASUS sources) is to provide power-related functions, such as battery and
charger communication. The device is exposed as an individual entity
because multiple embedded controllers can utilize the same Dockram
instance.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/misc/asus,dockram.yaml           | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/asus,dockram.yaml

diff --git a/Documentation/devicetree/bindings/misc/asus,dockram.yaml b/Documentation/devicetree/bindings/misc/asus,dockram.yaml
new file mode 100644
index 000000000000..3c690b83dffe
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/asus,dockram.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/asus,dockram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Asus Transformer EC Dockram
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  Dedicated i2c device used to provide power related functions of the
+  embedded controller used in ASUS Transformer device family.
+
+properties:
+  compatible:
+    const: asus,dockram
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      dockram@17 {
+        compatible = "asus,dockram";
+        reg = <0x17>;
+      };
+    };
+...
-- 
2.51.0


