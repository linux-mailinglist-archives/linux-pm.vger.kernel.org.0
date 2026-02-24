Return-Path: <linux-pm+bounces-43137-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG+LCT+PnWkXQgQAu9opvQ
	(envelope-from <linux-pm+bounces-43137-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 12:45:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A26131867E8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 12:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A72C3002B56
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21A837FF4E;
	Tue, 24 Feb 2026 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mMAYJXif";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gwaMojb2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644A376BE5
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933400; cv=none; b=gNBOtSaTxxw/wjpdK/iKD6SMH804CSNAZs9ZphU+bPpFuOZH6bWTuEtAvihikP/a08u5zp/1ed4QaoHYT3byyP1yfdzlKfXW2Ln8Sm/f3lZddDlv75EyaCCglr+iPYsMSC0fdKGo3O6NHb6VdIGndf8BXXsdyP459wAKrrWna4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933400; c=relaxed/simple;
	bh=n5cHJe0cgs+lHOK6mHu7Fndxloi0qiAccjX7UrV8aXs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qDQZgWrQQ8FK8BgJccCFt+ZVYklee/K4aVLKLaIDbJ80CTyz/RagDCRpNFzf3+ilqr5p0c9OcqxioqIPl9gCXdurmgrqbeRDE3Mp6KIhGpyJTwjjrNQzG212J8L3ScEIpQqwqZv91Wwv7zftETmoWeShTSdet5qhLwo/wDANCFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mMAYJXif; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gwaMojb2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFROW1774491
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 11:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=65G0bJCHSnbbWCPhZNp+DD
	i6zDYKRm2TEYd1jJu8uS0=; b=mMAYJXifnc5BA7hOHN+m+iJub+VXOt3aCE8vvy
	H5E3NP/xJ4OKof+Z5uoeaseHhnPZWxzsaI48U5Nlt6yYSo/ZO8zrMWASF6WZBEyS
	gFaGvco5uxp3z/dy4W1btp1HkfvbrRSu9WBuB5+X6MkyNIkgUFIZ14qzCf/k51Kc
	CjEjp3dV9a/dUt3JDwsDYU00BWjLUHhv+irJ0iQnIuhaka36ZbYEfFG0fMcAElE9
	fJynNnpAueR2kTu+9CKg9AHFtMs5mr7yhsRpvJxXHq1VSBfb2l0UIOZGV3rxETtd
	DA0EtxfxbOvVnpZYUTMriwKXogOpY66lFEVUkuMZCm7QcYZA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgpj8bs9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 11:43:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70e610242so4908692585a.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 03:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771933398; x=1772538198; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=65G0bJCHSnbbWCPhZNp+DDi6zDYKRm2TEYd1jJu8uS0=;
        b=gwaMojb2gtmukNQSO4AMHXLkA+eaj8OlW5s3JUaKMnF9w5HEPq2DHG/Ttajr5xEXAq
         iXPylb4TlOFUiCR/JZmH8dqBjlgDX7/TKU/kgD/5/M1u8xl5D/72fR/bz2jjaXg05Ndd
         lMEgPZqLieufVIfTcXgoejBPqMmuMEX+ZF6Fh78Z9w89cpcgonoXuVX0XvyzACwHuCAM
         0UvDTkAj4MWlx3lBSDwwioySDhQlN0YYFFZneplRRMYe4g+JM5e6WEOmhh7CK4TXD/sk
         dh0ulkg3aaau7d+mQRzm1meRjPzQLQoZTPXM9bARTWTXMY7Xsv7ZosveRE5iy+vI+uPx
         VKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771933398; x=1772538198;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65G0bJCHSnbbWCPhZNp+DDi6zDYKRm2TEYd1jJu8uS0=;
        b=gsLHg8s/wzfiTnOXMJa4ziL2wW6ZqQd1V5XJCmqXRV96j0G39CdC0f9wNsOdrwKW/M
         WWoY+QiBAFIZmVcVLb64YEDGcDPfa3ttxjuEmO0+gwZgIxM3ycYRsnYZLXsJEue+9wTX
         leJeCsxdekxzF4Yvcd5rAJk5MWxvM1AqUjNMB/Nio1+s1CEksl/DAqSE77XAuScdqEP3
         Ry7JUWZydX+VkLmWr7OtHvcucKW1qAKya40mgxsRq98zRwT6MKrAIJtjYKTojP3pceDP
         9yDkk3vqBnyn2Ktoa79qqHozkY3ZkUlHufDzfqnsx81dw7hvhH9YmnB9SeEKBcLQl46l
         cw/g==
X-Forwarded-Encrypted: i=1; AJvYcCW3+/GO+0C/4JTuRXEw1DARmUOeYrlUhJnqjC9rAhQsyZaGsx0cbQX0W3kEst/TaToETtiHCbr+eA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4SrhN6lsy7Ye1ZEwLBUTmv1YGxQTz6fvC101mwoBoIluTYd9M
	iBep0dENkVKT3E4P6vuV3jfBMWBnoZwxmbIustFfvjYA9woboTGVFs/oLlgRPD5qxc6n6FW63HG
	ffCmeKFffKPRQVG1YoNhsvN7/KGmyKhxrpb9QuyXuDSs2pitSlCGbBmXm9EJQtw==
X-Gm-Gg: AZuq6aLmtzacFpuQD1HtiC5O4WVx+Iliw7acn+RPf+FpNNGcqLxTzT8pD0xMWcfP51Z
	676N3ruAp7nGCMJTi7/mkMGZm2qF35ygyzJ1fddEFTYhlyWmp3tBPQRhKFw629Ebew9LqXmJ0H7
	B7BCSQWWHjvRjne9iVH60PZ3WyUEc64CdFceoleXB38lHS7ckfOIWlS9gCB2Y2SwvooCcY2ubFa
	HtaWdOrZ8jOXJgp4Phew2t96Pl4YJg4Q9qyzomqX+OQg7cBeThKUmpPJNc7ThjIct6wUWqGVUp0
	d94GhBOQJJfvgR3Fcmw39M1qeet8UW5ol9T4k+ug+hj97Xt5HezSmqag/lM84WxytPfPhs7J708
	To0KIrnASL0YkvhMynYeaDkSuQSSojg==
X-Received: by 2002:a05:620a:3706:b0:8c6:ff02:d825 with SMTP id af79cd13be357-8cb8ca66010mr1497830685a.48.1771933397663;
        Tue, 24 Feb 2026 03:43:17 -0800 (PST)
X-Received: by 2002:a05:620a:3706:b0:8c6:ff02:d825 with SMTP id af79cd13be357-8cb8ca66010mr1497826185a.48.1771933397065;
        Tue, 24 Feb 2026 03:43:17 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b8915825sm32143335e9.8.2026.02.24.03.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:43:16 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH v4 0/2] interconnect: qcom: Add Eliza support
