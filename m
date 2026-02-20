Return-Path: <linux-pm+bounces-42908-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BKtJ0UnmGlqBwMAu9opvQ
	(envelope-from <linux-pm+bounces-42908-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 10:20:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA091661D8
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 10:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5057C305021A
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA2331D39A;
	Fri, 20 Feb 2026 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="N9gjeNYo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA7B31D393
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579156; cv=none; b=QnkDnPEojSmVzO0K38ytay6MBgAT38ZZM3FEBh3t+O7LPssEWUvHVrPV0QP95kTcN4l8uf8G31fbP+hSoqHjLfhafUiMh6kpnZlRdelsJeY5mqkyw/+jrkN0zb8Os18JuMiML2hk5lqFNnnLF8M/BS2Mxei7pEDOJsDE7yFcJw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579156; c=relaxed/simple;
	bh=isDjg2KdEDAWzS8eIlvfXGW5pS+9OiwjRNsGXauVrws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kUqCPpGhW+vBJlAczhL7OhxUhJg0Ba8wl/jW295k7a2feRDxZ1uhdqdDWSKU2mr9wF7AU1wCv5IbO/4q1S2D1DRgg5DfWDEkh99zL5m8MtsZD4fzH3UN4xXd9wwNgFbu7NlOlVu/wnygGXwrqJchyt+KhN7jCgBOb3Twv0GuJ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=N9gjeNYo; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-65a1970b912so4716476a12.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 01:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771579153; x=1772183953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYkTpRjooi8HA/4JvTDsm3YoyWiVwSiSYVAVY34W7nQ=;
        b=N9gjeNYotHVttTLbIJ/8dDRB2Y6xz0zLJ50xkSPnY9oAweuDaRAgFdJtB54PuMzLt/
         J9REpQGOTlIzB5jetXjcWN7bx8IVE+SkDO4lfC5DN3Ycd/E8nxNiL72wO9iWf9UqouCi
         Xef1Ob1HSXJHwi90dLy1NoB/K4CU4AWSXkNW3EQOSioK6VI6QjyJsdr8cUeZkfIC7nsY
         CJTArJiSx9y0/ZlVg+ORCvBDpL+9zUPG0Beo2wtpcJfaawa7H67jz1fVWIkw4d0Lu/uD
         EtZdB4FlFFk1LJuWEZgK6e4RFtJDIvjfv/bdl9m+KOYlRUgJbSPUXBQ/Mvp4qN9JLqWL
         51JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771579153; x=1772183953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xYkTpRjooi8HA/4JvTDsm3YoyWiVwSiSYVAVY34W7nQ=;
        b=L1YEzGK47AYFTNeimQGH+m+dSpmkY4mPbaLTqgmQYBVupNzH+b8dLH3bcRPDeGN7TN
         REhUtoqBcmYxq8k3WYCdWIZsPfen82TC6b41H2VMzJCsj62y/E+hKJM4hT8EyRPyuIMZ
         wcKw7pqZzOHEX2ewV9+xt8egjCf1I7VAxz24QE7Pm14k8HPAn1JOAjhGz2DF7J3YKyl/
         gCW5SohRl9RtKAEKR6PhisSGQLJf1TC8JJNUd3iTgVLsGnbytgvHFIsFZHFOEHv4MA40
         89N94KDC/c6C+xhZFUxUVAq/9ePNf27UiuqDadJ6ZHdYRg0cnNtrqYngR0oHs4qGGt6c
         S20A==
X-Forwarded-Encrypted: i=1; AJvYcCWtPeThexg5taDjlKbJOrlv9/y8YasIg/WAFgymQiQRkd4/nZuudfcUzlWK0xa5Y+P63xA+wZLJZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbB3h8kBPx+oaKgdbQTY7D5wm63vHCGT0fb/X5QFzQlhpaBnR3
	Q4TqjENxLClWCnjmbIXz0m3mPdM5OZsaqGRAxNiHMwwz0HNJuSkQCzbEv7li7JII0og=
X-Gm-Gg: AZuq6aKXnoK1OMMG0VCWBM/Vb2oYhe92/6cP4PrvrxWEIIDbeTP4mqjDwXEa5u1WSH+
	9e//Lj0vmU/4O5YJaaRI2i3APtZ/iVTcONEZx9oJc7WS7aSHElTuUgzlDEXY0uvGdIX9qb1BROg
	LSix1rS7iIwK2jaeE/QorxcRMpj6U5eTFG2WnUTg7q6V9dmN8ubNofNbjC8QWzsqaTkMxkXaA8i
	IOZrRn5hDGC7dY52jilUFChkl9BgImkQYyPA3tXXX0Q9SEO2FpTGhoYRaHqWOZC0BZke17dSHHE
	QFE01rAcahAmXXqRmp4uLPnE39+qFQ6QBVJSHxWhBg1bzNjRoGT48pDDr29qUp83bdDE3XUKI2C
	kNk1e06Ltbgc/DHrF8FfIhlz8Nlueyy/aEmOcSys9AgKGXui5SWCpO9GCt2QDYrj7OKpIAd+Kma
	UnMPEvRGst4VmIP7QzG7zwPkpGSJ+uTCOm1oMrbWRqGfIODr8z/5UL7L/VqSOwVmfP1g9FHd64h
	P+8jS9Ys5cHzJwu
X-Received: by 2002:a17:907:1c28:b0:b88:4224:815b with SMTP id a640c23a62f3a-b9073049b87mr76905466b.3.1771579152977;
        Fri, 20 Feb 2026 01:19:12 -0800 (PST)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc769111fsm667098666b.57.2026.02.20.01.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 01:19:12 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Feb 2026 10:19:06 +0100
Subject: [PATCH v2 2/5] dt-bindings: thermal: generic-adc: Document
 #io-channel-cells
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-bat-temp-adc-v2-2-fe34ed4ea851@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771579150; l=1052;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=isDjg2KdEDAWzS8eIlvfXGW5pS+9OiwjRNsGXauVrws=;
 b=ZSVbqDHsSdLJsSwCkOzI7OsESGGyedhA0OT2p64wvJLLGx+vATaufPEQiebJ2HAoVmJZuf7QM
 fP2hUioU8+mB979BlBrTDKKHkKWw0KhWvQYmWm2xVr4I1nKLQZDoVeb
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
	TAGGED_FROM(0.00)[bounces-42908-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:mid,fairphone.com:dkim,fairphone.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFA091661D8
X-Rspamd-Action: no action

Document the property to allow using this sensor with io-channels.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
index 12e6418dc24d..317fc39ed46a 100644
--- a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
@@ -24,6 +24,9 @@ properties:
   '#thermal-sensor-cells':
     const: 0
 
+  "#io-channel-cells":
+    const: 0
+
   io-channels:
     maxItems: 1
 
@@ -58,6 +61,7 @@ examples:
     thermal-sensor {
         compatible = "generic-adc-thermal";
         #thermal-sensor-cells = <0>;
+        #io-channel-cells = <0>;
         io-channels = <&ads1015 1>;
         io-channel-names = "sensor-channel";
         temperature-lookup-table = <

-- 
2.53.0


