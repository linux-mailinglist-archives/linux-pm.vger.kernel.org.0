Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE54B416762
	for <lists+linux-pm@lfdr.de>; Thu, 23 Sep 2021 23:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbhIWVYL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Sep 2021 17:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243295AbhIWVYI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Sep 2021 17:24:08 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E13C061574
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 14:22:36 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso10540045otu.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Sep 2021 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MUk9cQnhiL3Zkl8SZPCyCUqEll5PCUu2UZfL3NWv9rk=;
        b=p6xVunDlOfkTJazQbadWMPPC6xtrVTuBgikipt3QXOK8psdrpoQIAEkU08aDR/88XY
         RuF98Yz/C0AHxKpUCrA/SbOS1oP1rnuTPdBWGuYm4PYcuzU+Gw3MoVzvtqVr0BiI4xyr
         QvMUMEpEXlz6FevC1u1NIcY9gh5drGmPgjcHF6u4tRHOOLWCMjUfgrZKnvdpONLgk0rh
         kI1wFGv+C4YZDpsnIEPXRFd5y7ol4CX/CLJwLOZt6vDMiJBqZHPo/4BWlk1zBThSaxIf
         3JS5QdwIt1o2CjumcXZD7aaRHvyTqdFLn6k6jF8QMmJx55hgyZQASXt0WcAefpp2tuoE
         UlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MUk9cQnhiL3Zkl8SZPCyCUqEll5PCUu2UZfL3NWv9rk=;
        b=Uxk6AFtBpFLFyFc4n5AImoiKaz819gss+masrLfiBChY1blJyGlubJ6alz5NmXIDGb
         E4gqy6M/4FOBuYH6x0ZV3dbsqPoY2OKBCAMBRneXvfNldIjawITnISxwpFs2IKnLoOuB
         SzXeFnARsiLfSGEIuZTgOV5grs4529C/Am8kdAAPTyMXK1EmKUVbPUSRWwc9ud8SytDc
         PRuU2XyPMkfWdNqRB9y9pQLBNvSR/JIUn8ra9A84/nkf/jGWq4rLnUkbWqerrxAIZgWB
         GcFtKJ1YTDKE3n3VFdmeIKBuTl2MsOq0YbvKApKe+Q5VlKZGup56BHHAgp2qn0xsHdba
         Palg==
X-Gm-Message-State: AOAM533aSaU4yvIQbfMqyGqpK9LXFtYhtYEkDQFGLNDrguixbO3Tt5qM
        8MluSQEvcMlDYqmioZGkIHRAbw==
X-Google-Smtp-Source: ABdhPJyS4o0vA69A7MO/A7du8ZidoqH6SCBNKw9Qn3lQFXKzBh8O1oUF5gV8lMGSBzAypRVpYaHn0A==
X-Received: by 2002:a9d:6a43:: with SMTP id h3mr813709otn.142.1632432155920;
        Thu, 23 Sep 2021 14:22:35 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e16sm1586820oie.17.2021.09.23.14.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:22:35 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] thermal/drivers/qcom/spmi-adc-tm5: Add support for HC variant
Date:   Thu, 23 Sep 2021 14:23:09 -0700
Message-Id: <20210923212311.2877048-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
References: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The variant of the ADC Thermal Monitor block found in e.g. PM8998 is
"HC", add support for this variant to the ADC TM5 driver in order to
support using VADC channels as thermal_zones on SDM845 et al.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- New patch

 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 43 +++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 8494cc04aa21..7fe5cf28ae15 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -82,6 +82,7 @@ struct adc_tm5_data {
 	const u32	full_scale_code_volt;
 	unsigned int	*decimation;
 	unsigned int	*hw_settle;
+	bool		is_hc;
 };
 
 enum adc_tm5_cal_method {
@@ -146,6 +147,14 @@ static const struct adc_tm5_data adc_tm5_data_pmic = {
 					 64000, 128000 },
 };
 
+static const struct adc_tm5_data adc_tm_hc_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.decimation = (unsigned int []) { 256, 512, 1024 },
+	.hw_settle = (unsigned int []) { 0, 100, 200, 300, 400, 500, 600, 700,
+					 1000, 2000, 4000, 6000, 8000, 10000 },
+	.is_hc = true,
+};
+
 static int adc_tm5_read(struct adc_tm5_chip *adc_tm, u16 offset, u8 *data, int len)
 {
 	return regmap_bulk_read(adc_tm->regmap, adc_tm->base + offset, data, len);
@@ -375,6 +384,31 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 	return 0;
 }
 
+static int adc_tm_hc_init(struct adc_tm5_chip *chip)
+{
+	unsigned int i;
+	u8 buf[2];
+	int ret;
+
+	for (i = 0; i < chip->nchannels; i++) {
+		if (chip->channels[i].channel >= ADC_TM5_NUM_CHANNELS) {
+			dev_err(chip->dev, "Invalid channel %d\n", chip->channels[i].channel);
+			return -EINVAL;
+		}
+	}
+
+	buf[0] = chip->decimation;
+	buf[1] = chip->avg_samples | ADC_TM5_FAST_AVG_EN;
+
+	ret = adc_tm5_write(chip, ADC_TM5_ADC_DIG_PARAM, buf, sizeof(buf));
+	if (ret) {
+		dev_err(chip->dev, "block write failed: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
 static int adc_tm5_init(struct adc_tm5_chip *chip)
 {
 	u8 buf[4], channels_available;
@@ -591,7 +625,10 @@ static int adc_tm5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = adc_tm5_init(adc_tm);
+	if (adc_tm->data->is_hc)
+		ret = adc_tm_hc_init(adc_tm);
+	else
+		ret = adc_tm5_init(adc_tm);
 	if (ret) {
 		dev_err(dev, "adc-tm init failed\n");
 		return ret;
@@ -612,6 +649,10 @@ static const struct of_device_id adc_tm5_match_table[] = {
 		.compatible = "qcom,spmi-adc-tm5",
 		.data = &adc_tm5_data_pmic,
 	},
+	{
+		.compatible = "qcom,spmi-adc-tm-hc",
+		.data = &adc_tm_hc_data_pmic,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc_tm5_match_table);
-- 
2.29.2

