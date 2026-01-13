Return-Path: <linux-pm+bounces-40735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F2ED19180
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 14:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C1E4300FE0D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 13:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C0438A9BF;
	Tue, 13 Jan 2026 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BUi7pfHd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4D23BD17
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768310893; cv=none; b=SGPJy3oRJeCb0+oEwDateTvYKysBJBXuwZ+ZR7XPhBnhSp906xUR4oT6XW9sptsyIN0wwGvhG/n4Q4FrOWpMiarc1dYZXf+iQmx6+xXAByAuNhb/Va/KOswAD1/i5ai5MeFsuZrcOXAsK7lFiDi2rjYeOyKZqxXBIzMx40WNdOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768310893; c=relaxed/simple;
	bh=H31kp+qb3JJC5sqImeoexliAVV3DVXGNjtkl8rswSXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iBc3pL5njFqVaUBM+3MV+Twr4062ClaUDdZCFLOsvwun199TLGuqTkS9zmr2MwgVICQrZ3SCYPHE2NMeTUkakyDQLsh7XqfqLTVuCSO45WLuOAVJcfPCRXhL5xd3RU0jEp54XzOqEl3SGwwf9fEG9ATJTsK6eTP2hqQQ7pBs6Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BUi7pfHd; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D795DC1F6CE;
	Tue, 13 Jan 2026 13:27:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 390A460701;
	Tue, 13 Jan 2026 13:28:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F735103C81A2;
	Tue, 13 Jan 2026 14:28:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768310887; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=pBLJ3Z03Hwb8H57I8l0t2Yk1Rd/EiqqO6MR9ajsHJU4=;
	b=BUi7pfHdKU2ZTVnDevkMArJxHQXwILBB6XoRZmcTgMYMhyPHCLPk8PCCZHqlgZuTTltlxz
	iYqqQc21yr0t3PvfEub/9RNkWyFidHPaob0ZRLclQ0orWqwoVXePIHe9Q0UlIpZzXNdlkL
	/ra/A5uqEGaOCvM2w0LX4k7KG7Wao0nk9GzDkQ31Ti3f5/Iv7GsaX02kSabiHIB6UzdLoB
	eA3rq5rgcHwdFXlDW6s8gahTxK1/OFcSI3w98DC2dppaJsBdktsk54xmoqYiqZ9npgHnNM
	G1WEm/e2ajXKuw0WJZYSDQAHUhG6s7+lueo6PJvy+HsbLZCyaMTa75dhJKGTTQ==
From: =?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
To: linux-pm@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	=?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
Subject: [PATCH 0/1] cpupower: make systemd unit installation optional
Date: Tue, 13 Jan 2026 14:27:52 +0100
Message-ID: <20260113132753.1730020-1-joaomarcos.costa@bootlin.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

For additional context, I found this issue while building cpupower with a recent
version of Yocto, specifically using linux-yocto v6.18:

ERROR: cpupower-1.0-r0 do_package: QA Issue: cpupower: Files/directories were installed but not shipped in any package:
  /usr/lib/systemd
  /usr/lib/systemd/system
  /usr/lib/systemd/system/cpupower.service

This revealed cpupower’s unconditional installation of the systemd unit and
motivated this change/improvement.

Best regards,

João Marcos Costa (1):
  cpupower: make systemd unit installation optional

 tools/power/cpupower/Makefile | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

-- 
2.47.0


