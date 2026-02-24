Return-Path: <linux-pm+bounces-43118-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIEqMFh0nWmAQAQAu9opvQ
	(envelope-from <linux-pm+bounces-43118-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 10:50:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2C7184EB6
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 10:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2803430480EA
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309FE374180;
	Tue, 24 Feb 2026 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SL+hm4gY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DmqO/bxV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31EC36AB45
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926601; cv=none; b=DsGpPbH2DjnuN3ASq5x7pgfCynmkvdaC2bryIpG+ATAd7NWQESt4EcRIGW1VG/Nd/D+Ggj8iJVTjNzTIm8VEQzok80WDHuHHnQv4bSCon48YTqBUds/A1KIsK/3cQH8v5m6GHNvwprGOikwcu9zp30sQVordrzjYHQ/wbkBZvp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926601; c=relaxed/simple;
	bh=qqfw9w0awQ71hzTYm+p8jQGQFb1k+CxmUX9o301++j4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L2FJj9kdmGpO3G9J3zVr9VQarxfd0xEbCM2F8e60R0tWBiG55+zwAxfxbUeLhrb2hB7JBvtP+/ozcJKtb4n3Jh794oh6k+qZaXbLXe+SimOC0RzgnbITQHlmUHGtuwDRBXCVeXsTjpWgR1lTIt0CR52Arfb70fubqZyz7WDY1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SL+hm4gY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DmqO/bxV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O4LjA32808593
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 09:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ihc1i2j/q8cxZfXwCx9hWk
	44X+mHIq/FDDXzsxYfsps=; b=SL+hm4gYrpMb0R5ng4CfkEpTcHtFoEnnfuAZ/1
	l07r7U59eyHVUrNBZp86TPsWlUcE+SvZzhhg+AI115xrBIbxv9xmF4BIfxul84cQ
	0GnuwQnDYpmmdmBiNcXqP90VAOWFtHt3Pyln/P3K7PVAIJXLQdxptNFAB7f42h9j
	MMeeZ+hi7NT60wwRk6gw1KX3TBPycwNd5g603Zfhz6Qa6cu05j4FGR6DMg1sDiT7
	78CuYWdxpjHzAjCz9rXI9yOuVwuvzP7ewRWmP0b9r68S9rZSVpH5ukKboXigisVo
	kJZcp/wo/HG0JC9GITxiN7bs8xtsAIB7SbFufu2CtbLFG8NQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8rbstr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 09:49:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c711251ac5so4125700785a.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 01:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771926596; x=1772531396; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihc1i2j/q8cxZfXwCx9hWk44X+mHIq/FDDXzsxYfsps=;
        b=DmqO/bxVEkOTqm/q0nYSXo80XDKQT3Vh/cWer/R2WAIwksE/eFWUMEDQ/fRZzfxBtB
         uPXXJ6qW1gYA+jnSylDNopCj4Y8+h09Rp6syvXwr41Ne8tOs9vrUIvqKd74qh28R58qm
         7b9npwyvMk9+vyUFWtY9RlxJjQ+2WE7VrmtxC5txWC8VnujPgcBTm+7JZbgE/PESTyh8
         lL7Fce8MLUqYeHie3PM3fDDB1KzQiB66T7PimludAJiYRUHVG+7WD9VIBfp2VaTXRk+R
         NNI6AQHFA5BCXmd6ZlukXoihDkzdXytb/pBgS9MPROKXeMRcCAeh8dr1t7cqYBnwlsIr
         UpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771926596; x=1772531396;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihc1i2j/q8cxZfXwCx9hWk44X+mHIq/FDDXzsxYfsps=;
        b=FdF7KA2X5Ma1v7NAhGyEHDN2+6E5o6rQiqVVZTuf4zaF8lovVpIOiPqWf8Tw2EJIv4
         PC1+l7ZfbI5awWM6a4loAAjU2LjzLAfP23tNPIe9kZHNS5oQLUqZE1oPdV+lKe/QHNWB
         SicUGBFLgNLpooYDsg0jZq6zxa0luG2SRS+UAmSS+t1ph4xI4nk+YfqPXbvmIAEWXNjd
         fHcY5FlCMpC/+KXJ6OHRRgtoIV/9Ok403Edw3bDKorHA9mPhR5SIl8RshpGdrahFBsCU
         ymnorz60OFz4sWHe3EA1qSvbcAu0yylM5CMKMJgdIP92hMZT+0dijEmzbSho0ktOv1/U
         kbaw==
X-Forwarded-Encrypted: i=1; AJvYcCXddz0+rsDgGbosmSoaUZl2R5ixLmEOnc48R51T40V6psi9oj0vq6SFznBMv0x6FFyob0E3+20NRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYZfr5alooDgIsLmsPp6SwoukWCxrn7TH0YjXEJAMKVhQuQKqM
	/dUQMJUyPrM4Hzhk926HO2edg1P8BPm/pE4ZtmLkoMn5CctfBmDGWrsvgqB1v9Ndsu6tldIE8yl
	oIX9zy+7tZxoa/53S7G4Eumj6v19UqK+iQIEof13sYVSw63aMXdBaDSrZuvBQhg==
X-Gm-Gg: AZuq6aIP6ODhqUYx+IZQZus1UXoCDC0e3UbcipnCU69JIuY8AphI0vahGiWJh8yzjcM
	5wuAuxHy716omHRxNagz3YhdsNAA600UIVBE5Iq3NhSbUKL/A68c2yZ6OZc6vY4DtpHyIANya/a
	LM+pcudHJjq6hYk7PCCHEk5ytt/IylVlp23C+DbgzaRrH1R2acPVkMzEISZLOffX4BRteg78FvO
	yCnPextLo6eQDjMFCJ7bSfzcdZId0yf/sQqNkiE/fuqH6nmIoO5GajBU4MWUlyPgzzKWeLRSvZF
	lkuFxzQte4MBNMQ3lY08j/O20TZH8WHNUvKEZRDIgpAGSgoi0E//ZSeyEeARP3JvkoJ5qSkjyXu
	YrZVT8BcxETdQxZXL1n4AonsFBZXL+A==
X-Received: by 2002:a05:620a:2911:b0:8cb:4a64:f482 with SMTP id af79cd13be357-8cb8c9ec06cmr1525188185a.18.1771926595688;
        Tue, 24 Feb 2026 01:49:55 -0800 (PST)
X-Received: by 2002:a05:620a:2911:b0:8cb:4a64:f482 with SMTP id af79cd13be357-8cb8c9ec06cmr1525185685a.18.1771926594982;
        Tue, 24 Feb 2026 01:49:54 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fdd0sm25912206f8f.19.2026.02.24.01.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:49:54 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH v3 0/2] pmdomain: qcom: Add support for Eliza SoC
