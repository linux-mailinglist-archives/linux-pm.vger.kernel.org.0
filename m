Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACB35E6990
	for <lists+linux-pm@lfdr.de>; Thu, 22 Sep 2022 19:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiIVRYH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Sep 2022 13:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiIVRX6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Sep 2022 13:23:58 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD51A101957;
        Thu, 22 Sep 2022 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1663867430;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=hzB5tPXtis0lkIp+WeRUcHMUH8bgPsn6Zt43bWhWAaE=;
    b=cVWaLrKk4h4B1X2B/gEhGqQvJWCeyAAQsd20fbsoI/xUiJ5Ju6op/tY/2NLJu0S2U+
    6Mx4LzRjtIOhJtCExIohmSbjPC3e5Z6uTo+pXyWhp+dP5i21ZjW0cqWIIp95qTKk1ty2
    IP7hxjtY6M6Pxk0i2oD9X4+NePNP9aHLhceszg+Ud19FtludGVSqbrexEyXr5S3GGphj
    caOA4z13727zrXJyWiT0Kecw4STtOLbj04xLmmTq8CIxjRW7eF4FPIh06hYkoMW4rpmA
    4xhF+km5pNePBNkOOsCAChiHwUUVWSgoFJtU1DcXI2NwAI3cQUH82gTLac55zunqV8Hz
    e9sQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrKY7lg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.1.1 AUTH)
    with ESMTPSA id w49479y8MHNnEa5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 22 Sep 2022 19:23:49 +0200 (CEST)
Date:   Thu, 22 Sep 2022 19:23:43 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] thermal/drivers/tsens: specify nvmem cells in
 DT rather than parsing them manually
Message-ID: <YyyaH1ZXF9IvLpwd@gerhold.net>
References: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On Sat, Sep 10, 2022 at 03:46:51PM +0300, Dmitry Baryshkov wrote:
> Historically the tsens driver fetches the calibration data as a blob and
> then parses the blob on its own. This results in semi-duplicated code
> spreading over the platform-specific functions.
> 
> This patch series changes tsens calibration code to use pre-parsed nvmem
> cells rather than parsing the blob in the driver. For backwards
> compatibility the old code is left in place for msm8916 and qcs404, two
> platforms which have in-tree DT files. For msm8974 the original function
> is left intact, since it differs significantly (and I can not test the
> code on msm8974). For all other affected platforms the old parsing code
> has been dropped as a part of this RFC.
> 
> The code was tested on msm8916 and qcs404 only, thus it is being sent as
> an RFC.
> 

Thanks a lot for working on this!

After thinking about this for a while I wonder if we can go even a step
further: Can we drop SoC-specific code entirely for 8939 and 9607 and
match the generic compatible (qcom,tsens-v0_1)? This would allow most
v0.1 plaforms to use generic code like for qcom,tsens-v2.

AFAICT with your changes only the following remains SoC-specific:

  - hw_ids (actually only needed for 8939 since 9607 has standard IDs)

While two other things are already handled:

  - num_sensors (the driver supports "#qcom,sensors" in DT already)
  - tsens_calibrate_nvmem() shift (AFAICT in downstream msm-tsens.c
    everything except 8916 uses shift = 2. 8916 needs special handling
    anyway for the backwards compatibility)

Having the generic compatible would allow me to add MSM8909 without any
code changes at all (just DT schema addition).

For 8939 we could read the hw_ids from the DT with something like:

	qcom,sensors = <0 1 2 3 5 6 7 8 9 10>;

And actually there are two revisions of 8939, the older one has one
sensor less (msm-3.10: msm8939-common.dtsi vs msm8939-v3.0.dtsi).
This could also be easily handled from the DT without any code changes:

	qcom,sensors = <0 1 2 3 5 6 7 8 9>;

The diff could be something like the following (I did not test it yet).

What do you think?

Thanks,
Stephan

 drivers/thermal/qcom/tsens-v0_1.c | 32 +++++---------------------------
 drivers/thermal/qcom/tsens.c      | 27 ++++++++++++++++++---------
 drivers/thermal/qcom/tsens.h      |  2 +-
 3 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index c3613b7ccc19..8bfa85b31146 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -194,11 +194,6 @@ static int calibrate_8916(struct tsens_priv *priv)
 	return 0;
 }
 
-static int calibrate_8939(struct tsens_priv *priv)
-{
-	return tsens_calibrate_nvmem(priv, 2);
-}
-
 static int calibrate_8974(struct tsens_priv *priv)
 {
 	int base1 = 0, base2 = 0, i;
@@ -335,7 +330,7 @@ static int calibrate_8974(struct tsens_priv *priv)
 	return 0;
 }
 
