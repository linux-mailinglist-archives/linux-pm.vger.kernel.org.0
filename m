Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AD2421CE4
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 05:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhJEDZm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 23:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhJEDZl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 23:25:41 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AEBC061755
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 20:23:51 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c6-20020a9d2786000000b005471981d559so24167143otb.5
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 20:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SvFCR87aiu5ds1ai63pEGRyATYSJy34i9VrTijqqATk=;
        b=vXNxhAPVm30L6Xwd7l1KDcxjU3BcId0umPpRZ+QRXrcRF/NNweADvP03yj3W16MmqC
         t+TU6TUsj3/p6FhOBj1Ywr8CI3d/EnJjW+QbRZMUlrT/JHQLY/rPw0Cp0oPoVfc0qIxy
         5ysF0+II44twkSwSjQ66eJNFuNcWHhtnJ8l35QnrHCVgZ/rPxk2+Tr2/zwRDQ7xbQMJx
         tNqwefRDwAFJDYTxHxDNlfP/piepyb/GlMnhZjlirSC5ZkkOciIZfv1hJeDU8/gxCffQ
         rfXb2a+B2ICQYVYGQaAEtBNTF7rO0B8cOd41MeBZSmWHgMbBq0i+o28Nxn5wug6vdv6N
         S3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SvFCR87aiu5ds1ai63pEGRyATYSJy34i9VrTijqqATk=;
        b=2HXlXwxvBkLiAC1+gQKrRrWQOvqSmzIgpQ08LCWQfsmzKeBAnobfA2/6VOIk5smBVC
         3fLTzB56xOJH3AISJ2UdgfSyKsoPqJf3YcIIq09wPahq6siB3Kn0Tg4ygxoZEuzzYtM1
         bpizmI5d6sUN+TptD9bebp9uoxiqtnzDSWOjznQbVjXeKkbfTM3K6hAQq4+rLKAeHCxE
         DZK+cib6ZLJtrqIeRHbQpeg6Jl6/vWXXg7U3RDSBS9Yj9LYyakYf/au9IvIEl2vsqMTh
         ulHR/JVJoQq7GJZbJkV8m5zgra+gOF2E7I2xG4GNQMowyHrEfd/BjrFFT7EyFSJMVveZ
         IfIw==
X-Gm-Message-State: AOAM5310nrmLbUuJEytSBD3HKlKLY1fmdykncZHWC1hZ3z58EDGZ1ozi
        6Ha8xzEMqPuh/eU9U/tPgaoqdA==
X-Google-Smtp-Source: ABdhPJxSSslvoW0rwWInaRPbH4TQYAA0/DWTIUmmyUTD8TNYQ48VnwLlvqg+BiZluVnaq9t2DjPRdQ==
X-Received: by 2002:a05:6830:793:: with SMTP id w19mr11859830ots.23.1633404231018;
        Mon, 04 Oct 2021 20:23:51 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id j4sm3111955oia.56.2021.10.04.20.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 20:23:50 -0700 (PDT)
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
Subject: [PATCH v3 2/4] thermal/drivers/qcom/spmi-adc-tm5: Add support for HC variant
Date:   Mon,  4 Oct 2021 20:25:29 -0700
Message-Id: <20211005032531.2251928-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211005032531.2251928-1-bjorn.andersson@linaro.org>
References: <20211005032531.2251928-1-bjorn.andersson@linaro.org>
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

Changes since v2:
- Dropped conditional return ret right before unconditionatl return ret;

 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 41 +++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 8494cc04aa21..824671cf494a 100644
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
@@ -375,6 +384,29 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
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
+	if (ret)
+		dev_err(chip->dev, "block write failed: %d\n", ret);
+
+	return ret;
+}
+
 static int adc_tm5_init(struct adc_tm5_chip *chip)
 {
 	u8 buf[4], channels_available;
@@ -591,7 +623,10 @@ static int adc_tm5_probe(struct platform_device *pdev)
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
@@ -612,6 +647,10 @@ static const struct of_device_id adc_tm5_match_table[] = {
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

