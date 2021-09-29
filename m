Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD35B41BE5A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 06:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhI2Eol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 00:44:41 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46255 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243992AbhI2Eoj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 00:44:39 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id C0880580DCA;
        Wed, 29 Sep 2021 00:42:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 29 Sep 2021 00:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=H92gfwIVzRY+x
        Fr/42obeioOfnah5ra1k8IBJ11GR04=; b=O1Q9kaJRG8Sq/CANgvn3+5zOcJLqP
        9HFsTcqkq9F1+AzZ23N6cu0IQgY3tZesh9HlDkfFoWkC0P0Oxyettxdy37GL5KZP
        CcFbeCqbj2Qs8Vw6PvXipu685l7bQAcXPzCDH+m6gxgskrzEinbacsVLNlw9GEJH
        XSdp5+gkPJN6onzC1QEnLlwx6GCid4JG4ccsBm8MTgkJQ7tGy/T7nvgPLntniEj2
        VYY6lqKxDin92zIvt/M0U9QVuG2e+6TXlxaCEuu3FIrJPA3TfNr0i4wBjLfKQpPm
        tAb2i3++kxds6xqZUqt56v1Hz6Xmxxxm1aCWGZq+A6dRf/KA8Iy85yAxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=H92gfwIVzRY+xFr/42obeioOfnah5ra1k8IBJ11GR04=; b=ez1u0+uL
        R+QOSiPSMTPDA1LTHgU5xe2kReydCd43K3Dxe5RzZzGwP/Ya4/rhjXtSvPHvSkQH
        NAsEzRwHiOjORjAAGi8/wvhnwaIqn95QsjKi6ziaHYLX0uEByGv515Bi0riBhIGU
        z5VThEMOugoBKYNCHedUroFR2y3nVwtdFqvLAe8lZzwCkj/utNDumUefWYRoQnRQ
        sAFyZ5p9g4dJbkWYsVEY1AYFL0CpRn1TDUqoIrVc+fMeJ5fi20jBXLUlbTdnfdLd
        5krup7xuVhbioRaYZX4OLxYQl2U9pWIsTEkSX5lYPU5c8c8pQYLwmrHZIVBmt4RV
        xm64RP4TTl2doA==
X-ME-Sender: <xms:0u5TYWlk5lgsX4SdJPL1zFsjsI3dNYRRMf4_AxADcLNLI0GReUTNbw>
    <xme:0u5TYd0yEb91v5OcT7orAAf28vl47F8iKSHZrAdAjvk7GwJFAk6MTSyPbgeJXppPI
    FLzhKOn0m7blgjf_A>
X-ME-Received: <xmr:0u5TYUqOIU_8ROaFnVroiCtOBkkb-A1ziegoySck__hxSNk3H4yGiVUUBoOUmPf_W9UuWyGRVdxKjptOm5RWYWvrBD8qZw_jrhZjiaO4qGyqdsIWDyKJvyXJrlh65BHa9UQyEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:0u5TYal9O3RyQP4lB50Kbp_CukMPIIaWP4dMxjCj_0xI4M1Y0U5NNg>
    <xmx:0u5TYU0bSpJqXCRFIO_Xj9zVepfqkoNXqhf8FJMs1Bk9yDnJjiNNow>
    <xmx:0u5TYRtq909FzMxUDbL1cuAPWLonPYZOY5cmgkmAwA8neMMGrGfQzw>
    <xmx:0u5TYf2OwE5dpFJXkp0ekUw9z71kXAPPct80pgZZRUVw1uYTNNxmQQ>
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
Subject: [PATCH 03/10] PM / devfreq: Drop code for descending freq_table
Date:   Tue, 28 Sep 2021 23:42:47 -0500
Message-Id: <20210929044254.38301-4-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929044254.38301-1-samuel@sholland.org>
References: <20210929044254.38301-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit 416b46a2627a ("PM / devfreq: Show the all available
frequencies"), freq_table's documentation requires it to be sorted in
ascending order. That commit modified available_frequencies_show() to
assume that order. This is also the order used by all existing drivers
and by set_freq_table().

However, there is still some code left over for compatibility with a
freq_table sorted descending. To avoid confusion, let's remove it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/devfreq/devfreq.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 426e31e6c448..f5d27f5285db 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -130,16 +130,10 @@ static void get_freq_range(struct devfreq *devfreq,
 
 	/*
 	 * Initialize minimum/maximum frequency from freq table.
-	 * The devfreq drivers can initialize this in either ascending or
-	 * descending order and devfreq core supports both.
+	 * The devfreq drivers should initialize this in ascending order.
 	 */
-	if (freq_table[0] < freq_table[devfreq->profile->max_state - 1]) {
-		*min_freq = freq_table[0];
-		*max_freq = freq_table[devfreq->profile->max_state - 1];
-	} else {
-		*min_freq = freq_table[devfreq->profile->max_state - 1];
-		*max_freq = freq_table[0];
-	}
+	*min_freq = freq_table[0];
+	*max_freq = freq_table[devfreq->profile->max_state - 1];
 
 	/* Apply constraints from PM QoS */
 	qos_min_freq = dev_pm_qos_read_value(devfreq->dev.parent,
-- 
2.31.1

