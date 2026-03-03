Return-Path: <linux-pm+bounces-43493-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF5dIAPhpmkPYQAAu9opvQ
	(envelope-from <linux-pm+bounces-43493-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:24:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 613931F023E
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 14:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A7C830383DB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 13:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8625542F561;
	Tue,  3 Mar 2026 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pKj7WLGP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163F42EECB
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544215; cv=none; b=Vhg2oS6KchcolZOUwyEe3MiaEh/iu5ps8ohMWY0fUP2h/KQFB/4QZD1AfAJmNLzWuslg3O60fEZ5dQr5OyQ07sFcBPKQyc4S4f11kY5AVzpV3NaL3534vaSsPDfWxCtZnQgGsVScvP1r+WCTNlRYu5omHHBRF+ZAxLyXzlC5x68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544215; c=relaxed/simple;
	bh=y/DqFEmuuAqngsFZGp72PLnscTsfuWhm9dcxa38N2FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOrf9C732bqAUG9LPYL4k1tZfzRLBnFszICMaMkVlNjDp3H2J5oRjs86+6C197scv+9+SF0eAktSTp4veheRUcTRAZcDhFtmeK8tqGwq/F/YVJDwkdlIEo89MePBh1xU3G6k1JaSbcvQDxRr4RaZ1DrGKSyK2SHytuycP5JiOfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pKj7WLGP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38a1eb8b560so9319351fa.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 05:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772544212; x=1773149012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGEFbwaqUhjNwCekhYMgDEG4xaWMEQ4ewEceL5SvVds=;
        b=pKj7WLGPBYvYYo1/u9GYId2bHWjXOLKknnToMb8Vz5b1hVffPjOH93mFkvGyOlZjU3
         TxsA6cPSySSg4dCYppE6YN/kgA53OWi9srlfpa8VUjFGMH7d65biIMRzyII0nnRO5dgD
         L0sKtW1BNOYnc4kHoh2PedH4cUMWorndFfYXgEdh3fynYmj+KtT2u5UB3w22qqE3w/TU
         ot3jycLks0RQ1AW/BzEX8exRLYyy7evN/IZn8BNAoxL9tPuHy9UtPC8DU1u5e6LO5XNJ
         UnCjVrfYCSH+dtIqOqZ5liz80cbCQUZiJe1PAyBbGfdrjRA7ZjzJp06qrmXAc6C/7njF
         hoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544212; x=1773149012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SGEFbwaqUhjNwCekhYMgDEG4xaWMEQ4ewEceL5SvVds=;
        b=hgr3BTPvPtYRNEmtoSk/t4Gfm/t+X2qovAOosaPvHgG+WMLNY87XwRE8Ti/zu2aUwy
         DvxkPjmEnYXTqkLE6zL/Lry+I617rkpjECoNcuX8YNDAfHWG8Em2fPIV3hZbApUtv7a5
         Qsnk9UrKAKvQBLQ+K0xq9A6erYtwHJyzfWLlsVXMJ+5k/LaWW8YekKnFTJgv5mpkjNee
         QLjqfusRJEXKkKTpwubp4eHEazdLSa7Kc/GaAggFyP9z5Vm9yfRFM0Qv9mY/iEG5ObGC
         gBdt9to2nv7qDq2VxdRT3c0q+ejPgz05wxxvdVeeWEJ0BiGP3MAkk6XQr88ubj+Ssq6p
         aghg==
X-Forwarded-Encrypted: i=1; AJvYcCVkXEWSX+s0JJXA8H3n/R4RNLEMh+wNX409CFwCdesmQIGnpb83sTCajBXRCxOpcKExUpK8kXCXzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVno3NCi3X6zWGDpgvdEVkCSIF/wYa7kjBZ5KT+UhRKtpFYING
	xzt24Tuxdrh7W1JxHn0DYNOFUgjjk1KP4UjO5ycSufQ38gfl1Jz1cfBdGCbJaE7M4Xk=
X-Gm-Gg: ATEYQzwFOC61sKDxwtL6j0t4SO+yIHmKmnyIHLfTB0hkeKs7QX6MCLieQC5/SirrSZt
	sqVL6G25mqa1KGg793tGaxHs5qInq+YqMx3t1bXg5Lb21lMMyc6k2jGR1gU1OZ5+Rmzo0YEnHLA
	9blh7C55wTp8vsqzWSJofqjeTuCkyp27QA7whOevOuyexoRzVIplBQotkRd7mdnZLt7wsiOhCo0
	J7p+R3reooFsALW2gpMONen3scefuSPOxNhtFz8vpNf+Y6ksdtdx21jENK23hHgamKrW909xQZI
	kDvLuUw+kl6AUgjk7r2oqbXtKcNCBpa6UVWQSgYBFdBnxUlYHXuNwBchEQCeG/DeSK7LdDKLE8i
	fl5nLh+i53v10Y0lJ1Glplf0Crr3Mg6clfWas5qxZMYaaOYTQiMb4jjttpLuPP2ieMOFb7yd4W8
	N3JrJL+PaTMXuEBgT42BwQSOaoL/gYDTlIgCfKlgFdZspGKvKGS0QLRA7ROyE0u+Hy3EW4BDxdk
	6GdQRsoC3Y=
X-Received: by 2002:a2e:9a83:0:b0:383:18fb:fdf0 with SMTP id 38308e7fff4ca-389ff34fbe2mr88653161fa.22.1772544212105;
        Tue, 03 Mar 2026 05:23:32 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1235811e3sm587866e87.29.2026.03.03.05.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 05:23:31 -0800 (PST)
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
Subject: [PATCH 6/9] pmdomain: core: Export a common function for ->queue_sync_state()
Date: Tue,  3 Mar 2026 14:22:52 +0100
Message-ID: <20260303132305.438657-7-ulf.hansson@linaro.org>
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
X-Rspamd-Queue-Id: 613931F023E
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
	TAGGED_FROM(0.00)[bounces-43493-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,linaro.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Along with of_genpd_sync_state() that genpd provider drivers may use to
manage sync_state, let's add and export of_genpd_queue_sync_state() for
those that may need it. It's expected that the genpd provider driver
assigns it's own ->queue_sync_state() callback and invoke the new helper
from there.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c   | 14 +++++++++-----
 include/linux/pm_domain.h |  2 ++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index e0b9dd15a949..0b07b2d15969 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2764,7 +2764,7 @@ static void genpd_parse_for_consumer(struct device_node *sup,
 	}
 }
 
-static void _genpd_queue_sync_state(struct device_node *np)
+static void genpd_queue_sync_state(struct device_node *np)
 {
 	struct generic_pm_domain *genpd;
 
@@ -2782,11 +2782,14 @@ static void _genpd_queue_sync_state(struct device_node *np)
 	mutex_unlock(&gpd_list_lock);
 }
 
-static void genpd_queue_sync_state(struct device *dev)
+void of_genpd_queue_sync_state(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct device_link *link;
 
+	if (!np)
+		return;
+
 	if (!genpd_should_wait_for_consumer(np))
 		return;
 
@@ -2813,8 +2816,9 @@ static void genpd_queue_sync_state(struct device *dev)
 		genpd_parse_for_consumer(np, consumer->of_node);
 	}
 
-	_genpd_queue_sync_state(np);
+	genpd_queue_sync_state(np);
 }
