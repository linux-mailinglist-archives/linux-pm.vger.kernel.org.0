Return-Path: <linux-pm+bounces-24876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44820A7DCE0
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 13:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC14188C36F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 11:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862462459CD;
	Mon,  7 Apr 2025 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="wnIe4M1b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB651235C01;
	Mon,  7 Apr 2025 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744026597; cv=none; b=uXPR/ideJodUKA/rGGAtiG/1cu8JKFYHrYX62dZKSoWnS4zXTP4eVuVWdNQTPKCE+AWgV+tBFHM+hkx/NCJWdvaMuyypt6Akkh2711kGCPUMo50NzGGiUJdcN4cAbtpe3T+TdrqmJpofNm/CxNmyHnS+Bjosuzd0HJHIuW6x1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744026597; c=relaxed/simple;
	bh=ucQEgl5HVHeTeohrebWaZYsCRJh0bcFkwg47+cWp9Z4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IfdGoy4XlzrgqeExlPqYMxmPWOuFQfsCHadjmd8nn44CBSp25y4eT6+dK4rkm/Xme9EvtFomyFBzCo7Trv86OwVHuvYnBE3IngJACheTVgFmBrBnOcTLfMj4WCRbiLaE16+oZ/dW/CFsr1WZdTTgnt1U2s/isYxsY+GdbzMYQIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=wnIe4M1b; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E17C81F98F;
	Mon,  7 Apr 2025 13:49:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744026592;
	bh=NQ2gG7/p35F4oCss8jQo4006NVKLZ97AM8WN/al+RaY=; h=From:To:Subject;
	b=wnIe4M1bSit44VsWX/X00gxK8FJL0McQULfrSNsyWV+Ad0J3pFzG1W/Bu5AxnJhdn
	 tGsuy2gSqLBvakzaym3zYk8mKeFC8SomZIRU4yP6tixPtv4xFEsc8PsxMkRWW3AZ1i
	 zAX2Q99ZdRYvJdgSssD2SYzJ9QQVbXjB+0t0SDA2jpuwjbFAidWg2GyXFJDW9rArmI
	 J3LP08RdGMrdNvb9RZORWzRc9WWVNXZcO8Ob9a1yiUDIUDy3Wlqs5QanGdc8EKiHLe
	 EyzwTwE9W8x+PPasjITYG8ONNkt+hikTCg8wR1uyQ3rEL6OlzmNDrhbqYJy6KpIdSN
	 TWQ/2MSY7OvwQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] power: reset: Add Toradex Embedded Controller
Date: Mon,  7 Apr 2025 13:49:45 +0200
Message-Id: <20250407114947.41421-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This series adds support for the Toradex Embedded Controller, currently used on
Toradex SMARC iMX95 and iMX8MP boards.

The EC provides board power-off, reset and GPIO expander functionalities.

We did send an RFC before,
https://lore.kernel.org/all/20250313144331.70591-1-francesco@dolcini.it/, with
reference to the discussion about implementing this as a MFD, we decided to
just have a power/reset driver, given we do not see a need to expand the
functionalities we already have.

Emanuele Ghidoli (2):
  dt-bindings: firmware: add toradex,smarc-ec
  power: reset: add Toradex Embedded Controller

 .../power/reset/toradex,smarc-ec.yaml         |  52 ++++++
 MAINTAINERS                                   |   7 +
 drivers/power/reset/Kconfig                   |  13 ++
 drivers/power/reset/Makefile                  |   1 +
 drivers/power/reset/tdx-ec-poweroff.c         | 150 ++++++++++++++++++
 5 files changed, 223 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/toradex,smarc-ec.yaml
 create mode 100644 drivers/power/reset/tdx-ec-poweroff.c

-- 
2.39.5