Date: Tue, 24 Feb 2026 13:43:05 +0200
Message-Id: <20260224-eliza-interconnect-v4-0-ad75855d5018@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMmOnWkC/33OTQ7CIBAF4KsY1mIGKC115T2Mi5YOilFQqMSf9
 O5SXeiiuiF5yZvv8SARg8VIlrMHCZhstN7lUMxnRO8at0Vqu5wJB14C44Liwd4bal2PQXvnUPe
 0rYQxSnLRyZrkw1NAY68vdL1553hp97k6SmNjZ2Pvw+21mtjY+zuQGAUKDIyBjgHoeuVjXJwvz
 UH743GRHzLuJP4tVZMSz1LLhWoUQlFX5Q9JfCT+408iS6aQoFolhNRyQhqG4Qk4NAq/YQEAAA=
 =
X-Change-ID: 20260123-eliza-interconnect-b73ff8523d59
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=n5cHJe0cgs+lHOK6mHu7Fndxloi0qiAccjX7UrV8aXs=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpnY7LOj12m2H5uWpykF7M7Egcr/U+GKewkE8xE
 AbuQLbbdS2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaZ2OywAKCRAbX0TJAJUV
 VleaD/9+VxY3hcuL91mMnydpPeVU/knUCO/Pu217Cx5NC8SB4y/WH0UDfzfN9UlvJS5ddfYdNxG
 0WETu4GrQBSvcczoVEklb/Ew6N2G/gqjEl3LKO9lCHhzEwO9SMSCzb/8uAf95oinggKc0xjqAok
 EJaTBtrtxJxkHRF2cLDJt7gZp90AoW0ORozm1SCRXT38n09n/qGqmzpZszOJpKLo/2b/n4B6bLQ
 jo4sODM/HmMkPifSXWrUr+YcPbJjEnq49vAvfcPY6cvpoxe2Ub0I3NEojYXoZ0tfMv2/mWuC8N+
 /XpyU/WsxZPHm6R9bIXfivwqll1Sh1qLaSCd8jsvKzw3LJG3vt1MY/EF+lM4Bh8+yVEylDXWqoI
 Ves1vD1drWwzGP4dAKgi4sL1yTWnG2ejB+TYcraEobyxQmCk7gGheepmY2E118IMLMo8O35mKHA
 uMuYC8t83zpZsg24w5oaYpcnNtNBlcnAmq7L7VCh587scGcFXGiKywKGAgaDXJuOHX5h2RGRxRC
 01hdTgjSCQ/hlJmxyvFoaIChuYD2e0Vp+XS1ITb6r8IrfjWPRuZrXR1hmHyDXr/+YS/joo/pgIt
 ez3pEL/LeU6ipWGoFENQBWiSFiegJajkvk8XW0aCNk2LYr6uiNah5cHpHlD9jsIbMI9soyHu4Wg
 ZfvC7W4jwsBuX3w==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA5MyBTYWx0ZWRfX3CrLg983Xdxv
 ntTmv9DLpwZj8KJFyjX+q9I0V2ZAoPyj8wJ1N2CAYwZsNTomAlfVPRvl+p2HPX8wlN2Vg8uZ1qO
 5Zm0gIWvq/BbZvT5UI3WYqVyIVN7fLW4mh6CeQU3VBnwnQo9ByebpfnmgdW3c9gcyDLTdwbGthc
 9xTVs6mXS0xG2anxyiCKV2j1IaaKF3uX714Yh/xsw2+5lUh8cMAui5YwxpCqdqrJBbqMDF+u488
 1qiyr5mQoKyz5ItsxBQ8JC0UPskGUdASvtsivaH8cqeeFMIFxjvBmSxFOHhdb/Q3hncPvxK578b
 0TSXVV6tCv/+hiHcRApDv4RQAo/jF0hH/PwD1fv3MPzHG2ANsBTxtPqyKfZs2ml3/dnFgoQyqbh
 m5PRHXEISlFaAL6oDVlaOP3XbATjBJ2D3PvUu4CeoPKS0IilASg3YLzXSpwgJMl4Wge05StGl+Z
 5ml3Y1ISVS6eX/fGAMw==
