Return-Path: <linux-pm+bounces-43707-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIGJFff5qWncIwEAu9opvQ
	(envelope-from <linux-pm+bounces-43707-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:47:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A782B2189D0
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 22:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D33830680A6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9E354AC7;
	Thu,  5 Mar 2026 21:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hmyWobAZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B76ICPnm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35AE30B514
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747177; cv=none; b=k6v7S8UBDCI83HosGSPoOwjkTnGVby9MXTlwSctSrwWbRHMCuA6+kdo0xBZz/QwWzZNaQRR58s+ZnAcdez9nn+XNJJt+irCiK7jjM3XEMYtd2a/J2EaVo0dMMz8YPos/BtPCS2JDairX+Ha5BaatWhMjcGpztxSHLDHp0zKZYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747177; c=relaxed/simple;
	bh=97oQa5AwjxFqQNenF0OHDjBYeqUlG3QZw9SpgqUFg/A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Twjj0tUJdcOLYp6HSDeZsjwMa+rPMU1IuFJy0hqXq/cjy3F2jPOcdmuDiY59mOLNVfy/iVIsT66BEqjKKSSL6Oj0BWPlqMaCb/EXhUKHCV+dfp8zt4bOOvLjxG1C+JyaM7fBTFeze9tk8rFXrx+060rvpqEsiXjd12U88bCeFSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hmyWobAZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B76ICPnm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625Kmael2267229
	for <linux-pm@vger.kernel.org>; Thu, 5 Mar 2026 21:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=aB/qAvAOoxaYoPHOVqo1Lu
	xW1bKORstF3vnraKsztao=; b=hmyWobAZWCng67anBwjrdkpCiiJKDGm4+8AGJW
	HAs/GpY604tzpYZzSSGi8fBcsyUux9Y0TM1Jj45Y5UbASVkd7wSKZ9HgParcwsgl
	7aTjFNtjiDogZGpPpaaSO2u4Y+AYob9kAR1rbNKVuoHPBRL4wEuOZY73I/elXT1/
	68GdSedWfLo11zCR8nnmW781X/UZRaL/wGmARIkiV31omtZLyIM3wBhQAKjiCTRN
	nujZ+jcQlLeuFeATf2+Xp+84QtjJLVBBdncDMYKzfna7j8Y+LDzUoEDmjrkmKRRo
	Vo5hC9nRfjlTo60Y1kO02bvehZ/+xDnPEog1IqAjlxW/ZkSg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq380u80x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 21:46:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c70b6a5821so4172820685a.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 13:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772747174; x=1773351974; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aB/qAvAOoxaYoPHOVqo1LuxW1bKORstF3vnraKsztao=;
        b=B76ICPnmmjOjhQDwdUSnop5vbde2MMwr5KaikI80e4uAMzgXP2ZU2v5OZbYAxkZmqr
         n55AgoeUkmYyd1NGkeqgHEVttYura8s/5XdDKspE+4R3DahUMrB1+c7OKfDUXcrDcjeZ
         37xh9KVNk6mxbgJUPo5Tpmx8fAgvatc1DsNS9UkJAIYsvypUBtkGO5V+IjTKqpktoBAz
         QIHTG6S0EyvDDYUJIyYC2PbeBDbJNYz+aDgWTQLemvgujU3yndDNnvPUyOocKoEv+vba
         RjLnIYHh1ZGcO0oEBia83bYRuYxAxNE6+K7tDvzPGh7Xmo0UqTWzZQ4bJdv9WUq7Asgr
         QJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747174; x=1773351974;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB/qAvAOoxaYoPHOVqo1LuxW1bKORstF3vnraKsztao=;
        b=EFkeiXN/X4t1dTPaeb+Io8TzSw/Z4Sq1xfr18egPhuGuxxNK5drbDaO69RbVzxMbXv
         UBHQ8qLnWE2CSDgyYsuY1sWG2axDHBK5GGPvmr2AdHoFMb1AP34+brEmY5qIT6uDRe96
         CH/zanoc0gmQLCKBaMVtVAbnbdsCl3B7WiUHIHqiesKOLiYPMoeOri0SBoouvhvq3R8u
         Lbsh+E7VQ25ZanFfUAWgQtwEveklOI0PK3laKv7zIUNNGZeRltxEtY8hnqUM+Zj3TM/G
         jCtO2nsITKDbE/EF2O/NRUTiicyKz+36l0Jl5h7pz3LWU0BKPNaOmrnMVG8NMrhLtEdq
         kVpw==
X-Forwarded-Encrypted: i=1; AJvYcCWR1VRfnfY4ZPSZEMQjG7yCn9fEyC2bpLi7Tn5V92AGtnQJsu+2sCAsuNTofXmOGzYlRs6uzwcMGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtXpjcYhdOXEiZt11AlB0a49MZPOlGwKmSJgIyS0L96oH1tfXm
	jFQCqark6HL0l+75/0fMBnUVTqM+zJg7vmVR0oJvDozmP2+ZVyqyWiJXuc6rc4WPV25v6lGwVuw
	DrmdXWPiiRf0DLgLjbeVxPGuPkN4HAQ+J9Maj0TUNx3m0oIWW2Sjpm0wfucuJyQ==
X-Gm-Gg: ATEYQzyDsQXay3I5J1IhsD6VRRmhLzN0TNEFQ9JdJa5r2XOdp5f+jtZ/LVchVIUl8BM
	eseVWDzZyuoHjHdocxyoOCiFS6uIOgn/eWqMxpDU0pRM4N+zo5XRryXypGAQm3JU2z689DIxX52
	1ilwY9szYuGYOOYYQeNdt/iwbmsAPdB1TMHxwwjP49Vak0iRf/1tdk2+rFy6SRAvRPijzwQsIIv
	TTN7B6ycOdaMxS5qdQlkUYXcfKNpRZfDdRljG4Me2EKUPTrlkTICp9bojooX8wKSrwDARwo6+k+
	DX1SgWoDZ19rgHw9mybwUJ/gTlMi+j12L60EjcxIs0JJA9v7Lp//HNG5+z7f0vunoQppB2Mulos
	53hsMbWJLkvLhhOw74hQK8XUbLlh8nzIhnlw+tiUEM0cp
X-Received: by 2002:a05:620a:f0b:b0:8ca:3c67:8920 with SMTP id af79cd13be357-8cd6d515328mr509185a.69.1772747174155;
        Thu, 05 Mar 2026 13:46:14 -0800 (PST)
X-Received: by 2002:a05:620a:f0b:b0:8ca:3c67:8920 with SMTP id af79cd13be357-8cd6d515328mr504085a.69.1772747173657;
        Thu, 05 Mar 2026 13:46:13 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a58dasm28571575f8f.27.2026.03.05.13.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 13:46:12 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 00/10] workqueue / drivers: Add device-managed allocate
 workqueue
