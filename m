Return-Path: <linux-pm+bounces-43280-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMWqMINEoWkirwQAu9opvQ
	(envelope-from <linux-pm+bounces-43280-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:15:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8189A1B3AEA
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD2BE303A96E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 07:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB533254BB;
	Fri, 27 Feb 2026 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZpfxDqx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B213313285
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176513; cv=none; b=XvV5vYzkqyYFN+k09YjevZQZjj0oQAIogZLdJ+DCsGTeJKBDjPpvqsjighsUlPWL7g9YkWIjstABcLWdPDM4w0VIvY+mvntIgyP9X0zmDXfqoVls9BCnfsOOVxFo5oHPy68qifnK51KHyg779v7RKuoPwO5o4K5igQ7o1ZRWD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176513; c=relaxed/simple;
	bh=/augY00zIPRmjio8jqvj1SCmtf+8/FE6pZ+zQ7AN0mI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C35e4iENkt31LVgLqUfEnNesckcZd32VwsBjkLp1luF6+1AoJI0QMQ7hYpmnZbRRwTqaZx5X+g2M1KHYzD9bB5yrLbRmetsf5fNiUmB04PONaDrL/Bs+k37xQdaQi7/QE7S573am9t7XHOgvTbBPLJ0hBNyu/TvZ+1k/nDqnl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BZpfxDqx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b90bc00578cso252710966b.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 23:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772176510; x=1772781310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PE+eVQ/Q4S/u1SH29EMKN7g0w+RRX3/eaSSvWEMkQE4=;
        b=BZpfxDqxQskupfXeSV3uxV1fqMm4Rfz8Qf1Y31jq15Y2wOhb9KEGkP9RY/m3XMxe0g
         19ycnh5/USh6CT7EUHrrNKsPjG/NeqGrADETztc4XyvjDqAzL6koQt5sz7aZSZPad7VU
         5ilLmhpR4LBxMR8XIdpdMAJL855mdTtTF7t2x3i1B2Yzl6pvq0kOJTr/unRahXL8VkXF
         RtVTVFZLKzZPkKB9Teiy+Ubk0Zqro7PGoTvDB9U1JgFWaspBGm57EcdizRPiqKpd/2vG
         eExJIJbhBxIpkkwPDN8R1Ot8etD4H90bGoUstH/nbjTCGYxa08LO9DIfkjD/EB5/9cfx
         NogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772176510; x=1772781310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PE+eVQ/Q4S/u1SH29EMKN7g0w+RRX3/eaSSvWEMkQE4=;
        b=qag17Wb/LYQRTklzvHmEqm+aveQifss9qj4EkH+SpZP6bn+VB9CrY8TG5olGF14b+c
         woluSIGzDlYdYgJ1HiAOvXty0ZBIqOnNLTCGSmyas2vyd+Rwm5brpYlvp3u+DEHWFP2v
         I4hPTvySkGmWf0ktSng/QV8FhFuWj6uJWwbiImQ2mDP01VDzIO8enQbjG80/115Nex3G
         dE0uu4YumawgOWaLH7u3g1K50Q/ip5ZtmLk6AEDDOf8m7YA6Ej/3bkOfprB+IN8VzJKO
         6anAU2OQyoqyBLNmRUa3To0mdbMa5lpqheVA0JEdRfk0+1Wn7PVOrOixWGQJDYxS/fFW
         qHmA==
X-Forwarded-Encrypted: i=1; AJvYcCXjkoXzq40NYcuJGuoL0XWqs2+iNW7IeOXMymUPkExftEzx6qUu3K4RnNiA8wN+yTmqCBJLnzEb3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3pJCB+Wz+jYPgwsjpHq8Z8JNleQsxI30b4YtTzpbpQSoXD4d3
	JxmP/UJvTPIOyo+hxA3HvhCugkQNkg1NgmnfMRuxcSn/cVOcjVyYi7CxhsKHr6bhoTo=
X-Gm-Gg: ATEYQzwNy8UGW1lf+AaFPE5UuxvZzBVZfIrxnIr/c574iStEIGuIfENlkdSWnKyKkEI
	BpbKtGzVwqny/UA7JAeM3D6sQUw45P5J1WQxMYIPCTP4ploHZDofXbTPaacPzZg/+iate+O2PUr
	b7JfOhbxokYsZhfDUtk2LDuxkQGSjSTksO11/jydd8F8ln5CFtAk8v0FF94T2ADEdFdqxHh9QLh
	uldqI1O2ps0baxvA1o75U2u+jJKv1Yk/vnZM6M08KSKkVKT3Qum9X9oGjn1x8b3gtuRwDBdf884
	kEm0CgxIYCThNZTcMnZpTSqGm1+LLjPKNQDX9eYt8c5NNoiOOi23cIU7NK8jqEcHJxgycH+DAX0
	txINitneE+hJPqmflFacAcCf5n1yAqcm6ocQ7qJdrNPSKB8hCPhEFzjh5e9jnpvU/PtRXWbCYFf
	+2jdNY0eQ0zYJJ5JWgf6qvM2LvoK9xnSDEpP/Rqgfv2FK8upQIVP6f23/qfXX2QS7z/L69bA5/9
	N2F8Ado0RniXhST+Q==
X-Received: by 2002:a17:906:209a:b0:b87:38e0:4403 with SMTP id a640c23a62f3a-b937654e1d9mr59219566b.40.1772176509910;
        Thu, 26 Feb 2026 23:15:09 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aeee867sm124205066b.66.2026.02.26.23.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:15:09 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Feb 2026 07:15:06 +0000
Subject: [PATCH v2 01/11] dt-bindings: power: supply: max17042: add support
 for max77759
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-max77759-fg-v2-1-e50be5f191f0@linaro.org>
References: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org>
In-Reply-To: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43280-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 8189A1B3AEA
X-Rspamd-Action: no action

The Maxim MAX77759 is a companion PMIC intended for use in mobile
phones and tablets. It is used on Google Pixel 6 and 6 Pro (oriole and
raven). Amongst others, it contains a fuel gauge that is similar to the
ones supported by this binding.

The fuel gauge can measure battery charge and discharge current,
battery voltage, battery temperature, and the Type C connector's
temperature.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 14242de7fc08..055d1f2ee0ba 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -20,6 +20,7 @@ properties:
       - maxim,max17050
       - maxim,max17055
       - maxim,max77705-battery
+      - maxim,max77759-fg
       - maxim,max77849-battery
 
   reg:
@@ -28,7 +29,7 @@ properties:
   interrupts:
     maxItems: 1
     description: |
-      The ALRT pin, an open-drain interrupt.
+      The ALRT pin (or FG_INTB pin on MAX77759), an open-drain interrupt.
 
   maxim,rsns-microohm:
     $ref: /schemas/types.yaml#/definitions/uint32

-- 
2.53.0.473.g4a7958ca14-goog


