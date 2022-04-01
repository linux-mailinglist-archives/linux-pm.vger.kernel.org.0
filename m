Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD124EECC7
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 14:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiDAMFX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 08:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345709AbiDAMFW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 08:05:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD706E4E6
        for <linux-pm@vger.kernel.org>; Fri,  1 Apr 2022 05:03:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bg10so5403356ejb.4
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2022 05:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QAcDFjrNz07YlUTF22+Hj1ORRdh1pD4AG8GERXefOmg=;
        b=OP5n5mebCQejScS7qW7DSZAtOSc9xKzxjeA7nUAjWib02eDE2tc7yJ+0Qdgl77XOh4
         VLTyD5drnTek7fTPHgZC6Bwyki0b8WXeDcEvkLxeEF0gudjABxVYQIswWu0ZKhDnT1z0
         /0klAhyjxYaMfNlEdJyAYkkBnW4AQiGTcKuMOsygLVCE7assk/Ig4yo3V4YshdKXU2OV
         5GNZZ1fsNlWUgJRMywf5hmaWAkm/7O6Xe3vpXGhTHH+5v4xR+NVpoxdc0+83dyGyqvkx
         aJiUdMfEIRAXftoXIEDK0JkP08Gp5fJW3jsOnqvS1lyWlsolEMTQyrHXCyl7OwjhCpLj
         LGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QAcDFjrNz07YlUTF22+Hj1ORRdh1pD4AG8GERXefOmg=;
        b=g8t1AzZNwq1suRKrqK+nUiIp9pbR7NncDB5XThHvSLUCzLuV8oUcl+Ob/Q0cJE6j+d
         9sAtzSq47tQ5VQk7WxgfPixNjoc0HyyOTW+AMO+u2+tism7e6uTUYBYCyI97rUGZgtfI
         0cz5a7UQ8Hgh1YDDH76GvuOXHWDDou4WjpUI2go3ogUI6v3ivGxqlaR5uby0+akIeQYH
         4dwQdpkvaW06KfE0cEHQAbn1vV/QX520OwH1lU5g7oXokHBuQUhIT6xDiopdhcAIU1ol
         6rgKyT9LzUl4CLqixmqwpkxBHORWRrs6PeH4Tqut+HtkLC44tVS2ioQbQKjzvrGmp0r+
         5ZXw==
X-Gm-Message-State: AOAM533mRE4KmLzwiRBHz7UZ2k477FGPj/iEvygnvVoKtykBStWZBglW
        YDUx53Z63VnMD3Z3JInZ5tPyzw==
X-Google-Smtp-Source: ABdhPJyYlWJnmtSQWgxzHYVdGG4CkLeX4c3fdJv1zDXd4Fl/xjBftkuR5fXCUtIY5/jC4vTQSvhsZw==
X-Received: by 2002:a17:907:6d19:b0:6db:89c8:52e3 with SMTP id sa25-20020a1709076d1900b006db89c852e3mr9329661ejc.754.1648814611433;
        Fri, 01 Apr 2022 05:03:31 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id e11-20020a50becb000000b0041b64129200sm1164768edk.50.2022.04.01.05.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 05:03:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] PM: opp: Fix NULL pointer exception on a v2 table combined with v1 opps
Date:   Fri,  1 Apr 2022 14:03:25 +0200
Message-Id: <20220401120325.820763-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

dev_pm_opp_add() adds a v1 OPP.  If the Devicetree contains an OPP v2
table with required-opps, but the driver uses dev_pm_opp_add(), the
table might have required_opp_count!=0 but the opp->required_opps will
be NULL.  This leads to NULL pointer exception, e.g. with ufs-qcom.c
driver and v2 OPP table in DTS:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  ...
  Call trace:
   _required_opps_available+0x20/0x80
   _opp_add_v1+0xa8/0x110
   dev_pm_opp_add+0x54/0xcc
   ufshcd_async_scan+0x190/0x31c
   async_run_entry_fn+0x38/0x144

Fixes: cf65948d62c6 ("opp: Filter out OPPs based on availability of a required-OPP")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/opp/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 740407252298..d21b7e7e3f9f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1760,7 +1760,9 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	if (lazy_linking_pending(opp_table))
 		return 0;
 
-	_required_opps_available(new_opp, opp_table->required_opp_count);
+	/* No required_opps for v1 bindings OPP */
+	if (new_opp->required_opps)
+		_required_opps_available(new_opp, opp_table->required_opp_count);
 
 	return 0;
 }
-- 
2.32.0

