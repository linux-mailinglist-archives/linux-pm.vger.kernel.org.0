Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5B239B16
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2019 06:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfFHEoH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Jun 2019 00:44:07 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:44645 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbfFHEoF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jun 2019 00:44:05 -0400
Received: by mail-qt1-f202.google.com with SMTP id p15so3685626qti.11
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2019 21:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qdT885hM1gH99LBPR29/QhPlOeEng+ZQVjJx3w/T2/A=;
        b=u4I58YoPay1wIV0iUGWNilJCvSvIVXTL1/ci8b1Wjy1sm8vMfzaHLznZpwJzX//Rph
         ttgkgbKpAFClv5uX/X/41cZzhnEUO/g/rlcKS9fYx+PTRXpRCP8TNbRaD1DvJrF/j/y3
         tgmBde4zGp31x0CDivMs+UIvYHGUxOiEig9Fi7FlulgpoytiqiyJIEiVtvIe64im3Had
         Yx//ZCG2LVsaWnL+r4lFVQhbV8d1aLk8a+YaEyJEDHDBJVQnw5HRHSuyjKHtMPDm0p3z
         tVCiE/66D13o+CzXql9II+Xk/wQo1n2rezQTAgA1+3Up520E+RgpsscP7xPh9p4Gh7y8
         WXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qdT885hM1gH99LBPR29/QhPlOeEng+ZQVjJx3w/T2/A=;
        b=fWLeVShllA/pV9096+onFyEQipENgMuEUF87reAwP5H5p4w8kP2zGicTOF9McRdN5l
         4V3fcofgFzzFGDc0leMmvfBCSY9andytzYCKbBrvph12qo8jDiWMkfbMS4vBFWYAc0TA
         opiMBA+jhWOmjhNSUliOZW7lGFXYragBWaRESX7gOLmfWLqGPud/PasFvk8Oev7AZUlP
         1RL5B5VjTYLy926rz4JdjcOihW4bd6LL9joh8rrxKLyooUgAamcnS3mm7L4CTGEY4jv2
         rgfM/Tkh9a1Jqalsv7qHFgsAt59g57onWec+aMP+ReYs7JlOyMk1fyIsDFAByYmPO7ON
         gz1Q==
X-Gm-Message-State: APjAAAUa14Q6kxIXrwxC3tT5DSO1PgMo4e+aKXCsaEMIxaCxZ8tmxZ3v
        ZJB2SIwrHoYFSac1r3noJXVf7+zpQYB1Lhc=
X-Google-Smtp-Source: APXvYqwj1cOP4RzT//I83dw4bKyy7KpftJsqRPBOzjTNZla/XLUxIXycPdwubPfAFYw0aw/lx47k+naEi+2zJ1o=
X-Received: by 2002:a37:bd42:: with SMTP id n63mr47852920qkf.262.1559969044588;
 Fri, 07 Jun 2019 21:44:04 -0700 (PDT)
Date:   Fri,  7 Jun 2019 21:43:36 -0700
In-Reply-To: <20190608044339.115026-1-saravanak@google.com>
Message-Id: <20190608044339.115026-7-saravanak@google.com>
Mime-Version: 1.0
References: <20190608044339.115026-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v1 6/9] interconnect: Add OPP table support for interconnects
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Interconnect paths can have different performance points. Now that OPP
framework supports bandwidth OPP tables, add OPP table support for
interconnects.

Devices can use the interconnect-opp-table DT property to specify OPP
tables for interconnect paths. And the driver can obtain the OPP table for
an interconnect path by calling icc_get_opp_table().

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/interconnect/core.c  | 27 ++++++++++++++++++++++++++-
 include/linux/interconnect.h |  7 +++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 871eb4bc4efc..881bac80bc1e 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -47,6 +47,7 @@ struct icc_req {
  */
 struct icc_path {
 	size_t num_nodes;
+	struct opp_table *opp_table;
 	struct icc_req reqs[];
 };
 
@@ -313,7 +314,7 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 {
 	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
 	struct icc_node *src_node, *dst_node;
-	struct device_node *np = NULL;
+	struct device_node *np = NULL, *opp_node;
 	struct of_phandle_args src_args, dst_args;
 	int idx = 0;
 	int ret;
@@ -381,10 +382,34 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
 	mutex_unlock(&icc_lock);
 
+	opp_node = of_parse_phandle(np, "interconnect-opp-table", idx);
+	if (opp_node) {
+		path->opp_table = dev_pm_opp_of_find_table_from_node(opp_node);
+		of_node_put(opp_node);
+	}
+
+
 	return path;
 }
 EXPORT_SYMBOL_GPL(of_icc_get);
 
+/**
+ * icc_get_opp_table() - Get the OPP table that corresponds to a path
+ * @path: reference to the path returned by icc_get()
+ *
+ * This function will return the OPP table that corresponds to a path handle.
+ * If the interconnect API is disabled, NULL is returned and the consumer
+ * drivers will still build. Drivers are free to handle this specifically, but
+ * they don't have to.
+ *
+ * Return: opp_table pointer on success. NULL is returned when the API is
+ * disabled or the OPP table is missing.
+ */
+struct opp_table *icc_get_opp_table(struct icc_path *path)
+{
+	return path->opp_table;
+}
+
 /**
  * icc_set_bw() - set bandwidth constraints on an interconnect path
  * @path: reference to the path returned by icc_get()
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index dc25864755ba..0c0bc55f0e89 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -9,6 +9,7 @@
 
 #include <linux/mutex.h>
 #include <linux/types.h>
+#include <linux/pm_opp.h>
 
 /* macros for converting to icc units */
 #define Bps_to_icc(x)	((x) / 1000)
@@ -28,6 +29,7 @@ struct device;
 struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
 struct icc_path *of_icc_get(struct device *dev, const char *name);
+struct opp_table *icc_get_opp_table(struct icc_path *path);
 void icc_put(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 
@@ -49,6 +51,11 @@ static inline void icc_put(struct icc_path *path)
 {
 }
 
+static inline struct opp_table *icc_get_opp_table(struct icc_path *path)
+{
+	return NULL;
+}
+
 static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 {
 	return 0;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

