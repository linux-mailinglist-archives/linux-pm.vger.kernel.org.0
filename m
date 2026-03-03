Return-Path: <linux-pm+bounces-43488-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOAlJAHhpmkPYQAAu9opvQ
	(envelope-from <linux-pm+bounces-43488-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:24:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8AA1F022F
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3F73302826E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A86426ED5;
	Tue,  3 Mar 2026 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGiQqSp5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC943AE1B0
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544210; cv=none; b=GV+lsALLOt4IHYYSgsZtKsV0tsbaCkk9meEs5ZFPRGGf4ZsSOOeEvFTON9u89iSeeWXoRWs7kI4ajpACss+QBkmEF35UpLmFl3qvgxQc3DL5nE7dmKr/cFMQsCqzaExtSK4hg0VOSQZ2HHolJXJKTP3ImEjIltWTILhhfaKEbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544210; c=relaxed/simple;
	bh=ryqZNJNqA365MRETYNHzz0EgbqcaPN3QUhG1y3UNT1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ha2bW11LleNNHrM6YtWO9dSuk4BUMg2LTUUh8J+4EF1Apuj2dkaXjg0fdqWWXVhR/0pLU/URIwzymUyc8wq6LLigy0Ki6ib/K1GBefD1EMzMkBoVAIdZUjwUMOkvxV1ZLNyR6ifEOeTo9CTxVQIhodGJWnvldzQi241/VSrcx/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FGiQqSp5; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-386fb2c31e2so100607571fa.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 05:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772544206; x=1773149006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DY+Uv5zbRZBrLkNEfOsAHSSzgZnf3SBlBifVwXPv9CE=;
        b=FGiQqSp5IG0COcpOM7SJNzO17LE8sv93D+xXaEHMFkO04tU5VOyrTgE0yW2GeAHkVn
         EEXcWqM8g/ryaLhTbYoWto66jlo4BKe6ZODaJ9FJBWRuLiTQr5CU+cgFMGOaBn1h1Ue3
         /ouIOdZsKx5po6Ux4HdoxsKHt4O2cAx5+CN4NipbwkkTBTZwtpghO8pOEuAtK/bK5Xha
         hFjWN+IlwLxweCMlfNnn+fiRe3A9jmlRQ1s4MoSFrgXE5sNczlOWbg3hzPf08viabZd4
         ZzTEj2YI+PhpJMuSYzpwoRk5robWrvhGsNI47Cnwcc5ECkgXBEg+RHX4iuKxVBap/maP
         B9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544206; x=1773149006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DY+Uv5zbRZBrLkNEfOsAHSSzgZnf3SBlBifVwXPv9CE=;
        b=fn4NC9tXdoXWj0+IaQjNnSPF92QQ4yMpFeEMb58v5jAqfXDQx0TTtTSm844+TeQK4/
         7lM7LqSUNCkHQ4sgmJZE1cvet7xjDC8iAvIRBM8yPU6UNmm28bDOxNM9mu15NDSKG1mp
         4UZxhxVailJHaa8XpEkg59JXfZ1u8+2IWU/4LRKU36SCKZYPuT82W5W+wXN3V++jJUfb
         o2od/9Zgcuao52oQYKXSfgskuc2Lnf5ybUcfbHA6/qGrdM84FxZpO6HP/s+pIzpcm4y1
         FHbcGaX/rwyzgqW44zM4qiQ34lO1jJwno4jpvdzTKi3zXoUuyjGXItAv+OMFxezLwD64
         Aftw==
X-Forwarded-Encrypted: i=1; AJvYcCW4B8BcgSmHjdF+Cx9yI4LSdzPPbybG/pQWT4xblSX2MwUlVFSQxX35fgmjMFwS/KKCt4uobHjmLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3o4TH/5fKrPLpwQfrC7s/d4qGsCvJ9qJpBu+PNagY7kEl+tzy
	d8KvBJHOB7XOJqY+oYiwPxqa4bz1GhK9wpwEonBv+N9vHH7OqeGICqpQFBBByPxQ+2g=
X-Gm-Gg: ATEYQzyaxnjpEpXRrT7Tm9PlMJjahsTE/ij/m6lBRructPNgfdLnSaoCfQDS/PNeAoN
	BbeSgCtIcLwBszw7iOB8RyAAe8Mjg1RUS28wewddYa+rSNxW6VGyherCiTp9SedSkFEHG7DsAsi
	B5UTEvNbRiZID5tvowWmFyfQzJItxo4Ue83GtLu/yNxInXf5iWrpX83YoE3/kgPOqcAgG9/bh9f
	ni/NBc3WXoKUkHjQZrH0TIDt6TR9B1kO7KLJFQRYHTnljh3rWM20OZzz94LXs26ho8r6AJ5vQgx
	EjjQ1pvlxqzLEYP3oVUBU4zYe7SEgRXQ87FjsxoFLlU8WNZMiZ2cpFz64HEv2+FYj9vXRn+LinH
	sOMSNigKc5POFgpbUq3N3vyEbPf1GU/Jp+r9aCuayvndxOamieWwe4aPsb/G75m+3Hza9f+fBFl
	jGS8vgvcgpuoC/z6atZjhV2el//yAHyuTgepvt8b9kSN9SPPu0nsmPNci9eajbPdfTrWO8CcIS
X-Received: by 2002:a2e:b896:0:b0:389:fd52:a1d9 with SMTP id 38308e7fff4ca-389ff141f4fmr91698381fa.14.1772544206259;
        Tue, 03 Mar 2026 05:23:26 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1235811e3sm587866e87.29.2026.03.03.05.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:23:25 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] driver core: Enable suppliers to implement fine grained sync_state support
