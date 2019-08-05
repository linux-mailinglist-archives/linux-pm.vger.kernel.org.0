Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1EE82050
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 17:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfHEPdh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 11:33:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38734 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbfHEPdh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 11:33:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so79655924ljg.5
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdJeprxlisYG8Xt385Sz+mmujOJvqAOkUH6DNb4w/D8=;
        b=B2Lhpbtr1RQ+61200Fmk9bx9MyVKDvEMyZ7/Sucu6j8pxDoI6avpjSje0laQDjRMYV
         VF1coVJgpdXAY89hZ2klNoOHN5jbuSkKkEmziApzwKR9b0+4dGSYq+0pML4qwwRoUkeZ
         cQAC6UiilaOZXiDSN8vOKYohnFIEwxtIr8QoKrzI/QGeD0IDaiDyhjah1Bch2ZDfLW/B
         tzhY0eJNcGYZFAD2KDbPILqRB7p2tkqIWuIhpwgCn16/EarR3t/SwJoTY01wVUePos+h
         1gX+EYq+wSM41n4sorJgO18a39v/T/lkZscOxu1KTm6dHMly2jmTSyg21btav+M/Gj+I
         TfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdJeprxlisYG8Xt385Sz+mmujOJvqAOkUH6DNb4w/D8=;
        b=rajE+jgzlv1Okq/E/3C0/buYj3/rCCtKqoN6HZjuJnf3s1cddwn2SqZqbcY5JMPCxQ
         UjxHkRXLodXyFr9yzmEIPUhCEdnh3sBHjO8VpeesNTlBx6EcJJylaiM55vi/WjCFj8YZ
         Bj4AWQFCJP5igegc2l0SHG/DwAFnPh7YxqE2UPMIz5Cy8ze2z+3krqS/ROwo9hE26WwX
         HPvWMmyWYO3dZAP9pePCYlpiLLDYjy3zVs8bDp9SEW5RL382PCLhstuO22j5zeqR91ju
         z+jtUf9C/LZqj4bJWTA/jOtozp/lH0jQ7fe46kVfmid9HUk+o5IbNGyq3N7SINYf+BM5
         +DuQ==
X-Gm-Message-State: APjAAAXWTzbZylZ0gdZrc6G7EJ5ShDCs0wet62Y5qNDizbYiTWKhIzsK
        0iKEJ7KJFFpTQ3+w/4Pv8gwxnJTSaHY=
X-Google-Smtp-Source: APXvYqztjooZSce4zqpF9/gHXvgtQ0+44a+NSVLzEfRyM2p2N1elaBB8l4bVhR8hOcA4WY6jJHvlGw==
X-Received: by 2002:a2e:534a:: with SMTP id t10mr39316085ljd.109.1565019215224;
        Mon, 05 Aug 2019 08:33:35 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a15sm14969312lfl.44.2019.08.05.08.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Aug 2019 08:33:34 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org
Cc:     vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, dianders@chromium.org,
        seansw@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] interconnect: Add pre_aggregate() callback
Date:   Mon,  5 Aug 2019 18:33:32 +0300
Message-Id: <20190805153332.10047-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <752aca6f-4f69-301d-81ef-ff29bc25b614@linaro.org>
References: <752aca6f-4f69-301d-81ef-ff29bc25b614@linaro.org>
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
index 4ee19fd41568..fd42bd19302d 100644
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
+	int (*pre_aggregate)(struct icc_node *node);
 	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
