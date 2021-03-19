Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6601D3411B4
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 01:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhCSAxK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 20:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbhCSAxC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 20:53:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E1EC06174A;
        Thu, 18 Mar 2021 17:53:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l4so6898691ejc.10;
        Thu, 18 Mar 2021 17:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z09SdxQbYon303jwEPJnCBbmtQ7jFYsjkeWRJycNuHE=;
        b=NlAMVGa5F163FQ36h2ItKN9+BSqtVSK23vAXaoXgpLxiiu7alu/09Mfsw79b5QqX8d
         zLWrzZTW+s3yfA1SNe6lynuahIvzoTmIculqRjWBEpJlTBnCvMd9ZrXiZvKELac4vLWA
         L7ILrTHtJuZUNz80GvWPM8EuojVdIguEWs4WsMIFyA9GQLjbrtcu8G6s42ipvf1gTg07
         XJIbMUmjV3GuqJ6NklLvq7iCntoajAdMn2k7WyJmvUCq4FI98i3gd/TFFkyHt4p2ufP9
         qjM1yxVlF32/SjdpOBWnpF4pbXuLKHiTvwc96MjkOiopORmgLOe3KvUq1sQp2gGyCIBb
         J8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z09SdxQbYon303jwEPJnCBbmtQ7jFYsjkeWRJycNuHE=;
        b=YsAggfHOfJr0mZ+l5dExS5Ji6GnKiPG/kirFqVzEGAO+DYABC0J6fyNx9dggonoODJ
         z1f49f1J46wmFixeDGKhxYrj+97Fi1/i23b+yxPmyfzLi1HePFiJgUA+uD9TvurJydN5
         TiQLTRl1Tv4fsPW0RNedGFvT18p2PHzpwqk6frrclcxNxMugGBlS/oVPWWXcRSVlNKou
         rfYMsrAH1Qg/2qAJp9TfrY0sEi86nOiuZrktFbvhl9Yl3d9xqqytHhR1595+wNoQKxPD
         cCCA+6g7r6WhAT7RaxY1KbcflgrtL0a/hlHtsWputqXDguZQ4rMnUQxbBwSZwd8ai0RR
         ZsDA==
X-Gm-Message-State: AOAM532pPoISMBbwqEhA15iFKtQSLoUbuvx4n+aBFfPg6x+c6xr/G/7z
        rOpJaMPC1ltWP3sTTdcYw2mig6kiy7s=
X-Google-Smtp-Source: ABdhPJx5HKgwcm1Aa2tfroj/Wz3C9RuOYXA6qyjIQQeJuhQ0gvsxX7qbOcVwu57IbtyEK2tLUGDPag==
X-Received: by 2002:a17:906:7f01:: with SMTP id d1mr1527847ejr.136.1616115180942;
        Thu, 18 Mar 2021 17:53:00 -0700 (PDT)
Received: from Ansuel-xps.localdomain (host-95-233-52-6.retail.telecomitalia.it. [95.233.52.6])
        by smtp.googlemail.com with ESMTPSA id q25sm3186976edt.51.2021.03.18.17.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 17:53:00 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 8/9] drivers: thermal: tsens: Add support for ipq8064-tsens
Date:   Fri, 19 Mar 2021 01:52:26 +0100
Message-Id: <20210319005228.1250-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319005228.1250-1-ansuelsmth@gmail.com>
References: <20210319005228.1250-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for tsens present in ipq806x SoCs based on generic msm8960
tsens driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 44bce16217db..1fd634f8f5d2 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -964,6 +964,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8960,
+	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
 	}, {
-- 
2.30.2

