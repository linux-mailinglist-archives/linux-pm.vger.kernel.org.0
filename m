Return-Path: <linux-pm+bounces-42371-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AAKGbtIimm+JAAAu9opvQ
	(envelope-from <linux-pm+bounces-42371-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 21:51:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E45114991
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 21:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5045D3013FFA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 20:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648BE42980A;
	Mon,  9 Feb 2026 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A7ry58RM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XVgjzRAM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56B642849F
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 20:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670167; cv=none; b=sd/uh6Zin/gRzIHDz5fYiRPwZbDFdfRnv2YNliotBz/0D9uYrSRuMU4GX7XL7UyKefyfU4ciejzXX3Z59Ymt/HTonU4OIHMe3E6UVPInLf5ZB0Y/7baYhtigJvPu1pFPucENhVtcS8xpG5yqhUjBQ2nFeI8sPj+0JshPfwwPbIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670167; c=relaxed/simple;
	bh=wbDLIC/kNGZ3h8BMBe70rlk5uwo566aWa8ZTAO9AkA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5cBfxK1CYtN2LtlZGFvwirhH36KPvKUIvKELumE4kBxvs3KdzFb5F9MEnFgMzyhlHJL0tF2d3CTehNogcZ04Pk7Zm+k0nLkPCc6nOmvWR1FOGK+5e+Mg4gddYLDeZZ9lTZfYX4o6+9RT6jtYYm87BO/nr8CZjA/C4ZnJfSXh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A7ry58RM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XVgjzRAM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619KLCfv3436726
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 20:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Jip/3G8CKVy
	YJeY/9bxM7H7qr58iBaNdMarG43/Z/YM=; b=A7ry58RMQ979W5nW9paYLGGE/PH
	HcFW1aELJbubeasIWGRnD+6efBxV8iA3UcTbLtr46RT/0n6g17lwOYH5pQZz0yS8
	L5nVjNmK6ScnLjUhFVtzGBQ1ctlmDMD+BGmNsnrvhnec/dlWRPmglurWUFY3AoqA
	65XTg/yacTGTaKKjuKVw8MWZNbCjd3YHMu03l54f4HmR0btUetmKMlBNFyN/khXK
	w52ZMe72NyiRyeIsJsWCCGbVXDU5C9uXahtl880o3/4Qy5+botNV504t2BL5VaLi
	Dt6DQdFEA4d+mayaQ1TE93YvBUe2Ghs5DEHxE4JWPRHO5ULks9CeSHmAHJw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7fev9mph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 20:49:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b6b9c1249fso3984340eec.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 12:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770670164; x=1771274964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jip/3G8CKVyYJeY/9bxM7H7qr58iBaNdMarG43/Z/YM=;
        b=XVgjzRAM+Ey/6mK7DGCzG3qXbSyY1xR+XtlYR1V6o0OipXKUrjsdgSkoTS6MuCq3q3
         MVhPXHwIEr2p1UODdPdRa0wZfGB/BOViflxtuK2JK4zmR2f3IDHJap2MlAtA6NedeNXY
         n6wW0+3tNCFgC6ob/WpliapTtRNBTRw0+Oo6kwnArDIGE/XQiDrnvnYOmKosqxvsr+VP
         qwTukebRUlfatFjHekJIhbEHJfYPiUjJDY8/Iw/6lzxi1LNi1zddtW0LNVMZUqJjrLGF
         Gs8VXnqO7dwHjSNUcqrh23X6Fv8xEegOVS/JQCnGkqISO+QiPZAlvMMPDuSvkwnojw5p
         X9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770670164; x=1771274964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jip/3G8CKVyYJeY/9bxM7H7qr58iBaNdMarG43/Z/YM=;
        b=CczSq7JdhtMvAG8wHfw9apx/jXrmFLOJ644Au7l+agZ6D2U4FX53fmUMFx9DiqMSRa
         gI1oodfs4YH5F5L06R1NKmNN+7D31wLYcG0wgLFez7WktuUWQfSGN+lDdasmmclncKBZ
         QauY+uefxkEbH73v6zLSpvECJ/9h0NDyIP1AiY1KjVkpKpliS/wNfTtip/KJyqyMsGS4
         66BtGxfzsa3gigqSEBkWLGCM/gTnTzK3HI677pNAOVsZmwa6aTsvpPkxVLJ1Zbv4FM18
         HyYLRpsp9o85rQ8NagHh1/FkcDYChKrSXza2p8n9uoLUDj2k7ripfdJ/kEUQRLMfGYMp
         mxgw==
X-Forwarded-Encrypted: i=1; AJvYcCXc26iHbZTM27rfMYsNZ0+7Wj2NmmE9+U1YRMmXU94Z0vgiWt/rRusO6AxntozLI8QXlQXK3YrFiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwNikk5fbxMLX/idt+b+wLd71q7nooR02Pib/s/3D5v4sPjKQI
	CU/iXymGchY8tauDhkmj7xhaSdYOaeO2AqqFun3NvXVoZJiHB/bI8L7N1GGV6rNnY+vFLgBg0v3
	BpS/sC/a2pkL/01Gba75QNc1BCusjyQcHiv5Dl1x47N3pGffE6Ak+/Abt6McOsQ==
X-Gm-Gg: AZuq6aLDfNgzKuNK8v9rYInJzxHOMrIeSSaEF6zLIAsCeXsVij51f0f/7pN083RtyvQ
	eY6IdbGAqI7izbwoPyyN5c2PldHhZ2H9Z8qCtU/0p1moJIjSRRpH3V+sYn3OyPRCKXWinR4EIou
	TYzCj+NJ68H/rnYQcOAVNlI21dk4exNnf+/BQIKhov5XGxD2SK6qKl2C6T60qQ4kg+IQnZmxGUE
	7SpkdMzBrqKEgJAE0KIsR2NZ9qsnL9rpEo5ffy2WRqbwEPcTT6/o/FZ8/OmQlSAv560MhW3Qeun
	N2hkBReLJPsUhtX/YbAIJ5UbdiGdrf+PzqYDm66etJ85BXm9ziz9MfpY4EcJfo8Tn8HAB/Poz2c
	g49oUDs1ghhIZ6MTG7CQ2mhqxq0A36vB1yuds5IGVKcxkpxzP/zCPlshbBXplOmsKGndT8GNy
X-Received: by 2002:a05:7301:418a:b0:2ba:6b3a:7696 with SMTP id 5a478bee46e88-2ba6b3a7b06mr1980389eec.8.1770670164406;
        Mon, 09 Feb 2026 12:49:24 -0800 (PST)
X-Received: by 2002:a05:7301:418a:b0:2ba:6b3a:7696 with SMTP id 5a478bee46e88-2ba6b3a7b06mr1980376eec.8.1770670163883;
        Mon, 09 Feb 2026 12:49:23 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba89ae14c9sm106247eec.29.2026.02.09.12.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 12:49:22 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v5 5/5] power: supply: qcom_battmgr: Add support for Glymur and Kaanapali
