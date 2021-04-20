Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B87365F6A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 20:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhDTSe6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 14:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhDTSes (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 14:34:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C89C06174A;
        Tue, 20 Apr 2021 11:34:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id x12so38993501ejc.1;
        Tue, 20 Apr 2021 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZpY6oHW5Nc4qUZgqqVYnVsBY3HZDhln/426SoLXgZU=;
        b=us7oHf9xkBwsTctKUnEsSJQnNKxA4FgW3e03Dw0jTCia+lBIeSBZ8aL84481Shyi0a
         uWEoJCVcS2rWzffBLR7rucAwoZYN/Z2SQUCxZnP/E+JAlQZAji6fu0dcxXgpc9n0eJJA
         3yeCqrsWOX1yT1JORnx9Jw36/KNmUDdunWElp0tGRtDKTTl3OvbvaBx+oxyZcTu/u+WH
         ZfSVFeUQ9lwsyJTjXiMxfwRZ8RJ6GjA8i4ZJ5Bv1o6zljmSHiMesXHmeZ/jXkiBhkLbW
         SbajFfZr6zLalBSIqrSI9MGxOMC4X2HiRK/jwTNdeRZCajq1JaUeQq/z2+8PDFAyZRvP
         rRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZpY6oHW5Nc4qUZgqqVYnVsBY3HZDhln/426SoLXgZU=;
        b=sn6z4eo+2QlqFv1Tv0la+xlRvkQ5zlBtzqdLvzW/sbHq4NX4SNyZKhmGnXWMWcrQL2
         KVNSEwD+NQ7ngxRQ09tNQjuII85KScTK4hl5SGa2XG2n2qxCmdtaTDphAVH4v0JSD+RT
         rWe+y5V2JxmyqK+fCDmWzye7ZA2jUWAnkYTus3e/1oNhzJWAgLbDK+R0zhD6IJmyQsGD
         XBggvPk9KIbMXup4ItOMmImqD8FWmc1y+l3vUNs8vy5mogNPAWRLAvzn7HT9+m/zpIPZ
         U5QkgQrCDL5d6S3wy0BtcLBnWUrA4OMgvf2fEaPhpc8ljx3dfWTxLSgd8vdN03uoKvGg
         UOYA==
X-Gm-Message-State: AOAM532qdAMeSH7rOxo2s9sfNvsE3qU/D03ikpb4VusERAjXkzo/eckN
        M3GcKO4SCoQVfO1p0TH45/4=
X-Google-Smtp-Source: ABdhPJwN+kQyM51zG2KVPFbcCG7ojJsD6UdCM8qgkqeQmUSNkidiyhp0MbUAglmIp96UyNVlVVLOVA==
X-Received: by 2002:a17:906:5487:: with SMTP id r7mr29114732ejo.550.1618943653447;
        Tue, 20 Apr 2021 11:34:13 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id n10sm13357141ejg.124.2021.04.20.11.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:34:13 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [thermal PATCH v15 8/9] drivers: thermal: tsens: Add support for ipq8064-tsens
Date:   Tue, 20 Apr 2021 20:33:42 +0200
Message-Id: <20210420183343.2272-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420183343.2272-1-ansuelsmth@gmail.com>
References: <20210420183343.2272-1-ansuelsmth@gmail.com>
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
index be0c5931f..56b505f35 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -966,6 +966,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
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

