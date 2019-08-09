Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318F087985
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 14:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406717AbfHIMNe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 08:13:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38489 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406731AbfHIMNd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 08:13:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so91872194ljg.5
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2019 05:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9/m5+Lvxb2TAhFuurt0ORxYfrBK3bQPTy/lNoBXYuYY=;
        b=qp403boUGXWedc1L9So92iR1TKVoaZ+Li/QQNx+ELKQjcc7ccXWhNnr1RE881sB3PW
         c/ETqcZin8+fdJmg0gruZsRWFZqhTTfgUx/b6tKTTWUluB6i28C2tZdNIWNu+m1IwYD/
         W+4iVYtCZBkj8JXjIQZIyNZpB+ZK3xqHoABOjN2BWe5VlLdqFWLyAv0OhH/XIqtUjOFo
         HMYPqLdCTvyhxT2p5S2ZOr/tqttaWIFcVq+KD6VZb6jKjNXFk/xN2OuxjgqjuSrGv7fX
         3Bqj3WF3I93zF606ljMXz7Z3rfN6GWY6VvHVi+v1I37pu4msuMWZTIExnq4mzSZ4mfDx
         m7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/m5+Lvxb2TAhFuurt0ORxYfrBK3bQPTy/lNoBXYuYY=;
        b=t2OfBnuNWuVXBkia9LEti5BEEyZ3ik8gLNnYTzAIcrVOQo/GD598m7J7dOGWY9gmnx
         8ZHyaR1oBCK+Wg5PwIswOVMFpDc+ltRHJQGIAcZttfnKswckJKLIt64FI1tHjqetP2Lc
         JgtjKa8Jl8hiOfNH11HhZHYc44kHaP0H1PEHpBtIOjnpnnT36e4GvvbwCbVWYpPiFMEc
         fCEiaf6IW9JuBgSCVLBgbbXksi6SAUNaOXaD+Df7tiFfus54+4pYuOAKNIWz+GKGiVPS
         9UOY6B62JHf+NNhADO8tDHRXwH6YK4RaQoximTgBF777xgD1Gih5JYPe4WJ7GEpwTi7k
         5Rdw==
X-Gm-Message-State: APjAAAWm36sBAp64zJmedRa+NwY29sBbVsf6/TUxCiWOLF2fK1CD0osa
        SGJfIoAXxyXsuZk9u34AjYPK2QT+Vhg=
X-Google-Smtp-Source: APXvYqyZ9z7aZuPewm0m3QURUCbtSxS7l9qpfomeaDOrdWY3ycCmxVeHjtts6q5bl73+WCfAOqGTQQ==
X-Received: by 2002:a2e:55db:: with SMTP id g88mr2449978lje.27.1565352811117;
        Fri, 09 Aug 2019 05:13:31 -0700 (PDT)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id f23sm1083425lfc.25.2019.08.09.05.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Aug 2019 05:13:30 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, evgreen@chromium.org
Cc:     daidavid1@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        dianders@chromium.org, seansw@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v3 2/3] interconnect: Add pre_aggregate() callback
Date:   Fri,  9 Aug 2019 15:13:24 +0300
Message-Id: <20190809121325.8138-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809121325.8138-1-georgi.djakov@linaro.org>
References: <20190809121325.8138-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce an optional callback in interconnect provider drivers. It can be
used for implementing actions, that need to be executed before the actual
aggregation of the bandwidth requests has started.

The benefit of this for now is that it will significantly simplify the code
in provider drivers.

Suggested-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 3 +++
 include/linux/interconnect-provider.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 251354bb7fdc..7b971228df38 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -205,6 +205,9 @@ static int aggregate_requests(struct icc_node *node)
 	node->avg_bw = 0;
 	node->peak_bw = 0;
 
+	if (p->pre_aggregate)
+		p->pre_aggregate(node);
+
 	hlist_for_each_entry(r, &node->req_list, req_node)
 		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
 			     &node->avg_bw, &node->peak_bw);
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 4ee19fd41568..b16f9effa555 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -36,6 +36,8 @@ struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
  * @nodes: internal list of the interconnect provider nodes
  * @set: pointer to device specific set operation function
  * @aggregate: pointer to device specific aggregate operation function
+ * @pre_aggregate: pointer to device specific function that is called
+ *		   before the aggregation begins (optional)
  * @xlate: provider-specific callback for mapping nodes from phandle arguments
  * @dev: the device this interconnect provider belongs to
  * @users: count of active users
@@ -47,6 +49,7 @@ struct icc_provider {
 	int (*set)(struct icc_node *src, struct icc_node *dst);
 	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
 			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
+	void (*pre_aggregate)(struct icc_node *node);
 	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
