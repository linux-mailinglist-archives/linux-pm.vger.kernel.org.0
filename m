Return-Path: <linux-pm+bounces-42022-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFWuG0yagmkzWwMAu9opvQ
	(envelope-from <linux-pm+bounces-42022-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 02:01:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3381CE02F2
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 02:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F50030386F9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 01:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CAE242D62;
	Wed,  4 Feb 2026 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k2Zv/a8Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VleHCBND"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F623D290
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770166803; cv=none; b=POAMX0gxt964VM7wff1HidfYNdcXKKgGYHEJ9oEQXIetpHRjr+nNo75NV+K04xbE9SMEqQwLJsptDj7cXuwxWvD0Ff9FGQA/xg4XUOHLUSqblAzLml682uKDvIeLq9asAqzLLHlxeoSiD9xacyOMNjIe4kWMaFvfdF+MDPvjSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770166803; c=relaxed/simple;
	bh=DrFwEkIoYrD1qa5tx9EdrYljNPefynFUvMATHqt7Zhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U9jthgVSdjhEqS2tPwmFVziXG8y9txJi2v1xE4mVMaBCAb8euF3y0tpJ6rUTDmr6eZuoyRGA5tQLhSD4IYel9Q8X/YEm1NlXDn8h+aMopuf//S0LuUHpxmYywOwfyBgdZhcoHLu0nOgl/Dj8XukFO0mJ90JHBGYAJLgnisj3iZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k2Zv/a8Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VleHCBND; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613Ilgf92962676
	for <linux-pm@vger.kernel.org>; Wed, 4 Feb 2026 01:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HFgRG5qL9bnoUT3jp+ysOldDPm40o5vQTA9j6ykK/qw=; b=k2Zv/a8Z0KJ+rUmV
	oMJx+1RTv6EK/XHMNwvwIHIQbf7SVyEVr3teJD4KYzxtuoQ8mDZ1ra2mnwGYswP4
	n3Za56KUmZj/p9y0bD3D99UVauFXB+Hdt59PcvbkibN7AlY0LNMzwhZlCtYqtvQQ
	/2F0Q+eJQPQ853xWzsHqX9B7e+uX6R1TfGw4N8DQxRRuwEFu04v/o/BiaYVO5C+3
	eqr7nLqYPreMkmUwp53vv51M2gviNMj4IyuYagIu1PRA7VikAq4VBVmoapEJ9Hbx
	4k4CmIHgCzWQkXfwAPp47VdqCqw1FH8eZnUZk5py4jluMhMmEcrKBKUUUHrmvuhr
	aL2kew==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3ne7sc4a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 01:00:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6ad709d8fso106030285a.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 17:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770166800; x=1770771600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFgRG5qL9bnoUT3jp+ysOldDPm40o5vQTA9j6ykK/qw=;
        b=VleHCBND3S2RJj5CpZZTpVF+0Pc9mLuvuApB+dI0DzUgPS9KPglsniRt9mLJ9n0SNl
         wajmFaKXbYUtR5pgj6mznxM7bqm36V2rIpM6Vg49MQzyBpsjZl11nEas+CbSu13kF0Xg
         7gYGz3MGSTsaQMKIikAzAFcWR+4D2ebAtwZ9nuZnmMvE9K201LLUNweNRdmBAgLgEBZh
         4pEfKyfIIdykYk6JxT1CoiCAe5tPBCMwIRIoQMqfi99XgIw/w6+XflRCJIIniuBYjM2x
         L6RVPlMBA5gdlAQamfZFD8u8TjlHdg3GNl1+W9AKfGerLV6dyK2t4SwoBbNBHpqVxDrb
         m67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770166800; x=1770771600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HFgRG5qL9bnoUT3jp+ysOldDPm40o5vQTA9j6ykK/qw=;
        b=uFSnaMi/ivp9h7ogfdA3CaKHe5UorNQJO7HlO3cfeeJwxCdkkAE81zp0eCK+HKGAU3
         atGke3u7qLzQleXxzFWpH9c/kiIOH5TwpP4aDmtePlzUDJ2EYW6WYxFRwEcOYX9RNeA8
         pUzn9FvO94oiF9t8FkYZ7d5jKwqK+4iH5TUIxFFvXQzefNb9sQ0hHFd+F27yB6/4cLrT
         o3xsZRFfIb/Y/DDDsoeZcmSvxR0x/77mt5gbi7v6Ntsu8dgJ6kY5UD3TtJtwEHI6pCTf
         AFYJcFKGtM+74K3GDTOq6hm//6mQcxklLem4F/zkdAMzlfCwbafUaH0Z/OZE9oNge/BY
         OtDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgLr7id3qD0ExDpuYIaD7K0Fgkbbz5gfPL1NEcKO4D0V2u62eQVvPHAb7oc1QclSC65mZYfqq/kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxY3KRnDqnk6UiCuO8nLAOb0zV2cTopSZgOzzSp3jj4DVY0pRb+
	FpXtyBDU8Z5jOc066XYfsX7URmYDmlRP7JhGTHUc034Psguu/X377009abVaNPUaupQJf1zlLCk
	5qSTFWTXR8gw6bfXjMap7UHKT7JcWbPAVABSna27S/FfdBnp+U8mCWzegJIXXjw==
X-Gm-Gg: AZuq6aJf4eHAXOJFBiTZa3vsuoaVMMiMBHWKNmNzImdnF1fYhrdc3mc6aGX//5AB/s3
	CNok1E1RFgG4ACtAI77JgWGK6KsUFMpd5UWqm5tY3C7QWJO6FldY8dLHucOn3iWD5EihWaPQgRP
	hRJk/S8lljxhJyfhPmHb9eAqNKzbSxuU7ePb4DunVRHOVPefwtDKMjkGwSPyIO6yeapUC+jRtXg
	s/ikkfRFJKxz4lyRUQjTxEfXvawPimGxSpCI4QdhGFAgBTzRJWe7SLu819BrkGSoA+8CK09iO5f
	SaoeRqvwEsavU7sv4t1P5nFW7qKQJZ3nr3vlVabBZMp6bXpT3ox2ZYWDcgfCCb7XgGp7nzOI/cM
	6/zyFpIWcRSP+vQFK2K7TnasybIgqFl7GqIu1ZiUBWqrVHdrxVYgIYEOCNj/tj7TWL4HD2o64ym
	N5MAL8oz0HLw+vE3qYUlBp2rY=
X-Received: by 2002:a05:620a:4723:b0:8b2:e0db:e639 with SMTP id af79cd13be357-8ca204cd086mr614825585a.32.1770166800198;
        Tue, 03 Feb 2026 17:00:00 -0800 (PST)
X-Received: by 2002:a05:620a:4723:b0:8b2:e0db:e639 with SMTP id af79cd13be357-8ca204cd086mr614820985a.32.1770166799720;
        Tue, 03 Feb 2026 16:59:59 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e386ff563sm253405e87.1.2026.02.03.16.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 16:59:57 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 04 Feb 2026 02:59:50 +0200
Subject: [PATCH v3 2/7] media: dt-bindings: qcom,sm8250-venus: sort out
 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-iris-venus-fix-sm8250-v3-2-70fa68e57f96@oss.qualcomm.com>
References: <20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com>
In-Reply-To: <20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DrFwEkIoYrD1qa5tx9EdrYljNPefynFUvMATHqt7Zhg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpgpoHGVXP1oPuZ1HuUzywdpPWCvtW3w+jr4aSM
 y/VnjMcAf2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaYKaBwAKCRCLPIo+Aiko
 1URPB/9AbHHnOcBK0yW1YvGlYOkWgOh7u5KCk0ZVSgqo0xge7DvEHmVVxxD/P1sQxFA65QGswBT
 TZdKhKTqca9+6fPUjh0BVrkCYPAK+/yj9TUZOYnIJCvSl9TiIIAVbkrjQTW5zhVQkJY0b7asY3i
 O8RuKd86nreQOjaqhDl5lZEZIpUF1tL3mytnS2Q5ka3fvdAyibGpul+zgxBe6qwkLhMCyR/Huea
 dRigVV0bMz2b3othCMm5yTbD4ld2O6C8538X0oKnKyzBzHKxZ06dQDrXKIDSpzNr/ewcRxErGDA
 PKllVBMVXDCzw5DFeUIQVpKHURpbMzaCTZf711bnD6XLOryV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: KFUlQQNgS_bfXaRcHqhAvSxMCnUCrdez
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAwNCBTYWx0ZWRfX9CA5wRZ9G6aa
 tI7Bn10o3gF2RQ2PZipZ251M8xQgdUqFI6okm2ObdH7K83S2xIYmMHm7Qwrw8COWs2wJXCOnZU9
 QP50DjL8RMUoHozOaW6eAUgELD2vpiJ9gP4AoF6cjyr4hHpwExB8DQr2gNvMXRCZuFCieA+y+WJ
 SELOszZhMsltC1avxSMFhGaD+O144ePimd026+PMoaiP10X92WNxNZvzi+tujER9LGeXsq4ZjrW
 Pl6nCsIODYPO3L3vTVlITqYDNNZiRSpRHFUhEsaNMWJ/eoTwTLenOhb7a/AiFEvYcejwzkw0wIN
 esXQXbrUG5iHHdwmXsiXcjsGcq5IocTHPgy9j9oPgcblhoQszSbHld3oXeE4tqhqlqvfZzbh8DV
 uDBpC3pshaPUR5H/tqvF3heZHQ/7WuR2UJ4UwQnQn8m0YCzR90uRMSFokre/o1I7LOpMJcLYGfR
 dOxhX1VD2UXXsZDhc9w==
X-Authority-Analysis: v=2.4 cv=TZmbdBQh c=1 sm=1 tr=0 ts=69829a11 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=V4YYwRrX08S5_i0GLdQA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: KFUlQQNgS_bfXaRcHqhAvSxMCnUCrdez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040004
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42022-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3381CE02F2
X-Rspamd-Action: no action

First of all, on SM8250 Iris (ex-Venus) core needs to scale clocks which
are powered by the MMCX domain. Add MMCX domain to the list of the power
domain to be used on this platform.

While we are at it, drop minItems from both power-domains and
power-domains-names, it doesn't make sense from the hardware point of
view. There are always 2 GDSCs and two power rails wired to the video
clock controller and Venus. Disallow passing just two.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
index da54493220c9..04cbacc251d7 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
@@ -21,15 +21,14 @@ properties:
     const: qcom,sm8250-venus
 
   power-domains:
-    minItems: 2
-    maxItems: 3
+    maxItems: 4
 
   power-domain-names:
-    minItems: 2
     items:
       - const: venus
       - const: vcodec0
       - const: mx
+      - const: mmcx
 
   clocks:
     maxItems: 3
@@ -114,8 +113,9 @@ examples:
         interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
         power-domains = <&videocc MVS0C_GDSC>,
                         <&videocc MVS0_GDSC>,
-                        <&rpmhpd RPMHPD_MX>;
-        power-domain-names = "venus", "vcodec0", "mx";
+                        <&rpmhpd RPMHPD_MX>,
+                        <&rpmhpd RPMHPD_MMCX>;
+        power-domain-names = "venus", "vcodec0", "mx", "mmcx";
 
         clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
                  <&videocc VIDEO_CC_MVS0C_CLK>,

-- 
2.47.3


