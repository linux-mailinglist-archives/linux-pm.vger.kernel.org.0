Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA5416BCA9
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 09:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgBYIxp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 03:53:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34480 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgBYIxo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 03:53:44 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so9166741lfc.1;
        Tue, 25 Feb 2020 00:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nDkpzkIbHTHFB2KCsxpJEeEEt/VOed+TnbNFIK439eQ=;
        b=M4xhRnWP+3zT1yUQR6eLcuwwllIfVTmMd7u6zZXLXdcK4HvCXFKWMEIicWInGKWkL8
         KNQRT9fM/vBlmURCdNLM5CddWH4FX+9xsFHohpoE0NAO6zXCQR1h186VoW4J9koiBEaa
         gPItB/GW5BHEuAzkU5JM9kxRWprCfG9bwdbor2HyY8BQwF1Mx2O+rSjN2m+aJ3gyncan
         cEDVDLzsj4cwjyBES4RtruUtWQOMBBncenIVJ5yTIw5wLMjPGIWCUTLV+ybVJTKs7emk
         edU0Rvd98IIW2rcKxKjxjPJnZAkPHxkrgHBo1NNJV517SdGjbwaNJur3/CWQh5c3TvTs
         iDbw==
X-Gm-Message-State: APjAAAU3J55eeKLOLNZ/7wZmxqiYhGStMUbZiWmh3DHAKp7biEgB7GhX
        eOi5JlxTxy5coE3skdRs7Tc=
X-Google-Smtp-Source: APXvYqzjfIDtiveEIf7gMME8qCXu96Jyuy/r4a79H5Js/J4aGLqBM4I6M7n+iiqvkx/F65uM990V+w==
X-Received: by 2002:a19:ed08:: with SMTP id y8mr6138763lfy.56.1582620822561;
        Tue, 25 Feb 2020 00:53:42 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id o25sm2079699lfi.89.2020.02.25.00.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 00:53:42 -0800 (PST)
Date:   Tue, 25 Feb 2020 10:53:30 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: [PATCH v4 4/9] power: supply: bd70528: rename linear_range to avoid
 collision
Message-ID: <8b09f9548d60b1aeda8bcecf7cee18e7f34c1d62.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Follow-up patches in this series will add a generic struct
linear_range. Rename bd70528 internal struct to avoid collision.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
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
