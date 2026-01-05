Return-Path: <linux-pm+bounces-40204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B973CF3E18
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 14:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 848F4302D89E
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D41633A9E2;
	Mon,  5 Jan 2026 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i0LFytSm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IHgkosfO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD10339879
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620074; cv=none; b=deTPIg2V7FCFGUKKzDhaxQMT/PG66qgwPKJ3xlVotiaENVLtGUklSHLsBX2ejOhNdCMFBi4SXbe19oMQzrcUeDzmulRtt68Jf4e75ivVI6ENhLHFakTFTc44Lt9ui6bbKd4GWbd/SZ7ac0IKJnAkik+hXQAdoq03NEz1SY/upzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620074; c=relaxed/simple;
	bh=9xYA0AmVAhViPtU3dAaeClRgRl0bvu0O3AlHrFxfqFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DLk0gH1sD1sq00MOhparBRssf2JoqcfDYnbkte0XcnXWsGzMOo+WQpmpDvBfx5OOHjuaOplr2tgfaMQzFSRxMloN4XIJs/kMC/Oel0LTAB10uv6A9k1DqewtmBOJKXezCzpRBlcBGhvEde2wSA1wXhyMP8BuTiynexn9KsYmb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i0LFytSm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IHgkosfO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6058NlmQ1058794
	for <linux-pm@vger.kernel.org>; Mon, 5 Jan 2026 13:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u8OmmJNn+r/Hwt1QPUnzFTymxge+nDosrd+T12lTVRk=; b=i0LFytSmb8lkHp83
	dtwiy4k/HqZDJd/ezwdRDTgPfqIdxQoFFjiuYEMMWn6yHfuPpugBHmB7AgnOFrfy
	0mnTR+NQVJJRoIWNAa8eU+8jhFn6Tc5EHqfJA2qQueEyZ4IDHUl7rfaxVaFzcnLn
	7vsT3eF0QuDrcYPYCp7GOQYGTVkdQ/paqYtDxM+pdAZTbeEuoq+iWp3r2bMZZpeI
	0w7A30mPMK1AHLtlh847Ti4gbk6oqBvxlvUwlZhLHsC/XbskcjBcU6d4CTfcwX/u
	KhT+uZomlRkhhdgZ6c3hiyK2xenBKW5ll1Nc9YhVqKnrfBCd13tEL3viR2j+++3F
	jFq7hg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bev9hcj32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 13:34:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee0c1d1b36so48890791cf.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 05:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767620063; x=1768224863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8OmmJNn+r/Hwt1QPUnzFTymxge+nDosrd+T12lTVRk=;
        b=IHgkosfO/k1GzJa6jDbZlABokPf/9j24kQLGahf1gSt7yXsNBPjXU4pAhpoHI18U+e
         uet7N+NpIC58YCrlc27Rt/nIWuIW/RuFDLOwl1byqKo8IzgXDw392+JO9pXFUSH4Bip3
         o+k1EWjwnRuDfZYmWTXYPII+cYdTv00qQYyZ5kVv3B3hQzQOrBfm8YbKf54QBjPBSUYf
         Y6fpK1NIo10zvQzxgz/8GpmFShXlHU/GldyypphV5J4peW5GVWTc9fKViTfw9AJ9TWxz
         XrUKQCdE2+5t2CUMyMRG2vDTxeLB0/dhsY2Er2Ult5eEVfuf+en+0Vf74v4SUIgbiKRQ
         13ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767620063; x=1768224863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u8OmmJNn+r/Hwt1QPUnzFTymxge+nDosrd+T12lTVRk=;
        b=JHQ7W1QaYdXFED/8814zNo7lOEoRYk/sEy/YlY+6cPHi2dHq++20VJH3Upgrh0SA07
         ZQkDA3Esmeav1yu8KNobGel2YlrZsPT1utJhA9c8riBvrriqPBqNHsnUchc4aABcA59c
         Bi0m/zYyCyC2slj/HNssHGb45ZJrMi6mbvJPDeYzSpJJPRIvjwtL6cESGDm7UUzp7Eq6
         SrByXGfYFjBqlVS1nt5Lpu+g4EmV9A2H0ULHNMvbITDhkxVeXVOUCdBmydD031nARME6
         xFaVavpGFmxd8hq3bjpmY+kNvKIhImoGBuZ1jC7NerTqnbvn6P4Hr3g52wGHuw4VH6du
         vkgg==
