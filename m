Return-Path: <linux-pm+bounces-43026-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHTKNzJEnGk7CgQAu9opvQ
	(envelope-from <linux-pm+bounces-43026-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:12:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A2D175EFE
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C96A930752F4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 12:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66A73659FA;
	Mon, 23 Feb 2026 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e7A463ci";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hbgOwtGG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEB534F48F
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848493; cv=none; b=GxktbOLrlYQT6xLW+3yftlR1md/6aOAu+2tsmKYXyO/h+gT0QNoQqKHGSt9bghmHv/gQy68L+b6wQGwuj9X5MVGaYJPE3014qxbRyl4eV2/5k6vjM5UwnkMt/JYESTro6HNNlFuqtTK9DLqrZqrlch37lHGQTiBH9Vz+qxMbIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848493; c=relaxed/simple;
	bh=l1P/X8RaAMg/5pk8zCokOgngfwYIKQ6wvGBAfwDa3YI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GCBZP8rnSSPO59WbMDIrQ8Zc/RvttWlWo0ALRV8YjD2/FjiWKCpwpg9J2SF1GV5xLucKcKEBjkPCT1dNdUNT954e09xDoAo8SPs4IuGfbO1uAHlW5Wh74mRjjZCTrwH2oicOPtlurUaA4c33FHes9xLmnIhsCiB2K+6vAhse7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e7A463ci; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hbgOwtGG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NAX4fR3698607
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nD29bnRta5GqbY29x+LShH
	634ju7lcefNjKqeboAYaQ=; b=e7A463cianJf0Qg0xYaMLlhZiogSyAAYpNHH31
	iqeVnE3mg5TaAe7CP+Vsd/olRzsDokV9DZVfxh5RX/t7Y5yb9ul37L7akBUI6dRg
	p5R7fH6wGjGrvaq7MZhNN8tjVnHP3jn6meZFIrVZZgz5/go513vGq1dU+dJiqjlQ
	xoR5d7jHGVf7Qh7yEGZncVYxw8joCmdw4GII1xvyW08NNvW+GNXsykWaNyfWI2Q+
	t56KXlWnid4cgap0Ko7tshPNoXKzlNGxvOLsyvXJEeMIXKWhBqibb4dSDs6zKX39
	fm1KQrs3BThw8xxtxn9UZs8w4NSDbplO9/gNOGnV9xEZ6qoQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8188mh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:08:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb390a0c4eso1303903885a.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 04:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771848490; x=1772453290; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nD29bnRta5GqbY29x+LShH634ju7lcefNjKqeboAYaQ=;
        b=hbgOwtGGUduQXk0/nRSAkr7BG9daQQfbi8MF1IAyJMfloP/JLigm7eiQWCt0oZ7FG4
         eO1SeDagB37t5mMc0EyCfXsbicIYpJSZ1Es0IqtW0YuGbcyO8uKIyzf/MJfI/IboW4OJ
         4iemxAAPZNgBnBohhhnQHzoKQm/Zhu9QrHMkWSJnQ2SKMKDUYHI7bPgTZijIQqMugNiH
         yJR1KOCfH754MMOFiKS0blYRB8edX2d0v6X/7P/1QcI8xin0zgExD8PDTS1p6csLZY5a
         RiEU+LCLOPSZ8aZnQS7GK5AaSZrUa4lNvswgsZX/VJqBdTLP7sZGVRVkdYH6plXGxKF5
         Htlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771848490; x=1772453290;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nD29bnRta5GqbY29x+LShH634ju7lcefNjKqeboAYaQ=;
        b=Xcqfg/XbJLrVslbIP+4LISEME+HwKBAnuleb0X/ljN5eqGFNS3H0u6UyZj2fjIejX7
         sOuaHK4+Ky2ZPEzSkGJPDDXQTh5AVOxvFRhmWgujJTt3aHZ0vQijtjkWfCJ22IgzZImW
         Cids0Ama9ZXPc5Rl8CrDOubRXfkGmslnib4yNmSbAd/ZxBJAlTp+XgL+dtvzy5QmPfFl
         jjjnzjRUNDBNPPI7qz5fnxpR/1pqgG/Maib+zV1/uBvFPr0k3s/SRGb0s02MkHUxyLM/
         JYFFe0rbBNWWEOpKKayFhXT46Vlh8BAxHMfihvybe4DMnXoZiFdlBaoZnBktUKrRGnwg
         xm9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUphUSbT0Fq/j579UY7gp8jtcjRn9FYdAqYd/PCepXHoTVj6AvHrZBmgM0K8IhQx3gG+akNIiS1fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYmjjUdlggvNIFfSI1sp0ZYOYe6ItiKKHfHOPFbtgKF+UTWKY
	cJ/bzwDUz3mZiEQXSpxQGZTqOl6s6E3btqnbM/QRdDmIPsTXEmWh4EVJ/CJJt4eKeUpVdlz2kAD
	7cphf48/SKk9W/DR1GzFFu7qNUYxbfxOh8DRVTgHOmfr0s3Q1rIenp2j1QMwogg==
X-Gm-Gg: AZuq6aLcEWZa+rpYbM2N3YCWIpuBfa9TE/ln7bH9vblXtfmCR5PJqVn2nWRGobuEV5r
	Qn8f460DkxkJnEIAktNto5cok+zyAJMvE2hpz9+l/uhStDl87TyP4eS0DWz9Q/IoDuNX38eJOHJ
	OCQctMBBxo+5NBGPpzYl/BHE8Duze0igjC4lDj9hFkfuzbNARI4CCeZMRYKB4fXBOEKnIgGxc2o
	kwu4oudXdNhmW3YIqO/+aD6Xc1dnaBz+m4VDNdYB9j4hLEEmNHrQnLrwRNosYzYHlroKHG8yrkx
	XfmgKt+lFIAVXWOMM684dFq5FfwpUq5VUT5cqXxT68NKxq5diT6zfqfhXjXbAaz7su99EzQybCU
	1vvYrRS2MJQ4BtZDvVMBPDBgF/PmqtA==
X-Received: by 2002:a05:620a:29d1:b0:8b1:ed55:e4f0 with SMTP id af79cd13be357-8cb8ca6412emr914219485a.39.1771848490126;
        Mon, 23 Feb 2026 04:08:10 -0800 (PST)
X-Received: by 2002:a05:620a:29d1:b0:8b1:ed55:e4f0 with SMTP id af79cd13be357-8cb8ca6412emr914214385a.39.1771848489519;
        Mon, 23 Feb 2026 04:08:09 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fc12sm16522603f8f.24.2026.02.23.04.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:08:08 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH v2 0/2] pmdomain: qcom: Add support for Eliza SoC
