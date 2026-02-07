Return-Path: <linux-pm+bounces-42245-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKPhEdEUh2nBTQQAu9opvQ
	(envelope-from <linux-pm+bounces-42245-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 11:32:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E91A105851
	for <lists+linux-pm@lfdr.de>; Sat, 07 Feb 2026 11:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62EC1303A5D8
	for <lists+linux-pm@lfdr.de>; Sat,  7 Feb 2026 10:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D94931077A;
	Sat,  7 Feb 2026 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SEgrkuuL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="As9dyQwP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B61C33D6E8
	for <linux-pm@vger.kernel.org>; Sat,  7 Feb 2026 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770460137; cv=none; b=k2LqEQhtslmdl79OwhVEIF15az3jSO6DeIo2SQqw6IIwgzSf1/7wYQejEn9ZV3cQK+GqDO7aQ0ZgELJUPMboZczVUiMGkpjCxjpX4YDw1RlUuPA3abLdp9yNIHjdt6K4dpgFKFTP2F64aTKF0+0Ep17X+kb5Eql9nWNcLUUnznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770460137; c=relaxed/simple;
	bh=fdXM5u+EC1F6tBegBz4n/WaPeBMpqUT5SzqO544dUiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D333cgUJTWjtIpEkct0wgZOsmegEhweIHqIzeWnJU/2nqB10qNZtY44x8r1Wb/sCr/VWhEjnrZph9tOWVkWbWwSqVsdgIHH6Xy7sSx9Rlp55BFcNhImA+QspwV7avY/a0r0mH2ctKcUChZ6uh+Y+WAk0CRDgRYwVUUld/ixGzx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SEgrkuuL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=As9dyQwP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6174hAGL2501892
	for <linux-pm@vger.kernel.org>; Sat, 7 Feb 2026 10:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Jmh6cn1PePN1iNEXlTltvb
	gnQOz7Ns10pWcafr12FGw=; b=SEgrkuuLGSttpwFBcrmVyFYJCt2ss0S992OGnk
	pS+Ye2R2E6Akf9dU6CLXJIb7jap96yWC5LhQh2U8V10aJFBhtV6/3tFWryiXs7Wq
	9O7VhNakcFeexAX121+NYbYxg/bFxDugfkHMNWwYmh5SL2YyQaxf/NRNMQEcIA7J
	orAzxHqufk5rI8cdPZVjy9KJTPY5pl/aNsp/t1S+JmYpS3TtXk20kX7yNKDaTQtz
	mN8Nu4mMF3hDasAsZ2hG7pxw2WWcBEZILW8HOG1naRQSoIZeZ3aVnD8fuWUH1Qo7
	fi7v+nIGieL0V5NpXcy6LjkOsTx5qYEYPAsdAVDxwMkbuKxA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xjg8g48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 07 Feb 2026 10:28:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c71156fe09so381268585a.0
        for <linux-pm@vger.kernel.org>; Sat, 07 Feb 2026 02:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770460135; x=1771064935; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jmh6cn1PePN1iNEXlTltvbgnQOz7Ns10pWcafr12FGw=;
        b=As9dyQwPWfMa6/goDeJB3VxOJr1HkO7I830OCh+nVjDAbrIkUyzPOyYGJmpypOIpi0
         d9o1u2+CjKyD/zHKSHf0bWq+mo7rI3G6gIVdveS2cTm35BanP8OpnPwaTtyc128yYhB5
         UDRhSZxD7Fm+OPu2MUMRDqscRppmcidfu6Vk4lc4ddiSp0rMwlEFOx/81B8eI+GQBB5j
         uV2Ter0tpQb0J6Ft7DZ/Ps6L8yscQHj0mAPyrAbm3qKtHgWNUripCQUQFS4snUbbCjGY
         xiytjqIY4+kcMGKzjKVA51d71Rkw4x4V2KvQOPlgM9VfC/iIQvWI8ZYQQzc2ikn43cc4
         i9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770460135; x=1771064935;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jmh6cn1PePN1iNEXlTltvbgnQOz7Ns10pWcafr12FGw=;
        b=RVEBkDEz8eQIyy3XizcThk5hYHUKq2z+C5HNcy40t+UOXC4BUNKixdt7EF6CXwce4v
         zVjx32LPhqpaFKZxHPGTzrcY1Oaz1+DoIWPizd6+rKe03vrr/3TxP+Gz9pEkGHEI9EdN
         7wHgKXld7HQng919PN343RISdnpnIzredu2gHlKLsnY291bqqAyNzBbFxIVtm2wmfN5O
         tsSTp0wuzC1K48+BfhZ01VkqjjC8yEwdoRMXtksnQdcN6RI4oXvhZgbm0ZHR0XOdTcI2
         xzru+VGIvdnBVR9ONd5wk+xvfBkSuKZ9KjpuSMGoU+T4jPNXF0XNmEkw/5IiEysNnkTJ
         o4iA==
X-Forwarded-Encrypted: i=1; AJvYcCXMPfgSVPOcPA8s7yQwb0mcX+ily9Y/RRwn0ZEJZQ9ljtj66/71oDmW3X7Pa8225Cw8xnd4RdPYhA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkoi5H+qiLtJs22kEMF5ga2aQw0xKrz+NC0aKjuZJAHcnJq3vo
	6mg/8nT4tL1CEWBLTRq7kpUEzSayIZoEVHv/8QVy7Er8+FK9F1dVM4ftmfegqCMek8s+wg+Bqno
	Y0dMW8XgPAnT+U5KyJvF8xxNm26ZARVbsjmluRnPei4h1gnzYPdmpjTaoPBQwk28dB3kA5A==
X-Gm-Gg: AZuq6aJiHRAGIcM0DqS2dwFUuC7jyIZRtkja0/DhXvr632LszKr3hOnLqjQ6+GEBXEU
	tCyr+guaak3mh2MeeQoB/bKq9hiw25PwPUe78l4h4IEjbxOz+GlJ2ZSgbFwr0H+wvHfb/A5pq04
	Z86jPjs0eFAOEk18LK8SmQyUsXrCahauuZ/RyuXgDlXzRnAERpnzCESFNcMp/vSSVs0vA7nseok
	+edVQMgt8xQFpfWVCbsIdETyCl5reRufwkVRJw5/IA0HS2v7vfawkbnd+ysqxHrBWwq0uu79iQl
	2v1Pou6GqsvHvTR3JNv0yVWNk0hOjtjXEM7WDg0OyJa2qmya+6oTfN/HL0e9+QZ7uSyNBMPBgwc
	Nqf7N0kBqHSc7s8ss+OTzxuRmLu0MqKHZScA2NBm4BVJHblYm2fVGmyBluwhQLKLS9oq8AtXlvq
	80QD/YCnmjqTLXMqfWs1HtoYs=
X-Received: by 2002:a05:620a:3948:b0:8ca:1e09:48d9 with SMTP id af79cd13be357-8caef409340mr731506485a.35.1770460135206;
        Sat, 07 Feb 2026 02:28:55 -0800 (PST)
X-Received: by 2002:a05:620a:3948:b0:8ca:1e09:48d9 with SMTP id af79cd13be357-8caef409340mr731505085a.35.1770460134780;
        Sat, 07 Feb 2026 02:28:54 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44d299a5sm1201940e87.63.2026.02.07.02.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 02:28:54 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 07 Feb 2026 12:28:52 +0200
Subject: [PATCH] power: sequencing: qcom-wcn: fix error path for VDDIO
 handling
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260207-fix-wcn39xx-v1-1-df0606108ce2@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOMTh2kC/x2MQQqAIBQFryJ/nWAGRl0lWlg9628sFEqQ7t6n5
 TDMVMpIjEyjqpRwc+YzCrSNovXwcYfmTZissc5Y0+vART9r7IZStA/Lhi44C4CkuBJE/7dpft8
 PM4kBvF0AAAA=
X-Change-ID: 20260207-fix-wcn39xx-afbde3f62eee
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1413;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=fdXM5u+EC1F6tBegBz4n/WaPeBMpqUT5SzqO544dUiA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBphxPkKD1aYtu7YtXcdZp0eQJhlK/9dLPCVqC/e
 qcww/2+3L+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaYcT5AAKCRCLPIo+Aiko
 1SEBB/9sr4tCViqVP8Fu+tfnRYEVXaAPzsNlMhylHg+EL5CC4e7rpEXYcXe16IL9QchffD4i/5v
 RnwlBNH3cn/dlvnshscd94sa6iZMxTedkBwhmEm0asn5nJRh1XKE5CL7DTp6W/cX1TgM4wSI/wb
 rSfDmow5clJrjLuSBtR5GfLWu6qoO1i3KQ/uSPdZ7FXaw9xwglAHLl7kKo+bV/la+LWxSzZ+GI/
 imh0f1eCTP6MJD5aXePZMO+Mb9MLrw4OJS/LXyVxOV8R+VQriAv7xdqvPAXAUtFtnNSo7QiY3ha
 Jz4DijIsLwMjHDcFW1fwUm4UwmBkulA7sxIHnFCMM+9o7ZH5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=A99h/qWG c=1 sm=1 tr=0 ts=698713e8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=-tBD5Kq2AfAjgSKCxPcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: -uaVZUSsCWVU4Bu9scyewsfr-m_LdPq1
X-Proofpoint-GUID: -uaVZUSsCWVU4Bu9scyewsfr-m_LdPq1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA3MDA4MiBTYWx0ZWRfX82Vf9byjItKw
 QosGHC7n7hueGW+9aCzy9k5QYMmdsl6Vcvx47dMqlqZYLjxQ26Yepki5PSit4dr4uv3HQsph/QW
 Dcx2BUNR3/w3IFLrSOMN4nob+HKLqXIkgG9SaVCxkjXoZQmPv+sdwFwtWY/creAyVZrMe/MViGs
 rUF0G16UTY6im8AJPANmheE2MGawM49eEfTKxC1MkwNgKEmHkNDjcGT35pfNHRVqpYty12bpd80
 58fq9u9qNa3P4ku+k8QGLwiR+MhlSA4PyjXZ0pRybGvyFany9IUSLZqUPXm0YJ/SkiZ+e97pZbP
 QBA1ZKX+7zjWlWpIDWPdAZ/z1cDatCfAgy9m9P/ob+j+G1zG0roSYQ/n9OPswZsa0lkkJVqbKqL
 6ZNCqxgZIDCx3CIKPyaxaLk9s0hnhPnUvyYlOqu3GbeiVJAqQ1TDxtywTbJjgD0GOCGMZwJikvE
 wkJpnQppXxKWhxHE7SA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602070082
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42245-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9E91A105851
X-Rspamd-Action: no action

In case getting VDDIO regulator returned an error, WCN power sequencing
driver passes ret to dev_err_probe() as the error code, however it is
known that ret is 0 at this point. Pass PTR_ERR(ctx->vddio) instead.

Fixes: 0eb85f468ef5 ("power: sequencing: qcom-wcn: add support for WCN39xx")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/aYXvQxKqmjP_sdCd@stanley.mountain/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 46a484b0b5a1..b55b4317e21b 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -489,7 +489,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 	if (ctx->pdata->has_vddio) {
 		ctx->vddio = devm_regulator_get(dev, "vddio");
 		if (IS_ERR(ctx->vddio))
-			return dev_err_probe(dev, ret, "Failed to get VDDIO\n");
+			return dev_err_probe(dev, PTR_ERR(ctx->vddio), "Failed to get VDDIO\n");
 	}
 
 	ctx->bt_gpio = devm_gpiod_get_optional(dev, "bt-enable", GPIOD_OUT_LOW);

---
base-commit: 5c009020744fe129e4728e71c44a6c7816c9105e
change-id: 20260207-fix-wcn39xx-afbde3f62eee

Best regards,
-- 
With best wishes
Dmitry