X-Forwarded-Encrypted: i=1; AJvYcCWQU/3QEwyvlPdyzWX+OQjaWOw+9fGumCMVhoSp+6SKvyEdeahso3r+s4dPefgW6sFciwZnaYQ33Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+d2UVQ0KwjyOPb/s/pVUoOwN29TnLvL2Gf6xUrw48sFfrX9Gg
	myGLs2bMLUwTOuFBz/bK45EAFwpf39agI4YtC7E1Fg/9jPROPp+DdQe9lgIyugtnVtrr1IL0tRf
	LQOK/dY+lmJ6aOarYkj509mnG30jkoRWoCWvFYoAEYSgXS9YeGQMUVOIC+gCLkw==
X-Gm-Gg: AY/fxX5Iu2kteuSkWNnzgZJqWNXMZIfrAb9OotfRUBkwESkZeMpeiQqqomCdx2fOMsI
	atSG3sy4V0S6nGv/rpOqJkcq56LHbRWI6h9kklfr0zvhB7T+yloww9uXRSh6AVBZhyg2r/oq7li
	C9+8MWSa7lp5j5yQQy2qPryVEpyIsTMNNdZ6rKCFq6jMvw7f9jrTvk8sqDfZnF2LP3o5M9wm8zw
	J3ezJSXCkgUAiWWIlDENHIYwPwEYP3r/Za7CPuFpeU11j8WT3mjLELiUmrgKXU6Hho1KNnJtHGJ
	LMFwwLdWnARVyNTt3oIdl8hwdBPE97FjbIL/l0oMXCx3O1iDrSNfikY7NQsOQsW/d9ZbwlqpnkB
	HQNrlhXPM+0JmdVLYdoz8h0VWmoB/9pOCqw==
X-Received: by 2002:a05:622a:244:b0:4ed:7fe3:7be7 with SMTP id d75a77b69052e-4ff46bfa6a5mr90855251cf.24.1767620063362;
        Mon, 05 Jan 2026 05:34:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH22+wbC/8ocAPNid4zwKCPLpHyZ3rp4TFMtIubPKSch4hbyut4GTVmx04qGX7V0XRikuXA6w==
X-Received: by 2002:a05:622a:244:b0:4ed:7fe3:7be7 with SMTP id d75a77b69052e-4ff46bfa6a5mr90854841cf.24.1767620062896;
        Mon, 05 Jan 2026 05:34:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d143f75sm147211015e9.5.2026.01.05.05.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 05:34:22 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 05 Jan 2026 14:33:49 +0100
