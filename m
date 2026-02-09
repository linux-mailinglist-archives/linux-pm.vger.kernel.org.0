Return-Path: <linux-pm+bounces-42367-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ/QDWFIimmXJAAAu9opvQ
	(envelope-from <linux-pm+bounces-42367-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 21:49:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C47E1148F3
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 21:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1BAD30095D2
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 20:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C983236EA89;
	Mon,  9 Feb 2026 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j0QDozXf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kRIljlZL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7461E331A6E
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670160; cv=none; b=IDFtQF4IiVYXjCa02B6xoucjZfoaap40KI2j+bTGcyVuM0iOXpHoPPIqU7PJ+0XLI6LFsOYsERqWQI/rVgotA91qJEKkh8p1j98YBNwhMmTVnNev3QH/oRq99ieHtPVRtFHcPjK5UIy4obItKcB5Bmgzc9NqQMQIqgW1eYkeGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670160; c=relaxed/simple;
	bh=aoUoYPP0lMFjfgsX8sXXZwnlizCh/N4rAy3MXP/KyGA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X21W3p1SGpqLjrgrNSzCMZdvM8ElSDK6SrvegzWrLsQuCkq7Aa+aOaHlGQISjIOlsRQWcSSWBwleet2ipgEXrr6eYJS//gdfpu7+EXU+eiyAuH+yiT0gXlqnIPQaCPfC8cpaQ9Dt8KC68se8GcrZk6Ukb5CMZFVmqU18Gw132Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j0QDozXf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kRIljlZL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619DGlDa3081680
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 20:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qTZ8NcDvt+yUUb6+k5zpz9WOatFhAqKIZ+i
	/C+QRFyI=; b=j0QDozXfvaNx4hFC9gB4xcn0IJh0DT4mEn7nmYm/O2nyO7URgfF
	rnPkfZhSNu1bC3VQQPmfzrISR4K8bRtgsM1W9M/UQhOaXsr1rul8LrMdrHcguoj5
	vrvC+2WLJzUuyjtSM5II1/ns9tL7IAB8BDTtYUhPlTIEt67cYBT5B/y8ffks2nCj
	VCnPRjsF2eGL7epvSxEMhZZVbRV9JtugUm/B56JBheiETTiBolmINRYlZseZi8dZ
	qWZ/PlgyvJYEA7tZpvkQocPdN9DMSxMo3uE82bziArVz4uaRHSXEAkUeZHAQ3i8k
	+KjtK3ecvr6U41weXGpkp53aveQ2imeA+Cw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7gau9e78-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 20:49:18 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba7e98178fso440164eec.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 12:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770670157; x=1771274957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qTZ8NcDvt+yUUb6+k5zpz9WOatFhAqKIZ+i/C+QRFyI=;
        b=kRIljlZL8/YXmjFMqtP6EW0lDDzOc5HL8d3A8Z+mEOn0s7AY5b5sq3cSoPCu9+PWg9
         DBTsx1ca93tRfbEMl+I0u7q7W7dy19FZXIE4NpAIlzpEUGDyex6bm0Vuh7KqU+UOZ3hP
         fqGwARFSRrUU1Jeex+KQiqofDMCNDzntuA94S2lCh9jvx8cSE3giq+A9CRJHFIg8y0Ys
         CADoxTLWKpL/u/ZbbVUY23K0nDOTiZE7B7HU95c0K5+rj84pZzHppB1iuDnGbCyCCEYi
         kwnvujojpOYMNKDmjpc8AQe6E8M2DxOrb+0yzUNLdbYQMxh234XF95ekVujcpXN9t2NA
         ZQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770670157; x=1771274957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTZ8NcDvt+yUUb6+k5zpz9WOatFhAqKIZ+i/C+QRFyI=;
        b=c0WSfWs/ARuanlvgF9NJTVF3ACU8LZkG0/GYltxAVseccjCN3NUOV+fMaHcTN8NNYf
         WpQhmS2/lLIqMkbr0HVvtGB5cgW7pPR5AXWo3VdtNj0YjNa1VGGHMYuWZs4tyw2Zzd3d
         eS07NnVLhoz0xHL0XSverYH1ruBsfaOjAzAPjcsaShiUWnY63F1Z+Ewy204Re82NM2Sf
         75QW2ogCtX/Gn4ooHJi+YmznOyYYmGHzI2t6nopHo/U9VgPIXkjGcvVTNx4E6M6Emi8z
         S/Ffut9haaW7PUBbvfLLmtPIcZN4DUXV0hSVKJBnpzBdeIru/FUmXf+KaUF3e5IH4WTN
         OcXw==
X-Forwarded-Encrypted: i=1; AJvYcCX/mvsMSO4HucDJe7sET0rsxkE6IenUs8AMKNNlEA1W2duMf7RpjUBJ9kaQrVULAw5j4QRwoXO69A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1WhTdAcaEq6giZknsrG7Yh/Pqv3vGprWrhIWDSJYW849wwn4
	HfzFZQ3qzLgtCk85E0JNMiG4ySczNN9hbwYUaNQm9tlel52thJeiO3onjJRQYc2nyUiEoW1bH6G
	iagjvYw9feMK5PNnu+EAK+ae2Y8CuTeYxMBrVYClLCtBeobVtsF8baxpzHwvpYQ==
X-Gm-Gg: AZuq6aKvNNXr6PHE+OOEhT0jlE+LHyltx5h9qHfta+/RRsGw/CP837e6fsR8iSGyWxJ
	CFRa2HuJZ+/ETZiK04G2UUFyTUts57N1j1HvQ+wNqaESjOjJbmc2teS0y3WVJSrIoGeJuzBjTfX
	PPQnhPPZ0OHHRd9MTcmgFYbVO6ZlT6jSRp5fN3kIfaFZIPX6wmH2DABjPeylS65Ddczm1c3ptDW
	EYIGjcp494sD418W7xuGOT/YGhxSpT3xVJS7CYwiUIaThirAUoSOQz4VVRda/ftYchgHe4hQfQp
	/onFIAeSMCiMuJb5AiYLoYimUwNwmRWQKNi/WEFcxT1zSTTBiM5DtVcXsmUx50bYjuKe39o4R/r
	jA6Y1CiXaGYZb2NVh860x8UI6s01BdaZ89T3i2M2Eg6pRykazOlqsL77/FOSwOBVo1hk5bRsAyn
	WxSklzRe6Q
X-Received: by 2002:a05:7300:e426:b0:2b4:5514:38fd with SMTP id 5a478bee46e88-2b8567240camr5656884eec.20.1770670157234;
        Mon, 09 Feb 2026 12:49:17 -0800 (PST)
X-Received: by 2002:a05:7300:e426:b0:2b4:5514:38fd with SMTP id 5a478bee46e88-2b8567240camr5656864eec.20.1770670156530;
        Mon, 09 Feb 2026 12:49:16 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba89ae14c9sm106247eec.29.2026.02.09.12.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 12:49:16 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v5 0/5] soc: qcom: pmic_glink: Add support for battery management running on SOCCP
