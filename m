Return-Path: <linux-pm+bounces-43295-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEfgGv+PoWkruQQAu9opvQ
	(envelope-from <linux-pm+bounces-43295-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 13:37:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9401B7328
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 13:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C250030AF3E6
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 12:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0413D9050;
	Fri, 27 Feb 2026 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZX6FlVEp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ko6PTFlJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D724330334
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195620; cv=none; b=WO9YMVxZ3dBMIW38wjkxdKH0gGaFqk71fAYWhnbY674MSxEY+R8X+CD6xBvQAmBLPRfj0/6PcjBmMceyD1/akHJlX91nJFxeCGQdWVygGSqiGC2hFwvmG3jHHeM7JIs+O/ELhMwsYGjqqcbJMwu6lkpXUpsIwf3Asw2Y098Rj44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195620; c=relaxed/simple;
	bh=RD5Y18SkvNUxo/kPjIziBJKreqUw9LaBwpbFloIcFfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iILqKOMUidvLorWlZS4SlMfRxmMB5hq0X4c7puOsROYruiq2YrGCnpgLBjLDtNnjwL0daVsfGNVJCFWVdEVzTczYAp29kWPcdk6YavTwH8t2BI6pWftZ4rAdvz67SUsfWUSdShhrRNPB7Qf1taX7KTE0X6YlN+KIGGrUm4ZxvVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZX6FlVEp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ko6PTFlJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9W78B3761435
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 12:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wiAy+vCzqXXJ5UW40ZL92600lnjU94FPvHKsBtkb0vU=; b=ZX6FlVEp5jPPQ6Ep
	IFmT0kelZZaTi1uR0MbkcqHLImGq7yqK5sOKRy0yWqPRDFMO7TPEu6hKQ3z+7YZ0
	Zeh+gOjbYXBQXqAsylvNQVXKb1ATui7uVKBWKhSOZPm/F1NJZAb+n/vbqk65aqvj
	4Mje0WIf8ZGf3cWX3TlBW2L5waysRp8yw8mOzymJEVxBTrCokOzoGWVGoagANQXi
	gkxxFe+adF/2xE+Yo5m8HKKilB3nPNhSLh0lSlLi/3RGmfyAvfpkDNFquBp9IOV/
	AuLMwtUK8U0swtChPWhzmBVRetVKrglNtsfgaHFla9pJsxTwEnZWkzaR+zKOXqWp
	f1Nntw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjt7ybjwq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 12:33:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso9539270a91.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 04:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772195605; x=1772800405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiAy+vCzqXXJ5UW40ZL92600lnjU94FPvHKsBtkb0vU=;
        b=ko6PTFlJ4TD9iaXvn2RSXbmclVP+EkNwtfyk4FHEHC6aKyQh7/1ACVFBBZH39ELmlw
         rngk4RtKqS5/Bm7OEsgvwS1k04WcHSWmhkYjdRoJcyDNGehsy1/W1RZAwz9UOF0yFepQ
         UayJ+Y3KQJG9sFxQVaXg9xd+4cSW/m92aidM8ANSDkUr/xBqmkdSS71ILf3kHU1WhWco
         +rFcq7Rx8zW+6AJXX9Iv3PaK7YvxOBCz5SGNtUY+zHrViplnYsZ2FOodHaX63f3Fz5NR
         QM8keg7rPjn3XF3WsWr8YV3k7TW/q2jnsxKn7J+QyOC5hcFwOS1QUKnT8zdzK3bnYplH
         1uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772195605; x=1772800405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wiAy+vCzqXXJ5UW40ZL92600lnjU94FPvHKsBtkb0vU=;
        b=IdTW14CKXXX1Hrfjj2avic1Fv14MAIGPIaQeHA368hWsVUIr6Xfwg89HqgsuG7s+Yr
         QnbBWWra5XZ5UQR4VMRskHypqNa6ZQEHrk56aJ9NUIHsxNWN9aj2+xHuXxgfizVhF2ov
         bjQKUxnSm/OL9aiQYWu6p/plaSIfOaGDXW7CdR8xtRPzh5d/qKR8BO345ry/OiJuEzST
         xWDhZ7xnFbqnMqSeA5dCBabCNunMnO/xYS81Qr/6wc0DGvjSCOj2atUrbh9oWWnmVyXD
         GJDa1FL40QW5rsgk8SxDb3SHvKgFKQ52iabXQIuSKRqlqxe27OeNa417Om4DEXLgDYEo
         JOmA==
X-Gm-Message-State: AOJu0YxnBRtmDwa1Lnitd9AYKYnpt5uyiwtu77HzZLL43A/qIqnt1wrb
	onaVfaIh3384KjeLozu3ppt5R7N0V8cErS/I7Ve16zNx6efYkozWr2G9xpNdgIXdBuxKnmUZDSY
	IzI1vJ8z22RfMdGc0gS8tfkalSxzuRqrNArVjdQyoQTLQubVdeyI8OG1+SupH
X-Gm-Gg: ATEYQzwDRH3qYprYGUeFQlbXUDgN17te12tu7WWEebQ2wr0YNmpeKuUJG69kH+7OPlx
	0USz8pyyzqWTvY1PnWQryvzlQFHDfpER6GrHT0nCtu/dIsAfB3HzSBzh38S6Dfvl3+gGNUJfi/T
	a0ZUUwiO8XuEyAnXujas/fCz7KGnvmJynzpJ/Ez6CDwtHAjVZoN8Ol1e8+6/v+VjyegfXjeGFKL
	k3zSE80YISkcJGIlZmfRjy62AjcMUeqAeyOe5CBuEcfE7qugGRhRc0ybdFAkQsdGQaVLBP0BLfZ
	aBI2E6HnYc7Yn8rXs837WIUFzawYfZaFJxFOsvRsYgqqevxflD7y0BdouDFhuM11dS+FXUlsgKw
	2NDQP97Spht8qPtgtG6kVkcboJ00NXSWm9eB59xWiC+pO4WZmueA=
X-Received: by 2002:a17:90a:fc4d:b0:34c:9cf7:60a0 with SMTP id 98e67ed59e1d1-35965c3b021mr2127260a91.5.1772195604679;
        Fri, 27 Feb 2026 04:33:24 -0800 (PST)
X-Received: by 2002:a17:90a:fc4d:b0:34c:9cf7:60a0 with SMTP id 98e67ed59e1d1-35965c3b021mr2127236a91.5.1772195604217;
        Fri, 27 Feb 2026 04:33:24 -0800 (PST)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593ddd103asm5005008a91.14.2026.02.27.04.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 04:33:23 -0800 (PST)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 18:02:28 +0530
Subject: [PATCH v3 1/2] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-b4-add_pwrkey_and_resin-v3-1-61c5bb2cdda9@oss.qualcomm.com>
References: <20260227-b4-add_pwrkey_and_resin-v3-0-61c5bb2cdda9@oss.qualcomm.com>
In-Reply-To: <20260227-b4-add_pwrkey_and_resin-v3-0-61c5bb2cdda9@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772195595; l=1792;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=RD5Y18SkvNUxo/kPjIziBJKreqUw9LaBwpbFloIcFfs=;
 b=XSStU41aXjAVDPFIShYdT3Wiw+GPmLDQl5ay0lTvDbGZM1ki9sccwSSKGfk9/UxG0wtJ7czM9
 p+WnCOsfOahDoRT8Wf+5wpqmv6k/99dE1zmFfC9uewAsMGOn1nxdVRW
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-ORIG-GUID: LOJ-gwQn3p4sykWc6cFh0sY166ZHGJcX
X-Authority-Analysis: v=2.4 cv=N7Mk1m9B c=1 sm=1 tr=0 ts=69a18f22 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=_AAIsZwEcCVD3kIwM0oA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: LOJ-gwQn3p4sykWc6cFh0sY166ZHGJcX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDExMCBTYWx0ZWRfX6HKQQHbf8TOR
 WKog5jh+g277TTHb2dm4Lfrk3Vdo2HFGKvNrA9p2cUKDr/OtWwRXSL3rXgKZIcWR4b6Q0ooUhmi
 hJXlzThiG+35zU4bmQ0HN7aor17smEVzNGZ5VbTxvvzTdYijUyNdndrpcOWx1GSpf1fR9n/s/xN
 MIkkCvfePPri3UR1pPhUR16L1wzKELGCzTS4fACBTK/L0BOpKPrvNhYPWBBvu3G+hMIbOku1CJF
 8L9F4iyiqBVg36EnlMRoWK33ui9IFSHS1WY6nC/7ed4OBpzdKSmFQVuVmcqRFZb11Dgqod8kear
 bHGyCP5+tNG0m0KeOMxRMU+Yx/jEYXoRTk6bPJ5bl00Mw1YpII8uSXv513zbkq8SL+jpqC9uiAs
 lL4DMHua1PkbmyD75rlIQkbMBR8dyewQW+TKdKy5l04wDN8CkVpo/+DZtkVP/0dEqdXEXU1umId
 2hdOrbbU5IjFdHzYkOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270110
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-43295-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rakesh.kota@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DC9401B7328
X-Rspamd-Action: no action

PMM8654AU is a different PMIC from PMM8650AU, even though both share
the same PMIC subtype. Add PON compatible string for PMM8654AU PMIC
variant.

The PMM8654AU PON block is compatible with the PMK8350 PON
implementation, but PMM8654AU also implements additional PON registers
beyond the baseline. Use the PMM8654AU naming to match the compatible
string already present in the upstream pinctrl-spmi-gpio driver, keeping
device tree and kernel driver naming consistent.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v3:
 - Update the commit message.

Changes in v2:
 - Introduces PMM8654AU compatible strings as suggested by Konrad Dybcio.
---
 .../devicetree/bindings/power/reset/qcom,pon.yaml        | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index 979a377cb4ffd577bfa51b9a3cd089acc202de0c..14b85b0d97da12c756cfe2ce33853501ba4ca46c 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -17,12 +17,16 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,pm8916-pon
-      - qcom,pm8941-pon
-      - qcom,pms405-pon
-      - qcom,pm8998-pon
-      - qcom,pmk8350-pon
+    oneOf:
+      - enum:
+          - qcom,pm8916-pon
+          - qcom,pm8941-pon
+          - qcom,pms405-pon
+          - qcom,pm8998-pon
+          - qcom,pmk8350-pon
+      - items:
+          - const: qcom,pmm8654au-pon
+          - const: qcom,pmk8350-pon
 
   reg:
     description: |

-- 
2.34.1


