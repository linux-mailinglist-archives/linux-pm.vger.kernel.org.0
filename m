Return-Path: <linux-pm+bounces-43937-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFjMDmW0rmkSHwIAu9opvQ
	(envelope-from <linux-pm+bounces-43937-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 12:52:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51752238384
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 12:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEA3E30500C4
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 11:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B123A640F;
	Mon,  9 Mar 2026 11:51:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D92396B91;
	Mon,  9 Mar 2026 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057076; cv=none; b=TPXqqwxsGOTyhfcLkfXTxc0bZcQZUv6m1zA86Ho7ZfB+2EPUyusmhY27yMvXdyDqSCPQec5BUkUhcpcz27m0Y5bfgGHpYZcTTBPTYCodMjF5RP/QCyfRlPUhzh8EVzWehi8lznpx+41c4yWpFgojrH0V5TaI+VYvaM/5St3uWN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057076; c=relaxed/simple;
	bh=d1oYBikAEkNb00Q1HpziOCq6EDorRL2n79XwzlBsLzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xcz1jDNaRNs3JLLP9oqIPUqYYcf4RVOtx4CawDrSxcF/cB4U2t0q8DoUMBxM/2XvaKJ57tOfy2MoxWMwTsp+Nec/wPiKQMmjbBpch/ETyD7qx6xHcwcxnjZgvil55JfTSw5yjNZGLmVfMERgGS+ziDPQz3thrCp1NJxNCCr09yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3cd4a3c01bae11f1a21c59e7364eecb8-20260309
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
X-CID-O-INFO: VERSION:1.3.11,REQID:bea72f19-a2a3-490c-955b-f7492d71756b,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-15
X-CID-INFO: VERSION:1.3.11,REQID:bea72f19-a2a3-490c-955b-f7492d71756b,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-15
X-CID-META: VersionHash:89c9d04,CLOUDID:b0a76ba4e19888d89ac4cb52d1110603,BulkI
	D:260309195100FOLSBYOQ,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	850|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3cd4a3c01bae11f1a21c59e7364eecb8-20260309
X-User: tianyaxiong@kylinos.cn
Received: from localhost.localdomain [(175.2.193.211)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1000916456; Mon, 09 Mar 2026 19:50:58 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	nm@ti.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 0/4] Fix some errors in the devfreq core layer when governor is NULL
Date: Mon,  9 Mar 2026 19:50:54 +0800
Message-Id: <20260309115054.1899861-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 51752238384
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43937-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.370];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

While doing some development work with devfreq_add_governor()/
devfreq_remove_governor(), I discovered several bugs caused when
devfreq->governor is NULL. Specifically:

1) A possible null pointer issue in devfreq_add_governor(), caused
by devfreq_remove_governor() setting devfreq->governor to NULL in
certain situations, while devfreq_add_governor() lacks corresponding
checks for devfreq->governor.

2) When operating on governor and available_governors under /sys,
there are also some unexpected errors.

See the following patches for details.

Yaxiong Tian (4):
  PM / devfreq: Fix possible null pointer issue in
    devfreq_add_governor()
  PM / devfreq: Fix available_governors_show() when no governor is set
  PM / devfreq: Fix governor_store() failing when device has no current
    governor
  PM / devfreq: Optimize error return value of governor_show()

 drivers/devfreq/devfreq.c | 46 +++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

-- 
2.25.1


