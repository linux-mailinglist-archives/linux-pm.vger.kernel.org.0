Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B0F1C822B
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 08:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgEGGIA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 02:08:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42225 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgEGGIA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 02:08:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id a21so4942245ljb.9;
        Wed, 06 May 2020 23:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oMfRzSsPW3kRjYs+IOUJ9u3rrSqH1BCp5PIFe3h0wzc=;
        b=N742UzLKPVhQSrP6ihxtX24e4sMGkq07hxbLCp4cd7aHsZ0YGzNi957e0rNOkBefj2
         nx6S50aStPtQVfuyw7pOhZW5rMreErvYp5GupjUvd9RU+9O2TF7GP1LtkF9BXDzN025p
         xhvQFADn1+pEO0ncjuGvh6/xuggTdL9Ltg3F0IzHp5GwDQnoxm1gW+j4VQe8jKm6dD0S
         TwAwuiXuLkJSLH/FUOQg4yysnzydl6IHm4rbMS9Dt4p6yWyAQKixoED1aW4l44MT7oDU
         CzDqvJTqkSIUfNdw5hYYjDnw8Q+qaRfJ5D1+Rsw5blGAp8WkS/6+V2kpK2C8AASt7QFB
         z9Zg==
X-Gm-Message-State: AGi0PuYGwShsDagvNhtrqdqxWLyFSMJzVaIOnf1A1P9GeBNjvBT9Qoz9
        A1HbX+5zyNNTA3/ZGP2jCuY=
X-Google-Smtp-Source: APiQypKMUqyhMrmZdfXHPJRO4S8bPRVYq4Skdbov1b5y0zi9V/FjOhyTgQng1dhRbbWFU63P3w4wNw==
X-Received: by 2002:a2e:2414:: with SMTP id k20mr7084478ljk.162.1588831675881;
        Wed, 06 May 2020 23:07:55 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id a2sm2602371ljj.53.2020.05.06.23.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 23:07:55 -0700 (PDT)
Date:   Thu, 7 May 2020 09:07:10 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 03/11] power: supply: bd70528: rename linear_range to
 avoid collision
Message-ID: <f0b88bd1bc1bfda268d3069ea9d05ebadb3fb17a.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
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
