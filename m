Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6115654FC
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jul 2022 14:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiGDMSb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jul 2022 08:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiGDMR7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2022 08:17:59 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF4312616
        for <linux-pm@vger.kernel.org>; Mon,  4 Jul 2022 05:17:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c12so711125lff.2
        for <linux-pm@vger.kernel.org>; Mon, 04 Jul 2022 05:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4c6eL6FkT3F5Q2UMeh1SdTOW/jzEthp0aJ+P51R6LI=;
        b=kXJS3f5b7yC9K8hm0tvpSXyKvaeyDMMSD899aQ9fPY0xv+kQ6x87ysIfsbv/i4t5ax
         hetzoT2aSLQPlE8MYiAfEd5rdps5hQxEd7u9DRuV//7ri1nFDUzPCCFO+Su1r6il1ycF
         r6MquXUYC4UB8KoWJ55xWDfzcEAckn33hVEo9FXKVvTrQxr2a4TQsx6KgWQOt8tpjO4/
         kEnAHv/Qb5zKF/H5FfqnhI+ba7IGzakf4rkZcSSIc7VHzsgBzK7sgrBR5ejUy9XgjImR
         eQRgfTpKrp+UT098Hz6KvYjUzhfLFhnyzm0GOi/U8qYim1IxQSkdoHrVWFh65ZDaYWyL
         KS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4c6eL6FkT3F5Q2UMeh1SdTOW/jzEthp0aJ+P51R6LI=;
        b=F671X5N2YsZVlvhID47w034H21t46Jk8ZGvV+I4XzzD/sKFuBSKsqwW46e8FTYhU22
         7B9/v1wNP7P+pMn1J3e55u3lBKmVqNUh8kNzZmO57+qv0GJdtAMq9vTuBpAq93PRHYX0
         wExyuWzPKoI45y+1bXqYFZbdi89WIzFOONAj/gLQPeSR5qWL34JcJl1czHnTAUFrSgNW
         vZdphdkbxgPghPDzx4RXpwfvCJurdbBZX+KKrkHBqc5SMrJWm9n6WPUsdMQS12JX/bUR
         ph+ZHBrY5wjSG8FviQ2IN5bCWPRN8CDaf2wnQaiiFLxRUfNIN7CjB47HefjsEldYsq9i
         xqug==
X-Gm-Message-State: AJIora9DGbwoIrA1ywyxq3+UpkcmCBGtGPBmoUjcKl1+S816+R4r0caa
        WJ+Ltj3EbWXhitA5SCE9qUkB1w==
X-Google-Smtp-Source: AGRyM1upzfjkZEwtDGMG41zysxdqM2gIjkq1K0IGy7cqb7Fo8Z5IGqeQ8GDyBx9J+kl/aMJjR+TSJw==
X-Received: by 2002:a05:6512:318b:b0:47f:b39d:bbe3 with SMTP id i11-20020a056512318b00b0047fb39dbbe3mr19062136lfe.487.1656937058537;
        Mon, 04 Jul 2022 05:17:38 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id u11-20020a05651220cb00b0047faa01edd9sm5102149lfr.229.2022.07.04.05.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:17:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v8 3/4] arm64: defconfig: enable Qualcomm Bandwidth Monitor
Date:   Mon,  4 Jul 2022 14:17:29 +0200
Message-Id: <20220704121730.127925-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220704121730.127925-1-krzysztof.kozlowski@linaro.org>
References: <20220704121730.127925-1-krzysztof.kozlowski@linaro.org>
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

Enable the Qualcomm Bandwidth Monitor to allow scaling interconnects
depending on bandwidth usage between CPU and memory.  This is used
already on Qualcomm SDM845 SoC.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6906b83f5e45..6edbcfd3f4ca 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1096,6 +1096,7 @@ CONFIG_QCOM_SOCINFO=m
 CONFIG_QCOM_STATS=m
 CONFIG_QCOM_WCNSS_CTRL=m
 CONFIG_QCOM_APR=m
+CONFIG_QCOM_ICC_BWMON=m
 CONFIG_ARCH_R8A77995=y
 CONFIG_ARCH_R8A77990=y
 CONFIG_ARCH_R8A77950=y
-- 
2.34.1

