Return-Path: <linux-pm+bounces-42993-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKn+FdkBnGn6+wMAu9opvQ
	(envelope-from <linux-pm+bounces-42993-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:29:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6A1172A9C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64BD23018748
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B088434A765;
	Mon, 23 Feb 2026 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VIiZZeQ3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BBHfoLAm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621616FC5
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831668; cv=none; b=p2XgHeU3WLlrDQKssMWLKJksCnkp3YS6t5U1y71tQ4tkKuJYT24QcT+8IJ5qcW27bFRa7/PN9XjMVKB0veJTGrRlV9MKsEw7RHIDdllhpNKj9ycJo9WLetkj6D9X8MUU4Zcuo0VzxWxgxaaTzpZjjzTiuuaIo3vr2M8zVggMIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831668; c=relaxed/simple;
	bh=7mljl1U9eXffJpZ0hBAWdNAHR5m+p0KaG/n8r9LaqAA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E3epWlZfk+N471DBSRWesIxeiHsqUmvB563r42nMwDpVfVe0vkKsrSLFcRSn/4iulnq5/IYJbXsqvkDI7cjfgLh/zpUemlXYQyOueBKBqftTmZWMTp5Z7BqfWeeVL8IGM2206scVUDIiueWMf4sFrxFMcdc9eml/rraji3AXYh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VIiZZeQ3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BBHfoLAm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMAjTL2154922
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+Lif/v6jrZ/kaLcznuMV5N
	FqGRHxVZU6OFm4P/Ynz3s=; b=VIiZZeQ3woW7l8DMziY9OPKkuzrr5WNhrX5twr
	Ot+moTFjx0q5lnDv2or3HQApaGPAmGRN5kBaE9R1gOL4H9XLEJsO2V7GjrwR6KS/
	tjoF3hKqVcrtYtggls9p2aTzeYdDOfWzzeICU7aJZD7k3wBXJLhlT9QO5Th5FVBZ
	J2OFM6fMPkp/Er9l8bdQJEg3PqYWiqCuez3tlzixbMcjJKMvz9CNOy4SRJkIo1xA
	sV4vkvs2yAakQhJTZXYBjOtq6L/Ae8FSE/PS1IcJYsBKCOMJFCMns+gcLB6upM/R
	lI3Lhx/blom9t0CM8AxYew3hhZCFZeaOFLQywNLhRa9aiGKg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vukq34-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb3a129cd2so5444705085a.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 23:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771831665; x=1772436465; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Lif/v6jrZ/kaLcznuMV5NFqGRHxVZU6OFm4P/Ynz3s=;
        b=BBHfoLAmPtQ5JMdej80jtvSP1PfFz8/bz1I7YO++fS/2YwtwqK39i0BTvjV2Brfwrq
         G59nsvyPIggYWt3yBrbFyNEsSUn2gOUv7h4H43xNGNeoIST3Dth9eExGxAnnQVpow51b
         33ZC2tF590aNnHK1ctEW10kcX6NV6gfAK/S46fxtPt4q+NIRtOM8dGLbO6fvHAg2+y/+
         1qV1TAnpN0P+rW01qE1vuO4LlAY4cfl3WWyM/uCP5C/jyMHA6pP4cOndndoNMw5LjWQg
         gmNokqTCYO7lTtK6/MImRqg2RkvcierGH7i4DsB4hgi19uLRjgec6McNFeJpMw6gDjRq
         EfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771831665; x=1772436465;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Lif/v6jrZ/kaLcznuMV5NFqGRHxVZU6OFm4P/Ynz3s=;
        b=HFM/Lah+NvUmOJ4uqV1FP0AmkcZKSpdm6rVuOusTkEiEdcpqX+q2bWaBLqRYUip6wY
         PVfv9htCI6oUWgxXkOWJliFlwBpR/f8F0JmWUoCWlinpfEZJjD87sH3mt18U3aNeYpGE
         GDhIhut0oOIvm+8LdDaaXPuyiVbS9YX9jhEDw4n09m6Nwc/7UmHWl7MZ1VgAiIiELtDG
         88WraKqadldxDSntFh14LsdQ/Nnu7RqYTj1Ji00OXkDEcba7POjLhsNaZIkMxEisbwiO
         cQwwfVSqeQ3BxddTr8a/RgLcd07dt/ma8N02tGENYdHISN/SyDCKQL2p75MpcmxkCHri
         RG7g==
X-Forwarded-Encrypted: i=1; AJvYcCUBB5nKOZ7ysJ8JgxSTTAzfxB0cmk1tXAwUX+ZZDFHcfF31FU+UkosjUq4n8TtpSkZj5jysdk5Xvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyTnICRgzQXyBt72QIGw9LqFU+xwAlagpL7kbh1rxD91VosXnV
	/vXW5/7mnCTjeK6SQ8Ya7LpdMRuGRVUmo75l8SJhGf62hPwpL64KoGP0oRCivYztwX9FnAVmAMr
	3izpc+zoFLCkmJEK8nbPEin/nNJr1eJv9EYv1JPQxpu9IZUHuQ8QjEaV9Bz+/72ooRTbBfA==
X-Gm-Gg: AZuq6aLNVjZ8W0r1PgwJ9GND56sPQ0+/N1DudpcPwEJ44KIuL9YUwk16CvCPDLgo3dC
	EMTE7RZOr1eH83Biytvy4DhIJxZy0zWsQkiQ3/n567Vn7dsk9CJbH+mDz/lUcI11bf0F6pxpDO8
	geSsa69hJ0G15HenB7n2qNDUF7g6CJdqGD9xVQAqYzlgPx/MyzrzB8lz9V43IV8XtiFPLIImWNw
	+ic80qVl82fV2ZkzhnnNDmCw0mvqNWwqtSXXUIR2sSkqmEVyE1Oa8BD7fMYv4+SndhN4pIZsRz3
	HGGbpQnnBtUst564/S/FckZBfbs42SQuwU/C4oHXgP9n1huGUoQ18n4XOgTFmYHmAnPJbjk3oFQ
	ULPCCRyMtG9xFSdHPFb5sCsKDYTbJt5L3IAf6q0Q0fWbKxA==
X-Received: by 2002:a05:620a:3949:b0:8cb:4d46:7a6e with SMTP id af79cd13be357-8cb7be5dc53mr1446018785a.10.1771831665243;
        Sun, 22 Feb 2026 23:27:45 -0800 (PST)
X-Received: by 2002:a05:620a:3949:b0:8cb:4d46:7a6e with SMTP id af79cd13be357-8cb7be5dc53mr1446016185a.10.1771831664738;
        Sun, 22 Feb 2026 23:27:44 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9ff5sm18550286f8f.4.2026.02.22.23.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 23:27:44 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 0/9] workqueue / drivers: Add device-managed allocate
 workqueue
