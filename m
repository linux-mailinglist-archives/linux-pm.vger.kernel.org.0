Return-Path: <linux-pm+bounces-41002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7FAD31AB5
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A20A3019658
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 13:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1977927146A;
	Fri, 16 Jan 2026 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="pg6Ka+tU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64877258EE0
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569452; cv=none; b=hGFKvU07X+/h0RZSWgUUqRPMLCwdZtnIEudcvD+BqQu0ZTmbPJodPUHV7ryDLMp0xp9qPtm8jk0fuPHNZagSCSOsHlIESdFKJp9kfzoLr420yki230DF68s+qtKAdPAXt3El9qUF0L0ah5tZQ6pBnKF3BCOVhneKZZTCRqi/gS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569452; c=relaxed/simple;
	bh=FtewN/DrAXamJnpTOxO78vEZuuizOqYgKqBWZjIni9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DnLJzI6OxWtaqXLMzdMxtESIlwl6qg2ng+hVHcn1lFJKxGlr8F2ysjzxTbIFFRs7f29T2u7AYMF438HxzJMZn7SeaftJjUNu249mAEYXoJuTUBHdMvotTKKiyb5GIM8ojB45+IdC376JM5c6k+Vhh9kaiQ+xtbmUxRNDF0pUUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=pg6Ka+tU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8768225837so277417766b.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 05:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1768569446; x=1769174246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhlx5emzP9b47xqsIY5Q/RFPv9dsLYm4piEORREEnEQ=;
        b=pg6Ka+tU0otA06bz6j664W3d9RAvgCKItczkpyPmZezTBm9CszX45+8U7GzFE0UfT+
         kawBbw2AT5hX8E5Nul/+y0PqIhB0zeBDLP4ONuYIaCa20rj6gAe1mT5jdBDT0hftYBs+
         I6NSA8huxRIocQyDAesfxN0eX5H0S+bBNEw9GDuu1/cjk4xeX/LAHKqW8spBe9HcAktZ
         bE086vkdawczgx6qoB4oT2UFEFABCP/jTlUo59f1l/a8sx7+fbu9mwWdnR7etDR1hMdA
         TGT52dc6FF5i+1SvSeHbab4AzysPxrs/lhSdyYISUX4gOKAjo+f7vzFdIMPbt1D5PMba
         yNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768569446; x=1769174246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rhlx5emzP9b47xqsIY5Q/RFPv9dsLYm4piEORREEnEQ=;
        b=L5lBcPmGFEU1k1nDeOLgsnmPcFauKiKczp1gl22qy9MhqvjWSsLpM2F7ZI6kwsqr/2
         gjEqWKw/AFBzjDMFB68MrzcE+oBimE073NJbb5ZkuPlq9HBSPQcZRSJFV5mWk5OLUHcC
         Gpj/7AM0tf2dhWnPdRNyrmiNJsDhkZzBGkT7Wdk8WV07opaV/9tzftdX8JP6ZdUX/wxN
         lZriSO/uMUen44ifwAUoC4LZdxhfNO8qPacb+6dXR4g/BVCv+hG90PBkAla+PponuBtu
         WJntUcpRVRFShbSadgl/El9FzCNtlT6btuXNUEuKlRW/D9hGPjdgQ8YYLp8DIgx2egMO
         Yj3g==
X-Forwarded-Encrypted: i=1; AJvYcCWPNLTBtj6QsZfOY7hcCXmzpOeHdMwrX4gdzIPz/KCy+wcjLhf5H4ggaQkJCEFmm36aUniCk5kYbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0NPGxAC/7w9v70SGCmfSyzeti02cp4JMXaj5+Kmtv4JNxxBsR
	HpG1VVZvCFlG5CaIM7f5yJqt8/JfkOOZcHVQhJQfWOA/7kEFSQfk3M4Xh73fQIE8UKVtis9PZAu
	VRleS
