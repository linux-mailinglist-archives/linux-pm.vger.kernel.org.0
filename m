Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9542A6A5A38
	for <lists+linux-pm@lfdr.de>; Tue, 28 Feb 2023 14:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjB1Now (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Feb 2023 08:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjB1Nop (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2023 08:44:45 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3E62F78A
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 05:44:35 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id x6so4659723ljq.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2023 05:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677591872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vveGd9sf9fGz7xfjIX4ynPRPTvQaFdGwhHtakqOTRYg=;
        b=VLXw8x/HVK++rxyPE+23hHMFMSwTE3HGtekASbnCMGHZuPar3hClhNxfuQMN3uM/81
         wNZlRETtkblRSd4rX6fxZtGipiuG/FJ3TPjMnVggM+q6Vqq3HAR9ozypQtbRcNDNxfl8
         sjwWPtULXuothLPeRoF0e+yauL/i5EyFg0zsKoO+kaHb47CeXIuI4+V+QkmsXKOMNfVs
         p9+75OjV2WKORkcqYS006WBS+44oaBFLj7qSQR2dF8MvlSmfWqQLNM10Snd8eW7CCuC6
         FsszgvA5bu7t7l+bkKGo/4q1TYNWhk7Y0LnWnhTRY6FnksSMMI/Hv7BfRQexSQ1fwAKM
         f0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677591872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vveGd9sf9fGz7xfjIX4ynPRPTvQaFdGwhHtakqOTRYg=;
        b=mWdgXqZ+CIuOc+F/V87ixmwNWC5DeoiEroONQSchpn7UQWsBZVfDhabKv6XOlzys5Z
         cVOmC0OK5d5yoripISweV+G2HnVtjcu5z5mW+/0TXMOnimAr7lb4n3xLy7ng4B59lWOc
         RPuAuLk0xjV9vL6KEpE3kUKog91PJ9hXCdrLLzWzLVsqs2JNF9WWsZog5INkAmk3JlIf
         Y0eWk8wjdulcKzc8gjiw95K8veqoiFHNb+X9IAADH/des5UKFFcrvL4RXn1V5eR0amPf
         XoTgXhvxcczVIOwChGj8JuXb3n2iTbf40K8ObotypGWslZaWt/eLlCODrErTia0mk5k4
         Orqg==
X-Gm-Message-State: AO0yUKX7SqO1kU9W1Zz8V+ypiaOEMKoDPUNs2NDaa34/ZKjxTDmF72zs
        Td5xAu5N/MTYDPCEADFaf5z7OQ==
X-Google-Smtp-Source: AK7set/yNx+ztYP2VxaFAU39vtO3EyYHHb4UMqld4Hkcce54kgL2KmeBXxl+aeseQybRjjAqsX3EoQ==
X-Received: by 2002:a2e:9bc9:0:b0:295:9970:9f73 with SMTP id w9-20020a2e9bc9000000b0029599709f73mr766874ljj.29.1677591872728;
        Tue, 28 Feb 2023 05:44:32 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e3c14000000b00295a583a20bsm1203975lja.74.2023.02.28.05.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 05:44:32 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 14:44:06 +0100
Subject: [PATCH v6 9/9] interconnect: qcom: msm8996: Promote to
 core_initcall
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v6-9-3c37a349656f@linaro.org>
References: <20230228-topic-qos-v6-0-3c37a349656f@linaro.org>
In-Reply-To: <20230228-topic-qos-v6-0-3c37a349656f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677591861; l=1279;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5H1KJ2r/pG170nOV3v3bsq3JNwWcNEZN04iD5DDB2kw=;
 b=yLfZUq5Z5xp1LtHleRTEckj0GMI3jzrt+GgHuw7jqq6epsR/JDBZ7/xLzu+YM7S7gah/Xn53SHWj
 OuJtKAZHBxh/lb5Uh3LGOzCaGd3xbVcn5ijbSbrKBi1QLMJaEP7c
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The interconnect driver is (or soon will be) vital to many other
devices, as it's not a given that the bootloader will set up enough
bandwidth for us or that the values we come into are reasonable.

Promote the driver to core_initcall to ensure the consumers (i.e.
most "meaningful" parts of the SoC) can probe without deferrals.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8996.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 347fe59ec293..1eb51ed18b0b 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -2109,7 +2109,17 @@ static struct platform_driver qnoc_driver = {
 		.sync_state = icc_sync_state,
 	}
 };
-module_platform_driver(qnoc_driver);
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
 
 MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
 MODULE_DESCRIPTION("Qualcomm MSM8996 NoC driver");

-- 
2.39.2

