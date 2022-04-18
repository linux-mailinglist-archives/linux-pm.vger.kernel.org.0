Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619DE505C61
	for <lists+linux-pm@lfdr.de>; Mon, 18 Apr 2022 18:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346127AbiDRQZM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Apr 2022 12:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346126AbiDRQZL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2022 12:25:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2672ED69
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 09:22:32 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y21so7528602wmi.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V5b0KiqwmQsw2Tvjdq6eIg9g7/J0fkOD26ZVfdSPlIs=;
        b=BcUIF1ErX+4shLIyGAX+bSueP0Zm/r3Ehw2UwZvbbGd9oHpsJB3AkkcqMjvEr6/2Xi
         1Yn+iSgQa7PNL8U99L31L02XEZXRSrwgzmO00AFOMsVW1pudSMXf1t687ijiCVOZ+HmV
         ZGDX83Uu/IDNQGZbRvHGUyI/S5CMn5QrfTb0e1lV+BNqh59AkawSHmgZ7r82ogxVOlEL
         wsuH8FNi/Kqe3969wAlH4+C7X1fz0yi67nSn0i/VwZ6Q70VljlRcM1G0plBEA9hgGjib
         xc+uN3q5b3a+yjXDiED44Oh2yHYpy8Q+n8NIw4eR9vgfbMNlmAxYXoEqicaK6IQHFH+q
         rhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V5b0KiqwmQsw2Tvjdq6eIg9g7/J0fkOD26ZVfdSPlIs=;
        b=bdBOWsStN0uitx2mTyU/5DZPolyr+6tS4RrFA4FCphB8fsyY8hajbTJ1q2RCitlCTo
         fqiUmoNDeg/gGBIvOGRTGVLmtWG1kSLZ4dL8JkYtyPrdYEaeaMz3/zzHxfXd5irexS4H
         DnNh68VUaNEZwz60OxLInszaltOxtbNuO4JSibMwB9tAXdJSkjG4awrWTJnrU8VZjXRk
         Yn89B3g69s1P+OFIf924KpFWY0MI07kX+4VIBVEau3Yk16C5HcmOYWT2z+Z1QHwR1faA
         IA6szAz5AdQq9TAZvJy8D2aDY4X8HLlJLefivQQdgNNeJ/JlIdvEwtkeM6w2puD63Vzz
         LoXQ==
X-Gm-Message-State: AOAM530jk2WDXal3rL+XfhXg5qX0TDbvA/ORFyY3myjGLKMI2z+bNP9P
        4ynyNloZ6Wylt9tX74el9alDsw==
X-Google-Smtp-Source: ABdhPJxZ4oqO/Fv6fGtxar/p297USwA/n1VvAER0b9C9gz6tZCWPT/We7nTz8zslgsZBG2QlWgRUPQ==
X-Received: by 2002:a05:600c:4146:b0:38e:bd41:39a2 with SMTP id h6-20020a05600c414600b0038ebd4139a2mr11693591wmm.18.1650298950685;
        Mon, 18 Apr 2022 09:22:30 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 205-20020a1c02d6000000b003928c42d02asm8460853wmc.23.2022.04.18.09.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:22:30 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, ilia.lin@kernel.org,
        rafael@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        bryan.odonoghue@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: opp: Add msm8939 to the compatible list
Date:   Mon, 18 Apr 2022 17:22:23 +0100
Message-Id: <20220418162226.2983117-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418162226.2983117-1-bryan.odonoghue@linaro.org>
References: <20220418162226.2983117-1-bryan.odonoghue@linaro.org>
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

msm8939 will uses this driver instead of the generic dt-cpufreq. Add to the
compatible list.

Cc: ilia.lin@kernel.org
Cc: robh+dt@kernel.org
Cc: krzk+dt@kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 5eb1dba13fe2..7efae476c02e 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
@@ -25,6 +25,7 @@ select:
           - qcom,apq8064
           - qcom,apq8096
           - qcom,ipq8064
+          - qcom,msm8939
           - qcom,msm8960
           - qcom,msm8974
           - qcom,msm8996
-- 
2.35.1

