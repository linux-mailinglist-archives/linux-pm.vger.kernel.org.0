Return-Path: <linux-pm+bounces-42392-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM0fEh7Fimm9NgAAu9opvQ
	(envelope-from <linux-pm+bounces-42392-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 06:41:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E770E1172A5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 06:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F3A33017259
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 05:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D095232D0D0;
	Tue, 10 Feb 2026 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7jQKF1+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CEB32D0F5
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 05:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770702058; cv=none; b=sSVNQsv6mfA5nR39WAo6bJBuBwuOpoNez3owsiau2KooOVqMbMZfVX/Kw2QBTVZ8ynpdGzkcMACH00EU9gWxILNOj4QJ5VdRlbP1hpgUeY85HaSj1kcR4jfUPZ8zrICXv69+rS5OgioQRAm37w5XAVIpKKHqD9u0SrJqZD+ZCvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770702058; c=relaxed/simple;
	bh=1KUelg9pD/rEzRhAQDzmX7XnUGou4EQnpuGOl9eA5tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmKwte2ZsLhgc69euhbFunPBCZwt1JTVZO6sCeF3L2kDvln7Z52hxjV7AxnGyE3hq4H6PnEzLNXIDgb5YB2edvlfy/XD5SYHtq/vD8hCuUYXxOB32e9NubyuuVEMfSUvu45SL8yf6W1mTfsXl74nfxyd3Y/A13TA9EvFO4pDroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7jQKF1+; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c6af798a83so556342685a.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 21:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770702056; x=1771306856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMfztC2Kl9bZJ/11xcUAkYHo13BsJ5PSJi+vhPNPnC0=;
        b=e7jQKF1+Yp8aKBiXQ0Yx8XuzTGjTotHXbPiQII/dltM2fvLi9F84hL2m88CHKUsOAg
         qBwWshj/P1eSgWP+ANIEW8Y0G2H2W9se63/f3FEI6/yWG9DlJn7SmU+7fBygtTuW61+2
         jsFnllC02lc+7rN6dBb6+GN3czVrME4sZ+6uRRSlllymDGfoJxvVAbK6eSHru5rubYdZ
         vC8rXkRHS0Lj/+NsKGGUQTTGqC5YkwAkdNCCyevoyP0uS256i4+/+1UKiUaVlq4wcYnf
         Q/a0HWEGwnEHTI3hITiUgIQ8hHq0TuBwU+txfGM/CpvKU9Dnxil8J7UE0qOr/4neS8+Z
         a8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770702056; x=1771306856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yMfztC2Kl9bZJ/11xcUAkYHo13BsJ5PSJi+vhPNPnC0=;
        b=ec1dBXCjVlgOzepnkubkucasMxbSRiyZoh45353AOW83zcV6iNqM+fYQlSO5hyPuIV
         9LJkV5bQclOnykCSFOB+tKBw2sY0wJT3XS8WTuvxYHYpFr4ZeSbNvq0hiqqNrB2vq8ra
         2Cfqd1dIJUq1mYib4Wwcos8Bs1zYiRphSijbgPvNbLVJxJlbH/PRfwuwKlXvzLTBN6XP
         DZaK5NoNuNop2I4Bq9DjPZ0cwtv7q4SGjwOeeeH9jr6c1BSU3cdd7WRd42rfeFlx4tKD
         xJNJfrDRw6vR5IPgcJrlLlYDR/71PKm9+/BCAoALMDVQ/B6q2yShiCcte8TcMcAR5dhk
         58cA==
X-Forwarded-Encrypted: i=1; AJvYcCWh3mUgBsYLd/W+QaBSsw4usyQKbOzZ3KuvDKU8DXZrcixBeRvu1IrX3pJxxnCRJLV06wDoDVxGPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhdSw4ydI0lYLhcZJx/alyMnd12Y8V/E41z/cqkZwtT6yD+pcC
	vKrvqtzLxGknSo3H/gz7AloQO8H6LeLMDb3/59VeVt9mehxjXRVBw5E9
X-Gm-Gg: AZuq6aLyq3eD4uAHX2RR+OL2gklgZEmvA1cl/65233LNI1eMFH0KtcqZyaodHNE1tel
	D0Ti5LLFCtSJUfsnHGYgqNRp9OzcclBOtLHq16fgqj2Ra4bSRx86LOGi+iRGom5XQQrnkCbxevp
	mVxjQhCnRHczGr9+Z1tx6wJMM/llZWN5HPGmv9br/YunieKFvmaZPljtYaGcpfZqZbFegrTI9xa
	rprCIm8GI3uT4jec8RrrB/lX5QBvi3M3q9DrFZ13YetRqQiZBNH7SnaQ8ls4mL8x84lPrkH6Xkt
	tyXsYoP3CXmPchTQKfXxhHIteoUnc/aMdF9XjQcmQmYlKhNRjRW6ydYtQ1NObYrM4nil0J3wqCT
	PMVw/V/z78L4HypgvqRyAcD53qk8AgWBtfd94X2lIsvLzqqyVO3j/MH+bolgRFfFhiCd6zYzpt7
	Ath5y8TeSNEc52txLiOA+pN07Re3rddqhADZcNcheO9MSOH7dWz4W1q2cT5HJG5v144nkivvz86
	A==
X-Received: by 2002:a05:620a:1a1f:b0:8c7:6f8:ae4c with SMTP id af79cd13be357-8cb1f74d3bemr112907085a.43.1770702056479;
        Mon, 09 Feb 2026 21:40:56 -0800 (PST)
Received: from aford-System-Version.lan (c-68-46-10-116.hsd1.mn.comcast.net. [68.46.10.116])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee9fbasm978632285a.39.2026.02.09.21.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 21:40:55 -0800 (PST)
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
Subject: [PATCH 3/5] clk: mediatek: Fix MT8196 topckgen orphan clock
Date: Mon,  9 Feb 2026 23:37:03 -0600
Message-ID: <20260210053708.17239-3-aford173@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210053708.17239-1-aford173@gmail.com>
References: <20260210053708.17239-1-aford173@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,gmail.com,baylibre.com,kernel.org,linaro.org,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-42392-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E770E1172A5
X-Rspamd-Action: no action

There is a clock with its name spelled incorrecly, so when a child tries
to associate itself to a parent, there isn't a parent.  Fixing the name
restores the proper parent-child relations of this clocks and eliminates
the orphaned clock.

Fixes: 895ab0134d64 ("clk: mediatek: Add MT8196 topckgen clock support")
Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/clk/mediatek/clk-mt8196-topckgen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8196-topckgen.c b/drivers/clk/mediatek/clk-mt8196-topckgen.c
index 6ace11ef6b69..2482597b9b7a 100644
--- a/drivers/clk/mediatek/clk-mt8196-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8196-topckgen.c
@@ -324,7 +324,7 @@ static const char * const emi_parents[] = {
 	"mainpll_d5_d8",
 	"mainpll_d5_d4",
 	"mainpll_d4_d4",
-	"emipll1_ck"
+	"emipll"
 };
 
 static const char * const ap2conn_host_parents[] = {
-- 
2.51.0


