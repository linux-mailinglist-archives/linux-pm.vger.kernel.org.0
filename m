Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA8E1CB3B7
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 17:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgEHPnK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 11:43:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41721 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgEHPnK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 11:43:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so1770579lfb.8;
        Fri, 08 May 2020 08:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oMfRzSsPW3kRjYs+IOUJ9u3rrSqH1BCp5PIFe3h0wzc=;
        b=oP5e0Tk+WBB6EscyAauBqDXKUivHbaoZXA7V2G6uRKkqqeOX6LJd9f6jhBOhAlXew6
         mIGBa/IMePbkMEadrrP8d4RNiJUUVkPiVB4dZWsv5MevjpXO8BtkKETPyLolBtvyMxJK
         1Ming/DccCrEfyBpnLkngJqA3kp30E+vfidGgcZNRKcF5OdlgKE57fn5dPhfTx0gT9UD
         cqCBLyY3HfnNVf6/dzYkXq4HgJku85jo6AIA1BA+5plq8q9mI7kON297PQHjs1wAlPIZ
         snx5GHHkUaPt+xznwznj+vpkvA/RiFfZv1xNb/NYRlGlPSQsaFiX/AzoXHctayeYUtiZ
         8/Xg==
X-Gm-Message-State: AOAM533bKuJRkovdhLZvuA9/ruoP7AxIN9hUl+y6TN1HYVl/yA41IisT
        hXL5cNITNzk4AKni7DVtDl0PNfARL08=
X-Google-Smtp-Source: ABdhPJysPCemwWLOlCAkNj5z4nRgPdxp3FHNzRmSurpODBPwOv8Sv4YzWGDuc2DQpN2bLzi46h9cdA==
X-Received: by 2002:a19:8293:: with SMTP id e141mr2346736lfd.173.1588952587907;
        Fri, 08 May 2020 08:43:07 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id h3sm1541224lfk.3.2020.05.08.08.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 08:43:07 -0700 (PDT)
Date:   Fri, 8 May 2020 18:41:49 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        brendanhiggins@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 03/11] power: supply: bd70528: rename linear_range to
 avoid collision
Message-ID: <286b1ae0adc1c08e7b644cbdc1a43eb2e0644647.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
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
