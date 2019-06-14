Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E18F45345
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 06:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfFNERs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 00:17:48 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:57237 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfFNERs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 00:17:48 -0400
Received: by mail-qk1-f202.google.com with SMTP id j128so976564qkd.23
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 21:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SJIMb+Ux62XaD1zvTN7sgB8J991Gr80Gygm6D6H4n5w=;
        b=hghN2IFdVV5jQWGPzPZfj8N0Ul84C8eBuXKbdeQmfXQzCGBY5ZqbUuqpImEdmhWmIo
         9qOU//XwKxDBz8ELfcENjG8S6e3Ef6obgwIFjcQgIaBIbwIV0iUk4hQVUaxc1E0RPs6j
         4B9xobeLA/t4xbUsX/xYRsjJB8sXtHhWHikl9LulTCv4m1ziaHGzx7wSNqwwdsMQVOsn
         j/b1oMDv0cECZqjkMZPJEigAkUMZOeXATrxQNeFFMVyFcRcHLLw8tE9H0sS3z62rtfxV
         uZcH/amHURKnUuYj0dXECYNQ4NhskYS+atKwxbBeRUvUo72AlN2cAxa/+7QeaY1t/7NI
         aiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SJIMb+Ux62XaD1zvTN7sgB8J991Gr80Gygm6D6H4n5w=;
        b=TJ3HK4KCWWScV25XLzwMmgMKOJU2car/+oLL7hcMj92R7ndAG0J32dIFM/bfnALz+2
         PhUOQfBlZet51iYO3GjF01u6bsAKY3ID+rfsAybGOymz7//i3qZZt4WsVsiJUkiYFuxb
         fPx8bAHv+Ti5VBQwcDE5fIRiR6J3K3bwRvYQqh2ZeTiYbbJjlTbaV1wzTy+On+ewnuiv
         qMBgWX/E7z089xZkg69k+5g65c/srAWQUvmp0Vwlzjs8fMa+fv8EqnLiZhl3ODUSO9UN
         wSPY5Dq8qAL/47rYIgSN97bm5wB7UC46RbaQUQLxljiTiu1SpgK47yhfZDtM1y3jNfhC
         pKuw==
X-Gm-Message-State: APjAAAUhiPonUcN3HVDWQvV3x8bGClfY6pspmUIcsOMy64vJsOm7TIYE
        0LutfxdXUKrOQq11l6h17SFEXuXvWuyVXLk=
X-Google-Smtp-Source: APXvYqy6txRryyUL2ABcJNZLNr6zXIbMUWDWOiEgQN6cFXelIVr9k5cMguvNDbpVLT6bi0d9sMNRQIXaJZ3YMfo=
X-Received: by 2002:ac8:685:: with SMTP id f5mr4388547qth.9.1560485867363;
 Thu, 13 Jun 2019 21:17:47 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:17:25 -0700
In-Reply-To: <20190614041733.120807-1-saravanak@google.com>
Message-Id: <20190614041733.120807-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 03/11] PM / devfreq: Add required OPPs support to passive governor
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
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

Look at the required OPPs of the "parent" device to determine the OPP that
is required from the slave device managed by the passive governor. This
allows having mappings between a parent device and a slave device even when
they don't have the same number of OPPs.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/devfreq/governor_passive.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 3bc29acbd54e..bd4a98bb15b1 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -21,8 +21,9 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
+	struct opp_table *opp_table = NULL, *c_opp_table = NULL;
 	unsigned long child_freq = ULONG_MAX;
-	struct dev_pm_opp *opp;
+	struct dev_pm_opp *opp = NULL, *c_opp = NULL;
 	int i, count, ret = 0;
 
 	/*
@@ -65,7 +66,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 		goto out;
 	}
 
-	dev_pm_opp_put(opp);
+	opp_table = dev_pm_opp_get_opp_table(parent_devfreq->dev.parent);
+	if (IS_ERR_OR_NULL(opp_table)) {
+		ret = PTR_ERR(opp_table);
+		goto out;
+	}
+
+	c_opp_table = dev_pm_opp_get_opp_table(devfreq->dev.parent);
+	if (!IS_ERR_OR_NULL(c_opp_table))
+		c_opp = dev_pm_opp_xlate_opp(opp_table, c_opp_table, opp);
+	if (c_opp) {
+		*freq = dev_pm_opp_get_freq(c_opp);
+		dev_pm_opp_put(c_opp);
+		goto out;
+	}
 
 	/*
 	 * Get the OPP table's index of decided freqeuncy by governor
@@ -92,6 +106,13 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	*freq = child_freq;
 
 out:
+	if (!IS_ERR_OR_NULL(opp_table))
+		dev_pm_opp_put_opp_table(opp_table);
+	if (!IS_ERR_OR_NULL(c_opp_table))
+		dev_pm_opp_put_opp_table(c_opp_table);
+	if (!IS_ERR_OR_NULL(opp))
+		dev_pm_opp_put(opp);
+
 	return ret;
 }
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

