Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C82338CF3E
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 22:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhEUUq3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 May 2021 16:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhEUUq3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 May 2021 16:46:29 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A83C0613ED
        for <linux-pm@vger.kernel.org>; Fri, 21 May 2021 13:45:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 69so11610596plc.5
        for <linux-pm@vger.kernel.org>; Fri, 21 May 2021 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igzFIccuiFriowe2kh28IcK5gIIDPMZQzahZDG5tSm0=;
        b=LETZk6m+q6FDNRsX65WTrupTI3FZ/EaQiq9mZPlX5+fjhzMiZjoJ72TwI78eYo6ABF
         v0xtJzjuccrXPBC9B64tc2CjjeLeRuLBm+FxFhV8kp92IknNf3COW34W3dCYecvXC4nB
         PXWpx9tg4j5vGdXj8AyC9eRqGeMHTCOLfYumo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igzFIccuiFriowe2kh28IcK5gIIDPMZQzahZDG5tSm0=;
        b=X/QSv5SeGJ4OO0tgac2ZfiE6uYm05e123/Jh73PyQIz533/1mlJDkciZcXashPRyPe
         Sw6pvRO9Yt4iVtgu0w1mqbMHLzgWKuLtAeBHovYVGwjAGKlpUo3lA3deJ0z4AJ0X/pBT
         oywCsPwW1uw5yYNERwqwsJ4X7ay3M/i36myH2DEoq2ekWQFn8vPqf8qupD4qaOHaQunt
         lmbaWQjbrMDfQFLsI10mJ6WkX+4w7PVvMjyb//AjDVJ3gFJYeumQxVJk4tBAMeKYxvXI
         Zj6sH0xjneNLfYqLX2qcMDKEL/nEyB8rLQ+8i+UQUM/FuF6LLXsAuO2kdbzSQuMsDJp4
         wyJw==
X-Gm-Message-State: AOAM530X8a0DN0SXSHojLhyRQBFsoWCD/tP6L68DsdMzD1O9ZpCOOMPA
        zznZzs+ouiVV0kpSaXRW6Xh5Pg==
X-Google-Smtp-Source: ABdhPJzEXBe5JUzWzzVD3OosgBi3Fy0tnzMkpWBbZNYCt+43ceoVpbNONzCVkf3CCwPmNOWfgN/XXA==
X-Received: by 2002:a17:902:db09:b029:f4:8d37:8d12 with SMTP id m9-20020a170902db09b02900f48d378d12mr14481362plx.52.1621629905561;
        Fri, 21 May 2021 13:45:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:10e9:a6cd:727f:561e])
        by smtp.gmail.com with ESMTPSA id l62sm5055928pfl.88.2021.05.21.13.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:45:05 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Niklas Cassel <nks@flawful.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2] PM: AVS: qcom-cpr: Use nvmem_cell_read_variable_le_u32()
Date:   Fri, 21 May 2021 13:44:53 -0700
Message-Id: <20210521134437.v2.1.Id1c70158722750aec0673d60c12e46a9c66bbfed@changeid>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Let's delete the private function cpr_read_efuse() since it does the
basically the same thing as the new API call
nvmem_cell_read_variable_le_u32().

Differences between the new API call and the old private function:
* less error printing (I assume this is OK).
* will give an error if the value doesn't fit in 32-bits (the old code
  would have truncated silently).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I haven't done any more than compile-test this. Mostly I'm just
writing this patch because it helped provide inspiration for the
general API function.

Changes in v2:
- Resending v1 as a singleton patch; dependency is merged in mainline.

 drivers/soc/qcom/cpr.c | 43 +++++-------------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/drivers/soc/qcom/cpr.c b/drivers/soc/qcom/cpr.c
index b24cc77d1889..4ce8e816154f 100644
--- a/drivers/soc/qcom/cpr.c
+++ b/drivers/soc/qcom/cpr.c
@@ -801,38 +801,6 @@ static int cpr_set_performance_state(struct generic_pm_domain *domain,
 	return ret;
 }
 
-static int cpr_read_efuse(struct device *dev, const char *cname, u32 *data)
-{
-	struct nvmem_cell *cell;
-	ssize_t len;
-	char *ret;
-	int i;
-
-	*data = 0;
-
-	cell = nvmem_cell_get(dev, cname);
-	if (IS_ERR(cell)) {
-		if (PTR_ERR(cell) != -EPROBE_DEFER)
-			dev_err(dev, "undefined cell %s\n", cname);
-		return PTR_ERR(cell);
-	}
-
-	ret = nvmem_cell_read(cell, &len);
-	nvmem_cell_put(cell);
-	if (IS_ERR(ret)) {
-		dev_err(dev, "can't read cell %s\n", cname);
-		return PTR_ERR(ret);
-	}
-
-	for (i = 0; i < len; i++)
-		*data |= ret[i] << (8 * i);
-
-	kfree(ret);
-	dev_dbg(dev, "efuse read(%s) = %x, bytes %zd\n", cname, *data, len);
-
-	return 0;
-}
-
 static int
 cpr_populate_ring_osc_idx(struct cpr_drv *drv)
 {
@@ -843,8 +811,7 @@ cpr_populate_ring_osc_idx(struct cpr_drv *drv)
 	int ret;
 
 	for (; fuse < end; fuse++, fuses++) {
-		ret = cpr_read_efuse(drv->dev, fuses->ring_osc,
-				     &data);
+		ret = nvmem_cell_read_variable_le_u32(drv->dev, fuses->ring_osc, &data);
 		if (ret)
 			return ret;
 		fuse->ring_osc_idx = data;
@@ -863,7 +830,7 @@ static int cpr_read_fuse_uV(const struct cpr_desc *desc,
 	u32 bits = 0;
 	int ret;
 
-	ret = cpr_read_efuse(drv->dev, init_v_efuse, &bits);
+	ret = nvmem_cell_read_variable_le_u32(drv->dev, init_v_efuse, &bits);
 	if (ret)
 		return ret;
 
@@ -932,7 +899,7 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 		}
 
 		/* Populate target quotient by scaling */
-		ret = cpr_read_efuse(drv->dev, fuses->quotient, &fuse->quot);
+		ret = nvmem_cell_read_variable_le_u32(drv->dev, fuses->quotient, &fuse->quot);
 		if (ret)
 			return ret;
 
@@ -1001,7 +968,7 @@ static int cpr_calculate_scaling(const char *quot_offset,
 	prev_fuse = fuse - 1;
 
 	if (quot_offset) {
-		ret = cpr_read_efuse(drv->dev, quot_offset, &quot_diff);
+		ret = nvmem_cell_read_variable_le_u32(drv->dev, quot_offset, &quot_diff);
 		if (ret)
 			return ret;
 
@@ -1701,7 +1668,7 @@ static int cpr_probe(struct platform_device *pdev)
 	 * initialized after attaching to the power domain,
 	 * since it depends on the CPU's OPP table.
 	 */
-	ret = cpr_read_efuse(dev, "cpr_fuse_revision", &cpr_rev);
+	ret = nvmem_cell_read_variable_le_u32(dev, "cpr_fuse_revision", &cpr_rev);
 	if (ret)
 		return ret;
 
-- 
2.31.1.818.g46aad6cb9e-goog

