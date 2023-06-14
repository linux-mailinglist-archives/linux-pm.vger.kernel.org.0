Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8A272FAB9
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 12:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjFNKYR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 06:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243917AbjFNKXR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 06:23:17 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2330F2708
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 03:22:49 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b1a7e31dcaso6629661fa.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 03:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738168; x=1689330168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOpw2IzeZp9GbeAF9i4mXNIR6mQ3JCYKPGrp1TSgTDI=;
        b=eHCOR6hzSYU8UU2gztT85J9Tb69J8P2nLKb9Qvb+8qBQMwSPQu6PEBsQeV5kXAn5TL
         qsBMW9TYYz9P4ne8jCLWNft0/sJb84eHAcPTvJuHD+njPZ6rF//kMamdfWcpjJ/aIWyi
         lhawKhRw6aBnv0gOWv/LEy5XO2siRy2T1g79rEw4ccnGjolcOlwupk4YsBf+EUCLJ3Dh
         xqxDMOZOYa+lYyLdoAxoQaEnK1KQ76mbMGfw45wRRYuhLxSY0aUpKnivYtQQfszJVRBp
         SVRdlAwtkFxV81ZKMJ9f2ZWTSm1Y0z13PVVRtideUfs9M83qImWnLTIWisSaMQDNw6BV
         4A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738168; x=1689330168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOpw2IzeZp9GbeAF9i4mXNIR6mQ3JCYKPGrp1TSgTDI=;
        b=QZC7tLMFT+zhyxwSZXp2y40QGSOwe7XSFGnityDoZ0z+NLqsWqnDahaxL7FQ/lMIl6
         B7eLD2/ks8LGlHpmEEdsZru4294DIYaCmBY2SLJtY7nMDHmkhvdkCvm79ADOMT/d0Yyq
         BIrXVO7g9YyfrZhhtau6hNUxmGQdoKVw/b6dyah3GTmgCKLjgmVEG1ezmUfET7I4EqpZ
         OnVkcI8LObedLdZOC5nGMdg4TZGmo2i0+Xc+uyjj1Td5auoR1O4kD9fokfW6q9PxsrCG
         BkU8d/LPzU43RlvhwU2NH3znxphaDOkQDyl5fAaY7PKqbzwokrLoD4ZUaDLNhCpsT9wM
         f78A==
X-Gm-Message-State: AC+VfDyMLY2JkLrory1k+s/XHKvv2QEVGIaA5t70No3l1ShUO/YAwrCF
        IdIvaR4lHxWEjcfvBQvQdAKroQ==
X-Google-Smtp-Source: ACHHUZ7fz5i7fWkj/w57LPjiM79ykm2PmyTeXR5HA8EE88LRd9FjGQK9GGwiGm4UDMoU7PeuVOMgBg==
X-Received: by 2002:a2e:a0d5:0:b0:2b1:c613:4b9d with SMTP id f21-20020a2ea0d5000000b002b1c6134b9dmr6454119ljm.4.1686738168154;
        Wed, 14 Jun 2023 03:22:48 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m2-20020a2eb6c2000000b002b20d8f270asm2520057ljo.74.2023.06.14.03.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:22:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 12:22:32 +0200
Subject: [PATCH v5 21/22] interconnect: qcom: icc-rpm: Set correct
 bandwidth through RPM bw req
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v5-21-eeaa09d0082e@linaro.org>
References: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686738135; l=1241;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vbgdPgoiD5DDzK4NJIK0hWqpG4fjAPJzqNg66olLHCY=;
 b=58+MSd6PMq1BtrHQgOJe1yKmACBl6ymycWRhzUgp7vYoBm12Pv2ILP8x+CYs9Q++pJtIJ0bU+
 WZspeQMlXUaCSkpbREVmWrmQDmFLTxWeXBJOZV5fqh+wO/YSBylW2WV
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, we're setting the aggregated-on-provider bandwidth on each
node, individually. That is of course incorrect and results in far too
high votes. Use the correct values to ensure we're not wasting power.

Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
Reported-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index ac84fe0bc852..b7e0dfbdd26d 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -355,12 +355,12 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 
 	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
 
-	ret = qcom_icc_rpm_set(src_qn, agg_avg);
+	ret = qcom_icc_rpm_set(src_qn, src_qn->sum_avg);
 	if (ret)
 		return ret;
 
 	if (dst_qn) {
-		ret = qcom_icc_rpm_set(dst_qn, agg_avg);
+		ret = qcom_icc_rpm_set(dst_qn, dst_qn->sum_avg);
 		if (ret)
 			return ret;
 	}

-- 
2.41.0

