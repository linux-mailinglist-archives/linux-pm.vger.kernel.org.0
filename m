Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA1669A959
	for <lists+linux-pm@lfdr.de>; Fri, 17 Feb 2023 11:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjBQKrN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Feb 2023 05:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjBQKrD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2023 05:47:03 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461E3644CE
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2023 02:46:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id u22so1242829lfu.5
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2023 02:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUZvSNJx+5CVUv1a1ome/kslg/vit8dOWhZX8VfXJjY=;
        b=EXsdWyi08Pn7WSIyxZUVREdsQR8UnirrYFke6f6W1etq8gPhRdj7ZgB4N7wIjtYzZT
         7rO+638bw8CSKKLWyVwDLbHVRdlkiZCXp0pIPfkoxg4ABM56NPG/DqIri8GLjMrwxXE6
         mxq7sRzyhPDfWE/L09Yj3zUq844ssUKqMguBGnB+ymP8VAUW55AEbNo5oyhZVhzk+bPm
         7B8nKUdMF11d7GZgf0zBRtU8Mp6vLYRPQFz6at5//qzcCIrJm7Gr/jckq8GaoyKsatca
         4HoSCZPWeKc6OOt9iKybUwE3Nto9K4MYWDqZ6SGXidgD9oX5sP/pzPE0dQdxepH0c5Jf
         Hqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUZvSNJx+5CVUv1a1ome/kslg/vit8dOWhZX8VfXJjY=;
        b=G+wMfqltSLUAdJBFw0NAKzRs16N9dmooA6nW8r2Y9Zq6LH7Ulwm7D/ZdYgVhLIltOK
         FHjVwzCmqBineXyZXlrC4yccfEoK7HCXV6BDIcU4Nz0NG0yc93nNIoNTbdbtwo+0ZQ/5
         Ew6LI5IyXpeNMlSY1YbuHCHeP0XOB2F6PKfyl508btgFmcAG0DVp8Kdogd2VvdNYXJzD
         sj6EyHtdSCRH2iT8PqHoxEKql+P2GsrvQPzRjTmM+Pr71aiHdQyfMgLWGW/4ubDdqNRp
         O0ipzWsh4yIb/wiaNMQFaXaKDYP5405ky26I2c0uXwm4Sdh305sL3sge3uSOZWu9I0Kq
         Zs6A==
X-Gm-Message-State: AO0yUKWavouhx5H1HCQ0U/b0x3Jv/cfr+X6cLHtr5u5XYCwdXHyX9uVo
        60+lxLlBL80EbT3kkcbpVkMGHA==
X-Google-Smtp-Source: AK7set/KOt4MODQVD/uWSLyLAfds7ypN1w2Qigdsvw/j3xllf/mfSjA/+3ShtHP8y1TfzcE+WNLUHg==
X-Received: by 2002:a19:550f:0:b0:4a4:7be4:9baf with SMTP id n15-20020a19550f000000b004a47be49bafmr131985lfe.59.1676630804528;
        Fri, 17 Feb 2023 02:46:44 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id c13-20020a05651221ad00b004b53eb60e3csm645940lft.256.2023.02.17.02.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:46:44 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 17 Feb 2023 11:46:30 +0100
Subject: [PATCH v5 09/10] interconnect: qcom: rpm: Don't use
 clk_get_optional for bus clocks anymore
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-icc-fixes-v5-v5-9-c9a550f9fdb9@linaro.org>
References: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
In-Reply-To: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676630791; l=1105;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=M6Z9fDv56JMA/vi+7eufxFCs9O0sn12I8qL5zKPdgGA=;
 b=4PU2DRlOt0EziTNs4oNm8eizsiGxce2VIGm7o4so4TLHPOOMLgZdmRPkufnOsNHyvGrwjURDmBk1
 n49XNf+UC2baBget3SKLWOJw2zcRPo9w1gGP7CZEdSEDgYWnk/WJ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit dd42ec8ea5b9 ("interconnect: qcom: rpm: Use _optional func for provider clocks")
relaxed the requirements around probing bus clocks. This was a decent
solution for making sure MSM8996 would still boot with old DTs, but
now that there's a proper fix in place that both old and new DTs
will be happy about, revert back to the safer variant of the
function.

Fixes: dd42ec8ea5b9 ("interconnect: qcom: rpm: Use _optional func for provider clocks")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 1b382a2f2710..7c2ed224d0e7 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -510,7 +510,7 @@ int qnoc_probe(struct platform_device *pdev)
 	}
 
 regmap_done:
-	ret = devm_clk_bulk_get_optional(dev, qp->num_bus_clks, qp->bus_clks);
+	ret = devm_clk_bulk_get(dev, qp->num_bus_clks, qp->bus_clks);
 	if (ret)
 		return ret;
 

-- 
2.39.1

