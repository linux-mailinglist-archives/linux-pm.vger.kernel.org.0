Return-Path: <linux-pm+bounces-41837-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEcZBiY9fmkvWgIAu9opvQ
	(envelope-from <linux-pm+bounces-41837-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:34:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1ABC340B
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 18:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55A23303500B
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 17:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC2A35B65F;
	Sat, 31 Jan 2026 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N2XtvVoV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cFGeuDdp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D935A939
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880839; cv=none; b=CzCpM+CaMF/P64MmdkwX9BjTCTpSKktGw+WoZ4JdMoOdvi1wuRNIL/CiN5AjbOiT2guizLAbrRzOnvIi4S3GrWwg2U/IRkyxcD+ePbXKIPUoCdxf0uVi5rwEVc0jQMhsWDwaB3pZRMnteUACZp2P/Uw8lRQO7cUI/FO3sd3xKvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880839; c=relaxed/simple;
	bh=32YQR180l4XuatpViT6nfN9ULShKtuaugvJ8/48mdxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jz6rfi1bNq+QWOVz2eGHtnDz1sWKwDl4aB+MMVL1spjk/BsvtCzxFUm5SBNE+wZvDSLPWS6C3nyIOe/AczWrhaGg8FafC6Xftm4vU93gPCrQd4i4qeipJ6gml11ItkpT79RWEsnhSIhPs6WsD+2Iiy2KsVWSb8RIer76uz0gE4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N2XtvVoV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cFGeuDdp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60VFoW3m1731290
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M1pl67zhaQRIlZ7r7pA0ZyoUVVuJsyuZALZX1rr0pn4=; b=N2XtvVoVvKtMGc7i
	P+w7xdZ33E3C/9tG02ncwqqO54NVvgQpQmcKtFt0hUXOcDShut4s7P9ZMNPhlaLK
	A4Z/QUg8u3lZHzvx8XVtW9kSWCmlPO55KLARzGvNwP59xNccnvJmnjC07kmKMLRN
	TE2sWwL+t1GtqWpYfOwCKytBcFtqChpOyvW62uTsr/bOzyZS0zhEZN6pUgMVadeu
	gOIOpw24yULbwloHhzGvklAtmh9yOL53fsc/ChsSegHhfd7If4o0PrvNSO1I/UaX
	Bcp9lK2v+/lxLuwVjK+utr6dN/4l9M+c/2r1ZwDLaorteBnJ4jvgI9NdQakeE0Kr
	NMYl+w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1awns684-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 17:33:56 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-948ad915887so1123482241.0
        for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 09:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769880835; x=1770485635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1pl67zhaQRIlZ7r7pA0ZyoUVVuJsyuZALZX1rr0pn4=;
        b=cFGeuDdppsrreMYF9r8GKZfiZjZmpwNrUxQ8Tme8X+TjCD1NJq6Zx/pyUZx6zYbwoi
         WRytFZE61saLHLs/HSpzrUgnV5fqThGUuy46dIhY1/Qn/LoZ1qOoxuw3oHDN6ddJ892K
         b6YDlCPjrKQEvz6B+yXWRjtMMXpoHEg0k7+l+1CFv4qGYoYn+8fV7HIzmxjuZFRtKwl6
         gv5lzTjhQDGAQtYWM0zmDA/3DrfLURSK52V3IIqO3D8giSr3gafjl+2WBOU2zvdSNz+H
         Ke3QNmhIOw2NxCF+jVNoAZu+b/Az2X5Dlv5f2TAM5l+YHD5lPnb4+INwzM6X095IkafX
         0f/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769880835; x=1770485635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M1pl67zhaQRIlZ7r7pA0ZyoUVVuJsyuZALZX1rr0pn4=;
        b=bTcc6RtVKYlIhBV3Jx9q6c2V+BvbD2h+TaTIWC87QPCsAA2beNOYl97GnubY8qo6ZX
         +43+aMcz+gWPnxIwVZ7H2JRIGEZtmteKLqIaPD9bGCISy7jjY/S/zl2sLbIcbY+SvhaY
         j2mjjL0DR/ueaVOe1RLD+FBBlO+rB5LiRWsHjfMoJnuy/TSEvIZYoZMyERDgpsAYObIl
         bYYnMjoP1748gzrtj1qbk6kSlVW3ZgXHB0blGmdk1PLoPxL6t1aJeaJSFVMQW/toJWGd
         6LRcAk9e9Vtrjx2xwjQCZq75FbzdSKsfiOozaqywGT0JsKJqLqYo0V+6KgnvfR2Puz/l
         2LgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMEKGeu8gfaDmfoOk5T2DB+BSiZ/wTcm5TyKptZxLY8SHtEIzEAMoXI+Q8D2JxP0/ipnIwvtdHKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXuabf8PVR+2W2QO+asOErIWy+3XJQzqDmdcO5SwlhMlA2fyo8
	7q4j/GkTz0MFlaFEWOMb31YzdEbH0++Qxuvp/H1SL6zqNUoACiCQb1lntgFI0d0qf1CSXgHT7IR
	IQ2njObUIYSZ3n5DXua2RsMepLfc+qSVQ9FxG/cXTKHcMtQN26LzEKUZWdQFURA==
X-Gm-Gg: AZuq6aIITvug7TsAKb+OU+Hsoifdi+DRX0IuO63Pe9rJrrR0Y3moK715zUxK8Ph7ZPF
	Sjp/CH/5FouL2yfuXTNDhxwmv9Y5vbspxxeWAbo6va6eYM8aJptiJYtdUGYVYFHY/LkeDvHTtEk
	He4ycP++Uq+B3q34nOtwL4uEVREPorUd9PKA7XKY1i5y7FT/R7KhMOAg2qF2V00l6DX0lx/9ysF
	9eyGBlhszkRZY5ioUSEztz8ha5HGydzksbydqGikTzaiOMIn1Ee5CNRqfAXQL7Or9i11b7CyRsg
	ZrTK6+MynA/PAPnFC1Oq16StBG4+J1rv9zdRzy1h/puC99we96StTAINfdIlQaeVAsKtJAL5PIV
	eynwUzvUb8N/C8Uzsddi6jcNU+6FAK03bNmxHyIPzvmE/SRzH/ax7e997jvsaE9muCtFDlfsItN
	ZZF73e0EfYOAQjbzeshm2I/4w=
X-Received: by 2002:a05:6102:2ac8:b0:5f5:259b:66e1 with SMTP id ada2fe7eead31-5f8cdaa2fc8mr3722626137.3.1769880835615;
        Sat, 31 Jan 2026 09:33:55 -0800 (PST)
X-Received: by 2002:a05:6102:2ac8:b0:5f5:259b:66e1 with SMTP id ada2fe7eead31-5f8cdaa2fc8mr3722605137.3.1769880835147;
        Sat, 31 Jan 2026 09:33:55 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074886f0sm2443236e87.24.2026.01.31.09.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 09:33:54 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 31 Jan 2026 19:33:44 +0200
Subject: [PATCH 2/8] pmdomain: de-constify fields struct
 dev_pm_domain_attach_data
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260131-iris-venus-fix-sm8250-v1-2-b635ee66284c@oss.qualcomm.com>
References: <20260131-iris-venus-fix-sm8250-v1-0-b635ee66284c@oss.qualcomm.com>
In-Reply-To: <20260131-iris-venus-fix-sm8250-v1-0-b635ee66284c@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpfjz+kozKhJSLZXFwUNSKEuTT/hOBSPTm33d2S
 Fku3cGVJ2yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaX48/gAKCRCLPIo+Aiko
 1SpGB/9+OyNZPfI4xAgU5372SEe75MiUrRaQNOjN0AV5lSPjuhkv/F97SIkLrKe8KRSJ77F3TWp
 yUIsOB246en8dBzWgeqSlUgVLg7y76H0oxGP7eqDshW+4kh1jHNvKO1L0YjmQEFmrQ4wf6/cmd3
 RhACkaf71ELUYZ0TmC/Ih8eYIIPtK5COv5vzeJriXSCeYbv0r5VEWzitnpVAX+KZ+nSoVOE6CUE
 p8WgyOflHMMlVQ/hrB9V7zi/Xg2jHwon/CWcrUcjK+spP8lxHKJJv/7nWpSEPNO9xQX7S/4N126
 SVOpQqQ+4SeQC97WJE0WQNMg2w1RMk99rJ/NoMCo+1i11Xsy
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=MNltWcZl c=1 sm=1 tr=0 ts=697e3d04 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=0MtQHd9Mo8yxAPGUVWwA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: ymCDAVNLWoGeafNS86_k-q2hpJAf8YcQ
X-Proofpoint-ORIG-GUID: ymCDAVNLWoGeafNS86_k-q2hpJAf8YcQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDE0NyBTYWx0ZWRfXxhpYDay2pVzA
 lchnb5e5asgozdLbB7hJ8QmmvJVOrk1L95mlntnvctxV43PIeBLiJky1R3sQV+E1apQxDTt5fBG
 aet/C3F1HS6//2101TqXDptv8LjANPbpRMTeEW0T3YxIXv5KpfbgttBhVaVKbWZDWUse8mu7Ahi
 oSxKHSyvOQ7iZZK7CSGV20qwGzwGmFhZDIwu/LLWn/xdH3B/FjBZHqsUO1kEI9zDXWTLHG86kjc
 hPjCTIleg2Zk9zXoEFNONe9BSCVwMIVTnRJqyJitXDjxzP9FYxt/hWU8pthDlokLDbf9Yw5YesV
 ODiXmQCu4ykBmNH4AM9cKT99vm6mtTMEWJcxNn8Tn5GtQmWZJ55oeELM5sqWuQTeRXjIHYcfEjX
 gxRBKNB6ps7fZpP02+yJRAy/m9S1psGUxfCyQcCOsWsxBVEMVIRX4QiJrpic3EUy6oUoEv3tC84
 +X0h7lvkHsIk+/2HTkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601310147
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41837-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9D1ABC340B
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


