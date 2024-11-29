Return-Path: <linux-pm+bounces-18244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4D49DE913
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 16:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4A6281960
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053DC13D8B4;
	Fri, 29 Nov 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTYeAdiR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46428147C71
	for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732892798; cv=none; b=Rsi2Venltd4HtQ86Xz4N5CU+Q9RPNvIwGVvMB0ZQHbi8Gk8z3GVHU9S/D2y4UaUHm8XfZ94kfOVEu4/6Jp3iPaImgjf9/2vu9/GYtbIvh5Zh7kfJLd3b4vVs9Q72Uw7FPm6NgPTstV/ZWSPjz7+EttQHn/fEL7MN4F/a/y387Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732892798; c=relaxed/simple;
	bh=9yHf0KJWm0K/IY4/jKLBMpZERAg9i0/ucu034t8ZUuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQ2LIcR8c3PfsqnGKkDSBO5vckzJSIyRdxD3Ybgf2tve5N9UaJuOHVS0pNMUdDYEhtQTa3TJ0A8LLPHsi69ckEvNaDguj3mz1eNoEy80nkTJContixpdL8DSbDNLu/Nbw31FhkTKjp8mbdm05lnfBHxkOlbuOmkiSgYyTRn80Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vTYeAdiR; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e1f12c82so28368f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 07:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732892794; x=1733497594; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVplK0gY4Tmc9m/uCWwm84G2EK5ABI9/9ThqPRIIUiE=;
        b=vTYeAdiRW2T05tMoEfzORBv6d+XYS9J8BRhBK/CyiO89iz3Von2Cl0Z0E4IWlm23Pk
         FiinbY0wGaq2PPao3U2v/5/+m1BBWiSYJgMbxMcxOC3Kje2f8hao2nH73pA5DdlWTBi0
         O9rCzqG0fb34Wl84PPv9NSHa41tlm1nb9VlNr73C9jIcv3puhpUrkFHNxDMa2BSb9rnw
         wa2fdwMIubDlEGqOjrCpoPQmPx+WDOPsuX9q4GI/WRXERElkuxVAgyhi534yY4McRnSb
         T1vB1GlpNWXPOP94XQ5oupkcZLIUIppau5PCCj3eoQu1Djpukri9+RJJjmVN2guxlhK6
         5KEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732892794; x=1733497594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVplK0gY4Tmc9m/uCWwm84G2EK5ABI9/9ThqPRIIUiE=;
        b=NcR9H7cycNdW+FhisXvfxc+p0i5mpDAHTpokJAibpyAKH0ecsQ6LVD9XW2s4DLApbA
         rlrucMv2uDOBdEET7Gjg3BgkCbGaqcblfBF1BJOMRpK7M2kbOe9ebIJP2/ezatjiVT/M
         JunL9V7qLE4lmTY1aHVbJLNODBN9VBuJ+NW6nXHBd7HE1bl+c3ZRqJZHkco2zQGe1E/0
         J6l8fBcwUytRiOFglMwZvCfnNO4p/pPhIzvLeyCWLWPW3O6inrFjnzRUTl/Kc4aSK3Nz
         dpy51zwH5Nm9G1kGisHQUU5K3t3z1h5I4yMHaqhmdG00t89OePsoU+R6LLI0n6f18LLM
         jHCw==
X-Forwarded-Encrypted: i=1; AJvYcCWm8xJxNXu+dQq6X0PzqMlbqm41sv/pNXu26BNdSeIzw1bCfPqTUkpR5V4gJu2Ycdeg5lMqWHRj7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK9oS6/VGuknIGCoaNUqnqJ7Q+n55jGUmWXUz7JWnMyN9R5I92
	fFSVjzLpvxa5Z7YZ+TW8A7CunP6LFmjaXsDZeoF5X9m9GV7lTT+FMuV1BAJRauE=
X-Gm-Gg: ASbGnct/YswBkziSfvQS+okH6+7Le4RXIGT0u8OuLKrcZ/+lcUy34lfwVUKAxN0Qsri
	wlZh5oZUlim+Of6fJ3205MMDaOw9bkFSGEFJnN5wy/yUeDr56azSj0cVF10B4mKg4dRyU1QEidE
	DbAdIKqSMDF17ioLol2kfVB8mcAXlUuwfD7WlqLdLMxf2MXEMwLWY7a3GI/iSlAXPJYdyuxdA3k
	QNdWA/Aeqg7oiNtVwaKajcbDKnwhWycUIxsTgFbHUySD6MvRtdRbkErVnpJep3sENQXZww=
