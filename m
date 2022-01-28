Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3ACF49FDB0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jan 2022 17:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiA1QKP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 11:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiA1QKP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 11:10:15 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E05C06173B
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 08:10:14 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id hu2so6238909qvb.8
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 08:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BZVdFXLyl74h3jtOPF272oyC+s8DavqmR8oCcxBJMgQ=;
        b=Irl9DzzuMp5iz+pnKClhzQPaMwdM0JkYG1ovs0IKC2O9S0v4uxcneGJvTgqJ2M9fWR
         z1uk2YF3U4ckMLO3AyhN0a04UiwiJJ/sfl3WbfVcGyOfUtHe6tB1hYjYC+MQFU6uKJSd
         rEloCtTXSk/x2tZcORAqeOWG7ihk5pXHdPzj2jif+RwjvoOPQ5vZV4JGSX3uzGKS/AV2
         1RtNE7BIp+sw5rndSOrKv9LN6PeClTtxV4znTpb70yiGCSkivqBWeM/8PHvZzinwfboM
         82HHT9uk2Gs3l9k+6G8WQYE4gfEWi1Jg8yHty8vSgLeh/4fcUwuheOiEKCnyQ8ovf35e
         qHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZVdFXLyl74h3jtOPF272oyC+s8DavqmR8oCcxBJMgQ=;
        b=4HJvZqfhtD13VaLxMQw+522j8kyyunQVOflLrEZB9yx3gdhBovYtHvFiPITwW9g288
         MNYjMdF/lBprweyitWn8/C1ls4Y7u1fUb732hCy8hVTpyQosjN7qbN9oZTqxA+vEO7cP
         wC2omdZkXjNJ5WjXnmYAjlK6fJ1aspOkYeGc0fgkFgPAnnpCg1E12AGIf4dJpXuRSe2b
         QX9LuqqcGj5k6UPSa9Jh1HT4I6Oxm8GaaX5dcM4ZXaB2hJilDftbvbr/fQfInG2ZwSLe
         QIYE56+Q4JbocJJxA6X1kaD4PxP0hyVWSIZTOFKT03Kic9MLYNeTlc2u5XKbN++hl0Z9
         qa/A==
X-Gm-Message-State: AOAM532oF7F32F6PB9BuF1BbRF0A1mf52WgNtuoxkoiKG2bxe2DEmNOn
        lrHgtNGSnlojpvl5Zl6KdAlh/g==
X-Google-Smtp-Source: ABdhPJx4boyq8XpVgJFTXH3MbmtL0MCaFGhtPTIwTG2irXEbCBxo7KD1ZiZ+2g2ELnnqqy8i9BqdFw==
X-Received: by 2002:a05:6214:5189:: with SMTP id kl9mr7555285qvb.9.1643386213864;
        Fri, 28 Jan 2022 08:10:13 -0800 (PST)
Received: from sagittarius-a.sqcorp.co (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o21sm3339006qtv.68.2022.01.28.08.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:10:13 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     djakov@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     jun.nie@linaro.org, shawn.guo@linaro.org, benl@squareup.com,
        dmitry.baryshkov@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH 3/3] interconnect: qcom: msm8939: Deliniate bus, bus_a, bus_mm and bus_a_mm clocks
Date:   Fri, 28 Jan 2022 16:10:02 +0000
Message-Id: <20220128161002.2308563-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220128161002.2308563-1-bryan.odonoghue@linaro.org>
References: <20220128161002.2308563-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

System NoC (snoc) and System MM NoC (snoc_mm) clocks can be defined
together and passed as part of a single snoc interconnect. rpmcc indexes
take care of sending the right RPM messages.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/interconnect/qcom/msm8939.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index 7030911e25adc..431e77d63df46 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -1290,10 +1290,19 @@ static const struct regmap_config msm8939_snoc_regmap_config = {
 	.fast_io	= true,
 };
 
+static const char * const snoc_clocks[] = {
+	"bus",
+	"bus_a",
+	"bus_mm",
+	"bus_a_mm",
+};
+
 static struct qcom_icc_desc msm8939_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8939_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8939_snoc_nodes),
+	.clocks = snoc_clocks,
+	.num_clocks = ARRAY_SIZE(snoc_clocks),
 	.regmap_cfg = &msm8939_snoc_regmap_config,
 	.qos_offset = 0x7000,
 };
-- 
2.33.0

