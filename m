Return-Path: <linux-pm+bounces-42370-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OpnEbZIimm+JAAAu9opvQ
	(envelope-from <linux-pm+bounces-42370-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 21:51:02 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF644114989
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 21:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 466BD3042450
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 20:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F39426EB1;
	Mon,  9 Feb 2026 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eICAMQfG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kHcvwGKH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED0426ED6
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670166; cv=none; b=KW59UQMk4TBTdot8ULmHrIZePdpyhMNt1fd9OzKEbDtm7kxZKPk+gBgXyQl/Mq+UB2U/j68idMWlR50AUoqg5XQKXxB0KrIiSdSu03ZBA1Z0YOfCo7g/cHjYg+CDM8MJSHailvrPNKM53TrhaTbsfEqnikOycwBWzchXut0fPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670166; c=relaxed/simple;
	bh=GjcOiAhOVZvgwvg/4rS0umS+LxdiLMCJC8TaLjPsglM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6dR8bUYTIm0mDNdNPlRaZvkFrZsFqgCd6725fDc97ZIHS0W7ZKF3UbhqaCBlKCSvWUmJuZMHpxrNCAWnsWWH6o7O8PlhI5LJceMKOgjCoUypccZwTHvQ9OOYH89c7G0f0EOBbUmTzeEiTUkqTmHvjutpOKaAETxjLJ8tSIOY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eICAMQfG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kHcvwGKH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619GVYAp4102283
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 20:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hCLz2PQNAIU
	C4fdv7YAerV+Je1obVaIS6CQCQXjH/hk=; b=eICAMQfGk3uSiw22o6Fx/WBrBIG
	taBRQnF5ES+XZZWvygMkkMSQpY1g3oWg2WT0lL2qg3UuWmw3yvBRWmRnJILSA1SI
	HYrMTlWrrg6wQ6FQiGxwCyq2kJILU4IrIDg282ddJOMj6Gagm5jUwA9Zk8fu4uQD
	EmqdHSZwvHkmIW4rzCOIdPulrfaozznN1/cm2SH1CW+LYKAEWqe5zuwHO21G0Nhe
	5PDqoxE1N2OxdaUo7V4m863oJifwzyPfLhcmy0wQiZ4uL6jX732+zDfhO6sAH+1Q
	P3zZaHH1AUCVP1AtFV5zBISRsSte19deJLihrNsM/TnqGPsISpKcbn5d7Ew==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7k61gsn5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 20:49:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba7e98178fso440390eec.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 12:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770670162; x=1771274962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCLz2PQNAIUC4fdv7YAerV+Je1obVaIS6CQCQXjH/hk=;
        b=kHcvwGKHqX59CNzXNqtv6FzGUXBQv9r8+vAc92s2h3kPphD0hnSkW+vL3C2myr9gRb
         DdcGMsxcWew65YLTexfYexsu7MWfnjss56iJTFyoz61sEVSAFb/KJZ3lolfVt7FdkZyp
         Dh4DOUU/K6PphYHaKWm+f1ynS5MyopomFg9MLkqEfUEwFKg8YzwkHBBU6DTevY4+QFJ1
         gGljiHxpAYrQjeNEzN7I9BTmtGU+0crQyBhLFf4Sh4S1yNwHiRHt4DRsd9AWMwsqwbw3
         KAFIzfvNWcG9htWWeIsDYkv94DHuAnrjDqos+ymHEHvi0g8hfikfmBh20r8tErzBjhIH
         QmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770670162; x=1771274962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hCLz2PQNAIUC4fdv7YAerV+Je1obVaIS6CQCQXjH/hk=;
        b=p+uH7zhBYjn0OgZcovqzc4SUb6nuSClNC+8mVrZFBN8+T2YyYBe9htQkQV8HCT+se4
         PVVO2nj92kmS4rmUTPG5VlAlBNZknV+dzhW3O6ce3lNEU/sIBIzr4J4SX8COIXwF2bml
         hKzz+qOWcGdoYXntJ4ME1aLWGOadlT4oJdMB8huoqecZU8A4mLpd11QoH6/BLAGVDUat
         Ez/O43aVvaxbtXF5jhzirDnuEf3YyLzrjwhkFTKB5ps18pSaKJ9LrS+R/Vm8P+grfia6
         Wf6sK6eqsbYsMifnaumgEiqn2ZAcoAEV9khZf92pCQ8nSF56JcGkO8D2hkaMVhFJ8RaI
         wSEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbwsdnMCDfSnBgCz2wRmx0iZ1deDzSF8flxJwirte07BzkSL5nQCO2fYYOTx/VIVaRGR4PjvI/1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWzgkObKRrmjklIfdEHxwTGtXxpJ6JnMzINaYumW8s5iQUW1et
	5AmNARm21yZ9UYoui2egfL2eFXNH8kwhX79GdQjhmRCk7nc931c4txlXFRqDgRNV7UDICqfBnIN
	eSe07VeC4BUorGegShTF9aUoYAff3VdzgTnR/gjwSWtISSNhi4rwxUdM+KKOQmg==
X-Gm-Gg: AZuq6aLXKQtnJPlBaNmrpvYCOlEr9w1+J9ha7lBhlDvrnZBZIbSGa/tbstu4LW6AD4d
	FJs02tbmjCXtSlrGuDErHnwcMBzMRt3mBTFpA1xGHrRXuZ7UQajcABYie97sMt55pGURxYApxwz
	muROm6ZDVKwbUL7QfEyGVTLkpBU6lhq7g7Lo/ZXFz49sxGauYZ++Z7+nczd7xar6SYHk+QvGMMk
	iDd10YDL5Q2uW+RPwLAhadVLj20r4WVKRFx4tNyH6o7TAbdc2VLfWcf7Na93jrmRttZSCYlU+nB
	DjubBoQhLjq1f0TdNXyMe2RWtYYCKby95h4yGogkPeWOCk4g567rtuIe8wAvhO8BSbMfIHZkvaD
	Zfl+Lvat16RPuwR7c/gmGKN0Zd18U2Rmba88v5bTjy7z8HokNRLwmR9/tWh8R2XWaJdvMpjB8
X-Received: by 2002:a05:7301:6783:b0:2ba:871f:796d with SMTP id 5a478bee46e88-2ba871f8c45mr337453eec.30.1770670161663;
        Mon, 09 Feb 2026 12:49:21 -0800 (PST)
X-Received: by 2002:a05:7301:6783:b0:2ba:871f:796d with SMTP id 5a478bee46e88-2ba871f8c45mr337432eec.30.1770670161076;
        Mon, 09 Feb 2026 12:49:21 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba89ae14c9sm106247eec.29.2026.02.09.12.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 12:49:20 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v5 3/5] soc: qcom: pmic_glink: Add support for Glymur and Kaanapali
