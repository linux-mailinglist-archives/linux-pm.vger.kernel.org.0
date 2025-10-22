Return-Path: <linux-pm+bounces-36675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95861BFE15E
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 21:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 034B034392A
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 19:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF5B2F3625;
	Wed, 22 Oct 2025 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghI2F/sX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808429B776;
	Wed, 22 Oct 2025 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162474; cv=none; b=Bu4HjY8LcPG8EmWUt7H7wWCS596bB+G+lfRQk2MGLtPXgcwigjc8mkZHdi+E5PxnENaHo9KIcoCfeXlCU85IaX4gscR4VQBeJ/AFrKhMAsFaLkUv4V3ULi0pkxMXuN/8bNKWbQj88EEZnoZSSDlzO99xgo+1e1gsia3S4+xjkxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162474; c=relaxed/simple;
	bh=OOWdg8OLvSFMbIcc+BI5b8nhes+ym73swFUSBnZalNE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VKQqYFZi9Or8f2nOCp3/OtRCVMEMYRGMxMzPfH02ZAda8WaGI4Q0OnWr1DWw0WH7sxp/G3WMfrzlUVGZICUx5cKRRliW1KFqmb9uWCiSu51v5SKTgcWBzyeQ88jbKAa1I/xbqTFQIAEsEz8OUlSgvkglzEKuvSm3XEw7XFmm9Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghI2F/sX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91BAFC4CEF7;
	Wed, 22 Oct 2025 19:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761162473;
	bh=OOWdg8OLvSFMbIcc+BI5b8nhes+ym73swFUSBnZalNE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ghI2F/sXv6kWWdckYQ3A5tsNguykdUBo9Iw2maDPIXP7S2NkwvZLVrLxdTIGSPby4
	 uYMYAc61B/PLgCPl1e2kcw0WUiQr2u/Kh6NI3i+UePQaN5tLe890ZYPKVMiSYHP8q6
	 9iPN47MkBSRiHVE01witG8QTGjdqf3YhL0KdT2B5wvzu2QHNkemGiTd5JXYZ3orN3J
	 jMPlYzaPJn9pnwdPIVM0mROu/6Fr3b7YDwbc1dvzW/oRySyXUrMNePiKqt004ys6br
	 vlndUSN3p+KBdlaUQkLtlCP0Il2tNflKpBvd3p5yC+v7ks3GrXaxnLoHA4HnAEr8Jw
	 WA/25hCcgH6pg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D351CCD1BF;
	Wed, 22 Oct 2025 19:47:53 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH 0/2] power: supply: gpio-charger: add support for
 fast-charge timer
Date: Wed, 22 Oct 2025 21:47:46 +0200
Message-Id: <20251022-gpio-charger-timer-v1-0-b557409400f2@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOI0+WgC/x2MSwqAMAwFryJZW2iKH/Qq4qLYWLOwSioiFO9uc
 DMwDO8VyCRMGcaqgNDNmY+kgnUFy+ZTJMNBHZx1LVrnTDz5MJokkpiLd+USgifscOixAR2eQis
 //+k0v+8HfnBUnWQAAAA=
X-Change-ID: 20251022-gpio-charger-timer-cddae1619714
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761162472; l=955;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=OOWdg8OLvSFMbIcc+BI5b8nhes+ym73swFUSBnZalNE=;
 b=PpF7pZWzkkC9XfQLaGcpxqv3v7GM9YR01a9GQv+9HJL/ePXifr+Ey3xAY4D63kEjuBRAihdxS
 vMZkvV1K0xgBDQjEVhfeUSBLDzkmzEDf1AeUtx1xQea+cVr6Gf0WWTw
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

On some devices like TIs BQ24081 battery charger it is possible to activate
or deactivate a fast-charge timer that provides a backup safety for charge
termination. In case of the BQ24081 it is a fixed 7-hour timer. Add support
for enabling/disabling the fast-charge timer via GPIO.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Dimitri Fedrau (2):
      dt-bindings: power: supply: gpio-charger: add support for fast-charge timer
      power: supply: gpio-charger: add support for fast-charge timer

 .../ABI/testing/sysfs-class-power-gpio-charger     | 10 ++++++
 .../bindings/power/supply/gpio-charger.yaml        |  5 +++
 drivers/power/supply/gpio-charger.c                | 39 ++++++++++++++++++++++
 3 files changed, 54 insertions(+)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251022-gpio-charger-timer-cddae1619714

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



