Return-Path: <linux-pm+bounces-32498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE04BB29B31
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C046917B025
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93976287511;
	Mon, 18 Aug 2025 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="gILAbdMG"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD59D287246;
	Mon, 18 Aug 2025 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503382; cv=pass; b=S1fAupHZuT3IXJfKmnAixx17BVCtcstwNeylTLAwB3Mx08ZQdSVUyVdp8GZ2+geRPGjdkxE/ITQAgZnx7fK3WdLxYbqbgiN1iu0jBl3Rx+xws2ZdhvCn+QUMWrHXbRB8/Y7opVjbNhNElYhmG3twLRBERFBuKNGa3ptk1FlwL6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503382; c=relaxed/simple;
	bh=EFj1VJrnLRgxubJrz6YlWacXHRIVbOlh4cXf+0vcdhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rfBZLf7oMU15xBSHAjIfo4iSxHARHIz8LR+Zk99qcKYsCGW8k+MZyt7rnpuAnu0toSK+RjburVatAJ6UgV2fogdks4EVisJXkLGE/4cqcOgTk4a0nJR2OTm9wtM/inM6BtPi6HJRW9TA3qfq8YbhCR7kCLPQIN9z/FnJaZfwous=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=gILAbdMG; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755503364; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Xat82lbwEAS5jmKyCWhCxIrL/pBgJx8v8X9Zf9OCzTYRKnq7vczAO28Ph4iQAHHOVyK9H204KTrbsEPND4n7KsxlBWajeRQDqcY4clpvhTTbeuqt9L6G6c7iRlVprl3CY7UYHaYbRhWImLh6Yht/lWrCjRu+jhLCxgGDoKWj5pg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755503364; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M3qvXpajujXPyv4fG45eVXvK9DfgH/PM+T6mlMFxVd8=; 
	b=c3b/6iJXlHwPsV+IOwvc+S8GbhXs0ie0By7xvFaMEY9lCkoKGYHLyf+zSW4Dg1RcmqN8SHdO8EpBKpVKsFg46fZdLOB8tF3fZz/LjvR0MKQdk0xQOKOczPQLyg8d4IUkqoQAT3ZyOJP2x2SFdcpSlEP+909+oVDrQWUHJim7G6c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755503364;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=M3qvXpajujXPyv4fG45eVXvK9DfgH/PM+T6mlMFxVd8=;
	b=gILAbdMGVlBomoNgtIKUlWz8tm2rVq7h3QiiDUl0ykxnuozKF5nktryt66P3Q+B0
	G4uTYo2pCWzzOHaxJipLyB1GsLOxbrxneteHyQcMn2yHuWuD5ST5OOQpzjJPvJSh77P
	hU0Pp+ZaaEhnNiJPCswVbFm9gTg5gFlyG9vKiR5AgJNuDCsVqJEW60GJYOsEnyjuFlA
	bBk+5G2Nybfz7vqMvt4ZoNhQUoizZWvCFHLyPJpL3Tpn2fhpTOmVpORhFv33KZWrqrB
	wcvdJoCYyWjn/FuiuRd+LJyVV3AIZtLy4Zmfm6z72NbKrhTvgr+RJod3xxeuDXRVuyr
	njNlXuepjw==
Received: by mx.zohomail.com with SMTPS id 175550336257471.67178673265767;
	Mon, 18 Aug 2025 00:49:22 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 0/2] Poweroff/reboot support for TH1520 via AON
Date: Mon, 18 Aug 2025 15:49:04 +0800
Message-ID: <20250818074906.2907277-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patchset tries to add support for poweroff/reboot on T-Head TH1520
SoC by calling the AON firmware.

The first patch creates an auxiliary driver for this, and the second
patch makes the driver currently matching thead,th1520-aon create an
auxiliary device.

Icenowy Zheng (2):
  driver: reset: th1520-aon: add driver for poweroff/reboot via AON FW
  pmdomain: thead: create auxiliary device for rebooting

 MAINTAINERS                                |  1 +
 drivers/pmdomain/thead/th1520-pm-domains.c | 35 +++++++-
 drivers/power/reset/Kconfig                |  7 ++
 drivers/power/reset/Makefile               |  1 +
 drivers/power/reset/th1520-aon-reboot.c    | 98 ++++++++++++++++++++++
 5 files changed, 140 insertions(+), 2 deletions(-)
 create mode 100644 drivers/power/reset/th1520-aon-reboot.c

-- 
2.50.1


