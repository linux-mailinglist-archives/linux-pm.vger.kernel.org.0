Return-Path: <linux-pm+bounces-42995-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ERMGnwBnGn6+wMAu9opvQ
	(envelope-from <linux-pm+bounces-42995-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:27:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6AD172A45
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98F21301513C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7201534B186;
	Mon, 23 Feb 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P7e0PJNi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kbxW0qlV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F034A799
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831672; cv=none; b=pSqJwohkoDibBQ8XeCP/TEcWZggeGs/i7NcAPr9xmBpF1NOKIw+dQQhcrY2vvokieqc1EG46iov31U2VXZfqFNkgOQfxrcRtBYmbHDEpXW3auwEMU6GCsrHmQkWv/D7EeOwizpjAe7vgDxmvf/6Wtucf0UWnJyM+1jnZf4tEBv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831672; c=relaxed/simple;
	bh=H4Qs2JkZdWI+ycAqQDT56iXbPAaAVIJgWc4JAWD+760=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i/XUHX5P/3CmMacplx05w8F/rj6iGOXDZejQeBbQdDw98OrLe8A6tJdVwuqUPNEsCeqTl+/jB+J9fIF8FESeuLrcqPiZfbStWUykGJ9t2YsT6zrtrBVymv2ZcmGWkwmAHfhnlRbQI93KMyJB91xde5Fx93Ga/pOePFZABsrgjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P7e0PJNi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kbxW0qlV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MLJVN22608680
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VRA3RyVyVxbH2SrEeG1JLyYKtVz8CEHlktSTCViEaYk=; b=P7e0PJNiKELxPETZ
	Awfd2x6s3dW2Ylcim2o3xqoz2thYA5k9ocfgidH4deTBUZaahdXtPDtZDGwIPiao
	f8EizRfXlZIXjA8p3hy9D+vFKPt6tgzMarQRAUBPNm7kJyv0Tvd/2xyxJQ8mdP/C
	OZYeQ+DA5RPkIWFqd01XZnueIN3ZDeRL6Y6yilnH/UA/vPixzT5LxVhdwnhsC32o
	nyrtRQ7k7rwzahA8RX3iQd8H+GZIpTAspfrKBGvVk3KUZFGdr2+NRx4ddgzrBVRd
	jEZmEgqbMC+v4M42eSCtBWNfGk5P95Q/CT+OTkxjyIg7IVTdCtrqHCVXf1MTiDZ/
	VbN/kg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vgusmp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb0595def4so5198405885a.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 23:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771831669; x=1772436469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRA3RyVyVxbH2SrEeG1JLyYKtVz8CEHlktSTCViEaYk=;
        b=kbxW0qlVoks5HxLHcpLxM7SjYzolyHOGDBGluMi0IBzt9MVwfpPV1ZqYnZOH7FlSvk
         2tp8/gX0pGu5+MsijphXCnBaAcZq2JfRtYIE+wNXGmMaMNY9aTKvOp8l9Lab1pkdEWOy
         H5IAnRZvnHtfMVnJl3191RD+eXCea98ADAzwp4yjJYSSZrskkScWe/ydQcf2AH7GpvzJ
         FjO3ThGy5ZRh2jSqUTFHtT2Bh9PCr86yBJCg7u8oVoSjOWwDs0qvzLONbiBGoE+2rwfN
         qchfunbU8wqvMij9zta0Fz5N35x8xr12EqKJc/CnMwme153/v2O3pyzrYPda22BIcWdf
         g7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771831669; x=1772436469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VRA3RyVyVxbH2SrEeG1JLyYKtVz8CEHlktSTCViEaYk=;
        b=cQHU/t+Eqv9QRRxsRbi0rIOk95GWcZLLAuK6xUMghqmyhbf2V48TOh/RvCe8m4OeVb
         AVW2hQS1FJw4TDAT3udf2n6sI2h3pSft1SfDo2LlcqhxTYzcRmLE5YwL9C0beA2bQyP+
         g0a8Oy24EfRuLRV+cmDLs2SbgcEthL+BC66fRBlAg0vKwA7yAXPUUI0VT5tIXkuHqorm
         YqD4Z55hAD32GQqMfaiupKu115zOPEFLJnctPC/pCXUVrz4aOgTP9rw4GQkYScAxAKq0
         mLBAoAIVmMNTlj0oRZqnztBaWh0Ioip/WrpwoEgze6QQAXdSkih6jIEzjbueeP9u3wPm
         9YhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB6EYzSKWvRSZZmDeiXTDKf7XBf5tPQcxDdLa8k9Fw1olruM4Bcr6FLUOUal5D1th2aN+/54TD6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08pHJSkp4zZMii9xNJcuQYsgOipG2FN2+QVELfWAKGfGEo72n
	0VVT9KUzkZeowy8XV9IFKjDyqBbgdTkIhlFjdj8nl0y28/GUejh4mCr4PbXGvFdSe0cMhMy2abG
	d8Nut+3DcEfo3TlqDijlaaSGn7nD4Fj1tCbvoQJ/Lp3cqLpMtbsgo+8uEF9kS0hi4V9hKbw==
X-Gm-Gg: AZuq6aI78xXVdMKlg0Yp1ADYrmUgezwfiJm/KIv/bKZuvI0ywAzqinnUYydSgM2oabI
	hpml+1Z3B9x0Jrq9mByi911UkQY8h1URCRyG+8M/LDBTdwITxPNwU1eBL5zk0WDTJ1lXgt5Az6b
	KQrb/aZS5gqHsTHW4GUiJuB2pEpy7tYSGnAQTFR/pnFKcX3GzXB/wC9icR5MuMjavAANXovoul9
	/zIbl6o8kf1+VQ5uHrJbqH604dW789D1QkjLMBZOPw1w9ASn8SbLWBRl3qhsPtdSUf6mThuSNmg
	bt066PISys3GTQN8y35tkDlOSTcof87sR0RxBoxAfNjtOOsmJRFiLiy0UrEoDatfLlZG6V2cK0l
	Z4J9nhgCfYq8aIRJ5t8crtsIWm5VoGWAAkpcjR9PtFnciTA==
X-Received: by 2002:a05:620a:410a:b0:8c9:e989:9d8c with SMTP id af79cd13be357-8cb7be3b56dmr1528263285a.3.1771831669229;
        Sun, 22 Feb 2026 23:27:49 -0800 (PST)
X-Received: by 2002:a05:620a:410a:b0:8c9:e989:9d8c with SMTP id af79cd13be357-8cb7be3b56dmr1528260785a.3.1771831668821;
        Sun, 22 Feb 2026 23:27:48 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9ff5sm18550286f8f.4.2026.02.22.23.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 23:27:48 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 08:27:30 +0100
Subject: [PATCH 2/9] power: supply: cw2015: Free allocated workqueue
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-workqueue-devm-v1-2-10b3a6087586@oss.qualcomm.com>
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
        stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=H4Qs2JkZdWI+ycAqQDT56iXbPAaAVIJgWc4JAWD+760=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpnAFnlKggUmMImpH+2q+EQOengTlEViaDst80b
 rri13T4ETCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZwBZwAKCRDBN2bmhouD
 1wL/D/4i3PYKpuAx1K5RL6gEvLpHiawDOSj9vjal+PUYon/bPYEopOZ/FUPvvzcyO3xwk1aE3fN
 Qjt1X6KJA3m12Rr3HoU4uzi7+QOtZhRC+Ee+waflrOuc2nmN4mgkRK5IZOP0P3ucCE7D0In7bU1
 VaDgnrh/V3ZCm37EuD+mQYYz7d5L0M3aXvcA7VOYqILqkUMKkSsY3F6fG2XrLIXh6XAIXjpKyHW
 kRH+idw+/a/tRpyCvoWBeHHdap8DB5XfnKr23uqVXt3Bt058BG82+iRoUjAk5RX0NchuKOAoejV
 mh6Yr1zLGVrUT7WJLWURwo+hKOyMx16oSSHu34xPX4RCVgbF1XLH6h7T2RAy+sNSv2pbMtcprVO
 d4xt/XcLU1usNGFqYiOKxkWyt0d2g9BL90vIdxK49QaKrhi8FKAJa9PIjRGf7Mw2hcaj8wTxzAf
 nBMpjwYqK9tj5Dma7CIHUZ5MZZpjZrlc0PbAOOs9UyXHWLWG0t6A5KoemPUprjvMqUTOJkTkUM8
 GVVtlaKnQwwUlKc8PHzp5UeJGRuoyXDOFUGsiarCRGWkISypxdARJzsBArPz8zFpm3ndeOnysuX
 lgYIX4UMonp+qXf7JQ9H520eW9Jwek8+IETCZeEhCvykTsj3Dwmo8Ip1VxDlwZ5+IeYSnWyiQkH
 4+N7CZUWdWSHfdw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA2NCBTYWx0ZWRfX/bOR/ZmrKRxp
 XJ5xk6pU7hcjmlVp6GZl1EE6iKkLGYKcbRj1LUjN2QOlSS2dR16b+ldy8bA49LbolifsspKJYjH
 lKp6+2pfp5CqZfAHjnA7YV9r+sPtW8gLutw786VUbLeVwV8pA9Olu1pVM+9yFMhGkVvnzOpAq85
 KHWILLN2eoYLfXdJKRTc7qcm6dPak0hOLqVymeKIYg2jjyRlbUZvEjg/H5NmEgHlNQxExCOV1cU
 s8ml4MSiAwKwFXjYAGFIF7yGsryiO5R8FIleAS2/YcxTlKWyFQwzpu4qkrdTjIBkGplZ4yvpZSc
 tQrDByqJpL56tOjlRewgyLnq36c7onTJy+wmyph8gDI/ImuSviw1jiG9LSba8rBsuZaqTgOCiRQ
 pVQrQOSo2IhKcPFeQFa4jglDRougdwf6n3MIzEg8+rYkO6syQqRG+fyc5t+scRJyYmqauiR00Gy
 VwGsI1WTN5If8DH80KQ==
X-Authority-Analysis: v=2.4 cv=W+A1lBWk c=1 sm=1 tr=0 ts=699c0176 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HiF-IioCT9ZGAFrUKQYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Z1AU8_wrm3P8CXWFm3A97iqoJ-xiZflU
X-Proofpoint-ORIG-GUID: Z1AU8_wrm3P8CXWFm3A97iqoJ-xiZflU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230064
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42995-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 2E6AD172A45
X-Rspamd-Action: no action

Use devm interface so allocated workqueue will be freed during device
removal and error paths, thus fixing memory leak.

Cc: <stable@vger.kernel.org>
Fixes: b4c7715c10c1 ("power: supply: add CellWise cw2015 fuel gauge driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Depends on devm_create_singlethread_workqueue() from earlier patches.
---
 drivers/power/supply/cw2015_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index a05dcc4a48f2..1e4e3b4c7460 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -694,7 +694,8 @@ static int cw_bat_probe(struct i2c_client *client)
 			 "No monitored battery, some properties will be missing\n");
 	}
 
-	cw_bat->battery_workqueue = create_singlethread_workqueue("rk_battery");
+	cw_bat->battery_workqueue = devm_create_singlethread_workqueue(&client->dev,
+								       "rk_battery");
 	if (!cw_bat->battery_workqueue)
 		return -ENOMEM;
 

-- 
2.51.0