-static int calibrate_9607(struct tsens_priv *priv)
+static int calibrate_dt(struct tsens_priv *priv)
 {
 	return tsens_calibrate_nvmem(priv, 2);
 }
@@ -401,21 +396,6 @@ struct tsens_plat_data data_8916 = {
 	.fields	= tsens_v0_1_regfields,
 };
 
-static const struct tsens_ops ops_8939 = {
-	.init		= init_common,
-	.calibrate	= calibrate_8939,
-	.get_temp	= get_temp_common,
-};
-
-struct tsens_plat_data data_8939 = {
-	.num_sensors	= 10,
-	.ops		= &ops_8939,
-	.hw_ids		= (unsigned int []){ 0, 1, 2, 4, 5, 6, 7, 8, 9, 10 },
-
-	.feat		= &tsens_v0_1_feat,
-	.fields	= tsens_v0_1_regfields,
-};
-
 static const struct tsens_ops ops_8974 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8974,
@@ -429,16 +409,14 @@ struct tsens_plat_data data_8974 = {
 	.fields	= tsens_v0_1_regfields,
 };
 
-static const struct tsens_ops ops_9607 = {
+static const struct tsens_ops ops_generic_v0_1 = {
 	.init		= init_common,
-	.calibrate	= calibrate_9607,
+	.calibrate	= calibrate_dt,
 	.get_temp	= get_temp_common,
 };
 
-struct tsens_plat_data data_9607 = {
-	.num_sensors	= 5,
-	.ops		= &ops_9607,
-	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 4 },
+struct tsens_plat_data data_tsens_v0_1 = {
+	.ops		= &ops_generic_v0_1
 	.feat		= &tsens_v0_1_feat,
 	.fields	= tsens_v0_1_regfields,
 };
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index e69134a6419a..c4772962fb94 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1021,15 +1021,9 @@ static const struct of_device_id tsens_table[] = {
 	{
 		.compatible = "qcom,ipq8064-tsens",
 		.data = &data_8960,
-	}, {
-		.compatible = "qcom,mdm9607-tsens",
-		.data = &data_9607,
 	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
-	}, {
-		.compatible = "qcom,msm8939-tsens",
-		.data = &data_8939,
 	}, {
 		.compatible = "qcom,msm8960-tsens",
 		.data = &data_8960,
@@ -1042,6 +1036,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
+	}, {
+		.compatible = "qcom,tsens-v0_1",
+		.data = &data_tsens_v0_1,
 	}, {
 		.compatible = "qcom,tsens-v1",
 		.data = &data_tsens_v1,
@@ -1152,6 +1149,8 @@ static int tsens_probe(struct platform_device *pdev)
 	struct tsens_priv *priv;
 	const struct tsens_plat_data *data;
 	const struct of_device_id *id;
+	unsigned int *hw_ids;
+	unsigned int dt_hw_ids[MAX_SENSORS];
 	u32 num_sensors;
 
 	if (pdev->dev.of_node)
@@ -1168,10 +1167,20 @@ static int tsens_probe(struct platform_device *pdev)
 		data = &data_8960;
 
 	num_sensors = data->num_sensors;
+	hw_ids = data->hw_ids;
 
-	if (np)
+	if (np) {
 		of_property_read_u32(np, "#qcom,sensors", &num_sensors);
 
+		ret = of_property_read_variable_u32_array(np, "qcom,sensors",
+							  dt_hw_ids,
+							  1, MAX_SENSORS);
+		if (ret > 0) {
+			hw_ids = dt_hw_ids;
+			num_sensors = ret;
+		}
+	}
+
 	if (num_sensors <= 0) {
 		dev_err(dev, "%s: invalid number of sensors\n", __func__);
 		return -EINVAL;
@@ -1187,8 +1196,8 @@ static int tsens_probe(struct platform_device *pdev)
 	priv->num_sensors = num_sensors;
 	priv->ops = data->ops;
 	for (i = 0;  i < priv->num_sensors; i++) {
-		if (data->hw_ids)
-			priv->sensor[i].hw_id = data->hw_ids[i];
+		if (hw_ids)
+			priv->sensor[i].hw_id = hw_ids[i];
 		else
 			priv->sensor[i].hw_id = i;
 	}
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 504ed3394a79..439f356f0177 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -589,7 +589,7 @@ int get_temp_common(const struct tsens_sensor *s, int *temp);
 extern struct tsens_plat_data data_8960;
 
 /* TSENS v0.1 targets */
-extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
+extern struct tsens_plat_data data_8916, data_8974, data_tsens_v0_1;
 
 /* TSENS v1 targets */
 extern struct tsens_plat_data data_tsens_v1, data_8976;
