Return-Path: <linux-pm+bounces-41003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92614D31B09
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 14:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F2AA3057F71
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CEF2580CF;
	Fri, 16 Jan 2026 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="mOjnHEaQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4526722370A
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569453; cv=none; b=acRDE2o4gj2uLfCEBtHU90SxC5K9thBc5D67vBUV0aMAEIVBGhsDwFRXJMCND8taQ6luCAXox8vOCe6FH/CXTbwzqryFAUly6dtjfpoWWl7KTDfC3d5ZQYSfWwBcUue2EIvFZgdKlqVYtRxPj/lb8OeaaE4aHLisYEvC8bjzcEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569453; c=relaxed/simple;
	bh=5i0VsvUcS0SUwOVd0wGHGUe0uBItUE4uGBSE3yIgsYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bUvetYnzHXSdnEPi1otxL3/+EFrqFZQFOoDZShkIA8mqLA+QaVJHXC31NSiFRXcPBJedesL6CUNoTA60LHuMOhoBvZrutYdctu51zf/69U3RZzRIf/nc/nxeb7RnLeJpzxvQG1QTjVh3da8qe16MwMxuwdzBqnyb8aAVxXp0t7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=mOjnHEaQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8765be29d6so291707766b.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 05:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1768569447; x=1769174247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duq39jBoqDFtabq63HAqX5adf5fdfb9r8RBQ2RPSZD0=;
        b=mOjnHEaQ0xxNRyxaRCwgz00PSnpOxde71MA1Cdyi1PZpG1XySlKbhbPekX1OJPrphr
         FBnSrVjmcOvp6VIwJxNpZkarwpgCNFaqwl7PUkzMNSG4VAIORELm6u0O+pw5p9Fe7uKv
         n76OKCHRioCRE3mJXgxGlZwM+tDreLGwshH9yNW7dikStHvDuIBm/qCRxG9hUipKtJV6
         SuMtQqasEkJsxY1h3k/YQBnJq2xQmQfXdmEP8/lfuwflQHgvKGcWPoHCZpbsJUGFTRSA
         FrcopB4CMrUQDykTUbPwZkIgIh4fK5NREzImnnXvShug82Tj82j8k9o3tPdYflJQzFqf
         fEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768569447; x=1769174247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=duq39jBoqDFtabq63HAqX5adf5fdfb9r8RBQ2RPSZD0=;
        b=bKgLEJyXRic1yBG4UWqwg0tOiNc8Plw4bGfSGyxE/mEaS0mQzM/X0zy+vKvGATs2Th
         R+cKg8acglYaZfiYsOgQ8th3rJ29ETpS4d7W9uORRgKR+iKmX+MRwRgVF1otWLMxJI/q
         R3la6jXjt1yr8OYD+kHrOU7IyjN/vLOB5itwFkzQR45oUvDDlCF9XDdACuHSW3C8Hp6Y
         MmES10l21FlYK/s8i3uauKyeT7V+m1OZVmPclNwJCv044kctNsh9jp11LhVpEeJ3yrqC
         BBcK1AyhhJR+TQvdvVd2ner2DnKsTBOeY0AKZTPCw5fU2pNSNTtEfxVf0zcWM3cPnluW
         zJ9g==
X-Forwarded-Encrypted: i=1; AJvYcCWOdJXamZgLXWPl+19pdyBdB8X1IXOvZZBu9OCYGBaHASHDZADhyqpQN2XH9LEitEzuKezt9e9hDw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Dg4rq+J4X4kBy0B1QpqlVqBy+Foqu++WfCb88UqXkfhq3npJ
	OWcSyoXEyuTO/gh+FRHTWaZiOm1N0qsw/vm6laQ22RgjnwC6ndCQMcfY+ko/51gFfBc=
X-Gm-Gg: AY/fxX7kBRZN33yP81neZMxp0gOu8jpplhnIy1Pz/RJRdvZ9sTcuItekkquA9rklLXH
	mMaIBrGuK9BLvv7fWJIj4AMmbFL4A/j4i6mBGq0w8AOVTYyfQGtw00WROfx3S+FBKls53MYGbES
	R8n4bt8y/U9cvcKH7pXE17NFJ0Qb75t/5XX+grGnVoX6vurzHqGLwPNAOdZmaevITCWUNLLVbeI
	XbHDyt4cAQzf6W1G/FJ0/nDNo1NEQ2gTDGvNgZfY8/sp1nvtvvMbkgcKM7WJFPhb95eRYvYNBmD
	3uWVs4SIV8BRoXOU3ZrSFgwKcqDBKIQ8PM/TxxNrouNfGwMOucUcT7VaVs+alcHqFuUafR88FFT
	jgM4yu1AImVNcqc9cPIOQlbpQyUtvpXHscc5GYWtlb6AdQboTjcbkEXY4D+TyxU4ql6gmFBX+ew
	7YeJMEmLVxGezLv5r2yPAX26FogxCj0e+pm3AbyRZfymS7uUyD6RmL7JnbhtyPXlhO
X-Received: by 2002:a17:907:25c7:b0:b73:398c:c5a7 with SMTP id a640c23a62f3a-b8793008849mr255921666b.41.1768569447170;
        Fri, 16 Jan 2026 05:17:27 -0800 (PST)
Received: from [172.16.240.99] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a350dbsm235507366b.69.2026.01.16.05.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:17:26 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 16 Jan 2026 14:17:23 +0100
Subject: [PATCH 4/5] clk: qcom: camcc-milos: Declare icc path dependency
 for CAMSS_TOP_GDSC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-milos-camcc-icc-v1-4-400b7fcd156a@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768569443; l=942;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=5i0VsvUcS0SUwOVd0wGHGUe0uBItUE4uGBSE3yIgsYw=;
 b=pxIbdFvn4Pi8X4MwhDSzKXEcKRx9BJ2hA91ot6BC8vc+Xctsgq8QVNEsD4kc47w1mvuNfbMGT
 fbkIhmEQvCTC+X+GuHJJaZKe/3EgLXqaOD5082PO4UqZCO8X7y851YF
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

This GDSC requires an interconnect path to be enabled, otherwise the
GDSC will be stuck on 'off' and can't be enabled.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/camcc-milos.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/camcc-milos.c b/drivers/clk/qcom/camcc-milos.c
index 0077c9c9249f..45e68165a2f0 100644
--- a/drivers/clk/qcom/camcc-milos.c
+++ b/drivers/clk/qcom/camcc-milos.c
@@ -30,6 +30,11 @@ enum {
 	DT_IFACE,
 };
 
+/* Need to match the order of interconnects in DT binding */
+enum {
+	DT_ICC_TOP_GDSC,
+};
+
 enum {
 	P_BI_TCXO,
 	P_CAM_CC_PLL0_OUT_EVEN,
@@ -1971,6 +1976,8 @@ static struct gdsc cam_cc_camss_top_gdsc = {
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
+	.needs_icc = true,
+	.icc_path_index = DT_ICC_TOP_GDSC,
 };
 
 static struct clk_regmap *cam_cc_milos_clocks[] = {

-- 
2.52.0