Date: Thu, 05 Mar 2026 22:45:39 +0100
Message-Id: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIT5qWkC/13Myw6CMBCF4Vchs3bItKRcXPkehgWXURqFQitVQ
 /ruVhI3bib5JznfBo6tZgfHZAPLXjttphjykEA3NNOVUfexQZLMSUrCp7G3ZeWVsWc/Yl+pSrD
 igriFOJotX/RrB8917EG7h7Hv3ffi+/1R2T/lBRIKarMmp7JQZX4yzqXL2tw7M45pPFCHED6ua
 GndswAAAA==
X-Change-ID: 20260220-workqueue-devm-d9591e5e70eb
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3030;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=97oQa5AwjxFqQNenF0OHDjBYeqUlG3QZw9SpgqUFg/A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpqfmYRxyzCwJtuMtPcmgwwLLBsg2Fv+yT512eQ
 cjU6/+PRz+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaan5mAAKCRDBN2bmhouD
 1yMdD/0Rzss9RkGRF5nKqvTWC/cgAO+EIzsrFPQrQxvOIyduZBpdUjVFhj4xpZwybjIg8hJkNWW
 xK4MLqpSkM3FPPTnPvx7URqpkHMVFAzZpYFTxJCJaEg2QNz883y7WzgF3wPnB3nTAZGTD6SkHiw
 7qtwhrzLR9KZ2RcmBf4P+zbHd6MvF/NjWgpbHf6/JHoSHF3D7e8fX1iWFI2fcYFTuoMLAXE0kD0
 DIJlbme/ltg9kAdbOfpnduvC0zZJ9DenyqGciETdu4u3+pyFeaL6kqJ+ncBGCmHcPyzVi10eaI5
 1dNEaW7ewsE+9TQWQzObBBWmOjRQMHGxEdeZJeToxploMKivPdWsBXLsBA/1EqqMTztOp4L0SaH
 urVc6BYdSEDLI/M5jCBPYAga+DVAfmKi2usRylz7oQm4fKCHHnfFty7UHSZPRkCNWPLcfdbKzUO
 5APGiClU7Lywgs35JbsNVrQ/bbXCjr+OyH2GoywqdFYNVQCmWzPbC/jdoEUPIIxI30hwJh8zG6B
 AM/3gg2VMporqUwUGLbaU2n5xY9zqlaJp+XsX9ghJgrZ0s5KuNb1zKhcVBFvwBgu9BObHEqMWh2
 xZ6pVDucGWY+fjqjq9elSwZ62SlrH5fyl+6CUcVJB2JSFwyaGA933iHQU0q2rvQlDwbd4FJ/ElD
 F32GZygtedFkMRQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=I5Johdgg c=1 sm=1 tr=0 ts=69a9f9a6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=5RJr-VCCejNB9LTRrg8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: JfUHI-8ARl6iLwY6iyIWnw7rmMyiqXjg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE4NSBTYWx0ZWRfXwFGkHDIavMjK
 EMCaXJRBPuX1G75uqNRy4MBjANcbOAO685FzQt2ZtCZhx63i/Na5O3NrMZO3W0/7kRBF77SCGtU
 IcyeESRw+90KlLPF+fKQfqvxElL42ZX0SBWehjk8kmNor6qM83Fa/1FSuolZ3/a3RyDVpsHvA1d
 1Otw6emvv0bwijWp8BNBKS9oUNReCM0AgmsX8EPG9Odaxg31M4nNiQeo7xHsmGs2RSwhrdV+11X
 I7m5I4ucvgTnkJPyGQHeZ6A4oBwZ4KWB7Dq7JiXIH8V06SPIGyTeZN1lF24iRnNtZRo+ky+0+w8
 1/mNOSrSgld8/6CrexnHOgYDm7DPOfDilRFCKafsHLIt/S9yn4zVRHI5b4GJJXPhNPjDKh5EeHl
 j7WIFNkxHwYH5GpPjzLkPHx71e32AXfaOax0EXdCy2ypXCWBitl8c5JBZZDmRlZ0VeAcMjjUHI8
 B4zXG/2nngu2COdfmAw==
