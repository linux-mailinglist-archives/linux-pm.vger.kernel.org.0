Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CBA41BE58
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 06:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243997AbhI2Eok (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 00:44:40 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:39379 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243885AbhI2Eoi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 00:44:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 175A2580DC4;
        Wed, 29 Sep 2021 00:42:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 29 Sep 2021 00:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=nBAwb14NmcBdr
        AqnC9W+le998BEqA3ENpSMZEhHDV8s=; b=XwY8yDnGMrZu2/GE4s1VOatuLG925
        E9Qxi9T6/X1OO3MTcL1Dlo/I7z++vNarJnSEGmdf/aPf6c6Jyj3YVrriL+Gl8AWS
        Ul4OFTKo0ySUQ4T2Fren8iEX/AZH6okvsC8mw2wkIa/T4viinkNV4JreEMX57H8v
        s2ZPU+C2RUUIGYEeojAiClPhG9Bfe5eb/O9GjpOXuybDeM+x/Vnh2vctIPTKv9Zm
        Jv/Y5bgSbQ1BTmd3Ka/q5nkoLxTUgsDJGCvDiF4+Rzfs5G2+1AUOzgDBOE3ziV3K
        BGkO8uhh3UZQ32S/3K8nN+5cQiE4HRCM8fd5Ocd+rkEG7yxpiQLBc2S2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=nBAwb14NmcBdrAqnC9W+le998BEqA3ENpSMZEhHDV8s=; b=Hjm8Gjra
        pFnFYHk8xStLnM0jSsqqPsvYcICjpnuWdvvcrQtozJ/dEqIsQ9gb9ah3cN2khXxE
        ykVJ40PhAs5vrhAEtsraFXZEhFgyUDq+tyNyaH1QTs+yuQVZPHIaslJiUS5RL5M7
        AgwocBOdVOxr5QisAEyN9L9tJAdpQ+tl40rT1Whj+Kuhc9W7uFHLxMlrKp1/og3p
        g4/PP7pN93qJbN2mxDPn0ZpNgVvka/p2tR5oA3cpy0fSLtuIiIUjb9y3M3L+cnd0
        1Sy8X3eAfdPKWKESqHb0Dync+du/9u+vILusp7cMOHRkCpNwexJXh6flcJscuZJ6
        aFULWOvk/OnCQw==
X-ME-Sender: <xms:0e5TYeXQOfvL7PFhNQAT6iUFABSV79E6L3jdr2Rn0wo_Lt9hTKwwKw>
    <xme:0e5TYanLXVr0x9fqE_sOvFrSzCnjQH9SkXTFtW7Zdx_S2PB291RsSo34UCsVYI2Qd
    DNWGKnYDNZGTksWEA>
X-ME-Received: <xmr:0e5TYSblFQTvx_abZW0Ltf5ecRg_zHfVLtyeYrwQ12HSt49kh-RsjJNEEmembPdVQb6KYiyhbiy9maia_lYq6C0HbWuQj1dP2jaMXC0XEVGdGno6hNERfwtAEStekgf1o9i1eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:0e5TYVUhHuGGpqV3aTmHdJ-KZjqfiKC7Elfzt2VlNUBB01V_daQySA>
    <xmx:0e5TYYlTZphbrgXK9OrtqdmrSVFMR8PJ3pRmYIsjQkxZmbxD8i5VAw>
    <xmx:0e5TYadD0SPCDaYRnjzXwvfERkm2dz2uLfd5fbATDp4t6pcJf14x4w>
    <xmx:0u5TYWm025yeGv60lCD4mISNWRzgF-PcJwmU6UUXpjcQJhMAsP1V6g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Sep 2021 00:42:57 -0400 (EDT)
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
Subject: [PATCH 02/10] PM / devfreq: Do not require devices to have OPPs
Date:   Tue, 28 Sep 2021 23:42:46 -0500
Message-Id: <20210929044254.38301-3-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929044254.38301-1-samuel@sholland.org>
References: <20210929044254.38301-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit ea572f816032 ("PM / devfreq: Change return type of
devfreq_set_freq_table()"), all devfreq devices are required to have a
valid freq_table. If freq_table is not provided by the driver, it will
be filled in by set_freq_table() from the OPPs; if that fails,
devfreq_add_device() will return an error.

However, since commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when
adding the devfreq device"), devfreq devices are _also_ required to have
an OPP table, even if they provide freq_table. devfreq_add_device()
requires dev_pm_opp_find_freq_ceil() and dev_pm_opp_find_freq_floor() to
return successfully, specifically to initialize scaling_min/max_freq.

Not all drivers need an OPP table. For example, a driver where all
frequencies are determined dynamically could work by filling out only
freq_table. But with the current code it must call dev_pm_opp_add() on
every freq_table entry to probe successfully.

The offending properties, scaling_min/max_freq, are only necessary if a
device has OPPs; if no OPPs exist at all, OPPs cannot be dynamically
enabled or disabled, so those values have no effect. Thus it is trivial
to restore support for devices with freq_table only and not OPPs -- move
those initializations behind the check for a valid OPP table.

Since get_freq_range() uses scaling_max_freq in a min() expression, it
must be initialized to the maximum possible value. scaling_min_freq is
initialized as well for consistency.

Fixes: ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the devfreq device")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/devfreq/devfreq.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 7a8b022ba456..426e31e6c448 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -835,24 +835,28 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		mutex_lock(&devfreq->lock);
 	}
 
-	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
-	if (!devfreq->scaling_min_freq) {
-		mutex_unlock(&devfreq->lock);
-		err = -EINVAL;
-		goto err_dev;
-	}
-
-	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
-	if (!devfreq->scaling_max_freq) {
-		mutex_unlock(&devfreq->lock);
-		err = -EINVAL;
-		goto err_dev;
-	}
-
-	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
-	if (IS_ERR(devfreq->opp_table))
+	if (IS_ERR(devfreq->opp_table)) {
 		devfreq->opp_table = NULL;
+		devfreq->scaling_min_freq = 0;
+		devfreq->scaling_max_freq = ULONG_MAX;
+	} else {
+		devfreq->scaling_min_freq = find_available_min_freq(devfreq);
+		if (!devfreq->scaling_min_freq) {
+			mutex_unlock(&devfreq->lock);
+			err = -EINVAL;
+			goto err_dev;
+		}
+
+		devfreq->scaling_max_freq = find_available_max_freq(devfreq);
+		if (!devfreq->scaling_max_freq) {
+			mutex_unlock(&devfreq->lock);
+			err = -EINVAL;
+			goto err_dev;
+		}
+
+		devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
+	}
 
 	atomic_set(&devfreq->suspend_count, 0);
 
-- 
2.31.1

