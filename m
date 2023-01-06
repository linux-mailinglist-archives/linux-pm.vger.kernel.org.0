Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1EB65FC0C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 08:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjAFHdf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 02:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjAFHdZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 02:33:25 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C6755C2
        for <linux-pm@vger.kernel.org>; Thu,  5 Jan 2023 23:33:18 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m6so901548lfj.11
        for <linux-pm@vger.kernel.org>; Thu, 05 Jan 2023 23:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx1KDmZfsq2uvvnOI5+H8ue+wTY/UY2mR9Q4gji8O7k=;
        b=u48/z029prHnx9lvHlheRljzwx5o+Qf0/fL7qkYi1xxchAEPO98SNwYBMgPgBr1z9r
         T9UWhddmrZipG4ahuwYjVqi2qcBtBQk7DyLbaXgg0/qNuvSJGyq9TtYurC/C8mToxkns
         RtzUVW6wn1IljNGJDFKNXsxKIkAQpUvWs1CrldUgWZucT8bJHSZqPxjiAt98FAf0PtiU
         N/fsLcD2aWPladepZzzLxtuR8zv9RYGdofy8aOO14n2lCg4ORxVoqlvhjc0tA2MVLtCi
         FviKe1rr3F42HV45koLHSsGP3LnaDXGMEdIwUMhLeUSfVWR4DIl+e6tof5OvlEoxTmYP
         Wg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dx1KDmZfsq2uvvnOI5+H8ue+wTY/UY2mR9Q4gji8O7k=;
        b=4uaDTDnUOolz9rKVzmHmF9Tk89blFC3tdpBdT/vxt5IHutcVZ+Ok5xslBQjlElceAi
         JyqS8M6zEuIbPKydpzCsZqH3Ph201wubnYcuSU+OeOK1nJwaiFH/R+IaWozCy57Fmd8J
         lnxpd567N0GJgt635tIOZ7X8OGHk96zqEcRHJJuNN07XtMFYm++h+Jx2RS+eymB5vMeL
         Ti/fb5KpoH5Q3GX0MkZUAD7M7PbkCtxpUGCdoQfkvGRhJ56fmBqahZ3gr1/66L8TS7bx
         RV54pBjUxQy9WWLqz5XaFoyIHHxa207FapTaLYmuphyiNPFM5xnZ/59KXnIXIggp88dE
         z7Iw==
X-Gm-Message-State: AFqh2kp7hjLAqtRRDlvFpIFanebClhDObW+jeAscD30P7woWAO8lTzp0
        HIu/q5oq0ExDUEAWlQSvRma2qg==
X-Google-Smtp-Source: AMrXdXuTzWGH3SpsWTw6Z7EEsF1vOUy8nCPd6SW8iE5BoPhQcCNIbOi9JPX6Zr1v9Op6BcVDbaIkvA==
X-Received: by 2002:ac2:431a:0:b0:4c8:ae6b:ea8d with SMTP id l26-20020ac2431a000000b004c8ae6bea8dmr13933538lfh.8.1672990397276;
        Thu, 05 Jan 2023 23:33:17 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c28-20020ac25f7c000000b004b4bb6286d8sm61114lfc.84.2023.01.05.23.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 23:33:16 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Alex Elder <elder@linaro.org>, Johan Hovold <johan@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/9] interconnect: qcom: sc7180: drop IP0 remnants
Date:   Fri,  6 Jan 2023 09:33:07 +0200
Message-Id: <20230106073313.1720029-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
References: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Drop two defines leftover from the commit 2f3724930eb4 ("interconnect:
qcom: sc7180: Drop IP0 interconnects"), which dropped handling of the
IP0 resource in favour of handling it in the clk-rpmh driver.

Fixes: 2f3724930eb4 ("interconnect: qcom: sc7180: Drop IP0 interconnects")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/sc7180.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/interconnect/qcom/sc7180.h b/drivers/interconnect/qcom/sc7180.h
index c6212a10c2f6..b691d97d56cf 100644
--- a/drivers/interconnect/qcom/sc7180.h
+++ b/drivers/interconnect/qcom/sc7180.h
@@ -11,7 +11,6 @@
 #define SC7180_MASTER_APPSS_PROC			0
 #define SC7180_MASTER_SYS_TCU				1
 #define SC7180_MASTER_NPU_SYS				2
-#define SC7180_MASTER_IPA_CORE				3
 #define SC7180_MASTER_LLCC				4
 #define SC7180_MASTER_A1NOC_CFG				5
 #define SC7180_MASTER_A2NOC_CFG				6
@@ -58,7 +57,6 @@
 #define SC7180_MASTER_USB3				47
 #define SC7180_MASTER_EMMC				48
 #define SC7180_SLAVE_EBI1				49
-#define SC7180_SLAVE_IPA_CORE				50
 #define SC7180_SLAVE_A1NOC_CFG				51
 #define SC7180_SLAVE_A2NOC_CFG				52
 #define SC7180_SLAVE_AHB2PHY_SOUTH			53
-- 
2.39.0

