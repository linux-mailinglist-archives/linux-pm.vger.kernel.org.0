Return-Path: <linux-pm+bounces-42805-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNanI7t0lWnDRgIAu9opvQ
	(envelope-from <linux-pm+bounces-42805-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 09:13:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E25A7153E95
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 09:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B997530191A0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 08:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D4531770B;
	Wed, 18 Feb 2026 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VIyYDvwG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MkoMn48l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975A3161B3
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402369; cv=none; b=RrXXqUURt5ARVf32V6qOghkbeKBhWUyX1F+CiZGKqXKguxsAbk52eMNYvMSk3VYvnbR0wSSWTbRw2afNwoJCUfCnwJ82r3rAzBFt1KbNBQaz0ARUc9+2p10HDNYL0YrNGwKal0oEmU/phodqqG5yIFuAuLPCd4X7glTZb4SuigU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402369; c=relaxed/simple;
	bh=kr27uYpqKnl3/NaFELLNpZzJB0wElVbtKvpi6VqgH1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2dPsB1AgngIPha/aQiJRkve8C2/LEOdZ5Dk+IdzmL5NtCwbUwzPTofZXr2tWPormGIAieigmIhjiHhYJCq7XbC7MeZjJo/a3m9pIqgx6ZnASfnmLYfqAno5uGs/IqNu27PII9Tpyusz7BGLR8nS8k6oOWPoS79uh0UI7Snozkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VIyYDvwG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MkoMn48l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I6aHLG1943465
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 08:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iocoITrqzOavAzny70iEVGcoDGpxtUqYXZTgwIQV1KU=; b=VIyYDvwG2NMuEJ8Z
	QqIv6XDRxCwMPB3WoF/mNYBu7FrrxN+zjRq0q3qTETgZfWx5BplPVFnJ7wb1Jjxe
	AHOjVekZN2rd4OHTZyoDWXGq/v10wGiBZlnmW7KiUR9mH36eIAS6WFNEPJvHQcBl
	S5HvO1zYyxy7h1EYYseORgqEyVRulDcv7hKtnA63ZGBnp5vK2xhljplyKpxhN7ja
	hJBx8z5OYSUgVyyPpV/XFgGhiz3hO/9CFcAXuZrjYcppsrHA1QqFzXubWwPyzIA5
	UsPgZ0/caPzaPZjjsJLsKfXd815AT9ueXsNM/meSlAvbAOuw+zew5ExzreGF0xD6
	kvk+OQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccq4g3b5s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 08:12:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aae146bab0so62109355ad.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 00:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771402365; x=1772007165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iocoITrqzOavAzny70iEVGcoDGpxtUqYXZTgwIQV1KU=;
        b=MkoMn48lut9BGOAJvMPpVAViP+nIHJilfaaTDvPCsZ6MTi7/P20ak5faYjYGl32jbn
         6ZVA6mZmhj/edcdlND33A9x71XTS2hHy2X1KdFVjQFZPUjyHmZ3Du5HNiVVJj7FKLaY5
         aa32wwLp+8dXlV+H6udixDun4fURpmVAfA62gZZwQfubhCnSWo/6WYy+dulC3vq7w3c8
         Moyu9HUdPiQsbBu20WibgOkd36L/OWC6SXql9fewfuyjQ/wfq2DqpG8Y99aUbO7ABNyK
         XcAQXpZt90IoVwZGCIscQlhq+mUWs1dUbeZcft0ZzDthSd6q+dWTH/Zkl85ey2ebxRuI
         DS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771402365; x=1772007165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iocoITrqzOavAzny70iEVGcoDGpxtUqYXZTgwIQV1KU=;
        b=icoI13fJnZjuulWitJOkWEWdwXdV0Os9HWvh10uS/AeC1ZPU2Md/z0T+tmLpYzrMc+
         bXBO1Hv5okrEtwZKFT9CYw32UbYng+lbBP82rjnmG0lUmMAh3+BOgOdyyJWSmyjfaDLI
         pPA9iI6+SQQe90NyhdEyTEb+hgQWeV3Y8Rc6y1uxZQughf0u5Fv9yr388xdxr4QWZCK+
         LM3qwJWmuhjpl0N/kL6JtSdknT5Ue3s8J7RUiJ5Z1SDqzLZ1CIqyuF26JXG4b7Gr2JAr
         GZXCL68N/BSiosAPB+lmerBaDyhDRYBXDeL1FCfrngTMpZ1KtfcUO06M9NOjX82zq9aP
         CuXg==
X-Gm-Message-State: AOJu0YwDkl8W0gvMDCliI8HQMOuG/wjiGfbpOJACP58PrTfIU4qjfOVi
	6xugDjOZrv3tQUCy9Yzw8utL/VG7yUiH8HW8fXxbYc/qCfaOnht7YN46cxjzUxfla8gLCqFlxon
	m8cojaLrTsWVqKFLpZTGP1GzJ+9elzvryEl5oUZN0XUy1/Qp4zlLA04aRI1Scow==
X-Gm-Gg: AZuq6aIJvbuIzcO6hecgmniwo5+eH2nXS7wM+XscGmms5hWTSMs28H/6do5rmsF8KON
	NMLRoIOQVZgHqLoM6nA0Sa836JWIj7d87HyPAG1TXFOFnyYUkiir9ea4htRgBZYfUmD2TpNhbI8
	HSZsLwnRxIO2dweGBFYAuPlTe0QgitU1NTEPS4EjwL3//lM6PdpsrbKE2NPwknyGoP24T7hRi4S
	6IbNtI5bfEW6qKHH1c8M8Kqm5YIk58ZU98eL++jfAJZEVRZ/cZYKEc9VVFbwi5HoYvWlyV58zwU
	mXxJvzh2nxY6OFjdbV7Ux3/rokPutQaIMR9HiiPjYtwYiqGDekmMsr+O/Z3W2Szw+EBRsIpLHyo
	89vTztkaw3DBOf6vYeTp/Ck2ZTNSMzrNutZBQKsfpSXACXGtAq4+pLUeH
X-Received: by 2002:a17:903:320e:b0:2a9:5c0b:e5f4 with SMTP id d9443c01a7336-2ab505c0e87mr138782775ad.28.1771402365452;
        Wed, 18 Feb 2026 00:12:45 -0800 (PST)
X-Received: by 2002:a17:903:320e:b0:2a9:5c0b:e5f4 with SMTP id d9443c01a7336-2ab505c0e87mr138782615ad.28.1771402364996;
        Wed, 18 Feb 2026 00:12:44 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d624esm118123685ad.49.2026.02.18.00.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 00:12:44 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 13:42:24 +0530
Subject: [PATCH v7 2/3] gpio: Add fwnode_gpiod_get() helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-wakeirq_support-v7-2-0d4689830207@oss.qualcomm.com>
References: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com>
In-Reply-To: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com,
        driver-core@lists.linux.dev,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771402347; l=1194;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kr27uYpqKnl3/NaFELLNpZzJB0wElVbtKvpi6VqgH1k=;
 b=CHIK6Dfv3xgeAdlKFHR8JSiT1167UOJDFNWBSMNuEKKQj5r4d7YEoEK+RMUc/wYwINFP5f56O
 Nubwn8ni7TBC+yld0IihIzYNB+K6wwABaSn5UR9uMig/MvicYBQ3pFu
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA3MSBTYWx0ZWRfX5dtgTVckkoUv
 AAz2X9pu0pRj5fJXlOVal+OFq8NSj7QtNDw86aBXgc2Cojf4bb1rep58J6Sd2C+/DEfrm21ulKK
 rnzhCE7Oy46HUpiADFGpQUE6hDucD7JU9s7NdZ1zZqBRy6nOkChxuH4YJjZxDAKJiTmLdy4u/yX
 nV0OdQnCh9lI35OxLnWDat2B8LGno3oqHdvBKhjfGfIlx1AhhsK4SFGJK+R46FEf82oFDttQyIu
 eMh5xJ8qUTiY9xKScAgCr8c86AKuYgT1LiwZKDB0UGu2ibPqxxZMRTclJ0cxzMe0WGHaM/TYNbo
 HuHzmDxeymWJ3eVopZzl1/PpVEBewtiMlfVUn0uUbcwpZkP9hFOJ3pMlexrByFohuFyD94lJB5S
 6tR45JhG7tPmUXz3c8zLD7BmAAqRoOXUm5bO9oTsYlPK+6gzS2dXu2ZCDrCmHmE/34TfwGAfomx
 y+pwa2Ub91b3X0sLW3Q==
X-Proofpoint-ORIG-GUID: gxOgAtj1RILoXWfMXj0bWiFzGw9H14J-
X-Proofpoint-GUID: gxOgAtj1RILoXWfMXj0bWiFzGw9H14J-
X-Authority-Analysis: v=2.4 cv=YdiwJgRf c=1 sm=1 tr=0 ts=6995747e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=Ocqi7cVID08-S0eeb-IA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602180071
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42805-lists,linux-pm=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Queue-Id: E25A7153E95
X-Rspamd-Action: no action

Add fwnode_gpiod_get() as a convenience wrapper around
fwnode_gpiod_get_index() for the common case where only the
first GPIO is required.

This mirrors existing gpiod_get() and devm_gpiod_get() helpers
and avoids open-coding index 0 at call sites.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 include/linux/gpio/consumer.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 0d8408582918680bfea6a04ccedfc0c75211907a..fee926c0262ce9dc4b9a3c151e74f2cf37470a49 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -596,6 +596,15 @@ static inline int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc,
 }
 #endif /* CONFIG_GPIOLIB && CONFIG_HTE */
 
+static inline
+struct gpio_desc *fwnode_gpiod_get(struct fwnode_handle *fwnode,
+				   const char *con_id,
+				   enum gpiod_flags flags,
+				   const char *label)
+{
+	return fwnode_gpiod_get_index(fwnode, con_id, 0, flags, label);
+}
+
 static inline
 struct gpio_desc *devm_fwnode_gpiod_get(struct device *dev,
 					struct fwnode_handle *fwnode,

-- 
2.34.1


