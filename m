Return-Path: <linux-pm+bounces-43000-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNetCrACnGkn/AMAu9opvQ
	(envelope-from <linux-pm+bounces-43000-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:33:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C05DA172B87
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4638307AA1F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D8B34AAFB;
	Mon, 23 Feb 2026 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bXFefgdh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D7B7TJAv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DCF34B1A1
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831683; cv=none; b=tKcqA440Vn3qPXWlPsAqPQYKPCUlkqJNm8Ql3Cz7zx2WEKbOGx9TRN0oISN4F0rLSXZjEUgs7sp1cC/DixXtJyi1lmwpLwwrrIP6etTCPrHhK1dA2sHGwfPGKb078u5fIH5AdxVOQbCvInmVh5G4C6c7Q8CQGb+qPEopZERaVtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831683; c=relaxed/simple;
	bh=r9x2dulUi2i/xHeDpXgX0ZLrT/131D7Fe/8Z5nmd+1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ek/Nnj1hpvDL6aKnHRPl8WCgCbVAfKYhCIZyzBlyc31PVf3iF7zA7nvN9dJChemD3FwfW+nuwUtZX3sPsdAWhVuahMKPVxKh8+m3hl1o4hlXV/UpEEmz1LXoZBeIOnWzc4aDphs02sZD1tQ6/0Z43Jn0ecZLcDr13RjMFXv7q0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bXFefgdh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D7B7TJAv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MKam4o3337870
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nrZc/Z7Be2A9y5DqcniQ9Lm/4gP6G87E802BvnTYUp0=; b=bXFefgdhxPDsuijE
	pYnRuIw6NL0O9YNgYItg1nt7i4ZCQEWOoOkFJAUghwrB+umKaoiUYEtnZpPxNNPv
	OlxrAGmuu+grnE0hac0PCqTo2xII88LwC3ifwVKfvHze7LyFkgVMOAn4C6uMF0YJ
	8jmAdcTJaXVqOp4YC+mru81BehBD+pO8nU349x98rPbYDSELkEAXuHO7UYcyA+yV
	K0q+d/6efiT0GCyZpTSr8tHZ67dyXrgpKBBLC7c8thjs3hNPl4RTemJhOjlQSZX9
	zgOUbR4t5ODWBY2zjHg1jkLRKO2p5vtjTVKJ21Y/ynHGhui94xPGB13nXFD7ys/s
	uWY9GQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5u8krx9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c711251ac5so3535960685a.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 23:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771831677; x=1772436477; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrZc/Z7Be2A9y5DqcniQ9Lm/4gP6G87E802BvnTYUp0=;
        b=D7B7TJAvFxFW18uM8WyBE0jrIzd3vOZHZcOyKdNGkNZ9akr9fYqxFb3Yz2YswN6fS0
         VwjUMHmGxvM61rL09Gw3G0VyR6hn+Ep+IPAucW9uM7YTPfDyBtDq+jqFL/H0PzE+cAah
         ub+/IkydBreJXtp5PiW2aonWrAcG9NUfKj8HhwE28STSvorMYAeHoz6SuUexq3b0XQf9
         xSUOljrGD99l+T95t0kSd6eUHL+E+ePmMICT9+JLfTj3NX7YPuZSEuu2CNMD+j2+y0zb
         DVjCr175mL6kit4+XF12wEkX1feB/YO8Et7Vkf3DQ4tsafbq7GY/zEAXfknGPolbqYGE
         w4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771831677; x=1772436477;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nrZc/Z7Be2A9y5DqcniQ9Lm/4gP6G87E802BvnTYUp0=;
        b=R3Nn6OSAcOdqR11YxrrOQjd7NBYHxxmgq/5ZIRuPUM8NFQE3k8FlvUOcJqF5BwlEpQ
         ds/93QUqZq552gINqefYNtFqBvIvik+VXsKROyIU7PB+f72/HPykEkcTbtd2KWEgMUY7
         hV0GFxU5PfjfHn0cRRk/O6UhXeRg484z+JWt9HvjroPO0P9BBmI9jLKLTBENDoqC0vCQ
         n/L5286exQMenXHd7Qg4nE7IZVxZQ81Au1vahClh/JOyuSdQm+glxyOh8k+n1P6ZD7bA
         ofmNlQqfVkVGFjUf/T5YoajlK77OcB5tXBIun/ia/pK9DLnm3RFNRhre72T2JVZTo18B
         tTrg==
X-Forwarded-Encrypted: i=1; AJvYcCWkV9fTdD3c/hQXfSCtesTBlp+UaymkWhY+u/S8eHxgYYmKtWo4FGph3tTjQLFjwtT2TJNELHG6mQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUxfOFYzcEYL1rKTmwl23Vukqr5S1w6J7iVzlqb3sApp6DlZl
	3LuZ/yd9VbsKHMmS5ai1DPLoALQqeCx8Cdx6e2rmH/ug2t3dGCKLRz4PZ3YWU3ya8K1qk6p//4V
	7rwaQe20kKvjr2+ZyKn9OPjBkKlZYRWTwqq2Xp/msugamlezyPLgYXmIqW4VooaROofzJWg==
X-Gm-Gg: AZuq6aIqXBAp7lTP6xbBsXTT4JVDxfWC3494tT71/NW49g+kc20qnFSlgeOoOh2qACI
	gepaJOTJ8nHKRkaSdHA3Gp4E3bJFyJ+R/mu6y56+jzj3Z5WbTt5huQJDIX361lk6TQD3aJmXyEQ
	R3ut6BbOXDd0lGWKy7lcW7CsNCao/M6m31gyKAZDgs8pO+euBbV8Dhps9vKSJTZhz51i0uWGFue
	7d9zPz8YIjp6YzIQiT48D/gfFH++xAu8/GElMZtzcdaPtXiHIH9W+aSyE7Dxx3UT5Wjri/K4C+v
	PskblBw9K3KHv34KUpK/pXkpZ/wg4+6nILOhqIxxHrVDojwVtkb2YTs5Z16WEikfOO8f2O7u648
	3UFseW/FgbulDXBgb7L3LN9EcZih3S7bkGZkS56ydbk4hUQ==
X-Received: by 2002:a05:620a:4726:b0:8cb:66dc:9fcd with SMTP id af79cd13be357-8cb8ca740a5mr760939785a.56.1771831676902;
        Sun, 22 Feb 2026 23:27:56 -0800 (PST)
X-Received: by 2002:a05:620a:4726:b0:8cb:66dc:9fcd with SMTP id af79cd13be357-8cb8ca740a5mr760938185a.56.1771831676321;
        Sun, 22 Feb 2026 23:27:56 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9ff5sm18550286f8f.4.2026.02.22.23.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 23:27:55 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 08:27:34 +0100
Subject: [PATCH 6/9] mfd: ezx-pcap: Drop memory allocation error message
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-workqueue-devm-v1-6-10b3a6087586@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=769;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=r9x2dulUi2i/xHeDpXgX0ZLrT/131D7Fe/8Z5nmd+1c=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpnAFrkKbfiaWJobMJ1uaOgm6ZHmwStj8BHlR2u
 vp1CSwCm1iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZwBawAKCRDBN2bmhouD
 1zVfD/oC4r95LjZ3DM+u2Ns+t8NFjd9MPKu16F32jeMboQjnWCR9YCLIRwn7Fvr1TR+ff5UtpyT
 XBgB2Rx8udmj/g956wfXJx/U4gpvw4kMozdxk98g5ROegzSW+zpfBmSdv/Y0RkSJY7v5JcH18E4
 nWjB6GjTLB5VOxQQj3pioJknmyxmuwTELNXH+jJri9kT3Z41Bz+Klt2i8/wc91yhXb407gbpdfR
 4DvWYkfuiKiF3C1e4MhjzEzlfuG9qQD3KIscOucgJL+YRlX3Ey7sED06o+WoJPNrPK0QfFXhHZv
 NOLX6kWeE53OeTAgE187NhmpJzoj7zvcDbaBI31ndIEGgthZWx7pORQJu6zkRlU71fOtYDaid9J
 FrKtxYHV0/sGCkFHormsZ+GOapWYEhWEJR50ScVUbd9ULC4ZlxUxCBTIWhz+Lkm9Gv5VXaFcLS+
 7OxY4GcIIWlXpspwcVNxWaSdqZ9JRVxzaRyzkcKW3kuNAn523XVBOUAuM9iCufA13SLXkpczN+Z
 ZZSw0XB5klJtECmOL/uR9A38T4ef5aU9LT4QNNVIEmKT6SgLS7zCvlvFse5bWOgrryLV9WAJGQ4
 W5iU8ft6bo8owCRtIIzDxGrRgVlwrPd6TNb2HR4Nqzie8fw3AxXahDDaQMK6t5HaFml+MzTwWfh
 z7dV1TA37i7F3gA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: kbZ-OJpl_MwAxN9c4wt3kx7x-O9GxR4g
X-Authority-Analysis: v=2.4 cv=cJftc1eN c=1 sm=1 tr=0 ts=699c017e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=3HoxRS3-ReI3PdwluWoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: kbZ-OJpl_MwAxN9c4wt3kx7x-O9GxR4g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA2NCBTYWx0ZWRfXylWZ0Et+JqTN
 uZsidzcaRjIsw2WNZpBP5RbgZpE/Pe47UODzaLiLq5MbStaceps0inkMmv+r406gX9PsGrTrBZ7
 WL6Gmn17jYLdWKGLHdRa1cUKa5/KaaoX+F4xxvb5CbhGregwNjJS5eiBTVQzh1YPM1c2N7vf8ad
 lPKrgSRccj1Pa1JqvRK1h15hgjZxxgm1kO9JkssA7plMPOysE1xJ0qipuxzdHlgmN5xN1fg3Sva
 WKmwkDNgzqziS6uY1OK7ags1HgFKzN8U+PCX5pA//sskMpBGYMTmPgnXbs3xvDmHa5Rh7PEjJfl
 9yUSPt4nmA5ZmpK4wSPVYHZk4KIcCLQ0y8CcqrD2xsk3U/fQBBVwqZTzlKzzvchRjcsmsf49wnz
 LqQqHei2azGcaBqfDBPKz8rNripuPmfft4GkFn3cxW49458U4DMEuCO/b0kntM8Hgjrth4BRAeT
 /GPFsIVCWRGo0GJwVQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230064
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43000-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: C05DA172B87
X-Rspamd-Action: no action

Drivers should not print error messages on memory allocation failures,
because core already does it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Further patch depends on this one, thus it should not be picked
separately.
---
 drivers/mfd/ezx-pcap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 1be4557b7bdd..13cb185638a9 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -416,7 +416,6 @@ static int ezx_pcap_probe(struct spi_device *spi)
 	pcap->workqueue = create_singlethread_workqueue("pcapd");
 	if (!pcap->workqueue) {
 		ret = -ENOMEM;
-		dev_err(&spi->dev, "can't create pcap thread\n");
 		goto ret;
 	}
 

-- 
2.51.0