Date: Mon, 23 Feb 2026 08:27:28 +0100
Message-Id: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGABnGkC/x3MSw5AMBRG4a3IHWtSTRC2Igbojxvxuk1LIvauM
 fwG5zzkIAxHdfKQILDjfYvI0oSGudsmKLbRZLQptDFaXbssp4eHsgirslVeZchRavQUo0Mw8v0
 Pm/Z9P35gpCpgAAAA
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
Cc: driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2816;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=7mljl1U9eXffJpZ0hBAWdNAHR5m+p0KaG/n8r9LaqAA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpnAFmZkGFLhO7cbL4Sqp0/lLgGV3Z1pGEZFFfE
 0wp1vv9KA+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZwBZgAKCRDBN2bmhouD
 1w6hD/0ZJmVgKfBwm7gdyPe4n638O/Y+0/1CnXxbSLVvC65RI+b67sjIRddYF78ZDR86k0TSQ/q
 DjiUVn5vZAowj6LeTHrZRaRtHU4IZE+hh4eAQ1lSS/4NgwPBo9lQ7MI1jCAqg/hhcrMyEI1apzN
 uz6mXYcLAmYs176+CiTXgk3dZheGTTQuy1dq216FpqcPC37DNvAo9MRMMNrQphMMBOccJtUBxD3
 FVpfb3ryijGZo7GnGUR2Zl9th+Ckpj/DwAceYI6vXj/GFH9Re/rG7P/HCyXgU4IZTHyprrcN0A4
 +Fimqo16Xxk9ffA8Ay5jkNF5/dFwQpgwMaVL2UJ04reD02gmHC/ib98vWMWTn3f/7w9pHDHAREO
 P6lx3QQKk6T3RT93ubw+O1DmjEMUeFnQHjEzk3b2S24uPwigtCuuaaFwe3gKzE0RhJAa3WROqJW
 dDx5NhC+Xg1aVOvRnLui39fkdqlwI9+AymUaGv3Ywe4BuBFA+lIcaUtPr14MrB329TWkJJB4ESJ
 PI9P0pNKpiPr/7BP05GVUyC8Wog05QRUVQBpPrxGG7VNotOJv1XCvWsNbVW8DMTvYVdkjPGefdM
 gp9gsjavEO6zd1p18hW06CbQu1O3rfae5eMWQTfiESznwD7h8CdoGC1MzLglLGA/ohMND7X7f4Y
 IcMk/BuoVRa2UNw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=AL4GpdX7 c=1 sm=1 tr=0 ts=699c0172 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=5RJr-VCCejNB9LTRrg8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Dhtz03PcaMHUfsPHGoD-VtiKdLPOjqV-