Subject: [PATCH 11/11] cpufreq: s5pv210: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-of-for-each-compatible-scoped-v1-11-24e99c177164@oss.qualcomm.com>
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
In-Reply-To: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
To: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-clk@vger.kernel.org, imx@lists.linux.dev,
        dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=9xYA0AmVAhViPtU3dAaeClRgRl0bvu0O3AlHrFxfqFE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpW72/y4CuyYTjdCordJY87DDcZCQImkSMPz5au
 +HhLxRd3cWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVu9vwAKCRDBN2bmhouD
 13e0D/wKDkZR+oKRpnlwWONfu2Y2/SNHWR8KA7TqekRFYafhYbZkvcHqlge7N3lURLyM9PvTjwk
 zqjR+rondooIsMzxGjfU+iaQiN+jQpeqV/bWMs2T3BEY5zOlToLQpNrr1gOyMpu4MZvIEVU11/R
 ezB/P2yn3Ejt62QO08r4mKcEQSzjz/ncjSX+7y7kkqpx+02YnR4dlQmCZDlS1qPShxQYg2lqu0s
 hCxjDvW2sunRizv8gjInpk6FT9u/Mlg3FvmWKBfQmKDcYB09lYkvXRkUZzAGEuv0dhAZEuLZ9/H
 B22GVb/cxXtk6U6GPjEw7x+IrpIPbpq3Oo6Fe/xr+gAgDdbfYKkC0ltJ8W9NaJf/SOEzzNy5Wic
 YFVfKTzRWchTMRonhmvPXLoxwvQZ5kuEW1zj5aiIVRpgsADyNKpkFxV7nuFKs4mZlYxTuPtTWPy
 brKRg+KVLL3PyLr5ooNsLN7MZhpwVlV/QNogFw+fY3dphKjRo4qMbZqjW90dB7Rgu5BAF23NWq2
 o5Vg+Gsx8Yee//iPiZovGUYQZAF4+k3D2Yku7y8PmhNwvzovMT3WQ5L5MdQJjSsrAxZasbnJ+pi
 SWqICNkVItqpBHbl+hZ4mVYVIPNvroxc/QTm2/E79KJhE3397HEt5Y6oQeKvZFOFdesUKeV7mmf
 YPx3kGjETmm70cA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDExOCBTYWx0ZWRfXwi0k+EAGugKv
 QBa+zuqUy5f35ONqFo7U/KlsF/dwS4zH4r2RWIZ5PpLoRyaB7/T4UKOrZcJIer6l58cO7uefhD6
 C2wIRuEGGPEgaghk5ze2uV1skHC9Nv7b7IV/Bk5KQhaXvjLSqdz4coiWQFzleZbhKoPyEr/6SqI
 4UjFQi23tRcHMuaBYfha+wn8rgEHqqbfV3wxJFgYi7YpjTOlBXsmbOjQZHrVgo5RfFDZGqNtGuB
 tvOzBl5nSzsIkPpX2aOYRbBtyPyzpTr11TDUQSAPSn6N2kvAYO73XilsSYQ/dvZFkeNJg2ovPK+
 e05c7iBVpG4He2tMRNQgkgVWnQlSF8C5Qx74CgKTZbixMMHtb54ekYp72/xX2U1WTnFgoVrxiEk
 AJ9RReQgQBvFoDJ4YGgXnfrG74cCbn4HGlKDzsk1H3u1QwnTVkNNNTyhx71jgp2Zik1yfBIESng
 TN60axWgOzGgUxLgWbQ==
X-Proofpoint-GUID: MihhNSu-5wvi_o84KLiX02tnGAEutlOL
X-Authority-Analysis: v=2.4 cv=RrbI7SmK c=1 sm=1 tr=0 ts=695bbde0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8YWg2ve-cigzn2S1SOoA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: MihhNSu-5wvi_o84KLiX02tnGAEutlOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050118

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.  Note that there is another part of code using "np"
variable, so scoped loop should not shadow it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Depends on the first patch.
---
 drivers/cpufreq/s5pv210-cpufreq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index ba8a1c96427a..e64e84e1ee79 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -629,19 +629,17 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 		goto err_clock;
 	}
 
-	for_each_compatible_node(np, NULL, "samsung,s5pv210-dmc") {
-		id = of_alias_get_id(np, "dmc");
+	for_each_compatible_node_scoped(dmc, NULL, "samsung,s5pv210-dmc") {
+		id = of_alias_get_id(dmc, "dmc");
 		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
-			dev_err(dev, "failed to get alias of dmc node '%pOFn'\n", np);
-			of_node_put(np);
+			dev_err(dev, "failed to get alias of dmc node '%pOFn'\n", dmc);
 			result = id;
 			goto err_clk_base;
 		}
 
-		dmc_base[id] = of_iomap(np, 0);
+		dmc_base[id] = of_iomap(dmc, 0);
 		if (!dmc_base[id]) {
 			dev_err(dev, "failed to map dmc%d registers\n", id);
-			of_node_put(np);
 			result = -EFAULT;
 			goto err_dmc;
 		}

-- 
2.51.0


