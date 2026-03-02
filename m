Return-Path: <linux-pm+bounces-43395-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPfzB3ZxpWlXAgYAu9opvQ
	(envelope-from <linux-pm+bounces-43395-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 12:16:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF50C1D74E4
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 12:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DE0A3027B60
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 11:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0965D360751;
	Mon,  2 Mar 2026 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SD1/ZOh7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iFGGHL18"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34C2361654
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450054; cv=none; b=eDJ84rzffKwZUPpVAXrwfB6vmIn10UqLp57jdh70GFctrC7soo53seuJxqve/6kKhwxqAZthr0oJTboNJa3mFPSfapprEjMheSuIX4ifgFfphRtlC0z8VHmuOdtbgWSddQqgjJVeJ2Buid/kF6RgG6TZYLRZa/n+fUArSjl2jeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450054; c=relaxed/simple;
	bh=OnD+J3Txy8+h5PHGhwbuMoSIh44riSvoH3it3jU0of0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rjoZ0kfJgcFnpQApIPH3ykNW+i2VOpzmTCfAm9ZkDHnpY6ZxaV55nyAGK6zo32EnLSSKYd0yf1S3m3bz645XtxFmPHqHq74BcIXbHlksyMDB4Mft7T/3/ZJaSzNgfcO2va+EFTsFLc9xg52kKOWavPENc+AYQ4StUaHIoMgQxDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SD1/ZOh7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iFGGHL18; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6227nFLD056160
	for <linux-pm@vger.kernel.org>; Mon, 2 Mar 2026 11:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NIYzi8A148bpyLheKetwZ5
	Kk3RO45DknEenbydeicmI=; b=SD1/ZOh7MqleiVqq19R9Ae9tv32NGOj9CjL3/U
	BXx3VVq9Fed6w1TOapBjmiY0/eLUrku/alkI4xRUPBOBmNSCtXBsVYOnCVt6tYWt
	u+5x9H6BB9K7AmH167b90xLacLSpXcTyjjYpgpQ12Hn0NnaKucnB3yigzq3OfGvR
	XpKQrpIhuw9Sf7L5AW+SbOtPTix3a1UnacWACzgfhpcDTUbND7W58gsjK+LDbaX0
	Y/xPkwIsfDdq9wbPIhbLFXdg9umVJX0VKzQCS4ql8M6n0bOf25Z06uTtC8/M6lxS
	jEhEF5VTHGb38j3VzaDb7Dszt5YknlExQi/tSzrTJYby4EpA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cmw64a42a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 11:14:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb0595def4so4214805985a.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 03:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772450052; x=1773054852; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NIYzi8A148bpyLheKetwZ5Kk3RO45DknEenbydeicmI=;
        b=iFGGHL18TDw42TnnuekId87BrHKoK2xM9gH+pJCIL8V5h+T3PXE6gdoD69MlmnCjSs
         a/JQjYRoGUfTSLI2AySSnE6kL8iet/U59fpkW5EW48zVT8GJBARq0Ur/TEos12naFKsc
         nFDx4FWmOx69FuoxuIxB4851d5qywBDEoBv63OkrvByFX/Tjl/Zrmrn54hGe2x1F03Xz
         pcU9yrDUA93DjHlS7bNSfmwzCJiLESwmyhiwwLbm2nboGsOXWOWhMT8YyTp0KJUQk4Sa
         CUc/YOLYlt5alsGZGr1vapyO6MwAyehFQ9IA1Nds6ipla2znmlh9GaX3UVN/PlBjiFFH
         BmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772450052; x=1773054852;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIYzi8A148bpyLheKetwZ5Kk3RO45DknEenbydeicmI=;
        b=F2zZO46JaoxNy2/iyq4r4SyfdKGh2dhkJyZY5tuZNMIr2qqHg00xE9gX53hoh7US++
         MNct7Qbdcm/tKvx+rL0uYzjqCfZBAOf5njTPJULcwb/2Mm2NFBlgONiwVg6CBDjsNvih
         Ub/iTEemM+69vFo55HedFd5y0fOkvaK/yWtXAp+eED63sZly4GZEkk+ufGrtvcKMZYnM
         9T+27R4obVm77LKsHZymMQphRoWxqvTTzczSy/jEdveVnlgE/h5mJfKPSP/Y3is2XU48
         43JOvS9oThdqvj8yFlqr4qSk+tVqgseDo8OKHRuKjJry3kjIL2uGi8e9D09ES0Hd54B2
         ha6g==
X-Forwarded-Encrypted: i=1; AJvYcCU3VVRXoF7rM9SgIjAZkLMPK/5yDhnpi3ACGdgxHkDo5xGSzyp7tuDrsktKZrX5YBX6TfOkxKRUrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGBm05SwUMsaQoNWQJwnGgzPbO6iTeKYVL6tndI/CuC6xFs80a
	wpjaO/D1EOZp6jHBVbOK25Mu0KTs4qt+kz28qlZfSeOjmryxmwZ5FWnMyg6u2lCBCkn8RNLXPpg
	VwZHgYO9BXtCbzCmYaxkzVXnIkGVam3rBWDjGL4z4w5C3cSN+ZS5UcvivprpHeA==
X-Gm-Gg: ATEYQzxYl7V646++dxQAPQrKPjhHY64aSnvI0Sd3GK47z6MYqN6wRfrlTUhY8dnLn1B
	0Tw0BYdDtNFz32yUB+i9zjlLWmyH1yx3Ar8/pIi577UejMgzQo2XCNkq6EOILH3A56ZbXcJSwMK
	FjtDf2c4A92PCRKk+GYcTequzJMjD0HQTSjd5g9cO8s55RYg8ik4D7ckEccwKibyJJnmAz2jZnj
	8Gms2DOE6F3rL3UR0cEruxwyLasb91LyXQ9y7G0Mc4G3Mj2+TwE88sGoHLUQhkCRiwTO709cdT4
	LZzSK0GG69D6bWIlDdR8Dxk5ioPQsQvbt+N3FWZ4Baql07OfC0C0fcsX69WBEtsdhzZrT+rtE56
	YE+jcPTqQWS7MJom0zb2lhxE7b1gYEA==
X-Received: by 2002:a05:620a:25cc:b0:8c7:1271:f336 with SMTP id af79cd13be357-8cbbf35265emr1688084685a.2.1772450051852;
        Mon, 02 Mar 2026 03:14:11 -0800 (PST)
X-Received: by 2002:a05:620a:25cc:b0:8c7:1271:f336 with SMTP id af79cd13be357-8cbbf35265emr1688080685a.2.1772450051242;
        Mon, 02 Mar 2026 03:14:11 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm422850805e9.7.2026.03.02.03.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:14:10 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 13:14:03 +0200
Subject: [PATCH v2] dt-bindings: interconnect: OSM L3: Add Eliza EPSS L3
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-eliza-bindings-interconnect-epss-l3-v2-1-05b1848b98cc@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPpwpWkC/42Oyw6CMBBFf4V07ZC2GHys/A/DotABxmCLHSAq4
 d8tGPduJjnJvffMLBgDIYtzMouAEzF5F0HvElG1xjUIZCMLLXUutdaAHb0NlOQsuYaB3ICh8s5
 hNQD2zNBloOq9VFKhzS2KuNQHrOm5Wa7Fl3ksb7GyTq+Jlnjw4bW9Mak19zNmfxknBQpqc8xOB
 2lzafDimdPHaLrK3+9pPKJYluUDBcH8GO8AAAA=
X-Change-ID: 20260222-eliza-bindings-interconnect-epss-l3-1f40101ed6de
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=OnD+J3Txy8+h5PHGhwbuMoSIh44riSvoH3it3jU0of0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBppXEA4oqplbct07JUcCF8YXpQN3RGDJNKoGd9u
 qKZvUcNlfaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaaVxAAAKCRAbX0TJAJUV
 VsxfEACOFICna6hipUPqEf2JBZP3hrGRhYTHBrfKWIPrNo/H8odyyK9B/hY1/8NA2ecRJgfr/JN
 KqjxHUOhC37da2q813Ezn+858ZhwapQXrd8ty3NMjqPvcaxiWhcpE5ucZaupU88XbeivURmJwhP
 OGeNMAyRfdoCAIUgt8sHNeVvvYJqKrkMTGd2HVInieJMG8XlESEkNOrroOfFhnAEahKFzZ2PHsk
 KFparm8meoHzwaLDUxmodjJ8402lrF18QdGDeOVUA0GaGAg0rZCfq42lqYIlMso+REol918QDUM
 03h8xaLeQS4foNI73nn929aTu1T8ddSvSFboSD+8au5VGxJdwTfOrSPGNYfNkUY8urbUvQW1DcJ
 ywKYwirN9i+ftdmi6fc+41q00z2kUpTA3M/en4Fbs2ZYEOPMjPYhEpT01wEQoCchmWrirjq4poo
 5ISVopfUHR/WtozyueSgR/yXDP/rezRgtRd9/YXRmJL5JY3yW2GDYH3VL0ZWEB/+eF2LxUS92pg
 6gYca2f/nThwITK7wOh5Dhm1a020Tu5WsRcTzVF81eoKfnP1ZP35M50IlK+s81KvKTd1SDCKDxd
 If/MBaSP4in1kIld962vh2wAUCAPp32oIhVGJWaahDEt7STvQEHVNW7Ybn4ZKzOnGNU12rQegC9
 RH6UcVN8XIheLKA==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-GUID: bYfEZeQ9wi4GlzoaVila_EE8WSOqNCi6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5MiBTYWx0ZWRfXytGEmbMbl+Lk
 SXPlTNzMUVBRuhcnqBczOyHSV/H92ludAewoYBcUZHQ4dhvzaTuXXznFWv9Z2oO1k7F828Gq890
 AJeBDwKSEEvpywfunzup0OKWeGOjMCRuOVhUbBuubDFGOEl13WLYDDBO1zjXf/cGIB56bDtq5cS
 yZeUt1YIrVJl7x+lEiJGQ8Pri/5lJxYl5ZoZbtYH3C9VH3mz/o8q+6qr+Y1mP0KZlh+qYnDnduw
 rXzdpnaONVssHhVaJLJW16AzvL7rCbTg/vMzJlapFg43FiI4HWiexBSffhpQvQxcfE9Dpt92qtA
 ewbBVIMz1Yn1yQDpqGh3QISDvyan8Rq/hhsAaQEf5mIOFtfarXy/VkZFlf+5thAGSXgDssn6wYc
 l4vmSZMTYGuAjla7RkTDAVWCSbYtgk+rOwls1A8knwyJomy38W+Ox4ryn15+wYFj69ekVPXkqGk
 dESZws7yxhyRZwLgmdA==
X-Proofpoint-ORIG-GUID: bYfEZeQ9wi4GlzoaVila_EE8WSOqNCi6
X-Authority-Analysis: v=2.4 cv=I5Vohdgg c=1 sm=1 tr=0 ts=69a57104 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=gZAgmGDqgr9CJ8NO_tEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020092
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43395-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BF50C1D74E4
X-Rspamd-Action: no action

Eliza, similarly to SM8650, uses EPSS hardware for L3 scaling.
Document it.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Changes in v2:
- Re-worded commit message to reflect compatibility with SM8650
  and replaced the OSM with EPSS, as Krzysztof suggested.
- Link to v1: https://patch.msgid.link/20260223-eliza-bindings-interconnect-epss-l3-v1-1-fa83970d60ae@oss.qualcomm.com
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 4b9b98fbe8f2..6182599eb3c1 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -28,6 +28,7 @@ properties:
           - const: qcom,osm-l3
       - items:
           - enum:
+              - qcom,eliza-epss-l3
               - qcom,sa8775p-epss-l3
               - qcom,sc7280-epss-l3
               - qcom,sc8280xp-epss-l3

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260222-eliza-bindings-interconnect-epss-l3-1f40101ed6de

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>


