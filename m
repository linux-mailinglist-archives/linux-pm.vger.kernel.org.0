Return-Path: <linux-pm+bounces-18423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D8C9E155B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 09:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F37284C39
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6466C1CD204;
	Tue,  3 Dec 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4BjREfV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462D198A0E
	for <linux-pm@vger.kernel.org>; Tue,  3 Dec 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733213590; cv=none; b=GKJiNFkX2Jg8SzFI2uexwZtwcqJPYsmb4mlO3Dq5CfzfFaxeB8LfWSFbchxX9qYrr7TXiwl+FaPlR3CLpIlmmkcV+q6sI+boFE5TSUgIEgz0e6TqCo7EkGoRQMV3mJAZN05y/s0jFXaFRfZVokrodnYdK1U2zqHdX2ck+aZ8VCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733213590; c=relaxed/simple;
	bh=GfIxjX3fUAG9xD0E7y4Y7LPGVwA/ovHOoj/JqoQo4b8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ot43wjG2Ot0ZDxMu3V4VZ1uNzp99khPW68Iq+CC5aAU4OmTLOWKjWyGjHcarSqBWQT+hqmDco/tJxOWoF6L8NDmZCw8Twi5jodSE4YInHTtmPE/cAtu6IeGGIG03PJMTeQrfDFlE7QN1AC4HJNvXTITW2u5EfjZJjk2a8V4Gf+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O4BjREfV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53df7f6a133so5513363e87.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2024 00:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733213585; x=1733818385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2919edKa0scKH1VFTPp4m2/Qq3wOxmRVQ7yuQJSD4N0=;
        b=O4BjREfVVVXTSe5ArYQqnCSlBSSLQdVhil3OvX8RF4iZ0bRgfrNQGTcXdkZL2FYNfV
         GFBNNWtzGzEfOybCSOgI+gmmqu5Ovl8D/EjFx4iGDVQYCMPCv3LwJt9V4FjNpicqn+m9
         cTgaPIbKbrFyPW0t7zeFwbw7z7xzs960gj1X5Q0v0t7oge2xj36/VZRmuySHz7NZpjnN
         tRiPSJTx45hr67Y52zJtMqV73s+AilHOnBZJGF1CnjfrQONVok6mh8jjJiZaJlOcLJHv
         06jcGYjaBauFSm3cfMUwvAQKvDFHdnPQnkk2lW2fQKG9FlzsNQsygLh27b3ZwcemBnA/
         b1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733213585; x=1733818385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2919edKa0scKH1VFTPp4m2/Qq3wOxmRVQ7yuQJSD4N0=;
        b=A5y5o3KcYb+SFtsVkwHqS1uJGC+p5MAgKWbci3CCOdT0LHJcdmn63XDxmdMu73+MJt
         6ZzKUYoFz8Bq3aJS0GKajN3d/ZsF10zFWcCHmbzICnI7KZoOstsrH4ksuOvUjrJ7Z3Ci
         4BumOlp8x7zPo+iBOcwyVJdDMiPlcKLTyNm+RXG/x9/JB05JCBR7yrI1CgP4FTRJT6WS
         OVFRvmQChSL4jH2h2I6bF1MxhdSuH//IHG2DSI4ZRjcgQr0wytHhRuYUjmZEcgCQny1w
         EfbSiXs3NF+Whkb3NLiIwxUy1+TSTuO2fYw4De9kA6r8vCGh4C6byqT46cMQr4IgCPFj
         2mNw==
X-Forwarded-Encrypted: i=1; AJvYcCWIsBF9iCRbzjX+TkIsyCoBOdUmKIBLtqwIPTd2gCtDUo0DyAh/hMaBm1NfhXKiW023YnR1oTiI9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YycbOj0n2g0JduRn0tC3HzgHiXDo3ak8rDI/jpoGGBbt3mXRHC/
	Gow9y/iaka/EQMPnNgd1JqUzOZRY+oSjpmBaa2H61fVExh6AEKsvvNA+eZShJp4=
X-Gm-Gg: ASbGncvI9jFvBZC2iMHMkdoofM0qvKT8rmrmbWpc3NsniA0zE/fqFU1qVTmkMBxLDaY
	FGYsV1mHfVT9NXiBwLXFzQHccSZk/+SLU+Jh41/ixj7MSVFDwxgsnXFOcIs3BiIMp6cWv9MHhxc
	K1+XLyiQIKcKCIIk0y1yIJTmTS/Gy0iVbOihaZyJ7X16ZC9u119vrBqDpt8tp01BdWaUHOokQhq
	WLUmaAXunpVRqGFwznNxI3FQCpWhjmMsNvfl5ynnrAkha1MNVeUt7x0qqEZRRxL7hJkOvw=
