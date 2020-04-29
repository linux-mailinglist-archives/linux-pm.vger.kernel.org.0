Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247851BD534
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 08:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgD2G5S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 02:57:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43827 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgD2G5R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 02:57:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id l19so1390566lje.10;
        Tue, 28 Apr 2020 23:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V8t969m/oAfp2aM5Orm4ogSiRH3cmyANou7ORBIqnUg=;
        b=LPftrBaxYNYVbLfDY/QhuVbYIFu1j1gxgbT002HbigEQnvK1+LotkwGONnACTobDGz
         YgWyF6gAoiezN9u0/CZxnmh9lqdrxQjurwLaTfXqXiwynJzNFdKwRPVDJxUc7A67RVzo
         0H3wOE3dtQG5OJx+o7+9n6XaVJmoX5JgS9BOlUfNl71+KPu09H/CVN+leqPq5gV1931F
         vJiRqO9Ody880fhmnGJF5SBzf++OIxdd7UvE+JmiwxuULZr17igXDldOoT2MewNcV8Nu
         2Xw/it4vcdnGhjP0RaDpqkF4zmHNsgm2HJTG3oNqeAqnnIAbC7GCQnEZhQ8WNDIudXOd
         Bvlg==
X-Gm-Message-State: AGi0PuaUns/EM0t123z1ZbryEfRgOCu7bmF3CEkkelQsA7I05sXh2C6w
        6yqBd5xWewj1I0Q4GTYXP1M=
X-Google-Smtp-Source: APiQypLNkx1MPoFtWRe+XOeHpvSmb/kUqhvngmODpWEvMPNNdwU1SKx1Td/D6Hyk3elOWVLMskClog==
X-Received: by 2002:a2e:7d12:: with SMTP id y18mr20986970ljc.211.1588143435144;
        Tue, 28 Apr 2020 23:57:15 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id a13sm1526442ljm.25.2020.04.28.23.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 23:57:14 -0700 (PDT)
Date:   Wed, 29 Apr 2020 09:56:27 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     sre@kernel.org, robh+dt@kernel.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v10 03/11] power: supply: bd70528: rename linear_range
 to avoid collision
Message-ID: <b523223f3ba5e570bb9d2ef197db24c5ea88319d.1586925868.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1586925868.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1586925868.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Follow-up patches in this series will add a generic struct
linear_range. Rename bd70528 internal struct to avoid collision.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---

No changes since v9

 drivers/power/supply/bd70528-charger.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bd70528-charger.c b/drivers/power/supply/bd70528-charger.c
index b8e1ec106627..3b820110ecfa 100644
--- a/drivers/power/supply/bd70528-charger.c
+++ b/drivers/power/supply/bd70528-charger.c
@@ -335,14 +335,14 @@ static int bd70528_get_present(struct bd70528_psy *bdpsy, int *val)
 	return 0;
 }
 
-struct linear_range {
+struct bd70528_linear_range {
 	int min;
 	int step;
 	int vals;
 	int low_sel;
 };
 
-static const struct linear_range current_limit_ranges[] = {
+static const struct bd70528_linear_range current_limit_ranges[] = {
 	{
 		.min = 5,
 		.step = 1,
@@ -374,7 +374,7 @@ static const struct linear_range current_limit_ranges[] = {
  * voltage for low temperatures. The driver currently only reads
  * the charge current at room temperature. We do set both though.
  */
-static const struct linear_range warm_charge_curr[] = {
+static const struct bd70528_linear_range warm_charge_curr[] = {
 	{
 		.min = 10,
 		.step = 10,
@@ -398,7 +398,7 @@ static const struct linear_range warm_charge_curr[] = {
 #define MAX_WARM_CHG_CURR_SEL 0x1f
 #define MIN_CHG_CURR_SEL 0x0
 
-static int find_value_for_selector_low(const struct linear_range *r,
+static int find_value_for_selector_low(const struct bd70528_linear_range *r,
 				       int selectors, unsigned int sel,
 				       unsigned int *val)
 {
@@ -420,7 +420,7 @@ static int find_value_for_selector_low(const struct linear_range *r,
  * I guess it is enough if we use voltage/current which is closest (below)
  * the requested?
  */
-static int find_selector_for_value_low(const struct linear_range *r,
+static int find_selector_for_value_low(const struct bd70528_linear_range *r,
 				       int selectors, unsigned int val,
 				       unsigned int *sel, bool *found)
 {
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
