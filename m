Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8314199660
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 14:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgCaMYV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 08:24:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39701 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbgCaMYV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 08:24:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id h6so11349486lfp.6;
        Tue, 31 Mar 2020 05:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ohvImCp014Io4Oupmt5+qexhjRs8YPgpvAzigx1eCkE=;
        b=LRJmYqiXgdKXOmY2E9QMyluGRVc8goimhORDlaNqMhHWiZ2ehuuJ+HMnaiOOVjniC/
         gQIoZp/wGB73/hvyIRMa5u9RUVLB8PXu9mvHSmO/x2ZdYjxP/vq7rCr6MR/hzmEbYJKY
         RCkqrVhRRZZ0T1CJroFEkL/4iBDymV6X9si+yuVGIrRoVoa1ONNJrNuFQCAJmACQ9XvR
         t56jt5MI680valm/rDUrJO1A6SldjntKeA6ZCAbvnLKU5R1WF+t5FIwzkwL6Z9nj92MO
         WySZtYJWBpA9ES6FdtnUMzzZMeiX9q2VNf5vINujhkSsPktBeSzoznYd9MyNGzq21Qsm
         tNKQ==
X-Gm-Message-State: AGi0Pubf4aDKXd9xd3Y6f+mCJAvMdYtjchGQdLQk+wjZnXYk3toMBc44
        8UvmntPXOxcXMCneSoiuePQ=
X-Google-Smtp-Source: APiQypLBiVKJIKEgNhjpWZGa7KnMSdP7F9H6Tf0LekUtYuYRMZ/lvYBKbwBNamrrXtL3RAdTIqkmWg==
X-Received: by 2002:a19:3847:: with SMTP id d7mr10980112lfj.158.1585657458994;
        Tue, 31 Mar 2020 05:24:18 -0700 (PDT)
Received: from localhost.localdomain (dc7t7ryyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16e1:b700::3])
        by smtp.gmail.com with ESMTPSA id b21sm9939563ljo.54.2020.03.31.05.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:24:18 -0700 (PDT)
Date:   Tue, 31 Mar 2020 15:24:10 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Changbin Du <changbin.du@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Gow <davidgow@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Gary Hook <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tal Gilboa <talgi@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v7 05/10] power: supply: bd70528: rename linear_range to
 avoid collision
Message-ID: <d9cb874134ae7a047e2cf8c87e8e949fe852ddab.1585656143.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1585656143.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1585656143.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Follow-up patches in this series will add a generic struct
linear_range. Rename bd70528 internal struct to avoid collision.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

No changes since v6

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
