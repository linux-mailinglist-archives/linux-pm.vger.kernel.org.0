Return-Path: <linux-pm+bounces-43002-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFk1GgICnGn6+wMAu9opvQ
	(envelope-from <linux-pm+bounces-43002-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:30:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AEB172AD8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1006E3038422
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36CD34D3A9;
	Mon, 23 Feb 2026 07:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bqdUhSGg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aWgRlwIk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2334AAEA
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831687; cv=none; b=R30jRqEB9lXIvv7Pm/BnmvO8ohOZYeHBzpKPXim/K8zVAYWMweLyDR1RrORk9dZJNRc050Gl6uZ5Bo7czpz+gD5dvoDdSXwURdt3ORgJ8oKr27ezJCzMakKUTjZ+Qep1OIpa6zazbaQRyZJ5kA+PamLaYvw9gwEiPoCXK4Y5e1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831687; c=relaxed/simple;
	bh=Tz7aCKZpxvE/URE9NHfPfJCIW6o+Wox+HN1jMO8zCgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XC4seI+5UTeTyjs+LFb4Cj/wlO3Zkk+L5DLYfY41xSeJG+wA8OV9Lazs7S2r2sX4gic/5WbDldhdrTogT96aNWpx6cmz6rcv5zdY4RuoV5f2ZPxXbeeROv+34vwZkTB0ZZ5nOtVQ4qfLoNfgjVvvzAmG9rq8BOjsbIsChbHWvLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bqdUhSGg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aWgRlwIk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MHAqD51060334
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V13TbOnjuV6VzvANE56HZysaUseqHKiXk3Stv9fSSv0=; b=bqdUhSGg4fNXC5Tt
	lBynV7L5CjuSOXJESYwWx3vFyqDGDls7Zwtx7n9sISNSuMJzh7UN16lJ1w6hz4s5
	2bThB4m0OzgpMqh7TiUxcmBjPWZOLk2wkaBSYBw5RNRm93k55D3BIgWqvIon0MIr
	ZbghUmGcXmjMY7v7Kc5oWG0gRwQRAJCmhK7yj8iTuw2EEiwBhm5GLL1E8ryEqvwp
	tJnt0AEfpr8xKWCvvxkvKVaIBiHl9KFAnKVTR+vOCizkWpraNxR7J5XHJNG3dOX9
	mEG5mvwhpWDUHVP9s6z26/akucfbtWNRM1FpY2dp8NShJqDdJljAs+CiJj/M7ACH
	VitS8g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5u9usf6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:28:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70ef98116so4541482285a.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 23:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771831682; x=1772436482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V13TbOnjuV6VzvANE56HZysaUseqHKiXk3Stv9fSSv0=;
        b=aWgRlwIkeetvYNGYEU+ReUUyQ5r6XdpIiGTbreZTCRZ7xbUrqAv/S+Uj7AQvI9odK3
         nt2B3HDub7VowEq6Hns5cwJmJc9Pn4AV+6/ZyJi/AhaJSCXLsCaX9ghV0VNs8VV8HMhm
         MZIF1JXqsg9lHP0U+ACbfZYuGv9CxXrIii1Ijeb29gyqVfFwc6RdStEt/mX1+0wnlMQR
         gpC38sQSQ3slMVb2UhOLFzzGAE7/bHFX7HeJ30r30zwJC8X/qT2+jqPjxQbxfWlku/ZI
         zfxG0J3SVlU/YwWQdVvCeLMN9c+fWddABq54eGk2TuLz66JHGcfxCyFHmNFPqxoN+0JJ
         3jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771831682; x=1772436482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V13TbOnjuV6VzvANE56HZysaUseqHKiXk3Stv9fSSv0=;
        b=wgiFuZnuzzvdt1+zwOQW+yi02WE+YBCABMNrrpDtjeeDMUJlnx4CP6uNT6TpWCULjQ
         fP/jcgYVkX0CaMhChDWgtDdh2PZQuK2EUdjTWWF/4jR7Owbm6eZGuRZKwVULPNtjtrHO
         U7maHa5PeDS5DREEVQPp0HnTUPKqWZ+WWalxUw7bLzuqQDWB9CfgIUXQFExAyvritgEG
         mfGxGpu0XpsAxXGYP72QT0lOQ7wxMCqQc0SKX0AhrJHdTJHOY+ReEEWOPrZM8vNbv1mN
         q3H3ZIWRGVEYS/aUuZLdHUNc3E5KAKtuhXXOT+KC/awJNmaejTO/YScOVoJS/FgOsyb9
         5R4g==
X-Forwarded-Encrypted: i=1; AJvYcCXELZJHT/cxbTtH1vpXXLO7TZ7gZDSYRLG/GH4ObpKruwyI2iEMR2U2qWC3+56g5I9ioyAqpLfbXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKg1V+GWJ3TYHvjVFj2A7R3Y+LJWPlynnXicMOrYa6tb7mT/Y3
	9IyraTSylsbevrVnq0j5trZLR/pdYI3Z4varNb3vf9elJIGQtW7PN04CuY0u8GkuEMMOYbmWhrN
	wyj2zrn3wtA4aythIpOG6yL1RSIX5D0GsWOaWC47vJKVYeMdvr0z6x9Oz9jTbaQegLIA8OQ==
X-Gm-Gg: AZuq6aKuhqjhuyRIuSswBfdQzIJow9OT+qnjVCeSnCDmdgVoTv6y4afXMHl1PMfhR0n
	sfkjTbbx+q7xFQjRR/tRjeuIveZo9Dyqg6AOPnE7jsnNYKo99QBtivNmaiRik3rAgn4nIURLF1z
	FpY34eRZ0RWaJDo8u/fsQZF6nn8IX9YsXaBPAPmXsuH++V4Adu6+xZmuCh+yqiYSK44v+Q213Ml
	PeVPHYpmrqu+X191Oq3Agw9OMC9rY98pHP2gufbJcHn6chWiiDzIsLKVgQmLiqp9lhzHEp1Yovp
	9BDj8xoAIlqBQP3Hafp3nB6jIdH4l5uCLl9bxv7ssehvj1zFEuVHEPsjqVwblRSuB08rhPvLHUZ
	eIm3j4/xfct0DOs5n+KpLQ7tVajxCmDyhFLT0DJuDBisijg==
X-Received: by 2002:a05:620a:414d:b0:8ca:3c67:8914 with SMTP id af79cd13be357-8cb8ca92dbdmr1030171885a.72.1771831682500;
        Sun, 22 Feb 2026 23:28:02 -0800 (PST)
X-Received: by 2002:a05:620a:414d:b0:8ca:3c67:8914 with SMTP id af79cd13be357-8cb8ca92dbdmr1030168285a.72.1771831682019;
        Sun, 22 Feb 2026 23:28:02 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9ff5sm18550286f8f.4.2026.02.22.23.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 23:28:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 08:27:37 +0100
Subject: [PATCH 9/9] platform/chrome: cros_usbpd_logger: Simplify with devm
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-workqueue-devm-v1-9-10b3a6087586@oss.qualcomm.com>
References: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
In-Reply-To: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tobias Schrammm <t.schramm@manjaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Dzmitry Sankouski <dsankouski@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2369;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Tz7aCKZpxvE/URE9NHfPfJCIW6o+Wox+HN1jMO8zCgg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpnAFu3KNp+CTKSy+V7k67mEChB+6tEknfgjT/Q
 0+9orefkKyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZwBbgAKCRDBN2bmhouD
 1wuWD/9J+JqARU6TsvU4zvVDheM7Vy4GbVVCDxKaqTn1LB64+jTh7G+qQDyEO+/8tfwnovEz32a
 dZfCA3g8kmt9XMucw0VfKlsZIX+GwOFNPaCzVAIUDxeJAZLU7RU0qIm5Sr9Tfvg2BRzyeDraYlT
 J7liSpFkaTD39Xe9e+ncf8BMH+iTwVSEDGmzCDAoM8binwflLgSFhX8+1BAAD+6dGF7I8S5Jd9F
 f+Yfs6XweClFjvk/QYcBtkxFZgTpt1p4s/Ksnk40iJqDUWV9nT7P4LCPGIedS+T3FPn0QWCatUy
 WQrnAzUWqundJe80uxqAF47q1sVAqylM2iuodrq7bUXWaR8M1DHKMOsQK60jEyt+n0BrWTqTC4X
 0OvX08AJfnLsjhGl7MXfKjH+t/A+dPPQeqxzDF//csXt0QJqWoJNq9HCMfDdAkCxvlSeo4H9Z+z
 cYCbIcdRo8JQNn5a6H/48X2v7YhZV8tkKw2OTs2JmW54h38R8qRm/EVPRfMRk0VxUtTcZIuj/Vm
 qUIhXscFFPVRJCkWfps7q1UEqNoWwk6x+NdWrH7EYppRe0NRgJ7xIAgldkle635fxHyB2C0sUgo
 yylFHJPeufQjL0tRBOlpP0gjwNExCI+B70e1ZlGbs4mOM7RJCdTfEZLGq4326lxqaEVTZZ5aRHq
 kW1pfV1AjFgY8vg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA2NCBTYWx0ZWRfX+flJDV6l6AME
 ykroxj19qcL6EXlJg7uhC+03C0AtZV5GtC8nWQMdSjffm6LabY5bJNtX5OuVl8XtF7xV8crbFBS
 NhoVahi7ToGFnhCxLkns/MwxgkOPknbBtF8kVarCPatNuTr1TlL8dwUEE0iaqlu1kj2kpXnUOQp
 57TN9vGBPROzwVG3lCoxnyWintyG1s4+ChrynvSo0fDRDanISRlKm1aSNT2m4ZSIua+GNhww4lQ
 fgScPoUDPqRfP577w7GhEvpQmCwYpasDJtkDV6h37RIU+IbU20XsyS69J1e7G2YbXVlVoH3Px3G
 1VgVHVD9ugEALBpU0fwEavQSIMWyub+uADJMypo+W8hfB3AfOOqsQMA+1XuK+lHZX+mZSXWwch0
 p3072OWEXn4E4M72fgz3zhfP2MmFRsx8R4eGuFRMCFyLQuM35SoN6Dbl3MNyfMmntzLGmpGCitZ
 u6uzW/qOYNn7SqgpGvw==
X-Proofpoint-GUID: O1Fe0k0w_ANKw7CzwXKkT33k2o0p8Cxo
X-Proofpoint-ORIG-GUID: O1Fe0k0w_ANKw7CzwXKkT33k2o0p8Cxo
X-Authority-Analysis: v=2.4 cv=RpDI7SmK c=1 sm=1 tr=0 ts=699c0183 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=fg_Lw6XCFRazdZfdaoQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230064
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43002-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 90AEB172AD8
X-Rspamd-Action: no action

Simplify the driver by using devm interfaces, which allow to drop
probe() error paths and the remove() callback.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/platform/chrome/cros_usbpd_logger.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index 7ce75e2e039e..b0d176c0f4cc 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -5,6 +5,7 @@
  * Copyright 2018 Google LLC.
  */
 
+#include <linux/devm-helpers.h>
 #include <linux/ktime.h>
 #include <linux/math64.h>
 #include <linux/mod_devicetable.h>
@@ -199,6 +200,7 @@ static int cros_usbpd_logger_probe(struct platform_device *pd)
 	struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
 	struct device *dev = &pd->dev;
 	struct logger_data *logger;
+	int ret;
 
 	logger = devm_kzalloc(dev, sizeof(*logger), GFP_KERNEL);
 	if (!logger)
@@ -210,25 +212,20 @@ static int cros_usbpd_logger_probe(struct platform_device *pd)
 	platform_set_drvdata(pd, logger);
 
 	/* Retrieve PD event logs periodically */
-	INIT_DELAYED_WORK(&logger->log_work, cros_usbpd_log_check);
-	logger->log_workqueue =	create_singlethread_workqueue("cros_usbpd_log");
+	logger->log_workqueue =	devm_create_singlethread_workqueue(dev, "cros_usbpd_log");
 	if (!logger->log_workqueue)
 		return -ENOMEM;
 
+	ret = devm_delayed_work_autocancel(dev, &logger->log_work, cros_usbpd_log_check);
+	if (ret)
+		return ret;
+
 	queue_delayed_work(logger->log_workqueue, &logger->log_work,
 			   CROS_USBPD_LOG_UPDATE_DELAY);
 
 	return 0;
 }
 
-static void cros_usbpd_logger_remove(struct platform_device *pd)
-{
-	struct logger_data *logger = platform_get_drvdata(pd);
-
-	cancel_delayed_work_sync(&logger->log_work);
-	destroy_workqueue(logger->log_workqueue);
-}
-
 static int __maybe_unused cros_usbpd_logger_resume(struct device *dev)
 {
 	struct logger_data *logger = dev_get_drvdata(dev);
@@ -263,7 +260,6 @@ static struct platform_driver cros_usbpd_logger_driver = {
 		.pm = &cros_usbpd_logger_pm_ops,
 	},
 	.probe = cros_usbpd_logger_probe,
-	.remove = cros_usbpd_logger_remove,
 	.id_table = cros_usbpd_logger_id,
 };
 

-- 
2.51.0


