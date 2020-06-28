Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB85320C658
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jun 2020 08:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgF1GEc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jun 2020 02:04:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:18773 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgF1GEc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Jun 2020 02:04:32 -0400
IronPort-SDR: JtBzqdWiJxblHfgFt7kXt1O/vcgQW7rZ+fu7HWsSnCzkU5i7duNgUH96ZzNR/NHv+BngpmMQaV
 Ogf2Q98BzChw==
X-IronPort-AV: E=McAfee;i="6000,8403,9665"; a="210857816"
X-IronPort-AV: E=Sophos;i="5.75,290,1589266800"; 
   d="scan'208";a="210857816"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2020 23:04:31 -0700
IronPort-SDR: Rp7G1qbm738fOTbwKesfNzmFHV5FpAUDq+4vqvR96X1hMDk/rvIk5setgE9GwLaDWq/opU4g+c
 rmJarV4mG5yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,290,1589266800"; 
   d="scan'208";a="276759770"
Received: from lkp-server02.sh.intel.com (HELO 1f25e51baad6) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 27 Jun 2020 23:04:29 -0700
Received: from kbuild by 1f25e51baad6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jpQQX-00001x-1K; Sun, 28 Jun 2020 06:04:29 +0000
Date:   Sun, 28 Jun 2020 14:04:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [RFC PATCH linus] drivers: thermal: tsens:
 tsens_critical_irq_thread() can be static
Message-ID: <20200628060359.GA29916@8567a11ddfea>
References: <202006281417.GPpEXCGD%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006281417.GPpEXCGD%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Fixes: a7ff82976122 ("drivers: thermal: tsens: Merge tsens-common.c into tsens.c")
Signed-off-by: kernel test robot <lkp@intel.com>
---
 tsens.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 8d3e94d2a9ed4..39c4462e38f62 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -382,7 +382,7 @@ static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
  *
  * Return: IRQ_HANDLED
  */
-irqreturn_t tsens_critical_irq_thread(int irq, void *data)
+static irqreturn_t tsens_critical_irq_thread(int irq, void *data)
 {
 	struct tsens_priv *priv = data;
 	struct tsens_irq_data d;
@@ -452,7 +452,7 @@ irqreturn_t tsens_critical_irq_thread(int irq, void *data)
  *
  * Return: IRQ_HANDLED
  */
-irqreturn_t tsens_irq_thread(int irq, void *data)
+static irqreturn_t tsens_irq_thread(int irq, void *data)
 {
 	struct tsens_priv *priv = data;
 	struct tsens_irq_data d;
@@ -520,7 +520,7 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-int tsens_set_trips(void *_sensor, int low, int high)
+static int tsens_set_trips(void *_sensor, int low, int high)
 {
 	struct tsens_sensor *s = _sensor;
 	struct tsens_priv *priv = s->priv;
@@ -557,7 +557,7 @@ int tsens_set_trips(void *_sensor, int low, int high)
 	return 0;
 }
 
-int tsens_enable_irq(struct tsens_priv *priv)
+static int tsens_enable_irq(struct tsens_priv *priv)
 {
 	int ret;
 	int val = tsens_version(priv) > VER_1_X ? 7 : 1;
@@ -570,7 +570,7 @@ int tsens_enable_irq(struct tsens_priv *priv)
 	return ret;
 }
 
-void tsens_disable_irq(struct tsens_priv *priv)
+static void tsens_disable_irq(struct tsens_priv *priv)
 {
 	regmap_field_write(priv->rf[INT_EN], 0);
 }
