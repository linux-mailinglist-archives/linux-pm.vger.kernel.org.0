Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE44B27E110
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 08:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgI3G0u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 02:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgI3G0u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 02:26:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324F6C0613D0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2020 23:26:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d9so473255pfd.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2020 23:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FIfqJN128jv1TVvEIDhwuZ9dOaQzoSaq54aIOEr37ac=;
        b=imY2j9krbNAVtueJwctK5JaGh3WgaZFjMh/3hQZRpqnbkpldd4P0Y0Fg90Mhoiaa7M
         F26UpdlspIySdkagoYGb9dq+C+m7h25wJnpuv/njrXoOuOlXbBtKELOLYvneq2LqAL9V
         4eRdd96ayGnqIuBzoCV97OaixcjlTSYLz9/GLWq6r8cYaPrBH05ZZPGSqUyd8rOVSxQP
         5yPI3JREmj5OEC1mmJQAsW/sjCfcsMv9EymM62mA25HYdzPBNayMsU/fVJ/Z8qiHSd1e
         evEyHk61lUNnoWQNa76FWWgBIFhlsRNMexVk+tznqyrwZKthb1Uq7ic0ZSAqwDrQzMib
         20Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FIfqJN128jv1TVvEIDhwuZ9dOaQzoSaq54aIOEr37ac=;
        b=DYYDjJPSGkIFkQ8+g+S+0/jfFiifEBrN8pTF+VUu25QogBGwvPlZ0QIlqAg15R7v60
         X9D9Up4fXUZuktmREIJEltNhtyD6FWNoWosWWO4zhz2KTzVzLt8Ot/5pZ1hJ6ZbsnfxF
         4illzNLuuIGxGiq7wpRvxFM5rDEMVZHHxJGNoFvJ7bhp4TW3KNU8rr7rdlohuj1dm+D4
         6/6YIrkIBbG5hZggbYK8PUGczlxaulcbiV0ibRUxEc2KjMRgieiLaeAb4xGmn19eeqYD
         itPN74F+UJOvmZfmZi7vqriZsmeHLdKqJSMPii+HvM5SI3tI717wKC8jLrSTrZ1L2gKx
         oobw==
X-Gm-Message-State: AOAM5302QhEBv7a71uuraZCv2mSjgQlsCXci2oUqCBJIl4klqwuTBsaT
        AoSZa0WC3zl9K4eVNGTClQm9Fg==
X-Google-Smtp-Source: ABdhPJxGovZmVE52kK6nkOGR96q20dMFW/5qFoaNbI5GyD3FT38FavIjVQEf+pH8smGo7YDChWJ1Yg==
X-Received: by 2002:a65:5cc2:: with SMTP id b2mr1023047pgt.124.1601447209547;
        Tue, 29 Sep 2020 23:26:49 -0700 (PDT)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id t5sm772462pgs.74.2020.09.29.23.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 23:26:48 -0700 (PDT)
From:   Jun Nie <jun.nie@linaro.org>
To:     nks@flawful.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     shawn.guo@linaro.org, Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 3/3] power: avs: qcom-cpr: add support to msm8939
Date:   Wed, 30 Sep 2020 14:26:03 +0800
Message-Id: <20200930062603.29009-4-jun.nie@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930062603.29009-1-jun.nie@linaro.org>
References: <20200930062603.29009-1-jun.nie@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory power supply voltage should be higher than CPU voltage on
msm8939, so add the memory voltage control in cpr.
quot_offset_scale is missing on msm8939, no scaling is expected
in this case and do not try to read related fuse.
Corner adjustments support is added.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/power/avs/qcom-cpr.c | 366 ++++++++++++++++++++++++++++++++---
 1 file changed, 343 insertions(+), 23 deletions(-)

diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
index bd7c3e48b386..1d9989636fa5 100644
--- a/drivers/power/avs/qcom-cpr.c
+++ b/drivers/power/avs/qcom-cpr.c
@@ -122,7 +122,7 @@
 
 #define CPR_FUSE_MIN_QUOT_DIFF		50
 