Date: Mon,  9 Feb 2026 12:49:15 -0800
Message-Id: <20260209204915.1983997-6-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
References: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fVv2bdhYRQFGFy5pVe7doNdqDswFlW7m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE3NSBTYWx0ZWRfX/nyKUVDY2E7V
 c+A/BU47nLI+sqHZxeLONojoT1omtzR/FK7Di2M31b9cmOS+1u48dUQaSt1LiAhYhnGGTTIB3tM
 Vdb1pWeCtsPM0Fd3/Onr1lNdys5TS4U+sFG6Fa0HgPYQ1ZHPXN2hkoM4kH+TXiPNpgU2DKJeLYY
 fAmNLj4+JjW8Sek4HtbmXva9ZpWD1idggU110FqQ4vIltEOXyjZ0kFd2dcpl9sgO9o0PVfPHIYX
 u2BMP6PBPQtD7abCwoCeADqa4BlLPWlxlregQy8HyYZDEx8DfweWOuYLNT7FHEC3xYLMe1dwRYM
 unJJwDzuyzi83mozj/zb2yIL2hM0qJYY+EtUKL+/PMa2bSZFt8p/GZtZh8hDGSiGucAeZ/ra0PO
 Hw/16DCX9H5vg69PNtXSM4rryUeQYD6H3unbPf2IQ5plKBGOJ+vEPzRcG3DO/gK/We9b/TdSMsO
 wVZc23g/28JFMlJi0BQ==
X-Authority-Analysis: v=2.4 cv=F6Rat6hN c=1 sm=1 tr=0 ts=698a4855 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=E9l9NioYpaNDlZYFeTUA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: fVv2bdhYRQFGFy5pVe7doNdqDswFlW7m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090175
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
	TAGGED_FROM(0.00)[bounces-42371-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 82E45114991
X-Rspamd-Action: no action

Glymur is a compute platform which has the same power supply properties
as X1E80100 and Kaanapali is a mobile platform which has the same power
supply properties as SM8550. Add support for the Glymur and Kaanapali
compatible strings.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index c8028606bba0..576ff35b4b71 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1610,6 +1610,8 @@ static void qcom_battmgr_pdr_notify(void *priv, int state)
 }
 
 static const struct of_device_id qcom_battmgr_of_variants[] = {
+	{ .compatible = "qcom,glymur-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
+	{ .compatible = "qcom,kaanapali-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
 	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
-- 
2.34.1


