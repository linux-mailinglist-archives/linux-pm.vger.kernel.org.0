Return-Path: <linux-pm+bounces-29907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C72AEF738
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6383A2FFC
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89240275B0F;
	Tue,  1 Jul 2025 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3m7vxFe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFD1277800
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370492; cv=none; b=YFb1Q1i9h4alA+XSwrs4nCoRsV7JyqjOcgecJdZGjmHRYP6BGNcj44MqR0eehkpCDP+99r41/q2alsLtf87/RfI8/0Fr85FMP7xBzqFwpj6+pDDH8gIxgf2H0VyirX0dOJ4ubMSasdGSu7ZV35c5GdfCe+k7WNeRpZDFLcRCx0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370492; c=relaxed/simple;
	bh=Z7/Ii4peBn6utUvIuofOs8Xdnqo3YZdslRw7QFE6ddo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLG5yCdDTwmTakIETxn41WMMLViFPCyanqmumdpn1ubqzFfQDDVxqJbAFs9mbWhnxg9932MEp6i4on9sMNYHAGUNzQn+7d3aPaKQub9BSB/Y96+cz68lWxP4qu9ZFcVzD8xrgGMZhqcjshKtUT69SiqlxWc0v0HETxBMmMaV5Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B3m7vxFe; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553b82f3767so3635545e87.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370487; x=1751975287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2osz+FDlcrsw62TOPCgoVgngpNoshxMUDCHEG4J5fcg=;
        b=B3m7vxFep2uUvPE2505Hsns3v619IpOzFmKUByMMb4fskPBz2+dN+jjoNPt2CktUMN
         O5WetQxk/spd1xfHHhuLtt01SUrVAECdFNfAyLoEcxbynaJ7u3N3F0MfEe1A4Z2XB8rA
         dePCYQ8MEUZhO0d/v1nGccDhib7Y52+3c1AIBpcjRe4TOhedL2ZkFEVGbZ2io7/kLxKH
         lhsU9EVJYWY6lzfslPuwjQ8dqTLeq+dMNW4hLNqP21lKl7z9EA9W1yVNBeTyn7UMT8o0
         xqAueOEjqmSWNY40NaxpSpuoVOlIEeOKbND2cUdetlx8Ty6ZuNrdeG4776S6cAYV6/ri
         0b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370487; x=1751975287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2osz+FDlcrsw62TOPCgoVgngpNoshxMUDCHEG4J5fcg=;
        b=JeQorZ2jlzLesD9AAjhbHznyLyrTDAO7b+91bCvTqnE/41Wuftzffqi8O0qioDxno5
         5alXeQBRcMhtddzAtPQ00QrTYPtpCKp10Ki7fx+iRJAnfr3xcDcReSf1+gy8/5LlvB2N
         qxwurbtyD9aiUMXpDCHJq5BBSSJ9lU7LGb3hb7Sht5ES5avi0E0hF8mFZM8rWprGrMwz
         TRCuFlbywe5MFm2DQAVEt74d+OybDEH2URgd7JUNXDsaHP1KkueiDXcb0jw9batnyff4
         JQ22fhhx+aDJBlhpRICD1F/aenziuvwneLv9ShKLDZwOuJ9rwK6w4RXcw+5765f+UHom
         1h1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4zbAxXhmrCLaddbZcXu9cPj7Ta9eFBXYfk/QUbpHgGoGHAtPLafRTsylrvQsN029EgQ1eAec4QA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzpb0JZGEu3+4OJSOyHoEHiD4HQVf8y8Cnztp8wL50GOptv1pY
	zCRipmDpbaPRJGbXYe4dYgylRMDh6u96jd5+bmBZeTQ9w/c9i03SQi/GKZBEJFF3308=
X-Gm-Gg: ASbGnctgE3b50vHnf4LoDawb9QCf4Ws9aK+2O1DZy8UGt43EHhaFG84rvqemRZImoNW
	XGczkXHNdF3eu1ggn4dcq5xeFbcIJiaOOQhGLS+PeojqzC8j31sT/RC+Yg3+MNyMudka1vJIqKB
	UcIKSpvoBxMRckekh5umnNRt9aTXb0oVlhtM+Y6ptruHlWkz4af1XJ5dGSVd1rQtdFJoUKdxlV2
	TbIqSqYyes71Kb/f6jh2dP9tIOnRsNtrI4NMvObqXHPEp1/C52jErUSRBjvQeaixbtcbdsnNBdo
	DXijXTtkk4xdW5UjIjBSvfodnYR4PdPq57qgX3h235kFRVHC19eEV9I+WMxXbsfDtR/EPmXs7Ye
	NCN+5mgXiOw467AUIwr+SpIs4VCxt0yjTYGBy
X-Google-Smtp-Source: AGHT+IGlTarSt6qvH4lmgRN+oUq7xpGteKJYtvJDbrXapQ7Eb/KPRGsvT0Gsl8JnkqI6XMTfQaWnpg==
X-Received: by 2002:a05:6512:224b:b0:553:cf38:5ea1 with SMTP id 2adb3069b0e04-5550b87b62cmr5843364e87.15.1751370487436;
        Tue, 01 Jul 2025 04:48:07 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:48:07 -0700 (PDT)
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
Subject: [PATCH v3 17/24] driver core: Export get_dev_from_fwnode()
Date: Tue,  1 Jul 2025 13:47:19 +0200
Message-ID: <20250701114733.636510-18-ulf.hansson@linaro.org>
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

It has turned out get_dev_from_fwnode() is useful at a few other places
outside of the driver core, as in gpiolib.c for example. Therefore let's
make it available as a common helper function.

Suggested-by: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/core.c    | 8 ++++++--
 include/linux/device.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index cbc0099d8ef2..6f91ece7c06a 100644
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
@@ -5281,6 +5279,12 @@ void device_set_node(struct device *dev, struct fwnode_handle *fwnode)
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
index 4940db137fff..315b00171335 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1048,6 +1048,7 @@ void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
 int device_add_of_node(struct device *dev, struct device_node *of_node);
 void device_remove_of_node(struct device *dev);
 void device_set_of_node_from_dev(struct device *dev, const struct device *dev2);
+struct device *get_dev_from_fwnode(struct fwnode_handle *fwnode);
 
 static inline struct device_node *dev_of_node(struct device *dev)
 {
-- 
2.43.0


