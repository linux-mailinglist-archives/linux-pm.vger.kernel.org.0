Return-Path: <linux-pm+bounces-17774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EDD9D2D57
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 18:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAB81F24D83
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 17:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342891D7E46;
	Tue, 19 Nov 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2zYMKTC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2C1D54FD
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039017; cv=none; b=RIye/dDSJewi7YD9v6wmYEw4tyqGyRjjWofmJobs/Yvv9HilZviHywkiZ17mUqtad735uwWKRSluuyfBkjTkV2UzpJjpugdbEyxHsHMaw2gsbX+CNqTtm0yAFiHYtdu9wUOxLAUkEMIpco/BwhDy4q3hIGzWIyXe+XHx+cOl1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039017; c=relaxed/simple;
	bh=8YGZ9WKDiwlY9CXdycHEn+g53UomsCDyNV7cpV/GbpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4GsNMo0f71g5ikXpG3CGqKydj4x3ZsYLBmK9CXk4WDsthFyvaJKmGQ70UDUeGlAdAZSa2ICkreo+BZeloXTbgcrLpPoBg2lQy/FmS7QsdmVcaqJFN0rS/mCVZYW2gui7hWvpbfNnR/qxbkZWNFGWRcM0XeULvFHi9XLgN5jeyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J2zYMKTC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so11450635e9.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 09:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732039012; x=1732643812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zN/NhtIKWV0JWgHtrKAVVv8gpmbYvF+U20QAevdC0aI=;
        b=J2zYMKTC62AsxtBtRVYwdAvkw2t8XkWj/ecXqJ9hAju1pGiMjZx/HGs6PtfnQMqgLJ
         RIu09C4bW6159g76eBCcKcwmiI3t6aDkj1pi/sgKHTzsv4OKXBDIQiHILyrPqYCuE7m0
         0A+yh90BTRMc6p9nP9DDvOe0bXTCP675RSeBQm1Wj7G6Lm2QwlAj5RLQxHWTzn/N1IvV
         35blm3gbzClryGkTnhfKEvMezPwjtWm9pWY4ARsJe4I+CeKrNU9Akntf63EeNQoFuIdB
         DRYgZFJgNNtaCCP1E1+pEEKQpNmYrni6Pk9LEzO7fxceCCBaFmltbdXr8T+6FP/hnMah
         qePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732039012; x=1732643812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zN/NhtIKWV0JWgHtrKAVVv8gpmbYvF+U20QAevdC0aI=;
        b=rjWXDs3baAffcgo5mrrCMgG3t8ZFbO5/IcsuhRLxS0/b/NIUeI/FNNsNT1BxrTtTGm
         WHOo7qUaX3asPeW/u8YywHcfxPPWYUx386XVRHnYh/aeW9cE9418hwM05eN3yCu1KATP
         r0KLxsv/GvfYC573aBCKn5YtCCQ31XrJ/yBOAnkxWZ0CkecIE1phX5pkODPbPwBn+b2c
         6+OIM7wR0n1nRRvG8xp1+tC8zLYWVxjMAQA+tf3I+tpjJ3yy4H/7khd1ShHioa0IvDrf
         lDBXD/z92wnNLWJaI7Weo64ph6KpLdkTeBGd3QOHGtwjk4Dcmaq5rO/vDUOUkH19vfSC
         MgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBp5XAoYbq3i2nMU8LpBWCwbw8XlUffyyxkJw9a7h2uKUXriZ4F2xi4/KrEo4J0PA7QYr78kk4Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqZztEIAwE19XfGRBnVsdbSef2q2GUj36ovTPfUopzOV7a6jv
	j07LEFeuvV4hyya7dH8TII+gFFybzj0Io0IJIwVuPcyGHqUr1r6AMpSt6Gg9zA4=
X-Google-Smtp-Source: AGHT+IHbURW1yV1GM9BVVgDb8HTgtd4EPVwidgPIsYm8KnFRO+oKjNCO959EqmNWOulCKA3bRMMHag==
X-Received: by 2002:a05:600c:4689:b0:431:9397:9ac9 with SMTP id 5b1f17b1804b1-432df746a1bmr163880285e9.15.1732039012427;
        Tue, 19 Nov 2024 09:56:52 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fe68sm208302275e9.24.2024.11.19.09.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:56:52 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Nov 2024 18:56:41 +0100
