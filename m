Return-Path: <linux-pm+bounces-42496-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJTCKgdIjGkHkgAAu9opvQ
	(envelope-from <linux-pm+bounces-42496-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 10:12:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 626C612299F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 10:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E31563014C51
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 09:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3E3559D5;
	Wed, 11 Feb 2026 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f3J7EYu+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gIbaOAfJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE9355809
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770801109; cv=none; b=gXfn2033cL4zAHvv2Ckq9yax3ubyh+5GLeIS8cZ3Su7F1O1D9KMdHefRGwkiaAiumndN4eW/WJ4FQXkPcHdravQJ1MCD9xd166GDBz+fsMFy5+m5aJIUxFsxqNxYlFFuf/xC+dgqpeGWFWWSccEHuRG5W/wZi06SKXeUinUdu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770801109; c=relaxed/simple;
	bh=El955TNgfEq+vvMUrMWi658/CEwsO58kNBlEcBMeI40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgMmv7FZbQOSt+IOcjMf4fPaN3Dx03Cr0677rUtfI41SrD9rXbZckHT9h+9madfjMby/935T6LwwnbTAmFQ3uKbNDBdCvIlotyaxfJiyBlBfw/haJAhLvbJlvmJNiCXYRKL9rSD9iOjh17n1W58Ugjhvn9A8WTooFkIFzQyQhcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f3J7EYu+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gIbaOAfJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B8Nwd24176958
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 09:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hQ51JRlPSt5
	s4B9/yYRO3CccNJAWz6AxalLUGQMD9Nk=; b=f3J7EYu+eIK+xYajZp2CO4EKjNu
	HKjKL79xrU7LXj/JQL8GUnd+Zp9qU0QFrXvMoF7V/CAtZPUQuBqlkhqxMcuMbG8e
	7/AlZsO25mUuAxmXzw6pl/vyZTLRxc++Zdlu2IO5J9rx3d7MIVt+6ETa6aMLwEof
	vW4R+QfBt4QdLSs4axzemQmWJOUziON2Kex3TXeJ56tIVcJPxX0lTx+e05KZ+9ne
	5ZruBEEA3YU5CXC67juWuMuw0PyJns3XD780kv5hXx4A9UNTODVhMoXWl8mbE49y
	NgLVh/O07isP4EfZPVA6IXqlGs/tw/dDvGtyaZwoLQNZSxnkZ8Fc/E3qLxA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c879mk3r2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 09:11:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a8f8c81d02so66178385ad.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 01:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770801107; x=1771405907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ51JRlPSt5s4B9/yYRO3CccNJAWz6AxalLUGQMD9Nk=;
        b=gIbaOAfJleEvYlhjxjR1dWB8VTveydPh914vlbNLPi19xgDXnm9WzCWHhme7lmVa0v
         emwASCu0R+Uy/pLi466CLoZZZeNfKUuWZVJnDOe3LaRJ7mfieuFIWY3jZCsMJ0JLMjd3
         uTmqf32eZtZcsszR9uYOpNM4cZEarUKNmK1O1s7FWIXZHk3pvMOw0iGoUXytIpgvFL5A
         wWl/HHwPi0lDCWBY8suCUoG3sZfv3XNjJtsNoOq8kGJUxFmreELsIyIUXG2HLPL9EpjP
         g9SoO/xWeeOggRGO1VQa7EEMnoxecTS8tsXBRTDccggmhz/5MmelOQIMTOsl/cidMm92
         6B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770801107; x=1771405907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hQ51JRlPSt5s4B9/yYRO3CccNJAWz6AxalLUGQMD9Nk=;
        b=S9KVkM7YkCXSDnOz4Mq4fPvXnzL2jKPfooE+9EnkPIt6B170qdjtehD67V8n6Z5FFf
         bOIeZaYqBqE1Hh26FCUjI5FwEPxg8mjlf8LJiEHfFecHDkB+rIniWfoE4LWQqFqZ72O6
         nUy4ewOSQYGlJeVEiVw7Q9BDma6fKDt9OLPwCxaBhbxkg0d4H8zbg9P+q0kSC2vY+4c1
         jlYBQ2z7fPTy3NdojGS2Xuug8HTmImPtkR9T07hAuphzA9nDeVSUF36VD2ZbpUGI5xUt
         Yo8nWXqISmJBdN/54PiqqM4tELZhGwA6vJlJmtVSW0k4+P1zhSOmvW0ry4dG5tAihCC4
         dWag==
X-Forwarded-Encrypted: i=1; AJvYcCXJ2cpDPK7GPIOXQdFNuQWnpDIaQ5Z+Vxe/3v9v12yEFndxgc9y57xsldEyclVWe+nTul2inBcWiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGtMhaXDdqVY08XeFS/xTrGVCFja5qsyN6IEXViKzfxNWnmjQ
	Q6icGAhCDlfQqwMptKsgBb1E2cEh7g8/eBOPDaF6dOLaNT6e9HV8Tx6uEuCQR1JLYF0cBIQXktH
	anoBAPWJuibhW9GKDhGGCmC/uIuzHLROIJ1Vc4SLaqy77OYx5xa17626ivCXjlg==
X-Gm-Gg: AZuq6aKg6MunQgggwJOjGfeCQQY1Km/6/qtGzaXVn/yPgBHrhgbOMYM2xA6ntjKpFme
	NKbsmDwkaxcPU4IeUJ9TAr2u0ectEm6XBIHFsKaJvVLJJKzMwgdxs3wZZi4pUpXwuNTipa6wK3W
	Y30f8Lu34rpDYO6cOfL07J9OisVJfVqjlpWKUd/6cx5Zip9hYqF4t7VkpuJVuJZ3zkhMID31Xu3
	ZcL6g933Odcm8RUCFOrBMQ8YZbS8dLmuE3cqaZTXNIF5f+VDOMQVd3BG3E5XSyFrGyu8kNvho6Z
	NJU6sUCxioxTcOQ9gBr+ciXbd4/1vAI0L2MxdVMr22hEo6k+sd2MVlWoHvcGSHYxx8gdbaPqduS
	8VvU8Xkr2a7K4doVZZK73f51dFk3soF+Q3VQtox3vLEkGhtjXg1LkZE4=
X-Received: by 2002:a05:6a21:6f0a:b0:392:e5eb:f0e with SMTP id adf61e73a8af0-39417fb11e3mr5175944637.65.1770801107384;
        Wed, 11 Feb 2026 01:11:47 -0800 (PST)
X-Received: by 2002:a05:6a21:6f0a:b0:392:e5eb:f0e with SMTP id adf61e73a8af0-39417fb11e3mr5175913637.65.1770801106936;
        Wed, 11 Feb 2026 01:11:46 -0800 (PST)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e1981512bsm1521481a12.31.2026.02.11.01.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 01:11:46 -0800 (PST)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH v2 3/3] arm64: dts: qcom: talos: Add clocks for QoS configuration
