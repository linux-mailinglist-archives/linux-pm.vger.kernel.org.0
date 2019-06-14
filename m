Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5124535E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 06:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfFNESZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 00:18:25 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:33662 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfFNESD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 00:18:03 -0400
Received: by mail-pg1-f201.google.com with SMTP id v62so969183pgb.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2019 21:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nYfthp2AfyfO7B9ZHl8Ammgshm5FNB69pWC4uzGdWTs=;
        b=GVJb8P57i8A8s2Q/xPGtRuqGml/T3Dc0WEw/F17bY2Wsfnclfx3eGoWReG2O2lx7Gg
         UqqGqa+5rSPj1HwW/apFO4TKxeR038gAsdmdb24fPQ1J2xlKNO3SQeHYcojtHMumKBTM
         WTe4FG2V1nSEKJ40YNvaiKOND86UFZPcLh+rhoVLkd9aaSK+qGkN6VsEgJZOwSN1d40U
         kCje8mYmJlqqIbPjDs7c3lcHZh5KyfWT17dG7WEjxtFaIU9RkqXXN1EbHmC4Jgfj5ia0
         7vwvk2Tq6R5fIrgtS/V+ak2yQ4QVpk9qGxaCPye+fr3NR5F5nC1yY5k/l8BM9BA+quEd
         R3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nYfthp2AfyfO7B9ZHl8Ammgshm5FNB69pWC4uzGdWTs=;
        b=e4Ru8/5JO8HETLYzRa52WcBTSPa+rUNQ3IX5QyQOz7iSIfcuNib71Bl6eK6ETKu/wd
         N1V5ovldo4gq0Omp4x8U9qRamlQCkyj5Ln66n85IcJ1R+1l6/1WC20YxwHwQhe1FLKF3
         B+mMAfjXyhkBZn+yFmKupQtGW9bDlxb6TE9ultYM7Tied7jdiiuER/aBdmnm3W84jZwK
         busjgaQZZu2LewC2xu/1fXfnsDy428FgA2NuhpKGMaL/9yPKjMnjaGsUc1gOKusxX9cP
         eS7VTZNdPDJaOUf030dJwUohtkGTn8vVYAZnTI3UjwBkSOXZ1ArBwaOcZy2TLfTi5CJ8
         s+cw==
X-Gm-Message-State: APjAAAUsBNGrdNHXlF/PbsRaa+vcuoSCqC1eVX2PKwDJkQJtKeMgJBP8
        sPlpibBM4HCJ2QQkD1JADwXt+mxeD3ZS83g=
X-Google-Smtp-Source: APXvYqzUC9HlFhAxNmIuXsO0mETwrQGfBv0aMuyKBFgTaDc2h9LrsQyWa5pzvaoE3ygZQW3W2VXMmmglbK9s5ko=
X-Received: by 2002:a63:1919:: with SMTP id z25mr34405308pgl.440.1560485882676;
 Thu, 13 Jun 2019 21:18:02 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:17:30 -0700
In-Reply-To: <20190614041733.120807-1-saravanak@google.com>
Message-Id: <20190614041733.120807-9-saravanak@google.com>
Mime-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 08/11] dt-bindings: interconnect: Add interconnect-opp-table
 property
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

Add support for listing bandwidth OPP tables for each interconnect path
listed using the interconnects property.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../devicetree/bindings/interconnect/interconnect.txt     | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
index 6f5d23a605b7..fc5b75b76a2c 100644
--- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -55,10 +55,18 @@ interconnect-names : List of interconnect path name strings sorted in the same
 			 * dma-mem: Path from the device to the main memory of
 			            the system
 
+interconnect-opp-table: List of phandles to OPP tables (bandwidth OPP tables)
+			that specify the OPPs for the interconnect paths listed
+			in the interconnects property. This property can only
+			point to OPP tables that belong to the device and are
+			listed in the device's operating-points-v2 property.
+
 Example:
 
 	sdhci@7864000 {
+		operating-points-v2 = <&sdhc_opp_table>, <&sdhc_mem_opp_table>;
 		...
 		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
 		interconnect-names = "sdhc-mem";
+		interconnect-opp-table = <&sdhc_mem_opp_table>;
 	};
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