X-Google-Smtp-Source: AGHT+IF96tm1kW0L+6Eafet2kokvnQva3vx6OFst6liTSpf4L4XZltWOm8ICfrYv1DvfjDe/iDx2Pg==
X-Received: by 2002:a05:6512:2810:b0:53d:e76b:5e6e with SMTP id 2adb3069b0e04-53e12a058a2mr876514e87.31.1733213585423;
        Tue, 03 Dec 2024 00:13:05 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f2c7sm215212575e9.2.2024.12.03.00.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 00:13:04 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 03 Dec 2024 09:13:00 +0100
Subject: [PATCH v3 2/2] OPP: fix dev_pm_opp_find_bw_*() when bandwidth
 table not initialized
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-topic-opp-fix-assert-index-check-v3-2-1d4f6f763138@linaro.org>
References: <20241203-topic-opp-fix-assert-index-check-v3-0-1d4f6f763138@linaro.org>
In-Reply-To: <20241203-topic-opp-fix-assert-index-check-v3-0-1d4f6f763138@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2351;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GfIxjX3fUAG9xD0E7y4Y7LPGVwA/ovHOoj/JqoQo4b8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnTr2Ong2+ZytkxIK3MGstGfV86Kj9+CTp9OMCqeeK
 qFhNAI6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ069jgAKCRB33NvayMhJ0Q+DEA
 CKQjhM+SeZZOaLtTPK/swZ1Re+qNDLT9wUIMuCZzOIjbuuoMQHa6PjyLiDt9KVK/9pmnoCMEPPo6y3
 BPw+JM37Mc+rzES+XO6axgc9gE80c6DpMLIpf00WLnOybpsYMz+OuRX8ElA9bY5Z/PH2cV9UO4sEQs
 wHPxccYfZaPy8hZn/w/OO+49SBfCPV2iTTFtyi3EQQLx97ZB9olfvnZvzND7QbV8Vs+PvDYXridrMl
 zLrnSmivO3ZkThQzBXXekIy9ADKUTGbQCJu3zoHp11zhXZbIZKe6Qy7pnWqgkQmgXjZ7mNnBHppqNd
 vGQDkGW57bl7U/Gfqa/BpVoU1e0BH0UVt78jUpW5k3MZ3/4FwDCQVKEGJWGhrDST9mdU3umhTFHMqR
 yhV2oHDMh771Z9YNP9a/xO3yA2AgDbcdezwRcouR6iTj0N9Vq2N9sKS3OK8B4DMF9EJ1j/U68J3ME1
 tiiLUvsFSQJe9XEnUUMsDm9oN/UG/QNwxcFNjlY3/UbMUZH1zjYDxzhG1/Hhveh0HttP0pUnTddILK
 a2+MUCWrQeibDF0ropeuGdyPAv6MlHfCpqviUjWqoX6553b17u6rm2ncFpWFDUrDVcNn4kdHV5JjW3
 XG43HgIQ+dxFCbvCJsfk6EJR6TDqkZV/AfR6DnKlgCj3r+Pv3X1rFuBBirsQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

If a driver calls dev_pm_opp_find_bw_ceil/floor() the retrieve bandwidth
from the OPP table but the bandwidth table was not created because the
interconnect properties were missing in the OPP consumer node, the
kernel will crash with:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
...
pc : _read_bw+0x8/0x10
lr : _opp_table_find_key+0x9c/0x174
...
Call trace:
  _read_bw+0x8/0x10 (P)
  _opp_table_find_key+0x9c/0x174 (L)
  _find_key+0x98/0x168
  dev_pm_opp_find_bw_ceil+0x50/0x88
...

In order to fix the crash, create an assert function to check
if the bandwidth table was created before trying to get a
bandwidth with _read_bw().

Fixes: add1dc094a74 ("OPP: Use generic key finding helpers for bandwidth key")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/opp/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ebe7887a27d3c1dd6c652c8bf9f5f9a285d7e74e..137764f2ac7c72585953d0928b6f917fb6f1fe7c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -116,6 +116,15 @@ static bool assert_clk_index(struct opp_table *opp_table,
 	return opp_table->clk_count > index;
 }
 
+/*
+ * Returns true if bandwidth table is large enough to contain the bandwidth index.
+ */
+static bool assert_bandwidth_index(struct opp_table *opp_table,
+				   unsigned int index)
+{
+	return opp_table->path_count > index;
+}
+
 /**
  * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an opp
  * @opp:	opp for which bandwidth has to be returned for
@@ -915,7 +924,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev, unsigned int *bw,
 	unsigned long temp = *bw;
 	struct dev_pm_opp *opp;
 
-	opp = _find_key_ceil(dev, &temp, index, true, _read_bw, NULL);
+	opp = _find_key_ceil(dev, &temp, index, true, _read_bw,
+			     assert_bandwidth_index);
 	*bw = temp;
 	return opp;
 }
@@ -946,7 +956,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 	unsigned long temp = *bw;
 	struct dev_pm_opp *opp;
 
-	opp = _find_key_floor(dev, &temp, index, true, _read_bw, NULL);
+	opp = _find_key_floor(dev, &temp, index, true, _read_bw,
+			      assert_bandwidth_index);
 	*bw = temp;
 	return opp;
 }

-- 
2.34.1


