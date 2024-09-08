Return-Path: <linux-pm+bounces-13851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6458F970652
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 11:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212BB28265C
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 09:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161501384B3;
	Sun,  8 Sep 2024 09:47:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m609.netease.com (mail-m609.netease.com [210.79.60.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB894204E;
	Sun,  8 Sep 2024 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725788868; cv=none; b=MShwmuQ4WKwubZqQSuJlaCz7sZvvo4Kubsk1MnWm+Vuw47pDZWb38L3VQsSF3wQyfZAFX+ig+ERVKA3Sb59OKcpJsoiemYHBoVmD/tORXU48llp34FOaONhRyJHkeXQUJeR2oooclTTJvfxBIvglCX+t3eVWLqvAI43rRwCEbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725788868; c=relaxed/simple;
	bh=PVmzuNEc8v5rWStQSiZ8VF7qRD5aaCjcgn5xVcir2eY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZrIMCPa3iF/Y2/UuxniBFy9P0N3KmY7GbSLXPnUXblw1xkCDAQnLaryByeGMXsLDza9SOgIhTMqcu7/3Sw1TAUYvxXKyH+swx3JOt0keh7+Q+/jeATkWepO2YUdzxU4z9iUifHwy9xbCRrGO3/n37KMuGBkBUFoTpVY9vtVZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=210.79.60.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [58.61.141.10])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 24CA27E011A;
	Sun,  8 Sep 2024 17:30:06 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: bigfoot@classfun.cn
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 0/9] Introduce Photonicat power management MCU driver
Date: Sun,  8 Sep 2024 17:30:02 +0800
Message-Id: <20240908093002.26317-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240906093630.2428329-1-bigfoot@classfun.cn>
References: <20240906093630.2428329-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTU0dVk1KTkkfGUhOThodTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VNSlVKT0pVSktZV1kWGg8SFR0UWUFZT0tIVUpLSUJNSEpVSktLVUtZBg
	++
X-HM-Tid: 0a91d0f81ae203a2kunm24ca27e011a
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAg6HRw*KzIxATIoECo8PDRC
	TD0KCT5VSlVKTElOTENMQ0tNQ0JKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
	VU1KVUpPSlVKS1lXWQgBWUFKTE1NNwY+

Hi Junhao,

> Initial support for the power management MCU in the Ariaboard Photonicat
> This patch series depends on Add support for Ariaboard Photonicat RK3568 [1]

The official website says it's "Renesas RA2E1 cortex M23 ultra-low power MCU"
Perhaps renaming the 'Photonicat MCU' to 'Renesas RA2E1 MCU' would be better?

-- 
2.25.1


