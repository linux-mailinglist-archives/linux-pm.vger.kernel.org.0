Return-Path: <linux-pm+bounces-27582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53746AC245B
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3575545400
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD5A2980D3;
	Fri, 23 May 2025 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmOOZ6Hs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E4294A07
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007680; cv=none; b=lVPkWQ9zB34BhAoI33sle2MViWqp6Whu6dxXOJx66r937Dx9gKonFL2k0X1cGXWx8AHgUYUu7AP7YrYl2iqjuc6nOFt9UJk9GgNcmRWuTbRQd87T8gDnqNH5HHmpujJtZ7cOhYJK4zkkQm1vSBWRc1UFrcGbFCLhnfxcsMhJnCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007680; c=relaxed/simple;
	bh=NN3Crtgicr2RANdkx4XpcfEgrbjiC/nyTFX0TvsgmcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hq+mdkZwUjF6JPYeQm11ylIjl6ONh3VP02ncAQ4b0Uvprx4/GRaCKlZfF8rmEYlPQ2b15v8xiLXIrbC+2gxGnjFVjkgFCOdPYvgE5NuKyizb0zVqaAUe/1fHWBICvqV0x/y5iKhyNS7yBBaNJJdUAYHSrQ7LAy9cIKin+T5Q2s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QmOOZ6Hs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so105666625e9.2
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007677; x=1748612477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71f6dv8Oj3Q5ky21qEIlnyYawuoQhOrGkPFVRB1RoRk=;
        b=QmOOZ6HsCKyJLrz1mLizI/tgjEbdw5BkTVRL+G8Z/34FC0PYAaU+lvVx9ui/xVMlse
         4Gz22ERx5TDlx/8kutNUMOTdE+95JEkncjaQCzzcwqRcUIgXaSE+cKflFJKeCiQ7f4X8
         LBFBG9w9gRsnM61XVCOt+4CHca8Zwwp2ossjh7gd5dIeuaH4pJZPeN0li0yVmKCjQnfL
         vsroWu0lbOAzFELcxdqUzVBGKDnOUDJYV562A8AFIUA2jDgGWm1smi5FRhXi1heVk5PR
         eOJgG9EO1+dLY2tiiIr+kQYZByLCQfSSVXOUxM/bsFrHyLP/tvTkIqK8iKED9z/L6Nen
         ZS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007677; x=1748612477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71f6dv8Oj3Q5ky21qEIlnyYawuoQhOrGkPFVRB1RoRk=;
        b=mq5PDvuO5JrytTHqm7OKU0QftGb8C4ZQ0Ssz+F00hk04yTI1rZsjixf42ER8iSEz6G
         j5xi58wOO3XWp8wHog6eqOvBTmwwPVhMmxwQZ6QEUig0txa84rYZAzZfEgojhntpmyaY
         umH/7EcEHijlyq6RHIgZo7zM5oBv7x0ISFAwsfTkHo0+uR70WaRn/7IbXZOLGJrLNeYF
         /aiLM0NE4yW/jxHYKvBXNrjHai3lT6fr/JPRbsEcZi+owa1DRedCW1tank9MD4RKAmyD
         7SYjREnDgnHpHcyEV9kmWobrDAUA4Z9XoYhzWFSxpOVYGopFSkgR0lW075iQ2WrYKBoN
         0Y5A==
X-Forwarded-Encrypted: i=1; AJvYcCWgEkO1kZJ4GJ/osHF56gyn3VUTwwaCKk5kclI5BTKBRzDL1ZhWubWXstCbJYcD/Qy5UfTqIUYiHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqE73TQpnjA5kMzlGZZ0f9G481vd0UCS8xijoFek6/74Z8MPTi
	NWvPwoghmM0qv7f4jzz7DOTLWyltLsTw2dgJ0Gibi4CmzzXFIRepkiQz61Y58UAdog6ACqI9smH
	GvZvnaBk=
X-Gm-Gg: ASbGncu8Jahpu5gj3HUn/RG9yZZp5Ja/lOHMWhv21aGgfqLTGP18cL3bmKMNWo3oBTq
	YTWD6tSn/9qctSOnMA7sASRtZ+sTm8sHvNZxI0Kh2CtOCPzu9WbEGdaYXa4dwvUAh3v053DOk/i
	p/fiZ15ROQG+kC3RioUqzJLgqK9f9YSEiUE0Ym/OLN7e5Sx82yAmgiaGiG5szSQgJfGGBfPihZj
	UrfAW2T2RUy+edAsLWl75GSEhXL5t/IqObFCYZ3vODlVRS4+AR/Cfi+NsdBSa2QzYEk8mXXq4yy
	quV7piENxNtZn/PEp4XL2PFA0W0YVAvfD8ZOTSR42IaAW1c/dRa3RSKaZY7EJuaU8tYugmSxsen
	7EhSl41fRv6vA+TVBKsRPpJywLw==
X-Google-Smtp-Source: AGHT+IGFndHOIFZSsgQfYdZw+/8HGCKSecirkmKfEr0kpQ5LrWHxETwwaD5/Fwd9r/MLkzRBHLqG+Q==
X-Received: by 2002:a05:6512:b9d:b0:54a:d68f:6ecc with SMTP id 2adb3069b0e04-55216df94b9mr843157e87.2.1748007667241;
        Fri, 23 May 2025 06:41:07 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:41:06 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/21] pmdomain: core: Default to use of_genpd_sync_state() for genpd providers
Date: Fri, 23 May 2025 15:40:14 +0200
Message-ID: <20250523134025.75130-18-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unless the typical platform driver that act as genpd provider, has its own
->sync_state() callback implemented let's default to use
of_genpd_sync_state().

More precisely, while adding a genpd OF provider let's assign the
->sync_state() callback, in case the fwnode has a device and its driver
doesn't have the ->sync_state() set already. In this way the typical
platform driver doesn't need to assign ->sync_state(), unless it has some
additional things to manage beyond genpds.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index c094ccbba151..b39d06d3ad26 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2621,6 +2621,11 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
 	return ret;
 }
 
+static void genpd_sync_state(struct device *dev)
+{
+	return of_genpd_sync_state(dev->of_node);
+}
+
 /**
  * of_genpd_add_provider_simple() - Register a simple PM domain provider
  * @np: Device node pointer associated with the PM domain provider.
@@ -2646,6 +2651,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	if (!dev && !genpd_is_no_sync_state(genpd)) {
 		genpd->sync_state = GENPD_SYNC_STATE_SIMPLE;
 		device_set_node(&genpd->dev, fwnode);
+	} else {
+		dev_set_drv_sync_state(dev, genpd_sync_state);
 	}
 
 	put_device(dev);
@@ -2715,6 +2722,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 	dev = get_dev_from_fwnode(fwnode);
 	if (!dev)
 		sync_state = true;
+	else
+		dev_set_drv_sync_state(dev, genpd_sync_state);
 
 	put_device(dev);
 
-- 
2.43.0