Date: Tue, 24 Feb 2026 11:49:44 +0200
Message-Id: <20260224-eliza-pmdomain-v3-0-6e13d3aa70a1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADh0nWkC/3XNTQ6CMBAF4KuQri1pC4K68h7GRX8GqaEUW2hUw
 t1tcWOibiZ5mTffzMiD0+DRIZuRg6C9tn0MxSZDsuX9BbBWMSNGWEUYrTB0+snxYJQ1XPdYKUr
 2lApVQoni0eCg0fcVPJ3f2U/iCnJMSmq02o/WPdaPgabeXzxQTLDc0rjlZa0qdbTe57eJd9Iak
 8eB0o/APhRWfCksKqxoxK4GURNofijLsrwAElsVtgsBAAA=
X-Change-ID: 20260216-eliza-pmdomain-dd10911bd4e4
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=qqfw9w0awQ71hzTYm+p8jQGQFb1k+CxmUX9o301++j4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpnXQ6HDjEMe1pv+QX+gSh0Uo6lvwhT8B025w9V
 Au2QKhWVA+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaZ10OgAKCRAbX0TJAJUV
 VuXLEAC4334ws4lxPjDFu3wkJxuL0nRds7KOltdcvmPOPgSHPx0EnJzYrXEuEYliu2bYKw4XXBL
 q25vJeT+nj8sUxguboYUMBFrrxRQKmoSTYZRXQ9tMMzRxm26/6rbTc2Kr4v/YVHpxBSZgACJxjQ
 qSTskhWCpEERcqLxCzaTQ09sWD+fZguZ6kOgEtQdW/kyc2rTd/npM4fYdb2h3sTB/8V2a7snVYN
 sORNoGk+yB0L24lEoL7QZ2f7cIh6HOg5U47xODLTuacnJsvQRtcGSva8GoF7AaM/G1IWDxrY7V0
 SL2A5xHYkv7J2M9AId0AgiGiGzU483qPG6wMXfuoEO8hfyQWYAaWlXS1GutIcF95OuC6FBXr4rq
 A0xSpX8Z8Z57HWMKvbx627yV8lSy/wZpgNhm5wlOKw1cVnqwUQQDV8cZM5EEB9oCn/xxtlu02an
 IyMWr1BQjS7PEXjYhWkDIwOkc6RHOqcRclh6nf4p48wsAM1oaO01ketmmdCXC/Noz6V3M9TRf8B
 AVC/mvKFrmNigq9tGjuJRy/VNQx6eHHH3eyEnSRfslLCqHtkF+SYTDCh8LYY9JeiqGM4gThE22y
 bdkEl+DCQLb5OCi275q/ZHnbBgA7GFPCbUUNCynkxRgFrcFDBzviV61F7vZSNwXq9IcNcIPt1yU
 h+W8guXxxk377Ng==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-ORIG-GUID: c72hHO7dPjLDhpHwHhGoDmHPGoARZj9k
