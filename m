Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAFF519980
	for <lists+linux-pm@lfdr.de>; Wed,  4 May 2022 10:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346179AbiEDIVf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 May 2022 04:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346169AbiEDIVd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2022 04:21:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F27B22B2F
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 01:17:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i27so1401396ejd.9
        for <linux-pm@vger.kernel.org>; Wed, 04 May 2022 01:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O6GbIkgJZE5Z6glq7Iv2emVY00yo6pcgnwtnrebV2k4=;
        b=ur/0KL9Fhaf7eYBEvSL291bNaCYRN55DUwp8WCBgMYvdAcjjBUF1mB02qqKIsoAtHf
         +hDN/7Z004Dg4IywRI5N4h137KL0DLdcF9jO4qgsa9drkhDfIZiDv+a7WX6UBWXu5P2T
         0Bn7cfBL95hejAZmK3VTyU/GQuJDH9q+JR+wGB2GFDyw1F9FJS0L4rjTJFsmMMfIEK8+
         V3ccPgCQEblCxvfQgZ/vsKjfvrAE7rSyfvc5mIabMrgebJtwHj+CqeqvmOhqUCwy7CRF
         2Q8UXVoZjfzH7XkWGjI/VeSWCJPgcQ0GmuEK34h4mF+pFkUxApGiwRuga7AJJ6ZVo/Gy
         XecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6GbIkgJZE5Z6glq7Iv2emVY00yo6pcgnwtnrebV2k4=;
        b=RhY3zsSIVbn6Fwf1cwPViI/hgAdgm7rni0gdLCcEkf1IsFHNLhpLc09gwFyMQV3rTH
         zaSCdt36cuBq37i280QLqhjkWa91VjemEB7McKayZbYo6FjiL2WBtMXV1Z4Atp3lRRyo
         tfSUW6LeZIuYVc1KQpevd2r+wtuE3kkfSOJIXLTdbMWXs6F5SvN3nEIJ9MS/uAdl/q2z
         pcwCTBHIQomE8vL8bMr8yVvKMjWZNAdxIyx4AZwpZSx9MTrTKY6nIVKs/dbkRRPFI/4I
         JTJMBBccg3RHPP1EvDjpBa0h3a9kKBKUUeq0xaXt6vxasBH2Z/y9cB1or6l6AOK8np/p
         T//w==
X-Gm-Message-State: AOAM530S6RQhUzx2bC7ljh7XXQ1v5ScpIZ5IMOLxKhVc0SDYOqSFUavH
        bSWqwvJ8N9sZRLNDbL+dSZoZBA==
X-Google-Smtp-Source: ABdhPJw8cwfUkl3cLE4Gx+H/jj1KdfjNqfXkg98cWmonAuCaRjNsaNnMBDBwVQQSS/yKkpS8GHFk5w==
X-Received: by 2002:a17:906:c156:b0:6f3:9e3c:5cc8 with SMTP id dp22-20020a170906c15600b006f39e3c5cc8mr19000557ejc.17.1651652276973;
        Wed, 04 May 2022 01:17:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402345500b0042617ba6393sm8781322edc.29.2022.05.04.01.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:17:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/5] arm64: defconfig: enable Qualcomm Bandwidth Monitor
Date:   Wed,  4 May 2022 10:17:34 +0200
Message-Id: <20220504081735.26906-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504081735.26906-1-krzysztof.kozlowski@linaro.org>
References: <20220504081735.26906-1-krzysztof.kozlowski@linaro.org>
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
2.32.0

