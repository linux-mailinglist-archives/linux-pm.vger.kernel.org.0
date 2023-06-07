Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56740725FF6
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 14:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbjFGMr6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 08:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240754AbjFGMr2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 08:47:28 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C44F1FF9
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 05:47:15 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f505aace48so9204413e87.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2023 05:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142033; x=1688734033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b5Qrnd5i2zJnrU79sLpQmCBr/qGSSDn3CP8EHjD6U4=;
        b=XpdKTgk1cDCNQQWTJx9Ik39EP7iB/XP9x8fLotqVKs5E477dudxeo7Fsr2smRNd8+T
         xIYKUBjmq1dI7sWLCfrfhPLDSEoSUdIig2/ZWCafAOVvs9avBLCodWD/W6kc+9MNfo4Q
         p5FaAOor/pyoO4fd1HWKz1rMMRIQil0+8oNeVFXaoAgEDtgyj0xtVjDjfJjcuHf3BEvb
         nXZbmt3RkadgB8PHOSDl0q5p45JA+ZMqI+gSVLy9HwjIVlv+87yDk0vDIMsqkEQ+eD7E
         5bPMSpYlkZXG8tibzBW8nrKec3MR+meotBXU985AI1YPcZ1rZfzCt6yOoGM8axVAApmC
         0DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142033; x=1688734033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4b5Qrnd5i2zJnrU79sLpQmCBr/qGSSDn3CP8EHjD6U4=;
        b=D/r88lSxFwZjmM/1BumXGjTM+8a2hvQAUQg2CegT7pdsHReCuCOOCKODju5lbbzw/u
         4F9Uyv4cRdv1wGbEF7mkCiVCjZe44AVcIObMUsu7Nlpdi5F2tcmtddZV8rC4mTHfhkQA
         ZCLrzAlNY0LGLwNCFBSvA5EFzPOkRO5+nJf560xbI6gan4Us7QlGKQDx0fmFjuRWZSIh
         8SdZlKElj2NllypF3MDbn5x4rMKq3Y9ItXgRhHoZiYjpwse8RoNiDHWlBVFK302ybFeK
         KrIactOvh5uCSvl835aXcodGdJso60clxhEMO+YPYHWDzILnTU/vjAOgwbhQhWnsjMwz
         5Nsg==
X-Gm-Message-State: AC+VfDxopaMxn1X3eYieksxhRICqEw9wN15kD25SvBUS4EK4pIk4I+Bf
        3lqWB2LYdtsQczhwiRO4XND5aA==
X-Google-Smtp-Source: ACHHUZ45w/pMhCdOU/CVe1mplFe8QafWFzLTdhmjb+KE2CxVl3xwpMAAlcS0iGJO0TlLTV/h13ehaA==
X-Received: by 2002:a19:6756:0:b0:4f6:47a2:7bb4 with SMTP id e22-20020a196756000000b004f647a27bb4mr133291lfj.60.1686142033767;
        Wed, 07 Jun 2023 05:47:13 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:47:13 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/16] firmware: arm_scmi: Simplify error path in scmi_dvfs_device_opps_add()
Date:   Wed,  7 Jun 2023 14:46:26 +0200
Message-Id: <20230607124628.157465-15-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Let's simplify the code in scmi_dvfs_device_opps_add() by using
dev_pm_opp_remove_all_dynamic() in its error path.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/arm_scmi/perf.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 9c5340f590e4..03a496ccc603 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -585,23 +585,18 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 {
 	int idx, ret;
 	unsigned long freq;
-	struct scmi_opp *opp;
 	struct perf_dom_info *dom;
 	struct scmi_perf_info *pi = ph->get_priv(ph);
 
 	dom = pi->dom_info + domain;
 
-	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
-		freq = opp->perf * dom->mult_factor;
+	for (idx = 0; idx < dom->opp_count; idx++) {
+		freq = dom->opp[idx].perf * dom->mult_factor;
 
 		ret = dev_pm_opp_add(dev, freq, 0);
 		if (ret) {
 			dev_warn(dev, "failed to add opp %luHz\n", freq);
-
-			while (idx-- > 0) {
-				freq = (--opp)->perf * dom->mult_factor;
-				dev_pm_opp_remove(dev, freq);
-			}
+			dev_pm_opp_remove_all_dynamic(dev);
 			return ret;
 		}
 	}
-- 
2.34.1