Date: Mon, 23 Feb 2026 14:07:54 +0200
Message-Id: <20260223-eliza-pmdomain-v2-0-23fb87eb70ef@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABpDnGkC/3WNQQ6CMBBFr0K6tqRtEKMr72FYlM4oYyiFDhCVc
 HcLrt1M8vL/f7MIxkjI4pItIuJMTKFLYA6ZcI3tHigJEgujTKmMLiW29LGy9xC8pU4CaHXWuoY
 CC5FGfcQ7vXbhrfoxT/UT3bhZtkZDPIb43j/Oeuv9lc9aKumOOqW2OEEJ18CcD5NtXfA+T0dU6
 7p+AcyvYpjFAAAA
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=971;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=l1P/X8RaAMg/5pk8zCokOgngfwYIKQ6wvGBAfwDa3YI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpnEMibhgyF+jsisUUDVqrKSQMzyOr4d2cQZ/IR
 r6BwQklZqqJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaZxDIgAKCRAbX0TJAJUV
 VqQbEADDZS8yACVnC9c+SXfEZ63HCw4YU7pZaLxhJlTcToFAj9sagGdmj4tJzU48DFMo5LlRUoN
 TRMGf4VQWvJWpQtPZaL04Wr4AauZzBlZSiH8OA3S5mi2YGCrBqCMYlCS8nEbUXOkcKOu1JYN9MG
 LdnZFcMFilaadzMwfl+gucGLMwE7eHOVElkSB0TpYo8V7WZMRZJ/Fu3cR4ptS5w6xx+Z9EzGhnJ
 1Ijb7pGVbmkWHrO+IxbJe7pvBGd+777deyYZmsn5kyBjb+y98oCotMWaUKjIqIu+x55pagqV1Oq
 z0Mzxcmkf1TbcXhuAJF5ScUcfb/suBwBi47meVdUcOfftfWAS11hBsVQNjx2PIpK/V6pyyss8pN
 YfzA7Zdk6+cM2Prq8r/GzQniKAEA1TpXMk73pbW+xonpjVogcd4+5EXAzebdgkRtd0H1iTPAGGP
 psxOzO1Ite0mkB2rbZdVNyssjNq6QFthAkEVq6VNEdQCxL7pzpVoCha7cc/AFSiJbp4cYOSABoR
 Zv5zAxxVfeNRcj0PA6cC/+NgRzLN1NIEB2qQaXp3uK4XtMGc+g6mVZ+fhp/Cj3ty6YHma9QdY6K
 i25Msi5ElbTVI7ArjF6LtoFkAhyApobXWswUqWWqxUAocxS1Wt5o6KcXJv+kojFGOma2AvjoPrE
 yDqXCGiRDXiicCw==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-GUID: Vqo3fQ3IViueXdYt8GBUyoCQD4DvxA7l
X-Proofpoint-ORIG-GUID: Vqo3fQ3IViueXdYt8GBUyoCQD4DvxA7l
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=699c432a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=c55ydOb7OSgMCAo-AKsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwMyBTYWx0ZWRfX49HS/UqGzNgB
 r8x7aubjAKCtpuOXn0fUmy3cdtE0DUFNT343IbuGPiGqSC1qM5yp2qqxzWBAooVHNZUp7jWzbu/
 P3vJ7Gk4hOGhZB7/RHtXL0gmTTDQwDkcOZVKJcETM3xd1+RP9yJfDBzz9P1iKU4l/yEPWZnflcX
 5cMrLXPX6lUgrUXpmlhsCM7AYka9IvwUDe522fjoZb8SmThj2U5soNcF7Nm/dBR/Eth+da8pWvr
 dztwOsWaZTMGgJ+BFIuZt5euI9eqxJiPpQR4ROdyhFSzK4KhOp16lce+25kMYOFg1J8Wihki5tj
 4T3L4GRcleYRC2+4ueaxsI/JVj22g4vkQhgmaVawW5sDVq2a+ApDFKJ0nNGjD/1+vrLG1jQcB+B
 yXyC4VylhWzsKnv4umHsVKfQjlkmC0S6Hf9sRM5NReWBONZgzyaa7OLOAs4TA70ALMkag++w9XZ
 XL/woLe63G4wfoWsgaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230103
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
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-43026-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,msgid.link:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 46A2D175EFE
X-Rspamd-Action: no action

Document the SoC specific compatible in the devicetree bindings
and add the driver support for this SoC.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
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
 drivers/pmdomain/qcom/rpmhpd.c                     | 26 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260216-eliza-pmdomain-dd10911bd4e4

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>


