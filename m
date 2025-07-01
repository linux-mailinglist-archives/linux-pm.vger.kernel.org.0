Return-Path: <linux-pm+bounces-29910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BF1AEF73B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED1E1C02474
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80C4278750;
	Tue,  1 Jul 2025 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vL6E56xy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8B273D6D
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370495; cv=none; b=VYr75LPQGERMGs5EtkEO/NO/ksjWNc4m/hlGdcEd8iKq1cpaUBXd496zIJnaEqRurkH9ff8Q9wSJiGXyNF2ARxUxEbygx0Vfazb8ludQ1gtRIlHxTcWEJF1vu7zxhvo6enUW0eLWIGiv3L7VZRJUgGvNXQYBfvaYvzDOUPoBmts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370495; c=relaxed/simple;
	bh=ZKxP/uIFZrB7DC/unY2AqJMe11Q/d2KHwpw9Mkep4WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rByIyHYUvigzCm+BM8YW7mER6HuKnfUQyqIB/OPr/5nbZg4HB6QyQHWkYC/g3Z4OcDCWp0fvtmz6wuRDhvq1qT57lmeJOJa2YdWSaQ5AdnpCLLn2/ddbjiM9l3iSpFGb2NO8iM1OldjGxKzwSb2ZSOswz8I4h+pHCxCvAhxdR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vL6E56xy; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553b544e7b4so3324363e87.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370492; x=1751975292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLehfsqvOq2rldbx14TVd1s2tM/WPFuPqjQ5HJp7toc=;
        b=vL6E56xyGGnimmeds6TrOzbOQMxLsd9jZQxyC0V6es/aF2de9a2sddNdEbOHBfX/Xq
         LDEeW8qS9UYVKgu7eA1NjGDlcg04S7yG39/4MB4GU9m3Hb6ir9uj08y+XZXlFxeHd8GT
         cu+TNa4E7+1JTjRPBCWIo7jWYMF/18Xfa9yltUbH7MizAbd9mQra+89xuFsuaf+WvEac
         REqe7R7u9g5Rn7EmVB0MD3+3vGufBhWxLoHP+qsPwTCT0mFel3HN6Cl8D5ALy3qVAUgc
         C2l98kisFvP2zEg4/39vKjpvnTiTEE2YOwBNgYmaTkvgN2XOwVKKJez20ltJLjvQ5FOC
         D3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370492; x=1751975292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLehfsqvOq2rldbx14TVd1s2tM/WPFuPqjQ5HJp7toc=;
        b=M3hEYU1HGSW0rizWhW1LPSMsMWWtABMg+DfxSrASJsJHqLA6MYTD5VBO0YccBncZpM
         YYcRVp4iPrnJUVRSr2rShK6z06hrJAtx+ZkCHCME+Q2RpQTL+bu7ECu11dHpQzQ1rPdF
         93DjlXg2ICTYYR/G09gtYGRnBvIXGPCj9JCGErH5KqUzLqgg/DGFGTz54mKyH9xfzZX6
         4rbnfif5Q/phOgbDo5sBj3k5ZUHp8aM5xZEHhn0BjkPpmHwWEMGisMkH3eLoHFpVne1K
         Aox1OXZnIOydYFCqiZKKgxEVhL/HkDTNQOr2VDsNgGBAThNT+lfiZRjWVNUd2GYkkuJI
         zUZw==
X-Forwarded-Encrypted: i=1; AJvYcCU3EWXB9BTd8Bke2LB/L5Is48+qZfu3uN7Z6FmNvHj4xTLCSKDY/ZFtn7dm6ZyNzLamPMCg5GIL5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKYeH1di67nYB3RWbLJ9ccqhDRrDABwyZSLFbX8MxqMR0EWcmu
	LuPMOYiDJ53OZp12EcHS+NmHGCa68E1rJPw4TWvZBi6lDLmUByRVJ3viPSWuYYcR8PDo7QYQmjl
	dufHU
X-Gm-Gg: ASbGncvpFC1WbnUrf6Id4h7QvCL5mQg+rLyOWYYqlTkcqanu+fAcHLXXiNKfw6Gy8d/
	xbQPC7vEHHwRLNxo4r/PlB/b/VvDJQDueOApBxq6g+JIz3rjjY+i3kKCNYFNFMj0viKQJtKD+zX
	lIK2b8ZQmCQbc3t9b8xH5GQFNoe7bcbI9p91wAdT/QE2h+v+oGKkH8xu+1XqXJ/2pA21XftUb1E
	CJjFu25ypoDXK5bbzlKmDAzLh/LjGHr1K0kP4zj4H50I2gR1OJnDyAPaaHHARJv5Af+f3qlpiOO
	rwOvS2UWMQmzA33mkWgwwlx+zvyG4udnhntUhesc+W0nH9eL3fVKPRQt3yyeYVhHmzcRjHBy7lg
	NaxP1NuYDeOJKuYz5wSB20STF7N7oOexPubgv
X-Google-Smtp-Source: AGHT+IEFrJBlVC7VlfyoWKCWgUF1BoulcpmDcaoQJgnAjb01VTeoCZDNnR+9q8S12QM4kbT+CovL2g==
X-Received: by 2002:a05:6512:3b9d:b0:553:aadf:b0c4 with SMTP id 2adb3069b0e04-5550b811339mr5665246e87.11.1751370491736;
        Tue, 01 Jul 2025 04:48:11 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:48:11 -0700 (PDT)
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
Subject: [PATCH v3 20/24] pmdomain: core: Default to use of_genpd_sync_state() for genpd providers
Date: Tue,  1 Jul 2025 13:47:22 +0200
Message-ID: <20250701114733.636510-21-ulf.hansson@linaro.org>
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

Unless the typical platform driver that act as genpd provider, has its own
->sync_state() callback implemented let's default to use
of_genpd_sync_state().

More precisely, while adding a genpd OF provider let's assign the
->sync_state() callback, in case the fwnode has a device and its driver
doesn't have the ->sync_state() set already. In this way the typical
platform driver doesn't need to assign ->sync_state(), unless it has some
additional things to manage beyond genpds.

Suggested-by: Saravana Kannan <saravanak@google.com>
Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index ca47f91b9e91..5cef6de60c72 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2600,6 +2600,11 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
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
@@ -2628,6 +2633,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
 	if (!dev && !genpd_is_no_sync_state(genpd)) {
 		genpd->sync_state = GENPD_SYNC_STATE_SIMPLE;
 		device_set_node(&genpd->dev, fwnode);
+	} else {
+		dev_set_drv_sync_state(dev, genpd_sync_state);
 	}
 
 	put_device(dev);
@@ -2700,6 +2707,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 	dev = get_dev_from_fwnode(fwnode);
 	if (!dev)
 		sync_state = true;
+	else
+		dev_set_drv_sync_state(dev, genpd_sync_state);
 
 	put_device(dev);
 
-- 
2.43.0


