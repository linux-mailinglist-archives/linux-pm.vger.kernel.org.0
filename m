Return-Path: <linux-pm+bounces-42023-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KwUADSagmkzWwMAu9opvQ
	(envelope-from <linux-pm+bounces-42023-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 02:00:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBDCE02BE
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 02:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 027F83057EA0
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 01:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC5F24676D;
	Wed,  4 Feb 2026 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OY3gMuzm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CQug+om+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC323EA86
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770166805; cv=none; b=hEYxTG6wLo2eC69h+e6c1xcj39PJ8+tTKW+W9o++kMH077T1K2+dFKrylTHbNMREjx8A2jY+btsO7ie4lILCKN1SktCvRb1XjqT6gzqPNlabdcjTD7h008pYJzr7UpcWBOVXgm3hBAfITRut8lVRInn3kIlK5j4jCjXaWTxbgek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770166805; c=relaxed/simple;
	bh=VfRuUvDLNQGtvgiSr1eaiBtwpSSv6JIHemxucUr//rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t62TNAyceCiRQxzw1DHyVg4qBfpxz279lrzSmyThvHOT4rb8GcWikqf9KEPrCNE/VHhgFBjNqUadkidx70fYEb/3Vv0ba2okD/7WrQ1qzzqsOOzBexXvvnZOhjTDK4FmuKr1gJRJ3T/ezEZElB4WtwT8P/n881mfKcIBh1ePDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OY3gMuzm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CQug+om+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613ImPuc3824323
	for <linux-pm@vger.kernel.org>; Wed, 4 Feb 2026 01:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F0AY75pLMlp6UqxNfuSclKDOeELGzfL4se7wy8hQYlM=; b=OY3gMuzml7IP7Qkq
	7Qk35TR0FHXAcYO36NxNmTrj5PHeUa8DB8m8Q93kXbn7oyafYiWmhhWKuRr+uR8z
	mO+UzSblYNS/fGhxWzsFX48oipYfbOvs0946FK+aiczLZ43doRUp9TFd6HadVTEd
	VWtXjDu1PwnRINwtRzJ4htsofspTw2Zrn/MttPoOKfYnRjv6Qir7/nMa8082D6AD
	0zlfhwB+DWoD9KHfMuVmVyjq7N+RoLNizJE/ZUfoYokPmowky1dDZMYXz/Jx24Ok
	r47MJUMP+bnKge6g18MXHnCQ73hfMfVXJt0ON2a+QVV2wv5xEhORNck/23b7ssHf
	pkEZWQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3g33jgk7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 01:00:02 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89471079a13so368934026d6.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 17:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770166801; x=1770771601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0AY75pLMlp6UqxNfuSclKDOeELGzfL4se7wy8hQYlM=;
        b=CQug+om+6ESlEAFBfG5iWjX75Hc7w2MLeENwElaVbwJjg7xRxFsvqP3OnHJcFqfOmB
         L9QV88OZi1pAw+S+gsieovqZLvSk8D4GRn0cZR0dQ5nokmbvqkjgoqRWCgwUQHVLFxvx
         usP/4KRyLSknIiwhoDZyhvFdbJdxqeGf8J2JLWsE64yu5I3vsSQ8euqs6kEFrQnVMqdy
         yUE9wi2AdXaxBtA2TrYlQ6OWA8BFj8YJuZlfHBWB+o4Pq2lm6k3DYGAKaBmBhW2XX80c
         YUxNYU2vf5fpBaIaWj8YAucp4xKsv9QeQZdOhUPpFma9uPJubHs4AJlBDVqYisAD4j5Z
         U/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770166801; x=1770771601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F0AY75pLMlp6UqxNfuSclKDOeELGzfL4se7wy8hQYlM=;
        b=oOT36/yKKp7ZvZbmQaluMQlBLkGzYLyYSkysWgirgbr20eGY4b9Tk8eCCNCZW/ulLt
         jys1PUtdcOGb93aW69/TiVhqPu/4TybFDt2hJvdyW6hojUXyY/LXjsd9x738O5XzOeew
         AU0p0jT14YPbxVhsPSwgHTsqgIjLsUaK4BnYq96UyrkP3sD7yagG27C37RkZ9gc9G0YQ
         6go4kR4oXufd6sZojOCLuBZLQCgYCKa01xlgnoWCI6cNfA4Elvlt742VvR3W//W8jB3p
         i/YVBqvFdl6k8OEo4pr9JpD2M4Vw2jSScQHJ06IbYw73poMsGnBx3pBHH9VTAqFNbNqK
         5nLA==
X-Forwarded-Encrypted: i=1; AJvYcCVNEtqDhbp0UNP6lZf7cMAFeH+o9oSot5hsJVrh4jUUbOTKahL0Nt+VACI1kwg38Z4IjLrKi1DmjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ujtZju/f6zWY/d4OOJOqIImvMZ0ZsohMH093AulvMv1KILeP
	SCAaQXiFqoy2K9Y91Qtx06pH6ofHlCd5lUXpv0B8nwXqbBxhw/kU5yRa4aQ8CrFn1GQjmfnYREO
	F9523D2vaA4o7x2S2XNXKu5GB31yVKnC/lQ1VLVEdvYPsg4bx2Jn9VnUVob+MBw==
X-Gm-Gg: AZuq6aKUMxNrUx22Q+DDO4yBCMPjrxTPIMH0YvKekb4brlnPaBwB7/eta/r574ty6dQ
	dDgMGNoMrvOoJvuCmGXPIp9IkqnbM9XOYTLqdaS209NZ4hHHzwQGAs3Nyln/wsEXm/kkETIjKW2
	yLfFhZccRsGBHDkwVcpSaM0tHqyl310hpRe8g9zsWMLPJybGIuvmWT4O3x4K9yeE30A/cHJF00m
	HR0G0a9VF1mrVPjtkJpUwQH6iBZ5Q2HfARdpa61GlAbqDY4wCl/0rChJZnGAqsr30vRjDohFFnJ
	rn4HeNWP36YIMxvyW0b7JrtWvUdoVpBSRl3JnMoHiV19tHAQ27FWRyNozgxCMHJCN3rQImu2nY3
	2SKKYsFpOywdeiXteWbrwxUb/i++/RebSYZSLsl2AUvWOV8OfKpQ1R+6EcUjbgY4fireyVwPepW
	43EcknqqJIwoiy1hGgZYV5u+8=
X-Received: by 2002:a05:620a:4148:b0:8ca:1107:1214 with SMTP id af79cd13be357-8ca2f80c8b6mr201840785a.7.1770166801340;
        Tue, 03 Feb 2026 17:00:01 -0800 (PST)
X-Received: by 2002:a05:620a:4148:b0:8ca:1107:1214 with SMTP id af79cd13be357-8ca2f80c8b6mr201838685a.7.1770166800833;
        Tue, 03 Feb 2026 17:00:00 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e386ff563sm253405e87.1.2026.02.03.16.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 17:00:00 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 04 Feb 2026 02:59:51 +0200
Subject: [PATCH v3 3/7] media: iris: scale MMCX power domain on SM8250
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-iris-venus-fix-sm8250-v3-3-70fa68e57f96@oss.qualcomm.com>
References: <20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com>
In-Reply-To: <20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=VfRuUvDLNQGtvgiSr1eaiBtwpSSv6JIHemxucUr//rw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpgpoH69jYaMl9aHZSebvqf/7+KmmazX16JJBMf
 XbNTMQ30MmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaYKaBwAKCRCLPIo+Aiko
 1fQyB/9WdlqfncSawuaEvQr/Y7vMSJ30ptCp+Q6MnsWnr3cxm3NiMiQkGgL4VGujh6za1/xN22x
 kwdizN2RrU+oihEl2FipMI877Fdq52jPDC//ieT7UCIF+PA67GtQPnDGz3mruvvDS0nj924uzEK
 /0xMiLULGUL2uroIdK4T8V68/zT/RYU9xKUNNQWJK0zcSWmZWSsfk0uYz0EztJQEp7FlScHEXGo
 19xZQdUA+Rhb6oD0bmv7kFAXs9XN9pVLfue9YtssMiMAMzXQVc7TfBeJ3DkkI0Tj34j+nPbM1wu
 U/Y6ohg3d3XQ3c7LCUBMzj1ydPICVugRCWj7NXhvR7cPOYfT
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=afVsXBot c=1 sm=1 tr=0 ts=69829a12 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=_hdJGhFWpaytJYYtlLsA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: F0l8o2Dgfc5UfuV6WLCOJXrAhoFu7Jv9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAwNCBTYWx0ZWRfXyfs2Rgt65lEX
 NVZT8MLt9EKTt4z3RhPB3ADbPBljAIz34WKQPMBDx2UiXLR+K5Vtu+YnsFBej19f30vhw0elXUp
 JSh2VVPlG0P/i7/BN/P8eZ6yt2QmCWHA6uIRSIKpZToX+cYC7Obg2us31ydCJKrA63NkJuOHR9i
 09oBPSBV6Qrp/vpAUvpA+wocBXfvaAPypS//7eBh1awfe7jUmSXEEHhp8qdqb+UCJn4VTV5pVkI
 7erCb/sSqMILiYaqFxEO3N9I26yistop2Ip5ZLXNKfezCxyDXGRw6KvDHyL9VV5gWB4nIi2yDtY
 FBEAm6KndjZx3nbxh3qVifBWmBsjwWcKjn0/MkEhige1M4pj64Fs4VHfc5ffHFguu/b/5X9aq4w
 5TgKB5weFktGBr1Eh/1TINKORCEIlDtxfUjYPPTvNMhelpgl/sh7BQlbQWvevYr0zCdRH150A3h
 +t+o1Hnox6lAvO0Kj5g==
X-Proofpoint-GUID: F0l8o2Dgfc5UfuV6WLCOJXrAhoFu7Jv9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040004
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42023-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9DBDCE02BE
X-Rspamd-Action: no action

On SM8250 most of the video clocks are powered by the MMCX domain, while
the PLL is powered on by the MX domain. Extend the driver to support
scaling both power domains, while keeping compatibility with the
existing DTs, which define only the MX domain.

Fixes: 79865252acb6 ("media: iris: enable video driver probe of SM8250 SoC")
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_platform_gen1.c | 2 +-
 drivers/media/platform/qcom/iris/iris_probe.c         | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen1.c b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
index df8e6bf9430e..aa71f7f53ee3 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen1.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen1.c
@@ -281,7 +281,7 @@ static const struct bw_info sm8250_bw_table_dec[] = {
 
 static const char * const sm8250_pmdomain_table[] = { "venus", "vcodec0" };
 
-static const char * const sm8250_opp_pd_table[] = { "mx" };
+static const char * const sm8250_opp_pd_table[] = { "mx", "mmcx" };
 
 static const struct platform_clk_data sm8250_clk_table[] = {
 	{IRIS_AXI_CLK,  "iface"        },
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 7b612ad37e4f..74ec81e3d622 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -64,6 +64,13 @@ static int iris_init_power_domains(struct iris_core *core)
 		return ret;
 
 	ret =  devm_pm_domain_attach_list(core->dev, &iris_opp_pd_data, &core->opp_pmdomain_tbl);
+	/* backwards compatibility for incomplete ABI SM8250 */
+	if (ret == -ENODEV &&
+	    of_device_is_compatible(core->dev->of_node, "qcom,sm8250-venus")) {
+		iris_opp_pd_data.num_pd_names--;
+		ret = devm_pm_domain_attach_list(core->dev, &iris_opp_pd_data,
+						 &core->opp_pmdomain_tbl);
+	}
 	if (ret < 0)
 		return ret;
 

-- 
2.47.3


