Return-Path: <linux-pm+bounces-33465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F93B3CC6C
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 17:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126F256346F
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 15:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEA9248F6F;
	Sat, 30 Aug 2025 15:57:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9FE1A23A5;
	Sat, 30 Aug 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756569426; cv=none; b=pOaXkoYEor1e+xvI1FIkJ3b5Q8Vjra477SH8v8dZj1Sr9+4+EnuFa9vOf4SY0bcB0qAZROoq2zrWlAVSAUzc9965iNt1ZbSdc9Tv1t4e/fw9/mGVuku6eSkn3tOtcH1EGqGdPwsspAjWGlmBzJ9hZPqQlHxtRVoYzrPS1GzgzjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756569426; c=relaxed/simple;
	bh=H6pAXHBGj4yBjsx4+6AaigVyDuks1PMwBLPQmlKjogU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u2XMw8KxXBdc36jtUBjGAx5gN75rjiCbW+kN8G1KXWBoM0Jwl1PxUiggq+6X8KGrZ7IChcLfxHZbvyoSXhAGbJmkm82LOqggx1RAiClqPWvGGS8muqBZ2zCWwb/n9vy+brvvWOZxymvMJYkt4wWHTPXBrf2yyj75yLqKqzhCrys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1usNwg-000000007pm-1X2x;
	Sat, 30 Aug 2025 15:56:50 +0000
Date: Sat, 30 Aug 2025 16:56:46 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mason Chang <mason-cw.chang@mediatek.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Frank Wunderlich <frank-w@public-files.de>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Chad Monroe <chad.monroe@adtran.com>
Subject: [PATCH linux-stable 6.12 0/3] thermal/drivers/mediatek/lvts: pick
 fixes into 6.12 stable tree
Message-ID: <cover.1756568900.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Temperature readings on the MT7988 are severely abnormal and inaccurate
on some devices when using the default commands.
Patches to fix this have been posted and merged for Linux 6.17, however,
missing a Fixes:-tag they have not been picked into the Linux 6.12 stable
tree which already comes with the driver support for MT7988 and hence
suffers from this problem.
All 3 commits apply cleanly on top of linux-6.12.y, so cherry-pick them
now, adding the appropriate Fixes:-tag.

Mason Chang (3):
  thermal/drivers/mediatek/lvts_thermal: Change lvts commands array to
    static const
  thermal/drivers/mediatek/lvts_thermal: Add lvts commands and their
    sizes to driver data
  thermal/drivers/mediatek/lvts_thermal: Add mt7988 lvts commands

 drivers/thermal/mediatek/lvts_thermal.c | 74 ++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 13 deletions(-)

-- 
2.51.0