Date: Tue,  3 Mar 2026 14:22:47 +0100
Message-ID: <20260303132305.438657-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303132305.438657-1-ulf.hansson@linaro.org>
References: <20260303132305.438657-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9A8AA1F022F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,samsung.com,oss.qualcomm.com,oss.nxp.com,ideasonboard.com,gmail.com,nvidia.com,linux-m68k.org,linaro.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43488-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linaro.org:dkim,linaro.org:email,linaro.org:mid]
X-Rspamd-Action: no action

The common sync_state support isn't fine grained enough for some types of
suppliers, like power domains for example. Especially when a supplier
provides multiple independent power domains, each with their own set of
consumers. In these cases we need to wait for all consumers for all the
provided power domains before invoking the supplier's ->sync_state().

To allow a more fine grained sync_state support to be implemented on per
supplier's driver basis, let's add a new optional callback. As soon as
there is an update worth to consider in regards to managing sync_state for
a supplier device, __device_links_queue_sync_state() invokes the callback.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/core.c           | 7 ++++++-
 include/linux/device/driver.h | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 791f9e444df8..a262714a83b6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1106,7 +1106,9 @@ int device_links_check_suppliers(struct device *dev)
  * Queues a device for a sync_state() callback when the device links write lock
  * isn't held. This allows the sync_state() execution flow to use device links
  * APIs.  The caller must ensure this function is called with
- * device_links_write_lock() held.
+ * device_links_write_lock() held.  Note, if the optional queue_sync_state()
+ * callback has been assigned too, it gets called for every update to allowing a
+ * more fine grained support to be implemented on per supplier basis.
  *
  * This function does a get_device() to make sure the device is not freed while
  * on this list.
@@ -1126,6 +1128,9 @@ static void __device_links_queue_sync_state(struct device *dev,
 	if (dev->state_synced)
 		return;
 
+	if (dev->driver && dev->driver->queue_sync_state)
+		dev->driver->queue_sync_state(dev);
+
 	list_for_each_entry(link, &dev->links.consumers, s_node) {
 		if (!device_link_test(link, DL_FLAG_MANAGED))
 			continue;
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index bbc67ec513ed..bc9ae1cbe03c 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -68,6 +68,12 @@ enum probe_type {
  *		be called at late_initcall_sync level. If the device has
  *		consumers that are never bound to a driver, this function
  *		will never get called until they do.
+ * @queue_sync_state: Similar to the ->sync_state() callback, but called to
+ *		allow syncing device state to software state in a more fine
+ *		grained way. It is called when there is an updated state that
+ *		may be worth to consider for any of the consumers linked to
+ *		this device. If implemented, the ->sync_state() callback is
+ *		required too.
  * @remove:	Called when the device is removed from the system to
  *		unbind a device from this driver.
  * @shutdown:	Called at shut-down time to quiesce the device.
@@ -110,6 +116,7 @@ struct device_driver {
 
 	int (*probe) (struct device *dev);
 	void (*sync_state)(struct device *dev);
+	void (*queue_sync_state)(struct device *dev);
 	int (*remove) (struct device *dev);
 	void (*shutdown) (struct device *dev);
 	int (*suspend) (struct device *dev, pm_message_t state);
-- 
2.43.0


