Return-Path: <linux-pm+bounces-42997-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLuuNmUCnGn6+wMAu9opvQ
	(envelope-from <linux-pm+bounces-42997-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:31:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF56172B39
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97E1A30649CB
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 07:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B9D34BA28;
	Mon, 23 Feb 2026 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SpVHZjbm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aYlYD7IR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403534BA2E
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831678; cv=none; b=tpXnPnS/Fp7nLRXrhy+0Tkdo61fm5yTngG3W3qhcEWpIf3zZThsez1KBUJ9TGfxyrxvLoJ8ZB1rgn+1xJP7d0Y3EdZe89ln2w0qfZzs3mFAUsvrOhACpXEM6jgqJcUpL9XK0wUvSvW1YqHcpy9AI6oz8zjqXeTMSPtgvXVa1K18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831678; c=relaxed/simple;
	bh=JXjiqG9T78eAGojjEK9/Zi9nDA6gm8rfDk6Pl5Nb7BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgS5MdEyh2kVvgKifQrWPR5vmUgglbjJbDaCrF0DuYIISz6sEP8eDwMXTTkQJ26zcPKMp1UG+ABvLg6zFZnmegsqGEnpMSTV4Zc1NBICzX7NrRz77yi9tBIDk4eOX4z8TP7G0FeHJNnrIURCNj/HVFHInFkNfuuYrFbHU0caIoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SpVHZjbm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aYlYD7IR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MJvlQ62146284
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J8/2gvQaG0Yq+hSJC2X5/y/AH/3zpoF7o7r8roBAJXE=; b=SpVHZjbmZaC1Z+RT
	50XGF06GAFXw7h4mNNwaUvn09re6nys6p0++c6ufA08lkdSvfVmuzzcSI2D+p7PW
	0kbwQeoXfuQleIRzkZ1jdUEp43XPREr9XwmpZAcri4ihmzWnAWV187icZi+kFlik
	F7Avbuj12qOGhO9n9mNLtGsHKM/Zdoh0sXVWiIXvokaEX+ci3g1Wt/M8lSMV2C1I
	P1nPmHYLdQ5g12mUQjqkr1eB9K9z3c9wGKmFjWVmaDuidGQzMoz/S5R4fCoO8ri8
	5byBZT8kEdPx4TwygRme45jgmViQIh7amKpIi3MqHzxeaTxHeuF1jdpXfxOTLlKU
	5EvOTQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wyurw2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 07:27:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb390a0c4eso949354885a.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 23:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771831673; x=1772436473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8/2gvQaG0Yq+hSJC2X5/y/AH/3zpoF7o7r8roBAJXE=;
        b=aYlYD7IRRdGg+G2bcIypMRCmIVAGcMWZB4mGg5NQtlQ78/X2kUofYJlOTD3cB6+OHi
         XxKe0z4i7D6khISEw3zehaGndKUbYHY35P3321ph1j6TCttzK82v/gQctMWaijobae86
         0MxxvcVmZk4UkXFCC/Ij3qI7s241CdNEMpMJayIN31IQyFfW+x3n2u4yHkpuwPs9TiQO
         H7L1uXni6IbHqyBCc9fLb9cYp325HsWaJ0l81hgxMApjx4FKhQs609bNqJPOzunum88C
         s66pOI6B9lgqNrFE2jx9aW2OAifLToRDH+C9z/kJq71/ARG3sXaZUvuaLzhErrzVlStF
         vNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771831673; x=1772436473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J8/2gvQaG0Yq+hSJC2X5/y/AH/3zpoF7o7r8roBAJXE=;
        b=TyzCHcVzmFsvkCg1NfcJX0ie4mnDXT4pN4cNUyVJngzUB+n6bm199QdM2Kqt/i7M+p
         fW/xjbyetRaqMuN4GYwtgVLbRN97tELRn9QyyiOEstMLnwxcYj+BOoNVqe8cOmtOrxan
         CWMmy/VhBMNU05cnpM3bx27qyBCt4Hxunk+7A5xfrZsRUjD57AHwLLCzhGfAh78rTJwH
         4abtgCjb6i35H0e41TFS9Gy6ha0VzIaMYXrb+rDtOOT/eKAxuZmUMfUl4OGBQJiW9Ghf
         a4EF9Br6USd3P7/Pbj2bsd/EYRSb6kRiJ1FnBng/Zx8WVHV3vAMqTLP00blHMFbB6b12
         wNbg==
X-Forwarded-Encrypted: i=1; AJvYcCXBW/aZ0pwFbFPLxhpC5Rzpq1KxYw7DeMbjgyXfMICKKORsxqStZ8bwnyOaEevwXn6lN39/bEHtwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqFymLcvklOYKBwY4lHZkZo5sSiOkSOCcbPJOlW1HDier3+nHd
	hETejeN0D+nO/u/qw/jcudu2fxup7vali6OptibZIHemud4IuC9cm9tZHIMvj6HGpGIFFNnm/36
	qfszxPf9bRhJWT8eeOiqIoYvPHQqgCwTFj42gbfRLP4ZKdYCrXzl0dLyyJMX6cYliCGbM6Q==
X-Gm-Gg: AZuq6aK9I6NIRuBU7h5Gsp5OSC84TJ5WeMXoWyL+mgoZa62ij3v8/kPxOxfdVvx2rYd
	zdWE7PZy9MsAMXLtxx74j8ZrJhVwJ+z53Hbu/NU9PehpK7NRekcGvb0t8HcPf4bDsyyNtbkE54w
	rF2BBzKvunnnMwKGmgw9mj/s1u933wQiBrl4kw35MAE4pzI1qJA03QEK/uLtW6KIHy9u1VKKZTz
	Vvjwab69HMvdhnLNCv8cEkX7Un7dlRiyJqHELjCV/b4nKjSu6c74AoUicTepFeZg2iAPRbBvV/X
	HVJ49gcwEg5IlNvwuNGDmL3kOcizbgd6/FgAJLGh2q2w2wdrUvK+G3l5YwPL8k0hIsIDKYOl7ss
	iS+TQn+CupSl2ja2NlvWB5uBjPsGOWmE9WxvOlvNnRvQkWA==
X-Received: by 2002:a05:620a:2a16:b0:8cb:44d7:39aa with SMTP id af79cd13be357-8cb8ca887c6mr919031385a.74.1771831673121;
        Sun, 22 Feb 2026 23:27:53 -0800 (PST)
X-Received: by 2002:a05:620a:2a16:b0:8cb:44d7:39aa with SMTP id af79cd13be357-8cb8ca887c6mr919028285a.74.1771831672680;
        Sun, 22 Feb 2026 23:27:52 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9ff5sm18550286f8f.4.2026.02.22.23.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 23:27:52 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 08:27:32 +0100
Subject: [PATCH 4/9] power: supply: mt6370: Simplify with
 devm_create_singlethread_workqueue
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-workqueue-devm-v1-4-10b3a6087586@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=JXjiqG9T78eAGojjEK9/Zi9nDA6gm8rfDk6Pl5Nb7BE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpnAFp9FpdXlORK3TYpQCMwkXfvfWNBaac//1X0
 vhPZnV5DAKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZwBaQAKCRDBN2bmhouD
 1zzREACQTNEy+SyS8bNuKjvXbhz5E4jN7BzYOJgWNyNmgpmJ/J0B04PSNn7WhRDzfnj20zlc3no
 4Z7M3WMZLj5DqvNNbRKuKmcYK8fumg/o8XU9WV33VRrFKXZHZ9fTesJOPKo2Ldub65X3GHGkqK7
 DpQ4aC8bK8O++YJp/QxQn1SGyQaJisOtMDOrk6nsOrOmZi3FftfnDF1yDgBmbHSZgSYrXGYFxJx
 LOA8z0QczvhcVAZdmENDdCbXK5OArtY07J0o/Gv3rHQ+2PvZmwswyFz4dsaQ4ckWnsX3VQ2rDTw
 i/gsWSxXY4M6NXKOo6267SGHkuwUwJhyALG8NwGGNncwrbNGuChatk5zV+ia7yiWwoRm4kinVV5
 H5hMs6RMj1luoPCIO7NhYLwgePLg7PEQIyL13bkMLl0ZAtO7InkRRbRBj1Sg4LrruS3gg4QOYFH
 chibkuHJZsfg4m5bL7vjeqDilJ228Ymmh1vH1CBdvvfmHKziimERsZvPLv+dF0BXo5LwFpPrNrn
 gqno1C894RfGiUYOj9LEKWcVleHEfiUd7WIj1WnDhgVnrmuuN6W2NqNSR1fYWKBUnzm57jZK4Ie
 eTOZPwdVIE8s4gcOtEZ2LNfkUjadTTtP4gjawJ6JsI6T9QM50P9nuFwrhox4a3nhNO3DJnk3qc1
 ZnclO3WsVt0zb8g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA2NCBTYWx0ZWRfXyJt29xYwHror
 AVlOBE03090+M/1QdY1MZfVfEfmfr6DNVyyB/81k5kinju+dFAHq5AB29NhDPyRQpG8WjGXwDBE
 mEW0s8izMQ0oQVeV7ZLUq/QkUrXspZTXcAS7f4i7Ea84SrlALKOnC1bMI0THjTMfW91z0nW4kXO
 Jn0CvLjUkKhPPuwe9wGZvqINwtOfwMRIAmBc8bb4uU5rdm8z9Z01Eg8x6qghgHsYJmNzOn40USS
 UuM6za/gg1h2YwXwp2ZBS163exVgPx/ofB0jgRVLs/f18nyOL+VGzWy6+vmuwYxSjYlVagu89jF
 AvIZI7yvmNd9pJYJq6fZMvmzYklv2S1kMm0vQq06GSWO7I4bvFJbXpjjKHwaI2wXmArTosByGiz
 tC8Cb0iSZNfpEtLxlPWmC1qR4DZwUB9DnJA9m855gZCoM+TpT060QnK3elJJWWYveAxY/Azxz+T
 giWp8qs8lPLHmvHiNxA==
X-Authority-Analysis: v=2.4 cv=UO/Q3Sfy c=1 sm=1 tr=0 ts=699c017a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ztnre8jBXG8j2NFRlM0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: Beh3m2rqjybpYmB9YR1LhGFUUUGtVaHi
X-Proofpoint-ORIG-GUID: Beh3m2rqjybpYmB9YR1LhGFUUUGtVaHi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230064
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
	TAGGED_FROM(0.00)[bounces-42997-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 8BF56172B39
X-Rspamd-Action: no action

Simplify the driver probe function by using
devm_create_singlethread_workqueue() which handles the cleanup already.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/power/supply/mt6370-charger.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
index e6db961d5818..f671fe62876a 100644
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
+	priv->wq = devm_create_singlethread_workqueue(dev, dev_name(priv->dev));
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


