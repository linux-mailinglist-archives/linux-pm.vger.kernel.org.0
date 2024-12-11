Return-Path: <linux-pm+bounces-18987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E13F9EC58C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 08:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5DC188A01A
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73921C5F1C;
	Wed, 11 Dec 2024 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5K+ilQN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70E21C5F0B;
	Wed, 11 Dec 2024 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733902174; cv=none; b=SzsIGDoAQ+2/7IwK46d6Pjaes+u5ZvavvljCB0s1XpSxEWjVyqBxQWTq+rvVL2A6cIDhnzuz8bq5hD6UxID1tUlh2REURsUdGkfp3PpFppfKeo5D/NA1JK+g5gZ6/mIbZsq97bv6n8LvsF2YoqcQvyQkTUTowjstQNWKIE2Fj7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733902174; c=relaxed/simple;
	bh=z7Dc5FJTPUHHlOFfQcHtMzEV5zoZUD9OFcQgozB76GM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RT4XBsj6zNl1ssq5vju7VcASa4NLt1tMRzSthZz0LyoZXJda+QlL5R7/Q5npcjAcM5fBE1waduJlcqC4F6aCpuRxFbZ7/hGQSsfIt0s88zCymm0hEWewCi4lCrUN5a/oZLQYa8XyDzWmdbsLBwIcfiHL2dhsUeR41ZgfQ5Ou+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5K+ilQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 206BAC4CED2;
	Wed, 11 Dec 2024 07:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733902174;
	bh=z7Dc5FJTPUHHlOFfQcHtMzEV5zoZUD9OFcQgozB76GM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=X5K+ilQNlazLd30L97mBpacv/8NDaG0qLsrf+wTSVOW+2+D3K6z08LRR32fsa/vGt
	 /LFj2UII0FEYMWAt5y/QGwvXZ0sZIKx6z7QvMax4B9WY6bKhLRAlN3ojLvpiyj6PHL
	 Ca6dUnHe5yWYwpCiHXOvRu++h9oJztJ7OPDilD6sg1RyWVo5y1CFM135F1Bw2BXBRF
	 VmMzzMplK+k/HHXQnEhzXx0LtF0EHhaA3LV28QbPccHGIEIu6YXATFriQSl5XSS8Q+
	 5hRLRHFvqWkCivR+t2ISXvG15FZ02mmc5+uAlcpmemw9xi86GSvouraMHskoTOrDEi
	 YyMRvzHpMXdLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4010E7717D;
	Wed, 11 Dec 2024 07:29:33 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH 0/2] power: supply: gpio-charger: add support for default
 charge current limit
Date: Wed, 11 Dec 2024 08:29:08 +0100
Message-Id: <20241211-default-charge-current-limit-v1-0-7819ba06ee2a@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQ/WWcC/x3MSwqFMAxA0a1Ixgba4oe+rYiDolED2idpFUHcu
 8Hh5cC9IZEwJfgVNwidnPgfNWxZwLCEOBPyqA3OuMo643GkKRxrRlVRHQ4RihlX3jhj4wO1vqp
 NYwPoYhea+Pr2Xf88L+ON9wBuAAAA
X-Change-ID: 20241209-default-charge-current-limit-69ae7945061a
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733902172; l=780;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=z7Dc5FJTPUHHlOFfQcHtMzEV5zoZUD9OFcQgozB76GM=;
 b=QN+vCWDtq5aI6nCehjbU2+5I8rT3UTY0ytF/rlzS2w5tLUv2ivyxP4cP4PAz5Vj2PmXyH5Cef
 1A1I1Q2ehIlBvjV4jcrNPfjkFwYeQYJwheKvL3xQK4rOC8GXJXDHt7Y
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

The driver defaults to smallest current limitation for safety reasons. Add
support for setting default current limitation via DT.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Dimitri Fedrau (2):
      dt-bindings: power: supply: gpio-charger: add support for  default charge current limit
      power: supply: gpio-charger: add support for  default charge current limit

 .../devicetree/bindings/power/supply/gpio-charger.yaml      |  4 ++++
 drivers/power/supply/gpio-charger.c                         | 13 +++++++++++++
 2 files changed, 17 insertions(+)
---
base-commit: 88e4a7dc04b7828315292eb3acaa466c9c123d8b
change-id: 20241209-default-charge-current-limit-69ae7945061a

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



