Return-Path: <linux-pm+bounces-39398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 331CCCB1F2E
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 06:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0E3530080DE
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 05:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0C8285CA7;
	Wed, 10 Dec 2025 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uo1vB/tb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GAEjb2iP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1E219A89
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 05:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765343868; cv=none; b=AsSp2oVvii/vAIvKu4u2emW3uenXW1mHrbnyLptnppU1B/Xdc//jcUXajo9nLhncCwBekAf+n+GvhDGnBToHCFaR5i0wqv054XhClNvb7BdEtnIvNTdLlu4gRQz3moOmC7f29OYutW+xvfSsmzG8OGIgpBQtqOn+/weVaeYHnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765343868; c=relaxed/simple;
	bh=bhY51TIus433VCOJMEJVew7I3STJBD9pP85tOYCmkdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZ2jLbyu48uPRAE8xTTUE0wlVqi5UU+27rPfkGy1T0E/v2RzpyT17fU0GaG9WOqmfx6Buab3/JUkNqtMNykAWsFGl3deBJGcDSolM+qb1+XzuEMLfmnLJa75v4GojPfmFApU2eQ93xRC7j0ZWoa+dzAkhwWEK7n1T1Su1+2H8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uo1vB/tb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GAEjb2iP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA3LPLe879045
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 05:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=YBTMj2VQVWcHawl/1Vp1hGPoQqnshlmcclg
	UjH9Sor4=; b=Uo1vB/tbWHbo4u18PMH37uELUkxkcmko9sQebf7Th3kEBSoDomU
	aYjubLow/Wu/wfxX8PpGybr8xBv4bAChinXhrw1/pg6HIS0vSsNbPxtU9FBgq+4y
	AaeU4/8oXivHMDp7Ystcc6pWIOPUPIYEdxy+dpNVlKAMc4dgwuQLS9UG/7LCsssH
	Oq1cWs8OU1l51D3+ZQTm6HVicdJN7lSXT5MfsY3jOo521nthen+qxMQaHAwOJkXe
	TtElWwPy/m1ct5B93eUrheHxJeawUPZVU0IshH07N5vyS0xpHzR2eFdUMwn+RIeU
	+6ObplM5niJe3rtnIqnkJcuGjModdu0ubXA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axp4vthk8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 05:17:44 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b9ef46df43so7085772b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2025 21:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765343863; x=1765948663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YBTMj2VQVWcHawl/1Vp1hGPoQqnshlmcclgUjH9Sor4=;
        b=GAEjb2iPBXAq9lwUz7C4hgpv+2pngvjZ3ey52418qbuT+t5Gw5CGwpcX2k8o8GDZLz
         kWpOWchN+ROmv7LBcTBoyAuda+VXMpb7wmamenPvs+5TuKO2Zl7yGuWWKZNxjLsNC9f4
         Cq9Ys8LpEOHQ1yUWpJqF0Fj9zC4fvKQbba1yMV9ziMLnJhDyul3fdzZl6dScNDikxh3G
         M0KWd9+rnQjyxZabVnMzBYwegYWE/RzdmYqtp4ZK48c+69c+nS+gwi62Td7MgA8FTLIG
         OBeF3Qh5IcTjqH6JGFVOahWwMiRDRzdaDA/YSdCRK0DELlPbLf7nz+l2urfmR72AEt1Q
         3+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765343863; x=1765948663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBTMj2VQVWcHawl/1Vp1hGPoQqnshlmcclgUjH9Sor4=;
        b=X7NWdulfczxarOZ0f+izfIlgRRfv4dYwF4LMl2or10jkIMuFeYrfd3N9+4Eg+hn8mt
         n0OuzzinHYWphJT1UMuKQ8gBUpJWnku26NBLh4BtW6HXxg1pD73ccgPYcjVQLHb/RvN9
         GG37nccsfV4TmdUtFfHInO91QX2lPIzfJAPFi//c/g6jg0Ee4KosCZVJqk8gqlh5RabS
         3wb5WF73o49YahpOdiAJEzFeZ45z2hO3LSmVeuQya/qtzb70Ysj1NHin2nsn1jxmuiqs
         X2AYxbPZ3kOT7SySkEPwg5Ht2flIBoZNmnFskNvc218n8DMGMl0Us7oN1rnQhvXTtkW/
         sPQg==
