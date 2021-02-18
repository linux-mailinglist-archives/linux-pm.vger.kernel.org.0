Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CFF31F140
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhBRUmc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhBRUkd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2FBC061794
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 12:39:52 -0800 (PST)
Date:   Thu, 18 Feb 2021 20:39:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KhlgRm2ZTsIj8vRVrqUP0tTeBkXtaYHqRyOnd0IDKbs=;
        b=S9gXYu4sS/fo3VJabqEx5TDXt3yn/qKm9mJndeTAu9QE2lyhi1IdS9O/G4nkXxP6eqM6sE
        vcYL0mYvjfUmTfNVYMLvOsjQGGp9fLHB2RwbcgpKeaQ2FxYw4hd2Xufh6x20M+ImdQkv40
        VUEGvDFDmhW7dGxJt0pGL/Vcxd9iw/4EGtDqek9IpNgDVDkhw3w1HihX9lZSLLsoazL+fZ
        Wh0Z9GmFdK7hQ0d8dfVDHzEF0N+Hqrb1Wl2Q9i4/GCcWu3mrJ+ihK7dOtWddx3xjdXd06h
        GOvhyQWvHWV1BCt+Grm86Tuv1+JvUTRPAp1X1OZPlLn5HeS31mOoVgiMxROryw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KhlgRm2ZTsIj8vRVrqUP0tTeBkXtaYHqRyOnd0IDKbs=;
        b=mS1WDBKZ9okFKGmFXWWsppPyfNmMLe7G9rUJVXeGk3lxZCvQifXSPGmgvLNLviM87Q+gSg
        FZ8RLuOrzx8lkzCA==
From:   "thermal-bot for Dmitry Baryshkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] iio: adc: move vadc_map_pt from header to the
 source file
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20201204025509.1075506-9-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-9-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Message-ID: <161368078396.20312.10276329811528002669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     bb01e263743293d37148f1fa00e3ea04dca416a5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//bb01e263743293d37148f1fa00e3ea04dca416a5
Author:        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
AuthorDate:    Fri, 04 Dec 2020 05:55:02 +03:00
Committer:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CommitterDate: Sat, 16 Jan 2021 18:28:18 

iio: adc: move vadc_map_pt from header to the source file

struct vadc_map_pt is not used outside of qcom-vadc-common.c, so move it
there from the global header file.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20201204025509.1075506-9-dmitry.baryshkov@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-vadc-common.c       | 11 +++++++++++
 include/linux/iio/adc/qcom-vadc-common.h | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index ee94774..45a3860 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -10,6 +10,17 @@
 #include <linux/module.h>
 #include <linux/units.h>
 
+/**
+ * struct vadc_map_pt - Map the graph representation for ADC channel
+ * @x: Represent the ADC digitized code.
+ * @y: Represent the physical data which can be temperature, voltage,
+ *     resistance.
+ */
+struct vadc_map_pt {
+	s32 x;
+	s32 y;
+};
+
 /* Voltage to temperature */
 static const struct vadc_map_pt adcmap_100k_104ef_104fb[] = {
 	{1758,	-40},
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index 03a9119..1d337dd 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -59,17 +59,6 @@
 #define DIE_TEMP_ADC7_SCALE_FACTOR		1000
 #define DIE_TEMP_ADC7_MAX			160000
 
-/**
- * struct vadc_map_pt - Map the graph representation for ADC channel
- * @x: Represent the ADC digitized code.
- * @y: Represent the physical data which can be temperature, voltage,
- *     resistance.
- */
-struct vadc_map_pt {
-	s32 x;
-	s32 y;
-};
-
 /*
  * VADC_CALIB_ABSOLUTE: uses the 625mV and 1.25V as reference channels.
  * VADC_CALIB_RATIOMETRIC: uses the reference voltage (1.8V) and GND for
