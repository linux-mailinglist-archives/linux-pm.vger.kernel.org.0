Return-Path: <linux-pm+bounces-24543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF8DA71E5C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 19:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ABA07A51DD
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A2925A2DF;
	Wed, 26 Mar 2025 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RPxAusWO"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58812580D2;
	Wed, 26 Mar 2025 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013598; cv=none; b=HyXzicwnyHwnx7KUBidtxEjrdphT4ZnyJv5QEG8ZEy4K6YY0y307m/AVKDlV1dZQQHeYQqtVwOBwJCfXKVgSZtHpUc3zNXH5MK9nZN2NZfAXPZn4Q8B06S3cbtBgq7c6X6HajGkK5G06So3HCR95av6DNZpt9LXyXR7ILGKUfrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013598; c=relaxed/simple;
	bh=vAlRbDLpBPvP27lE5l60zdFPJjk/fx1iTxJsOyArih8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1HchB6EpJEl8XGw/+y+5tuU3iMS9WisUuxv6q6GfQWO4pK5fZG4BWnIniwgag3v5rYGGmWVpcdIjxKxPZbh/IfN2MF0iEOVsH8UU4MIg31tN/nCEiWyVDl6lVyuIOtjYcLw2Sm8VinmLkh6BxSYQH+rHlHVhx1rIv6rU1SDAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RPxAusWO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D81734441C;
	Wed, 26 Mar 2025 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743013595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2hsGs3TPtjFLp63wGPsUwJ0AqSkzAmn92jic3zpuq8=;
	b=RPxAusWOpENU7S+0Gm6/ZorY7WocaT/IlByfoaDUzw/QcIBrAcdCo734i2ubSBsnX9hARj
	CXlaxA8jExPw3ZBbze+xDVOPFzaw4bLYWcucOZrGxZDlpmBk1FL7pdEx66Qhn6I8fewkE9
	hVWs8cB0b8zSxpL+WJB/3imhLhZ7SHeTcQhkAzKVfvIc3gt5wZU08102nIELKlLZjfNMIX
	apcQ3WMsuDUn7ebSslAsiscmz1TUA9wcp1X/ai580VAEmxhIePq3rFB6+Cn80a3ipaf6c+
	vJ0NlQQkKAOl5xVY+xFIWMUtot/6GK4MnbS4uursyGA5iNz1VLZxddnhVbhBTw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 26 Mar 2025 19:26:22 +0100
Subject: [PATCH RFC 07/10] clk: Ensure all RPM enabled clocks are enabled
 before reparenting orphans
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-cross-lock-dep-v1-7-3199e49e8652@bootlin.com>
References: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
In-Reply-To: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Len Brown <len.brown@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Kevin Hilman <khilman@kernel.org>, Fabio Estevam <festevam@denx.de>, 
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 linux-imx@nxp.com, Ian Ray <ian.ray@gehealthcare.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Saravana Kannan <saravanak@google.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeivdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopehmrghrvgigseguvghngidruggvpdhrtghpthhtoheplhhinhhugidqihhmgiesnhigphdrtghomhdprhgtphhtthhopehlihhnuhigqdgtlhhksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihgrnhdrrhgrhiesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepmhhtuhhrqhhuvghtthgvsegsrgihlhhisghrvgdrtghomhdpr
 hgtphhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhhhilhhmrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

In order to fix the ABBA locking situation between clock and power
domains, let's disimburse these two locks by preventing any runtime PM
call to happen with the clk prepare_lock mutex acquired.

Reparenting orphans upon introduction of a new provider means that if
there is a match, the core will recalculate the rates, which requires
the relevant clocks to be enabled.

There is not much we can do to guess which clocks will need rate
recalculation, so better ensure all registered clocks are resumed before
doing the reparenting operation which obviously requires acquiring the
clk prepare_lock to protect against concurrent accesses on the clk tree
topology.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 95f53bc427d8980287bfe668d1c993023e0e078b..4c2f2d2b7735dfbe323fec4e0d331302534bc849 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -5032,8 +5032,16 @@ int of_clk_add_provider(struct device_node *np,
 	mutex_unlock(&of_clk_mutex);
 	pr_debug("Added clock from %pOF\n", np);
 
+	ret = clk_pm_runtime_get_all();
+	if (ret) {
+		of_clk_del_provider(np);
+		return ret;
+	}
+
 	clk_core_reparent_orphans();
 
+	clk_pm_runtime_put_all();
+
 	ret = of_clk_set_defaults(np, true);
 	if (ret < 0)
 		of_clk_del_provider(np);
@@ -5074,8 +5082,16 @@ int of_clk_add_hw_provider(struct device_node *np,
 	mutex_unlock(&of_clk_mutex);
 	pr_debug("Added clk_hw provider from %pOF\n", np);
 
+	ret = clk_pm_runtime_get_all();
+	if (ret) {
+		of_clk_del_provider(np);
+		return ret;
+	}
+
 	clk_core_reparent_orphans();
 
+	clk_pm_runtime_put_all();
+
 	ret = of_clk_set_defaults(np, true);
 	if (ret < 0)
 		of_clk_del_provider(np);

-- 
2.48.1


