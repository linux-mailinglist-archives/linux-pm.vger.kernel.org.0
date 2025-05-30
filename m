Return-Path: <linux-pm+bounces-27884-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E398EAC9067
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 15:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA48018825BC
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAA4207DFE;
	Fri, 30 May 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="W7EytWms"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB20A18DB1E;
	Fri, 30 May 2025 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748612354; cv=pass; b=Q+t7phOm0GB+XGv1KFAPsJExX0fvMFnFc8he2kD2VBHDIx6cDWAlbEWxGMl46HQUuYjll1IYOKSRThqqpxcsqinf3SDq9+tU2v0eM6fManxaGORs78CbFdfyN/GaThy4MQqy80XRxjREELMpX/2shp4cUAmrldpb4wPLt1lkD44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748612354; c=relaxed/simple;
	bh=12ntjRgwgwK+Seu77q1XPGvqWeoLN1de7YjAF0PqYkA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YUzlO2IxKhtchVikBGJNw3kNU17kmVL+gLb9eOf5NHm5pin7uwTcUq67bGp6mkfCAQ/1mbsUfQqa37l+GVzOBiRcBqB3mLzZyc+yZ1tRSKTVuh7PG1iZ9ptVa4auhNK0Pqqgn08iwuaWHxwOr9rt51qFM/P0hAM07PTgsp0W2ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=W7EytWms; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1748612319; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SZShYD1t7mTQ9DT2tggEIk7RVpQCf8D3/y2WWQq3xAp3QVq2TJNm8s2lhA5m3Bu7IX4+k3Azipd3wd5/YXEee8Nhg+WAmCgDktW+cPgRxy1nTbwb/ufZlgC6GS60Z0xf1vyoXRkR5neD91mJgPUZrQvyF1lH87/56WRqUC+jYPQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748612319; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=y1IxS0jtrAS2T8sDTVWHloBSuBdZ/2pcZoSIPKDAGmE=; 
	b=H3rILkaoiVKgWlNhEKjM6EZiyvUnapLf5g56V+3Bs9THP1+BOv0Z/La9coz7lHvXU7B/RDdf5jf6e/0jm8wQ2bkzPYKyCccXL7uaJlyMPby3SAY5DytJsTzDG/N51Mn9PiN+HltABB0RZAlnB5reYvXoawUyqXogI+Fwl+SmxH8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748612319;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=y1IxS0jtrAS2T8sDTVWHloBSuBdZ/2pcZoSIPKDAGmE=;
	b=W7EytWmsa4SYw9aRN+PY2FYG2NiUItqPeB4c07/PK1UR/4G5Jl6Yc/dXzga8aXn6
	Pv/I+YN9TL/7dFgSsxf7naHrTNbGeWGerVZPEtxySVSOvA9VafN+FPS1QEVY+YlBGnX
	G80zcibtcscMFFi97xEAkivPAzxujErT5+pGHHVw=
Received: by mx.zohomail.com with SMTPS id 1748612317988810.2056390045541;
	Fri, 30 May 2025 06:38:37 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/2] RK3588 rockchip-dfi enhancements
Date: Fri, 30 May 2025 15:38:07 +0200
Message-Id: <20250530-rk3588-dfi-improvements-v1-0-6e077c243a95@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL+0OWgC/zWNQQqDMBBFrxJm3YEYEytepbiwZtIOJYlNUhHEu
 zdUunwf/ns7ZEpMGQaxQ6KVM8dQobkImJ9TeBCyrQxKKiNNKzG9WtP3aB0j+yXFlTyFktF1utN
 KXxtjFdT3ksjx9jPfxpMTvT81UM4R7lMmnKP3XAYRaCv4j8B4HF+xaBm9mgAAAA==
X-Change-ID: 20250530-rk3588-dfi-improvements-f646424715d2
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

This series consists of two related patches. The first fixes the memory
cycle counter on RK3588, which read half of what it should've been
reading. You can easily verify this with

  perf stat -a -e rockchip_ddr/cycles/ sleep 1

and then dividing the result by the number of Hertz the ddr init settles
on, which for LPDDR4X on RK3588 appears to be 2112MHz.

The second adds support for measuring memory bandwidth with LPDDR5
memory. Results have been validated by comparing its reported bandwidth
with that reported by stress-ng --stream 8 --timeout 15, which line up
almost perfectly.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Nicolas Frattaroli (2):
      PM / devfreq: rockchip-dfi: double count on RK3588
      PM / devfreq: rockchip-dfi: add support for LPDDR5

 drivers/devfreq/event/rockchip-dfi.c | 91 ++++++++++++++++++++++++++++--------
 include/soc/rockchip/rk3588_grf.h    |  8 +++-
 include/soc/rockchip/rockchip_grf.h  |  1 +
 3 files changed, 79 insertions(+), 21 deletions(-)
---
base-commit: ba2b2250bbaf005016ba85e345add6e19116a1ea
change-id: 20250530-rk3588-dfi-improvements-f646424715d2

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


