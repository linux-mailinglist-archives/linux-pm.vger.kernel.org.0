Return-Path: <linux-pm+bounces-12042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5DE94D0A9
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 14:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1342837BD
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 12:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D889C194A40;
	Fri,  9 Aug 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="fIGHu2gk"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C71E49B;
	Fri,  9 Aug 2024 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208309; cv=pass; b=Chop2Qd7Hp13aQlH9mpgBUCdIdzJnzcJ+NTcjw2OVgIZ3Isj+tjwLkUtYXQvGmVnxg8pJCfi5TEheMHSNi2qGnprmMaBhds+x2WE81VsnY6c4j1isWwGB4ij2+G8MtCsSOR2KPqBH3I9uNVdvBgYL6HiRiu0K1hYM7zFrH5cA/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208309; c=relaxed/simple;
	bh=B1akwv+Nz2NEkiz/ydKyogdQBAECDgmEFMQcdLxjl3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+zFrtp52jWBi+jQGmroiAJb1bY40LO+cgcDbgCh03O9KAKNLPAlQKwcvn6xhmF5OdxER2oSb/GOzvRSFwN0xA3UduhDzSGwxmnWXHU013LgXrhRZ8Jr4v5ruKM5Fw9nnJCIgL3G9UX8JHD1JrGrQK1f7cWbsFtTonF+HaAxBSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=fIGHu2gk; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: detlev.casanova@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723208289; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TFYc5GC2InGK2vJkzxzVWTL9GN3QpNSaShANM3c8hq4SgcO1sj7ZN26EMVdkVgi9WHi/+uGr9eVriYY4F0vUiq6wWIRrHWLQu3oqPvn0J/YvKrKBzHhH8LJFZtBB/JzBefzTGkI/nXpuY28RWtV749aXz0Lm1XJQkqN3FuPzM3Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723208289; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QgHKMVm9qef45pCQ2A52WWjlGN1Vwr37tZFt+U9C6FE=; 
	b=FPRT68Kuzo0e0ITTlViZO1K3d6GeY5cFy3axyw9CfuO9gWf3TBiWPnHnlY9t2H1Uv3TwVLNzVAChWPP1UiAa3UqkgbGmo4GXysKHpXG8w6UggkajXAFPcu/xlwa+Onuiq6+JuwIugeeBH4FHJBwvVPu5xmuQsGCM834hptoM1jc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723208289;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QgHKMVm9qef45pCQ2A52WWjlGN1Vwr37tZFt+U9C6FE=;
	b=fIGHu2gkMWgQrvoFr4Icwf3IrBEmG2HcFbaT1oBi9exQv5l/ODSUYIcTgt8o82n8
	JQnvdf7a6hdrZ8BRZXDEBC74B7opNzWwO+XH7JzKLw7Nr/RHX99XKhvpUESckFERHOl
	xGEwM73kr58aJrqEENWKA3YH+XWquhtd2Opf9sLk=
Received: by mx.zohomail.com with SMTPS id 1723208288516683.9262197649491;
	Fri, 9 Aug 2024 05:58:08 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jagan Teki <jagan@edgeble.ai>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v3 0/2] Add power-controller support for rk3576
Date: Fri,  9 Aug 2024 08:58:03 -0400
Message-ID: <20240809125925.4295-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add support for the power domain controller on the rk3576 SoC.
Patches from downstream have been rebased.

Note that the mentioned TRM is not publicly available.

Changes since v2:
- Remove unused delay for npu and vop

Changes since v1:
- Rename rk3576-power.h to rockchip,rk3576-power.h
- Add memory reset support
- Squashed header files with bindings commit
- Updated license
- Fix commit messages for subsystem.

Finley Xiao (2):
  dt-bindings: power: Add support for RK3576 SoC
  pmdomain: rockchip: Add support for rk3576 SoC

 .../power/rockchip,power-controller.yaml      |  1 +
 drivers/pmdomain/rockchip/pm-domains.c        | 66 ++++++++++++++++++-
 .../dt-bindings/power/rockchip,rk3576-power.h | 30 +++++++++
 3 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/power/rockchip,rk3576-power.h

-- 
2.46.0


