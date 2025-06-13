Return-Path: <linux-pm+bounces-28704-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F58AD9854
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 00:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD8C3BB355
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 22:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4152928F534;
	Fri, 13 Jun 2025 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nILvlXas"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519DD28E5F3
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749854397; cv=none; b=tP4iyMiLYccDcQTSBP5i4nJAmKFtZndNmW5VzuI9YRUFuFNzoO0RNcfCy+6jeSR6NykUHeZGSz3w3rXYxLz5JjF/Ss2T7RFDbQpHRwTwfwGJbw6fSpwwo2qyfcSNxdq3jJPeDf4otKz4098VsdUp8EEI5+K/LPfM7KAOhWIvl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749854397; c=relaxed/simple;
	bh=B0FUAZiH6G0b7CriNqbZGM4nS2MMo/a1OdSAH0IiNj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WoNM2eahtm3f0XeEuv9CRlrLfcWeSO46LiVJfiQpspEYAhNl9UoqPeh911UHuHBe2sIsVR2xq5MkArnYMksMfNjOXxnLEQ8egtk5GvZ8DjqXnEtAH+/icv6s2kIdLe4nEDdKHYqgOIIo2WG3v48HGl2+Py9O6BJVKv3ka7dvM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nILvlXas; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2c41acd479so1699367a12.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 15:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749854393; x=1750459193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEP/GWMAy1HT6GH5o2vnLpMiMEEPruBz+MB11qZprHs=;
        b=nILvlXasG//fUq/uHE72rGdcgh9dnsSdHhcQS/nTPG+w3qAUHBnrhbQbdpXaHcLwux
         ibo2OrPQa/64dQ3l88z88aUhThwl/dzJlABKAn5WJCtmhc04yZ2JAYD/hKA7VBuSiYLN
         pc6V+d8ASRU+jL5kYZ9hJef+zLaKBhs2O2/CCgFXoibLPoF46v+Wb9tgTwmYaVzqMpCg
         i0aCfUsN2QyJi+jP82HBWLmyNtbDnosXUpeyR/QTdv1Fat4Fv0x1HFWh2J9EYK/+BWAP
         hLgQczaIjARzm2gsjIZZA9MQVA3u4jXywFEDTeHLCbX9fNazuLslR/pIaZv938+3uD9B
         bGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749854393; x=1750459193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEP/GWMAy1HT6GH5o2vnLpMiMEEPruBz+MB11qZprHs=;
        b=Gcw+gkdO3+QvXFACmXo9tLZgi9g2oZynBOQqLk6WJqwPjN0HCMA6AEkf0/qYLBHl6M
         Abqw9kRF2S9uXZMH/E5dS0msb0JqHj9R8hMGnmh7Iuvqqac9AZllLPyIN8QQcusCX1dS
         op7K397bvx1xhVmKpS40rSIwuBZm6ehVdW7HGs8OQ9NHoU8zMAmj4EISoGz0d5U+5+Ps
         2jWd7bYieYWliZsdVBB//pB4CmHVpEL/rtSRIhTGimBE7SrcLUWU2yzEt44vF9+0GUx7
         8yia5b+XRBvc9pHUa4a/DTeiT4F1ummWdBsN3O4+MLNuUrUqGa4LoVyi+xQzLUZRqRUY
         vB2w==
X-Forwarded-Encrypted: i=1; AJvYcCWO3fA4mhQO2l5+R+pwIPBxIcvibGtAnxiy6mXhU3al+pkYIdUko/fZzeIpoNwU/qLFZ41P4rPJOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrPlkj/nCQ1GFbazoDUmoCyUcJ5EzablPg4TdebuYX333gxZjn
	Tw/wKqGGZYVXu/ZDPt5itHjQuuEg/kI/ep+2bEeGZLtuZgyokdJh3bIE3OKNu4VBLTiAoHzHCIa
	ulrZCy7Y=
X-Gm-Gg: ASbGncsCUYT7S7jzOOB4PnJ2N+RJxIgCozYk9wiQ+PWlyoLXIIf5X/A6sMRlSj1A9G5
	OFUS8p6EC0dcjfhIFoupAGgaD9wNrfUI/Xsm9UBxxCTFQEubmAVPyWde2P5/YyOpgCKJkS1tWsD
	kCPwRTMuEmdZNoPRzZT2NQFQDQTmm2NcC8Z1JBgkPjkYYv2YaNJm3Jmsm2xMSW4vDzjUraVIMwb
	AJScFW2X/o68cX0yzp8cXI8B0uVrpeVhNqm6WRCKpTVqreZ++ULpjEOxYaV7dUVvjqEP4SWPNqG
	7Grk5s995Z84G9W/M6vdiFqFKcgGJZjTN8T1TQu/0cukI8pdfMOn2BSv4dF2
X-Google-Smtp-Source: AGHT+IHM69myxixxhovi3BjNN6Y4awOReozcaBNGYOKlpKfUomG5cP6OPwQYHgEgzT97VOzosQBw9Q==
X-Received: by 2002:a17:90b:3806:b0:313:f6fa:5bb5 with SMTP id 98e67ed59e1d1-313f6fa5d2bmr68296a91.18.1749854393521;
        Fri, 13 Jun 2025 15:39:53 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca277sm19802395ad.198.2025.06.13.15.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 15:39:53 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Fri, 13 Jun 2025 15:39:28 -0700
