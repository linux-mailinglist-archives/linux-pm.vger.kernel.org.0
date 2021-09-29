Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9848F41BE5C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 06:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244089AbhI2Eom (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 00:44:42 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:39379 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243996AbhI2Eok (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 00:44:40 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 765FB580DCC;
        Wed, 29 Sep 2021 00:42:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 29 Sep 2021 00:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=WoIva3nZ/OvlI
        FuKcUaObQyBgwdR2tNV2TTl4sUUNog=; b=S2C8vuFAYoR2BbXNgEq2fwZlLmD4m
        FmS1y3sN1Y5x3e1jtDXqzjFqVOYUvmkUpRfgVn4ebRLMK/4dNrITKyBzxYleLmWZ
        IMWcNJXdsJ6vBjuMytf6lg0YZlxcrnW1ix51DjaJwnCpSgAVRdrpx37jplmGxeEr
        eFRHVEar3PZemg177qeW1vixvTMnUlDFTHxgjFF+5upyEYu+EUPP4rYLm9+RANHs
        JcyI/ivhyAKNRaFfJhliTtOeAUCDAIGFRVs5UuIHJ4N6rmIe4cN8hgsUV7RdU234
        XA81FgDXU5YKRQFlCw8Sqs6HEOf9+TWaS7QxLv+8kI08fQRIHSYcn5Oxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=WoIva3nZ/OvlIFuKcUaObQyBgwdR2tNV2TTl4sUUNog=; b=qv+hYIi+
        /G0Z6cuudD85y+InDX6ojari7YLfKQQXv82OmU2NIAo1M8tak9X+704oYXlbuf9r
        /EkfJQsNE15Q+56vgp0UQhKJYssDAkHJWOq3WzfFftMZ3VCqVaXpginHzDiIHyW1
        8jE5kdAXQO7W971Pn7mBpR5v97T29wyCp2kb/kevHnPktyK824er6MCUIePNZZiv
        zZOhqE+PmCzhexPPQHMytI+zB9kdkuuaH8o+w3pfd8siDTvaFe6FHvxNFBIQvUYy
        NF9Ru8MTMum281w/psAbTDcUH/hMaPBzHs1pnkT7EOrsYgDmzpRTsa8Ln4m/IguU
        Ddpj8vXkjQXFzg==
X-ME-Sender: <xms:0-5TYcE96cRbvD9GLjq7_IMjwe8KR_9z3DD5VmCkGakZAXZX7F3zYg>
    <xme:0-5TYVXNrPhos_Fmg6KTz55XrPptkNfb8qAyggJH961h61DuZ3PLI53fQT-y5p6dX
    2dXMqoqhty3AMa9nw>
X-ME-Received: <xmr:0-5TYWIjyhng54xuk3qSNEdhzvMrQSX40QASWk2Zgs-sm0GrAg_XkTr3UOUvC4EFCVM7ed1cfV9j05D3jK0T0ZlX_B0KbwiAGUDObbp97Ye_pn9I6gfJ6Tb_8HxzDDhpPfJBMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:0-5TYeGIFnZygPmWwMyngwGa_We-neaHzr801lPIc-PSd2sKxOletQ>
    <xmx:0-5TYSUyQhAncF6G2cvFYG0ni1dMMrKHn5X_lAYaWolbeUUS7-2c9Q>
    <xmx:0-5TYRM0PzaA4FUX8hDvLjTKQXaeh7gTLr3w43nPA3HfpvmuAK7W_w>
    <xmx:0-5TYbUz5fj2sfLJWGUReUnNGmtyIY_tybAh8DF8ahh-lSg_sSritw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Sep 2021 00:42:58 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 04/10] PM / devfreq: Add a recommended frequency helper
Date:   Tue, 28 Sep 2021 23:42:48 -0500
Message-Id: <20210929044254.38301-5-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929044254.38301-1-samuel@sholland.org>
References: <20210929044254.38301-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This helper peforms the same function as devfreq_recommended_opp().
However, it works on devices without OPPs by iterating over freq_table.
Since freq_table is assumed to be sorted in ascending order, the
algorithm is relatively simple.

Devices with OPPs should continue using devfreq_recommended_opp(), as
that function respects disabled OPPs.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/devfreq/devfreq.c | 27 +++++++++++++++++++++++++++
 include/linux/devfreq.h   |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index f5d27f5285db..fd46792297ad 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1984,6 +1984,33 @@ subsys_initcall(devfreq_init);
  * OPP framework.
  */
 
+/**
+ * devfreq_recommended_freq() - Helper function to get the proper frequency from
+ *			        freq_table for the value given to target callback.
+ * @devfreq:	The devfreq device.
+ * @freq:	The frequency given to target function.
+ * @flags:	Flags handed from devfreq framework.
+ */
+void devfreq_recommended_freq(struct devfreq *devfreq,
+			      unsigned long *freq, u32 flags)
+{
+	const unsigned long *min = devfreq->profile->freq_table;
+	const unsigned long *max = min + devfreq->profile->max_state - 1;
+	const unsigned long *f;
+
+	if (flags & DEVFREQ_FLAG_LEAST_UPPER_BOUND) {
+		/* Find the first item lower than freq, or else min. */
+		for (f = max; f > min && *f > *freq; --f)
+			;
+	} else {
+		/* Find the first item higher than freq, or else max. */
+		for (f = min; f < max && *f < *freq; ++f)
+			;
+	}
+	*freq = *f;
+}
+EXPORT_SYMBOL(devfreq_recommended_freq);
+
 /**
  * devfreq_recommended_opp() - Helper function to get proper OPP for the
  *			     freq value given to target callback.
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 142474b4af96..4d324fea8a78 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -239,6 +239,8 @@ void devfreq_resume(void);
 int update_devfreq(struct devfreq *devfreq);
 
 /* Helper functions for devfreq user device driver with OPP. */
+void devfreq_recommended_freq(struct devfreq *devfreq,
+			      unsigned long *freq, u32 flags);
 struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 				unsigned long *freq, u32 flags);
 int devfreq_register_opp_notifier(struct device *dev,
-- 
2.31.1

