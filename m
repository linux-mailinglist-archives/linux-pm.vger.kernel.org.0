Return-Path: <linux-pm+bounces-38147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C93C67234
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 04:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B8BE329C03
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 03:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3970E328B6E;
	Tue, 18 Nov 2025 03:24:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9018E30FC25;
	Tue, 18 Nov 2025 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763436245; cv=none; b=HtUfcZmS5TigSmnTMrptFi3ZSraV2REF/AB4BVW5qOzKkgduB4k6O+29PEMpVDGCmpqUHp5hbxwWiG4+M3PpExd2JrqLDbdgtAbTVU4aUDjd1eWBuqXbtUJVXUtS889McDoC32jnh9X4ZMY9Gq2PsxCjoRP7b0pcOR4GTznNVNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763436245; c=relaxed/simple;
	bh=sS79ckhjapEcObSVbt9Nl9+7+ZN7Kp0ni50OqlwdEeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AVQdb8v6EpehYiEPh7WkoGU1tt9rywYDG4qPLMnnqhQxInL9teXv7f0/kPl0W3HSJJhh+SwYFfqbuLflTKQrgc5cJM8EJL4q2aA0tTXIK+6tcxMqRNiT08IT7KXxKtS2PC66d5/OtCyI6Bw4FGab8E6E9hzQv9I/Q3G9iaxBykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fe28cf48c42d11f0a38c85956e01ac42-20251118
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:44845838-ae9b-4d03-9f5c-5b6d885db060,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:339fe55a7e3c622e3a898ec81b7ae7b7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|15|50,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fe28cf48c42d11f0a38c85956e01ac42-20251118
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 636265314; Tue, 18 Nov 2025 11:23:46 +0800
From: Riwen Lu <luriwen@kylinos.cn>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v1 1/2] PM: devfreq: fix typo in DFSO_DOWNDIFFERENTIAL macro name
Date: Tue, 18 Nov 2025 11:23:38 +0800
Message-Id: <20251118032339.2799230-1-luriwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the spelling error in the DFSO_DOWNDIFFERENTIAL macro
definition and update the corresponding variable assignment.

The macro was previously misspelled as DFSO_DOWNDIFFERENCTIAL.
This change ensures consistent and correct spelling throughout
the simpleondemand governor implementation.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
---
 drivers/devfreq/governor_simpleondemand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index c23435736367..b4d7be766f33 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -14,7 +14,7 @@
 
 /* Default constants for DevFreq-Simple-Ondemand (DFSO) */
 #define DFSO_UPTHRESHOLD	(90)
-#define DFSO_DOWNDIFFERENCTIAL	(5)
+#define DFSO_DOWNDIFFERENTIAL	(5)
 static int devfreq_simple_ondemand_func(struct devfreq *df,
 					unsigned long *freq)
 {
@@ -22,7 +22,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	struct devfreq_dev_status *stat;
 	unsigned long long a, b;
 	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
-	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
+	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENTIAL;
 	struct devfreq_simple_ondemand_data *data = df->data;
 
 	err = devfreq_update_stats(df);
-- 
2.25.1


