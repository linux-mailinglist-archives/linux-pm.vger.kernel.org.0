Return-Path: <linux-pm+bounces-41859-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J0JO7ovf2k8lQIAu9opvQ
	(envelope-from <linux-pm+bounces-41859-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:49:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D054C5929
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 775CF3007A72
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 10:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FB432AABB;
	Sun,  1 Feb 2026 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J+fSOL8o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LXonr7KX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE132936D
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942958; cv=none; b=d1h2QvbtFuVJmGN8DjwDo3S11z2CBH3ULnxf0lcg/TYEdw0qLb3SviptTtCY/JMByvJoHXEDYoPwksjFbIYRGYlTCnbuRjK9xKj3gihnfieJb71D5kCxCDxjwS0o+zuvQJnR3lrncOonaEbxCvUFS55FgDPuF3Os6ofRdANIGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942958; c=relaxed/simple;
	bh=32YQR180l4XuatpViT6nfN9ULShKtuaugvJ8/48mdxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQ7iGBOuwtaOCtnFdxSmjzsJpxY4vlPbJ8qvpUyZCr68xU49SGVhu6UM1zDseri/fRdtd+G5wTFigkoNIBvm0qMSFF65FuovFFMeIyfdlW5LN/FV/hKSTkwozEHzLhVRcgoStCsnuDEc4E176rUfZ0/HpwdtF5TSGDw4ZKLE9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J+fSOL8o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LXonr7KX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6117RvYd897462
	for <linux-pm@vger.kernel.org>; Sun, 1 Feb 2026 10:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M1pl67zhaQRIlZ7r7pA0ZyoUVVuJsyuZALZX1rr0pn4=; b=J+fSOL8oecJ7htUY
	rnOB6a3qU6Xuj3iE/3SWCU8jRB2OA2RaeKEc8TqCusqzgO6Y4g1WsoNPxvzZ7R/L
	nkIDQJiIgkeNh+b08w7MB6Dnr82x+gNiS9/WAEmiYmJ8BDdNzmKLyIAkTBQlzaA/
	6vh+yuz/0sW2MCaggJbwgzfoA99kboaLhAmXwtxGsE39MOGQursySv8NHmstUf5O
	HG/DjjJrL+W1EHj/iRe/Bu4x0h49lsGDxATGmUP6GZdaUioNNU25OqlQnIlclQNC
	k9XATVdbJZUX+u+LRaFibeloS6u/sOO+R7tqtzMyyY2jFiv16Sq6GuH5akEON13z
	gpCfnQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1awdaf9b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 10:49:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c52d3be24cso581235985a.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 02:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769942955; x=1770547755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1pl67zhaQRIlZ7r7pA0ZyoUVVuJsyuZALZX1rr0pn4=;
        b=LXonr7KXMKu6OjLrpKR9QKi1L5El0DwbLeoVB9wkez+a1rAahvb9Zc9vem85VhoTi6
         sSRFGwPhku/Hry1htGNrTKQa31j8M1mthvB2MT3r8BxQBpWl4JwJq3xszHCgydcG2Gka
         TVgFQRJ2k7icKAiMa5gr2aufnaMYb6dBL0sQkgnXLVk6wwOoBmbOJVs9nNZj6Of+DKho
         gAAUc68Gk6I7B/HLFZzVMiBdG/vmtBgPrB8azncs/PSoLTW48VX7PXMvf124pbsSY1nZ
         rQzAT47pe/0We2H9mhSooOjmX2kN/6NcFdcQR2dk8JqndoMDunzuC/w0TTHqan80tmRY
         wvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942955; x=1770547755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M1pl67zhaQRIlZ7r7pA0ZyoUVVuJsyuZALZX1rr0pn4=;
        b=ENfW6CWKQRfxSLDUvycp54h1xglaiUhbYUmyzVC6CDNRrf+r9/4AgrDG4gK7fxVHuR
         x0c8GLGIIiZrAyTAbRhTfYeddCq543i5dmgbed8YqYOO1L92a41hu79fxNX2i+zq+BtD
         fhnmHMHiQTjz3z5b/IEc7f0FSXMNuvgMplNBXQI9BuY+O4AlK9AieVzMppbNopPCckhY
         ks7LP8apnRPbKPSeS0Ax0gM/ZY/4rEV05DZvvJbRfkeuone8675fr8jwVfIqz7H2SCwE
         XjDarpVOIVu50Kqd05pudEeang1LlVPvMO65FvIs7s5o3DAEC0tkrM3ATQ8eecQfMZPu
         OyPg==
X-Forwarded-Encrypted: i=1; AJvYcCVffgcvEEJACGhtoJ1HNTH2KaQIXIBVyvh6WkMqXdLMAl5moQUrXCU4hkJABZ7v91G47NxpJ1QNZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6y7PFDb5oq/Z8WCnFZZXP3KbPwkHtYip4n+I1BLqXCo7wVSqU
	nmFvrItEVNyTS74u1jBP27zgC7YJsUt2OaqxUHNLjV4VCPbKPlDjfjujZ+GwS8Fnl9ptJfSpZPP
	D+ijpR2fu3RjGkFCfkq7FDbc99WHuPmHjGn/ZdYPSc4HwNZ2VKMP3dEIy+U5g6Q==
X-Gm-Gg: AZuq6aIzPGKQlIgEKmlkyYwXJaglXNr5NkTh3PM5uQHJaCJd73G/Fb2kYX1zOmYusil
	0J7cyQcxoVghBW4lhBOXuE2pkegZ/WIDT42fbwRoC8P1EvcPMxOCa/XJNUjnnl7OV+PDlu8LPr4
	lOIkkYn/AI0b6aOA9/QedAr4lNciQVjfm9CQr7fsDmiUXjzwNGqQUKd6/l++UGhMKxmqQNcxUrY
	TCX8GfOU67108E35JCF9HwmHVWn6AhUxzjhJDvkbsl9obitAKqSE1UUdqpAX6mhuZdBEJrOm3Rm
	NKvqFuDOolSnetwrcSVoZSEcUdun/+yqLS14lN9fzbpKhG9woY0PUPDD9ohS4xHgUS7KnrUo5VQ
	I9ibrDUnc7q8JjhnkkqFr8A1xNV7q3yJ8P2groB9xO1/lU/mNYOqVv8i2yZ2cbW77scvKiCJDqM
	IsGhFp2W/nDiULXNU4KeYMJSs=
X-Received: by 2002:a05:620a:2906:b0:8c6:a85a:5204 with SMTP id af79cd13be357-8c9eb364f83mr1127874285a.88.1769942955054;
        Sun, 01 Feb 2026 02:49:15 -0800 (PST)
X-Received: by 2002:a05:620a:2906:b0:8c6:a85a:5204 with SMTP id af79cd13be357-8c9eb364f83mr1127872885a.88.1769942954578;
        Sun, 01 Feb 2026 02:49:14 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b7a8csm2835006e87.77.2026.02.01.02.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:49:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 01 Feb 2026 12:48:59 +0200
Subject: [PATCH v2 2/8] pmdomain: de-constify fields struct
 dev_pm_domain_attach_data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-iris-venus-fix-sm8250-v2-2-6f40d2605c89@oss.qualcomm.com>
References: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
In-Reply-To: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=880;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=32YQR180l4XuatpViT6nfN9ULShKtuaugvJ8/48mdxQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpfy+kyu/4kaubF+LUVuH4Re7eRBOaxduY4IJPt
 cXB0D862a2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaX8vpAAKCRCLPIo+Aiko
 1aRuB/9WBlRYvHMHWuVOGRyjcbOrZio4cJ42F43gS/VLCY0xeqGW/Mca12KWFPezXuLAppc+RUn
 Ku4AIG1IbCuKx3vVrZz24t619lL3DXZLWKNWR4O+bgiYys3B3BZiwpQ6UdAHcz4EVEQAO4l6Xxz
 qIM5qoSfNUCS9mex4aqDiUgyOW4KpIAMyTAsVyeaE7/2xDrvmJW+cPCkDKFMdp5RputgCBc+qBh
 7VWcqxKMpJ0cc8eiGwHznJ/eFVz9f9YGZ1OLRwNN2SHdJ3Ah1dMWCWo/ij/o0f1qimYu7/XwE+/
 DuAPT+2YNHGocojIFbyT6n67q06WMtGWPpqD/NHN8Z9B83Ph
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: AeXMsSLdZAU6WmfOglqX1eczSL52AJcU
X-Proofpoint-ORIG-GUID: AeXMsSLdZAU6WmfOglqX1eczSL52AJcU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDA5NCBTYWx0ZWRfX+RA6HMd/KQmp
 GyHDykf5YXXHC8RAnDrKdZ82GYmACSgfux1HcL0ztQm099SuFPKa6JLQk+jkZ0Di8rr3/nZ8Zko
 NMGgg++HKtWPiCJLtUipOe16mS52/EqFpKCVH1Eb3cPw2bWgIQQs13WQFFPl5yrvkNYYQ1Lnx07
 0VCdGGcG5wSRE/zIry9b+u1aKgFDYKmqqcFfHE5Z2KK/h779v9T3Dwp9QZa2DIrtFS6lMoSArre
 //WmvV1FH6VUHoVvJIyL4jiFK1fYcrDB1GLMN+xVOq8mGqW7FzTlEXKHgs6B2dsYbUY6RmICZn3
 PpyHXkChpsuL2YgVIg8VB1UA22nPVmP43Jz/CP1vBCgUCNeAOGEMBSuNw9pf8VGRhubr8VUVj7E
 Jvr3NDQL6BbWXEIIWrrjwDuyjrEzBCkRG+I44Jg3SuNNCSyQtw9Szq9xHC9d0WIBQdTv5piVhFN
 /ta8Wluz4pqNvOM6evg==
X-Authority-Analysis: v=2.4 cv=T8OBjvKQ c=1 sm=1 tr=0 ts=697f2fac cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0MtQHd9Mo8yxAPGUVWwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602010094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41859-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1D054C5929
X-Rspamd-Action: no action

It doesn't really make sense to keep u32 fields to be marked as const.
Having the const fields prevents their modification in the driver.
Instead the whole struct can be defined as const (if it is constant).

Fixes: 161e16a5e50a ("PM: domains: Add helper functions to attach/detach multiple PM domains")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/linux/pm_domain.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f6f6d494f728..b299dc0128d6 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -49,8 +49,8 @@
 
 struct dev_pm_domain_attach_data {
 	const char * const *pd_names;
-	const u32 num_pd_names;
-	const u32 pd_flags;
+	u32 num_pd_names;
+	u32 pd_flags;
 };
 
 struct dev_pm_domain_list {

-- 
2.47.3


