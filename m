Return-Path: <linux-pm+bounces-37552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4380C3D2BD
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 20:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D860188E182
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E200357734;
	Thu,  6 Nov 2025 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQqMdFnZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953E3570D3
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456108; cv=none; b=DItP9KYc2wn55GQCJe9TQGhGLA5/F2+FaX5pT0XitZ9eaMu0DHY+oU87yagwKuCOc/+ZDJKf9LQSNMiqQtGe/qzuG6jdL/hcAAxCuHXYJ+15hE4CaKxa60enbZax0A/+q5VwJYn3J4qmn3ObHGtYxstThtpce+aKo9I0znd0B0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456108; c=relaxed/simple;
	bh=mMs+/htGtXYGsIA71gg7FmYxj0Ux55LRPjq4c7c7iAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/JYZpm9klxUAIVaBOslaDmOwRfOKErcm/0/zrYEeMOQi/75GKp5DglD6BFpZzLtr9NUfKCpGfXxSf8v0XL0+kJpH6YMwG5iO9OO8JONNiLZ0h945gwjBvPVZQHcq9PXTmDbpgC31miUxNdLdBIMnpRBTamolzU+t84LPIfY4Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aQqMdFnZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-633b4861b79so268860a12.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 11:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762456104; x=1763060904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBDauKoKfPD4CnZZWtWcSb53n04sjO6bQK2uW89yUaA=;
        b=aQqMdFnZ/EDbn5WdteambA+Xc3GQlyI8b7m8ylszwSPejK+NiQFn7rcT+7F24nrY/H
         5fzrZKogx9kbUl6gwFkr5vQZzq66EfoB82318oCRTbWOmt7gQu8Wii70ZcEfOfn7krES
         XM8j7l0WEa2tACzmLoeDIKMWSu2bUaRaz3RB/h7cS2vAkgQ3dK3H6e3RFnXSYBfDR3lS
         OYtBw4QHPF7r5yCyXY56UTk37K4UiC+rYNqMHhHmyRJYhXBZ6N3tMAjS7DE+ShBBZs7V
         nnDiGh4m+bC5D5Wa9UrSeQpKVgIPu3HRDGJywX6an6ET8UQg43BnhDIYIhAtDFsdx9a5
         7IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456104; x=1763060904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PBDauKoKfPD4CnZZWtWcSb53n04sjO6bQK2uW89yUaA=;
        b=v6pOoQu6dzvaWmPknrVZpd6rFeLpObTw3iZsWlSZDyrICPiYTHngUvjUaNTspIQnQf
         o3WcjPYgpQji5D8Mvj4ZyB7JXNatCfLYOGARaUsZEUpSNU7fcP6laN0l23gLqVvNYkD4
         RLmFlEB9cVWqJEvG1Gk1fJlKQQQ9X6Hz6LKsZaWsElpJYt5gHYLMZ0w7yQZdroqtiH+W
         0HtY8cO/AxHKVOyzKgAAoMOflnFyOfZ87vVaw5A8U7Syh+NmhSODZuUAh+mI1XcHi0QD
         q8EhW8JT6MwU5DtACUqHqZCoMLMvyFhjN+gkgQWSpkm3qe7IW+gd6z2nFIq5V3yOoN5i
         S4ag==
X-Forwarded-Encrypted: i=1; AJvYcCVcerqrYKRbLBhY6936O3fe6FI2S0//1KN65OwvWS5ojopOsZJ/PKmz2FI4gi0P1kFjokO/V8Ba+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMwsyn8RY7wJL7gbsYgKxJvmQbLgEtkHL6kWsveN12i4Dv11pJ
	d+zhwu6evYoMGMxflIb5u1wYJKSyQaa0Ypz5U6tqk4MDwpke91A3ejpZ4c1e/KgwF5s=
X-Gm-Gg: ASbGnctLrMRKbo17wXLreHGS3skZRJvdH0z+ZfG4P8oNlV1mMd9SPXAYRrUVqNtEqOP
	C+5w3z0bADz0Cf63c2HslPhqFM8AJeqg4hRq5IEwdv51IMEJZCkfjSCtRdHVUZD79u3e0DY7ciW
	pr8ezyB1ixsjLK5y+8ZF8FYo65vxdVLbD+8iQ+TdyD29aDQA6Drlw0fVs5D50RFFBhgLJ1elMJz
	CazFFJg35RhBec4fOl+OI8XUH88UVesj+muXAgBdI7uSa5syiHWG/g/2GWo/a6lPmoyVF0VCYl5
	G+z5qfOlORb80Y8ToW5BcHQptOhGZ4AJM1jzohVc4eg9i1BKw4sNvlr+Tu3+qp11tnSguH6OS4T
	CxhNImb24vHI0itQIWuw3s7Xh0IPo+l4a+pV7jPtVxIebKj04m6vByKPPdujOB5N49UG4Yz0nCS
	9aclpKS7spg/Jz7YUwWF3LJg8NzOQ=
