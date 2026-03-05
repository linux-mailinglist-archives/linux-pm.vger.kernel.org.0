Return-Path: <linux-pm+bounces-43712-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGv+Gd35qWncIwEAu9opvQ
	(envelope-from <linux-pm+bounces-43712-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:47:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FACF2189AA
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CEE03061168
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 21:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A0833F377;
	Thu,  5 Mar 2026 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hsF3iFgZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HvXZhPrH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC835E93D
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747189; cv=none; b=tjFTL3Vu7ICSYnJsI/3SigwTslKN8FUvbyrvYp3YGzvXcd75c4x7ocDTJyqx/4U39oOfeOn4oSC5Bj+Ekj138yUgax8x8rXo6dHCDobJMCyUcUOWr1MWklg+3Lkbi21TJ/A632Z5dvoBEupfwoK+uzBcwpcQXSF1cA4c7QWCgHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747189; c=relaxed/simple;
	bh=NEUpXBPJ9dEtS2fWmU+0dR2QDjspzcgcqiZEmv2uSmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UeAZeB3baqMnCdawnhw1i6CyMzmPbmzeEysYcVmOu9g1JCqUuefdMyHGpcxQTPsY1tuvOfzzA6vIVEpRqFVVF4PXG3QKWt9eMj8ageBfGcMNqALRw9aGXnBfCl5ELlvdLPUk8viI8Xnq9dbcHn6JE+NM/3q8HEgo8+Ep+Ijhzw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hsF3iFgZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HvXZhPrH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625Kmaw91809326
	for <linux-pm@vger.kernel.org>; Thu, 5 Mar 2026 21:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pMdwalXJEavN6LV6CAE/53Eqg9eopdoniYo4PZb2D4c=; b=hsF3iFgZR3eFh6Ua
	8327APE3WHi8P+d6fNwAgOeZkBA7nU/f46nx0tJOzdK+dQl1mUb1mq1x+YiANJp0
	I1GuI4e/GaoeDdjwQb+St9rfI9y7MqWyBz4m5Zwmi6XUFeS/TwygmH++HSfneFeu
	xS/LQxdbaLeNZDvra23uALJ4t6q/5eQIIrxKq93g/I6j+0Cji+dm+0N7fr6xzTiK
	RNL3FSlM0VhToCUb5dUT0iKFOb6lqFDhv8glQwvmkyXyFgj2RHeC8McMjhTvQ3ar
	M+dNBv0iH6X1ejSPi+62L2hrLHgOQYxx9kKdsHP1E3gdJflQnXe09MMvi5DxJJbm
	OzwKJQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqgp407p3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 21:46:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70ed6c849so1657739685a.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 13:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772747186; x=1773351986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMdwalXJEavN6LV6CAE/53Eqg9eopdoniYo4PZb2D4c=;
        b=HvXZhPrHiq5MDhQ/EUWR7Xm3iP8iOn46l4sAKKvVJYHJGDg/kHQaS/+zgqjCMyo9jZ
         Tbn2X1a/m1iYjG0JKvStPrNU9/bFDYXLcJVy5qI5P8JcwExsP9y6M3wigucLeHDkj/zL
         bt+WChbpglwlEAOEZEwbSgtByOtqbM52GbIhsjt9rtm2NPACE/nlzyOhqfWqqy2Y82hu
         hbpub1jNMKpigREG7I9LyvJe9Mzjq3ofGu6nC0O4ZPs+e//dahlhqcmWEspUsHsLzKvu
         +SZ4yDV/gAVEGmVDbG8yqEWIx+bvNlUkM3LZd3AWneSsoLLTFdhojAKrAQ/ANH0C39T/
         Ehnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747186; x=1773351986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pMdwalXJEavN6LV6CAE/53Eqg9eopdoniYo4PZb2D4c=;
        b=VcZuC9F5Ox1TRy/3orLfKtYUd5HMa7DlfN/th4/k2pc3tX/3M43xJOl9JNjjb4Grt0
         d7mao6bsqQq2DdcatElnvvb/CReG7noe7dRFivLypSwMr9HU4XoV3GgHTO4vPjhxvbuC
         rT91igY6ykkX6vT4u5IjZ36nykFhcpJasA7uoGFu45mbGP+M5UEevaE891OSgr/eFJGe
         22Q8+Oui7/oXrtWCpR6xyyNi8ur88P0GH6eQTIREQN2jCJs+134JqwHUwP2QDS/r2Ll1
         HUhS2P+U8ZLTvYqaIdNq/L47WjCBKexk/7FZ4gCUs/YM+4ApGzMyNNwrLAqqIYQwusMo
         sQsA==
X-Forwarded-Encrypted: i=1; AJvYcCW5saSPCEVnAqjOm+zcahZyIpnpbk7pmTjg8HZ+BLPEg71atw8mS8TJGfHdAJoHf/I9ckJsb/iSkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRyZa0JKfDGyCVpy1f0+xQln98AD3nWZjPTvaug9BO96Kcn0V+
	OvekdCfXg5Td3C7dG7KBKhk6Nay3eyg0pVmzpp+hi5+dXoKrKj6xzHLv8I1VC+28I0s8JkdBh/C
	tatozc6f2mUNg77WhXwF8nhRPq/TMZ0q7EyOjWXRzqPc9p8rXo7ot+NI9jxvTTw==
X-Gm-Gg: ATEYQzzsuEam+do8V3HOj5elb83cJAnOcm3TQnejwXaBEQTtkDEqZ399fuhYZHRn15c
	zpltnS69aTovIULxf1ixOxJ4loqe+dSo/48AuKmPZT++BUPSmjruBZeC6lepjwxbqGWaWEbq/Yu
	61tA89sSaGyRsnMw7M2VA9WSyD1/0LEOx2Kmjjmp6i7pRnPa3CpQtNo1aYjRTGt8Blevdyp1sqN
	I/zjYiIb0yGPSHGl3UzVBFWTw0l85Q4qmNqoi3ZOOFTyS+P/oXxtdS4SGPtnDkD+gunmzGjR/B7
	K5M2FQtt+omoJFro0gEMvAoRRIwznkoYWIigLr0n9lxSIoDUxIfRn0v83qxDssYIzMlpMw1Oyml
	yfSZ8bmr/smFmEcg99NkHZpuD5JKIOx7QkhetYkoZM3g2
X-Received: by 2002:a05:620a:4482:b0:8b2:37ff:de74 with SMTP id af79cd13be357-8cd6d3ab314mr5795485a.34.1772747186542;
        Thu, 05 Mar 2026 13:46:26 -0800 (PST)
X-Received: by 2002:a05:620a:4482:b0:8b2:37ff:de74 with SMTP id af79cd13be357-8cd6d3ab314mr5793685a.34.1772747186093;
        Thu, 05 Mar 2026 13:46:26 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a58dasm28571575f8f.27.2026.03.05.13.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 13:46:25 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 22:45:44 +0100
Subject: [PATCH v2 05/10] power: supply: mt6370: Simplify with
 devm_alloc_ordered_workqueue()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-workqueue-devm-v2-5-66a38741c652@oss.qualcomm.com>
References: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
In-Reply-To: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
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
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, driver-core@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=NEUpXBPJ9dEtS2fWmU+0dR2QDjspzcgcqiZEmv2uSmU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpqfmcNn3k3Rnw/2EcuO2yaMfih5Vsn0i/XXJf8
 SvINHHZXpmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaan5nAAKCRDBN2bmhouD
 136hD/9ALKD9SvFh/azG10v3UDLkpNlFun8cFPxOsqHfB7d5jt0wLAMJR5OL/G0gbo4oAOx3rZz
 T8YEb9fJN8jqmiPiXHZV46OJ6MX4FJxGF3ko3W56lIhjR/GbgdkU4oZZOUDfJjhKmjm52JL4uri
 Ety79GYKI8agwE1+zQxflWbPZ0ACvbgpu/gSfA1+uImrdNmJrXxnGczTKSzc6/cwKvrfFhRITfK
 qugeeHB6FJX98OI7B0/y5V/PxLS6HhXfQb28TXxpfHaQi2Z6At+ql1/SaeFX33rIq4NSlV1Z17x
 2AQUKGzGhYSQBFE9p/BHznlYMN4+YUsSpkilQJq1FLg50apjcVXWhbRdDTU/QlgGwiy/qn849+R
 bTeGbErLTERXzbcUgA0JDy01bNziJyp3zcwACGBgVCoc7HyfY1C+ZrrXs55ou4ZUTH74eX8e/75
 Bsj6LEgkgws/j26GPyEqX0tUEoKn4KYjr5vjMPiT3B4CjRnm2EIMQA+hd3eVIDLEF1Gx73S//O7
 P3uykwrUAg4/KbdSlO4x8Y0oZekuMvA0wECeeIsW6nBX/GLqql/R+MrycZ4s3CzNoILTJJm4VGq
 aqUNQtFjSZkEGtycfu9T0VqpOY1quTm3MSUX/d9t7UBo0mj5pjjRuYFEc0K/+Auqy76BT2ros/w
 1z93nTbelAT8enQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: m-FiqkxsmiY2u434OT4uM2S8AScWjiPz
X-Authority-Analysis: v=2.4 cv=LegxKzfi c=1 sm=1 tr=0 ts=69a9f9b3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=3EgDlKgDbQZu3HAsDPoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE4NSBTYWx0ZWRfX7sIycQAnNKPc
 aRgd1mYGM58BPc97DguUQtjz94FI69OIk+aqwwTLbwmzfXdKfqb7z4Q4kGatZLkKNwXUc06ajYL
 p2Sz2pv2W+6ZdjtERlA/tUvQti+kTUnP0Cgdrq/82mXyVSFZc/XqhkIhMPGvKI+fHfhjPQroPQn
 lmq8wP9mumBq4dA1htoyGuly5xW109tgGQCKavqhoF8SkKD0mVrMBaMN+ffBxz4TrrWH2uwvIR7
 532DRih7x/8OTeZyKFgkWDGXPmHnVurAddG/hCr2azzWWAYAYAVRbZeACPI0yhh3uCXpYUVlUN3
 2m5Z7xuBjX5X0GZZeVOIvOjnklTiQ23ZgxbPII4a2uLYXMSpraELlAbulCBSoZHAKxEO8N2qq+t
 PGdHOzDtoQxomOBzEhJhFfVIAMHlJFr+7dSaMnJxfUUqENd20teErrf73qfNY9RQl8I+wmNnYdL
 p7W/NqGyjsWEtvIzehQ==
X-Proofpoint-GUID: m-FiqkxsmiY2u434OT4uM2S8AScWjiPz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050185
X-Rspamd-Queue-Id: 1FACF2189AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43712-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,collabora.com,lists.infradead.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Simplify the driver probe function by using
devm_alloc_ordered_workqueue() which handles the cleanup already.

Change is not equivalent in the workqueue itself: use non-legacy API
which does not set (__WQ_LEGACY | WQ_MEM_RECLAIM).  The workqueue is
used to update power supply data (power_supply_changed()) status, thus
there is no point to run it for memory reclaim.  Note that dev_name() is
not directly used in second argument to prevent possible unlikely
parsing any "%" character in device name as format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Use devm_alloc_ordered_workqueue(), mention this in commit msg
---
 drivers/power/supply/mt6370-charger.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
index e6db961d5818..916556baa854 100644
--- a/drivers/power/supply/mt6370-charger.c
+++ b/drivers/power/supply/mt6370-charger.c
@@ -761,13 +761,6 @@ static int mt6370_chg_init_psy(struct mt6370_priv *priv)
 	return PTR_ERR_OR_ZERO(priv->psy);
 }
 
-static void mt6370_chg_destroy_wq(void *data)
-{
-	struct workqueue_struct *wq = data;
-
-	destroy_workqueue(wq);
-}
-
 static irqreturn_t mt6370_attach_i_handler(int irq, void *data)
 {
 	struct mt6370_priv *priv = data;
@@ -893,14 +886,10 @@ static int mt6370_chg_probe(struct platform_device *pdev)
 
 	priv->attach = MT6370_ATTACH_STAT_DETACH;
 
-	priv->wq = create_singlethread_workqueue(dev_name(priv->dev));
+	priv->wq = devm_alloc_ordered_workqueue(dev, "%s", 0, dev_name(priv->dev));
 	if (!priv->wq)
 		return -ENOMEM;
 
-	ret = devm_add_action_or_reset(dev, mt6370_chg_destroy_wq, priv->wq);
-	if (ret)
-		return ret;
-
 	ret = devm_work_autocancel(dev, &priv->bc12_work, mt6370_chg_bc12_work_func);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to init bc12 work\n");

-- 
2.51.0


