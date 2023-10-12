Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDF97C69D7
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 11:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjJLJlU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 05:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbjJLJlT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 05:41:19 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE43291
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 02:41:17 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c131ddfc95so9783211fa.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 02:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697103676; x=1697708476; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9Ha1tPoh6dVTvqYgTNLLl69UYatye7Ch50vBppvcQw=;
        b=JbWIv1g0Tn+3K0Xbkoi7GjbG/lR5KSDYwXkMitrkcwMFLukuWJplaRYeEGYBuQyjWa
         D0umqMEgMDeAJuLCAv0NhARqQ8HO/hRHeiNFG6Y1VRPFtZlcueJMMOhQ/BIYmQrFsvMn
         cg6y8vD4++ukECKrEjCYwZaxiWGkBAPIzX42A9KNUO69rHi6oL3sRtFOxGa14WV+q2Ic
         erSlUBT9l9Q7T90fhBCQz4btXQR9A1EydNaM35tGQC3W/ac2ax3+eGD5vTHakDc9Ehlt
         cw2ij2XBrEd87WOZDlsANIlFtxnPGNAq1ok8ujMMPXYvtEYWKfVWgS3fSdaplnRev2au
         nOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697103676; x=1697708476;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9Ha1tPoh6dVTvqYgTNLLl69UYatye7Ch50vBppvcQw=;
        b=KCRt8lKOIPpnQcQFdYyIAPtXvqxYmE0HVLpuVnjVmw6dup0Xhc4e6AUHl/8XotgAjR
         R7VFbl1arGFT7fKG2r6AJ19RtstJ0w1P9Ibvs6J8OacaHct+9cGATxA+jxajsZMza0B6
         PEI86oVemL2d1CD0/FTD358BpxrJv60IPX52+hDAgEbpbXDriZhnHvw2HOBLOBehZHLR
         yFltIvMa623QRGv9ENOjjzDQ+l6+y9edC56HkZ2PG3SAHjob78OuCI7N4eOA+5QQv393
         dmVGAnJt9/kWSHenEfnmXgTfpHXKXyD3oep5Nr+EXJ01ooTDZ+w9uDG23B56gq3Yuaph
         9bCQ==
X-Gm-Message-State: AOJu0YzenTl+TyqjHv0/zQ4c0Z5zuWc9LA67rnD+NlM7X/T/MQRPTpyX
        zQZrUs12GexttCarDAcjHQSkDQ==
X-Google-Smtp-Source: AGHT+IEaL1Aj5cIMJu9KIjuRu/rF5MoFIOwR2MxjF+RWVDhV2KmCzFNegrVLqtcs2W2wfLtFgVf2RA==
X-Received: by 2002:a05:6512:3d15:b0:505:6ede:20a8 with SMTP id d21-20020a0565123d1500b005056ede20a8mr26060481lfv.42.1697103675962;
        Thu, 12 Oct 2023 02:41:15 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q5-20020a7bce85000000b0040596352951sm21495929wmj.5.2023.10.12.02.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:41:15 -0700 (PDT)
Date:   Thu, 12 Oct 2023 12:41:12 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Mark Tseng <chun-jen.tseng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] PM / devfreq: mediatek: unlock on error in
 mtk_ccifreq_target()
Message-ID: <1bada9b2-d276-4123-bfdf-03d165569543@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Call mutex_unlock(&drv->reg_lock) before returning the error code.

Fixes: d2805601988f ("PM / devfreq: mediatek: protect oop in critical session")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/devfreq/mtk-cci-devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
index b0ed25e33f2b..11bc3d03494c 100644
--- a/drivers/devfreq/mtk-cci-devfreq.c
+++ b/drivers/devfreq/mtk-cci-devfreq.c
@@ -146,7 +146,8 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
 	opp = devfreq_recommended_opp(dev, &opp_rate, 1);
 	if (IS_ERR(opp)) {
 		dev_err(dev, "failed to find opp for freq: %ld\n", opp_rate);
-		return PTR_ERR(opp);
+		ret = PTR_ERR(opp);
+		goto out_unlock;
 	}
 
 	voltage = dev_pm_opp_get_voltage(opp);
-- 
2.39.2