X-Proofpoint-ORIG-GUID: Dhtz03PcaMHUfsPHGoD-VtiKdLPOjqV-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA2NCBTYWx0ZWRfX+tWHQOTTsQsl
 Sq3Su1qCsgq3YyBPxe/sCNPzvRYKMRfc1ViHTaePpoJ1E7g4fxt4bVkxnM4PWRrUiOuHZ9hBiPf
 9czLrjdAzBsYuH5ZUhP0Ndv6F3xt553nCH4hrnyxqv65uYZTutWnC90Xdh++Le32sr0wjr3AKWz
 mof/kSIZuYgahRERqBckGRAqrbkw70s5IaGsV8raWiTA+TpeJjgf8Ekw6dWxtqlkhvRmJEewdcH
 1AMjIesm9QDCOG32CY3rVVkatNKK75c6RuMKtxKNSs+qEMdlq7kcumunKxOMgZ3EHO4bOTsLeyV
 SwzSGEuMuboq7OguHYsc0CnHPLFG0vIyEMVEWom11aQHM7BrBmyteHXzHbbK8Jmbt5L2HdHd/8U
 zOKwqbo4VJJR1UphjsIa7Viz/K/BqFHY6MLmmK6+SKrFWomGBUD+qw0H+AfhLLT4VqeUN0pVEnh
 Uui2wKySmcFuJQq0pPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230064
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
	TAGGED_FROM(0.00)[bounces-42993-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ED6A1172A9C
X-Rspamd-Action: no action

Merging / Dependency
====================
All further patches depend on the first one, thus this probably should
go via one tree, e.g. power supply.  The first patch might be needed for
other trees as well, e.g. if more drivers are discovered, so the best if
it is on dedicated branch in case it has to be shared.

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
Krzysztof Kozlowski (9):
      workqueue: devres: Add device-managed allocate workqueue
      power: supply: cw2015: Free allocated workqueue
      power: supply: max77705: Free allocated workqueue and fix removal order
      power: supply: mt6370: Simplify with devm_create_singlethread_workqueue
      power: supply: ipaq_micro: Simplify with devm
      mfd: ezx-pcap: Drop memory allocation error message
      mfd: ezx-pcap: Return directly instead of empty gotos
      mfd: ezx-pcap: Avoid rescheduling after destroying workqueue
      platform/chrome: cros_usbpd_logger: Simplify with devm

 Documentation/driver-api/driver-model/devres.rst |  7 ++++
 drivers/mfd/ezx-pcap.c                           | 27 +++++--------
 drivers/platform/chrome/cros_usbpd_logger.c      | 18 ++++-----
 drivers/power/supply/cw2015_battery.c            |  3 +-
 drivers/power/supply/ipaq_micro_battery.c        | 50 ++++++++----------------
 drivers/power/supply/max77705_charger.c          | 36 ++++++-----------
 drivers/power/supply/mt6370-charger.c            | 13 +-----
 include/linux/workqueue.h                        | 32 +++++++++++++++
 kernel/workqueue.c                               | 32 +++++++++++++++
 9 files changed, 117 insertions(+), 101 deletions(-)
---
base-commit: bc32aa8c2aea9fd3acda58dd8a5ea6c17e9dfc36
change-id: 20260220-workqueue-devm-d9591e5e70eb

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


