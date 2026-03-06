Return-Path: <linux-pm+bounces-43799-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGMnDGfEqmnVWwEAu9opvQ
	(envelope-from <linux-pm+bounces-43799-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:11:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 889D32203DF
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E830C30D06A1
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 12:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4791638BF84;
	Fri,  6 Mar 2026 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deu9DuPs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA631385521
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798765; cv=none; b=IJBxfUnCVjoZ82r18ucMLmXq0HiPF42EuXUOrk8/MrtW5wQ1mSef/Z0XPwh9Oi+rKfhgIqfOyna0pO761Xz6MiH4C7suYnPFgFgoKBonZJkPX19X3qhqx72fciH4M/CI40I6DOoskarvEv9gPkJYUOiZQDaPuBd3PkfWL+JznRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798765; c=relaxed/simple;
	bh=J83EIuQWnuvi57JW/hDPZJDW/A2HqSUqADqfDfUCqtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QanXhtJwUFlioyFyWNU0kR9T/RWRaTv7Co4E9YWYzAh8UZXjxfUC/AfON6QeWf/ESOqHiwIl4uX9mIu1DEN1mK89x3iCgE4AUUonyhd6mtpTZmTv/XcXhCaTE1ZcGvn2IODhC2sBkK0mr2USk9GsmYASSjKHLBzbkd0dOEmk5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deu9DuPs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48375f1defeso69104045e9.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 04:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772798762; x=1773403562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1Te5dWKyFtHCAsQSaH2ONpVBfHilH2WjO8uBzqlY+c=;
        b=deu9DuPsomq4gkRyPCtlT9+w00KPZN3fSf6cPUUbPTbQKNwLRvmo/YegdiNSmq2cgJ
         NA498QBzW2+K7IXUIW3n5fQ2TyNshyjVa6fcM0sQwWekUWnNBAgU5dnwMVYA0CMvgxiq
         RLp4t0HUThRig3e559GHHTmAA21HwHhVIKfJ1E+NiWxlgqEuFBXa6adMmsPSMpVSGQws
         VfFtht6UWWRHNUmH++3vyzaEekn4rEyeGFY22vYDzX+JgFgCqS/K+LqjYfxK2riYqyRR
         N/4CSmES3EJ6UzPBjJoC0jAy8bIgBZMXFv7aGEsSckXOuCOz0gopKxU84CT2/Ou66wYx
         G1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798762; x=1773403562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1Te5dWKyFtHCAsQSaH2ONpVBfHilH2WjO8uBzqlY+c=;
        b=dGkwU+76uurOu9PT9ibSc0xIPlD+pXUgNMdxglbEi64h/hq+k/uFyz7odk03gp+mzg
         5TgY53DkLJy0T7VMoyseEW6zBLpgnsImwn3v4HFRv0d/XN08brPL50XukGgMX5YYOW8s
         1+NloJdNXg48ZvTO7l/6+sBKO5WkaiuLMcfS25PxWr1Ggh7kO88OMK+rbK47HLTChtj/
         eOJQBCUhocWgcsVY1H+Zej7XstuwYFBWazI/O1Nyn5PP83QDumYYFIE8kCGhA94j+wxC
         nSXbuo8ln3lnXoMu8g4Hs+KnxMsH2ljzoXarfHJEv3RDAcngmasnLm3nIKJv6hN70tmW
         vP0g==
X-Forwarded-Encrypted: i=1; AJvYcCXLx64VVpxiCe5niAkwlEJh4RJBybrtdAtWiYLIjzqM8uKnkm2z4e3GgTyyFmI5o02ux5IciD4noA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGMfgDgR10flJT6HJ4q1mGvkgsiVs3WY4FikuRPunacAWzMYN
	M6V/oawFjwCO6Y6OHBijAsn21pEYbHy/mk1H7Sc/BmqREMhsMpP229nH
X-Gm-Gg: ATEYQzxwnnLwCkBGK8CBctxT8dFLezG5tn3hlemNiL6S1Hx5+wduxJdr7D4wQK4q3Lt
	y1/EsDCblhlz8iXXKhRCfotWDFmj0mxkAXyQy21eexoemnPTGwA1rEuZ7YwsPb5qWFRKCK3FyDU
	TvKCkKJLG5EQsmNKmqFknlCvKWy81WMKwYeng5yiCjXGybmgxDSIx1vBKp2VlB2S9qlFUVgV2ht
	ceJCExJrcgwNxKjkjl5r6SQXSK1OqtzX4PR4RirJA90GjAyNKA+hkCU5N7SEhkawD4yc3LjD6PN
	JxQLAzik4lvjWFLKJ1cf5KzfWBy1kAVhz4jchP6NQqBXLjSzlMfZODJv1AsiUW30UnWEksUxoZO
	5W2sFId4BP8n1b3Fawn3FFkosbrJz6+99r2yDcDVD6wjAB8k6vAep8MC0+j96HqLuTpBfLqiCCd
	7S8q+XVAm7OqvQWeHULFs=
X-Received: by 2002:a05:600c:6386:b0:483:afbb:a064 with SMTP id 5b1f17b1804b1-48526918f7fmr31691795e9.1.1772798761805;
        Fri, 06 Mar 2026 04:06:01 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9d8sm3457225f8f.21.2026.03.06.04.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:06:01 -0800 (PST)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
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
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/7] dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
Date: Fri,  6 Mar 2026 12:03:05 +0000
Message-ID: <20260306120521.163654-2-l.scorcia@gmail.com>
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
X-Rspamd-Queue-Id: 889D32203DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43799-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,packett.cool,kernel.org,mediatek.com,collabora.com,vger.kernel.org,lists.infradead.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,packett.cool:email]
X-Rspamd-Action: no action

From: Fabien Parent <parent.f@gmail.com>

Add the currently supported bindings for the MT6392 PMIC.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 6a89b479d10f..c358b2f8059c 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -40,6 +40,10 @@ properties:
           - mediatek,mt6358
           - mediatek,mt6359
           - mediatek,mt6397
+      - items:
+          - enum:
+              - mediatek,mt6392
+          - const: mediatek,mt6323
       - items:
           - enum:
               - mediatek,mt6366
@@ -72,6 +76,10 @@ properties:
               - enum:
                   - mediatek,mt6366-rtc
               - const: mediatek,mt6358-rtc
+          - items:
+              - enum:
+                  - mediatek,mt6392-rtc
+              - const: mediatek,mt6397-rtc
 
       start-year: true
 
-- 
2.43.0


