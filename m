Return-Path: <linux-pm+bounces-7005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623CB8B086C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 13:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41A71F2419B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 11:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2743A15A4AA;
	Wed, 24 Apr 2024 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edKYD9Dn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B4815A492
	for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713958820; cv=none; b=frfP/ypFKqFVxNMLjbGkKFbj4g2Mx+OqdS8eM0qKCsKVIGRjy4yp+B2ji8f2n6ifA20mQkO8G8EKQUamoUpgsk1PolfKqBuRxIZf2bTu7AszlqIrGynEhed2thu/NrP1+dwZo6DyiW+f1aZ+X2hpd6wzr6XgI6ztwZIht6Hvu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713958820; c=relaxed/simple;
	bh=uPxQKTFjx1OojfL3XIvuRwqZqEHhetjhGQ/QNoCE0cs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dpAQHU4J7MBa3RBhknztr0YwQnMkPHZgzk88AtfaYCQqVN8KbpjP54InTx8zBkMjSQ+SwIyMNlOuq2sNux2S1gIm3vcyhazOkoAIo2Vzn1WOCCW0ftZH3ogIugHjUo2gk+NHQCglvAEjLscmiXzzWkJ1/0hm/AqBEpjwV6ADNFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=edKYD9Dn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41b243c20a2so322605e9.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713958817; x=1714563617; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWMfbfXnYK3fqv0yrgeedC9giNqOZfecY/EM1i6Y9pw=;
        b=edKYD9Dn7FaCWOBjpHdZh4kLOcScK13PKLKG9a8zuh+rux5j/0bEp7lbhlhu+P27pk
         SujBXnQa7jgAn4MzXbVLXsYf0nkEzHgn7hbwkuDpFnxLmwq2lD47B6/yxtRTBIJD/sK0
         NDCPjDHmye2Cfg8oVuOs6YYRu1h6sfuxvdTr1ruM6+8jFNjFCCAFWqt3Ss4iD4yTfCy6
         SwouGHq5Ym4i9/2O0zDcQpq/bR5GrWghp/es4enWAe8Quj6XtEUah889VLl7GJ7TjIMg
         d4SZbm0PK6cRsdRlR38QXJLdvgFJ+TMIloQ0+QYICRDoVGjn5DDHSOovoSZ27sXe3tYa
         EhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713958817; x=1714563617;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWMfbfXnYK3fqv0yrgeedC9giNqOZfecY/EM1i6Y9pw=;
        b=TwVZmLhvZz6SRgk14GdpTHiBDLPFQdnVjlbM18VBs/y44OZ5BzSDqtqGbvYDioTQT5
         awbig58eoyLdgeykz4bW8W9H6hB3OlC2Bz0UBKlQ6eC/kSwr/3pqBnyUjMD1DJnV9JlY
         rCgERRRfi+tiCn69qqONamQa0aFQLeruojw2XaOKaAR+P2zA6AIoIw/VO1yDm/99qISz
         vOjtFMXQZsAEN/EY5NBT0FjYBj7GaTojdJDAOeFWUD72fTXwva3ED+r68OWcZr3+L47D
         +AF4blRn+WMb7cNtvvSNUt7YkkOIwZ7qTZscJU/wnP4DPeVWIJvSL7r2L/QE3j4gGke3
         fG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpmX7VMimUk8flBXKiKz6nooQ19nU7lHfj0WWg6lKCLDCQ7ywoGcXwdzpwbLJq3+tLCDlptIYEZjCD0HY1wg/ujEt82Qj3UAU=
X-Gm-Message-State: AOJu0YxmPJC50tboyIFE43FER8/LmxuG06pCedktn6imL4GUIfXSF94Y
	VYy491y2FCMxiOtTHGgC6v9ig8Mg8lK78BpvAdVfUzRD5N4bBAWCjE1cw9ZjkrQ=
X-Google-Smtp-Source: AGHT+IEWJT/8VK6y4z/3yPVqZFVfOmJf5zYfnoJ8CK24bfiYAkNVefNagGs454ZH+JH0euJmK90N9w==
X-Received: by 2002:a5d:568d:0:b0:34a:9b75:cb95 with SMTP id f13-20020a5d568d000000b0034a9b75cb95mr1449964wrv.37.1713958816645;
        Wed, 24 Apr 2024 04:40:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe2c4000000b0034a3a0a753asm15306805wrj.100.2024.04.24.04.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:40:16 -0700 (PDT)
Date: Wed, 24 Apr 2024 14:40:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cpufreq: sun50i: fix error returns in dt_has_supported_hw()
Message-ID: <9bfe5703-b39b-4d98-9995-f6a7d0ea558d@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The dt_has_supported_hw() function returns type bool.  That means these
negative error codes are cast to true but the function should return
false instead.

Fixes: fa5aec9561cf ("cpufreq: sun50i: Add support for opp_supported_hw")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index cd50cea16a87..0b882765cd66 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -136,11 +136,11 @@ static bool dt_has_supported_hw(void)
 
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev)
-		return -ENODEV;
+		return false;
 
 	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
 	if (!np)
-		return -ENOENT;
+		return false;
 
 	for_each_child_of_node(np, opp) {
 		if (of_find_property(opp, "opp-supported-hw", NULL)) {
-- 
2.43.0