X-Forwarded-Encrypted: i=1; AJvYcCWL8qM+EqQhQFZYB8IfNQoZm1ZiUoJuZqGNyODzVxhAT1d0w5KEiC2uEGtAl5IjjnXHgwYA3YheqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoBYY6ZtNRuGIo2YHFb8HGghhoFSndMzZryhWE6g/A9vp8dbAZ
	u2c+pnnCBghYJEgQzJN1PnJ6vbBnfgxYWEK+H7XbtgAmeRcSEEXsTr1FtAWNATqfd1CCVFA14HW
	MZJQQMQAYAbGy/Rli4gGaUqAwvU8uZ0cAi8wY1h5gJqIg26BHPvadGZ1aakYuVA==
X-Gm-Gg: ASbGncvB2CpOcE9v33KyYbQy1uOwInsy/PufIeEtkdhNkNIww9X1zoh0AkWPzJ7RGTc
	DnAznJpSjlwYjPWT0bjBYD2HkRziG0fj74TjV8nlCG6IeT32itds/4r4xc68srq1o0YIdvgykf1
	h/s0mBqKA+y0WbEeZiTabE3KH3tI5d0lRsJ2JMV8uAdieZ1sa6ryIWzvuzmCeN+b8IjpOpetkUS
	QVFz3zxatm1LxILN/EzUIqE1CbVgKWbEkOvxGyBtIQrVGGZy9+gVRiRJZ/v4lS04zccjOeLq/oW
	EjlXAlyoLbc632S243M7CP5z007rGK/s/dDSl1/DRtU/hiD+D5Plj+1XnOWeNR09ldVS8SujxwJ
	9z/e60nc6lxJorhl1Y32M0RN8OUYEwSjyH0+Gk+/csbAgUHZUT1+94yyZ
X-Received: by 2002:a05:6a00:1256:b0:7b2:2d85:ae59 with SMTP id d2e1a72fcca58-7f22c845f55mr1058048b3a.11.1765343863192;
        Tue, 09 Dec 2025 21:17:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAz12z6wVZHGAlD1CuPazu0wBSPLu2K+M8Rea/P6L0Os5b8v6WRwEtI1o0uWXo5mXT26mPXw==
X-Received: by 2002:a05:6a00:1256:b0:7b2:2d85:ae59 with SMTP id d2e1a72fcca58-7f22c845f55mr1058029b3a.11.1765343862671;
        Tue, 09 Dec 2025 21:17:42 -0800 (PST)
