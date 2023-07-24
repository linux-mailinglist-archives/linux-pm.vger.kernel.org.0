Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BAF75F3C6
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jul 2023 12:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjGXKtb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jul 2023 06:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjGXKta (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2023 06:49:30 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D109FD
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2023 03:49:24 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b974031aeaso39565571fa.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Jul 2023 03:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690195762; x=1690800562;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DZNvYrVthLVnyT1vCTz76LDPSOhoYBXUv6sJqHcelaw=;
        b=YJTYZImmB9JueLr3bDE0VuBdRIzqjP7CeXNL00mQgdEmEjfrZgJZSIwhPXM2ig+kPB
         ZeAmZR62wrlMN9+EvEatTNKZ9alkGgugOrVcP2KiBkh1NOF/PXEXG7rjg7nXe/vHbusq
         bkjTe8pGg6fSR3lvsxz5FBLM5tEsUa0KdtSFAFMLg+6Hp7GfMK80NJ/QjCybeMqkL9Eo
         tw7YHUjTRxvhnMA2n6QKEqXDyBZxj5i2qRAVHoqei6vWc+UGgmC+kWaN/f1fSoSLWQqE
         2oyYE26f0FPbpZYHXun/O4Kt8yjBZP+icHWGjHbGSI37HSD79a7uUjXYwbYhHBVOJ+vf
         qipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690195762; x=1690800562;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZNvYrVthLVnyT1vCTz76LDPSOhoYBXUv6sJqHcelaw=;
        b=VH6I9WL0RMB4alAxLw5VT2mapCCddslox5/ljfhvPAkc/yOzhpTMnrpw81Ly2+uNAT
         raciGwoSt/GWnHvJ2BB48NYjAKFC72ZUxw69jdQBWEkQ2EyZCCf206+Un2L39gTZm0Os
         umYXuSrgMGO+3wR1Lnnt6MPWqc+dpWqEPTmsWJm2oVG3C2xja+9WMPDFHL1mt2HCybWl
         AUHi056fp6LcJZnoKe3H+YBWEZ7P/+lBNdaYvtUTtClyBg17+fCcb06KuBN+IXpSRVvy
         VT2595jf6TqVYUXPZGyRakpvVH+RzsRuRj3yGnax6TVS4CEBcylGfhnxdD6Iod0CvwAa
         vCRw==
X-Gm-Message-State: ABy/qLbErFKcIFaEn6Yp23sMKGmTk3TAm7/U5qH9VIeaZuHYyx4oOZXV
        IRm+4lTGtT5prfhnt/WRgoOqrjYBCvNrETM3WSLYsg==
X-Google-Smtp-Source: APBJJlFqc/fKryxe6UpKwyBjZRCiXffFBiaWUEf9MknSIxwWMEJd8TqWmfpO2ij4O28nimR0iZeBNA==
X-Received: by 2002:a05:6512:b97:b0:4fb:97e8:bc1c with SMTP id b23-20020a0565120b9700b004fb97e8bc1cmr6296392lfv.54.1690195762416;
        Mon, 24 Jul 2023 03:49:22 -0700 (PDT)
Received: from [192.168.1.101] (abyl203.neoplus.adsl.tpnet.pl. [83.9.31.203])
        by smtp.gmail.com with ESMTPSA id o14-20020ac2494e000000b004fdc7ec5cbesm2164201lfi.300.2023.07.24.03.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:49:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/2] QCM2290 icc fixes
Date:   Mon, 24 Jul 2023 12:49:20 +0200
Message-Id: <20230720-topic-qcm2290_icc-v2-0-a2ceb9d3e713@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADBXvmQC/32NQQ6CMBAAv0L2bE27BhFP/MMQU5YFNsEWWyQaw
 t+tPMDjTDKZFSIH4QjXbIXAi0TxLgEeMqDBup6VtIkBNZ50gVrNfhJST3oglvouRAqNaanEnJA
 vkLrGRlZNsI6GVLrXOCY5Be7kvY9udeJB4uzDZ/8u5mf/LRajtCq6c9EhY16SqUZxNvijDz3U2
 7Z9Ad38cZvIAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690195761; l=703;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=V5VLuysiELC1Er6lyMJIuGPFDavBvRd/ufRAXrK7W9o=;
 b=fwqrM0Qa9FnLzPux2jyipgO4M7jLpaHP1a4+DULTJ38WE9pzeHjAfsrjZeHx0iXIUKNC9UV+l
 pLCgziY+yHNAm2seXUTDE3cUOo/Ec+tAwSZN0mC2xANz+lCWAEsjdOA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series contains fixes necessary for icc to behave correctly on
QCM2290.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Clarify commit message in patch 2
- Link to v1: https://lore.kernel.org/r/20230720-topic-qcm2290_icc-v1-0-7f67f2e259c1@linaro.org

---
Konrad Dybcio (2):
      interconnect: qcom: qcm2290: Enable keep_alive on all buses
      interconnect: qcom: qcm2290: Enable sync state

 drivers/interconnect/qcom/qcm2290.c | 7 +++++++
 1 file changed, 7 insertions(+)
---
base-commit: c58c49dd89324b18a812762a2bfa5a0458e4f252
change-id: 20230720-topic-qcm2290_icc-211dc925c2e8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

