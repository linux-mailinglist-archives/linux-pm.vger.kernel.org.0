Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79E024425A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHNAJb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgHNAHR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:17 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C673C061383;
        Thu, 13 Aug 2020 17:07:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w14so8110042ljj.4;
        Thu, 13 Aug 2020 17:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdFHEYH0SedaYmARghSCa7o+JjfWSMYBVfZijnGUEd0=;
        b=eRd1rHgYkncn22Ou0jtrzjuUMIhGYMHYufHy42pGDs51PAOtFx2BMutWIBqfSQZgeh
         D7/PQ6Xqbi4FxgeoJmMRNpZCjT8b2Uc+GUkG5ycvfAGH8nKeOCGifPVc+cSILE2DBkFq
         pwBsZhyi4RjC9JIaFLEoJceorJBvBa6rwT6J/Vn06MsajIMtPrlQeY1332O/NBjs8Zx7
         cCQrW7fLJxr6U1pgQqocd06kUMG4un9wqz5hetkah8/G5Frrr2jypCwDGGW0dHIaqSvR
         tloMI9cMtsC2Ggb+rToMR8iWZ0fyc0Z/grWTZbiGH4awBP6befBtmj+oE8ZDYPmB+e+1
         IXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdFHEYH0SedaYmARghSCa7o+JjfWSMYBVfZijnGUEd0=;
        b=Ld3ynTToGDI1d27QaqcpwELvU98uZsvHQBSK8Sx51dYUfBG3kmRGgLVoV4jcYt1Gwf
         rZccAAafJdYNTVkuJ5xWQtivN7Aw45wPg0WplMxlp75+gIGnw+7R9bF1UzXvaH9dVMCg
         IGUo8PyLd6dsrT8HBvVaj03F6gZbqbpglpqry7dDHeztNvoszLT5B3OESuJ0Gp9hs3cd
         joRblOpbbl6+zxaRJdFzlsmTLDe0xheg3Qe3YJt/o5w+gUpLOzOHaU6wYZSlPDBN65HO
         hpniSRu2ij8Ib2kVhujlFsRIoIC8lHz+h5RFtZuoH/RpibuJvBpBu7XRyMvrnDZjCsUg
         rvqQ==
X-Gm-Message-State: AOAM533ghQUrimbJMvBnQBBPY0n/TNEy/6buQc3nnnJwzKqKlsfhXAVU
        LNG58ICTAj5wPBKKCiEONm8=
X-Google-Smtp-Source: ABdhPJxL9BUYSKl5lC8jFL/iz/BrlYghtRVCp2vUSd1CIrGiHquNBYFpKfC60ekSidFAFA3FJT+PMw==
X-Received: by 2002:a2e:b008:: with SMTP id y8mr81369ljk.421.1597363634483;
        Thu, 13 Aug 2020 17:07:14 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 12/36] PM / devfreq: tegra20: Use MC timings for building OPP table
Date:   Fri, 14 Aug 2020 03:05:57 +0300
Message-Id: <20200814000621.8415-13-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The clk_round_rate() won't be usable for building OPP table once
interconnect support will be added to the EMC driver because that CLK API
function limits the rounded rate based on the clk rate that is imposed by
active clk-users, and thus, the rounding won't work as expected if
interconnect will set the minimum EMC clock rate before devfreq driver is
loaded. The struct tegra_mc contains memory timings which could be used by
the devfreq driver for building up OPP table instead of rounding clock
rate, this patch implements this idea.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra20-devfreq.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
index 6469dc69c5e0..a985f24098f5 100644
--- a/drivers/devfreq/tegra20-devfreq.c
+++ b/drivers/devfreq/tegra20-devfreq.c
@@ -123,8 +123,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 {
 	struct tegra_devfreq *tegra;
 	struct tegra_mc *mc;
-	unsigned long max_rate;
-	unsigned long rate;
+	unsigned int i;
 	int err;
 
 	mc = tegra_get_memory_controller();
@@ -135,6 +134,11 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	if (!mc->num_timings) {
+		dev_info(&pdev->dev, "memory controller has no timings\n");
+		return -ENODEV;
+	}
+
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
 	if (!tegra)
 		return -ENOMEM;
@@ -151,12 +155,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	tegra->regs = mc->regs;
 
-	max_rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
-
-	for (rate = 0; rate <= max_rate; rate++) {
-		rate = clk_round_rate(tegra->emc_clock, rate);
-
-		err = dev_pm_opp_add(&pdev->dev, rate, 0);
+	for (i = 0; i < mc->num_timings; i++) {
+		err = dev_pm_opp_add(&pdev->dev, mc->timings[i].rate, 0);
 		if (err) {
 			dev_err(&pdev->dev, "failed to add opp: %d\n", err);
 			goto remove_opps;
-- 
2.27.0

