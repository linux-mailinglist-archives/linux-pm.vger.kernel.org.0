Return-Path: <linux-pm+bounces-43938-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBdIB+q1rmkSHwIAu9opvQ
	(envelope-from <linux-pm+bounces-43938-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 12:58:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB452384D9
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 12:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5D6F3055820
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32F39E6C4;
	Mon,  9 Mar 2026 11:54:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC436376BE4;
	Mon,  9 Mar 2026 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057285; cv=none; b=m84UaV+PGweeCel/hKImqLeLYSPNUcFmTSoTaAr6NIvp6Nf+Hv0E/Z/y+XFiYXiiPRr7fXBy0RyJchPdxkDTgTHce2YjTNW4QgaQt2kMYLnXde7xjyYFmf2Poqw2Pe0Jx+A84IseznAq8XUYu/GqEGOAqPy6zBxk7Y/6ru7bA5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057285; c=relaxed/simple;
	bh=EQ0u/cTaIGlgPPSn2zj/uyDVberTCae4yj7OzesI1G0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TaetrC1j++LuoKSyB2r86dyVL4eU2JjdG35YxlTSkUr+YZcPYxpFYqbmwOM/Rd0mAieGpPKudBJdvh5ANQGLdFRoezLiMX3hcAyQpRPOxZwwFvu6SOieTAm2iDIyrH+n5iVNgD9YNCDQa2id1uGMPdJAQBZmDuWYqE53Jr1WOPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bd506c1e1bae11f1a21c59e7364eecb8-20260309
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD_SPF
	CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:2c89d9e2-52a4-47ac-bb43-943a48531289,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-15
X-CID-INFO: VERSION:1.3.11,REQID:2c89d9e2-52a4-47ac-bb43-943a48531289,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-15
X-CID-META: VersionHash:89c9d04,CLOUDID:25f0a5e32810ae3cadba35b84c436267,BulkI
	D:260309195436K68LMHDV,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:1|19,IP:-2,URL:0,File:nil,RT:nil,
	Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BR
	R:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bd506c1e1bae11f1a21c59e7364eecb8-20260309
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.193.211)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 87041393; Mon, 09 Mar 2026 19:54:33 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	nm@ti.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 1/4] PM / devfreq: Fix possible null pointer issue in devfreq_add_governor()
Date: Mon,  9 Mar 2026 19:54:30 +0800
Message-Id: <20260309115430.1914703-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260309115054.1899861-1-tianyaxiong@kylinos.cn>
References: <20260309115054.1899861-1-tianyaxiong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6DB452384D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43938-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tianyaxiong@kylinos.cn,linux-pm@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.338];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Action: no action

When a user removes a governor using devfreq_remove_governor(), if
the current device is using this governor, devfreq->governor will
be set to NULL. When the user registers any governor
using devfreq_add_governor(), since devfreq->governor is NULL, a
null pointer error occurs in strncmp().

For example: A user loads the userspace gov through a module, then
a device selects userspace. When unloading the userspace module and
then loading it again, the null pointer error occurs:

Unable to handle kernel NULL pointer dereference at virtual address
0000000000000010
Mem abort info:
ESR = 0x0000000096000004
EC = 0x25: DABT (current EL), IL = 32 bits
*******************skip *********************
Call trace:
__pi_strncmp+0x20/0x1b8
devfreq_userspace_init+0x1c/0xff8 [governor_userspace]
do_one_initcall+0x4c/0x278
do_init_module+0x5c/0x218
load_module+0x1f1c/0x1fc8
init_module_from_file+0x8c/0xd0
__arm64_sys_finit_module+0x220/0x3d8
invoke_syscall+0x48/0x110
el0_svc_common.constprop.0+0xbc/0xe8
do_el0_svc+0x20/0x30
el0_svc+0x24/0xb8
el0t_64_sync_handler+0xb8/0xc0
el0t_64_sync+0x14c/0x150

To fix this issue, modify the relevant logic in devfreq_add_governor():
Only check whether the new governor matches the existing one when
devfreq->governor exists. When devfreq->governor is NULL, directly
select the new governor and perform the DEVFREQ_GOV_START operation.

Fixes: 1b5c1be2c88e ("PM / devfreq: map devfreq drivers to governor using name")
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/devfreq/devfreq.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 54f0b18536db..63ce6e25abe2 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1288,23 +1288,21 @@ int devfreq_add_governor(struct devfreq_governor *governor)
 		int ret = 0;
 		struct device *dev = devfreq->dev.parent;
 
-		if (!strncmp(devfreq->governor->name, governor->name,
+		if (devfreq->governor && !strncmp(devfreq->governor->name, governor->name,
 			     DEVFREQ_NAME_LEN)) {
 			/* The following should never occur */
-			if (devfreq->governor) {
+			dev_warn(dev,
+				 "%s: Governor %s already present\n",
+				 __func__, devfreq->governor->name);
+			ret = devfreq->governor->event_handler(devfreq,
+						DEVFREQ_GOV_STOP, NULL);
+			if (ret) {
 				dev_warn(dev,
-					 "%s: Governor %s already present\n",
-					 __func__, devfreq->governor->name);
-				ret = devfreq->governor->event_handler(devfreq,
-							DEVFREQ_GOV_STOP, NULL);
-				if (ret) {
-					dev_warn(dev,
-						 "%s: Governor %s stop = %d\n",
-						 __func__,
-						 devfreq->governor->name, ret);
-				}
-				/* Fall through */
+					 "%s: Governor %s stop = %d\n",
+					 __func__,
+					 devfreq->governor->name, ret);
 			}
+		} else if (!devfreq->governor) {
 			devfreq->governor = governor;
 			ret = devfreq->governor->event_handler(devfreq,
 						DEVFREQ_GOV_START, NULL);
-- 
2.25.1


