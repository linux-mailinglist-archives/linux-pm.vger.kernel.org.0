Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DD441BE56
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 06:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbhI2Eoi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 00:44:38 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50399 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234322AbhI2Eoi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 00:44:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 487FC580DBB;
        Wed, 29 Sep 2021 00:42:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 29 Sep 2021 00:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ALZ+89RMWvaZz
        rA1f7LpbYBKk681jYZFRU0J8EDdz70=; b=aHOjpZKk7ni97VKtrRLtFFZ1iwGIB
        TMsK+fc3B68/7XiuJEksS+ihr0aNky5WGq69mSCxkXvLLCfAEHvoYD8OG+xHwxxu
        MnoWI2lDuQSHi0vWwoiq75uDr4G2HHQcFl9wcIf4IV9QrTyiVQgaeBMiULjhZ+Cc
        LOxlecqpNeVqbj8F8ymmlm64uhnmLbv1r3XaC2r5IcGw2CZCpWP9LbPRQoWXZzXt
        KrTCBVNnl/NPhpjwR4j9iQ8Qp9BVmo4jNnvvtfCq5s1RL4zcs2KO0/qxb4IjJNxR
        Bq8zhihG8vEkwXzajg97ZE+uXz5Havo+pkcRuupzTKy+TU03wZyudCceQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ALZ+89RMWvaZzrA1f7LpbYBKk681jYZFRU0J8EDdz70=; b=C6BDVr2i
        pB1eDRrcoLpIh7k9Ln4kEIWtdGCxsMLREz8kkBw9IOBwwzjWuJXpUrWKyzL7hkVK
        0uth7rQKW8/O1Zh2/F3eleeVZbKje96cph8nA3T/VUMfi7E8j/zG+v8Y4t2m2PKF
        t/nnMRNxreTl6hga08MvCqUW3hN95YqsVJCNql5nWfw+F+W236Keao+e7aPZMkxj
        68maWWp4wm3F6StaFq0NszG6CXV+KuyuRjQFLcriyTvwO0bzLWGlklMWSwhENFBP
        jy8vp1z2oHI56xlfNrkekGH9o3Qwvqv922xH+MvyWChFCFJELdyIP/SKbjwXvBHZ
        BLMaR2zvjOoZBQ==
X-ME-Sender: <xms:0e5TYZHLNcFtKLfxlCZiwixM4gPi7bNQ65ItvndcZN2pu5h3j5R--Q>
    <xme:0e5TYeUObkhAMkQOcmRPtO99-mh2tiiXTbHKMPMoxXYIQABLhawsj35oN8806_rgG
    RXSd_TNoM8OEEYKKg>
X-ME-Received: <xmr:0e5TYbJtugA1G-liCglqU1kEA62SXlLmtEtPWFyDoqazpCn2wyZa7ZLBu8mSGQSuWAmOzkbGZGPJvbGXvhlrkrUTcAo3nGWa3k6QDZsbSiFRsxiLR-ceDMJlhq8MUe7YRXmSAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:0e5TYfEM6o75NUErOvLp7vrkb4cydjArZ4DJXntZ0KJtuVutQFjA0g>
    <xmx:0e5TYfXMt0ll6YFvCukJ2ncOulCR5OxWWGakwxCnqjB9WLaFZI0V0A>
    <xmx:0e5TYaP-KG7nikGsQNWzZe8qP-V0WZUwjf8nwt7wcT7DiGTmNlBPmw>
    <xmx:0e5TYcVMypkcMUc2PAF1ZHhV0DxFUAdcbe1w4Y_3QXFedwSg0rzjfA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Sep 2021 00:42:56 -0400 (EDT)
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
Subject: [PATCH 01/10] PM / devfreq: strengthen check for freq_table
Date:   Tue, 28 Sep 2021 23:42:45 -0500
Message-Id: <20210929044254.38301-2-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929044254.38301-1-samuel@sholland.org>
References: <20210929044254.38301-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit ea572f816032 ("PM / devfreq: Change return type of
devfreq_set_freq_table()"), all devfreq devices are expected to have a
valid freq_table. The devfreq core unconditionally dereferences
freq_table in the sysfs code and in get_freq_range().

Therefore, we need to ensure that freq_table is both non-null and
non-empty (length is > 0). If either check fails, replace the table
using set_freq_table() or return the error.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 28f3e0ba6cdd..7a8b022ba456 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -827,7 +827,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_dev;
 	}
 
-	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
+	if (!devfreq->profile->max_state || !devfreq->profile->freq_table) {
 		mutex_unlock(&devfreq->lock);
 		err = set_freq_table(devfreq);
 		if (err < 0)
-- 
2.31.1

