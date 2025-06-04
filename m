Return-Path: <linux-pm+bounces-28083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FF3ACD650
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 05:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDAF3A2C9E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Jun 2025 03:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2431F4180;
	Wed,  4 Jun 2025 03:10:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650F7BA42;
	Wed,  4 Jun 2025 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006643; cv=none; b=eLJTRuhQWVHBs/1x9XuHZiufYMDZ9YbWjJXKOKR0DHPGEZK3hz4uV6rLgdftUkj9dxGMG7A+NOUZgpN3MbsgZQOoacxdfKaghu2EzAHgIoXueqXliWFDgb7LuI+3YtSa2h+i7LcJ6swtMM3v56r7w2AO80SQq8EmHC7RUz4GC3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006643; c=relaxed/simple;
	bh=/0sxrzAoueqfw+gLKfT1VDlj/pvhkcnVEiXip92eenU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W2hOZGNv/CN5mhkmSi5sYUKNFh5IBKar6fbCG323c4k3ajb40NayGZJpsWkf7Fn4u3l8LT83jgEXJlbRbXkQaTNAOEzMkAChM8PtfkYjeESQbwDNr116DcsPGzznpiZk3vsDWkstoL/SN8pjq2cBLyBY+bgsS5b44ZMgB/bs5vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7ab46de440f111f0b29709d653e92f7d-20250604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:af8db382-ee1e-4e86-84f1-205f16c33789,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:62c4a49c96e344d521d92ffa2db6a557,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7ab46de440f111f0b29709d653e92f7d-20250604
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1502085564; Wed, 04 Jun 2025 11:10:33 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 9EA17E00891C;
	Wed,  4 Jun 2025 11:10:33 +0800 (CST)
X-ns-mid: postfix-683FB929-39672414
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id B7A17E00891B;
	Wed,  4 Jun 2025 11:10:32 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [PATCH v1 0/2] PM: suspend: Fix pm_suspend_target_state usage and logging 
Date: Wed,  4 Jun 2025 11:10:22 +0800
Message-Id: <20250604031024.13093-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

1. Ensure early debug logs referencing pm_suspend_target_state are valid =
by assigning it earlier.
2. Simplify state checking logic using sleep_state_supported().

Patch 1 is a logging fix, patch 2 is a logic simplification.
All patches are small and localized in kernel/power/suspend.c.=20

Zihuan Zhang (2):
  PM: suspend: assign pm_suspend_target_state earlier for valid debug
    logs
  PM: suspend: simplify state check using sleep_state_supported()

 kernel/power/suspend.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

--=20
2.25.1