Subject: [PATCH v2 06/11] drm/msm: adreno: dynamically generate GMU bw
 table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-topic-sm8x50-gpu-bw-vote-v2-6-4deb87be2498@linaro.org>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2755;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8YGZ9WKDiwlY9CXdycHEn+g53UomsCDyNV7cpV/GbpI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnPNFZkDlMgucCKOVG3spwNDcQZ0ZydMSrArihhW/Y
 vFgoe8OJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzzRWQAKCRB33NvayMhJ0bjFD/
 9Mm8Si6vY3yrr2jLQmK9hIOxIo7VQGaygEeTkajDIJBFkFAFPQXGV5BNeb7ZEWXTXcNYlDIqs0qRb1
 JOF/h1vPRq3pDdOEnG5JcF45su6IX9V935mkZDOhynF9D4dfaVySkMl8vSYI8PbBxLQSzj/vLcVd8o
 YGiWIm+8ZzZ5yT5UxZLeEeyjrBP5tOcyw6EmgiLf0snPQYsDadgXnpDO3+E71tmdcUHMsVGwJsEqTr
 g0uYhy3CsZK9eGEcyH3BvnjPQg2xP4ln6pEXC49Et1S9kpcpRzlZ6NPvBK5Li+TNX3GCL3eg3/ciUw
 0x4TkUHAtlTQl2K7c/Ucm6rhadLnn8y86WWnlVepGCHZx1K3upgvczZbs/6mtob5xrp8xgfJWH/vbB
 BmTy+I6vhg+a9nle+Scw+KpcTF2L7UMam1Kiu4vKcXiniSHVO3GMwAp4845Mpc4PrwYiIofLS/0mUX
 zdMoAGfH8G7hzfQ/B4YNsXQAZ3cIuvC5XESP35Whkjtd635QbmeB6XFkhUrkofR6A8bY81WRuWltqP
 XuTJ4hq777J3vSZB/xSkBbj6T40vviF+j+CiwcJOLnja5qAYzgbmbi1jNRDstLj68//tK3vEU/gKW6
 menmwvCUhLMg4vKU3j5zhTxgQRw3ZlwdCmTDWchXJnGvzssONP8cVOc1nQ/g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Adreno GPU Management Unit (GMU) can also scale the ddr
bandwidth along the frequency and power domain level, but for
now we statically fill the bw_table with values from the
downstream driver.

Only the first entry is used, which is a disable vote, so we
currently rely on scaling via the linux interconnect paths.

Let's dynamically generate the bw_table with the vote values
previously calculated from the OPPs.

Those entried will then be used by the GMU when passing the
appropriate bandwidth level while voting for a gpu frequency.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 39 ++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index cb8844ed46b29c4569d05eb7a24f7b27e173190f..0c8aa9f8cabe1d9cb20445a4274b728236a99fad 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -621,6 +621,36 @@ static void a740_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 	msg->cnoc_cmds_data[1][0] = 0x60000001;
 }
 
+static void a740_generate_bw_table(struct adreno_gpu *adreno_gpu, struct a6xx_gmu *gmu,
+				   struct a6xx_hfi_msg_bw_table *msg)
+{
+	const struct a6xx_info *info = adreno_gpu->info->a6xx;
+	unsigned int i, j;
+
+	msg->ddr_wait_bitmask = 0x7;
+
+	for (i = 0; i < 3; i++) {
+		if (!info->bcm[i].name)
+			break;
+		msg->ddr_cmds_addrs[i] = cmd_db_read_addr(info->bcm[i].name);
+	}
+	msg->ddr_cmds_num = i;
+
+	for (i = 0; i < gmu->nr_gpu_bws; ++i)
+		for (j = 0; j < msg->ddr_cmds_num; j++)
+			msg->ddr_cmds_data[i][j] = gmu->gpu_bw_votes[i][j];
+	msg->bw_level_num = gmu->nr_gpu_bws;
+
+	/* TODO also generate CNOC commands */
+
+	msg->cnoc_cmds_num = 1;
+	msg->cnoc_wait_bitmask = 0x1;
+
+	msg->cnoc_cmds_addrs[0] = cmd_db_read_addr("CN0");
+	msg->cnoc_cmds_data[0][0] = 0x40000000;
+	msg->cnoc_cmds_data[1][0] = 0x60000001;
+}
+
 static void a6xx_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 {
 	/* Send a single "off" entry since the 630 GMU doesn't do bus scaling */
@@ -690,9 +720,12 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 		a690_build_bw_table(msg);
 	else if (adreno_is_a730(adreno_gpu))
 		a730_build_bw_table(msg);
-	else if (adreno_is_a740_family(adreno_gpu))
-		a740_build_bw_table(msg);
-	else
+	else if (adreno_is_a740_family(adreno_gpu)) {
+		if ((adreno_gpu->info->features & ADRENO_FEAT_GMU_BW_VOTE) && gmu->nr_gpu_bws)
+			a740_generate_bw_table(adreno_gpu, gmu, msg);
+		else
+			a740_build_bw_table(msg);
+	} else
 		a6xx_build_bw_table(msg);
 
 	gmu->bw_table = msg;

-- 
2.34.1


