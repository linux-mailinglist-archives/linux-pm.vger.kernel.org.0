Return-Path: <linux-pm+bounces-43491-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AODDfTgpmkPYQAAu9opvQ
	(envelope-from <linux-pm+bounces-43491-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:24:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C86341F0211
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C877303AE51
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FE342E00D;
	Tue,  3 Mar 2026 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ebZgW3Nr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA3428852
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544213; cv=none; b=cvk813IKyD+Lm/9Mk9zJ7+9op72bDCu4oLsmQ0HkR3uErsPFz+nT2sQXmUGRimRZTGP0DC/mlZtp0rYUujWR76NYbA0fG4SCbmEuxHtbsiHvsxhMEeGMlX1dqrtAqDM+a2anmcdX0/9BGlzHq9Fx2/ISWr7GEWDiyUPuRYdaZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544213; c=relaxed/simple;
	bh=KqwRlC6a0mFJBPkblfsKOEZY7P0vlTLRhRY9ZzoVEss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzsGqya/Ceozd9+ulJvw/EmuJzmB3YBz8D4YFlmUPY4j21zkI02D62zAHDdlVH3AOyTXo0+41kwsOpVVtPL+wYxEiUcH2OG4KJSMaquxfWoerqiL3Be7lgh2aucW1NNrbQkeBV0DKmG2gSbp9gpgmqm/fVWGkEirsXkLSLi4BeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ebZgW3Nr; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a23cf08e0so4590171fa.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 05:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772544210; x=1773149010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SAiIzSfTMRShdXJxCInhMGpqoMCKhmfdktkL1GCb0E=;
        b=ebZgW3Nrqb81MdqiZgEgQPDhRcCC42qgUPPd+lzVy0DpJfbQjs2pSh+O9MMJem0h/+
         8nxIyUw6cp+7tb0lNMGGXJXJjbpjer3TtuHU/+ahnqLkqG57iQa8NL+GKwwWFvPBrPYq
         n0S3c9Js+EqHXNB9CQ3g0GpA0SyU/J3B+810GnsfE6a9OiaMe2ZkcjAiQGrv2SCJ/Nqn
         vcpz1q+WPztpWZL01CeiJXSA45MvD3CUIjiQrPdWFjzD5/I9PpIFZkIPEDPojX9F19X8
         0IlvyIzbCCSNt7l6OP5RSTv9sYbQP98nsDB6Yzmcrggdrsssr1JE1dQlexGipyAUHum5
         jitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544210; x=1773149010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4SAiIzSfTMRShdXJxCInhMGpqoMCKhmfdktkL1GCb0E=;
        b=ffbGeQaulBL8XYI/DzUppPWNZHyOthpABBO9ko9wjfYCCIlmsqom5XVoTWpdNFDrY4
         MWkABG3DA72/P8GZG1smUrFUXStxlbVEQLsZ5HINB/pGEnZikkxCePwK4R2UxKI0j9w3
         EhcpgYK6OZxOcui3Jsz2Fct2NvMF6j58WePlgDJAVDV4lH0lN90zPzHSr3m317xwzh9n
         s7bZm2HFf03+0E4voLMlH//DaxYLHMtLQD9qYFYqKbIIs+mOYt2uOxxRFrOnySZ5ne9K
         5IchxKNciAi8XeUr1ajbw60JdnSe5P7ooeybirbmgfapHFkgMiJ8RtfAQELvPxUccBuV
         5Lxw==
X-Forwarded-Encrypted: i=1; AJvYcCVFuuvaY2hjIP7K4zv28KMOZj5ZqF03wH7znCGzfmkcLojFbVtmKHVSFeuZWVcMtVUxZZYRE33EyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF9kTl+/dSrXbN2gplzGtj03riNovRgO+KanwD8sZD+d6flsAm
	8Dj/HqFw6qgHUAZIDoKU1lavRj6JtJIuL1oiNSZHJWHrXo+BPJl2OV0I+LCGyP66Mos=
X-Gm-Gg: ATEYQzxukKGWpVFMWOExHbh78HikuGJy1By/Tt8x4okafoxNdnVNCMPkbQEtJIjnptd
	9yoEHAC9DRSARsQZxxrpHmygO29WyHcNUzSWhRY4W9aXsDCOkELNWOuTceRoNRIMOaciwfbkJuf
	lD2pcCdwN5PAKzeTTOv26t0J7l0dA8dYLfQQrMgH3kZYZFD3Fmc6k/ZJ9n/jPctvIzYto8zPLTl
	E12Xe9PULYluvJy9SJSi818Mit5cp7NaqBuEclWCJh6FI4Pf75bTwzfZh/lvO6rBUjcAn4/g6KH
	96tt5I1AehqTQ7kjEza2zC650bbb+3agb+BpjOjlEKQ+jIAroMpSBk+oNpdd4shla0SegjRg2fl
	6/h/ySeThjdJOWuqMl0PC1tlyCHq7VxRCNtAL/wqtymrNi8IxtbTa3onF9rSPM1BisxoJYldsAv
	XAPHE/cy6lFp0BCNfzF43j31g+p9T8sxgjubyUlHXk4m5SUJ9xsm8XMfQ6TP5YAaaqxtaLX6pT
X-Received: by 2002:a05:651c:1c7:b0:387:17e6:1dd9 with SMTP id 38308e7fff4ca-389ff34cc65mr108309141fa.23.1772544209839;
        Tue, 03 Mar 2026 05:23:29 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1235811e3sm587866e87.29.2026.03.03.05.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:23:29 -0800 (PST)
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
Subject: [PATCH 4/9] pmdomain: core: Add initial fine grained sync_state support
Date: Tue,  3 Mar 2026 14:22:50 +0100
Message-ID: <20260303132305.438657-5-ulf.hansson@linaro.org>
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
X-Rspamd-Queue-Id: C86341F0211
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,samsung.com,oss.qualcomm.com,oss.nxp.com,ideasonboard.com,gmail.com,nvidia.com,linux-m68k.org,linaro.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-43491-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,linaro.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,pd_args.np:url]
X-Rspamd-Action: no action

