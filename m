Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F1B244AD3
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 15:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgHNNmL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Aug 2020 09:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgHNNmI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2020 09:42:08 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52E5C061384;
        Fri, 14 Aug 2020 06:42:07 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a26so9996207ejc.2;
        Fri, 14 Aug 2020 06:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xh728BF/eYFLr8qT6FFw5npDjKdJyvTy3InaLGSMaVo=;
        b=WFnQ7f8gIKGQFFMYBNfchwpC7MnYBe4OE7NDeZ+dKvCoYAiVynrCr7CwfbmfaJUXkp
         TfzGfnUAneDOlZbVgnOtSgmwH489FdElTxWDbTmWA47YlGw1p/Hr60mST86drPvqO0kK
         6cI7kKjg+3yXEPETjq9e18Qlf+97Kcr9Wia0SV6SJhAECM1qwSvuk+JwIcSV40XmxoCQ
         DUcAyiUUnS5LO/e5fSyTRl5cEVYw0V9FmQel4WZja1D2qumGRP/ySLjvU55jOjKbpOHm
         P9+1bi5CfhSVKYDdD995ABrZ9Mz6SRH5hVrg0bmcQDzQP3Tjn3d6scBtiKexDN0/Fzeb
         Z3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xh728BF/eYFLr8qT6FFw5npDjKdJyvTy3InaLGSMaVo=;
        b=toxHWG878YoCqBrE84Ezq3mwMMMBWC6TkO/JELJpzNqplJW+zmwf2IEmN+iK0AO/g4
         ekHAfSNU5NgDCkJo+Zjlf4d5FrTO8dmiMWqZ2/b6DJHLBtqBBFkrFbeD9UcUoqOxk2+2
         8dzmBcOVB7H2flDu90h3FIW1bvvZnSvgVJ/QLVZU0svIAjQZ7nCXRxIGSwfnDI8MvWvH
         IXMV5fjocUQhrJKN1B/pK7MPD6fvR2ihcBkzLbqozMu4JgKU/29GX5WQZqm1ic7/Wrh6
         cZLnlQtmBW31TIcMwDLOIWafps+yzM0E2eLOPqhGqDA8VMSyBs3OxyCSI5PaUIl9mnge
         2R+w==
X-Gm-Message-State: AOAM532HtiaBTR+OTMEF9xjk/WtV+rDO+VWY2x94TYqf6RxzwDRRG9TA
        LvdZEjUNRM4OT2rqmRJSXh4=
X-Google-Smtp-Source: ABdhPJysV33cH4agZBarQgQREVnggrouAFSA9tLnaRmEbLAq8W3Fqry1fWlMNSBYFMWuh1GL60/gtw==
X-Received: by 2002:a17:906:8286:: with SMTP id h6mr2369540ejx.341.1597412526421;
        Fri, 14 Aug 2020 06:42:06 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-0-192-118.retail.telecomitalia.it. [87.0.192.118])
        by smtp.googlemail.com with ESMTPSA id s2sm6767118ejd.17.2020.08.14.06.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 06:42:05 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 1/8] drivers: thermal: tsens: use get_temp for tsens_valid
Date:   Fri, 14 Aug 2020 15:41:15 +0200
Message-Id: <20200814134123.14566-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814134123.14566-1-ansuelsmth@gmail.com>
References: <20200814134123.14566-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the driver get_temp function instead of force to use the generic get
temp function. This is needed as tsens v0 version use a custom function
to get the real temperature.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 9af6f71ab640..9fe9a2b26705 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -580,7 +580,6 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 {
 	struct tsens_priv *priv = s->priv;
 	int hw_id = s->hw_id;
-	u32 temp_idx = LAST_TEMP_0 + hw_id;
 	u32 valid_idx = VALID_0 + hw_id;
 	u32 valid;
 	int ret;
@@ -600,9 +599,9 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 	}
 
 	/* Valid bit is set, OK to read the temperature */
-	*temp = tsens_hw_to_mC(s, temp_idx);
+	ret = priv->ops->get_temp(s, temp);
 
-	return 0;
+	return ret;
 }
 
 int get_temp_common(const struct tsens_sensor *s, int *temp)
-- 
2.27.0

