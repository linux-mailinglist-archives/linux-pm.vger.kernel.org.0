Return-Path: <linux-pm+bounces-12499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A4957A32
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 02:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4C91C23DA4
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 00:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC95A1E210F;
	Tue, 20 Aug 2024 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JDiNM9ey"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCB0148FF0
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724112033; cv=none; b=O8cgvkgzYxXVVzXH6WJqT79DdkjczoPQTn/1cKFLfVDaoMRUvMcQWmJdyikb0HKLmLnWsyxrYOjkuH9Y4JdXUXllfkk7UmkekKsippKfYo4BRHub+V2Qp89UF8VbcHb9wWNoyOd9B7akf4uQQ7LqFunXMJTE0iTLomaEd1fNCI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724112033; c=relaxed/simple;
	bh=tUlhhvUzqEYQ9xxjHzkEQgHRjJRMt3U1MS2Dj9MMzKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZfhitdPR8vLsYDCKjM6JvVwdrrrS3iZyJT2BGwkirzIiELs++FQK1r3nDrD0Kl4x+wff+ynYmcsnRL5M03ad841yrHpEgUcwGqeujNiegU5aoWTiO/ZSNH9furcuPP0kO0hcbtevhzyoRdXI0SKDOSs+8sTEno4HusfHvCqNp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JDiNM9ey; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3ce556df9so2927749a91.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724112031; x=1724716831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrn9kJswz7J5k2KMeEwoyClXwEGKchhZrenYjTvg6wc=;
        b=JDiNM9eyOKaYju9rkVJnvdpn+cIiCfCBWXbjd5KFrnLiqWm4uf25tWp6ducjrS5KF2
         1fCLDJEpmdNHFfaP9cvoSzp1IVqJpKaSYS41V3ZQwFkbpCX3OlgWdMY/crO1PIgauHvk
         rq7itCLFRwCUiuSo8mywUdeC+U4lRh0ffKHgCIFDRLrPJcthygdOI6e9GvOoKmWIAN/v
         Js1IhSD2YMcae9eo1Pxigw2r7tzjdTmwucPCODSrWSm9vnAko/VRlY5NX/PHhCQdVYAK
         TBwRykFT/q2duqqOAumNQ+tdTdhsPeRK3mhfu6bdMjLIvNvfMh3scyOPqF7xsgG3nUJP
         tkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724112031; x=1724716831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrn9kJswz7J5k2KMeEwoyClXwEGKchhZrenYjTvg6wc=;
        b=ecKk/BK0Sv1hIPmoSKJN3ESp4LYqzCcnXY3/GjOQWypD6sSv7GHWEmLdcfxq/feICb
         iPfjqYBIKtFceXX8hbOYzNqgP0JinwzYu3VoyGy4qxSQrUZAzhGnepH5M1G+7DOPN1No
         UzQ7GFSblCDsORPcGMs+JVPxqL3nHqasazIVArT0VM8g7xmieq3kZuYbXuVcBb09d/E5
         rrLoUIf++4pwCld7Vr/jpItlogAqJEg7ef4An/ZqVQahki6qSbdZI38T1csJuvrD0gl2
         kzZQoSG/LJ29iC+G11IKipDv8PgI09DGtD/k5VFZXS2J8zHYLtI0YB/+h6fzPKSTcTGI
         kEkg==
X-Forwarded-Encrypted: i=1; AJvYcCU5BR0frF24uw3sW9awN0FarnJuWrKfYY2kY9QZ/odHjPCcz5jjKtn5CnG6UBxw4SL62HAFTsHku9OsPg24jbGq6kzehImHzKs=
X-Gm-Message-State: AOJu0Yw5jKL+bI8G1EFyT29Y5GVFYvdm+W97ybTllGfQpDvQe+QfNOXs
	kWIbtdB0SB1qPY9E0S494jehqYe+/gi/O2j0ybtpTbji6ApBfptHY4sgvR7ksOUJEwWCwVBY1Zn
	j
