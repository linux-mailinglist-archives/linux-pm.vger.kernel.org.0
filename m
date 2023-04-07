Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3039D6DB50E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Apr 2023 22:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjDGUPZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Apr 2023 16:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjDGUPN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2023 16:15:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E492CA0B
        for <linux-pm@vger.kernel.org>; Fri,  7 Apr 2023 13:14:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y20so55741850lfj.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Apr 2023 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680898496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UK324XxVLyW7Zcb2CZ/1jAhmypGps1orFHLyigBwr5Y=;
        b=yqZEBUvNVCoCG1kYbv6BCn4D0Qcr92VlfzKmglVvZYkEdbsKkM9eX6zrAes/n5toqv
         Qu4xR1oXPF3iW2PlmWZM4PiNnoYT7pHivkuEumgtKq5oW0+xNraiZVR+iFd5Ap7YE0Md
         UkYReMEbtTgol8JUCdn1e8AY4R+sRqVF/1vPdymDn8yog1HL/noqOd4oUik9koaXGWDM
         aJxPdG1AYb7uanLSnaNK9gtfH0YsPqphnes0NrEHCEV34cS1XsFJH7f1pxDIx4dyQ3nS
         Usmcqh5IhlWzI049CC/jJCuLBE7JkBk6R0LE1A9G8lLMyhYBGzmc+c9y9yqTy0CEw844
         RMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680898496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK324XxVLyW7Zcb2CZ/1jAhmypGps1orFHLyigBwr5Y=;
        b=AyHK5/EtIbUPLpdKSyXXWGrgapU974dz1KoKCXPrLzeH+V0gBwkbgsM/Btpuscpc/l
         W5GcgBD+lubjKj35AvlIXY5V6aBWHxj5eLti7Sgiv85YvgpWYxN0XlOjKuF0dkgBsM8d
         Frs5JnzELNtmSiicYMO8mxXFqEc2fUMQzc4K9skyaQOnwMw9JR75xSCybjMmz2luUOQm
         S0g5nlMcV6pdezugoWfkURb+wZ31kveBGZP0vOYR5UVtHZL/mDGJEmfxXE5ZAWKDmZke
         wh59MkTudX8cO6WlMdw6alR4GNOrv4mgqN/LKBGDXXM0Mz/8Z7UrfkZASGicfh04Ypz9
         +iKw==
X-Gm-Message-State: AAQBX9e2dL1pkfoOeB/qXAw1UUjAMmlVRT50IHdFw2JulUFA4Plg5qrk
        SSzLGbqu4bb8bBEthPTwbL7Zb/OTt1ROsH1YQqg=
X-Google-Smtp-Source: AKy350ZqCC2EWpi54zjCAZha/wQjOAUazAPsrcEJ8ES8x2YGJmj/5Oaf+q9Y20lANUCgsRiqOL1KlA==
X-Received: by 2002:ac2:48b1:0:b0:4db:513b:6ef4 with SMTP id u17-20020ac248b1000000b004db513b6ef4mr1437520lfg.11.1680898496200;
        Fri, 07 Apr 2023 13:14:56 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u3-20020ac243c3000000b004eaf6181a32sm842436lfl.75.2023.04.07.13.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 13:14:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 22:14:50 +0200
Subject: [PATCH v8 8/8] interconnect: qcom: msm8996: Promote to
 core_initcall
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v8-8-ee696a2c15a9@linaro.org>
References: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
In-Reply-To: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680898484; l=1279;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BYfX0jKxH/0PCjBpNTo0aggPX+DBVTo1e00pUoIo7lE=;
 b=Q3wauYfS7gq5URur71wgmqfygzW5MSoxMThsPbY1kwefMc+i7/CpNJfllJopgOxt5+m5bsnSWzun
 FU/S2NiNDMRstqmR5b2r2pmOwfx7MCLGGf7tcxHLHdcPc7OV9ijd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index dc9959a87df2..20340fb62fe6 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -2108,7 +2108,17 @@ static struct platform_driver qnoc_driver = {
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
2.40.0

