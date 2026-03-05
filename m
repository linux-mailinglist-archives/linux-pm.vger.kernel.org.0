Return-Path: <linux-pm+bounces-43716-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMZsHRj6qWncIwEAu9opvQ
	(envelope-from <linux-pm+bounces-43716-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:48:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7FF2189FD
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C4DC3077F04
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 21:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E7C33986D;
	Thu,  5 Mar 2026 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kTDsn66d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iw+MAwFt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354E235F5E8
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747200; cv=none; b=kK/AAObYC23KAcsA5hRY74gvg7OgdMk7N+Hvpv5xtQFVELymsPTOjg8K+hERGwqOCqMYyNln3RV3waCnHB6WU6I7VKl4Qx7AcEm5ddedp2zHhLWtjYj4AXJSrmWwum0/0zx6mrlQTzP2reR6OqKwLghLEQKVmBNUdLUqcmygwX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747200; c=relaxed/simple;
	bh=8HCvYehjmNIH+BlrLf3/jZA0T/6LceXynB2MmBf1YZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NX5+ndZ2wIHth2su6TJy+VQ7kklTlTYvDIVdlMwwycDCoVH1GgGWJ3l6mRmGiV0zehrVAmGx2j/8eqlAj2Tf5WBqO1B5wdr0GKN7u2NKdgQyie0c2BP9GGsA2aDIaQXrrR9a15qd2KbjS6wCxyclivoe7kcvQJ1K0znHgfn8R6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kTDsn66d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iw+MAwFt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625KmXeE1802697
	for <linux-pm@vger.kernel.org>; Thu, 5 Mar 2026 21:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xF762MP0D0x0cXFJ11pLhifB9krYSxT1GrxhCZLRMoE=; b=kTDsn66dim843s3x
	bzoXPIj8EMMuopwYjRQyxsAK0/F0JrLLNjwqqwjHiYKYbhwfPNhqEV4WSOKJTCUw
	8oRKJBIWpwqKxNHZ57CpnugwbQWqPa5aSY2ouGRwOTL8lVMY7JpN/Y+1wNYXwsZk
	q/ZtWA4mj04NpXSgvJwO18yHZexy5y1y+Tj+Fzp0aTNXH93IRWMLAetDFFsYR4U2
	Hpbx66OeSEqYiZt20rz+ClqHIZThDHpoZ3Ovg9QCfci4I6W4FyKD5qPoLWMoyLGk
	x0hL5k9uvxjBs8nNVHiSI8VkubHB0rMzXHqth4SYLMXk9Lp7OmDgRmKB3vX5TH+e
	YzxRLQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq9srhtm7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 21:46:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb6291d95aso1095622485a.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 13:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772747197; x=1773351997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xF762MP0D0x0cXFJ11pLhifB9krYSxT1GrxhCZLRMoE=;
        b=Iw+MAwFtwtn01o89VfGifuNKDWIg5menGKrWeOY93H8vswHh55pMb/rSkLRH6wiR9s
         hmiZ5jB70OWay0J6sOEzLHNj+qZhgr0NOxwAPC+bYftZ0V7SmIOKTili0gHxJBW/EfIY
         57odzEu0dpMhwTU7Sgxdh8drEZSgrOtSsrXEALSrYe+ZOSnXJFZAWZhuzJHbOeimzIw5
         4ksZMbXwjOf6RaLqPexMeTMYXwqzz50Q1ONMYxOaPoOBJeQmlMjV16nn/eC1QjLj+sIP
         EdLOOqaIMrpjSU1SaAPfJrq6X3bO9cwKgjV6zt4oP5/mzN0tn8GU73Gj+TjUjwrFYX1w
         NpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747197; x=1773351997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xF762MP0D0x0cXFJ11pLhifB9krYSxT1GrxhCZLRMoE=;
        b=ZkZxh1hRDb39C3997ABHTjK22E6LU6eefjfeE/IOkiKkH0IlhCiSH5VL61+OQ4lcvM
         9EUsGxwY0u32fciaeF1S88/Bk9414AxFjgxyxY+jaeOh8O8Y1qOIfBFQmXPDsgTb3wnJ
         fKqSmk/uhqpLo3D+KXLrmDYS/NpprYPxbrKnuP3rEwRH7tmC9GD+R2T59fPpY/phipyA
         bbEz7eK3QZ7bQqPR7KYNnodeAlXq97Qzrbc2Q45yjVi0BEOzfwrGAbfICAQJCUHu4svF
         jX/zjqMWVNKgfoeNeXWRJZgd7Zz3a74mcJ26c9OlshGl2wmfpg6M8RJusD7WCTV0IqtJ
         x7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzKqq3L4SqhnrCXusGTJy6MZhzvqeK+b7vvRURsNfkpgx2biEkYqM37zrHauEonUhqwECP3q2pxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuUXLTQBmtsPMN6EtoYpvKbdjhle3/Gn7fKE19/YdDftrhJXpZ
	ScFFs87kW1Ip9HmIZuWbCy5h5NdaWfztI5odl5lqcyzirhE8i4h2v1o8sC2OCwdqb+vktDt98HJ
	qCpdo+rSR+WIyq8MvVXDYzmA6kZkEvVxiDq3RPTkKpmuk4lkoBM76iIt9yGkXdQ==
X-Gm-Gg: ATEYQzxy1Tse0Wnmf7ImZywxfQj6Gsb6LBbrSl09zXVZ8ksaTjsPhoz4OsYXK4XuxK4
	rsQHTp9MYfujymz2dwjiIW1cr5J3yWQbRBBI8v6p/1G91Bhw0OeYq5/ugeWNEezlrnBRsXKzqLl
	WpOv+q+I/AikAGWKr8tnji7AV3LG0BdIwTxbeHR8ag+6TeSVbLM9M0IWVFB02Kh2fzcFFHkehpO
	qRW3AC1cgYzSKgzwc/DuuQSREHVLghB9NYclmktxgxFEkx6z2zJ29clh924wd5V5bPfBSKMYyfk
	6fAcMZYYD7kEFzH0ucXMFBzNtWjL3m4leRMjtVgW8zp0SxdDQi1Mxk/YGxfy+CfdPT552YO0RD3
	Kj2VC2TiB9gEx4alVcKTztxGjhTt1TwTPyWV865YZ+16L
X-Received: by 2002:a05:620a:4687:b0:8ca:3fb7:2570 with SMTP id af79cd13be357-8cd6d4cc0d0mr1696185a.42.1772747197566;
        Thu, 05 Mar 2026 13:46:37 -0800 (PST)
X-Received: by 2002:a05:620a:4687:b0:8ca:3fb7:2570 with SMTP id af79cd13be357-8cd6d4cc0d0mr1693585a.42.1772747197119;
        Thu, 05 Mar 2026 13:46:37 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a58dasm28571575f8f.27.2026.03.05.13.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 13:46:36 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 22:45:48 +0100
Subject: [PATCH v2 09/10] mfd: ezx-pcap: Avoid rescheduling after
 destroying workqueue
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-workqueue-devm-v2-9-66a38741c652@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2299;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=8HCvYehjmNIH+BlrLf3/jZA0T/6LceXynB2MmBf1YZo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpqfmgTLUiHh6rin6gIR8tn/yHPbJ7keLcVF5yZ
 GGBAe1ny7CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaan5oAAKCRDBN2bmhouD
 1+A1D/46IEOXU4c7rCB302yiUbZqrN3J0Box+FRnliJ/p6E8EXiDnmOg4obwzDlEUpFEf7ibEyq
 GYEw9cFAKDrszgDdGRbIFVYHr8RFOirL2Hdrl9Km81dPKqBQLXZQWnvAIKZe4uFGm8rDEiTS3FV
 gXubYix78Obr5LtZTm+Tn3H4VlOmRf/a1n/SAYakf/wp8btHWAgUY7J9nNAMK2Lbwsc4nzYJoHi
 vZbjtyC/9Gclm/CRe1O8vCpyJktvnNgAqHtQ/jojtr4XybHQF965vKIWwvLvoJBrhi2yylmf/EG
 S8CxeogMKobJs6UveopZ0d5TANJ1DRYacznxvzG9KA6g6X2xQKhxgYl480SHuTQMwdI5ygPt58U
 YlxL6+Ij5kO4Fz14qrhXHTZ40edvx0sQflZMFPcB4RVEyHUSnt2upCd3xRWA+BtmXbJ3NVnN7YE
 7JHqzNSdItYNG4lO1wHyEOQRHGJ6KLMq+xqetuC7XXGt+e2iAroOx4ODQ1itWBm9mnLq0brsQkX
 aZkgptRJCcNG6nj6JfVtXI5u3cZGNevrxo+gGHIhTsR2iQROE0tCQbAzduBnKIEtq3Pm4AyCrGB
 GzbjoRK4ad8uW8GvCPBi00G3EXVvoOWPBuOLeQPVp8BuTwkTHYs7DVw1wsrnE0aEKQYge+pTQo1
 a1ws7+4oKjEY6DQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=a/I9NESF c=1 sm=1 tr=0 ts=69a9f9be cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=3MYFky5D01qQmCoSdzEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Zp1o5t79hF0F86oatklmVPPHaXQ418uv
X-Proofpoint-ORIG-GUID: Zp1o5t79hF0F86oatklmVPPHaXQ418uv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE4NSBTYWx0ZWRfX66s34uR2JsRC
 0vhji8qj9Jk905gdwsMMBqSK+aTdjgedQe1R5q+ykQBuLdyXkfSzTwFWUSJdEsuKRyplFnC1PMO
 olIHdHA6lhKtMg3XFwqWby5axzIBxhWw5lo0MhrCkVbjLSfvCGd0H30w6DfQfGv9vpaTiIIre/5
 vPxWipAWA/hJtJllD23o4ZqoB8u6UByg+mv7d0zxVrPSF/tBj0KOmvAoL2IKwcprRFD8k8ddHyg
 w57Mcr5NMnFu459W7/GeBo9cuoTJ8o48JZ4OvShsgVxfvt/tmGkuK4tTYUjRwOMOlkYQmkmyFsD
 SZeDmVCPwh1BgYWrartTtTqAIrqixEB+/DfTlkPM6C0RUkjnAaXUl9ztNRRBKnSpNJGZUYtfPV+
 +UTGD8iH79QZvbiCtPC1PYg4MFshoGTXMPvRHQEb85pGMi3mhkust9UnJimc/7XMTejsGQWJoqY
 GR7+T3rfN8UbL3+BU+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050185
X-Rspamd-Queue-Id: 2E7FF2189FD
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
	TAGGED_FROM(0.00)[bounces-43716-lists,linux-pm=lfdr.de];
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

Driver allocates workqueue and then registers additional interrupt
handler with devm interface.  This means that device removal will not
use a reversed order, but first destroy workqueue and then, via devm
release handlers, free the interrupt.

The interrupt handler registered with devm does not directly
use/schedule work items on the workqueue and the remove() function
correctly removes other IRQs handlers, however the code mixing devm and
non-devm interfaces is difficult to analyze and read.

Make the code flow much more obvious by using devm interface for
allocating the workqueue, so it will be freed with the rest of devm
resources.

Change is not equivalent in the workqueue itself: use non-legacy API
which does not set (__WQ_LEGACY | WQ_MEM_RECLAIM).  The workqueue is
used to update device registers, thus there is no point to run it for
memory reclaim.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Depends on devm_xxx() from earlier patches.

Changes in v2:
1. Use devm_alloc_ordered_workqueue(), mention this in commit msg
---
 drivers/mfd/ezx-pcap.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 8e51c113a320..9a685ff8cd15 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -375,8 +375,6 @@ static void ezx_pcap_remove(struct spi_device *spi)
 	/* cleanup irqchip */
 	for (i = pcap->irq_base; i < (pcap->irq_base + PCAP_NIRQS); i++)
 		irq_set_chip_and_handler(i, NULL, NULL);
-
-	destroy_workqueue(pcap->workqueue);
 }
 
 static int ezx_pcap_probe(struct spi_device *spi)
@@ -411,7 +409,7 @@ static int ezx_pcap_probe(struct spi_device *spi)
 
 	/* setup irq */
 	pcap->irq_base = pdata->irq_base;
-	pcap->workqueue = create_singlethread_workqueue("pcapd");
+	pcap->workqueue = devm_alloc_ordered_workqueue(&spi->dev, "pcapd", 0);
 	if (!pcap->workqueue)
 		return -ENOMEM;
 
@@ -463,9 +461,7 @@ static int ezx_pcap_probe(struct spi_device *spi)
 free_irqchip:
 	for (i = pcap->irq_base; i < (pcap->irq_base + PCAP_NIRQS); i++)
 		irq_set_chip_and_handler(i, NULL, NULL);
-/* destroy_workqueue: */
-	destroy_workqueue(pcap->workqueue);
-ret:
+
 	return ret;
 }
 

-- 
2.51.0


