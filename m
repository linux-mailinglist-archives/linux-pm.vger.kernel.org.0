Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022B877962F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbjHKRfD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbjHKRfC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 13:35:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49FF30DC
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 10:35:00 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so3477122e87.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691775299; x=1692380099;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RX5NC2nxTvYUnTWlDYqv8Watm397qo1pPwODouKdZeU=;
        b=n2AdfiuGSPOrUZshS5L6EhAoX7KhSRu8eirE3rHEpFUO+L8XTWcQmdX2nSnHYdn8BK
         P388KjpCj1w+YouYIvt/LAyfxrGQlA8icB4fwV1Gu/ElLYZVGI69GhZ0FjB5soiHKNkc
         yW8ndMuyOnWW5sg5NqQXtFOtDZvkx41LeRmhcL6VdDyC3pCrwUXxdPLJIQ9us9RVepkG
         Jrk4ngtzJcDGmZ52i9kTGEPWl4P/dUxrurglnSiROUbN2MqAfGRvoiJgNNG9keDmb2zq
         pP7gaJWGHvLm8LXh3tWNxp110zypNKUiiP9beVRAq3zaV9mZFjPjuMZ4hseta+jgBI4j
         HRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775299; x=1692380099;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RX5NC2nxTvYUnTWlDYqv8Watm397qo1pPwODouKdZeU=;
        b=mGLW84RVLivBw/0ORECTigrIvGLkErm2xRKbvCh9GIJdvh6lvdno3U2xQJRarX7WB8
         hMy9r5Idj6L66ArGFtISynG7bJmXBuB/kr+CAo6QgUnNBDbihvewkDquES/apdXkHv4Z
         Pt5jh1pKSOlNdYHDNDlXAfMa5bC/2woE4t5txU78akendgEUjrMtbg2nZ6m5ofgTsVCI
         dsPPO7Apl8XBL9lpIt5vUdZM0YzAF0tpkOLqi6TrfBSMGOYxErt3JF1HT6Is0Gz4ZuaU
         xlzlrIwCcjPjfiwB8dB1utIRW8oYmAG2ABoOmFNgXVeo4elnfFslzzywqg/IJAcef4jv
         mfrg==
X-Gm-Message-State: AOJu0Ywv3Toh7LaY/z9HoDuRTAhwNXGFJFR8hk/BphCP1jpnhwexSWC9
        CDDl6UQ3hnxvx9M3JQsw+f19sw==
X-Google-Smtp-Source: AGHT+IGAmZThdwQAiS1xAl6Ltee2IuXD9l5d67D3lA5RqD/dFMFSzQ8veQsPqKbNAttfPh1OgJ6Mug==
X-Received: by 2002:ac2:4e08:0:b0:4fe:551:3d3c with SMTP id e8-20020ac24e08000000b004fe05513d3cmr2752264lfr.36.1691775299011;
        Fri, 11 Aug 2023 10:34:59 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id x19-20020ac25dd3000000b004f864690901sm807988lfq.244.2023.08.11.10.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:34:58 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 19:34:57 +0200
Subject: [PATCH] interconnect: qcom: sm8450: Enable sync_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-8450_syncstate-v1-1-69ae5552a18b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEBx1mQC/x2N0QrCMAwAf2Xk2UK71VH9FRFpY3SBkY2mijL27
 wYf7+C4DZQqk8K526DSm5UXMQiHDnDK8iTHd2PofT/4FIJry8roUjz6m34FteVGLo4FKQ0nHEM
 ES0tWcqVmwcliec2zybXSgz//1+W67z9VPzlTewAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691775297; l=934;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=VaX2xnItyuHn1L8/m740629cFVXUColklvClLG09CF4=;
 b=l6yDNcM4xcm9kewWLEvA4Y69bfr5vdEdkmT1lMXyxxpn1/08p5FcPl8gBizuoB1BVjUugxmpc
 ChDomTW/jouATC57md3HIXNlBfFPYfrctKu8AWW8dmwJW5v/qxiu+u7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable sync_state on sm8450 so that the interconnect votes actually mean
anything and aren't just pinned to INT_MAX.

Fixes: fafc114a468e ("interconnect: qcom: Add SM8450 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8450.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index 6ce413f7c10b..eb7e17df32ba 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1888,6 +1888,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8450",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 

---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230811-topic-8450_syncstate-46bce839c614

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

