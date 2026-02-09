Return-Path: <linux-pm+bounces-42369-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPgsKXZIimm+JAAAu9opvQ
	(envelope-from <linux-pm+bounces-42369-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 21:49:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 882DA114930
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 21:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0768E300DEC1
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 20:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC919428837;
	Mon,  9 Feb 2026 20:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oJ7NYo9L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bTakVY2Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBEC426EB1
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670165; cv=none; b=dL6TYBwwOb1nxF0gRBYLmITeuL7aTJewQJg77htx5Qt9LmJZ/PhCBXiC8XbtQbRbbNzjDHn3V/T7AzxKrIgzGwjH8AboRgOyea1d4+dc52fMWMz2aFJXDQUCndXWXtKQpVmvoDLLRBCfWCjwSauPIVcIQx8U0UMdyw0HXeDNcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670165; c=relaxed/simple;
	bh=lb15+faF+Bj4CyuaWLPe2aYw1ThfhxhGP+DnBVjNajc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GvCP9P/26ezbs9FzZzQWgkMN8s5A1sXh712w9NONdijdNxA/Kd7BQVtljKk5kHy4Ydius/4mGHFsLSaAjHm6XkZPPdtEun+X9IDlRkLbs8tjYpk7Ut6IgdygGDH1e5B6MVXH4T3aee9/T5NZ/Dxpq1TO+ha3Tj7BhePxIX3J5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oJ7NYo9L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bTakVY2Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619Il89k3347583
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 20:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=z6wBMOBlY1A
	ZaU9EBufQxC3HeY99WrDaPrtxx7GrAmM=; b=oJ7NYo9Lurrahnludv2xZWKeap3
	mhg+dr+YCitsAGu+FYRQrveWltQDiMeJRZb05FaOWsz42iE0fzu11xuBQ/QsPTw4
	exq4RUCY/oSlPIz8flwzmiBKQSUddBW3aDvfddsZ+SC6gxc9TkP9x4mY7tcKaPpz
	CCZEG2irt1CJWpiIwLvybNJrrXeZuTWwveTSTqD7GLL7/5H7j7yljhw38cjKOTrL
	BP7GUhRn9sc+k6Lz2HXPPBwy343ZJBhS/L639rTT3Krob8bxKnAFYsUJr3TXIIM9
	uqBFuDZu6MrzoKFpH+gZa8E3iC8eRcLjJOZKLJ1aYVUMcZRkrriofVZ96Jw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c79cy2xnr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 20:49:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b9ea5408fbso83988eec.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 12:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770670162; x=1771274962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6wBMOBlY1AZaU9EBufQxC3HeY99WrDaPrtxx7GrAmM=;
        b=bTakVY2ZbjV7FSUpIiQkjKhs7oKVwWXUtY0pSoVg0n2R26aztRlBV9ZlpJgTFa8KWY
         LbnNWgJQhKwDugufndaosisUQIhivFUfcrLiqaigf98TOs5JJMnmEULlqE4ti7CD0PSh
         PCl7t8Y8Alv5gzs4LMD6Uqwms+7gHvEERvSr2PTokcoKqHcnuRH/yH+DeUfTQHtWUjVP
         4Spt+rGNZPjxjxVXItZIys4IgtIntebzEokFUdxkqYoT21vE5lkayCYrZB6Uh2rETn0o
         wszb7HAEEha7jXYacVbIpSx4+V6rUSvcesLrr9F1OqcKYXn0XSFwK92abt5rGPQNnKM6
         OgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770670162; x=1771274962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z6wBMOBlY1AZaU9EBufQxC3HeY99WrDaPrtxx7GrAmM=;
        b=vQkwFWYOTDkTuTKH72bRC7Rffc9qMJDXYp5fVz63JqKVndHITWtZbX+42+m8QLB7Ae
         ncSEcD60jU7BnuTSOl4AuKske5iX+HxEFA6oicpkKJ1/2/9hPMl7hAFubWiFJzlczPVu
         75UnVyDqWq+fGVucHtdYo89vFk9nsI6hQWrF+IPJMEuE6UGLP2glz2kgtgwH5TBoP+Vk
         j5odaHE5b4OHEcRVifW7nZeFKHSWaGfsqx6OimVIoK4+JDyYMlOrdal8BZWqi3+P3Y3v
         QJnMAcDhhwyjCMFgMVfe0npDkM4pRUUJ9KAdVOeDQ5fGXNGOYSTIr3uv23k0pMYW9zyk
         uwCg==
X-Forwarded-Encrypted: i=1; AJvYcCXvxe78w5dUYkD6rmFClRj5WVxo8hLOiYc7BGlKaVS2BvgZPpxlzPl6cwIDAlJAFx+dSyffSRG+lw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1imkCgCQEHjxu7eOXPLUPX1IXKRnpfTw8s4+nfx63pRnzVHPT
	L3PFrkfhTLcwjPibZhBfAGOozp7eZMNMUTRzL9n08+X0981qXPbZuqQ33ddhxaFM9vy9yne3QGH
	VPbGas+i/GiYVJwWO5do1izMSu8g/KvlYjhJkcMNHaNGCvoCA0cTAl9+FCnpgqA==
X-Gm-Gg: AZuq6aK0XL13ZWHMI0ch7ZT9JCkBFqLKwNVGsGXwentC0BPkCbGZKD/W4WQQFXlbSMf
	iWF+/m9v/bdzgIQg+MM11NtpRX57QkGHU+87H7Ou+U2EFb5L40GDpDDQw4F0JskRjLcL4g7PJpb
	muRjpLn161bXU+KIzW6qdbF3UdS5SyiTPW2Td0XXrBG5RXETtlbqYlfLrzD8o9aNtQ4vB8ybnrC
	ns/1uqTAj4nYGhOTTJBmaSvkwr0/XAfT2KGXlQGstLIyD71r3iyOq1/xOlLq822aW9NJPyqUhV+
	MEjG2V7batmq+uGtJcWdOAn6PrlkcMrklsQG1o6Wpg1tQ0l5DGnYgaEyBy4L2WeCHPV1hUev0Jn
	VvZ+KuyamqhIWulQJdnYCVXpmpxYmH5se7Suie3hs6MHrwgaYkhVwOmXsM7Q2LO2yC2V1uX6uWh
	StbO7gCHoS
X-Received: by 2002:a05:7300:2d05:b0:2ba:640c:e238 with SMTP id 5a478bee46e88-2ba640ce851mr1874338eec.40.1770670162387;
        Mon, 09 Feb 2026 12:49:22 -0800 (PST)
X-Received: by 2002:a05:7300:2d05:b0:2ba:640c:e238 with SMTP id 5a478bee46e88-2ba640ce851mr1874319eec.40.1770670161797;
        Mon, 09 Feb 2026 12:49:21 -0800 (PST)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba89ae14c9sm106247eec.29.2026.02.09.12.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 12:49:21 -0800 (PST)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v5 4/5] usb: typec: ucsi: ucsi_glink: Add support for Glymur and Kaanapali
