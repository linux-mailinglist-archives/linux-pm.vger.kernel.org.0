Return-Path: <linux-pm+bounces-27577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFD2AC244F
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1931C072FD
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B35296FBB;
	Fri, 23 May 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ep/ddSDV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144B29374C
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007669; cv=none; b=GAZ/VMB+D+Lzs+vEcP9XXxCMNeDO9NQOaTNYEcHFFxs514QHEYBJWQ2/ERjCmpkxG2hDWrOVRlhDvp6mA/YxEcNioTRyiZpRp0xCXWzvQHpi7XDKPvUNMBpCq5STqboQKChyQf4Z4wL9319kLIXQIryKPt50Q03uyGTkbF0xMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007669; c=relaxed/simple;
	bh=pJSLQthsbZ1x5UaqwSUyIjHPGHXE3quITyYFZ8WQSC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQy9ZnnEjd5iadl+TRcVtR605+n32LCTH90IrHmcv+xBz+3q8MEHWPfEWOfI76GXdysk0nJviQ51RMWBgOYyWmikNqF36J3UzSiwzdI2zOY8XNhToayiOqlHFqBcHDcq0FM6i9T2Uf6/sJtipNPCeNbCx4HPWql/yteHpA1Dt3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ep/ddSDV; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54d6f93316dso11147007e87.2
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007666; x=1748612466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+GVQQEW/Nx5/3Tw2jXG/FjfLcvR6Pq+aehkGjHuNLA=;
        b=ep/ddSDVVRlJQ8yD+RSZmdrgb7qjpJiomJ4UhC9j83V6yTN+mkJzUIKeJhLfZeSFdt
         B/s7mkn+7t53EwepuIeyu8wC4ZS12Tx5wMD8c764+35GzQQ0nIPKtt6AVGAQTtAUWQM/
         Yjk+CTmhhIUJhHDBpurhAAw1ruGlVol9K0VOmIykgamgufoLUEnJ1IxrBkyZ8zuE2v0h
         Tc2H04BpJVySpm3MlzoKdM3X1vt+yYkCDX/FYEKAmT7kjnXz35ydC3IEYnCnVck5AesD
         bkV33OIia9dY4Ltcz3Qty2CRpcao8PZQNFEszx9ZxlTUain629U1zBjqctbz3woC1JzS
         IXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007666; x=1748612466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+GVQQEW/Nx5/3Tw2jXG/FjfLcvR6Pq+aehkGjHuNLA=;
        b=syaNiO5zGUXho7SVLmgwuOkJiZKj24Fdg1njftUsLMgWBszxqoih/R1GnECuUON5nG
         bvuq8sCTje1vpG55YKuPTPeyhUl+q1RYGfey8Y5rcsZ+ObuOflT0Mn1Nw9uo8My7Nc+7
         denhWswo7PDk8lhcNQLeV00glesv61/hkFCQa4dX+wpG84gkfokWpiW1DfMdWG9fMyfK
         MA0KOYf85k0QaxbxtlLsouUzngFCHSWAOlg8qvzEmG2iZDO/d55n0I4nuly+rffTKsPI
         xJGcR9DbxIJ9GTJwkc06pAWKvv6jrsPSncaFKru1WkQuSg+9vQu3CQrvZThOG5pxgfXu
         /4zw==
X-Forwarded-Encrypted: i=1; AJvYcCWa7dgfSd1a5muRUTiufoROnBFnGCAPIVL+GT0SZI7kWJMD41lrrXojUTRXIVPfRrbzok525vbqTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8I6jmnGkLLnAXp4bvaLNt6Urq8YrPgNY1N9zCfSPRRHXAf/w
	+C9n0a7YV7zeudKBIHfDaML3NQhyV2SQLioPYRz7rWTBPrUB8yFJnPbinXWfs5j7ao0=
X-Gm-Gg: ASbGncsyPBBHrEfavXP7KFTCyFQ+0uZrCkaq5+Gk8bIurCsiQYvvd/Y7ytHmLH8D8Hb
	QOEvkKwHlsdw+Eo/svvvhWZp6G5bbb6imQPmRPVTCnESK7966iByVpwbPcHLnr2SMWswVaV8vke
	+IiHcUfxatneInT4UBbbC8YmIcFCiscqfJiAW9MbsuTo7f1oMZkXqE2eDvMwgzbElLWCmalRmmA
	Jp0+kBYy2Jfba9uZK4FfE69H65QI7CmXpmbznFFnzd2U+Pzeld9pnSw7N9pqDa9QzTzd7TloVMH
	vcJtECGbLeBALKXqAKOE3bFT2lYjFL7Tk/ZarXg1EhMUqUl8xq/rGGHVNYJRRnT8mL6OuPNOCZb
	IQV/+SRPI64QBneIeOIcHmQdPhw==
X-Google-Smtp-Source: AGHT+IFNmW5G55PYYj6h7M2zKXEklVPMXRP8NGNgucOTfaGyaIHNIHj2hhtdlXQWdhi0wo6WcDpLPQ==
X-Received: by 2002:a05:6512:690:b0:54a:cc04:e77e with SMTP id 2adb3069b0e04-55216ec7d93mr957968e87.44.1748007665804;
        Fri, 23 May 2025 06:41:05 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:41:05 -0700 (PDT)
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
Subject: [PATCH v2 16/21] driver core: Add dev_set_drv_sync_state()
Date: Fri, 23 May 2025 15:40:13 +0200
Message-ID: <20250523134025.75130-17-ulf.hansson@linaro.org>
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

From: Saravana Kannan <saravanak@google.com>

This can be used by frameworks to set the sync_state() helper functions
for drivers that don't already have them set.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/device.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index f6ca813eebbe..fd4300e17b17 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -955,6 +955,18 @@ static inline bool dev_has_sync_state(struct device *dev)
 	return false;
 }
 
+static inline int dev_set_drv_sync_state(struct device *dev,
+					 void (*fn)(struct device *dev))
+{
+	if (!dev || !dev->driver)
+		return 0;
+	if (dev->driver->sync_state && dev->driver->sync_state != fn)
+		return -EBUSY;
+	if (!dev->driver->sync_state)
+		dev->driver->sync_state = fn;
+	return 0;
+}
+
 static inline void dev_set_removable(struct device *dev,
 				     enum device_removable removable)
 {
-- 
2.43.0


