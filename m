Return-Path: <linux-pm+bounces-40023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4093ACE8C4F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 07:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 523AD300F8AF
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 06:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F09262FE7;
	Tue, 30 Dec 2025 06:15:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E8C2EA;
	Tue, 30 Dec 2025 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767075356; cv=none; b=ucWk5OCr3moDedFywIE6DHFLW4SNgoQDXQq0sZh494AvExhke4RyQ61OpGGU7dz2+LWuCYtUK7R8m2pcfTfxNAFRkVBgcSlTrXPtxdPcjNKvjbSoFB+/H9ecE1+diXU6k9rd3M3eZo9MKRv54L2CxZf3ptJF5dUZoroaUHtA+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767075356; c=relaxed/simple;
	bh=NTC9wSq+SufykWoN80ehpC+XL6hCh+O+89RGiV1M24U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tCG0gXG6P12EyRxKl4wLzRJoJ2O1ej18ApniN5hJzoFrgsXoZTOUTUwEA2v6xM3Jpr4pKb5tngs7a96Zlz2g+3ocCZb2uU1rSG8OlkdCSk8/EzvOm+nivoVne1ouway5rH7NqkRRIHnGuOQAbr/FfWk2fSQ26v/ccRLMXu2q8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f5e97d8ee54611f0a38c85956e01ac42-20251230
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:c66f5087-e6a8-4a49-9469-20eda22708a1,IP:85,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:85
X-CID-INFO: VERSION:1.3.6,REQID:c66f5087-e6a8-4a49-9469-20eda22708a1,IP:85,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION:
	quarantine,TS:85
X-CID-META: VersionHash:a9d874c,CLOUDID:c920579a920a17be89697ea3152e5c46,BulkI
	D:251230141541QRAFWXJS,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|127|850|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_IMR,TF_CID_SPAM_SNR,
	TF_CID_SPAM_ASC
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f5e97d8ee54611f0a38c85956e01ac42-20251230
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(223.153.157.141)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1887944253; Tue, 30 Dec 2025 14:15:38 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 1/2] PM: EM: Fix incorrect description of the cost field in struct em_perf_state
Date: Tue, 30 Dec 2025 14:15:34 +0800
Message-Id: <20251230061534.816894-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to commit 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove
division"), the logic for energy consumption calculation has been modified.
The actual calculation of cost is 10 * power * max_frequency / frequency
instead of power * max_frequency / frequency.

Therefore, the comment for cost has been updated to reflect the correct
content.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 include/linux/energy_model.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 43aa6153dc57..e7497f804644 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -18,7 +18,7 @@
  * @power:	The power consumed at this level (by 1 CPU or by a registered
  *		device). It can be a total power: static and dynamic.
  * @cost:	The cost coefficient associated with this level, used during
- *		energy calculation. Equal to: power * max_frequency / frequency
+ *		energy calculation. Equal to: 10 * power * max_frequency / frequency
  * @flags:	see "em_perf_state flags" description below.
  */
 struct em_perf_state {
-- 
2.25.1