Date: Wed, 11 Feb 2026 14:41:12 +0530
Message-ID: <20260211091112.3285626-4-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260211091112.3285626-1-odelu.kukatla@oss.qualcomm.com>
References: <20260211091112.3285626-1-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKjQ3Sfy c=1 sm=1 tr=0 ts=698c47d4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=7s_9-EB0MOrke_GCL94A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA3NCBTYWx0ZWRfX5Y0ar2kjQizc
 +Ns+wb0+5QNDTSKHmYHBxV3LaWtE4U8dXzEq4bk2QbM7TxzQsyfPj4/2IXgLnVoeX2lNDgC7gep
 FjflCzo1eroqzukWgN7pe0GxrIhlggDguTeZSFcZ6QdGB3W7BGuq14uEvIrdJn4OH9HPHsl8TlA
 Qid46pt4fXpt8ZyeMwJsrJDnYla2gPNobdR1HRJ4tNmAtAP6xoRea/JOSs+6IfallNJP5n3FSoC
 4WFvpXqf1psdwvvlZpT/G5Zt9NrOEj2hvLu5tEqLZAVgbDmPWcSF4p1LNA4uMQrpiJ4yckx0vr2
 Ca4Xg6cn3SjKM2BLTouW9tjI2Jq4BOTZisYCodjEnBuUhzXIpxu+iIW/1lUlcEUUsNOCEt/b3V3
 6shzVpPUTv/BQk5/+1N0Zei2JFfDX6Fkwj1WFwKhQaXYr8vg7RTw55yF/Nk2TjTgCNJezk4+zUO
 VQkhDgiGdCLS4sm00Mg==
X-Proofpoint-ORIG-GUID: anJQh7G6JNW-w9JgR9-F3IkOvia_pDD-
X-Proofpoint-GUID: anJQh7G6JNW-w9JgR9-F3IkOvia_pDD-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110074
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42496-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.25.240.160:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[odelu.kukatla@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_PROHIBIT(0.00)[0.26.140.224:email];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 626C612299F
X-Rspamd-Action: no action

Add clocks which need to be enabled for configuring QoS on
talos SoC.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index 75716b4a58d6..232232b02265 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -1234,6 +1234,10 @@ aggre1_noc: interconnect@1700000 {
 			compatible = "qcom,qcs615-aggre1-noc";
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB2_SEC_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&rpmhcc RPMH_IPA_CLK>;
 		};
 
 		mmss_noc: interconnect@1740000 {
-- 
2.43.0


