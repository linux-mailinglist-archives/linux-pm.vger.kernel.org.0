Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A145E221A02
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 04:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgGPC2y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 22:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGPC2b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 22:28:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6E9C061755;
        Wed, 15 Jul 2020 19:28:30 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so8096058wmg.1;
        Wed, 15 Jul 2020 19:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jsnFEaPOATe0rU74z4wmdx5Snp9SyB/gn+FbmEyk+5U=;
        b=BJCEiCgjoizQk0MuwZnjC++IpUrRbuW2pdRAaA62MIRcfaclEvyOXR/tD9ejUx8GMS
         mF90akZODSnNpjz6Uv4bahWA3cNTRYJUF2aXKAsCNiWNRsllo/6WH5fXcXS2s0t4XrHX
         lzcNf/9rpffayJ8OKYukNpZHVJO/m1A8HBwouPwdkhMZlHWunkMej7lXrK1gJc8o+H5d
         URbglFqcIogn5Oj3ZKJdVO5cTaZMaQk5jGAP1KB+VVWMaCatsUOq+tyaQ99Bg78Jju41
         wMxTLmnysHeG8DpPr9a0EHs1ezob1S+rOScTOxEALW9jw4oZfjilpq28K6UoEwCafva6
         JGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jsnFEaPOATe0rU74z4wmdx5Snp9SyB/gn+FbmEyk+5U=;
        b=NPAHDXY218eCwiUwzLshGJ4bp0tvHWjhcEvTCnFHTfuIRYNH8zHgi791DgJK3Hdjcz
         QNsKPu5czYgTXyNGsyJoEild7alFUzrQujAMmcxdbVDhuB0VKmwvSeH0Dbb+9U6PzcSc
         sqL3Uvm4041NRd3PyNOXSyLOXQonazQkWCXceYqD92+OgAWcsBehtkFSIdOvHLp9tHoB
         S4G2auskHd+HodUciACZcGrGnMQkdhe2taZhKPqW5JD91uShjHL9pgvxmLGtsb0XYxN1
         mVzAs+Uj53U/Sega/4Xe2B/Lh0GeImZGmFUYYHyC+/S8o7oU3hKCjtt8bA2fNZRFfETd
         Q/vw==
X-Gm-Message-State: AOAM530tTvTNceZdCm3jwrvgEeakYMLel1J2T20JU8JA0ySjpp0GZ71F
        GSBvWuDms3TQxwLYVcK1EHw=
X-Google-Smtp-Source: ABdhPJzCJ+vAQ/QeXIWzlb11w/o7pwBiMD7vR0FI/Iqs4NB5SM67+6BkbQd4gbRfAjNy7ipBfFR+ig==
X-Received: by 2002:a05:600c:2050:: with SMTP id p16mr2179009wmg.44.1594866508949;
        Wed, 15 Jul 2020 19:28:28 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-7-31-173.retail.telecomitalia.it. [87.7.31.173])
        by smtp.googlemail.com with ESMTPSA id u1sm7477611wrb.78.2020.07.15.19.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 19:28:28 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 3/7] drivers: thermal: tsens: add ipq8064 support
Date:   Thu, 16 Jul 2020 04:28:12 +0200
Message-Id: <20200716022817.30439-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716022817.30439-1-ansuelsmth@gmail.com>
References: <20200716022817.30439-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ipq8064 SoCs based use the same 8960 driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 39c4462e38f6..23f63dfbf13d 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -906,6 +906,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
+	}, {
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8960,
 	}, {
 		.compatible = "qcom,tsens-v1",
 		.data = &data_tsens_v1,
-- 
2.27.0

