Return-Path: <linux-pm+bounces-11838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6AA946023
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 17:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A221F21CC1
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA553DAC0C;
	Fri,  2 Aug 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GLrmTus+"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9171136320;
	Fri,  2 Aug 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611820; cv=none; b=gQYccSV/6sZlvq+BD99DfWG2F2Nnr0wpEECHyRM3AyBhcUCDty1HRqP1qFlU3tt5PCMnoHB4LuoVnf1XFhjN6rZHY/Mz1lqtfr5g2pJuTJ20ktk55psHVzUc2M70QByfZBgoQegJ+pUOt/wH8BIQZQX3BMuvaAaY18MXNYDQwy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611820; c=relaxed/simple;
	bh=YzI0V43/kzaNDgbEk0GhCnjigPpGJZdjx0urigdeuKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lALP9a3KxPZpYi9pWqgKY9WdncmMI2l5EE9dOlEiw8l5fT9AVk+RTFLUOzIDQ8Lkl1rW7fEbh4URjOCE0jQoX/McDWs5Z/hEkEZVQqnH3pkEDIxGTcOrTsJoCOsZX/7vbrHcWJgUxNIygnnASnKX8JuteXlAizHvJW2FX7VWKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GLrmTus+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722611817;
	bh=YzI0V43/kzaNDgbEk0GhCnjigPpGJZdjx0urigdeuKE=;
	h=From:To:Cc:Subject:Date:From;
	b=GLrmTus+LtId0YIKOkMx3+dctVtuL5KmUS6AGhEI+YGp5lmeLmIm8fCNTPX/O/CSC
	 MbfKNMr/HRyFyxnCWbUAAxDenCoBnIxJZ+mVk3wO5n22VSPJMWSgAlOB2RiWRUTMpx
	 7vO4wfbR4G0C7K54fkzM9KIhLRQO7xmNrztj2faSRqN9Wz73UeqEsSDAx7USuqC6fa
	 vj4nNxk4X0+Ogo16HdGF7JzHSUwk8Bh2XcveJaHXPgQtDZCr8tdvBgzhLTYOVcLqsV
	 GfdiBdX+irzLS1YMUNa6Ob9HXPYlVWgNMXNpcxfJSc8zHHjkhr6IvGjLlfkwYTEy6X
	 dSblbOyLodyng==
Received: from trenzalore.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BB3A137821B5;
	Fri,  2 Aug 2024 15:16:54 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/3] Add power-controller support for rk3576
Date: Fri,  2 Aug 2024 11:14:57 -0400
Message-ID: <20240802151647.294307-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the power domain controller on the rk3576 SoC.
Patches from downstream have been rebased.

Note that the mentioned TRM is not publicly available.

Detlev Casanova (1):
  dt-bindings: pinctrl: Add rk3576 power-controller bindings

Finley Xiao (2):
  dt-bindings: Add power-domain header for RK3576 SoCs
  soc: rockchip: power-domain: Add power domain support for rk3576

 .../power/rockchip,power-controller.yaml      |  1 +
 drivers/pmdomain/rockchip/pm-domains.c        | 69 ++++++++++++++++++-
 include/dt-bindings/power/rk3576-power.h      | 30 ++++++++
 3 files changed, 97 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/power/rk3576-power.h

-- 
2.46.0