Date: Mon,  9 Feb 2026 12:49:13 -0800
Message-Id: <20260209204915.1983997-4-anjelique.melendez@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=M8lA6iws c=1 sm=1 tr=0 ts=698a4853 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=eoX2Nymsb10xMOwzDcsA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE3NSBTYWx0ZWRfX3YKmYALK1rcH
 Vct1j4JwTiF+jB6bNfuF8Bz55Oz0fepqvoI6iWlgE8HbJkO+tmmm/x+tV9UWz6IoNmp5cVwQGMS
 QNLOlugQoFIy27qi4uXa2rRoa8ZZ/qqHtJuQaQ+YBP8AF0JTmkWHsgte9fv9OZ4p19v0GV2G8Tm
 J8RURQj57q6FBxwsRF8u02cHAlpv8UNX2AN7bjr1rqKfn9TXOBoXarzZmrhxHkMeUkTCYBsbisZ
 1l9JZdkNatiJjMHgmqYAj15+3ajXyqQpjJ7K80yWg1T2tUHX0/Vy/NCAPY7Azxjscq2lCTZTTm2
 slKLqrwXBKGC4D/zjEL/kMWKM2yLF13vFzVpvTi77nMAxRdgl5muH+m4W6lOduCxOeQ57hKaVKC
 m5djOFEkzofD7q2wbhv8hmKtUD2uxGd2Ark8CVgsqQEho46Vtthc7Xd7tTR9Aw6v0ojOXKyy/AW
 IyiNq2QzTLWov4yl+Sg==
X-Proofpoint-GUID: JVdcvNJcwniqrcNnha9dbMZrS8mURCuo
X-Proofpoint-ORIG-GUID: JVdcvNJcwniqrcNnha9dbMZrS8mURCuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090175
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anjelique.melendez@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42370-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EF644114989
X-Rspamd-Action: no action

On Glymur, a compute platform, and Kaanapali, a mobile platform, charger
FW runs on SOCCP (another subsystem). SOCCP does not have any specific
charger PDs defined. So, add support for Glymur and Kaanapali compatible
strings.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/soc/qcom/pmic_glink.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index df2fd03d3b33..3042261578aa 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -397,7 +397,15 @@ static const struct pmic_glink_data pmic_glink_adsp_data = {
 	.charger_pdr_service_path = "msm/adsp/charger_pd",
 };
 
+static const struct pmic_glink_data pmic_glink_soccp_data = {
+	.client_mask = BIT(PMIC_GLINK_CLIENT_BATT) |
+		       BIT(PMIC_GLINK_CLIENT_ALTMODE) |
+		       BIT(PMIC_GLINK_CLIENT_UCSI),
+};
+
 static const struct of_device_id pmic_glink_of_match[] = {
+	{ .compatible = "qcom,glymur-pmic-glink", .data = &pmic_glink_soccp_data },
+	{ .compatible = "qcom,kaanapali-pmic-glink", .data = &pmic_glink_soccp_data },
 	{ .compatible = "qcom,pmic-glink", .data = &pmic_glink_adsp_data },
 	{}
 };
-- 
2.34.1


