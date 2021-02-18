Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5AE31F144
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 21:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhBRUnB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 15:43:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhBRUke (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 15:40:34 -0500
Date:   Thu, 18 Feb 2021 20:39:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613680784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lnWp7FKh0B75nGnXeYCJaOCT0/GNUeE4ABRVO4qcRQ=;
        b=Yfe1bSVWigDGBeMZV3VaYuRZUMhDBe3M5cYJv76fXccFV5htRuW2vjBMa0V7MaoB9AdbEJ
        WM3ujzYn2FnZKN6e3JL8urXiRTss9b5OdRWQTf5wqn8hNwCKzzhDqyNQLd11xPXvcMomtk
        h0F2ac8sk94ra/9KWYzlFCFVBtj/0o+8ynFsOLbyO/x7gAU/OigYVYuUIq/AR7BC38VrUU
        wLY1CgKQXQG6f3W2r9iS21xftnvOz564S/MbqBnfYi+Wdp/dF/ueiPRVpnuT60kYWOMc7D
        2RdArhsFVfQfkxkbF5ldg8w5Vdr3cDxNtg/ELjU5vj5ExqQZQOLOvAnznAF39g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613680784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lnWp7FKh0B75nGnXeYCJaOCT0/GNUeE4ABRVO4qcRQ=;
        b=h6DIYg2d+X347a22H6osSD+GqsW2lfeAhmH5MvrPFNKUYtifV/S+7PyuR9X3JrrQm9v5Bq
        sLucWyz4vJHgAgAw==
From:   "thermal-bot for Dmitry Baryshkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] iio: provide of_iio_channel_get_by_name() and
 devm_ version it
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
In-Reply-To: <20201204025509.1075506-8-dmitry.baryshkov@linaro.org>
References: <20201204025509.1075506-8-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Message-ID: <161368078423.20312.15393574883602604651.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     6e39b145cef7577cd6b550e633155e5fc1e5838e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//6e39b145cef7577cd6b550e633155e5fc1e5838e
Author:        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
AuthorDate:    Fri, 04 Dec 2020 05:55:01 +03:00
Committer:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CommitterDate: Sat, 16 Jan 2021 18:27:51 

iio: provide of_iio_channel_get_by_name() and devm_ version it

There might be cases when the IIO channel is attached to the device
subnode instead of being attached to the main device node. Allow drivers
to query IIO channels by using device tree nodes.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20201204025509.1075506-8-dmitry.baryshkov@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/inkern.c         | 34 +++++++++++++++++++++++++--------
 include/linux/iio/consumer.h | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index fe30bcb..db77a2d 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -191,8 +191,8 @@ err_free_channel:
 	return ERR_PTR(err);
 }
 
-static struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
-						      const char *name)
+struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
+					       const char *name)
 {
 	struct iio_channel *chan = NULL;
 
@@ -230,6 +230,7 @@ static struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
 
 	return chan;
 }
+EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name);
 
 static struct iio_channel *of_iio_channel_get_all(struct device *dev)
 {
@@ -272,12 +273,6 @@ error_free_chans:
 
 #else /* CONFIG_OF */
 
-static inline struct iio_channel *
-of_iio_channel_get_by_name(struct device_node *np, const char *name)
-{
-	return NULL;
-}
-
 static inline struct iio_channel *of_iio_channel_get_all(struct device *dev)
 {
 	return NULL;
@@ -393,6 +388,29 @@ struct iio_channel *devm_iio_channel_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_iio_channel_get);
 
+struct iio_channel *devm_of_iio_channel_get_by_name(struct device *dev,
+						    struct device_node *np,
+						    const char *channel_name)
+{
+	struct iio_channel **ptr, *channel;
+
+	ptr = devres_alloc(devm_iio_channel_free, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	channel = of_iio_channel_get_by_name(np, channel_name);
+	if (IS_ERR(channel)) {
+		devres_free(ptr);
+		return channel;
+	}
+
+	*ptr = channel;
+	devres_add(dev, ptr);
+
+	return channel;
+}
+EXPORT_SYMBOL_GPL(devm_of_iio_channel_get_by_name);
+
 struct iio_channel *iio_channel_get_all(struct device *dev)
 {
 	const char *name;
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index c4118dc..0a90ba8 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -13,6 +13,7 @@
 struct iio_dev;
 struct iio_chan_spec;
 struct device;
+struct device_node;
 
 /**
  * struct iio_channel - everything needed for a consumer to use a channel
@@ -97,6 +98,41 @@ void iio_channel_release_all(struct iio_channel *chan);
  */
 struct iio_channel *devm_iio_channel_get_all(struct device *dev);
 
+/**
+ * of_iio_channel_get_by_name() - get description of all that is needed to access channel.
+ * @np:			Pointer to consumer device tree node
+ * @consumer_channel:	Unique name to identify the channel on the consumer
+ *			side. This typically describes the channels use within
+ *			the consumer. E.g. 'battery_voltage'
+ */
+#ifdef CONFIG_OF
+struct iio_channel *of_iio_channel_get_by_name(struct device_node *np, const char *name);
+#else
+static inline struct iio_channel *
+of_iio_channel_get_by_name(struct device_node *np, const char *name)
+{
+	return NULL;
+}
+#endif
+
+/**
+ * devm_of_iio_channel_get_by_name() - Resource managed version of of_iio_channel_get_by_name().
+ * @dev:		Pointer to consumer device.
+ * @np:			Pointer to consumer device tree node
+ * @consumer_channel:	Unique name to identify the channel on the consumer
+ *			side. This typically describes the channels use within
+ *			the consumer. E.g. 'battery_voltage'
+ *
+ * Returns a pointer to negative errno if it is not able to get the iio channel
+ * otherwise returns valid pointer for iio channel.
+ *
+ * The allocated iio channel is automatically released when the device is
+ * unbound.
+ */
+struct iio_channel *devm_of_iio_channel_get_by_name(struct device *dev,
+						    struct device_node *np,
+						    const char *consumer_channel);
+
 struct iio_cb_buffer;
 /**
  * iio_channel_get_all_cb() - register callback for triggered capture