+EXPORT_SYMBOL_GPL(of_genpd_queue_sync_state);
 
 static void genpd_sync_state(struct device *dev)
 {
@@ -2925,7 +2929,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		sync_state = true;
 	} else if (!dev_has_sync_state(dev)) {
 		dev_set_drv_sync_state(dev, genpd_sync_state);
-		dev_set_drv_queue_sync_state(dev, genpd_queue_sync_state);
+		dev_set_drv_queue_sync_state(dev, of_genpd_queue_sync_state);
 	}
 
 	put_device(dev);
@@ -3657,7 +3661,7 @@ static void genpd_provider_queue_sync_state(struct device *dev)
 	if (genpd->sync_state != GENPD_SYNC_STATE_ONECELL)
 		return;
 
-	genpd_queue_sync_state(dev);
+	of_genpd_queue_sync_state(dev);
 }
 
 static void genpd_provider_sync_state(struct device *dev)
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 7aa49721cde5..d428dd805c46 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -467,6 +467,7 @@ int of_genpd_remove_subdomain(const struct of_phandle_args *parent_spec,
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
+void of_genpd_queue_sync_state(struct device *dev);
 void of_genpd_sync_state(struct device_node *np);
 
 int genpd_dev_pm_attach(struct device *dev);
@@ -513,6 +514,7 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 	return -ENODEV;
 }
 
+static inline void of_genpd_queue_sync_state(struct device *dev) {}
 static inline void of_genpd_sync_state(struct device_node *np) {}
 
 static inline int genpd_dev_pm_attach(struct device *dev)
-- 
2.43.0