X-Google-Smtp-Source: AGHT+IF1NfWUZbWpyfpHlbAfLpF5uRsQsGKCgn3DKqKJAf6OPFuUxpR9lOOfUl3xYac/G25kixBBow==
X-Received: by 2002:a17:90a:9ec:b0:2c9:6514:39ff with SMTP id 98e67ed59e1d1-2d3e076c66amr10858991a91.33.1724112029182;
        Mon, 19 Aug 2024 17:00:29 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c7502csm7857404a91.40.2024.08.19.17.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 17:00:28 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Mon, 19 Aug 2024 17:00:12 -0700
Subject: [PATCH v2 2/3] pmdomain: ti_sci: add wakeup constraint management
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-lpm-v6-10-constraints-pmdomain-v2-2-461325a6008f@baylibre.com>
References: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
In-Reply-To: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=tUlhhvUzqEYQ9xxjHzkEQgHRjJRMt3U1MS2Dj9MMzKs=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBmw9yaw4z8Tn2b14jGRvuZX85gZ7ivnQCQWDNjy
 eJOyqKt2oqJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZsPcmgAKCRBZNxia0/vG
 Zaa9D/0T7h6tsTpPWJ/ttDQEwpzwuZgC0zUMUYapMHQMP+3gx1wS03bIEiCPiWYukJKn6Zu5G4j
 TwPRwPah8RJeC7muQk3sJNH2SCaI8pJb+QsYuVyTWKJ7x0Rl1XhZFpJzDze//8o0oAoPF1jGTrB
 O+8PMibGcfTv8rmiljFBwTyx52J8JGXdYXVPV9gw6G66TIpiiQW/dnGXqXEwhtAMH+3cAaKeusD
 87bQ7zYcLtu++AgSIFmdU8G+UNxc8BoDcnEpnk1ToBVXCgZoXaWwztIW8Mow8Yl8EwAIi8TdZm7
 CSXZhfkQbwYNBJWOQ6nE3rDaQNyaTRbfT0D+6sXeFaunQNqUrIN9M8rznM/aCzEUd+7lcHBM1eJ
 pRbEuKLjhHj+g+qzfHlPJ31F1RQ7eh5U9/Fu+C1pGcfzz4nawTx4/ViuPNP1KTN6ZbYPanIcrLF
 3/F8/V6ZWZPH5DcciGWnTtR6N1R2R1+o68EXROklT1sq/pq+DN8l4z6vzMN+a5I8YoyzmiRRIBy
 w38cEq8seTPnFvlMx8e4PuqKRgHjhIcqxHXg3t+qwXjAJpmkVPFy+J/YO4m6sS9LCeLABn5gG/i
 luhEZyvX98OTmDRoK69HGHI7QDZR0fZszgX93Hhy/ILwfxO8ztS6xP6Cq/aTZcp2nHrnPe9HNFM
 gepXr4pmMzQgkZg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

During system-wide suspend, check all devices connected to PM domain
to see if they are wakeup-enabled.  If so, set a TI SCI device
constraint.

Note: DM firmware clears all constraints on resume.

Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 963272fa387b..8af907579152 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -76,6 +76,23 @@ static int ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
 	return ret;
 }
 
+static inline bool ti_sci_pd_set_wkup_constraint(struct device *dev)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
+	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	int ret;
+
+	if (device_may_wakeup(dev)) {
+		ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
+							       TISCI_MSG_CONSTRAINT_SET);
+		if (!ret)
+			dev_dbg(dev, "ti_sci_pd: ID:%d set device constraint.\n", pd->idx);
+	}
+
+	return true;
+}
+
 /*
  * ti_sci_pd_power_off(): genpd power down hook
  * @domain: pointer to the powerdomain to power off
@@ -117,6 +134,8 @@ static int ti_sci_pd_suspend(struct device *dev)
 	if (ti_sci_pd_is_valid_constraint(val))
 		ti_sci_pd_set_lat_constraint(dev, val);
 
+	ti_sci_pd_set_wkup_constraint(dev);
+
 	return 0;
 }
 

-- 
2.46.0


