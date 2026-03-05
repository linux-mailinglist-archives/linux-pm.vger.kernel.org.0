Return-Path: <linux-pm+bounces-43638-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMjJLpf6qGnVzwAAu9opvQ
	(envelope-from <linux-pm+bounces-43638-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 04:37:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 445C320A98B
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 04:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 216A1305B2AB
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 03:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD36279346;
	Thu,  5 Mar 2026 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHtc/9li"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721AA72621
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681654; cv=none; b=GVeYfdsbqaqKrOIXHuFTjPyxBYSIx4TVtRIMY03D1sptwuMl5az7GkwFHIN09xFzMrDtHjx1aLVVXpJWZoH2uJjhBFta318mFTt9p4Rg1o0xuL913gReBHwGca3024yxNz9n++qVdHOz8Pwsq6BPeDrnr2toCwwKfO6xL3Ec0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681654; c=relaxed/simple;
	bh=G93cII+3A1u7CvKJrZXIJlpca2wo8XCXaCLCELHybVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aIRObmsNe2q9n0A+Ndjh9CxgnbDm5K9KupQxht+Y/9bCuPxEu6Pcxe3g+0LSrvdVL+QeQ3hoY5aB7Xu7KgWjifoBVgO+4vkQGx6EBNHp5UR2nXWimr3PyeEZdFlo+9JtH1cQt/NBAJXN4Y/z9dVUAAd9d/LgKlNmssP3kJRIz6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHtc/9li; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506251815a3so67642911cf.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 19:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772681652; x=1773286452; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoyJS43DjogCNIlYUyLOl9RH46vOQLUOd3a+06hfz+Q=;
        b=gHtc/9liE0Xz/URCsAUZ/VJmEMYRNykrH0X2KvPxyN+gND8W5aEEgP2fHox/Q/FzGv
         gqqWtahGYLEpP2BmRtqJd15wOxQj7mTWSnNe86F+nxd06KKh1kAi2tk0d7c5RSi+dIAx
         dI4IXsgWvhiV9mYFHcMUvZdI8MUfPnR64bG5UFVRkGbJtn2Y3bm6MzzcxbWfX9cuChSi
         n87L+2x+5GDXWp0xItnNLYzJBg1FTdAUdHa6SDSIQxB0Mgg+ALB9oigI6TnED23sFexu
         VhD+KFiUX80qxJCdtvzL4k+sb9kdq0lO3d+j3V5CIlWqxeLG8UKn8qRNwCDKvJ8fN70r
         ZFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772681652; x=1773286452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GoyJS43DjogCNIlYUyLOl9RH46vOQLUOd3a+06hfz+Q=;
        b=I7AnGmt0lLZsP5w0Zx0swio6X9MluKmSrsAm3VngPh2BdDCWaduSZkWh4tTsiNGxRc
         OLAmEdhRh+ocDckAb3KkDTbrqLQEDbSVae0m370gAfEaCKKtWRXidT/Osf+GGuBKjYT0
         TyLUbIPEvculOhEn6m5McyqQqD5bprilej3F8IHTepiainyS1JXTGtT/LpsRmEAUdovq
         7ZtvyIGXOoQ04Qk+68qxw+PY1kyqi113bBYE/F61kBR3JlQZkiN87IDKOryLxPR0k/YZ
         wZJF5e4H0OyoGXiGzzktA43EQucdz3so92svqR7V4tP6C6bwB62pkzblXKGI4qwwj4uV
         JA3w==
X-Forwarded-Encrypted: i=1; AJvYcCVyQo7Z887KPFtjMncub1/ttIFmNLYCDgd0Gp4h6qNaROUIysmTP+VgZbfGYj8MAj4tmYWjJ7NqrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0stttgeljaRSYWO5/JB9UviLI8F06NO4mpPDsznDJ1UeU3vRy
	XtgDPvkqdxLVc0+ImyrAJW/RCtvAzztD7kUl0v8GyafIlKJDh8eVOsRJvxmgwXe8
X-Gm-Gg: ATEYQzzCoq+6p68RcWoZgkq1bWjXIFaZEJfyxqNvTOp5UbqbaimJmsKBYgHCo2B07iA
	siPHk+nt+oF6EpMweSw7vEz9bdveo6zYRTraAOVw5Vo4HJBlpIlUATfMVXpEJ4j77edwIxgkB5x
	QWUZiKOpz+eGjsp/K7X/cKPxvQepFwy4Gro4uVudF1bTPxM7wukVM+2UWEQB4f80Nle0LuMaf2i
	NBlIrykAPvmx/XPTmbQwKGCwWqDIt4mbN8RyZpFyUPDX8NmkCgPHZ5jAzqMyjphABfz9QxjU8MB
	Se2OffM9JjxZI4EQtcvj/yZ/mABFdLoP6Y/QwTdc/25ZgE6nxfM7uyuyZ0S0wzpt/9GZEgpVPuv
	+q4RhGiWXGUUnyFXlrFOImPT7eVqGZWfNfto1OWvwHCqV0G1S+fvVLUfH2e5nWF0zZ7sHdHGgAq
	0sekZXInyKk9hfrpFbJKs4y0ic+Xs=
X-Received: by 2002:ac8:5a82:0:b0:502:9e93:617d with SMTP id d75a77b69052e-508db36395dmr51002631cf.46.1772681652477;
        Wed, 04 Mar 2026 19:34:12 -0800 (PST)
Received: from [172.17.0.2] ([134.128.219.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449630b6sm190667601cf.7.2026.03.04.19.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 19:34:12 -0800 (PST)
From: Yuanshen Cao <alex.caoys@gmail.com>
Date: Thu, 05 Mar 2026 03:34:07 +0000
Subject: [PATCH v2 1/2] dt-bindings: power: Add Support for Allwinner A733
 PCK600 Power Domain Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pck600-a733-v2-1-ba6bbed7d253@gmail.com>
References: <20260305-b4-pck600-a733-v2-0-ba6bbed7d253@gmail.com>
In-Reply-To: <20260305-b4-pck600-a733-v2-0-ba6bbed7d253@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Yuanshen Cao <alex.caoys@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 445C320A98B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43638-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,gmail.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexcaoys@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Action: no action

The A733 PCK600, similar to A523 PCK600, is likely a customized version
of ARM PCK-600 power controller. They share the same BSP drivers in the
package provided by Radxa, with the only difference being the lack of
resets.

Therefore, document A733 compatible and make resets required only for
the other models, as well as prepare the PD definitions for future
device trees.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
---
 .../bindings/power/allwinner,sun20i-d1-ppu.yaml        | 17 ++++++++++++++++-
 .../dt-bindings/power/allwinner,sun60i-a733-pck-600.h  | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
index a28e75a9cb6a..b97361ce2a00 100644
--- a/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
+++ b/Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml
@@ -20,6 +20,7 @@ properties:
       - allwinner,sun20i-d1-ppu
       - allwinner,sun55i-a523-pck-600
       - allwinner,sun55i-a523-ppu
+      - allwinner,sun60i-a733-pck-600
 
   reg:
     maxItems: 1
@@ -38,9 +39,23 @@ required:
   - compatible
   - reg
   - clocks
-  - resets
   - '#power-domain-cells'
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - allwinner,sun8i-v853-ppu
+              - allwinner,sun20i-d1-ppu
+              - allwinner,sun55i-a523-pck-600
+              - allwinner,sun55i-a523-ppu
+
+    then:
+      required:
+        - resets
+
 additionalProperties: false
 
 examples:
diff --git a/include/dt-bindings/power/allwinner,sun60i-a733-pck-600.h b/include/dt-bindings/power/allwinner,sun60i-a733-pck-600.h
new file mode 100644
index 000000000000..cf476a005b55
--- /dev/null
+++ b/include/dt-bindings/power/allwinner,sun60i-a733-pck-600.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_POWER_SUN60I_A733_PCK600_H_
+#define _DT_BINDINGS_POWER_SUN60I_A733_PCK600_H_
+
+#define PD_VI			0
+#define PD_DE_SYS		1
+#define PD_VE_DEC		2
+#define PD_VE_ENC		3
+#define PD_NPU			4
+#define PD_GPU_TOP		5
+#define PD_GPU_CORE		6
+#define PD_PCIE			7
+#define PD_USB2			8
+#define PD_VO			9
+#define PD_VO1			10
+
+#endif /* _DT_BINDINGS_POWER_SUN60I_A733_PCK600_H_ */

-- 
2.53.0


