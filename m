Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D013939B1C
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2019 06:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbfFHEoX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Jun 2019 00:44:23 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:43555 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730910AbfFHEoL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jun 2019 00:44:11 -0400
Received: by mail-ot1-f74.google.com with SMTP id w110so1941517otb.10
        for <linux-pm@vger.kernel.org>; Fri, 07 Jun 2019 21:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AmlnQxdhHxhgaUE+upN643FVBvwEIISLpUNhemfIGlM=;
        b=JL5TWljI4VDEsVSrJSrPNzCX/VIAWb2fbHLcrGTXg2NQX5riYvqM7uVswYbzT/EEIy
         djd3AV+RJB9gvVahixYEtpThuyB3VVlVmFDDq1q4B9h3ijMYAPCKfE0nk4RoHstinSwx
         c/R9Pg82bRVid8j95hPh+O3ygphRRVx49n/4u3GIvaAN3C0B+dBOwvqdlm4rSCAstLr7
         QkLCiAB4f29eEWdyvpz0T8IDux78ly13crISVGWjBxWAo/Kbu+0XLJFfmT1XIIdKtPZl
         86fMZcAYwDzqag6dAnzFYm22f8WETD3fmEbtrfW4u453VQ+8v26rZpQt5DhyAP9cb9Gh
         DfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AmlnQxdhHxhgaUE+upN643FVBvwEIISLpUNhemfIGlM=;
        b=ACP5prTzCDmo2H+oI64iyuw+02xyD/vTZ4YNDe9tEcZsfle/+tF2drMI89cxiD1cg9
         pGVoD6fT4mnldKH9fhdLEb317MillZfLscvR1s8+fhyeMAZvyqfJvcJ3KUWgwCStuwUg
         mY+e1eMoJK4C5TBICNeIKy6xZutIx6EaY415VHTCnJUESnP2sAIkQwmfio52nQMv4LAB
         bfsu6wePJ33MgP3VgLnoeUhMg2eEjAZ7GbCZr3TDNMkKf6UVvADcC5HntV/+iR+iHFJb
         Noaemo3xwbOU0YtR6d/Sj7Rb6WmCOI7SFJ+qo4fpjQwG36demY2z8uDzSa4N15eNZee/
         v5ig==
X-Gm-Message-State: APjAAAUCO7bit2oQqPHtjR8swFWe5X2eVBRp50BRnpgx68yPjzV/p5ae
        GWFc6me7uGJIiLF0QsAkdGiIv0/WRxQD2P8=
X-Google-Smtp-Source: APXvYqz9I03qq1fo0EbBYhFp6pczS0prAvgt/qQK+tiBjETZmeye60HIskMRhLyeg6qLcL8rLOIIuIvMoSD2BCs=
X-Received: by 2002:aca:d88b:: with SMTP id p133mr6059786oig.3.1559969050745;
 Fri, 07 Jun 2019 21:44:10 -0700 (PDT)
Date:   Fri,  7 Jun 2019 21:43:38 -0700
In-Reply-To: <20190608044339.115026-1-saravanak@google.com>
Message-Id: <20190608044339.115026-9-saravanak@google.com>
Mime-Version: 1.0
References: <20190608044339.115026-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v1 8/9] OPP: Allow copying OPPs tables between devices
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

Some hardware devices might create multiple children devices to manage
different components of the hardware. In these cases, it might be necessary
for the original hardware device to copy specific OPP tables to a specific
the new child device. Add dev_pm_opp_add_opp_table() to do that.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/core.c     | 8 ++++++++
 include/linux/pm_opp.h | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d96d5746eb47..9d49aee2c3ef 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -943,6 +943,14 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	return opp_dev;
 }
 
+int dev_pm_opp_add_opp_table(struct device *dev, struct opp_table *opp_table)
+{
+	if (!dev || !opp_table)
+		return -EINVAL;
+
+	return _add_opp_dev(dev, opp_table) ? 0 : -ENOMEM;
+}
+
 static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 {
 	struct opp_table *opp_table;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 13381dc3dd39..31acc617fda3 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -81,6 +81,7 @@ struct dev_pm_set_opp_data {
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
 struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev, int index);
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
+int dev_pm_opp_add_opp_table(struct device *dev, struct opp_table *opp_table);
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
@@ -158,6 +159,12 @@ static inline struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *
 
 static inline void dev_pm_opp_put_opp_table(struct opp_table *opp_table) {}
 
+static int dev_pm_opp_add_opp_table(struct device *dev,
+				    struct opp_table *opp_table)
+{
+	return -ENOTSUPP;
+}
+
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
 	return 0;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