X-Google-Smtp-Source: AGHT+IGpjTuS4N/6ugXpDEd/u75FUuiXXyG7Pn24HZklpgewT4kxHW9i52CNdh3NkIYPXmDr0u8+QA==
X-Received: by 2002:a05:6000:188d:b0:385:ded5:86ee with SMTP id ffacd0b85a97d-385ded587c2mr3550345f8f.57.1732892793791;
        Fri, 29 Nov 2024 07:06:33 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2df65sm4759637f8f.6.2024.11.29.07.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:06:33 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 29 Nov 2024 16:06:25 +0100
Subject: [PATCH v2 2/2] OPP: fix dev_pm_opp_find_bw_*() when bandwidth
 table not initialized
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-topic-opp-fix-assert-index-check-v2-2-386b2dcbb9a6@linaro.org>
References: <20241129-topic-opp-fix-assert-index-check-v2-0-386b2dcbb9a6@linaro.org>
In-Reply-To: <20241129-topic-opp-fix-assert-index-check-v2-0-386b2dcbb9a6@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9yHf0KJWm0K/IY4/jKLBMpZERAg9i0/ucu034t8ZUuM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnSdhyA5K9LuQf2hibSwfMOcLoWPeVKDCzr8fh4fDg
 vEz0EhmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0nYcgAKCRB33NvayMhJ0e0PD/
 423aI0Dmnr1QZ6PDbOOOuhw4LGjo5XIuoi8jI3fIshhu8/Hw1ZIbsxkwOkDKd6+NjTvZhuy/ZMwal1
 jeV3NfZykvRRTux3EJ0U0xoE2Zb1jrywxp1q5a5pnI0cdbOWfX239x89gEtMhwC/x3KHFyCsWVyLo5
 GjJ86edXwEZSjHbYaoQLhtAI9bSuay94hM+LA2dr1IiGnEUflsGwFO1gwp7rfEh+SSNrHW6igh/Jk6
 AItaIdUJTxW+LFosDfo2p5lrt19lvkiSyoOTJ+QOq9o5y9OxpyRy1KYP11WN5e9cqjd5BcVwTL+3f0
 KIYr6MxOK4ncX7q2CaHtE1bMhqg8520W2P6lNzUk0jrLR36fq0lL2+KohC2bOvHOYiN8VX7pMpF6Gf
 vFDiENUjQpOn5snFoX5wM5FWqt/Q7MCf1CRNGPfU0z4xLgPmPgY/6RihvCctYduv+v/8WcCWh5Hmmq
 LE1rvSRU3h9/LD9kqoXKGkjCg4y/VOw7bh+W2L9ntR101JgDaHjlfbrNus6O67LNRY6keSBHx3g5AQ
 76QZIqPAG8bHg5jfAZt69k384Satzq1UNrFIyH/NCKfW2ragquOCFDCBHn79teS2OlZBnDjwDmal7h
 HKBKwK8bx4XkkEakV28IEk0YSuhUlInb3D+jsAXUJj6DOW1gErL4PpglS+Ag==
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
 drivers/opp/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 52c6a45ceb7479c3ef0ed97ab43a37546d695c7f..c7d16b2c5110089aeb35012be1dc35dfd209963e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -114,6 +114,14 @@ static bool assert_clk_index(struct opp_table *opp_table, int index)
 	return opp_table->clk_count > index;
 }
 
+/*
+ * Returns true if bandwidth table is large enough to contain the bandwidth index.
+ */
+static bool assert_bandwidth_index(struct opp_table *opp_table, int index)
+{
+	return opp_table->path_count > index;
+}
+
 /**
  * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an opp
  * @opp:	opp for which bandwidth has to be returned for
@@ -913,7 +921,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev, unsigned int *bw,
 	unsigned long temp = *bw;
 	struct dev_pm_opp *opp;
 
-	opp = _find_key_ceil(dev, &temp, index, true, _read_bw, NULL);
+	opp = _find_key_ceil(dev, &temp, index, true, _read_bw,
+			     assert_bandwidth_index);
 	*bw = temp;
 	return opp;
 }
@@ -944,7 +953,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
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


