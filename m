Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6587E30DFCF
	for <lists+linux-pm@lfdr.de>; Wed,  3 Feb 2021 17:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbhBCQf1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Feb 2021 11:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbhBCQfW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2021 11:35:22 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39E7C06178B
        for <linux-pm@vger.kernel.org>; Wed,  3 Feb 2021 08:34:36 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b8so139452plh.12
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2021 08:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tDdfcsBZJuJtkpBOSJDEI0wgJxTXViUcOD8MHou6QmE=;
        b=VXtxZbi8AtZyMZJpc50pEvpcML6zaCXy49jNoMowkU5wXzOsZgefVdUPQHgGHCEr3B
         VX/+A3V9YXOgufIR6vLDsozEfwkoAZ/C1d88U1v/Wkhpp93O57e5bVOJgh4lDGnRF7W+
         6IRdn4Htmw5yyWbTH2IP++5A1kQzyq0CkCkuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tDdfcsBZJuJtkpBOSJDEI0wgJxTXViUcOD8MHou6QmE=;
        b=jlkelF3szDoqvYJZ5X8oQhljodPCbn0CHF9UqOBduf+oOdo2YbsIzlCwCDbdcDNSKd
         XU9icj5glp4FeXoso5n4RPHAhWv1TKqHiNuyxEwZnlVFtdxozm1L32vvITt9OwkAgIHi
         mZG+63lktcOlkID1QrmpOYDLXBESJ6SRAhcbVbttDz+8BYPdek9jyYbItmDqvGH4r9n8
         tor5AY2/5Z6jVpww1c5KsZQ7Hn7We77KiFn5Dtf48a8LmLwRrMJ1MogXxberDekkNn6j
         pXcuV26zm2Nz3iZw48+vDk0UfsZtoCJBiliyoueiYgRfRrJNDViTTOIwk1r/Hx1zvIFt
         Tsjg==
X-Gm-Message-State: AOAM531jd/QUTxIvU6b6IfvJtX7xpJSQib5UuJTJsZG2byF61F0ss4wC
        AvQw/YsjYZyEheEJwidJTIV73w==
X-Google-Smtp-Source: ABdhPJwHW/bPgjpIW8uXFOPagPYKISILCxeoo1NzldsvLxwfQdCWM66jZLnLeBPCfTIPz2JEdYXQHQ==
X-Received: by 2002:a17:90b:4acd:: with SMTP id mh13mr3913378pjb.229.1612370076555;
        Wed, 03 Feb 2021 08:34:36 -0800 (PST)
Received: from localhost (162-207-206-139.lightspeed.sntcca.sbcglobal.net. [162.207.206.139])
        by smtp.gmail.com with ESMTPSA id y6sm2754285pfn.123.2021.02.03.08.34.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 08:34:35 -0800 (PST)
From:   Benjamin Li <benl@squareup.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     square@linaro.org, kernel@squareup.com,
        Benjamin Li <benl@squareup.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] interconnect: qcom: icc-rpm: record slave RPM id in error log
Date:   Wed,  3 Feb 2021 08:34:06 -0800
Message-Id: <20210203163407.9222-2-benl@squareup.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203163407.9222-1-benl@squareup.com>
References: <20210203163407.9222-1-benl@squareup.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add slave RPM ID to assist with identifying incorrect RPM config.

Signed-off-by: Benjamin Li <benl@squareup.com>
---
 drivers/interconnect/qcom/icc-rpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index cc6095492cbe..54de49ca7808 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -59,8 +59,8 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 					    qn->slv_rpm_id,
 					    sum_bw);
 		if (ret) {
-			pr_err("qcom_icc_rpm_smd_send slv error %d\n",
-			       ret);
+			pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
+			       qn->slv_rpm_id, ret);
 			return ret;
 		}
 	}
-- 
2.17.1

