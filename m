Return-Path: <linux-pm+bounces-29894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B5FAEF70F
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A2C442735
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4612741B3;
	Tue,  1 Jul 2025 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7oAM1XB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C95273D6F
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370473; cv=none; b=Ww9Rx3E4DBUNFwRSi2z4iJU49QqCQcPW5MbIx0dPVjz359DYkA2db1+Dr69rkhzxfFTXY0kKaiXZfkGzSoSSi6mZPQB+dbppCc1hRPkIuqnJhbrr85FrXFFiwzNbXZt8923wu6XrHGM3NSGuvwqSmuk5ZmrbJxDEyJAhOVw99mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370473; c=relaxed/simple;
	bh=vaFOqCI5djpScYcqXyC+q/cAcrHuyrRIVEA7y07/NSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZdMWG3tPBYLyIr/bdAUDyN9Mu9zydNM4wi6/bxY6cMr/rbXTAD+cTwdKL93E961Ei4tBXBi7KzGpNA93C/KzsySqF6wm+9//y4AdmoCsvZ42phiitHLUaTMdHoIyOrhkgutfY0aZdyFZI5QT0GfYLH6+y7WIPAm4HA6yMVNY64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a7oAM1XB; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553b6a349ccso3580483e87.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370470; x=1751975270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZOLfR72PXqOLw5WtFWDE/MmTe35xsn3qkEJhynzf0Q=;
        b=a7oAM1XBPf06BELVGcVNSDTsHQo3E3VCyA5lvWmm+nXMybgoQc+P/gQKU0Zrn+X+jX
         KxR6i8mMm5JtOnyN4i+4GVZrItVij64kH5Y7Zff1GPZ6mC+IMr2/VWR2NVEaRhB0dnxk
         ez4bHE4AyBQLkcYl4DvptRKyolVknpe8YqKlfI4l8dcBSqL7byXwBzUyoM3eAfcyVLX4
         1yEYCz0M17T8D+6NjV8yUUghdQdHq9OHBGh2FrT/7Gj2zYbvUcMaSxDlpP5tpjpflGHU
         uflyTRs2ro0GtDSvt81B9p02pfR279e6f2Xtw+9MNd5xrPlUATEaIWISHNRAa/GBebsb
         AXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370470; x=1751975270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZOLfR72PXqOLw5WtFWDE/MmTe35xsn3qkEJhynzf0Q=;
        b=wFy5hLBVpexXC1sKBTvbWFwFiOvCbPz0n9Agv5dFejF9gjYwuzLlebZ/uQMBhdzww+
         Ftqy0aJkikt+KBBEP8nXFHWe7RmLTI2cq11+K/i6uWELG7vIIvkaSJkWsIuCEuZbZ8AM
         HiXR80GvBBuEzg/x2m9hvwObUh2XFsdt9ROxru/bDTB91FBypWC0uO83uvLzZeY3GdKL
         /gYVJj5KX9hIux4jYza+TEVCWY0Pf749ZV1jk1hfw49jONtNi7J0+2+r8zrnyHMKG1PN
         3EJK4HSiLXGKYu4cXcKM8IAZ3wxhxDzTFuZgYvfkI24W58S2NxROwSd04gKJK12iKKQd
         zZBA==
X-Forwarded-Encrypted: i=1; AJvYcCWHWPixHfUIuu6hnqbGnjpfivoj+BQw9QnrQHJYLNzfOWQi0tQEzcDsNveagd+B8wPBUB+jfrIheA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTiU0c4zouYKWlUJ52Bkr8/cgxMS9VJ5obTROytmerEH567ZpE
	Uhqxr5TNuiPChvApiEA7duFvTFOy4af+FaM9Q5ePrVwatLE1ixUaQWj6U07Tf76FWQ0=
X-Gm-Gg: ASbGncsH99Gmfmrl3hVi2ibTi8iwNmKBu0BGIIOsz71RbyyHSuerIM+LGdRLYiRmjZ+
	PdgFfUvt/Nvj4hJxbXu+f/TsHvjRikGTl1NnWYclZSBBLq7JwetdQUKNANMm2xm4WUmrZXFiEYX
	bQdjeF8VnOBY/8d1nJQHW3Zs0AP43ACRHXC+Waseljp121AImLeNQCEe8ljew1QVo6gH6AyklOC
	MeeOZwX52/UEYR+s/NlpYngJC63U1nVUiukGvwEgt6wxszByS0L/ePi+SrUYoqxxmcncfnV4uc8
	ry2Au33jiWBiNGUX3nCwECsWEm2O5pdIOfHcSEWe/y6OvVBNfykZqIPbzsbI57TLhzlBe7zI/9e
	haR0H7LTLq/udojZKV/hDkKVBu+shLsKecTu2
X-Google-Smtp-Source: AGHT+IEFlqH5aVFiMAtrKQEMVhHjR3b0DQN5zCXSWC23vo3ub27qmEf/97Rk59xwHI3Cjb9MA+KM7g==
X-Received: by 2002:a05:6512:3a86:b0:553:a272:4d18 with SMTP id 2adb3069b0e04-5550b82b648mr4551995e87.20.1751370469527;
        Tue, 01 Jul 2025 04:47:49 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:47:48 -0700 (PDT)
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
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/24] pmdomain: core: Prevent registering devices before the bus
Date: Tue,  1 Jul 2025 13:47:06 +0200
Message-ID: <20250701114733.636510-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701114733.636510-1-ulf.hansson@linaro.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We must not register a consumer device to the genpd bus, before registering
the bus itself. Even if this doesn't seem to be an issue, let's add a
simple check to make sure we really avoid this from happening.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- New patch.

---
 drivers/pmdomain/core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 9a66b728fbbf..93d71164fc56 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2491,6 +2491,8 @@ struct of_genpd_provider {
 static LIST_HEAD(of_genpd_providers);
 /* Mutex to protect the list above. */
 static DEFINE_MUTEX(of_genpd_mutex);
+/* Used to prevent registering devices before the bus. */
+static bool genpd_bus_registered;
 
 /**
  * genpd_xlate_simple() - Xlate function for direct node-domain mapping
@@ -3179,6 +3181,9 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	if (num_domains < 0 || index >= num_domains)
 		return NULL;
 
+	if (!genpd_bus_registered)
+		return ERR_PTR(-ENODEV);
+
 	/* Allocate and register device on the genpd bus. */
 	virt_dev = kzalloc(sizeof(*virt_dev), GFP_KERNEL);
 	if (!virt_dev)
@@ -3357,7 +3362,14 @@ EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
 static int __init genpd_bus_init(void)
 {
-	return bus_register(&genpd_bus_type);
+	int ret;
+
+	ret = bus_register(&genpd_bus_type);
+	if (ret)
+		return ret;
+
+	genpd_bus_registered = true;
+	return 0;
 }
 core_initcall(genpd_bus_init);
 
-- 
2.43.0


