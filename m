Return-Path: <linux-pm+bounces-26876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19A6AAF3BD
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 08:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279283B6669
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 06:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5228421ABD4;
	Thu,  8 May 2025 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ASRF76rU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231EA218AC0
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746685771; cv=none; b=aMaSnxADmS9yQs8BXl8teRCU/HbR1NqdeO6YC8idKbgIS8RFdZ3hnrIdNTHjyxvG2VVwT1C+2CpIY8BPp/aQGRW0zg2b2O0v4+RnYvULdSb+CCfgH5oW1/3jpNmKiUStcPA2/H1KN6RT0kXdsw9QJyALGh8bS+i87XSJXqeAhxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746685771; c=relaxed/simple;
	bh=nvAOftu8RZvdo9jR+7uDcoM7mg78LNDiZJ9RZTqBFTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pn2JsZGGcWlBfVDZqhOyltOXmom4ZasiWiDF1lZsbrl8nrvKtVw3OeMQlYqbMYUkuBCHezhoELcbskdFrFaC3jvqvY/9ILxtaFFvd2isuOY1DiY9kM6Wd6LgqjbjrsP51ISu6gkaGaA3YTLwETP/MnCxYy+DLXVjfIOzxnaEArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ASRF76rU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43edb40f357so3539265e9.0
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2025 23:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746685766; x=1747290566; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/4bzmi3WeEDbTzTrWnva98EY9qxtiVDbKUh9os0Wng=;
        b=ASRF76rU+oOGWhmnMMxRGZPnXK3rtLnBpRXUFejEdLp/KYAJz7st/87ui6hKnwKPGM
         36BW+WiFnPeDBVY2OqpmuvgKQqXQhCV/7zEFMsADo2SWml1qUuQQrkZCse7aM6dHEgT6
         Os90z5dDV/Clw+nbCQ+MQXP0FUACBP30g3XpaPqfwV713B7mjxY5LvDP181TOVlGtYKH
         +8SFcxinreTVILfiLJ+46xvvKZJ7I8Ex2/wcgNY297BjX7DSl9k8KGvzL/EwLJyDFEck
         Sa6OuiWz+4QbQqCd/3jguzgK3ile1yzNkYT9RB0Tf9tOBKFxl53vAZONNZGcQWAmJv+B
         neLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746685766; x=1747290566;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/4bzmi3WeEDbTzTrWnva98EY9qxtiVDbKUh9os0Wng=;
        b=WbagbRqSzLP71DNVX4hi4Kvvr0UnwG3giPBrlI1BkhcnVEmRuIWSi798d7eL9HEynu
         ZhbeNQwzxvf5blvfJAXxjaq1nAA1nyEp8wjRjneHsIlmXAzxD2pQHzFZ16F2F6fs58n5
         UsZNBPtBNSflMjCxiw5nFwSeM2tDh/yE0zytRNCnidfq/idvfYVlLdS1X2JrNwG6jTpu
         v20T2EE8DRS6YBOdstbIGvVDllY/f63VLct2wWHQ63NSHkYSn9AlwaVau8HVjL2smVqR
         N/IrfsA4wg1T5QjGFsgWcmYj8vacZ5JxvImqnyKx4vDIElDV7Z9RODEOFyrrbkAqiXpq
         yOCg==
X-Forwarded-Encrypted: i=1; AJvYcCX3nLBxrgHzaJMp5LknM9JKRzP+3MgymNPWMWCJbImJp1uyvs58ZlWeb9UO8+uU6dOj1rdfvcLM9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqMsldLrQ7xhcZ9MPbhGtvlSwGTFtsCcMdOGcZmYwbbyzj0jTl
	mxP+Tek3z6ywZuE3X4Yfy50/LKFEIq3Zpn2AjSFegVMiNuwiPnPIMUoMfhYrYPCVxElQErkfkh2
	2
X-Gm-Gg: ASbGncsb6d9HqWgNr5ArkcXtGCSg8eYLAUP00kWWXv9QQmsZG1K95BBI4r+3VEE+o1S
	f4vETFGwy/ywM0ulboPKUXvSKZ52rDlGjWy1b98JZ9ypwerXVMRhbiJM/ExiOh4uzuEMSvQX7F+
	cTtIO9/zFRoYCbKAl63sLaTqtNesrja2Ui/NA85+znS3FwqKw1LneNEnxAV004X1C5MMsxS56LZ
	7ZR9sDSijHTGSQuqVeDEKRpM8/uLKqLuGrYKTMA5M+CSkL7gbIkBHKyFKehYB9BuQV+z65gcKiE
	6c/qi5dyXHjMMbzrdzxFe3Dprp/NuLlD7m1ixJljgVfLYw==
X-Google-Smtp-Source: AGHT+IED9IVqI1ICbHb0y7mZgDW+1JcDLNkQqI9Ufmww05m3kDmPH3IE5qhfjUZINH4pYQlMToViTA==
X-Received: by 2002:a05:6000:430d:b0:3a0:b8b0:4418 with SMTP id ffacd0b85a97d-3a0b8b045f4mr2297566f8f.50.1746685766494;
        Wed, 07 May 2025 23:29:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a0b81a1b9asm2527467f8f.0.2025.05.07.23.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 23:29:26 -0700 (PDT)
Date: Thu, 8 May 2025 09:29:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Niklas Cassel <niklas.cassel@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] pmdomain: core: Fix error checking in
 genpd_dev_pm_attach_by_id()
Message-ID: <aBxPQ8AI8N5v-7rL@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The error checking for of_count_phandle_with_args() does not handle
negative error codes correctly.  The problem is that "index" is a u32 so
in the condition "if (index >= num_domains)" negative error codes stored
in "num_domains" are type promoted to very high positive values and
"index" is always going to be valid.

Test for negative error codes first and then test if "index" is valid.

Fixes: 3ccf3f0cd197 ("PM / Domains: Enable genpd_dev_pm_attach_by_id|name() for single PM domain")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pmdomain/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index cd4429653093..ff5c7f2b69ce 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3176,7 +3176,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	/* Verify that the index is within a valid range. */
 	num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
 						 "#power-domain-cells");
-	if (index >= num_domains)
+	if (num_domains < 0 || index >= num_domains)
 		return NULL;
 
 	/* Allocate and register device on the genpd bus. */
-- 
2.47.2


