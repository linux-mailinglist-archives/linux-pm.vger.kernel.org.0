Return-Path: <linux-pm+bounces-43801-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFhZMYHDqmlXWQEAu9opvQ
	(envelope-from <linux-pm+bounces-43801-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:07:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 199CF22022D
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC8183029B9C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 12:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D8238E123;
	Fri,  6 Mar 2026 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkh7R4wI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A981364EBC
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798786; cv=none; b=dBNiOfV6tPkfbGrmAMDFmSLNnNvpylEw84i31mlUVqH89QKl0rhrunTFc9EQYXtDs9rrl2f3DTTP0TPvk/fJzRdPnexy7XgQ4AAPBfum9GJGN/f6FpS2JoPbDhTSG9Ryhzw7SvzNLQzKnCu7jZwP6s50GKsPppHjMKw05r2TIbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798786; c=relaxed/simple;
	bh=q8iNQRclNimcvTVMz/xp0ANElWweIprPYt8rET1d6u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMGCtTQttVu0PNNpAUhsjAGmfCpu8pbOhz27yZnCdN27yINKJEb2xBoLUlGLmi4mLi28E33Nkt4x8nYyyiDXgnsn5QpoUXNcq/JxyxWFRsvgcMzSXYiKkVYTapeQ5M4uZGSZJVgsAzzWIXLwINTzSVbLHcStuC2MlSGmSGjplBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkh7R4wI; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439c5b40f60so2628348f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 04:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772798783; x=1773403583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+y0veSsgUsUJmnxU5xqCTTpBOt5TLJfl8EzSd1maDY=;
        b=fkh7R4wIhYmfpptMYrrqKRXNhNMhDlYQD6yU52VfzlaukLS141fSbydQF9L2K1IyKd
         DKLtonRhlY/JuKJ85qnFTRbDWT0QWFpeSzx222wlsEMHN8gyTjIHZEq9ycITQwtWjpqV
         ZpJl20PJVPIhGvDL0Nf/kWMxu32WE6DmH/1zWfKAwyodo6Jtk8oAIRWt7Lp9adA9Gp8D
         qcgbXlhwYOMomuNaPd9xE4Xo0n2NFRoffcuR5cOnh0oOP0y2f9rlDcuf7I6ukFyLv4py
         t/Hs9zXRg97khQJdm663VAZ0TRH44faJyqrjyrBsvEV2DG9l0jrsinqp2XG+pZObXG7L
         4qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798783; x=1773403583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+y0veSsgUsUJmnxU5xqCTTpBOt5TLJfl8EzSd1maDY=;
        b=rTXiBZnCti/9sCF5DVsNhOXiSM4taZL5hcjLlLATEcs74kg8HVl1p6U14nOZrTSSO/
         LdHgnE1v2prrvQGAJjLyTstJh1rV4mRjWduuPoBqqUy3kaQds86yGpJztchBr16ce1eN
         i2b1VyNn5G2Rna++fxMvc3Bua3O0qbVcYMnFuHyTmLLDESTRGRlHBz1fsahsUV+mcMMp
         cy0scqJBPc0WGRbBB+cH5ih1l0E+miPojdZAxqTxxgeYVLWbla/xIbNFnmL2/lEu8eva
         M2GCRbvV4bz7jpXtKEr14T1KOC4vNWK6KPz0GYHczg8DjHVIW+o3XcB0tYkqxbiPmlyX
         GWNw==
X-Forwarded-Encrypted: i=1; AJvYcCUfgN4eANCwzpoHJWQzl8up2TibSHPRI1qqi4ANWPPkPGYMvs8d9u4s3CGA+HfZTmeXu2k4rxxEJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK7QDzx2bQqkO3gapoG0CMaUj31dFAhhCGCLfxXyWXmSHbdzCb
	rLcB+rw2Wvies24dR3Yv5GTw6zEkpdPM6PJEEl8ctunYd+5Ht9LLXwGE
X-Gm-Gg: ATEYQzx9WiUweyNF1m//x52lO2fj7qHcp0dPJSnCJiCmyZYjY9MWMjH4f7DEJplrfTG
	WS0UiOmDOAKh3HCFDkllVUPbAzfzGXj4AMKFFz9V2Sz9+VJgW1rCVLfJzcQnceYv4dhnZFP7oz1
	33yrPIdhvmLDPlSs6/l9AMfB9jJ5bjv4RJnusP6YdPQAgERQOVtGqGiT12zVodqaODCAuLg/L/d
	LRYjoUVsFOVRbsN6WEvlxLJtLlNNUnmpHNGPPz/dDmeZuoehdluakFslclcBOiUUz9bPMaDLQPY
	0dTKvaKYOtk+LVD+fP8VHZF1ZlFF1xdYh10lzUlGA18uDU9JYB00XT/F5uQDBHE0IrNzLPyWTeY
	f+r6XsYgS72QEnZoZ4r2Vut7Bdk1mmek4VNy3vzy/DmyIBAd3OwQ7XEDOMihHVkmV8S9pabo4g1
	lisZmVVMxvMJ99kchCttQ=
X-Received: by 2002:a05:6000:290f:b0:439:b715:6f49 with SMTP id ffacd0b85a97d-439da86fa3dmr3098642f8f.59.1772798783337;
        Fri, 06 Mar 2026 04:06:23 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9d8sm3457225f8f.21.2026.03.06.04.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:06:22 -0800 (PST)
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
	Julien Massot <julien.massot@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/7] dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
Date: Fri,  6 Mar 2026 12:03:07 +0000
Message-ID: <20260306120521.163654-4-l.scorcia@gmail.com>
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
X-Rspamd-Queue-Id: 199CF22022D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43801-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,packett.cool:email]
X-Rspamd-Action: no action

From: Fabien Parent <parent.f@gmail.com>

Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