X-Gm-Gg: AY/fxX4YVr4ZK1qDooyOWURqVakJujA8okINLehgSt75Z9FniyPEfFDO9OSSaRVZXIh
	Uw+ffjpcS4OT/i9xszIMHsNF+IddRNXab4kDYohKqy+vfrkXKHX2qss5Bm0rMlDhT31DlgYaLwZ
	MsmxXeAvtQip3gHmFXLw+T6F5yMj5cz9uWPG3/ol1SIgGoR/OdlcO/2YsSCPtwoollJodAssrYF
	gc3OjcVNRfP4SLS2UaFJDZRBUkZ7EdCqzoMU/nwIc6bdi5/aSbPWoe1vgYNas2KmLkjGrrVut2l
	dsX72EJ4DabZDlDWRmYwEKoL1jZiVMYQkIa/NJj5GGQuk/b6G0IAEl9OnpLa/6ImituYzPg+lLu
	tTQYmRafaACaFkvsvNToZuU6e36HSZB7DsJRIZ0x1JmRVKPtyCO1YxAOv1rzcGxnZbUEWGPzjPa
	nMwy6n/NQXf0ZNt/iaWyvyZR//Bk25vo/k/7gjmwDRtsrkO6U+6m2rmlMhX55rmn3jDloyeBeyE
	20=
X-Received: by 2002:a17:907:702:b0:b87:2cf8:f7b2 with SMTP id a640c23a62f3a-b879324c7c0mr293012266b.56.1768569446608;
        Fri, 16 Jan 2026 05:17:26 -0800 (PST)
Received: from [172.16.240.99] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a350dbsm235507366b.69.2026.01.16.05.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:17:26 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 16 Jan 2026 14:17:22 +0100
Subject: [PATCH 3/5] clk: qcom: gdsc: Support enabling interconnect path
 for power domain
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-milos-camcc-icc-v1-3-400b7fcd156a@fairphone.com>
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
In-Reply-To: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768569443; l=2630;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=FtewN/DrAXamJnpTOxO78vEZuuizOqYgKqBWZjIni9M=;
 b=x4GXwqWuo6jrdq33GBtT6tJ+qKr74k1xcIHAngz8zsb5pzHU3zqpcBtB/3sXgYHAwKBDQUV4/
 MCX7Lg5LzliARKzTzK8Eg1nE2qFKjmTiYZqAzcdsWWTMObC+Om+nhzP
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

On newer SoCs like Milos the CAMSS_TOP_GDSC power domains requires the
enablement of the multimedia NoC, otherwise the GDSC will be stuck on
'off'.

Add support for getting an interconnect path as specified in the SoC
clock driver, and enabling/disabling that interconnect path when the
GDSC is being enabled/disabled.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
icc_enable()/icc_disable() seems like a nice API but doesn't work
without setting the bandwidth first, so it's not very useful for this
driver, at least I couldn't figure out how to use it correctly.
---
 drivers/clk/qcom/gdsc.c | 19 +++++++++++++++++++
 drivers/clk/qcom/gdsc.h |  5 +++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 7deabf8400cf..ff1acaa3e008 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/interconnect.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/ktime.h>
@@ -261,6 +262,8 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;
 
+	icc_set_bw(sc->icc_path, 1, 1);
+
 	if (sc->pwrsts == PWRSTS_ON)
 		return gdsc_deassert_reset(sc);
 
@@ -360,6 +363,8 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	if (sc->flags & CLAMP_IO)
 		gdsc_assert_clamp_io(sc);
 
+	icc_set_bw(sc->icc_path, 0, 0);
+
 	return 0;
 }
 
@@ -574,6 +579,20 @@ int gdsc_register(struct gdsc_desc *desc,
 	if (!data->domains)
 		return -ENOMEM;
 
+	for (i = 0; i < num; i++) {
+		if (!scs[i] || !scs[i]->needs_icc)
+			continue;
+
+		scs[i]->icc_path = devm_of_icc_get_by_index(dev, scs[i]->icc_path_index);
+		if (IS_ERR(scs[i]->icc_path)) {
+			ret = PTR_ERR(scs[i]->icc_path);
+			if (ret != -ENODEV)
+				return ret;
+
+			scs[i]->icc_path = NULL;
+		}
+	}
+
 	for (i = 0; i < num; i++) {
 		if (!scs[i] || !scs[i]->supply)
 			continue;
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index dd843e86c05b..92ff6bcce7b1 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/pm_domain.h>
 
+struct icc_path;
 struct regmap;
 struct regulator;
 struct reset_controller_dev;
@@ -74,6 +75,10 @@ struct gdsc {
 
 	const char 			*supply;
 	struct regulator		*rsupply;
+
+	bool				needs_icc;
+	unsigned int			icc_path_index;
+	struct icc_path			*icc_path;
 };
 
 struct gdsc_desc {

-- 
2.52.0


