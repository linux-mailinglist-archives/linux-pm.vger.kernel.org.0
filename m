Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17B7216FCE9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 12:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgBZLEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 06:04:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40698 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgBZLE0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 06:04:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id r17so302852wrj.7
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2020 03:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZWhacWTD2BU+prP3lvYdDYqf9uP+69zqv/jCGbvIHQ=;
        b=doJwSQugq3/coKedt8Wa7bs4/CIxdyAgyKWZXlgH3F732ITadyuo9mwtZtN9iN7Xxk
         ouD/jvur1ugMssJTAkABgXfaaQAc+kkjTcmeR+4VIgSMJ7lm7KpW3qJAyzoaIHX8tdXn
         j+GcE+Y9tvVVSRIOd05WzcQ15Yz1vyWtqRStczTHxjk3RZlineVOfv0rbs2ZlHC1MECP
         y7F4/onFxzr29zSqd2ti9xyzPDj+DB44evaawsVYb5I91chI2plSm2Ms+Qn3lIgw6r5d
         VWxwMDn3DaJIsaF6rvP8XlnGOvfm20JI6LDx0tY1TjxnvsAbDr4rpCDeB/1A9RapMzXy
         MkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZWhacWTD2BU+prP3lvYdDYqf9uP+69zqv/jCGbvIHQ=;
        b=dLb/WtlSvYLtFL3CEkuLeK8E+43SBaRmvO73HxfzGISllqHjf3gpJHlg/k4qpxI8nH
         L3UcIBJ2mHS8To/rnKessPFbUn3d7CsdGXn/x75iYdm5YeG0W3hH3ucEwU0MRMfsx+39
         AmMhtRmDdaJMNTmd5wOPNJNw+ocffv3+sXFIdYhgcwRiElZK8Wj1TqC3NJJDd5JfQTzW
         wdABXQHRGRbcjFgAfpJZfay80UEJQbtAGB/sDeF5w91BHZ/xEfVmONCAel0udRYFJ6eO
         kLWDfGwmKOFSOLJ3gU3LyEgEOq5tbekcmVzVGMimQ/CzOCyRLh/jPEb2+UEd+c5JcNFv
         igNg==
X-Gm-Message-State: APjAAAXA0vVX3nR3OExDlheIwFj34bSyTDYbCjFmD30XN3PxkRf2WQXg
        lQ7CN9TpUUYOqT/xJDwW4zmF1g==
X-Google-Smtp-Source: APXvYqyqpti78NZcTmxqOnL4JZBCBc9Xn3/oAwt4rD8e9V35Fnrl5tR8epuHHz7KrYeTIUdHjf+f+Q==
X-Received: by 2002:adf:bbcf:: with SMTP id z15mr5018995wrg.266.1582715063018;
        Wed, 26 Feb 2020 03:04:23 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h205sm2448176wmf.25.2020.02.26.03.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 03:04:22 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 1/1] interconnect: Handle memory allocation errors
Date:   Wed, 26 Feb 2020 13:04:20 +0200
Message-Id: <20200226110420.5357-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200226110420.5357-1-georgi.djakov@linaro.org>
References: <20200226110420.5357-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When we allocate memory, kasprintf() can fail and we must check its
return value.

Fixes: 05309830e1f8 ("interconnect: Add a name to struct icc_path")
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index f277e467156f..2c6515e3ecf1 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -445,6 +445,11 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 		path->name = kasprintf(GFP_KERNEL, "%s-%s",
 				       src_node->name, dst_node->name);
 
+	if (!path->name) {
+		kfree(path);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	return path;
 }
 EXPORT_SYMBOL_GPL(of_icc_get);
@@ -579,6 +584,10 @@ struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
 	}
 
 	path->name = kasprintf(GFP_KERNEL, "%s-%s", src->name, dst->name);
+	if (!path->name) {
+		kfree(path);
+		path = ERR_PTR(-ENOMEM);
+	}
 out:
 	mutex_unlock(&icc_lock);
 	return path;
