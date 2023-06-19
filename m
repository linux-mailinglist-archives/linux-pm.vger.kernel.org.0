Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0AF7357AD
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jun 2023 15:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjFSNEm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jun 2023 09:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjFSNEk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2023 09:04:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAD091
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 06:04:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f867700f36so2232299e87.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 06:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179874; x=1689771874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ak6pJEE70i86/FySUfYrSS2au3HzGmo13oLp85+Of0E=;
        b=w2KyWH+GCCRJKUkiVspBElqLjMxjw08ivrRU3GKf9VxhhZcdrtOg6Ui5cKPMBnmWbx
         Whr0y1tfNL+p2jy3BJyRoCrcK+MBBomalzUhM8iwRkyINRC1BXrGv+domU1HWGH5vtSz
         GisMGLp3EvpITPvmsQNYtwn2faUiIhsBOKUJx0XBMHhXFNDx3nnQLbyyF4RfxEWFQ2oc
         k9VXwew1XxCzz/+xZy+JRfkrrR94EQlyRTc8bSWhtUe3IZaFBaisLq4B/ZQA8iNFXL+8
         VT9YpvmfxXnncgjVDpRtUNnz39x6m7omacDScqjO39LcRjxUn5QcB/EBrO3J6KXFOQe+
         QA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179874; x=1689771874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ak6pJEE70i86/FySUfYrSS2au3HzGmo13oLp85+Of0E=;
        b=hw46clALZ1ZDJKCKaGWpiZyijEDkEehB3kQAndTeOKOshAPXYiqafsbXZkXOGIVMOd
         J5OJb22AdmmViZMGjMrnbIzGd/ukGGUftRDzCSyKQAd9Fmk1cLhEdhedGDOcWbkm9f25
         3aRWac0DDJ7Epw7vW6V+nmKJNFWJIZu968BSFi/rK/qYwgMbTGQon9Bn9Gkmqhi490fa
         9ed7xx0V4BsRRwObXOYBCAKNueTm4m+7J2qcjyix3tqRQN82fz8UagIRqyJuhy/N5lb8
         5o6ak3SXMNZM85H1I+TRZpeEXhDEL0IFPdDRKC9kdGEkyiZALrY65ofc+sCUhE9JLiNY
         gE7Q==
X-Gm-Message-State: AC+VfDwXvGgRChxcTZIXuH7umGS9ILpy2euqu8gKZSUylZOJtv3N5nmC
        sfAnUDuzS7XbVbOFcnbcqmoFRUwJSBvO6I6mtqw=
X-Google-Smtp-Source: ACHHUZ6aEZZActg//L1dLw+KV5I0lmLFpotkjIzznzSVEVGEGVzw+5wH54zA+SpUs3ghFNuslbyMww==
X-Received: by 2002:a05:6512:47c:b0:4eb:3fb2:c56d with SMTP id x28-20020a056512047c00b004eb3fb2c56dmr5068671lfd.12.1687179874166;
        Mon, 19 Jun 2023 06:04:34 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:04:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:27 +0200
Subject: [PATCH v7 02/22] soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-2-09c78c175546@linaro.org>
References: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=664;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XHE1WQYZzaLo+c3xD4ALM/GRb1VwY7GuxNqpdL0mBnk=;
 b=btTEFhkxZ9hPrAB1HpOL9cD+zppCxzeWP2iOlroCrAa4fl3B3uFwALjH9g9s68cfx44dKjL+N
 I6vmtoGRG5fAwFmK6D9THXdqXvkLKNrjXx7HimOcjVL9cxv+ykbua9Q
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a preprocessor define to indicate the number of RPM contexts/states.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/linux/soc/qcom/smd-rpm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/soc/qcom/smd-rpm.h b/include/linux/soc/qcom/smd-rpm.h
index 2990f425fdef..e468f94fa323 100644
--- a/include/linux/soc/qcom/smd-rpm.h
+++ b/include/linux/soc/qcom/smd-rpm.h
@@ -6,6 +6,7 @@ struct qcom_smd_rpm;
 
 #define QCOM_SMD_RPM_ACTIVE_STATE        0
 #define QCOM_SMD_RPM_SLEEP_STATE         1
+#define QCOM_SMD_RPM_STATE_NUM		2
 
 /*
  * Constants used for addressing resources in the RPM.

-- 
2.41.0

