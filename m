Return-Path: <linux-pm+bounces-43053-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF+VJNONnGmdJQQAu9opvQ
	(envelope-from <linux-pm+bounces-43053-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:26:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E6A17AC93
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA23A3194DBF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 17:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A018330B28;
	Mon, 23 Feb 2026 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLWZmXbq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DADB330652
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867062; cv=none; b=k5W1wFRnTltWVdG/DQ8B03dUXqOd5/Ott21JoTqNgk/iX69+1Oy8bne2h4Not64qPdU6H+/qDVRG5M9z14M41p4x5NjOc0mdMAx10i61X6oZihQav86onHKcmqcNGo5htzWbSAquJyQm+EJMCwsAEhX82kx5O9kG6JeY2MGpMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867062; c=relaxed/simple;
	bh=xZzzDOkgKbTZ66GRV3Ylmkt1TVDNGKrjwzmFpeTjMtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izx5nl4HC1eonBG41f3Ye81SvTRNveHawKJrZp9m5PoY+DDQOfuQBvvVt7WROlcOuhP5w0iy6MpnGVntKh1BDY8AtZd1ggxRXo8CXqgsJyqj62+h0YKuiDAsf1kkk1lTWghExIVQggVqeusJAdmcW2ThpfzZ2MhQJW1gy/9gDx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLWZmXbq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso34731345e9.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 09:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771867060; x=1772471860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uM6wk4ilnVR3AWYXU6RXXbe1DzogOfIUTZwC0wgcO4g=;
        b=bLWZmXbqp88H2k8jp4QSQwQRi2vI0f/1Bq0gcFqMzcnIMaHRdkRUNvHEt0ZI6FBYgF
         3iWQ691o2Id0G/+XyKWeS2UeI4v/1Vdvq2iKWpq9XarKBXh64g8Kgru0ofkrbk+iPBEU
         MVU67wwols2XShMQ2hNcXE2N2kN0y8JEi64b4QGHR/1XXhKLeuFzRSWwVYk6SkxsV+C/
         Nf9kc4HhYfVmr9wk4ni8SL2cz+EJqcWXfW2IU4sQOWi3RhytoysGkZPgpqQrtZI1D9rr
         GctbvxDUsmgCwf+XPZ1fAEBzwVD0SngLMAQTEOVEbnu9mmcSTcbM1mP9IC4X7kciWYvN
         8KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867060; x=1772471860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uM6wk4ilnVR3AWYXU6RXXbe1DzogOfIUTZwC0wgcO4g=;
        b=OSkv0/CGEp/EmQ8DUr00nlY+Had7AcQ2Dyy+omIdgTWp9u+g5AV9aMt/8Wxcjbcn31
         pySKukRmZODeL7lQJlZnwh11Lvj1hv4VOH/nzg0Y8z7knQd9Kem0+YaA8fuh1dhfXiaP
         lTzu9usDY2/FZzMUfy9x0DYCoaKOAUj9cTU+stKJjusW3mjZR904rpt/+75F7s5+iFf0
         ikf7coX5AdT6jtCGkxyNBff05AzpSUeer3mSDPhnNNRB60AT+mpL3stWx5be7aBscrRX
         HQ+L8r6WgCqQMUZMfPqR6R/t6pvyzctfZgGdxmETuKJphGo40OAFrqXCzo/4B5iNtM2K
         +mnA==
X-Forwarded-Encrypted: i=1; AJvYcCWazRtaY+ahDp6e4Q7gjBh5tt4x8fGKt14Z2P4SVrSP70QAfWtTZCOi0sQEY/gnlisqRxwD/A/13w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCakzHWS/T46iOY1U1bjMlikTkFmYUoYMgYLHsFdT2QpRaofP
	eGReG36r3Hcml852pS3wJcbWKPswUzwuy9e5BUF1ADJqv31iZ8w6HudY
X-Gm-Gg: AZuq6aI6bLi2AUu+DSvD8afesJeFysAD5no0u7HrKwM+zTo1lkM7ipm+SsFhYEu2Cy7
	oJRve5f1dDSc7ZirntnCifhzBJkMIKrpEIK0ND0T5Y3p/EeTXacbWHUIs9NH4fiGVhuv4PYJNz+
	1FhVPuro4p0U3QKGAEnAxdgxZV/jt7sTemJbskow44QECuO5zG986IWFSPqbzF3RlPfxhMiH5v0
	9AUSiQaQeJkTZFfjsdny1039yc69vGdADkDtjDJ5juUn4As358ZTOEAZz96i6opZNm/+zC/4veW
	IyEa243i4MJt06OHBJRx4s5HdpZLICDd5mUxkPY+t3hqhCw1R7LNLk2EDe4wXck5cBluNmkrFfl
	bGYc504cJqmCA+LloMqNGsEdn2jUVygrDqHsjATQRzjbkN55W9eeIq2aGUwgezV6Drl5EHcsZFm
	OURVOyeXgOhlE6aDITUVI=
X-Received: by 2002:a05:600c:4589:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-483a95dea3emr196855965e9.16.1771867059590;
        Mon, 23 Feb 2026 09:17:39 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c982sm20871454f8f.31.2026.02.23.09.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:17:38 -0800 (PST)
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
Subject: [PATCH 3/9] dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
Date: Mon, 23 Feb 2026 17:12:42 +0000
Message-ID: <056cbc09fcbb4a2845cece69209a2a564d993ac5.1771865015.git.l.scorcia@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[gmail.com,packett.cool,kernel.org,mediatek.com,collabora.com,bootlin.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43053-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[packett.cool:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1E6A17AC93
X-Rspamd-Action: no action

From: Fabien Parent <parent.f@gmail.com>

Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index b95435bd6a9b..2d3c4161a7f8 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -30,6 +30,7 @@ properties:
       - mediatek,mt6357-keys
       - mediatek,mt6358-keys
       - mediatek,mt6359-keys
+      - mediatek,mt6392-keys
       - mediatek,mt6397-keys
 
   power-off-time-sec: true
-- 
2.43.0