-#define FUSE_REVISION_UNKNOWN		(-1)
+#define FUSE_MATCH_ANY			(-1)
 
 enum voltage_change_dir {
 	NO_CHANGE,
@@ -150,6 +150,7 @@ struct fuse_corner_data {
 	/* fuse quot_offset */
 	int quot_offset_scale;
 	int quot_offset_adjust;
+	u32 min_diff_quot;
 };
 
 struct cpr_fuses {
@@ -165,7 +166,6 @@ struct corner_data {
 
 struct cpr_desc {
 	unsigned int num_fuse_corners;
-	int min_diff_quot;
 	int *step_quot;
 
 	unsigned int		timer_delay_us;
@@ -182,6 +182,7 @@ struct cpr_desc {
 	struct cpr_fuses cpr_fuses;
 	bool reduce_to_fuse_uV;
 	bool reduce_to_corner_uV;
+	unsigned int *mx_level; /* memory voltage level */
 };
 
 struct acc_desc {
@@ -207,6 +208,7 @@ struct fuse_corner {
 	const struct reg_sequence *accs;
 	int num_accs;
 	unsigned long max_freq;
+	unsigned int mx_level;
 	u8 ring_osc_idx;
 };
 
@@ -247,6 +249,8 @@ struct cpr_drv {
 	const struct cpr_fuse *cpr_fuses;
 
 	struct dentry *debugfs;
+	u16			cpr_fuse_map_count;
+	u16			cpr_fuse_map_match;
 };
 
 static bool cpr_is_allowed(struct cpr_drv *drv)
@@ -411,6 +415,10 @@ static int cpr_pre_voltage(struct cpr_drv *drv,
 {
 	struct fuse_corner *prev_fuse_corner = drv->corner->fuse_corner;
 
+	if (drv->desc->mx_level && dir == UP)
+		dev_pm_genpd_set_performance_state(drv->dev,
+						   fuse_corner->mx_level);
+
 	if (drv->tcsr && dir == DOWN)
 		cpr_set_acc(drv->tcsr, prev_fuse_corner, fuse_corner);
 
@@ -426,6 +434,10 @@ static int cpr_post_voltage(struct cpr_drv *drv,
 	if (drv->tcsr && dir == UP)
 		cpr_set_acc(drv->tcsr, prev_fuse_corner, fuse_corner);
 
+	if (drv->desc->mx_level && dir == DOWN)
+		dev_pm_genpd_set_performance_state(drv->dev,
+						   fuse_corner->mx_level);
+
 	return 0;
 }
 
@@ -439,7 +451,7 @@ static int cpr_scale_voltage(struct cpr_drv *drv, struct corner *corner,
 	if (ret)
 		return ret;
 
-	ret = regulator_set_voltage(drv->vdd_apc, new_uV, new_uV);
+	ret = regulator_set_voltage(drv->vdd_apc, new_uV, fuse_corner->max_uV);
 	if (ret) {
 		dev_err_ratelimited(drv->dev, "failed to set apc voltage %d\n",
 				    new_uV);
@@ -884,6 +896,48 @@ static int cpr_read_fuse_uV(const struct cpr_desc *desc,
 	return DIV_ROUND_UP(uV, step_volt) * step_volt;
 }
 
+static int cpr_corner_get_adjust(struct cpr_drv *drv, char *pname,
+				 unsigned int num_corners, u16 array_num,
+				 u32 **adjust, u32 *pp_valid)
+{
+	struct property *pp;
+	int i, len, index, size;
+	u32 *ptr;
+
+	*pp_valid = 0;
+	pp = of_find_property(drv->dev->of_node, pname, &len);
+	if (!pp)
+		return 0;
+
+	size = num_corners * array_num * sizeof(u32);
+	if (len != size) {
+		dev_err(drv->dev, "prop %s length %d is invalid, %d expected\n",
+			pname, len, size);
+		return -EINVAL;
+	}
+
+	/* use 1st vector if there is only one property array */
+	if (array_num == 1)
+		index = 0;
+	else
+		index = drv->cpr_fuse_map_match * num_corners;
+
+	*adjust = kzalloc(sizeof(u32) * num_corners,
+			GFP_KERNEL);
+	if (!*adjust)
+		return -ENOMEM;
+
+	ptr = *adjust;
+	for (i = 0; i < num_corners; i++, ptr++) {
+		of_property_read_u32_index(drv->dev->of_node,
+				pname, index + i, ptr);
+		dev_dbg(drv->dev, "use %s[%d]: %d\n", pname, i, *ptr);
+	}
+	*pp_valid = 1;
+
+	return 0;
+}
+
 static int cpr_fuse_corner_init(struct cpr_drv *drv)
 {
 	const struct cpr_desc *desc = drv->desc;
@@ -893,16 +947,35 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 	unsigned int step_volt;
 	struct fuse_corner_data *fdata;
 	struct fuse_corner *fuse, *end;
-	int uV;
+	int uV, *mx_level;
 	const struct reg_sequence *accs;
 	int ret;
+	char *quot_pp_name = "quotient-adjustment";
+	char *int_volt_pp_name = "init-voltage-adjustment";
+	u32 *quot_adjust, quot_pp_valid;
+	u32 *init_volt_adjust, volt_pp_valid;
 
 	accs = acc_desc->settings;
+	mx_level = desc->mx_level;
 
 	step_volt = regulator_get_linear_step(drv->vdd_apc);
 	if (!step_volt)
 		return -EINVAL;
 
+	ret = cpr_corner_get_adjust(drv, quot_pp_name,
+				    desc->num_fuse_corners,
+				    drv->cpr_fuse_map_count,
+				    &quot_adjust, &quot_pp_valid);
+	if (ret)
+		return ret;
+
+	ret = cpr_corner_get_adjust(drv, int_volt_pp_name,
+				    desc->num_fuse_corners,
+				    drv->cpr_fuse_map_count,
+				    &init_volt_adjust, &volt_pp_valid);
+	if (ret)
+		goto free_quot_pp;
+
 	/* Populate fuse_corner members */
 	fuse = drv->fuse_corners;
 	end = &fuse[desc->num_fuse_corners - 1];
@@ -920,9 +993,13 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 		/* Populate uV */
 		uV = cpr_read_fuse_uV(desc, fdata, fuses->init_voltage,
 				      step_volt, drv);
-		if (uV < 0)
-			return uV;
+		if (uV < 0) {
+			ret = uV;
+			goto free_quot_pp;
+		}
 
+		if (volt_pp_valid)
+			uV += init_volt_adjust[i];
 		fuse->min_uV = fdata->min_uV;
 		fuse->max_uV = fdata->max_uV;
 		fuse->uV = clamp(uV, fuse->min_uV, fuse->max_uV);
@@ -940,17 +1017,24 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 		/* Populate target quotient by scaling */
 		ret = cpr_read_efuse(drv->dev, fuses->quotient, &fuse->quot);
 		if (ret)
-			return ret;
+			goto free_volt_adjust;
 
 		fuse->quot *= fdata->quot_scale;
 		fuse->quot += fdata->quot_offset;
-		fuse->quot += fdata->quot_adjust;
+		if (quot_pp_valid)
+			fuse->quot += quot_adjust[i];
+		else
+			fuse->quot += fdata->quot_adjust;
 		fuse->step_quot = desc->step_quot[fuse->ring_osc_idx];
 
 		/* Populate acc settings */
 		fuse->accs = accs;
 		fuse->num_accs = acc_desc->num_regs_per_fuse;
 		accs += acc_desc->num_regs_per_fuse;
+
+		/* Populate memory power supply settings */
+		if (mx_level)
+			fuse->mx_level = mx_level[i];
 	}
 
 	/*
@@ -970,7 +1054,8 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 			dev_err(drv->dev,
 				"min uV: %d (fuse corner: %d) not supported by regulator\n",
 				fuse->min_uV, i);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto free_volt_adjust;
 		}
 
 		ret = regulator_is_supported_voltage(drv->vdd_apc,
@@ -980,8 +1065,10 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 			dev_err(drv->dev,
 				"max uV: %d (fuse corner: %d) not supported by regulator\n",
 				fuse->max_uV, i);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto free_quot_pp;
 		}
+		ret = 0;
 
 		dev_dbg(drv->dev,
 			"fuse corner %d: [%d %d %d] RO%hhu quot %d squot %d\n",
@@ -989,7 +1076,13 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 			fuse->ring_osc_idx, fuse->quot, fuse->step_quot);
 	}
 
-	return 0;
+free_volt_adjust:
+	if (volt_pp_valid)
+		kfree(init_volt_adjust);
+free_quot_pp:
+	if (quot_pp_valid)
+		kfree(quot_adjust);
+	return ret;
 }
 
 static int cpr_calculate_scaling(const char *quot_offset,
@@ -1006,7 +1099,7 @@ static int cpr_calculate_scaling(const char *quot_offset,
 	fuse = corner->fuse_corner;
 	prev_fuse = fuse - 1;
 
-	if (quot_offset) {
+	if (quot_offset && fdata->quot_offset_scale) {
 		ret = cpr_read_efuse(drv->dev, quot_offset, &quot_diff);
 		if (ret)
 			return ret;
@@ -1015,6 +1108,7 @@ static int cpr_calculate_scaling(const char *quot_offset,
 		quot_diff += fdata->quot_offset_adjust;
 	} else {
 		quot_diff = fuse->quot - prev_fuse->quot;
+		quot_diff = max(quot_diff, fdata->min_diff_quot);
 	}
 
 	freq_diff = fuse->max_freq - prev_fuse->max_freq;
@@ -1031,6 +1125,9 @@ static int cpr_interpolate(const struct corner *corner, int step_volt,
 	u64 temp, temp_limit;
 	const struct fuse_corner *fuse, *prev_fuse;
 
+	if (!fdata->max_volt_scale)
+		return corner->uV;
+
 	fuse = corner->fuse_corner;
 	prev_fuse = fuse - 1;
 
@@ -1085,6 +1182,7 @@ static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 	struct device_node *desc_np;
 	struct device_node *child_np = NULL;
 	struct device_node *child_req_np = NULL;
+	int ret;
 
 	desc_np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
 	if (!desc_np)
@@ -1094,6 +1192,14 @@ static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 	if (!ref_np)
 		goto out_ref;
 
+	/* freq in cpr_opp is only used to calculate virtual corner quot, may
+	 * not identical with freq in cpu_opp.
+	 */
+	ret = of_property_read_u64(ref_np, "opp-hz", &rate);
+	if (!ret)
+		goto hz_done;
+
+	/* Support dtb that does not fill freq to cpr_opp */
 	do {
 		of_node_put(child_req_np);
 		child_np = of_get_next_available_child(desc_np, child_np);
@@ -1105,6 +1211,7 @@ static unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 
 	of_node_put(child_req_np);
 	of_node_put(child_np);
+hz_done:
 	of_node_put(ref_np);
 out_ref:
 	of_node_put(desc_np);
@@ -1116,7 +1223,7 @@ static int cpr_corner_init(struct cpr_drv *drv)
 {
 	const struct cpr_desc *desc = drv->desc;
 	const struct cpr_fuse *fuses = drv->cpr_fuses;
-	int i, level, scaling = 0;
+	int ret, i, level, scaling = 0;
 	unsigned int fnum, fc;
 	const char *quot_offset;
 	struct fuse_corner *fuse, *prev_fuse;
@@ -1128,6 +1235,10 @@ static int cpr_corner_init(struct cpr_drv *drv)
 	unsigned long freq;
 	int step_volt = regulator_get_linear_step(drv->vdd_apc);
 	struct dev_pm_opp *opp;
+	u32 *vc_min_uV, vc_min_uV_valid;
+	u32 *vc_quot_adjust, vc_quot_pp_valid;
+	char *quot_pp_name = "virtual-corner-quotient-adjustment";
+	char *min_uV_pp_name = "voltage-floor-override";
 
 	if (!step_volt)
 		return -EINVAL;
@@ -1141,14 +1252,30 @@ static int cpr_corner_init(struct cpr_drv *drv)
 	if (!cdata)
 		return -ENOMEM;
 
+	ret = cpr_corner_get_adjust(drv, quot_pp_name,
+				    drv->num_corners, 1,
+				    &vc_quot_adjust, &vc_quot_pp_valid);
+	if (ret)
+		goto free_cdata;
+
+	ret = cpr_corner_get_adjust(drv, min_uV_pp_name,
+				    drv->num_corners, 1,
+				    &vc_min_uV, &vc_min_uV_valid);
+	if (ret)
+		goto free_vc_quot_pp;
+
 	/*
 	 * Store maximum frequency for each fuse corner based on the frequency
 	 * plan
 	 */
 	for (level = 1; level <= drv->num_corners; level++) {
 		opp = dev_pm_opp_find_level_exact(&drv->pd.dev, level);
-		if (IS_ERR(opp))
-			return -EINVAL;
+		if (IS_ERR(opp)) {
+			ret = -EINVAL;
+			dev_err(drv->dev, "Fail to find cpu opp for level %d\n",
+				level);
+			goto free_vc_min_uV_pp;
+		}
 		fc = cpr_get_fuse_corner(opp);
 		if (!fc) {
 			dev_pm_opp_put(opp);
@@ -1158,8 +1285,10 @@ static int cpr_corner_init(struct cpr_drv *drv)
 		freq = cpr_get_opp_hz_for_req(opp, drv->attached_cpu_dev);
 		if (!freq) {
 			dev_pm_opp_put(opp);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto free_vc_min_uV_pp;
 		}
+
 		cdata[level - 1].fuse_corner = fnum;
 		cdata[level - 1].freq = freq;
 
@@ -1227,8 +1356,10 @@ static int cpr_corner_init(struct cpr_drv *drv)
 		if (prev_fuse && cdata[i - 1].freq == prev_fuse->max_freq) {
 			scaling = cpr_calculate_scaling(quot_offset, drv,
 							fdata, corner);
-			if (scaling < 0)
-				return scaling;
+			if (scaling < 0) {
+				ret = scaling;
+				goto free_vc_min_uV_pp;
+			}
 
 			apply_scaling = true;
 		} else if (corner->freq == fuse->max_freq) {
@@ -1243,9 +1374,15 @@ static int cpr_corner_init(struct cpr_drv *drv)
 
 			corner->uV = cpr_interpolate(corner, step_volt, fdata);
 		}
+		if (vc_quot_pp_valid)
+			corner->quot_adjust -= vc_quot_adjust[i];
+
+		if (vc_min_uV_valid)
+			corner->min_uV = max(fuse->min_uV, (int)vc_min_uV[i]);
+		else
+			corner->min_uV = fuse->min_uV;
 
 		corner->max_uV = fuse->max_uV;
-		corner->min_uV = fuse->min_uV;
 		corner->uV = clamp(corner->uV, corner->min_uV, corner->max_uV);
 		corner->last_uV = corner->uV;
 
@@ -1260,7 +1397,15 @@ static int cpr_corner_init(struct cpr_drv *drv)
 			fuse->quot - corner->quot_adjust);
 	}
 
-	return 0;
+free_vc_min_uV_pp:
+	if (vc_min_uV_valid)
+		kfree(vc_min_uV);
+free_vc_quot_pp:
+	if (vc_quot_pp_valid)
+		kfree(vc_quot_adjust);
+free_cdata:
+	devm_kfree(drv->dev, cdata);
+	return ret;
 }
 
 static const struct cpr_fuse *cpr_get_fuses(struct cpr_drv *drv)
@@ -1294,6 +1439,9 @@ static const struct cpr_fuse *cpr_get_fuses(struct cpr_drv *drv)
 		if (!fuses[i].quotient)
 			return ERR_PTR(-ENOMEM);
 
+		if (!desc->cpr_fuses.fuse_corner_data[i].quot_offset_scale)
+			continue;
+
 		snprintf(tbuf, 32, "cpr_quotient_offset%d", i + 1);
 		fuses[i].quotient_offset = devm_kstrdup(drv->dev, tbuf,
 							GFP_KERNEL);
@@ -1385,7 +1533,6 @@ static int cpr_find_initial_corner(struct cpr_drv *drv)
 
 static const struct cpr_desc qcs404_cpr_desc = {
 	.num_fuse_corners = 3,
-	.min_diff_quot = CPR_FUSE_MIN_QUOT_DIFF,
 	.step_quot = (int []){ 25, 25, 25, },
 	.timer_delay_us = 5000,
 	.timer_cons_up = 0,
@@ -1396,6 +1543,7 @@ static const struct cpr_desc qcs404_cpr_desc = {
 	.gcnt_us = 1,
 	.vdd_apc_step_up_limit = 1,
 	.vdd_apc_step_down_limit = 1,
+	.mx_level = NULL,
 	.cpr_fuses = {
 		.init_voltage_step = 8000,
 		.init_voltage_width = 6,
@@ -1412,6 +1560,7 @@ static const struct cpr_desc qcs404_cpr_desc = {
 				.quot_adjust = 0,
 				.quot_offset_scale = 5,
 				.quot_offset_adjust = 0,
+				.min_diff_quot = CPR_FUSE_MIN_QUOT_DIFF,
 			},
 			/* fuse corner 1 */
 			{
@@ -1425,6 +1574,7 @@ static const struct cpr_desc qcs404_cpr_desc = {
 				.quot_adjust = -20,
 				.quot_offset_scale = 5,
 				.quot_offset_adjust = 0,
+				.min_diff_quot = CPR_FUSE_MIN_QUOT_DIFF,
 			},
 			/* fuse corner 2 */
 			{
@@ -1438,6 +1588,7 @@ static const struct cpr_desc qcs404_cpr_desc = {
 				.quot_adjust = 0,
 				.quot_offset_scale = 5,
 				.quot_offset_adjust = 0,
+				.min_diff_quot = CPR_FUSE_MIN_QUOT_DIFF,
 			},
 		},
 	},
@@ -1464,6 +1615,86 @@ static const struct cpr_acc_desc qcs404_cpr_acc_desc = {
 	.acc_desc = &qcs404_acc_desc,
 };
 
+static const struct cpr_desc msm8939_cpr_desc = {
+	.num_fuse_corners = 3,
+	.step_quot = (int []){ 13, 13, 13, },
+	.timer_delay_us = 5000,
+	.timer_cons_up = 0,
+	.timer_cons_down = 2,
+	.up_threshold = 0,
+	.down_threshold = 8,
+	.idle_clocks = 15,
+	.gcnt_us = 1,
+	.vdd_apc_step_up_limit = 1,
+	.vdd_apc_step_down_limit = 1,
+	.mx_level = (unsigned int[]){3, 4, 6},
+	.cpr_fuses = {
+		.init_voltage_step = 10000,
+		.init_voltage_width = 6,
+		.fuse_corner_data = (struct fuse_corner_data[]){
+			/* fuse corner 0 */
+			{
+				.ref_uV = 1050000,
+				.max_uV = 1050000,
+				.min_uV = 1050000,
+				.max_volt_scale = 0,
+				.max_quot_scale = 0,
+				.quot_offset = 0,
+				.quot_scale = 1,
+				.quot_adjust = 0,
+				.quot_offset_scale = 0,
+				.quot_offset_adjust = 0,
+				.min_diff_quot = 0,
+			},
+			/* fuse corner 1 */
+			{
+				.ref_uV = 1150000,
+				.max_uV = 1150000,
+				.min_uV = 1050000,
+				.max_volt_scale = 0,
+				.max_quot_scale = 0,
+				.quot_offset = 0,
+				.quot_scale = 1,
+				.quot_adjust = -41,
+				.quot_offset_scale = 0,
+				.quot_offset_adjust = 0,
+				.min_diff_quot = 0,
+			},
+			/* fuse corner 2 */
+			{
+				.ref_uV = 1350000,
+				.max_uV = 1350000,
+				.min_uV = 1137500,
+				.max_volt_scale = 0,
+				.max_quot_scale = 900,
+				.quot_offset = 0,
+				.quot_scale = 1,
+				.quot_adjust = 0,
+				.quot_offset_scale = 0,
+				.quot_offset_adjust = 0,
+				.min_diff_quot = 40,
+			},
+		},
+	},
+};
+
+static const struct acc_desc msm8939_acc_desc = {
+	.settings = (struct reg_sequence[]){
+		{ 0xb130, 0},
+		{ 0xb124, 0},
+		{ 0xb130, 0},
+		{ 0xb124, 0},
+		{ 0xb130, 1},
+		{ 0xb124, 0x3000},
+	},
+	.num_regs_per_fuse = 2,
+};
+
+static const struct cpr_acc_desc msm8939_cpr_acc_desc = {
+	.cpr_desc = &msm8939_cpr_desc,
+	.acc_desc = &msm8939_acc_desc,
+};
+
 static unsigned int cpr_get_performance_state(struct generic_pm_domain *genpd,
 					      struct dev_pm_opp *opp)
 {
@@ -1540,6 +1771,7 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
 		goto unlock;
 	}
 	drv->num_corners = ret;
+	dev_dbg(drv->dev, "has %d virtual corners.\n", ret);
 
 	if (drv->num_corners < 2) {
 		dev_err(drv->dev, "need at least 2 OPPs to use CPR\n");
@@ -1651,6 +1883,94 @@ static void cpr_debugfs_init(struct cpr_drv *drv)
 			    drv, &cpr_debug_info_fops);
 }
 
+/* Match with map table to find out entry index that to retrieve adjustment
+ * array from properties lookup table.
+ */
+#define FUSE_MATCH_TUPLE_SIZE 3
+static int cpr_fuse_match_tuple(struct device *dev, struct cpr_drv *drv)
+{
+	u32 cpr_rev, cpr_rev_high;
+	u32 pvs_ver, pvs_ver_high;
+	struct property *pp;
+	int i, tuple_size = FUSE_MATCH_TUPLE_SIZE;
+	int ret, len;
+	u32 *tmp, speedbin;
+
+	drv->cpr_fuse_map_match = FUSE_MATCH_ANY;
+	ret = cpr_read_efuse(dev, "cpr_fuse_revision", &cpr_rev);
+	if (ret)
+		return ret;
+
+	ret = cpr_read_efuse(dev, "cpr_fuse_revision_high", &cpr_rev_high);
+	if (!ret)
+		cpr_rev |= cpr_rev_high << 1;
+
+	dev_info(dev, "fuse revision %d\n", cpr_rev);
+
+	pp = of_find_property(dev->of_node, "fuse-version-map", &len);
+	if (!pp)
+		return 0;
+
+	ret = cpr_read_efuse(dev, "cpr_pvs_version", &pvs_ver);
+	if (ret)
+		return ret;
+
+	ret = cpr_read_efuse(dev, "cpr_pvs_version_high", &pvs_ver_high);
+	if (!ret)
+		pvs_ver |= pvs_ver_high << 1;
+
+	ret = cpr_read_efuse(dev, "cpr_speedbin", &speedbin);
+
+	dev_info(dev, "pvs_version %d, speed_bin %d\n", pvs_ver, speedbin);
+
+	drv->cpr_fuse_map_count = len / (sizeof(u32) * tuple_size);
+
+	if (len == 0 || len % (sizeof(u32) * tuple_size)) {
+		dev_err(dev, "fuse-version-map length=%d is invalid\n",
+			len);
+		return -EINVAL;
+	}
+
+	tmp = kzalloc(len, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(dev->of_node, "fuse-version-map",
+				tmp, drv->cpr_fuse_map_count * tuple_size);
+	if (ret) {
+		dev_err(dev, "could not read fuse-version-map, rc=%d\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * fuse-version-map tuple format:
+	 * <speed_bin, pvs_version, cpr_fuse_revision
+	 */
+	for (i = 0; i < drv->cpr_fuse_map_count; i++) {
+		if (tmp[i * tuple_size] != speedbin
+		    && tmp[i * tuple_size] != FUSE_MATCH_ANY)
+			continue;
+		if (tmp[i * tuple_size + 1] != pvs_ver
+		    && tmp[i * tuple_size + 1] != FUSE_MATCH_ANY)
+			continue;
+		if (tmp[i * tuple_size + 2] != cpr_rev
+		    && tmp[i * tuple_size + 2] != FUSE_MATCH_ANY)
+			continue;
+		drv->cpr_fuse_map_match = i;
+		break;
+	}
+	if (drv->cpr_fuse_map_match != FUSE_MATCH_ANY) {
+		dev_info(dev, "fuse map tuple match found: %d\n",
+			drv->cpr_fuse_map_match);
+	} else {
+		dev_warn(dev, "fuse map tuple match not found\n");
+		drv->cpr_fuse_map_match = 0;
+		drv->cpr_fuse_map_count = 1;
+	}
+	return 0;
+}
+
 static int cpr_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -1659,7 +1979,6 @@ static int cpr_probe(struct platform_device *pdev)
 	int irq, ret;
 	const struct cpr_acc_desc *data;
 	struct device_node *np;
-	u32 cpr_rev = FUSE_REVISION_UNKNOWN;
 
 	data = of_device_get_match_data(dev);
 	if (!data || !data->cpr_desc || !data->acc_desc)
@@ -1707,7 +2026,7 @@ static int cpr_probe(struct platform_device *pdev)
 	 * initialized after attaching to the power domain,
 	 * since it depends on the CPU's OPP table.
 	 */
-	ret = cpr_read_efuse(dev, "cpr_fuse_revision", &cpr_rev);
+	ret = cpr_fuse_match_tuple(dev, drv);
 	if (ret)
 		return ret;
 
@@ -1776,6 +2095,7 @@ static int cpr_remove(struct platform_device *pdev)
 
 static const struct of_device_id cpr_match_table[] = {
 	{ .compatible = "qcom,qcs404-cpr", .data = &qcs404_cpr_acc_desc },
+	{ .compatible = "qcom,msm8939-cpr", .data = &msm8939_cpr_acc_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, cpr_match_table);
-- 
2.17.1

