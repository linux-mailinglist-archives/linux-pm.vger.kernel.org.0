Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FF7760165
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jul 2023 23:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjGXVmw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jul 2023 17:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGXVmv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2023 17:42:51 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D72DE9;
        Mon, 24 Jul 2023 14:42:50 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-583b3939521so33485707b3.0;
        Mon, 24 Jul 2023 14:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690234969; x=1690839769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/5RSV3Hpiy5sXwWx6A0fKzeyTBqVKJN6USvmb47CSg=;
        b=Zm+zpYspmqeXwh/gjrvM09jtRt+3z9Y7oB9Bp4uystRgukAHbj0bNNs+R0vtV9AK2u
         gMsoiXOipLp8v5WpRxih80AiVbu686b/8lQZMdg1nlk27COIRnLdcMxMpQzARKzBiTRI
         R8vD26HKA7sXwPfnznwu9yJiIVLnMFZNtfh/HswJqZTMAH/OKBiC79Zn3UvQOoAqdQN6
         suk1RerZebnGzZk/X+kgcPqbYbIqB2FiIDznYlR0mq7tcyINWujbbkWZvkVMoiW7Snin
         ZxJwONs+EUvkPzwXtztElcwNNH9nLvQeWXtW8yxxK17cZLstPnQi7Ib3cFiwCyyUzSia
         uz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234969; x=1690839769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/5RSV3Hpiy5sXwWx6A0fKzeyTBqVKJN6USvmb47CSg=;
        b=JI6XGSIxi5vA1rtGeHj+C2nEa/Y8Bi9y0DhjR3LOUpLWiKNcLNPyYY9ZTE5DMALSR3
         S24/qvZHec2fhZRJBHBHIeXk0xR8+dRrBxhX4boYYoMz4Ne13bmAJ4ylMmBTZQ/tKpjR
         RZCIdEJVbDTNeewMA0GDDPZ9SQEAIU30rUyhH7/syZJcQZylgCnk4k5KXB8yjWjzZUpg
         a0jGj6esFJ3ASYkeKTN6IpUWxomIYqZ+G5LZdwKaYHixWTRpWOa8dJqyygvt8nVTby0P
         +WnZ12VWFpZCtG+L+dMT7hCkbSbK0u/JB3n0SfzvyqgZuJHIhcL+wPRmDmOMzD45TDsV
         PaFA==
X-Gm-Message-State: ABy/qLaC2c9sT8jd3H56HQMbJUf1hH/dQxV2fHZq7KnJLubS49U/E3gn
        0muYmBoA9OWEuIPLq927zOlSSK1KJmNd5w==
X-Google-Smtp-Source: APBJJlE/44Xe2sC05Lzvpj2tRArBipfQPmzsmlgMMUojFub3azhEFYdXQ9VQmxwUDHk5DaUJyHZxNQ==
X-Received: by 2002:a81:4e08:0:b0:583:3c7e:7749 with SMTP id c8-20020a814e08000000b005833c7e7749mr7913534ywb.41.1690234969425;
        Mon, 24 Jul 2023 14:42:49 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::3cbb])
        by smtp.gmail.com with ESMTPSA id x206-20020a8163d7000000b0056dfbc37d9fsm3118624ywb.50.2023.07.24.14.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 14:42:48 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 1/4] dt-bindings: interconnect: add SDM670 OSM L3 compatible
Date:   Mon, 24 Jul 2023 17:42:11 -0400
Message-ID: <20230724214209.208699-7-mailingradian@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724214209.208699-6-mailingradian@gmail.com>
References: <20230724214209.208699-6-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the compatible for the OSM L3 interconnect used in the Snapdragon
670.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 9d0a98d77ae9..21dae0b92819 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -21,6 +21,7 @@ properties:
           - enum:
               - qcom,sc7180-osm-l3
               - qcom,sc8180x-osm-l3
+              - qcom,sdm670-osm-l3
               - qcom,sdm845-osm-l3
               - qcom,sm6350-osm-l3
               - qcom,sm8150-osm-l3
-- 
2.41.0

