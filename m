Return-Path: <linux-pm+bounces-23154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D239A492C8
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 09:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF9916F9F0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 08:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078121BDA99;
	Fri, 28 Feb 2025 08:04:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAE71BC9FB;
	Fri, 28 Feb 2025 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729855; cv=none; b=nFvMjkHFXRXEBNhDONIlwtwdENepu3aDOSIBOniJgPws86YvVzXgaOawQDXp5Ta0E5kqW75oAxDYBA6i8eJOIlmWHVfln5rQiEuaiyIQMdrSMdWM4z+Ho4WkZ0DRYMi5aRB4BLj9/sySUOLPuIcXKPWBq4Ux/Vzzm0CUv90WH14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729855; c=relaxed/simple;
	bh=svq9Iu/fuXJ3Td3Wbgw3xJRuitwGhtbaWpt+BRHs/Zs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cydDf7weffvLTqtikv5is7TaGwBnyMSvQZfrdpPDnthS9MjzLh3Q93C0VQhjdmi4QK4X/OgGPx5xFL2ZQQaJU2clloWBumqujeMUvioGtKP4E5LAZ72dC19fy2z9EhcD2W271op/nc+4QLKctzaOD6V7WmDwkaPXkc5rpg77wxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201602.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202502281604061769;
        Fri, 28 Feb 2025 16:04:06 +0800
Received: from localhost.localdomain (10.94.16.254) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 28 Feb 2025 16:04:05 +0800
From: Bo Liu <liubo03@inspur.com>
To: <sre@kernel.org>, <mazziesaccount@gmail.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 0/9] power: supply: convert to use maple tree register cache
Date: Fri, 28 Feb 2025 03:02:27 -0500
Message-ID: <20250228080236.2759-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
tUid: 20252281604062f6713ea8aff083e82110897b9308013
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Bo Liu (9):
  power: supply: bd99954: convert to use maple tree register cache
  power: supply: bq24257: convert to use maple tree register cache
  power: supply: bq2515x: convert to use maple tree register cache
  power: supply: bq25890: convert to use maple tree register cache
  power: supply: bq25980: convert to use maple tree register cache
  power: supply: ltc4162l: convert to use maple tree register cache
  power: supply: max1720x: convert to use maple tree register cache
  power: supply: rt9455: convert to use maple tree register cache
  power: supply: smb347: convert to use maple tree register cache

 drivers/power/supply/bd99954-charger.c   | 2 +-
 drivers/power/supply/bq24257_charger.c   | 2 +-
 drivers/power/supply/bq2515x_charger.c   | 4 ++--
 drivers/power/supply/bq25890_charger.c   | 2 +-
 drivers/power/supply/bq25980_charger.c   | 6 +++---
 drivers/power/supply/ltc4162-l-charger.c | 2 +-
 drivers/power/supply/max1720x_battery.c  | 2 +-
 drivers/power/supply/rt9455_charger.c    | 2 +-
 drivers/power/supply/smb347-charger.c    | 2 +-
 9 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.31.1


