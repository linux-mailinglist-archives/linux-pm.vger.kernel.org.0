Return-Path: <linux-pm+bounces-40570-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C6BD0BE7A
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 19:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9FE930D264A
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8652BEC2A;
	Fri,  9 Jan 2026 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrptUlM5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730B278E47;
	Fri,  9 Jan 2026 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984086; cv=none; b=ZXui1DsKs+l0D14u9Igs1wSXMRlB9zBMWnuTNFe+gdxCVJySwaBbxmPqe0dkiCNND41D84WVrr20eTHe8KJxORJosOCOFX+yx6oABqQB5nXmoVZe9wBdXj7upPtGYEakUchcKuG6jNNQZm6xQKPMKNkotXCR2mzSYMETRv1gOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984086; c=relaxed/simple;
	bh=AkWfGMy7CoxX8lwk4ACgbZ8DU1m/o9H1ps5R6pef5iM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=boj96agJJsnBOzHkcZ6vXs/ze8GiKL2ttT0lyioUhb56WFg2IKqw+7mlWSqwmvG84rXqh/f5ceyo/S6iqiSoou3sL1nE7o46JGiPQnqjKDnrEs58Ztjbh/i1fpHHGljJnMqEhOpYvaqXbQikJNYxxvZO5JdiaSrGhjMQJitzUMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrptUlM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37776C4CEF1;
	Fri,  9 Jan 2026 18:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767984086;
	bh=AkWfGMy7CoxX8lwk4ACgbZ8DU1m/o9H1ps5R6pef5iM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JrptUlM5Ow5x+fZBlxiIzEV7muXtKmIAdplB3eeWfly0kmKmJVnLYnsEzWa+CKCGE
	 C4pw7/xpAfG/1Qih8phcNtrqGPgMAKLCGKH9dGRQ1DMDdKB+LaoYsvEM9YfyGKOmdT
	 MY9d1TqAIYTIPQcKGmaRZhww7ls8zoSyAQSeoRee9CTsUjifsID1KW55MdGiPkBXbY
	 JItGoPM0oJXGaZJYcHE1DA4gahAGnBBND9cht5M3Cb7WoHRVoYd8f4EVQ6uxjtjHTM
	 WccQ/xY3Gg+O8D+sGUzMENVyvzuQRMQiXv4CA4vbvC8IdGuKmyXTW8O5FeojfqPROz
	 IOxNJ+4sEXLQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A2CD26D7D;
	Fri,  9 Jan 2026 18:41:26 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v2 0/2] power: supply: gpio-charger: add support for
 fast-charge timer
Date: Fri, 09 Jan 2026 19:41:18 +0100
Message-Id: <20260109-gpio-charger-timer-v2-0-63fd1ba75830@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM5LYWkC/32NQQqDMBREryJ/3ZQkmIpd9R7FhSbf5EM18iOhR
 XL3ph6gm4E3w8wckJAJE9ybAxgzJYprBX1pwIZx9SjIVQYttVFSa+E3iqJG7JHFTktV69yI6qb
 6TrVQixvjTO9z9DlUDpT2yJ/zI6uf+3cuKyHFZEzXyr6VctaPF+EUkPlq4wJDKeULhwyYYLcAA
 AA=
X-Change-ID: 20251022-gpio-charger-timer-cddae1619714
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767984085; l=1100;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=AkWfGMy7CoxX8lwk4ACgbZ8DU1m/o9H1ps5R6pef5iM=;
 b=0WZEp5rREGLi0PqgpPQAQIExjUN2H3LCmNO4sF++IuDli6gLvq2S5z2jpBBOWzPsjiaqJFJkU
 IYpeNHC/qWFAj1OBl8irj0LAwC6aSTmn09YQcHzJf5iy68IoZ7vL8LM
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
Changes in v2:
- Added Acked-by tag
- Link to v1: https://lore.kernel.org/r/20251022-gpio-charger-timer-v1-0-b557409400f2@liebherr.com

---
Dimitri Fedrau (2):
      dt-bindings: power: supply: gpio-charger: add support for fast-charge timer
      power: supply: gpio-charger: add support for fast-charge timer

 .../ABI/testing/sysfs-class-power-gpio-charger     | 10 ++++++
 .../bindings/power/supply/gpio-charger.yaml        |  5 +++
 drivers/power/supply/gpio-charger.c                | 39 ++++++++++++++++++++++
 3 files changed, 54 insertions(+)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251022-gpio-charger-timer-cddae1619714

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