X-Proofpoint-GUID: WJoxFMOK-wpcGT3d3BcRHWAVEHj2gi4o
X-Authority-Analysis: v=2.4 cv=Z5Lh3XRA c=1 sm=1 tr=0 ts=699d8ed6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=ID9p70YM8hoiZytZed8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: WJoxFMOK-wpcGT3d3BcRHWAVEHj2gi4o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-43137-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A26131867E8
X-Rspamd-Action: no action

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Changes in v4:
- Fixed the clocks for the aggre1-noc node in the schema example.
  There need to be two clocks instead of just one.
- Link to v3: https://patch.msgid.link/20260223-eliza-interconnect-v3-0-f4508b8335c5@oss.qualcomm.com

Changes in v3:
- Picked up Krzysztof's R-b tag for the bindings.
- Added UFS PHY AXI clock to the aggre1 noc in the bindings.
- Link to v2: https://patch.msgid.link/20260127-eliza-interconnect-v2-0-b238a8e04976@oss.qualcomm.com

Changes in v2:
- Picked up Dmitry's and Konrad's R-b tags
- Replaced the all-caps SoC name everywhere
- Dropped extra empty comment line, reported by Konrad.
- Link to v1: https://patch.msgid.link/20260123-eliza-interconnect-v1-0-010ff0d100c9@oss.qualcomm.com

---
Odelu Kukatla (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Eliza SoC
      interconnect: qcom: Add Eliza interconnect provider driver

 .../bindings/interconnect/qcom,eliza-rpmh.yaml     |  142 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/eliza.c                  | 1585 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,eliza-rpmh.h |  136 ++
 5 files changed, 1874 insertions(+)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260123-eliza-interconnect-b73ff8523d59

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>


