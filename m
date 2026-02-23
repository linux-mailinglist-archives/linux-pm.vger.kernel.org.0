Return-Path: <linux-pm+bounces-43052-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCbcGA2MnGl8JQQAu9opvQ
	(envelope-from <linux-pm+bounces-43052-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:19:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1895217A9B1
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAD77300AB3B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 17:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76738328B58;
	Mon, 23 Feb 2026 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPuSI1sc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E440D32ABCA
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867052; cv=none; b=sJZQCi7EhkpN8AvsKrHUf/OsJ1A88nt/z7FRk7GPpkDBgC7BNuo8MNWYNxBuAKxUCWajC5K/o96RvFtfkN6dS5kLCQZzfQ1tOPRKDRBFwcQqWIfelYxZIjf/0CUEyFT/D5pKTr1aG6maKy+KO7YVXlF2+76lv0bsvZw2LYt4XTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867052; c=relaxed/simple;
	bh=OZfaPFSqbA2C31QZTHgklz9lyeFU0Jd8/jlpq+HGvJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVIdV7Gao8qntmYP4CRv4jvwfdv2L4xEcBF4Z7mTTr3h1JSRSqW20LxpvA8zvyr/fDP3PfvzUo1DV3DnozqAiKNEdRaEM1roOx7WSHYA6Tw6UFgANLbvDwZz6wJb2Runblzbh9fElLb7rd58v+NEao31LEaHohHw9YzPosHiBfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPuSI1sc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43767807cf3so3472672f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 09:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771867049; x=1772471849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfSw/YyZxtWdt6T+0h8WzqJ7g3THGU6LxAxLY8xoIzw=;
        b=gPuSI1scwCWzlR8FBeZxbwSrPM+9HXa9Pgv+N3SySO1xN4xE3RclTXWEPoKXdIuUGt
         c6tJwU3RdZ+hyeBO4b8J5be5POhh5wlMtmUGIgcIPW19bdabM0TfZGeOmbR21aDa+r+a
         DB9uAVjN7rOHQ8pfNFzRiPhCCyVyWhJJb0igFgYKzAFE7pPTMnrvvBmqla9sHo5fG4s7
         0OOpIexnPfbua2ARxQt20UtF/+wyqimd97WtszzGUPox+HfDxVRjr98j5SFL6h2q0HI7
         mByQM4T6sHDK7RtRv8DkROMYKsf22cIk/q62bSI5btAVLglwRzkf8t0HjxrLVPemgF5X
         yLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867049; x=1772471849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qfSw/YyZxtWdt6T+0h8WzqJ7g3THGU6LxAxLY8xoIzw=;
        b=QD5WXy9W6D6okAF4js0MR1w2OWH5xO5egStgwSmJLnKKHDgJAcf+525sRYnPORBDKF
         vlcxUOSmaC8DagnyvU3TdoekS8AaSjKiQGSMY3CFwU8aAhkRnhx94RH6xA81EBZR49Li
         QlMQgGIn7FK6gC32AqrGbTVi46/8Drzlyv9jcsEi8pAop3Qpapv5ZxH2YqMAs8CuBNwt
         oQW1dyKgkoOJf/PZRvIhKpJT4qao5jQ+DrLFE+pZrWxkZqyxMz378IdiExzCDMSNOvHo
         OVBYgl0JymWXussHuvPv29yA9T4lnLYEunfLQOaUzH9plOBku0AcNw1eE56oO5uq4Csy
         YOFw==
X-Forwarded-Encrypted: i=1; AJvYcCXqL0W88niNpyXMEUUTKWb7oHA0IlkI3SUd2x2HbiUMn/SNXvg9mLISc6UHmaiwTBheQu0Nn3jNCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr6ZHu6r3PkP94KhnqAsQASrX+V8x/q7DzBmbsuvCwPObiVTXQ
	71iAobCY5PBKff0XfkYcsI8DvuA+2TVnebk7UnWdLZK1Z8/xYzJ4Y6ZY
X-Gm-Gg: ATEYQzzrvLSmAQUledJecykV5UoDlfS8GT+tsJ4MI/p2nRS6A3qbdtVPZvIwMzDsSWt
	wv8/H3oj02Z0B7rjr3k03JcSMTsjEK9N2zfvnyv3OWefhcBo8QRwHugcgnE4NsAp3IKJU7jC0P0
	JLaZ+2nd7LN/UxUgQPP0U+CGtL7eAj1Ar02LeQ7vrAUzfewVR/9T4Wf9pGxhKA9Y3LZr5ZxoQzd
	QrxZDEnu9uu70/AUIqypD/6xfUei6QArru9NjgByzprYN3VFgPi9JAphWrEaoxo3/RaUTnLqP4g
	HTw1tjR7U+ifhQq4UKSPvDjK6bRupvGlhGNsQjBL+id8zqhv9w7Kpc+Je0eaDYCkM5j1x/t72rK
	ueKHdATcnWA0xOz0s2SL9G1N3tv0+7dtW95GqcccvNcFLo2+UkTISNbqNorl3/tZ4agAUyTIHXt
	rG9e5S6/HDzkUXv6XP1bU=
X-Received: by 2002:a05:6000:188e:b0:437:9d2f:8bf1 with SMTP id ffacd0b85a97d-4396f17ce2cmr17527562f8f.38.1771867049261;
        Mon, 23 Feb 2026 09:17:29 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c982sm20871454f8f.31.2026.02.23.09.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:17:28 -0800 (PST)
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
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 2/9] dt-bindings: regulator: add support for MT6392
Date: Mon, 23 Feb 2026 17:12:41 +0000
Message-ID: <b7664f4d9a7b038b0603b6bba79cfab4e18cbdd6.1771865015.git.l.scorcia@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[gmail.com,packett.cool,kernel.org,mediatek.com,collabora.com,bootlin.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43052-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[packett.cool:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1895217A9B1
X-Rspamd-Action: no action

From: Fabien Parent <parent.f@gmail.com>

Add binding documentation of the regulator for MT6392 SoCs.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 5f422d311d4d..b61fce8f09c0 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -94,6 +94,7 @@ properties:
               - mediatek,mt6328-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
-- 
2.43.0