Date: Mon,  9 Feb 2026 12:49:10 -0800
Message-Id: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GmHJ5HzjOTJzai8q3AAt-mH_V1CGiLsa
X-Authority-Analysis: v=2.4 cv=eP4eTXp1 c=1 sm=1 tr=0 ts=698a484e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8GRrOjMAp5Dx-Alo9PUA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: GmHJ5HzjOTJzai8q3AAt-mH_V1CGiLsa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE3NSBTYWx0ZWRfX0I+HaRUAC4U9
 wHbhaUyuBPCtnGQP/UIjmBj/0sF+R0R9Unfop+DiB1BI8Wcl4Qo9JAC/exyIxd0vu0UZg5pJMh6
 WmARDoxOAooukIrxn5l88XTIi8troIH3Ie9Mj9Hnz0Vvj2Wvs7WTmN/HaFKzSoRC+zXVMY500tI
 uQb7OkNmah5kpSDyye7SB3nMSMIMIZnBOsnrk5DobxSEf97KgZ3X8mYqoxNxrc6V9OVpflyWNnU
 hdhGE+wIFspfpaTauvmzbW+h9TTEIwrklfiaZe8vH+aA5QH58jCHvxTkACigoe6YBrRKoQrgQ20
 3KRoc9qNcoBOW+qDkXpRug4XuhBnH7efeXSpkLkpsA0ABykvNdHqj/GiADoXhwtPo6lXKz58K2b
 Vwf3n4UvciSqxZj031zu7AhmhzKpDhtEY5yu5K3N9sWRbUnT01TekUg5noSGJ7W1k8p3o/mBgHd
 lBqDsFVC43YKIluWURg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090175
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anjelique.melendez@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42367-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8C47E1148F3
X-Rspamd-Action: no action

System On Chip Control Processor (SOCCP) is a subsystem that can have
battery management firmware running on it to support Type-C/PD and
battery charging. Add support for devices, such as Kaanpali and Glymur, 
which are running battery management on SOCCP.

Changes since v4:
  - Defined Glymur and Kaanapali compatible strings as "base" compatibles
  - Split v4 p4/4 into 2 separate patches (v5 p2/5 and v5 p3/5)
  - Added Glymur and Kaanapali compatible strings for pmic_glink auxiliary
    drivers
  - Link: https://lore.kernel.org/all/20260114211759.2740309-1-anjelique.melendez@oss.qualcomm.com/
Changes since v3:
  - Added "dt-bindings: soc: qcom: qcom,pmic-glink: Update X1E80100 compatible string"
    and "usb: typec: ucsi: ucsi_glink: Add support for X1E80100" to series 
  - Corrected bindings dependencies
  - Renamed pmic_glink_data structs
  - Link: https://lore.kernel.org/all/20251217055655.638594-1-anjelique.melendez@oss.qualcomm.com/
Changes since v2:
  - Updated bindings dependencies
  - Removed qcom,glymur-pmic-glink compatible string from pmic_glink driver list
  - Link: https://lore.kernel.org/all/20251027212250.3847537-1-anjelique.melendez@oss.qualcomm.com/
Changes since V1:
  - Corrected bindings dependencies 
  - Renamed pmic_glink_data variables
  - Dropped "soc: qcom: pmic_glink: Add support for SOCCP remoteproc channels"
    since it was applied from its original series:
    https://lore.kernel.org/all/176157405464.8818.5887965202916918883.b4-ty@kernel.org/
  - Link: https://lore.kernel.org/all/20251017003033.268567-1-anjelique.melendez@oss.qualcomm.com/

Anjelique Melendez (5):
  dt-bindings: soc: qcom: qcom,pmic-glink: Add Glymur and Kaanapali
    compatibles
  soc: qcom: pmic_glink: Add charger PDR service information to client
    data
  soc: qcom: pmic_glink: Add support for Glymur and Kaanapali
  usb: typec: ucsi: ucsi_glink: Add support for Glymur and Kaanapali
  power: supply: qcom_battmgr: Add support for Glymur and Kaanapali

 .../bindings/soc/qcom/qcom,pmic-glink.yaml    |  2 +
 drivers/power/supply/qcom_battmgr.c           |  2 +
 drivers/soc/qcom/pmic_glink.c                 | 66 ++++++++++++-------
 drivers/usb/typec/ucsi/ucsi_glink.c           |  2 +
 4 files changed, 48 insertions(+), 24 deletions(-)

-- 
2.34.1