X-Google-Smtp-Source: AGHT+IG+hyJMTcEGj5iy777lLiyM71Dn2jw/AE3Pf8p7sH3RSp5ANpEt8SWqIzbEh+pnzhio1EyGSQ==
X-Received: by 2002:a17:907:6ea0:b0:b70:bb39:6f34 with SMTP id a640c23a62f3a-b72c085cb83mr16365766b.1.1762456104130;
        Thu, 06 Nov 2025 11:08:24 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa2510esm26739566b.72.2025.11.06.11.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:08:23 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 20:07:14 +0100
Subject: [PATCH 07/13] firmware: qcom: scm: Simplify with
 of_machine_device_match()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-b4-of-match-matchine-data-v1-7-d780ea1780c2@linaro.org>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=mMs+/htGtXYGsIA71gg7FmYxj0Ux55LRPjq4c7c7iAM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDPIPnieH16c8d60rwZIiX6haowTgQtMDdTNgc
 Nt9m3EGIpqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzyDwAKCRDBN2bmhouD
 15MND/9iEN4qP+PowaIfKdmRXiKRnNXohM8G8jgJAet6APPR2LlkfxfOSySgRZDLKCKTj6THV0b
 7S1uNUEDLipfAfqOyb2ES/O3p5hOdH+NaiNLbJNFfvKNEVsn1979VTOkhpl0yR8E/eLVMk6Rb4v
 3BjFCTTZSlOxYovGcx2SaB8PFO7Mb0UJEj9+6dJqeF+WyC1jWN89UziF9Aa9kShSX7nhipdwh3e
 ZvzDbpiCfcqIJ1oAWBlOLSkYTWAVyHAxnH07HvL+u3MaiynTgwewgye1+rFCFDZXCord4VxYgJi
 r/pAXsBB7P8GdbQ/0tzWWixP0N5XIW+p1fW23ZI7sp7IeSI/y8IOHHtzb3RfzN5z0cL89NB31Ld
 ZMzeoYy4VMqJsWvzxzO5H04KoDvuG8++JeHBB7TFbaBpwfMXXF/fhWawgvSGfvGlQVMHPkvwQzT
 pm/KFaHtPyRmeKO7mf/wyxYMOHlJWUFo5HgpPwzSKC/wTylBSMjmlVio4ZGFJeLMvA1hFqKE1md
 ncgtRPz3+HXM4i3pKZ1yCq3ECTajGjpZ/G0S8kFfY7AEKZlPseRRXMisGjDhnEibdRTOVnsmjBs
 vG5FsRPbRPg/s0BYkgUIUEREnc9tP+jJ3rCqmA4Bd4DOr284xpS3Rd+NkltT1CfIkfO1IRPgHtH
 WEqN666U3/TfL2Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Replace open-coded getting root OF node and matching against it with
new of_machine_device_match() helper.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first OF patch.
---
 drivers/firmware/qcom/qcom_scm.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index e777b7cb9b12..1a6f85e463e0 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2018,21 +2018,6 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ }
 };
 
-static bool qcom_scm_qseecom_machine_is_allowed(void)
-{
-	struct device_node *np;
-	bool match;
-
-	np = of_find_node_by_path("/");
-	if (!np)
-		return false;
-
-	match = of_match_node(qcom_scm_qseecom_allowlist, np);
-	of_node_put(np);
-
-	return match;
-}
-
 static void qcom_scm_qseecom_free(void *data)
 {
 	struct platform_device *qseecom_dev = data;
@@ -2064,7 +2049,7 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 
 	dev_info(scm->dev, "qseecom: found qseecom with version 0x%x\n", version);
 
-	if (!qcom_scm_qseecom_machine_is_allowed()) {
+	if (!of_machine_device_match(qcom_scm_qseecom_allowlist)) {
 		dev_info(scm->dev, "qseecom: untested machine, skipping\n");
 		return 0;
 	}

-- 
2.48.1