A onecell (#power-domain-cells = <1 or 2>; in DT) power domain provider
typically provides multiple independent power domains, each with their own
corresponding consumers. In these cases we have to wait for all consumers
for all the provided power domains before the ->sync_state() callback gets
called for the supplier.

In a first step to improve this, let's implement support for fine grained
sync_state support a per genpd basis by using the ->queue_sync_state()
callback. To take step by step, let's initially limit the improvement to
the internal genpd provider driver and to its corresponding genpd devices
for onecell providers.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c   | 128 ++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h |   1 +
 2 files changed, 129 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index ad57846f02a3..53401db2a386 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2699,6 +2699,123 @@ static struct generic_pm_domain *genpd_get_from_provider(
 	return genpd;
 }
 
+static bool genpd_should_wait_for_consumer(struct device_node *np)
+{
+	struct generic_pm_domain *genpd;
+	bool should_wait = false;
+
+	mutex_lock(&gpd_list_lock);
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
+		if (genpd->provider == of_fwnode_handle(np)) {
+			genpd_lock(genpd);
+
+			/* Clear the previous state before reevaluating. */
+			genpd->wait_for_consumer = false;
+
+			/*
+			 * Unless there is at least one genpd for the provider
+			 * that is being kept powered-on, we don't have to care
+			 * about waiting for consumers.
+			 */
+			if (genpd->stay_on)
+				should_wait = true;
+
+			genpd_unlock(genpd);
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+
+	return should_wait;
+}
+
+static void genpd_parse_for_consumer(struct device_node *sup,
+				     struct device_node *con)
+{
+	struct generic_pm_domain *genpd;
+	int i;
+
+	for (i = 0; ; i++) {
+		struct of_phandle_args pd_args;
+
+		if (of_parse_phandle_with_args(con, "power-domains",
+					       "#power-domain-cells",
+					        i, &pd_args))
+			break;
+
+		/*
+		 * The phandle must correspond to the supplier's genpd provider
+		 * to be relevant else let's move to the next index.
+		 */
+		if (sup != pd_args.np) {
+			of_node_put(pd_args.np);
+			continue;
+		}
+
+		mutex_lock(&gpd_list_lock);
+		genpd = genpd_get_from_provider(&pd_args);
+		if (!IS_ERR(genpd)) {
+			genpd_lock(genpd);
+			genpd->wait_for_consumer = true;
+			genpd_unlock(genpd);
+		}
+		mutex_unlock(&gpd_list_lock);
+
+		of_node_put(pd_args.np);
+	}
+}
+
+static void _genpd_queue_sync_state(struct device_node *np)
+{
+	struct generic_pm_domain *genpd;
+
+	mutex_lock(&gpd_list_lock);
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
+		if (genpd->provider == of_fwnode_handle(np)) {
+			genpd_lock(genpd);
+			if (genpd->stay_on && !genpd->wait_for_consumer) {
+				genpd->stay_on = false;
+				genpd_queue_power_off_work(genpd);
+			}
+			genpd_unlock(genpd);
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+}
+
+static void genpd_queue_sync_state(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct device_link *link;
+
+	if (!genpd_should_wait_for_consumer(np))
+		return;
+
+	list_for_each_entry(link, &dev->links.consumers, s_node) {
+		struct device *consumer = link->consumer;
+
+		pr_info("%s:%s con=%s\n", __func__, dev_name(dev),
+			dev_name(consumer));
+
+		if (!device_link_test(link, DL_FLAG_MANAGED))
+			continue;
+
+		if (link->status == DL_STATE_ACTIVE)
+			continue;
+
+		if (!consumer->of_node)
+			continue;
+
+		/*
+		 * A consumer device has not been probed yet. Let's parse its
+		 * device node for the power-domains property, to find out the
+		 * genpds it may belong to and then prevent sync state for them.
+		 */
+		genpd_parse_for_consumer(np, consumer->of_node);
+	}
+
+	_genpd_queue_sync_state(np);
+}
+
 static void genpd_sync_state(struct device *dev)
 {
 	return of_genpd_sync_state(dev->of_node);
@@ -3531,6 +3648,16 @@ static int genpd_provider_probe(struct device *dev)
 	return 0;
 }
 
+static void genpd_provider_queue_sync_state(struct device *dev)
+{
+	struct generic_pm_domain *genpd = container_of(dev, struct generic_pm_domain, dev);
+
+	if (genpd->sync_state != GENPD_SYNC_STATE_ONECELL)
+		return;
+
+	genpd_queue_sync_state(dev);
+}
+
 static void genpd_provider_sync_state(struct device *dev)
 {
 	struct generic_pm_domain *genpd = container_of(dev, struct generic_pm_domain, dev);
@@ -3559,6 +3686,7 @@ static struct device_driver genpd_provider_drv = {
 	.name = "genpd_provider",
 	.bus = &genpd_provider_bus_type,
 	.probe = genpd_provider_probe,
+	.queue_sync_state = genpd_provider_queue_sync_state,
 	.sync_state = genpd_provider_sync_state,
 	.suppress_bind_attrs = true,
 };
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b299dc0128d6..7aa49721cde5 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -215,6 +215,7 @@ struct generic_pm_domain {
 	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
 	bool synced_poweroff;		/* A consumer needs a synced poweroff */
 	bool stay_on;			/* Stay powered-on during boot. */
+	bool wait_for_consumer;		/* Consumers awaits to be probed. */
 	enum genpd_sync_state sync_state; /* How sync_state is managed. */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
-- 
2.43.0


