Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380CF740F76
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jun 2023 12:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjF1K5g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jun 2023 06:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjF1K5Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2023 06:57:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D081BFE
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 03:57:01 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991f956fb5aso280656466b.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687949819; x=1690541819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UOP/HXwOfjROV0iDHrU1g1p6LD4GcCF3K/FghLtNOU=;
        b=dujCAIaXSqqrylpawSmjXQ0uVV5fxHuMEQFzZO//TIz9sxd1krxA8ZDYPCDBDRVh0/
         BfluOhNKHaqL76P0tQO39OagrbXFJc2LI7Tg5leqj6NdydDD+PHLgE+d3n6pCSrGdu5c
         qsrE6I/PhnivlF9PkTMJ1Laa3igaQiDWgWYmKdVl0J3y4kuOVTJ4Mg9PU83v4ml0UsSx
         LK0jT/vaxWfQQJ50Yj/VnTLXf3Aj0r5qZRmcn1iRAh7QmanZn5fC3LhQaukjGHdSnlKi
         B/+a2PL7DVxgndOYPox3yCot4+cfYZCKp4OCr+ZnWX93JP3lLrsTMb7JnHyfIWJF5ROo
         sDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687949819; x=1690541819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UOP/HXwOfjROV0iDHrU1g1p6LD4GcCF3K/FghLtNOU=;
        b=ero1BK8rYAG5mTCsS8V1tR2/1LuOQPTLFadELTIlyDwb5kjj8/0yEYCNk4guE8hUve
         k802trWqK6MOIDKfkz6vzIcbRE/gz0mhX+obv2mKzgKhWsOOo6SBC94e1OFbLLQoyi8b
         06aOMkMhyoeDOehtSqZLMa3Y+jRKuJj9ACPhj2VgfDBfhprWiWZgPK+RgNXH+p1CYJ2n
         UGl9zsIeq+Hhw+zKKbi82d/p9Qc+nqHkSCM4BS/g5AFl2vMznIvt5DEcCTk/JtofxAOD
         2mCoRq++AKBJwZne1MXRADoTb60/44DLOE0LfZB2m2ng2EYMT07gFgWhtHufnrHf50VB
         hwTA==
X-Gm-Message-State: AC+VfDzZ39AGbQmRPeTwcTQCUMHQV1pWoNf05RqaeVTxxyX97DVWoRd0
        P4vIl9E4o1nRVpVUOPHvWMUF/Q==
X-Google-Smtp-Source: ACHHUZ67Cwzrz18vbTdkKEW1I1amvlbeV+5l0PQbp3RlpgaAlkwLmpNPkfXRt0ALcbGFWNJZXuNGDw==
X-Received: by 2002:a17:907:2683:b0:957:1df0:9cbf with SMTP id bn3-20020a170907268300b009571df09cbfmr25730821ejc.19.1687949819656;
        Wed, 28 Jun 2023 03:56:59 -0700 (PDT)
Received: from hackbox.lan ([62.231.110.100])
        by smtp.gmail.com with ESMTPSA id e8-20020a1709062c0800b0098921e1b064sm5544678ejh.181.2023.06.28.03.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 03:56:59 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        avel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] clk: qcom: gdsc: Add support for set_hwmode_dev
Date:   Wed, 28 Jun 2023 13:56:52 +0300
Message-Id: <20230628105652.1670316-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628105652.1670316-1-abel.vesa@linaro.org>
References: <20230628105652.1670316-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Implement the GDSC specific genpd set_hwmode_dev callback in order to
switch the HW control on or off. For any GDSC that supports HW control
set this callback in order to allow its consumers to control it.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/gdsc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 5358e28122ab..9a04bf2e4379 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -314,6 +314,26 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	return 0;
 }
 
+static int gdsc_set_hwmode_dev(struct generic_pm_domain *domain,
+			       struct device *dev, bool enable)
+{
+	int ret = gdsc_hwctrl(domain_to_gdsc(domain), enable);
+
+	if (ret)
+		goto out;
+
+	/*
+	 * Wait for the GDSC to go through a power down and
+	 * up cycle.  In case there is a status polling going on
+	 * before the power cycle is completed it might read an
+	 * wrong status value.
+	 */
+	udelay(1);
+
+out:
+	return ret;
+}
+
 static int gdsc_disable(struct generic_pm_domain *domain)
 {
 	struct gdsc *sc = domain_to_gdsc(domain);
@@ -451,6 +471,8 @@ static int gdsc_init(struct gdsc *sc)
 		sc->pd.power_off = gdsc_disable;
 	if (!sc->pd.power_on)
 		sc->pd.power_on = gdsc_enable;
+	if (sc->flags & HW_CTRL)
+		sc->pd.set_hwmode_dev = gdsc_set_hwmode_dev;
 
 	ret = pm_genpd_init(&sc->pd, NULL, !on);
 	if (ret)
-- 
2.34.1

