Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5B621BE03
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 21:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgGJTqj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 15:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgGJTqK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 15:46:10 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA14C08C5DD;
        Fri, 10 Jul 2020 12:46:10 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id by13so5512438edb.11;
        Fri, 10 Jul 2020 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7hfnd49qzQu+v3pW4+QTWy4zDs6kHByKCCdtVpj2B8=;
        b=UN7Gn4uPQtMnfHppgaJpBhNkiEB9r7978G3WIOnisLXwrh2OI9cn0BCtUqf1MPwZVY
         W2ZJhJmz2/t842wvrC1Jhh1tusoJ5T8+hffg2jWdu+jG4pSdsmJ6vN5kJQTE8OsGz8hq
         2jPSCCNk5NziX1RpxRuwApyp5Hjfhl6pjGAxGswNZO7WmH6pQnYgP2iD28RlrSVNMmvv
         fjErgvT8SBbvPO2YdmtXeYgIvVQsEVzur9GXwGZeZdijnTZI+eFOZW5rQBepuqlw80pj
         XT+1icbJI2CMn155prTr+XDtVeRsyDWmi78OBlqjGCBdLZ9yk5rE8QqAAOmd9C4B2qUx
         2sMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7hfnd49qzQu+v3pW4+QTWy4zDs6kHByKCCdtVpj2B8=;
        b=guyEsEUiJhmYPhXjqS6YezBLnaYZ0OPE0eP8HuuI5z3yLcXgoR8NAUFl7dFd3tFLm+
         qPc61xscULmTErOt8Yaaj5/10PrJ0skxPNqBVI6cYYPPZJ+POuGKhsHnzaiOjOXwBki2
         Nn2V1KMUDgUb1//6zdVRsdOhtm6KAifLjp3duaGpZD2FtlwMU/OKW4G54JMCM+tHv4QJ
         PhWoSeF2LlNineVeETFfo8eqVmZrC8ZEImvKiVI67+ZlBRmkIpOBu7V7oJUTJF+BjvGj
         TdfNo3IoVAUOOQ8dIpKhIH29x3TiAjuH2zb9tzqKB08By2hk6++q8J6+6qBVVQCUGC0B
         cSFw==
X-Gm-Message-State: AOAM533QTsOb3Xj1KCyv6ukkj1PrCe0es3oH7tFWYtYzly/f8mdIhyaa
        bATBehaXjEBqqJTu6ifNHrs=
X-Google-Smtp-Source: ABdhPJykPK6hXQIbX7d3fld79E3i/oUJKENzcBCVYhZYKx1YdcxH769O2NWFAYLrpNr/TrdEOTIbWA==
X-Received: by 2002:a05:6402:134e:: with SMTP id y14mr79734387edw.4.1594410369165;
        Fri, 10 Jul 2020 12:46:09 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-16-250-164.retail.telecomitalia.it. [87.16.250.164])
        by smtp.googlemail.com with ESMTPSA id kt4sm4155768ejb.48.2020.07.10.12.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:46:08 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] drivers: thermal: tsens: add ipq8064 support
Date:   Fri, 10 Jul 2020 21:45:53 +0200
Message-Id: <20200710194558.26487-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710194558.26487-1-ansuelsmth@gmail.com>
References: <20200710194558.26487-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ipq8064 SoCs based use the same 8960 driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 39c4462e38f6..2985a064a0d1 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -907,6 +907,9 @@ static const struct of_device_id tsens_table[] = {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
 	}, {
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8060,
+	} {
 		.compatible = "qcom,tsens-v1",
 		.data = &data_tsens_v1,
 	}, {
-- 
2.27.0

