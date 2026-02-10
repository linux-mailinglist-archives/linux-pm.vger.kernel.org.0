Return-Path: <linux-pm+bounces-42390-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD1cHOjEimm9NgAAu9opvQ
	(envelope-from <linux-pm+bounces-42390-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 06:40:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DF1117259
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 06:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6590F301177B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 05:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E033832BF38;
	Tue, 10 Feb 2026 05:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN1XGimb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62581EDA0F
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 05:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770702053; cv=none; b=V8WqxxI/hpSS2im5ze5Imfvd2Vz3CkUUS6vnbEiZE2CZpElmnSNLHcO7dGa7AIl+s4iKNPPOzL2SnT2LO7kJ4MuqgvF/64aG5i0O6xVxrkypbUrp6IKedhduxMT612R/kJTLB0CklsixSBesDYl1nPEeMAj2Mk62MYu8ytnTh2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770702053; c=relaxed/simple;
	bh=p2dA9KDQRjS45qNOOtBa8QMra+nlcWCB9wGJ5zfkaYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ha57kgFUjleVpuUxGNp3zgxbYOGJL2rUX1z++OgOeOGOtUA+7rhlpmq9/TldiAq0RcAmUOnZ5rxf7g3Js4XUC8pXPa69eD3egOTt19ietZEcfUKilPHRaeXvPhd1Y5+OghfECuVtNpkingK1QWAw4WUOVEGP30eBlkzxmxzmfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fN1XGimb; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c7199e7f79so529292885a.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 21:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770702052; x=1771306852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=onU77N0wQuj5Lnll1/fvZOs/qEnLfPl+2FK8REXemOY=;
        b=fN1XGimbTOWN/1fxT4d/KvhSDiTt0a5Nq1JtdH/FgZjIH5FEDHiA/1cmXs2ZFejXwU
         jhb1qFDF5q3LKZfMbAdtaKxK1rotudiDt1opi41zlq9DVfqvbR/F2qYWHN0fRbe1jO3E
         yeSg5WwFR5P3uxVejBq9DYbu+5ug/iWt2D4sSgMJiiUB/mS1GQOZ+ndnykGZW6vnB5mL
         loJ5uEDoMutT0ehOpFD/0TdlODYzGTRIsFA17NhHX+Ib/q5U03RLyZRbEOXMbUPTzxV5
         yiXEYhybJQzBJ+G2piL/Eq+10RS6Iw7mxCHBugaf2/Sz2ZydMVF6qwm4aNpWDPcL/fuH
         pXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770702052; x=1771306852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onU77N0wQuj5Lnll1/fvZOs/qEnLfPl+2FK8REXemOY=;
        b=tGuKcwLO15otaTdBcUoSiz2bMeXI+/lNnDzS5JQapbDQ40l/WIYd8n4X6eMja/hbiy
         1gizR5ZO1lRIv+UJFLIOIV4ed9q0Ar1v9f0cW7Ln4KWcY19Jo+IqtGLOrj6pDzJwqrgG
         ajtK7AKH20P1AKR5ftJ3F2arSmvmfvUMPtimNuoPBLeYLvN8V9n57iVGsKUjBAKpi/ao
         4lhOGELHOJGqaTqD4o2ELA5bQ2xYfCYd5iv4vnzeVWt5koPeMtn4ush3ivY0w0OMQTGf
         7B44dBuBkXl7Mh8kw+F4j9ktT3Mow6YTQNeH8MgEclOHD/j5+2PRstttqyhUYKXj9aLi
         6dnA==
X-Forwarded-Encrypted: i=1; AJvYcCWu5I/e4QVNpYwlWU0FTzbsJC63WKrQ3yWjPPR4Il0cCTxVlAyrn9CmIURfH//JrUOBOaGRi4UhNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6hXxq5btIGWqCEbzI4FOoofoIjwnVdR7TYiwRprxXLmBvoTKo
	jsnUWYvNCvBPXFdsjJuHiMY+UeKyQvrq5R/aymywdB4D/hjf67FN5jp4
X-Gm-Gg: AZuq6aKc6FiFYIFGbJgx1dzWqIWJ/xf7++rwRXohyjNOJYivP4TioymKgaHwlPswu2R
	QookrdpotL0TMx2yG2/wg0efG+8JINxmyix7jlEcHw4fg6g+GTMWqiwAcaJnPTj9qP8uyiyOCJJ
	hrasEiUEVR4sc9B+MFChSBNBT8RYNNP2eGjraO/0J3zhK7dith1BTTo70q8aUgu5Mx7FlthYTd8
	wQSUH0Hqj80leez2MOo2JbJY72kQRkOPmQfaJwfQGxcPWLW1m4HAhKRgXmWmT173cCRKxrr7ls1
	SMVcqROArzmLv+ZMQY5Sd0pOpNH8e42BmMRKWUj6I0HOsNcC+HAD5otZm82LgqjtJAzS7Fl8wKI
	rVt4fMK3Bh3COKYJQ/rzxteaANj9AYOU4sPy7GKrtdbC9jE0FdFSG0NrRkJA8y/c+s/1IR9oEYK
	Ex6wFOUAfGTL+hlYu7NNvgGaSg3BS/jmpIc6WQTtrZxGMsLdbv5K2gz5d0Yyx/9rQEzyiFC+Ae6
	w==
X-Received: by 2002:a05:620a:1982:b0:8c7:16fb:ed45 with SMTP id af79cd13be357-8caef7e16e5mr1861918185a.27.1770702051590;
        Mon, 09 Feb 2026 21:40:51 -0800 (PST)
Received: from aford-System-Version.lan (c-68-46-10-116.hsd1.mn.comcast.net. [68.46.10.116])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee9fbasm978632285a.39.2026.02.09.21.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 21:40:50 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: angelogioacchino.delregno@collabora.com,
	Adam Ford <aford173@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/5] pmdomain: mediatek: Fix power domain count
Date: Mon,  9 Feb 2026 23:37:01 -0600
Message-ID: <20260210053708.17239-1-aford173@gmail.com>
X-Mailer: git-send-email 2.51.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,gmail.com,baylibre.com,kernel.org,linaro.org,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-42390-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aford173@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7DF1117259
X-Rspamd-Action: no action

The wrong value of the number of domains is wrong which leads to
failures when trying to enumerate nested power domains.

 PM: genpd_xlate_onecell: invalid domain index 0
 PM: genpd_xlate_onecell: invalid domain index 1
 PM: genpd_xlate_onecell: invalid domain index 3
 PM: genpd_xlate_onecell: invalid domain index 4
 PM: genpd_xlate_onecell: invalid domain index 5
 PM: genpd_xlate_onecell: invalid domain index 13
 PM: genpd_xlate_onecell: invalid domain index 14

Attempts to use these power domains fail, so fix this by
using the correct value of calculated power domains.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 58648f4f689b..d2b8d0332951 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -1228,7 +1228,7 @@ static int scpsys_probe(struct platform_device *pdev)
 	scpsys->soc_data = soc;
 
 	scpsys->pd_data.domains = scpsys->domains;
-	scpsys->pd_data.num_domains = soc->num_domains;
+	scpsys->pd_data.num_domains = num_domains;
 
 	parent = dev->parent;
 	if (!parent) {
-- 
2.51.0