X-Authority-Analysis: v=2.4 cv=V7twEOni c=1 sm=1 tr=0 ts=699d7444 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=w5gbrMkz2gkyNj4IujcA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4MiBTYWx0ZWRfX9vtiD9P9/8Rr
 JwxxN0YregtMATHKa6Y6huzd/aixlVVppb2b1IDqAh3S5yAybOp5MqfgUXrYGCn80obn0dBY0mu
 n0uuemiqwxc9vXHjEE/kxPEA6A5G1TbRMW2qRjNwHcgPp5K0njPxLm7Tb36wjTW03VgezY6ZzWb
 K+gMc15ihw7Kt+SaeL/x0H0ALyBm2hiOJEr5tJy/sB/AcS6o6xaqsLqFv2NWrPTIw5srf8rbJqS
 xyWZL+EA2rvCwkWufvl6QUnvo4h55hEcCXKhCVFwc/+vUgDM0tcdwNSy1Qp1CR7Oi+zTAKsyNsz
 qsGk+6qVW2RvHBklNWifzzhqnycPC/XkydPvZtvTbigGU7BAw56Io+u+Sgs2P4TBuuVujLdzYFF
 apg3nGhE0Gbttzpgs+AzGlBlkFepbLV8fj6UPxGgesPIjZ5wzwVhwpoBdLTod0IsYrQ/KAxbi6z
 Dkub6Vuu2LGABvGbVBA==
X-Proofpoint-GUID: c72hHO7dPjLDhpHwHhGoDmHPGoARZj9k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240082
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-43118-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3E2C7184EB6
X-Rspamd-Action: no action

Document the SoC specific compatible in the devicetree bindings
and add the driver support for this SoC.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Changes in v3:
- Picked up Dmitry's R-b tag for the driver patch.
- Re-worded the commit messages with better explanations.
- Dropped the MMCX and MXC entries as they are not described
  in downstream and not used. Consensus reached off-list.
- Link to v2: https://patch.msgid.link/20260223-eliza-pmdomain-v2-0-23fb87eb70ef@oss.qualcomm.com

Changes in v2:
- Changed the MMCX and MMCX_AO to the PDs with CX parent.
- Picked up Krzysztof's R-b tag for the bindings.
- Picked up Konrad's and Taniya's R-b tags for the driver patch.
- Link to v1: https://patch.msgid.link/20260216-eliza-pmdomain-v1-0-c51260a47d6d@oss.qualcomm.com

---
Abel Vesa (2):
      dt-bindings: power: qcom,rpmpd: document the Eliza RPMh Power Domains
      pmdomain: qcom: rpmhpd: Add Eliza RPMh Power Domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                     | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260216-eliza-pmdomain-dd10911bd4e4

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>


