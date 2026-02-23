Return-Path: <linux-pm+bounces-43051-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKYLFf+LnGmdJQQAu9opvQ
	(envelope-from <linux-pm+bounces-43051-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:18:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BC117A99A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 648F73052DAC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8303330B25;
	Mon, 23 Feb 2026 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQCdL8TH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676951CEAA3
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867041; cv=none; b=JObzBRV6nsnXCNjZFPzPektYLqsYp7EoUk6UffWfLaV/qb5a55w7N8PhCbPCjAiN6kqLRKkr2hJp4gasSt3w+4IKJJDaZMqMQQliPqM0JZcP37DDi/nOLtmT4uWRyNPpxkbdesFmMb3CymRN7M1BrOl4MFtx9XYHUWZt4cTVK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867041; c=relaxed/simple;
	bh=vJOr9ewXibzfb3H7LhY3fT3XdYMp+tyABiqtgW4H+/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtHpSfmtjoCMACZSERkAwL/oT1GVoD6g5Ti+OFoN2rWGOOWk3grsdJLWTSxkofaCNwRbyrY1QgHbb8ddjRtgQCfX6BrQN6fly1qul78wcbxIJ2iWKl4i2qmIG+oXh/ieYUaC+UVnErVYLJN6vX0hwZVzLu8/gGYWUaFE5IIbqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQCdL8TH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-437711e9195so3018434f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 09:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771867039; x=1772471839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jf6/GdPMgEPudu5Ub5QM0YH/lbZT9UmvVkra65sIm8=;
        b=LQCdL8THtSx20n8arg5+THT/3yXUfYGFN36M5mv1CHRiBfcBnnBjKsWzt4KZ/l8hEl
         JUBVirKsXyYSKp1S+8qa/+evoRTaUkN4/w2zRwmt1aNHsD246HV8cayjJgc4XNX0KNeM
         y1lpNSa4kI5Yr4j3/hE/ASnQ3nTp1WYeh1PSxnPEaYoTPZPXtToJhZitCw1Ltok0ptbf
         ZmyU3EBdFzgF4plaEDrPss3CLBfGUwmqsAbA0DsAkFHdQLIu5Q/Ok3XYb7kojUNY72w/
         yof8bTbhrUDAwOgb0tu2mLVhpWxPx0ek/jALUw50aOCBSlziykHhiwsGb/mUtU7U7d8E
         xaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867039; x=1772471839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+jf6/GdPMgEPudu5Ub5QM0YH/lbZT9UmvVkra65sIm8=;
        b=CFn1Ktlrsp+YSEUrSygzRUZG3FnGD+22NBEqfOnXFtdpfGgnhhpQxFT6Q+hGg4UFsx
         ZP1kCPQ4SOi/R1NbbLqKvbSzDo+76dWkHlkqcIPzwr6yxdJOTokuxok9vNpfdjDwfKpB
         kJAw9KmbuULporgWzQupLlYpY+mKkj5mEdPuQeIkfQc77V/X60Dx+vyFeyX38Msh04jB
         U35wnJ8tqTnNG7WwYdAd/Ta5Zza897YuKFTjA7jvFpQYAotnQmLg1QKsGL89/ap3cREv
         6dIDW5To+/RURzAKg6aaPp11MAAGHYWKhD+1+LUT/OG8tfT656SmpgGLElnqSiuM7G/c
         ByAw==
X-Forwarded-Encrypted: i=1; AJvYcCUrKMLCk+SNfP/Gv2WJ7c3woupV4qdEmnQSHRwfsjD+5Y+lV7rcB9eD1lEgbbqwF0qJVcPvfIQGqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6UHWjoofY1BoZvPiDWpT5jKDqyeSSI4kUAUtU2HT5sS6XCOBK
	/1R4N+JccZFVPBtt8oEoqz7fGBfb65r9Wan2wl8WltepbwJT/B0oPAl5
X-Gm-Gg: ATEYQzy3gxJ6sr3apFq49xKBAzKFdRJzIoYEaDyctGaJ0SnZJFY7ngZgyaCBsGfrHN5
	pre8OLwQ85PG5RVwCGsuNQ4iOLFgNra515JvkhZH3dMaVNMrkA6H4vL7VWFhQZdy/YjMm3xMmN4
	1Uk5W036iAXu+noF+PODUQr/c/lp4BkRCywtsy8fT6nmf9/g5/vwS0RxfXZwuirrVPwGrvUds/5
	gNh6VbnkMznYCt/Q9BroJMiXTSNLwtfp2GLhCDYBNFN3rtvtHI/Of+KiSr5eMnf3dg16ZLjXVSP
	D2aWo35+P0CGsvHpgYGwctJ9+YiUX51mDZc8Wv8eIp/W2mOJBJSF91s2mAaeg4+QcqlqvO21bSa
	wcwQnctbCEpxUImlj3piVGGz5kQwdIh+S0jqZ27XidQ4NRJiE7pmmbV3ftSE7G0cZNp1sLElgGa
	vb+AmaYTCJN4YWEDch+hNf1//h8PVEtw==
X-Received: by 2002:a05:6000:604:b0:435:97f6:4f44 with SMTP id ffacd0b85a97d-4396f1a97fcmr18768298f8f.56.1771867038655;
        Mon, 23 Feb 2026 09:17:18 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c982sm20871454f8f.31.2026.02.23.09.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:17:18 -0800 (PST)
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
	Eddie Huang <eddie.huang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 1/9] dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
Date: Mon, 23 Feb 2026 17:12:40 +0000
Message-ID: <c5ce038359583c5318c2d5ee341287c213aef880.1771865015.git.l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771865014.git.l.scorcia@gmail.com>
References: <cover.1771865014.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[gmail.com,packett.cool,kernel.org,mediatek.com,collabora.com,bootlin.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43051-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lscorcia@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,packett.cool:email]
X-Rspamd-Queue-Id: E7BC117A99A
X-Rspamd-Action: no action

From: Fabien Parent <parent.f@gmail.com>

Add the currently supported bindings for the MT6392 PMIC.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 6a89b479d10f..5f422d311d4d 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -39,6 +39,7 @@ properties:
           - mediatek,mt6328
           - mediatek,mt6358
           - mediatek,mt6359
+          - mediatek,mt6392
           - mediatek,mt6397
       - items:
           - enum:
@@ -67,6 +68,7 @@ properties:
               - mediatek,mt6323-rtc
               - mediatek,mt6331-rtc
               - mediatek,mt6358-rtc
+              - mediatek,mt6392-rtc
               - mediatek,mt6397-rtc
           - items:
               - enum:
-- 
2.43.0