X-Proofpoint-GUID: JfUHI-8ARl6iLwY6iyIWnw7rmMyiqXjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050185
X-Rspamd-Queue-Id: A782B2189D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43707-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,collabora.com,lists.infradead.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

Merging / Dependency
====================
All further patches depend on the first one, thus this probably should
go via one tree, e.g. power supply.  The first patch might be needed for
other trees as well, e.g. if more drivers are discovered, so the best if
it is on dedicated branch in case it has to be shared.

Changes in v2:
==============
- See individual patches
- Link to v1: https://patch.msgid.link/20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com

Description
===========
Add a Resource-managed version of alloc_workqueue() to fix common
problem of drivers mixing devm() calls with destroy_workqueue.  Such
naive and discouraged driver approach leads to difficult to debug bugs
when the driver:

1. Allocates workqueue in standard way and destroys it in driver
remove() callback,
2. Sets work struct with devm_work_autocancel(),
3. Registers interrupt handler with devm_request_threaded_irq().

Which leads to following unbind/removal path:

1. destroy_workqueue() via driver remove(),
Any interrupt coming now would still execute the interrupt handler,
which queues work on destroyed workqueue.
2. devm_irq_release(),
3. devm_work_drop() -> cancel_work_sync() on destroyed workqueue.

devm_alloc_workqueue() has two benefits:
1. Solves above problem of mix-and-match devres and non-devres code in
driver,
2. Simplify any sane drivers which were correctly using
alloc_workqueue() + devm_add_action_or_reset().

Best regards,
Krzysztof

---
Krzysztof Kozlowski (10):
      workqueue: devres: Add device-managed allocate workqueue
      power: supply: cw2015: Free allocated workqueue
      power: supply: max77705: Drop duplicated IRQ error message
      power: supply: max77705: Free allocated workqueue and fix removal order
      power: supply: mt6370: Simplify with devm_alloc_ordered_workqueue()
      power: supply: ipaq_micro: Simplify with devm
      mfd: ezx-pcap: Drop memory allocation error message
      mfd: ezx-pcap: Return directly instead of empty gotos
      mfd: ezx-pcap: Avoid rescheduling after destroying workqueue
      platform/chrome: cros_usbpd_logger: Simplify with devm

 Documentation/driver-api/driver-model/devres.rst |  4 ++
 drivers/mfd/ezx-pcap.c                           | 27 +++++--------
 drivers/platform/chrome/cros_usbpd_logger.c      | 18 ++++-----
 drivers/power/supply/cw2015_battery.c            |  3 +-
 drivers/power/supply/ipaq_micro_battery.c        | 50 ++++++++----------------
 drivers/power/supply/max77705_charger.c          | 36 ++++++-----------
 drivers/power/supply/mt6370-charger.c            | 13 +-----
 include/linux/workqueue.h                        | 22 +++++++++++
 kernel/workqueue.c                               | 28 +++++++++++++
 9 files changed, 100 insertions(+), 101 deletions(-)
---
base-commit: 9739e59909e70058fab7a131d7bee60d447ab732
change-id: 20260220-workqueue-devm-d9591e5e70eb

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


