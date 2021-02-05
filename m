Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7388D311846
	for <lists+linux-pm@lfdr.de>; Sat,  6 Feb 2021 03:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhBFCdB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 21:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBFCcO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 21:32:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B968C03C062
        for <linux-pm@vger.kernel.org>; Fri,  5 Feb 2021 14:27:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 11so8753817ybl.21
        for <linux-pm@vger.kernel.org>; Fri, 05 Feb 2021 14:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Bw5DCGRTYuHhV6CaEDXr7VykkGUog594vA90XJtHO1Y=;
        b=OJ24USk8NaXzKxxqD9cIc2fuOOLVmyyzmeeBnuhX2haf4opjBLOqqJRPp0oJB2TcJy
         QU5VBOCElNExNGxqLUxqgYZItGUiFhRtQzb3LQdbw3Y0LZcW3LuI88Njj48rtjKPsSZ2
         4F0icSi17k6dTngdFP+PaTB0cFBlMjBumwi1fy39MHFAPu/w9n8my2gcennaSg5vjErP
         sQRLYkA7SGqEGGXM0TBNdHDG5nonXhw92Rf6mDDQik8AxtIwTOsa++xp6SeuTGFyIXpz
         MAv6/0kL+jIazKDHFcWr73Ze5NFqgWo6QJFSaG2D5SJFVSY04331pMLEzlZOwVgZ2YBU
         uyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bw5DCGRTYuHhV6CaEDXr7VykkGUog594vA90XJtHO1Y=;
        b=qQv4SO+L1OBuAMjovyc7yWLtCGTbQWS69Za4SB3p6ZWKhTpZxFmDlADsAT9Yzr6Wx9
         dlD1iMlOP1nfNep2axgDRdmjfQELVAbLbnxZYy9jMWpso1wuOfh9xyN4oQqj+Kt9fR3I
         xgb4UI8adNMBOiG8aPl7Q3QwDKGDqjQFXoyijHs3sz4AgHrxmqZwHW0is0Jc4SjLLTI4
         QtyrzJtxB94NuLawN2ULpCa5RJQ/zFDqW/1UCBZpKwhCFDftUkOBJmvywSa0eeuNYlLm
         uKMBKoRsGwPAhe/eIgYlFVKl8kga0a8NmchAJy7KlpGNj6aYnzHYtopz3Nq3pXmbDDUN
         4Ehw==
X-Gm-Message-State: AOAM531Cy9n7Y8/y7qy9/qo3k/Xm2GLpP6S8TCpJtZj+Mu4vPqUx1k/d
        cNp2vwpmVUFCK9v2XUqApgktS5bW6oJAz20=
X-Google-Smtp-Source: ABdhPJy8zXEis/xhZQjdQJH/U4yg9J4P3415kxIuICG74Qvlo/PkTtrQfpR8JQK+yrBlCNXAjS7e2k4VjoRZpiE=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6d36:b798:55d7:f5c5])
 (user=saravanak job=sendgmr) by 2002:a25:e54:: with SMTP id
 81mr9240781ybo.404.1612564019429; Fri, 05 Feb 2021 14:26:59 -0800 (PST)
Date:   Fri,  5 Feb 2021 14:26:40 -0800
In-Reply-To: <20210205222644.2357303-1-saravanak@google.com>
Message-Id: <20210205222644.2357303-5-saravanak@google.com>
Mime-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4 4/8] of: property: Add fw_devlink support for optional properties
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Not all DT bindings are mandatory bindings. Add support for optional DT
bindings and mark iommus, iommu-map, dmas as optional DT bindings.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 53d163c8d39b..962109082df1 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1235,6 +1235,7 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
 struct supplier_bindings {
 	struct device_node *(*parse_prop)(struct device_node *np,
 					  const char *prop_name, int index);
+	bool optional;
 };
 
 DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
@@ -1308,12 +1309,12 @@ static struct device_node *parse_interrupts(struct device_node *np,
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
 	{ .parse_prop = parse_interconnects, },
-	{ .parse_prop = parse_iommus, },
-	{ .parse_prop = parse_iommu_maps, },
+	{ .parse_prop = parse_iommus, .optional = true, },
+	{ .parse_prop = parse_iommu_maps, .optional = true, },
 	{ .parse_prop = parse_mboxes, },
 	{ .parse_prop = parse_io_channels, },
 	{ .parse_prop = parse_interrupt_parent, },
-	{ .parse_prop = parse_dmas, },
+	{ .parse_prop = parse_dmas, .optional = true, },
 	{ .parse_prop = parse_power_domains, },
 	{ .parse_prop = parse_hwlocks, },
 	{ .parse_prop = parse_extcon, },
@@ -1368,6 +1369,11 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 
 	/* Do not stop at first failed link, link all available suppliers. */
 	while (!matched && s->parse_prop) {
+		if (s->optional && !fw_devlink_is_strict()) {
+			s++;
+			continue;
+		}
+
 		while ((phandle = s->parse_prop(con_np, prop_name, i))) {
 			matched = true;
 			i++;
-- 
2.30.0.478.g8a0d178c01-goog

