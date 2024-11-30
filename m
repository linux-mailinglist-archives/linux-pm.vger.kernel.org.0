Return-Path: <linux-pm+bounces-18262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AEA9DEFD6
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 11:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65820B2186D
	for <lists+linux-pm@lfdr.de>; Sat, 30 Nov 2024 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721B4155C88;
	Sat, 30 Nov 2024 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3GBR9rd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CAD1547FE
	for <linux-pm@vger.kernel.org>; Sat, 30 Nov 2024 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732961283; cv=none; b=Uz2NqVVL72bIbuMr60glb2JcRPmlLtZfmA9Wl9+fv3n9p1CWMcvALyG//PEpnVdLVdRa/SR8krOwlh4uLnB2L+Spna/wvBMXIzbb1Sx4RLO0oYW2CrrC6tysGHlxEtKZgDbw91t17Shbl3gehUQcu5ez/L0Q6+DhvRRY4culpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732961283; c=relaxed/simple;
	bh=7zmpFrkNE9b9fiTObZOVjwcI3iZNrUR2CLn6+i8hq2o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pJwcJCR2Sn+vBoQHRV9E0+9+Fi8pJyuQSvXo4hst/gc3+HSYDsDT4Vc/frNBusfRPC+pr26imwtdwF1CME3r5XITwcUeMNKcZ12zkUwiXAsz8H412fIeOce1IYp7/6xfqAaPmVxuU1KiEqsJEDfTrbVTd2NRNa1a4T/GerDK9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b3GBR9rd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso361149366b.1
        for <linux-pm@vger.kernel.org>; Sat, 30 Nov 2024 02:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732961280; x=1733566080; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bF1qKdUD6G82UToWOeQ2OIejZEXXxD5wyzBbKqaeajo=;
        b=b3GBR9rd0hyfCgYKbu8TnWR3qKxYGOMQvNRF3pPW54jLcHrFjMguPv5NyYyQOP/YDm
         xS1dSKvt+9R/eR5S8HICejlOgGrg3re5qSYaL0q8UW9qmQNmxllmN1YcAEP3qHENpyQH
         wtFEK6EJmi0nPi4VAVQzhJyVXj6cK9+e4yCfq0eNHGQyBIUWhrTiA4TZx1E50Puvuyqm
         Hc5hO/jiXVBPKMBe5EBA3D5G/sNkyeHn1qALIuKFAW+NtTiZ/13P0b0jKei9fEPxKTSv
         ET4wwN1gmBSt5AT9FUTVpAMrMVG4RqqC1cq3D3k5B5asl4+ABWPuQje1Yh6MyZDfwdJH
         VlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732961280; x=1733566080;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bF1qKdUD6G82UToWOeQ2OIejZEXXxD5wyzBbKqaeajo=;
        b=tFySBPn1tCwUFPAP9IqmkKIcyyp1iARsaG8GloidFEzOP6Z6auqdnGWiNbwbqdUW/D
         BGW2xd2VUUMRaLWy8FvBQ9HxmdcoLuEkAt52pmRM3ZCIFxfC5j6N4E8CmCic7tSsouAk
         lZl42ZglrjfqVgllztlOafpS8hdnBxdJuXV/08/l90iskpIPs+5HPknWfSVsxIsq8O0Z
         wM4Ar8axz5frMWZjF7m90Gw/syxm9Ga7O/Fw8G7wAa8eMPU0r4tAshbi8aFKUWCEYfKe
         Qa5sZUZNJAoUtNz+CgXksRB25p6LIyaTykFz9FDJnLU4JJ13XHiwc8z2yDwTYo6OtiSe
         seMg==
X-Forwarded-Encrypted: i=1; AJvYcCXD/GclLpMESl+34/Dib54bFEugBLEsoYH1csuQAK0Y5YkWDKdbY7VWwNqh9uMRp6MiMqhckXp7Og==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0tLnb9D8VqUZixh4ZK2Dfr6FaJ52oljzKrrZ0h136Dl/TMia
	H3ztnzSE6de2MF0uKHPGQECnmt+xKTCMNMH+qLOFfrn/9+TovqPF26RPaCIV1qI=
X-Gm-Gg: ASbGncslcot+KSysD75AL7xuOchsmoijENbA343l6YaY1hRxFlG50PXbScGpBcDOsBj
	O7JR+n0fNsfLn9n35ml6Odqay2ymH481dUr8QTj3OJywIq3igPBnPraKMZAxtlWbcB4zXMatFwt
	u6xGRu06t2tbPNZDXVvs5H+sN1dBYwz3sV/2aJGx5WEgg0YWKVypRhQLnG2c9Fwf0TAjXcUL4rb
	qJfS+nWZy0b43HvFEOAmJ1ZzAq/iOVjqX+jLxk2FQknLzzoH4RTpdUui3zgghvQDixnCuJp
X-Google-Smtp-Source: AGHT+IGFFkuSzUzBV6MpzgZNlz2YgAq3cRPDWZKCNGkjjw0xQWjwQCZY0kfL1J0lIP1VbayZcSBWxw==
X-Received: by 2002:a17:907:7819:b0:aa5:b2b:f236 with SMTP id a640c23a62f3a-aa580f353f3mr1240877266b.28.1732961280003;
        Sat, 30 Nov 2024 02:08:00 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de7e7sm264394866b.71.2024.11.30.02.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:07:59 -0800 (PST)
Date: Sat, 30 Nov 2024 13:07:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] opp: core: Fix off by one in dev_pm_opp_get_bw()
Message-ID: <41ae307c-f6ff-49fb-a962-eb488152de71@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "opp->bandwidth" array has "opp->opp_table->path_count" number of
elements.  It's allocated in _opp_allocate().  So this > needs to be >=
to prevent an out of bounds access.

Fixes: d78653dcd8bf ("opp: core: implement dev_pm_opp_get_bw")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d4a0030a0228..09a1432561f6 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -121,7 +121,7 @@ unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, bool peak, int index)
 		return 0;
 	}
 
-	if (index > opp->opp_table->path_count)
+	if (index >= opp->opp_table->path_count)
 		return 0;
 
 	if (!opp->bandwidth)
-- 
2.45.2


