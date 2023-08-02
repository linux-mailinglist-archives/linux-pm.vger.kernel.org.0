Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D9F76D096
	for <lists+linux-pm@lfdr.de>; Wed,  2 Aug 2023 16:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjHBOuI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Aug 2023 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbjHBOuG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2023 10:50:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD04196
        for <linux-pm@vger.kernel.org>; Wed,  2 Aug 2023 07:50:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1d9a8ec6so6672625e9.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Aug 2023 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690987803; x=1691592603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+m04PdzXiQtuh5WJn8M+ftKQwW8UzOG5dvhfD0CJvU=;
        b=ZLBkTF98A4H9YK/hVFrxVvlLc5lKvCR3tZHuNxuJz3cALyNTCcS7E3bP/F5KSs+YG+
         1eiHq/Tpgy8vs8PIuHQocH9El3UrNUWYPmme3V9taYDYW/qbKWftb5d4RbJXc9lVyDRI
         c5wDX+JiZbfMam4SeD3PEjOoNPsDJJh8RLGPv1QihNI2qFj7x7ophNpdPGyhCMlwiTHp
         YoUJ2MnS7ILrRC942xOZNwhTLimJiNJ3T2u+bbhU+dF5/F10bz2t1wtvQMAt9wbQ5LZc
         I6z2Zd92g0jnLmFx5RXz9cZ532Fuy8N3JTr4FDlacZ7ibShqmI7TUlldLFWUCnbwUBmm
         nDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690987803; x=1691592603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+m04PdzXiQtuh5WJn8M+ftKQwW8UzOG5dvhfD0CJvU=;
        b=ik7bK3llh/mZM6x9YG88GGaUS5peMBlEvE8BI+Uqd5J4ZCwCOB5dDYzu4p8a0QzvD+
         QdlZgLV3W/KvzsA9bbHFnVHvB5rRgg75eu3bFw8AkiB6d0qdFoW9eIGDrJzcal81Cdh+
         K8TgdCemoztEuwbAWSFYUqVaN6hw2veusWUkW7mvpyWKx+BKEqIKYtVvh4GAGNjp98GM
         Ap9Pf/nRw0mgBqztWfUJntWguEO1lvj4riLmfteN1AojS238P+RB3q4brtVTnAQSdS2k
         MNEGbks7cnDakFAhbLjQ0yAi7I6KoAsk2OPS3Ul1vBj3lNJBwCVcgbIDarINJuoyFrft
         AYSw==
X-Gm-Message-State: ABy/qLZgdAHkL7XBIjL+YY0RHC15D+fY4WizQhtcc+NitjwxiLXAqFMJ
        92pyT3yJRboSmUiQR+BFFAWbdQ==
X-Google-Smtp-Source: APBJJlE2wPXiYQ+0gkWhrzGHFnE+KfBuDB7r8sjzI/Datz8SVNXcjAKj6WNgazUonfskRyL8IDB+tQ==
X-Received: by 2002:adf:e752:0:b0:314:423c:95a3 with SMTP id c18-20020adfe752000000b00314423c95a3mr5107091wrn.9.1690987803499;
        Wed, 02 Aug 2023 07:50:03 -0700 (PDT)
Received: from lion.connolly.tech (host-92-17-103-66.as13285.net. [92.17.103.66])
        by smtp.gmail.com with ESMTPSA id a1-20020a056000050100b003141f96ed36sm19371033wrf.0.2023.08.02.07.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 07:50:03 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
Date:   Wed, 02 Aug 2023 15:49:29 +0100
Subject: [PATCH 2/2] power: supply: qcom_pmi8998_charger: fix charger
 status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-pmi8998-charger-fixes-v1-2-a8f1e8b84c1e@linaro.org>
References: <20230802-pmi8998-charger-fixes-v1-0-a8f1e8b84c1e@linaro.org>
In-Reply-To: <20230802-pmi8998-charger-fixes-v1-0-a8f1e8b84c1e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=996;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=p5XueRdNouZez7x5IuOUY6Xd5perVKgBWAuqhh8dWx0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhpRTuZIWU/ct3nj6tqWJwiTWWRcOlnXu7T33na/l8fcv0
 6awiy5b0FHKwiDIwSArpsgifmKZZdPay/Ya2xdcgJnDygQyhIGLUwAmsugqw3+P144+Bc5in8Sf
 tSTkbNe36MlS8bi3ZOYS9UUJl/IEW9kZ/unNNJjqbOz/vG1VT9Wtvz9qV7WencDfeejA3i6Pokv
 3Pm4BAA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The INHIBIT_CHARGE status bit means the battery has reached a
pre-programmed charge limit which is some voltage offset below the
target float voltage. This should be reported as a STATUS_FULL rather
than UNKNOWN, fix it.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/supply/qcom_pmi8998_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
index 61be835f4106..a0d76f4f7054 100644
--- a/drivers/power/supply/qcom_pmi8998_charger.c
+++ b/drivers/power/supply/qcom_pmi8998_charger.c
@@ -517,9 +517,9 @@ static int smb2_get_prop_status(struct smb2_chip *chip, int *val)
 		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		return rc;
 	case TERMINATE_CHARGE:
+	case INHIBIT_CHARGE:
 		*val = POWER_SUPPLY_STATUS_FULL;
 		return rc;
-	case INHIBIT_CHARGE:
 	default:
 		*val = POWER_SUPPLY_STATUS_UNKNOWN;
 		return rc;

-- 
2.41.0

