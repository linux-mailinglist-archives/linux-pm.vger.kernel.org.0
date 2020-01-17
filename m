Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66121140716
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 10:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAQJ6a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 04:58:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41808 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgAQJ62 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 04:58:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so22053752wrw.8
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 01:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=96TwPn9tZGUSDTaF/Oy40asyB7vDV/iwGB6pLp4mfFQ=;
        b=Wu8zTcz9k2Vpywvl31N0c25HBVn2qwXOqD+MWlsqko83KPs6S99De4fRi1hfH9F8TT
         Bg5GAmWjYud1pvlRTCQmmg2nHWybCYCtt0u8WW0WHk8rwJvl8LiDDa7JZ8IDcRORVEw3
         2wtW9ktAzWPuLhTC9wg4wsxYNJZ4lJMqrpdVhlWS365QBIt5lSmxFzCPYY3ew2eFr4pF
         zUcuQdWuHEqjjl0oFrXtTNXF7ZGD6DbBmaOEfE8ryP1K2/cuK94vwoX8VlgL+5iye5IJ
         3jgdn1lOCh62EdMU1CYcA5EuwBGMv9Fyhn7RbNbIIRnp3RRBvf5FpZKvi2Mx0KXUm1Pf
         asHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=96TwPn9tZGUSDTaF/Oy40asyB7vDV/iwGB6pLp4mfFQ=;
        b=jHGfLbVve47fEU6jjtJE7C23tu8Ta0V406EF2jpupwfDlLgz80doZuKQeqwx1BXHWG
         6qdL/z/lw9hmzPjKilDVooRkG9IH2ZRZ1EYKHItwwayVW/g3unbXjZgZoff99Ft4KolF
         Z4EBjt2raui6Ujv1BJr3twsL9xNKOj3g2sU2uENip8eeo+LicHNwmt97CXZvHK7bsZfX
         wrm6pVjOwbZWzN9TmdD1zq8tTIlqM1ijOJY3K66aEwqMkL9cDjHNEcIaJdjxeyuV0+3H
         s5u8MiCOo16SxTy4Te6YB6HYq2lPnBwcwN752d9Qpr29lOnR5IOL4q/CEsAZBd7zUf+9
         D9Gg==
X-Gm-Message-State: APjAAAW3I4qwUVvBgG9mtNnGRa8BNICciGOCzb4wOZON+ny/VmqFaTOx
        xBCGqj6bOTCB+9IlkUU1pB6xeg==
X-Google-Smtp-Source: APXvYqw7rr5TbFsnSWWKlT8WqTuoJZTg7S/XbonYjwnU/AiKmIx6JDxL6B5TNmuGTi3EbzX1aVC3HA==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr2278558wrr.116.1579255106666;
        Fri, 17 Jan 2020 01:58:26 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r62sm9967007wma.32.2020.01.17.01.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 01:58:26 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Brian Masney <masneyb@onstation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 06/12] interconnect: Add a common standard aggregate function
Date:   Fri, 17 Jan 2020 11:58:10 +0200
Message-Id: <20200117095816.23575-7-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently there is one very standard aggregation method that is used by
several drivers. Let's add this as a common function, so that drivers
could just point to it, instead of copy/pasting code.

Suggested-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Brian Masney <masneyb@onstation.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 10 ++++++++++
 include/linux/interconnect-provider.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index fbec2e4fdfeb..03625406c69f 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -221,6 +221,16 @@ static int apply_constraints(struct icc_path *path)
 	return ret;
 }
 
+int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(icc_std_aggregate);
+
 /* of_icc_xlate_onecell() - Translate function using a single index.
  * @spec: OF phandle args to map into an interconnect node.
  * @data: private data (pointer to struct icc_onecell_data)
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 31440c921216..0c494534b4d3 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -92,6 +92,8 @@ struct icc_node {
 
 #if IS_ENABLED(CONFIG_INTERCONNECT)
 
+int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 struct icc_node *icc_node_create(int id);
 void icc_node_destroy(int id);
 int icc_link_create(struct icc_node *node, const int dst_id);
@@ -104,6 +106,12 @@ int icc_provider_del(struct icc_provider *provider);
 
 #else
 
+static inline int icc_std_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	return -ENOTSUPP;
+}
+
 static inline struct icc_node *icc_node_create(int id)
 {
 	return ERR_PTR(-ENOTSUPP);
