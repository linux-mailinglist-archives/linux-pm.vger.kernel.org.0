Return-Path: <linux-pm+bounces-41364-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC1/K4Jec2l3vAAAu9opvQ
	(envelope-from <linux-pm+bounces-41364-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:41:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A8A753D6
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 12:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A2B7306B99F
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 11:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF73837AA8A;
	Fri, 23 Jan 2026 11:37:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A2E34B1A2;
	Fri, 23 Jan 2026 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168249; cv=none; b=pNiJSBwRB1leVO8ujGHcW9lqw2YdxIX/GuOPOJONfaZzIhafDLEIj52fwogM+vni8M/uTQCqzCIc/87JaVUGELA/rmb/VI2LHnApqsuSl6JD7WCMsxDrrcluZOp9+CJhYANUMB/fCbbFdMbXG8g1vXQw2XTboUHCFDc7fYKsDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168249; c=relaxed/simple;
	bh=h7TrcYh+NXIB4Y7PUTS/P/BnzGIi8hHtgrzYgPXeSto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KSxThdZeunLHbjQ6f/Bd9ZsQuDDsu7dCT9mLK8naUA5YHrCgEpgdfLjr8/fF50bWMW7PNReTBkP93zC7AXRC9cWn8fdVRf47yER24ouz/n5bmo1EJCqjRwgdQt96D7hpoF71aUiOD+OSNw4xZEmQVfDDirDrMm+BDjK57CrHsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: df34503ef84f11f0b0f03b4cfa9209d1-20260123
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:a810f61f-8caa-4244-8ebe-6ff94aa56eb3,IP:10,U
	RL:0,TC:0,Content:23,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:28
X-CID-INFO: VERSION:1.3.6,REQID:a810f61f-8caa-4244-8ebe-6ff94aa56eb3,IP:10,URL
	:0,TC:0,Content:23,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:28
X-CID-META: VersionHash:a9d874c,CLOUDID:3e68a111b7eb9ba57b7f5d35ae5c7ae1,BulkI
	D:260123193719V72TS5BR,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:4|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: df34503ef84f11f0b0f03b4cfa9209d1-20260123
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(223.153.58.254)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1789499668; Fri, 23 Jan 2026 19:37:17 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	srinivas.pandruvada@linux.intel.com,
	lenb@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	ricardo.neri-calderon@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 0/3] cpufreq/intel_pstate: Support dynamic hybrid capacity scaling during SMT transitions
Date: Fri, 23 Jan 2026 19:37:12 +0800
Message-Id: <20260123113712.1590187-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tianyaxiong@kylinos.cn,linux-pm@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41364-lists,linux-pm=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: D7A8A753D6
X-Rspamd-Action: no action


Users can toggle SMT (Simultaneous Multi-Threading) via
/sys/devices/system/cpu/smt, which dynamically changes the CPU's
hybrid nature and related features like EAS (Energy Aware Scheduling).
When SMT transitions occur, the system may no longer be recognized as
hybrid, invalidating previously applied CPU capacity scaling settings.

This patch series addresses the issue by enabling dynamic toggling
of cpu_capacity_scaling during SMT transitions on hybrid platforms:

Patch 1 adds the arch_disable_hybrid_capacity_scale() interface to
handle dynamic SMT state changes at the architecture level.

Patch 2 removes the refresh logic in hybrid_init_cpu_capacity_scaling()
since sysfs interfaces for cpufreq_driver switching make mere refresh
insufficient.

Patch 3 implements the core logic to enable/disable CPU capacity
scaling during SMT transitions. It leverages cpufreq online/offline
operations that accompany SMT transitions:
- SMT off → on: cpufreq online operations occur. If hybrid settings
  were previously applied, disable-related operations are performed.
- SMT on → off: cpufreq offline operations occur. If the system meets
  hybrid conditions, enable-related operations are performed.

This ensures the system correctly maintains CPU capacity scaling
configuration across SMT state changes on hybrid platforms.

Yaxiong Tian (3):
  x86/sched: Add arch_disable_hybrid_capacity_scale() interface
  cpufreq: intel_pstate: Remove refresh logic in
    hybrid_init_cpu_capacity_scaling()
  cpufreq: intel_pstate: Enable toggling cpu_capacity_scaling on hybrid
    platforms during SMT transitions

 arch/x86/include/asm/topology.h  |  2 +
 arch/x86/kernel/cpu/aperfmperf.c | 23 +++++++++
 drivers/cpufreq/intel_pstate.c   | 89 ++++++++++++++++++++++----------
 3 files changed, 87 insertions(+), 27 deletions(-)

-- 
2.25.1


