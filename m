Return-Path: <linux-pm+bounces-20587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED23AA14286
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 20:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE143A4C50
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 19:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5402361DA;
	Thu, 16 Jan 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hNPRVj9p"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E150E23026F;
	Thu, 16 Jan 2025 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056698; cv=none; b=banJ7W065GGl+l+H9yxtU5oMyfkXlkLMmIgUk6wDswI/BBqAFEpKSKFzPSu/BrqKkGzlOchl9NzIDWVyc2N5g8duPEq11uyS4FUqSkW3XO37WlDBVye4fqc3gwJWuGy2p3mO794VKtXwlTsLVGfEh2FFC2kgIxLhvj+G92haed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056698; c=relaxed/simple;
	bh=8v9mULLUI2zAoxGeGM2bMkwyZL9ROiSzuwJKu8SZEwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tqTg0gke8msv3jts/dyco3ndsJrGydbmfYLMbCJ5qjzJ42sHnAbr993rDOkrAVmV+hAShVOPCcz+c38Bhhk2QcxWIhPqLpfdpurD7tfoiptW0Pwxl/4izGGCgRKJ8wGQSz9t+ZwEIO49rVTmwR4ZnJKXDp324TS8ytmg2xBa/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hNPRVj9p; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id ED087C003AAC;
	Thu, 16 Jan 2025 11:44:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com ED087C003AAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1737056690;
	bh=8v9mULLUI2zAoxGeGM2bMkwyZL9ROiSzuwJKu8SZEwE=;
	h=From:To:Cc:Subject:Date:From;
	b=hNPRVj9pcHgFu2kSnD1cjamUQf/Z9BDzyilypaZLMHgGwdb/Soll1ngRfo63hReJI
	 oKQbRaxWRpUJlHreX9REMOXGMU3q34tfsdzRX1EDKcA/R/tG86kHjfR4GA3ms1vVE/
	 lPXY8PujMG30Fo59n9/F7u1nHrKKLHsMKauCco4M=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 6DAC918041CAC6;
	Thu, 16 Jan 2025 11:44:49 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE)
Subject: [PATCH 0/2] Thermal support for BCM74110
Date: Thu, 16 Jan 2025 11:38:40 -0800
Message-ID: <20250116193842.758788-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small patch series updates the existing brcmstb_thermal driver to
support the BCM74110 chip which uses a different process node requiring
an update to the thermal equation.

Florian Fainelli (2):
  dt-bindings: thermal: Update for BCM74110
  thermal: brcmstb_thermal: Add support for BCM74110

 .../devicetree/bindings/thermal/brcm,avs-tmon.yaml    |  1 +
 drivers/thermal/broadcom/brcmstb_thermal.c            | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.43.0


