Return-Path: <linux-pm+bounces-14653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A309855B0
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 10:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D01F1F24357
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 08:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDCC15AAC6;
	Wed, 25 Sep 2024 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="fekwNvTo";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="NpMD+N51"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852D8158DCA;
	Wed, 25 Sep 2024 08:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253677; cv=none; b=TFeUk9gGL43qN3+lk/2tkfbh1Hudpmyp03vDs2WXpXM7ZVsqgCoiD6eCFAZ7jxURVEtgYXaEZ7ZLAIIcElU1RUgppURoovNjTd8K9a5QRP37KXIsqqZhx67AU+q0OVhN3RQeKWNO0MwIxsZRWMWvVs6AytABiSs4FYsM32CMjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253677; c=relaxed/simple;
	bh=nM7iSF6c0w0QH1Vof8AfQe6JrilnzTkiXL14EjhKcg8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r362j44XPBexFvatOmCZ9TuPCjB1z3s94YV66wLk10vpMDSuoDm6aQJ01P1qQvx/Des4MUDtyaRqlLm9HPWDXKmgpPydHyc1uVOf5OG4rNjY9Ts9KeYZxntR05wX5UYfTSWjdUKCBA+ovJ9/9cv+z2AYsudEbvOJu0yWIiI28lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=fekwNvTo; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=NpMD+N51; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1727253673;
	bh=mUdi9yMu+UVLGMRC6gLui78O+3HasF3EwSVe5W6mxn4=; l=487;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fekwNvToiCKUKjhunshSt0nkQa1Lb0XjunhQSqpQ05gPaTPOXQAlKXH//zlc/7wUu
	 b+7qJ9F+HoiWEvS/vCOSHErcofXXtkzAWDbBj9g+H9LYsIPequdkpj6R+4fmivWpX+
	 iLvC3qWeEBLIlBQXmiiJetTFEEQqqyTK3br3jrER5bMbX2AiJRZVzWraiuN+ZheekH
	 qLxbhfHadK0nGwcpYfeTGl9K5DmB1Jnx0gr42gUnQwgr6J6Du2e+SOI1bACgCjlwyW
	 YW8Qt6p/UjBFHzz5oLpw3Sx/eR7SIc26jYSM+flw+psMZNXYLXYymFhq11L44nM1J/
	 goU9f50mGu1Mg==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(3190227:0:AUTH_RELAY)
	(envelope-from <prvs=1995EE0AA0=cy_huang@richtek.com>); Wed, 25 Sep 2024 16:41:12 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1727253672;
	bh=mUdi9yMu+UVLGMRC6gLui78O+3HasF3EwSVe5W6mxn4=; l=487;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NpMD+N51Ywt47RXmlxrH0u/GQy9UoyJ/bpICzmA8sEKYQfqsnl0GCvrpRriMsx2WF
	 TPyp2ntRQtirse4CdPemzkmY4o8jrrBgDQ/LcVsgYtXsRP7uZWzNXgG6t1SERjyo9V
	 xwovulQg3nJjrGLVm+av6IwT8yMqvfhXK0IPctGHBaeqKnJitDf1lUKP72fiR9vGqx
	 wZm7/ZzwMU+4bN0Q3aGG/QUMQ6S6MO8zrNYNaK8dXMRgbvqzGi3+HlnwmeMS1caUlL
	 zKTGZ1qHzyyhOCmN0htLJIP4zbPFKpK7f/ramjPpNYU3tnpzaVipqGVTqOzWGG1+tg
	 2pQxYl2cHUbXw==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(1323018:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 25 Sep 2024 16:33:16 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Sep
 2024 16:33:16 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Wed, 25 Sep 2024 16:33:16 +0800
From: <cy_huang@richtek.com>
To: 'Lucas Tsai ' <lucas_tsai@richtek.com>, Sebastian Reichel <sre@kernel.org>
CC: ChiYuan Huang <cy_huang@richtek.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] power: supply: rt9471: Fix WDT bitfield and charger status
Date: Wed, 25 Sep 2024 16:32:57 +0800
Message-ID: <cover.1727252762.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series add the following fixes that reported from the end
market included WDT bitfield and the real charger status.

ChiYuan Huang (2):
  power: supply: rt9471: Fix wrong WDT function regfield declaration
  power: supply: rt9471: Use IC status regfield to report real charger
    status

 drivers/power/supply/rt9471.c | 52 ++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 19 deletions(-)

-- 
2.34.1


