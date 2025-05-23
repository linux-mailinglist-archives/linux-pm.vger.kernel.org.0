Return-Path: <linux-pm+bounces-27574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31892AC244A
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418C61C01763
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9318F296D09;
	Fri, 23 May 2025 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="riRxBLj9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B847296715
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007666; cv=none; b=J30kgdErndj8F6Yhh6Pp/uZEl9IhgaAgdZ0CsVhKPBFdalUuqaPesm4LcwKPqMMKNRHa+GwIoBkkr5NXOzxKtWUo+R6wT0c0iKuuDAE/JAAmvBAmV5pxnF9Xv6DiUIZ4kNJ/Es+oGt5bvsss6bMRCYuzCMQ/SwJSbvPdt1PCNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007666; c=relaxed/simple;
	bh=rKpQ93wGB3N2jcBrTcwJvgpog+JGf2BH59ObvzlpVTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5H+/ZIlkW/MfXzy/EaYFDhIOoEcgeJvDuXuDe4R+/NeV8BGzPAyI581nW5WO0VUfy48MPDta9CYfyITSvRDKfNPbphlGorCc/Mhlj4rjGMbJWorweMn6KCXcdPkZdFwdErab8FLPC9mEAAUDhgf0aIpf1n6/D72qmHIYCMlrpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=riRxBLj9; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-551eb17123cso9062609e87.1
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007663; x=1748612463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ptipst+jgUVMZThwfnH2tLuY1vSwuKeNOIIYU0B7Lc=;
        b=riRxBLj93NWR2TUktrAfB7OMoau5ESJTZTigxcB8cvLQDGqIQNlkM1ju9LK3w1v/82
         N7Q8ExKba1LQnfsgyw1MEg4GjmnsFBoSBd3dMGAQvn1E1W2JsBJyskAEaatUqFamjzXA
         oc7ZWcW7bec+a50NZRfQzUE1LgpNWQm/KWITJw6yArJ0Ecz/4Tv//qtdc+SQ0pmjNUvp
         +DzGInq5GRXlPXFsC0imkNiohSTbIsKMGTH9zURo9SvA5rTU0/rhAxqsuKqq8yVPjt5F
         KEp/5O1szwI7JZiuC5Vfaty6bONyH0UwB/0Ug59m/dNRZo98a8TkRiatHwdvH8ezSAoB
         h7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007663; x=1748612463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ptipst+jgUVMZThwfnH2tLuY1vSwuKeNOIIYU0B7Lc=;
        b=ZjFcORDr9sElQlVLoOPaZFt5QsPtdOJ8mBedyUF8VRBWXujfGeyJXvMlZMTlSUpYyS
         wv30+zA2rfrvKkERs9sKw0/s4kRqeIFGYxYhP/TOn2rJadDRgb4tKJy+eUi3jI98E2z/
         9wOuImao0R0PbKAAXfPTPKts7o/ozgjVvkcUuPsMtM7odVc19S+ndoW+RLOZihIjUCCT
         lataJxujxEYAZ5q+zF2OWtqFUmJH9H+achx+BJJM0YJkE6PieND+1g4W0oyn25C1zPjX
         LxjgKt8lFpITJZQrUiH8TvJxbcq0mZsW1BFUfjfrPVZnu5PCOGW3u7VHHRloHgZEoRWd
         Id/g==
X-Forwarded-Encrypted: i=1; AJvYcCV4xP7vShlyUZcYpHfptgJWkOPwfiGSSA94zyWf8Mbs3kPQ96HWNgW3lIVEztdAoKRasQSeq+A9JA==@vger.kernel.org
X-Gm-Message-State: AOJu0YweGtNCpVjLNlpeHYHrUvN9ZH12Y19SDx+URspqKkW613lBmf3L
	s1JzxQ5BdLyUd0Rs/x0++dzsVEOGurk17M41lr5ZptL50FqSL9wZiq5YOGX9ybLkfBA=
X-Gm-Gg: ASbGnctD+FLcGKGz5kW4HpTzTGQhxYH8ofjlxrBYbKeryzPdC6TiGEvMFxxXiWh63lg
	nsiOqEHWVgedZkFo+JD+hnr4DnjRGtew2PYJWP8tXqyD7VlSVaf/SaelDQqQc0MzSlAPoZAuCt/
	01sg8m4w3uQAaNZADjBk7ELHglqDWlUys1Z2CAj4p1T7uXHdwaucHCaGv3ldlzfb1t/aHD/GdkT
	p0ZKekEvaoiWpRRIy6nbGlPTx95dJYloYKgi+Z23E70aTamrvlZiLLhnDRydfOZC/gAAe8AaCVZ
	LQBJWzK9V/NBBtXPUxtfyykfzXDkVy1LyKc3FqQH4QMkUTFlQT0bZ9N7xPmkIRqQt47ZboaLuMh
	SkzUdX2DTVsUxof0ZQnU49Np+cQ==
X-Google-Smtp-Source: AGHT+IGfBRDW1UMlFuEvFbwkjGLGnQiQkt71IPhxmMxhJWvlHH9jDUn6RGcLspRvscDDVp9YdgMBPw==
X-Received: by 2002:a05:6512:39c9:b0:549:9143:4e8d with SMTP id 2adb3069b0e04-550e719835cmr10282215e87.8.1748007662658;
        Fri, 23 May 2025 06:41:02 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:41:01 -0700 (PDT)
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
Subject: [PATCH v2 14/21] driver core: Export get_dev_from_fwnode()
Date: Fri, 23 May 2025 15:40:11 +0200
Message-ID: <20250523134025.75130-15-ulf.hansson@linaro.org>
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

It has turned out get_dev_from_fwnode() is useful at a few other places
outside of the driver core, as in gpiolib.c for example. Therefore let's
make it available as a common helper function.

Suggested-by: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/core.c    | 8 ++++++--
 include/linux/device.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d2f9d3a59d6b..51512ab8a6e9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1881,8 +1881,6 @@ static void fw_devlink_unblock_consumers(struct device *dev)
 	device_links_write_unlock();
 }
 
-#define get_dev_from_fwnode(fwnode)	get_device((fwnode)->dev)
-
 static bool fwnode_init_without_drv(struct fwnode_handle *fwnode)
 {
 	struct device *dev;
@@ -5255,6 +5253,12 @@ void device_set_node(struct device *dev, struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(device_set_node);
 
+struct device *get_dev_from_fwnode(struct fwnode_handle *fwnode)
+{
+	return get_device((fwnode)->dev);
+}
+EXPORT_SYMBOL_GPL(get_dev_from_fwnode);
+
 int device_match_name(struct device *dev, const void *name)
 {
 	return sysfs_streq(dev_name(dev), name);
diff --git a/include/linux/device.h b/include/linux/device.h
index 79e49fe494b7..f6ca813eebbe 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1086,6 +1086,7 @@ void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
 int device_add_of_node(struct device *dev, struct device_node *of_node);
 void device_remove_of_node(struct device *dev);
 void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
+struct device *get_dev_from_fwnode(struct fwnode_handle *fwnode);
 
 static inline struct device_node *dev_of_node(struct device *dev)
 {
-- 
2.43.0


