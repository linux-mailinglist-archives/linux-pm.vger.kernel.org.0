Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B6532F73D
	for <lists+linux-pm@lfdr.de>; Sat,  6 Mar 2021 01:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCFA0u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 19:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCFA0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 19:26:45 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709C0C06175F
        for <linux-pm@vger.kernel.org>; Fri,  5 Mar 2021 16:26:45 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id t26so2443971pgv.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Mar 2021 16:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NS5Lxo9BxfuP6QZPK99yTL5xf7oG57S72PW7587sqTc=;
        b=OF6iKVvJm7nV+Gc6VzMBqvRN+neWOeuyd6iZR7wU09QDxn7EQnsj7+mPPzIhA1gFfz
         qXUN0tIMY34ELyjVsu3NaI/MfTZe+jt4+rQDRc7hFeve/QQCJvijj4rI3wZggNfn7cAN
         mUSGSDyOoEsAOQOwwLa3CtWnXCMsWKzKOJAaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NS5Lxo9BxfuP6QZPK99yTL5xf7oG57S72PW7587sqTc=;
        b=C+SiwUXh9y90Q1FG6O7x0+/m2OKSbxPTKvf6FWMKattmT8mZv1XmAZHMl+PHj14666
         cm9rfM+6azLN9/ZiPOVHavXcqts5xdvOujDY8B286DWwRYzR14AWX9Ap50qb1LGSvgcI
         rDNgn166msvZR8VYWTrL2ZMVoUFTNUvtzYQdPDw+J+7RcOrvvmM4zkDcA+jzLGA7nOEz
         G5iDefMMjokFImUO79iBGr7GKh6h9QCFndiWBilqC2tgL31WAesPPIHxGR3n7YRMOeKS
         GzPlGIaGpWtfkGf2g5NjqCN/jTqwijPrd3pw/t3NpLsFvlhXsNRvk/7URbWQKxoPvpRe
         5/EQ==
X-Gm-Message-State: AOAM532EC+zzZH8lgUqXalXwSQdnuJGeZDCeSVqguaCZLjQ7Zbm0+G9D
        m9JVv43ZloWGX2uGiPZNT6IghQ==
X-Google-Smtp-Source: ABdhPJwYNoTKdPo4SqwlHiwi1KRPqS0VHMbOkjyM8E0HzhGRyeLI+96z4eeI1IbBhhONP/H+U667ow==
X-Received: by 2002:a63:5c1e:: with SMTP id q30mr10501289pgb.259.1614990404968;
        Fri, 05 Mar 2021 16:26:44 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:48f0:8f48:7388:d921])
        by smtp.gmail.com with ESMTPSA id 192sm3608905pfa.122.2021.03.05.16.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 16:26:44 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Niklas Cassel <nks@flawful.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 3/3] PM: AVS: qcom-cpr: Use nvmem_cell_read_variable_le_u32()
Date:   Fri,  5 Mar 2021 16:26:22 -0800
Message-Id: <20210305162546.3.Id1c70158722750aec0673d60c12e46a9c66bbfed@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210305162546.1.I323dad4343256b48af2be160b84b1e87985cc9be@changeid>
References: <20210305162546.1.I323dad4343256b48af2be160b84b1e87985cc9be@changeid>
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
2.30.1.766.gb4fecdf3b7-goog

