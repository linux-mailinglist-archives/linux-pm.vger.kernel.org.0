Return-Path: <linux-pm+bounces-24539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8692DA71E50
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 19:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F963B3A3C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F2F255249;
	Wed, 26 Mar 2025 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HtU8fdh7"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D167C253329;
	Wed, 26 Mar 2025 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013594; cv=none; b=YiULyy7c9BtaOm4dRt8c1LIGaJoZB/2gugD3L46Sh/kHgDLQ6RDxw6J30AEis/1R8GHYWp5mZUkzbBS4tS98/Kd3KURiUfAvJ50RRVyevMOtru5JvvK8JXILojlkfkhX01XrM7tEMgXMOScS++aXaigrybxAHnatqyqIQh4FiVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013594; c=relaxed/simple;
	bh=sNLIxfRQxoLMAhgUD68uj8OIlLkhY/ZJlt5ea2wwBSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYnqc3I1gJibTq+LGtj8bCDwznCFaMSetUtcW3LIsqDrE3LzsSCCXpOlpMku6HYfDdQDeXl+496EMHeiPI9/sWJe7laetgDk7A+gr/9QIjufHJgVkTA1Rb0Bt0xWZyh4B6QylHWc0XkeJwtGC7zvUPrH2Qou0HtWa7jFzc3zv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HtU8fdh7; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5F474443D;
	Wed, 26 Mar 2025 18:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743013589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+D4+TVvLLcIqytfuD7J/XNoklUwFm0W6VvZ8tlYmJk=;
	b=HtU8fdh7KePPCVVs9OoRBWCkqO2qnhsZ7a3r2bxlZb5tjI2un0xAtctzxTQ6PGahKj9ket
	J3zoCgV5+dr5QarWYkE5m2NiEGTxbXDuu5680oLiItkhvX9TGmlNELK2j/B5bOzZcdF1lh
	EEqPyoKT0njR1vzl76N3sko45VurrjY0CfFmL9DLTJPHSc/r7cVK2CPbGNF7eCi1mG2m1/
	LFSLM8Y+hnwLTfpJbz8I2RZQFhx55Qr3HkHrNDiVUuICdhcjyY4w5DvM9Z/IgMRrBhLik7
	+A3dISVCcSFimQa5Q3TXFLspZrZbpnxYNfHb8bw7ncy7kt/HNiV8TyxeBQQFUA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 26 Mar 2025 19:26:18 +0100
Subject: [PATCH RFC 03/10] clk: Avoid non needed runtime PM calls
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-cross-lock-dep-v1-3-3199e49e8652@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeivdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopehmrghrvgigseguvghngidruggvpdhrtghpthhtoheplhhinhhugidqihhmgiesnhigphdrtghomhdprhgtphhtthhopehlihhnuhigqdgtlhhksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihgrnhdrrhgrhiesghgvhhgvrghlthhhtggrrhgvrdgtohhmpdhrtghpthhtohepmhhtuhhrqhhuvghtthgvsegsrgihlhhisghrvgdrtghomhdpr
 hgtphhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhhhilhhmrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

clk_core_is_prepared() needs the clock to be runtime resumed in order to
call the ->is_prepared() callback. But at the same time, clk_prepare()
runtime resumes the clock and clk_unprepare() runtime disables it.

The fact that the clock might be runtime resumed do not indicate it's
been prepared, however the fact that it's been prepared implies that
it's been runtime resumed.

We can safely check the runtime status of the clock (and RPM increment
it in this case) instead of actually calling resume. With this little
trick, clk_core_is_prepared() can be called from anywhere without extra
constraint regarding the fact that the prepare_lock mutex might be
acquired or not already.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/clk.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7df9965bcbdffd641e6dbf5bff3d3b20079a3af3..1c15d72cd3daeeb5bb4f0d94c9f387526fab75ae 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -119,6 +119,20 @@ static int clk_pm_runtime_get(struct clk_core *core)
 	return pm_runtime_resume_and_get(core->dev);
 }
 
+static int clk_pm_runtime_get_if_active(struct clk_core *core)
+{
+	int ret;
+
+	if (!core || !core->rpm_enabled)
+		return 0;
+
+	ret = pm_runtime_get_if_active(core->dev);
+	if (ret == 1)
+		return 0;
+
+	return -EINVAL;
+}
+
 static void clk_pm_runtime_put(struct clk_core *core)
 {
 	if (!core->rpm_enabled)
@@ -295,7 +309,7 @@ static bool clk_core_is_prepared(struct clk_core *core)
 	if (!core->ops->is_prepared)
 		return core->prepare_count;
 
-	if (!clk_pm_runtime_get(core)) {
+	if (!clk_pm_runtime_get_if_active(core)) {
 		ret = core->ops->is_prepared(core->hw);
 		clk_pm_runtime_put(core);
 	}

-- 
2.48.1


