Return-Path: <linux-pm+bounces-42295-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JXgMaQiiWkK3AQAu9opvQ
	(envelope-from <linux-pm+bounces-42295-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 00:56:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A2710AAB6
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 00:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B65693015841
	for <lists+linux-pm@lfdr.de>; Sun,  8 Feb 2026 23:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BB03876C7;
	Sun,  8 Feb 2026 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A8QNw2q+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Li9l+T7R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD03876B7
	for <linux-pm@vger.kernel.org>; Sun,  8 Feb 2026 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770594947; cv=none; b=uG/7/pQmso2e17oXEBuHSIPULhttu1+Juqcyr7r11rBOwyOhHQSmyNmU/WjC6C2yAdSWCZoRPox19QOVdvzwr9bLBWgoqz6vt7a8WYC8Cg4yTYWEDXHYw5uzjgihgYEE9nkIT98UgsCxqaOJ6v5A5mGDPe8Qn8R/igA6TXZO/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770594947; c=relaxed/simple;
	bh=mp7znh5yUTXGIVAo3yop0t0MQrXUpW7C9vuYHOlkZ+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thJwP83k1z8ahw6uMfzHY+Fh6YpGOgEMqx1MZtoGohgijuHG19rBE6T9VRdChfKw0A76mnKUBuVTcT8PQKHMSFyXChsQ/wi8TRpLEp9ugbyF//7fFUtQ0SGA0VYdV+iZcQGt9sqogg+Vse3a/2P2zutoRCu7l8XXYHrQ1UurvxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A8QNw2q+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Li9l+T7R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618Kr7n81479197
	for <linux-pm@vger.kernel.org>; Sun, 8 Feb 2026 23:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OLZC7NStGj9UHK+dN1GsxWqO1A6r1SVJAMjsxlitvPk=; b=A8QNw2q+F7dJuDbi
	6+p8hYYHyYRRJdzBuNurSUflkfvtgq6iorVhLR7si/mgrt6SeVwKRmqGlOKe0Dzg
	JcCXhRzK7j25xeGgTNCIZIEK6MTckH8NpdEt68CSudyrLBA/VTtARK8SFzmxaHxO
	W2yThWC+iM/pj3G92Dp3OUQjuFZQjuNnvtyfpsiMiNML/3dWqJtnZ6K5xNs6anHP
	+XwL6RnXWKH8sQIqztfy3jYzZ/TULEaOprPkvCRZ+0575TFi0SO/B0EjWh+eEuNJ
	zGVmWY0rGBZNGaAVmC7ioYgZph7+RzhTG7ElorkICwuN9zlIk/db4SxAjZJt/dq4
	EHZqHg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xccu346-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 23:55:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6ae763d03so409480985a.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Feb 2026 15:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770594946; x=1771199746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLZC7NStGj9UHK+dN1GsxWqO1A6r1SVJAMjsxlitvPk=;
        b=Li9l+T7Rr7W/o+vmRCIRV3nxvXEXSTDs1W2YJDiIqR0ehlZjL1+h3AfnThKShhQbEC
         g9TfDr1j2N5qmCiRa3JI1fJYYqJL74uJrr09sdxm51M5tu/2S8BNQatmgKvc/U0YqEB1
         j9ppdONvMuVruhJyesDv8tRRjAR5uE+cJRjbKeDEWgCW2Bk3pt/Pxrd01V8wkn4dxFj0
         Y/ycKtgKLMuPDZjMGuQT2xVoCdCrWWb0HMqP/BhHoIqgR9Kv/I8yaZhkLOuFS0nDou9t
         pz0Ln6jLb2zpXRh92N4dWbaizZrpChSnULYq99xzNhP5f7SpzoURyeLTronIUqburuqK
         pGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770594946; x=1771199746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OLZC7NStGj9UHK+dN1GsxWqO1A6r1SVJAMjsxlitvPk=;
        b=amgeVmi4py6CcnCy2Ru1T2MqJ8TxlZ3PLVy8eIUDY8ibhWq9ReEH4Ygk6H5/g5NsR3
         FRSAIw0S/AAHI3JQRbKRdj3SySdNkntKLqdmztdXnid/IbPzbThmcqApkZVrZcy4zKEf
         wLQk3CgTWi21Hg6eDNDak2BgyOeM+FvwiwougWP/gx5vLikBR0EutMWim0cPBzzeLmj7
         kDu9O9/Q5ZD2YAO0506YOUAMbuI0kESUUR/BPg3to/cNlaGdD76XvVw/kVMxjrdpOn00
         pt1yDuQj7ckHupuhnd+oph+I9VjRIQCRLzwyu/xcC4kCJOQeLhwTaVJwHp/vm6zg7Y6z
         NKxw==
X-Forwarded-Encrypted: i=1; AJvYcCVhUCR9HFL+wMDl89CTFa9lKwFA30f+PVtf9GtOjKYbjH+o6CMrrjAwC+Kl3thaM4KlKxWX+IRX1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv654Z1kC8aoyWOw8xq5Dk0Nr0ERDPbR29qiPZ6pD+M9YZsOGN
	6lwGABViKfzLD/Swm96stVqb12EGhat4bCEjxG3/BQ8ZG/eVntg9nalGgsx8Nvsi8HI9VpIgFVh
	30KxEwkViibibKmSZzHjPw6SlysOcyaJsqZPlh92CGvbH8t/wG64Va92RQvyZ1g==
X-Gm-Gg: AZuq6aIH0nJYxaUY9V599KJbLJcOo8cDJGCMt0QgsZU1puWF8AmyfdReHYJRE3Ae36S
	h8TSTUeaeNxjJgL97gaQx+42gtokTxHX1jJ6F5IUTNckAMbzUUt0CEGCTISt9z43gOcqTbdQKwD
	cWtaSGrCZO6pM1OKl0uNp1+eNVDE8seGYn6QbyLC0QDAfzqHiJCf1UHTU+tEbORdUfL+PpCss9s
	IriAR5ywVASyFdJ5HJWQIIs0KarqxzST4zHT4pRNCyfpNI0Xh7tia9pnx1vqe3qmcan5yn46N/L
	22ajuayhS+iR87/bB4UEThz+WtemaI5/gYItthKL1LZc2pTtBYs9MOuaIQIVGgGllW1MpGWBYbE
	PvjlobnTm+3R+9npygX9NPSX8u+PxxhKL0OHY66AjLDMFS1QlyclZtlWglVfiJZN3C6ubsYiN29
	ZoDtjuBCKDeYes0LhIIklll6o=
X-Received: by 2002:a05:620a:4506:b0:8b2:9fab:d7d4 with SMTP id af79cd13be357-8caef7e16aamr1193762685a.38.1770594945637;
        Sun, 08 Feb 2026 15:55:45 -0800 (PST)
X-Received: by 2002:a05:620a:4506:b0:8b2:9fab:d7d4 with SMTP id af79cd13be357-8caef7e16aamr1193757985a.38.1770594945056;
        Sun, 08 Feb 2026 15:55:45 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6ee4sm2188074e87.4.2026.02.08.15.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 15:55:44 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 09 Feb 2026 01:55:38 +0200
Subject: [PATCH v4 4/5] arm64: dts: qcom: sm8250: sort out Iris power
 domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-iris-venus-fix-sm8250-v4-4-9662a0471d82@oss.qualcomm.com>
References: <20260209-iris-venus-fix-sm8250-v4-0-9662a0471d82@oss.qualcomm.com>
In-Reply-To: <20260209-iris-venus-fix-sm8250-v4-0-9662a0471d82@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2348;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mp7znh5yUTXGIVAo3yop0t0MQrXUpW7C9vuYHOlkZ+4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpiSJ6kW7QR98yeuApeUex1KSRnszYqgJ3u6AQD
 sUS9PBj/eeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaYkiegAKCRCLPIo+Aiko
 1Q1GB/4u7BiqyNOw5NHYYW0n/v6ucOYEb1TE0oTRy21Riw2Td2HAdOQgJGjCxj/AGKBIPRRKdHu
 16pkQZkRpQWgpM1uvfkN6TKbnwnyzgGA6s7jVde+Y9tBeGxHCwyBF+rtduXFzHSFBqus439i26e
 pBpL1C0u8TD2w3kRy20lc/D9p5gsezozNQzhXM8G8yjqQMe5WJWSAEplVRXdXzd+9cQ4oV+XpRP
 xshrwuzyl8GoJfyT7UL4w8rOgor51lV72Yo/CznOD16dX3tr6xRF5ogtlAOPK6tStyaxzcB281C
 H3zbW1Pn5z653djOxQ5uP+61kt1lnnOIJAFhwVsu/OlxvvD4
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDIwNiBTYWx0ZWRfX2f63essaWD2/
 oLU5SjRerDM4EHwfi2a7itQi0tqT2Sj0H0aPXu1Wffl8CMeOPhj4y7UqvLgU52zSaqsqZyEIgn+
 axpOSs8JUZf+wPraiiRRTDrc19ZeJkEEeoGf3gukXbKKJsIBQ766OgbaySIblT2JPNq4Gsx/gKm
 5M3x96kd1RSPXXNd6M99tVt5KuwqbyfAzmSmyKnBs7uq1VFSUQ0X8C0k+197VgNSE3at4k0fCM/
 qtRAHvkziJNh1ymgJVxVJSObsuXgFmnqSe8nIH9ABtV+f0UC6F3QwiXOQmRzHHQAAydIZeZiBny
 KbQJRq1kLfWqw11C1af1g45mm76XnoyTSv2SI7cVMa5mt7q8afvIPine2JynVQ3fhZhVDz6+EF9
 JFHkIIRmfG8Sl2eO41UJjykFoEOaKKuLRcU78BCXFjvpHlS12Aq1KzLO9+rQY9q8ySlUxaCXO6L
 jeuvhCy/OGtMtaViDcA==
X-Proofpoint-GUID: lFgSX5ITsndYV8ZoL7IFrtGieFVUxKT2
X-Authority-Analysis: v=2.4 cv=ft/RpV4f c=1 sm=1 tr=0 ts=69892282 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=tBOqMctlXquWO7Kigf0A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: lFgSX5ITsndYV8ZoL7IFrtGieFVUxKT2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602080206
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
	TAGGED_FROM(0.00)[bounces-42295-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 88A2710AAB6
X-Rspamd-Action: no action

On SM8250 Iris core requires two power rails to function, MX (for PLLs)
and MMCX (for everything else). The commit fa245b3f06cd ("arm64: dts:
qcom: sm8250: Add venus DT node") added only MX power rail, but,
strangely enough, using MMCX voltage levels.

Add MMCX domain together with the (more correct) MX OPP levels.

Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index c7dffa440074..a1ab8c3c27e6 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4321,8 +4321,12 @@ venus: video-codec@aa00000 {
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&videocc MVS0C_GDSC>,
 					<&videocc MVS0_GDSC>,
-					<&rpmhpd RPMHPD_MX>;
-			power-domain-names = "venus", "vcodec0", "mx";
+					<&rpmhpd RPMHPD_MX>,
+					<&rpmhpd RPMHPD_MMCX>;
+			power-domain-names = "venus",
+					     "vcodec0",
+					     "mx",
+					     "mmcx";
 			operating-points-v2 = <&venus_opp_table>;
 
 			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
@@ -4348,22 +4352,26 @@ venus_opp_table: opp-table {
 
 				opp-720000000 {
 					opp-hz = /bits/ 64 <720000000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_low_svs>;
 				};
 
 				opp-1014000000 {
 					opp-hz = /bits/ 64 <1014000000>;
-					required-opps = <&rpmhpd_opp_svs>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_svs>;
 				};
 
 				opp-1098000000 {
 					opp-hz = /bits/ 64 <1098000000>;
-					required-opps = <&rpmhpd_opp_svs_l1>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_svs_l1>;
 				};
 
 				opp-1332000000 {
 					opp-hz = /bits/ 64 <1332000000>;
-					required-opps = <&rpmhpd_opp_nom>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_nom>;
 				};
 			};
 		};

-- 
2.47.3