Date: Mon,  9 Feb 2026 12:49:14 -0800
Message-Id: <20260209204915.1983997-5-anjelique.melendez@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 0oz-jJSyB0x7tSEYPS2vLg6p1Ia5H5ng
X-Proofpoint-GUID: 0oz-jJSyB0x7tSEYPS2vLg6p1Ia5H5ng
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE3NSBTYWx0ZWRfXz95ynBT72Dku
 zh3Wetdn0Zmk/7AFRrFhbdw/9ju7ENaPjNX0shjVm9ntR4PHgqZcxxgtR6DVoNIVuWZkuxx8Qck
 T1KoAqpoVLaYaNbKHAIvWLv1HSOj9TX6cVCRgNRcRg2e8cEDQ+hEnBp29AbAFRRarmwU0qpwefS
 MYbipZ4HhJsgjBtJ1IelK8aXmdDoNBpiD09j7otsFZisUuz2/KSFy0ePnyIsq1szn8hs9dM2Bpx
 czVWn4X/EPWY91Zd+j76tc4/wJJgtIJjtlB8b18RnEuClQdWewdJxmDvH/dCjY1ucBUk32OkWKe
 HJcCGCBuGntupYLZ/dpBubibiioMtavjNMVxChaL8fgJn7/a5KtWnptB7WJxgtWDbwnS6j1sJLp
 rOhyFlefYulGOsXijMxqxzzaAmiRqhYBEyTaQ8N8n9cta4Fvu5IqugF482gLQUlPmlv6/Hj1Rn4
 zi4lcbvTlczZUiaLG9A==
X-Authority-Analysis: v=2.4 cv=EtvfbCcA c=1 sm=1 tr=0 ts=698a4853 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=-sI-HX3K5ndwM-XbIJcA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090175
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anjelique.melendez@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42369-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 882DA114930
X-Rspamd-Action: no action

Add Glymur and Kaanapali compatible strings which both need
UCSI_DELAY_DEVICE_PDOS quirk.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 11b3e24e34e2..c7878ea0d37a 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -373,6 +373,8 @@ static unsigned long quirk_sc8280xp = UCSI_NO_PARTNER_PDOS | UCSI_DELAY_DEVICE_P
 static unsigned long quirk_sm8450 = UCSI_DELAY_DEVICE_PDOS;
 
 static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
+	{ .compatible = "qcom,glymur-pmic-glink", .data = &quirk_sm8450, },
+	{ .compatible = "qcom,kaanapali-pmic-glink", .data = &quirk_sm8450, },
 	{ .compatible = "qcom,qcm6490-pmic-glink", .data = &quirk_sc8280xp, },
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = &quirk_sc8180x, },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = &quirk_sc8280xp, },
-- 
2.34.1


