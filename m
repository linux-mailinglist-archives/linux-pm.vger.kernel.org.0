Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49835244ACD
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgHNNmd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Aug 2020 09:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgHNNma (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2020 09:42:30 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD60C061385;
        Fri, 14 Aug 2020 06:42:30 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id t10so9966286ejs.8;
        Fri, 14 Aug 2020 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bs0AcB7qbmfQNprig5SI2Kb6XQbYlIr4AXzloSOjX4=;
        b=aqZaWTjWfIK9QTifJNdS3EEbrKib8Tk9ULRvZ2JOg8nGjp/Ofc1mAPrEiN+89U3mnA
         hyGCMiPomiX3VgVxOTsCIBxn8Uozr6XEhVZVnWS8o8hQbMd00X8PbEEbPvAJSe+JxWdX
         Q+NKNZiwqWG5jTBUCGN4Q8wnutL9NThYDh1Vy2cMbuupz8Lmgl+Aw0ga5gy1Ns3bRACn
         qrhHAKI/9LBUSMsC6nv1wqRN2tDjpTEi2yHLZxqvoLBQ8MZ0KuUbx4Dm8xo6M/FCFdnO
         N+tIXT/jL3tQU4hHGE+GRvc/+M3RrDxTVYEOZlYOoHb6xT7qeK9GNSK7H8d82+97Ocd7
         TnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bs0AcB7qbmfQNprig5SI2Kb6XQbYlIr4AXzloSOjX4=;
        b=sjZYRrYIQBLAZeiXZR24rVPoKJjbJzJhDkmrh05WTwlxtasfnUWqIoMTMgZPnBOArO
         0SBhsoSACQm/K9Z6vnwACENCvOgyufMTcFL9kOgdrYXURMDl5uAk/fY1U9ZBCZrjKqKF
         qDKS4qwKiqUKaMheWXVy2rLNP3CdzUne8cZnte5SVI3eLQkziOXpmmY1uuVKH98z8WJP
         QiyUeZb5RA7dE/klUyIdizLOD/5ApGgTyfKN4wdo+gnu1Uh0pfvxWrTCPZv4I7r626xE
         AWA0GuNJmAZ/kUPx6iGzmTSHirGipabAJx1e/IBeQDPhewbo8hNql00S0UHiGzQHjKzy
         Nf8Q==
X-Gm-Message-State: AOAM531eLEvmWKe6HkUW5lOjVyEHAfNkccTj01Lo7Zdr225Q+uNnocUB
        O5xn90nk549Y+9mP2Oc6+/Q=
X-Google-Smtp-Source: ABdhPJyirA/O2w/YoO9JLlrGxROtlWU2Xa5iYgGRxnr64pnEqZMbI/JTXTpgXkhoKBlv7dvZC3UgvA==
X-Received: by 2002:a17:906:b294:: with SMTP id q20mr2376743ejz.223.1597412548969;
        Fri, 14 Aug 2020 06:42:28 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-0-192-118.retail.telecomitalia.it. [87.0.192.118])
        by smtp.googlemail.com with ESMTPSA id s2sm6767118ejd.17.2020.08.14.06.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 06:42:28 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 7/8] drivers: thermal: tsens: Add support for ipq8064-tsens
Date:   Fri, 14 Aug 2020 15:41:21 +0200
Message-Id: <20200814134123.14566-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814134123.14566-1-ansuelsmth@gmail.com>
References: <20200814134123.14566-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for tsens present in ipq806x SoCs based on generic msm8960
tsens driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 965c4799918a..d571a6ddd914 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -993,6 +993,9 @@ static SIMPLE_DEV_PM_OPS(tsens_pm_ops, tsens_suspend, tsens_resume);
 
 static const struct of_device_id tsens_table[] = {
 	{
+		.compatible = "qcom,ipq8064-tsens",
+		.data = &data_8960,
+	}, {
 		.compatible = "qcom,msm8916-tsens",
 		.data = &data_8916,
 	}, {
-- 
2.27.0