Subject: [PATCH RFC v3 2/2] pmdomain: core: add support for subdomains
 using power-domain-map
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-pmdomain-hierarchy-onecell-v3-2-5c770676fce7@baylibre.com>
References: <20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com>
In-Reply-To: <20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=openpgp-sha256; l=2994; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=B0FUAZiH6G0b7CriNqbZGM4nS2MMo/a1OdSAH0IiNj4=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBoTKi2z3hkHLDnnQqUsxMulvLva65h7u85EQGb1
 Ng68KklfiyJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaEyotgAKCRBZNxia0/vG
 Za5BD/9QcVioMiNXIQJ+/wpNTcBj+X9G60C/7XhUWr9aJHGRvgbEPdiBCGrKQNph3l1R4GFuY7i
 4gkL2iw9ipupDL4XI6ES1mZ5cAXD1HR+7VEr6pBKr02RuKjMb0qUgvg6VM4Rg8gBHJ9i1WPbW/k
 gSu3s1kP0aXZMfn4i1O1tdGaifWc9Qbcq3N16Hifxl9jhFmTVQGUuMciFIRlOs5onlO8xncbffB
 0KTACjua41CDkNlna4qtcsMjaAxHpElyluFQC0lk/mwOHBsvjFOdvRs7GFgTkCjNK6TlotZDiqk
 RK6TcCYvaV3QPwHz391pGDieDdjn1HOzYklNFT3N95C6zcyMOxgSSa7jln6YtDeTCCIltPrplGB
 8xBsopOqxh9nDrEiNPt3qOZXRWaAkPA9eC/UFzEK79e1st2raOdVfEaUhGO+yxU7OcYf7Riy8QH
 WRD8ZN0PorPyYlmbqOoPOdkKTLWbhUmPuTn+M+Q5j+mNhhA8luxd/RHZhWSMApj1+w2mnLZCozt
 Sn8U4QYMWrAS7mfWX/GZEjJ0YW6QAXYTYocOBwgqS7fkvuTk/lZqycHVEAP8XdFr4O00UCWtq+l
 aqqW+zA7SpVHA+/pRAUoj+monTqGsV7Au08KYfU4aHqOysrcJsew/DC+B/zigbgqfsCdvA9g8y5
 5iAVbwikKU9NY8Q==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Currently, PM domains can only support hierarchy for simple
providers (e.g. ones with #power-domain-cells = 0).

Add more generic support for hierarchy by using nexus node
maps (c.f. section 2.5.1 of the DT spec.)

For example, we could describe SCMI PM domains with multiple parents
domains (MAIN_PD and WKUP_PD) like this:

    scmi_pds: protocol@11 {
        reg = <0x11>;
        #power-domain-cells = <1>;

        power-domain-map = <15 &MAIN_PD>,
                           <19 &WKUP_PD>;
    };

which should mean that <&scmi_pds 15> is a subdomain of MAIN_PD and
<&scmi_pds 19> is a subdomain of WKUP_PD.

IOW, given an SCMI device which uses SCMI PM domains:

   main_timer0: timer@2400000 {
      power-domains = <&scmi_pds 15>;
   };

it already implies that main_timer0 is PM domain <&scmi_pds 15>

With the new map, this *also* now implies <&scmi_pds 15> is a
subdomain of MAIN_PD.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pmdomain/core.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index d6c1ddb807b2..adf022b45d95 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2998,8 +2998,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 				 unsigned int index, unsigned int num_domains,
 				 bool power_on)
 {
-	struct of_phandle_args pd_args;
-	struct generic_pm_domain *pd;
+	struct of_phandle_args pd_args, parent_args;
+	struct generic_pm_domain *pd, *parent_pd = NULL;
 	int ret;
 
 	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
@@ -3039,6 +3039,22 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 			goto err;
 	}
 
+	/*
+	 * Check for power-domain-map, which implies the primary
+	 * power-doamin is a subdomain of the parent found in the map.
+	 */
+	ret = of_parse_phandle_with_args_map(dev->of_node, "power-domains",
+					     "power-domain", index, &parent_args);
+	if (!ret && (pd_args.np != parent_args.np)) {
+		parent_pd = genpd_get_from_provider(&parent_args);
+		of_node_put(parent_args.np);
+
+		ret = pm_genpd_add_subdomain(parent_pd, pd);
+		if (!ret)
+			dev_dbg(dev, "adding PM domain %s as subdomain of %s\n",
+				pd->name, parent_pd->name);
+	}
+
 	ret = genpd_set_required_opp(dev, index);
 	if (ret)
 		goto err;
@@ -3056,6 +3072,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 			dev_gpd_data(dev)->default_pstate = 0;
 		}
 
+		if (parent_pd)
+			pm_genpd_remove_subdomain(parent_pd, pd);
 		genpd_remove_device(pd, dev);
 		return -EPROBE_DEFER;
 	}
@@ -3063,6 +3081,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	return 1;
 
 err:
+	if (parent_pd)
+		pm_genpd_remove_subdomain(parent_pd, pd);
 	genpd_remove_device(pd, dev);
 	return ret;
 }

-- 
2.49.0