Received: from quoll (p7838221-ipoefx.ipoe.ocn.ne.jp. [123.225.39.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2af843307sm17637692b3a.61.2025.12.09.21.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 21:17:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rob Herring (Arm)" <robh@kernel.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pavel Pisa <pisa@fel.cvut.cz>
Subject: [PATCH] cpufreq: dt-platdev: Fix creating device on OPPv1 platforms
Date: Wed, 10 Dec 2025 06:17:19 +0100
Message-ID: <20251210051718.132795-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=bhY51TIus433VCOJMEJVew7I3STJBD9pP85tOYCmkdM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpOQJehAkAkIg3kGIxHtMh38TSuMWDDEfWHrmrv
 MPxZxoFJAWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaTkCXgAKCRDBN2bmhouD
 1+MGD/9jcq4gRTkrN67DMJF1QD2rPAPG7mVeoJt8AQ7Tg8r713+8FGP3KohX6ZerJDyv8rU6Lho
 8UwpPyE4mSw6hwRazU0q1Jo4uLRzzgnEuVRFe4g5a2syiS9EiG3rsxbSNTdU0rmCWzVUs3SQVRx
 W/mTWTKozzIZ7W46b+AnxAlAlQHD4FPp1oOs7MgekrLHl4W2555684Zt7s3NzHaMm4bp4h0Rp9l
 ignDuNU9f/BFzGqApN7Qsd+K115+ZX7AtzdU/HmuvjeqaYT52KwEl7nr8FxX9tLOnZ9+CjP7Qh6
 vvis/Cwb1CbZ4rKTwhIvUQhGLwT6idRnLTYMC1GeWbC0kI5/7LnuYtzIjl82qzgd4OEQwLLGs1e
 G6ze+7Obkwyb3wcuEX6/YczZhIzk/p+kVKksODT+EKLuxPZejeuQijE71Fdk3DGw59rtHN05OfI
 PuGSE/PScWhsmgr+Gew9Yyzf2eKNsk/XPKhFjBoK57ScaqqEDIb4xx359YeJ3trmIVyxT4ZJRR+
 9mNRMxqKhWF2wcwWqFRTOR04fghw7Wv4MLGq/3lfhWjxVN7oMdblr3vBvBgXBfyp4IllNC/Xe7Y
 GVlJTNLfTCUezFOv+8FP6XQ5ZOolIhUH4EuLVmI6HZ+KqKJRkgRo9ShP+MJtVOBNqqcM7bDawyi rid5JewbwXj4DDw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OFSzSqOn3tR0ytEleuIFaQRm51ybwxFQ
X-Proofpoint-ORIG-GUID: OFSzSqOn3tR0ytEleuIFaQRm51ybwxFQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA0MyBTYWx0ZWRfX3SP6+dpBwiOY
 YoyN7Ixu4HeurCntjhYpIXHglHK14vVXIBg6w0bWlqyfVfw1OVD2jeveXd2GtVeas+PoyJiDcZT
 5qkmj3dKwy0SaRsEoOwmvdiigEmI1K9pqFC4QPUBJygxIr8KvHJu3hnqutOuJSf48qACpKxvc6Y
 2wUwdqiiMlls78+hFFlTRD9/r+KK24/BqfUxoee02uZL0T5ZN4I0DxB2v6OQGeaVE0MobG/I8Wx
 uId9QZRtUy9TyMVxQS44jFt4tssA5fCvGOHztTDyqW0iXi02SScTKy1dsRiNBfPlaAwx6fNgAqK
 vs05/4btSllrmm+wRN4kF/2TCkjvybpLeWQFsZdyld/ioLbNaoyxMDgGQbk8foycg0WasbKzS4H
 DWpwvzGybq9QgpWh6i6Fp3nW5swgDA==
X-Authority-Analysis: v=2.4 cv=IoYTsb/g c=1 sm=1 tr=0 ts=69390278 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=cRv1ukX+bdz2y/k5ONU6nQ==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=tBb2bbeoAAAA:8 a=EUspDBNiAAAA:8
 a=yAr-ADGfomHROUh9l9oA:9 a=OpyuDcXvxspvyRM73sMx:22 a=Oj-tNtZlA1e06AYgeCfH:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512100043

Commit 6ea891a6dd37 ("cpufreq: dt-platdev: Simplify with
of_machine_get_match_data()") broke several platforms which did not have
OPPv2 proprety, because it incorrectly checked for device match data
after first matching from "allowlist".  Almost all of "allowlist" match
entries do not have match data and it is expected to create platform
device for them with empty data.

Fix this by first checking if platform is on the allowlist with
of_machine_device_match() and only then taking the match data.  This
duplicates the number of checks (we match against the allowlist twice),
but makes the code here much smaller.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdVJD4+J9QpUUs-sX0feKfuPD72CO0dcqN7shvF_UYpZ3Q@mail.gmail.com/
Reported-by: Pavel Pisa <pisa@fel.cvut.cz>
Closes: https://lore.kernel.org/all/6hnk7llbwdezh74h74fhvofbx4t4jihel5kvr6qwx2xuxxbjys@rmwbd7lkhrdz/
Fixes: 6ea891a6dd37 ("cpufreq: dt-platdev: Simplify with of_machine_get_match_data()")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index a1d11ecd1ac8..b06a43143d23 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -219,11 +219,12 @@ static bool __init cpu0_node_has_opp_v2_prop(void)
 
 static int __init cpufreq_dt_platdev_init(void)
 {
-	const void *data;
+	const void *data = NULL;
 
-	data = of_machine_get_match_data(allowlist);
-	if (data)
+	if (of_machine_device_match(allowlist)) {
+		data = of_machine_get_match_data(allowlist);
 		goto create_pdev;
+	}
 
 	if (cpu0_node_has_opp_v2_prop() && !of_machine_device_match(blocklist))
 		goto create_pdev;
-- 
2.51.0


