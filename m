Return-Path: <linux-pm+bounces-13188-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE7D9650BE
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 22:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A471F22CB7
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 20:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A271BAEDE;
	Thu, 29 Aug 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jZEN+jeH"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C36A335C0;
	Thu, 29 Aug 2024 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724963170; cv=none; b=XlNLvoJFEEshuHMRZ8jvSRUwTsac+ZnBYhNuHJxX8n9xptpYC1ToE8RIU+GjxUuHtFUD3wmumDVm71n2ulPFEar/wHcpwH8Lq89r++j6Uk4vofuskbkOY6Ox/WxDUeXlWyjODiI+i9+V4NljeZrNSqpsDDCINJw/bvUiS8MuZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724963170; c=relaxed/simple;
	bh=BaxomN37nDwtcnmBYKiF+VC28hwTR6bK3LpyB9OgCgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ByF/OPVq34kLt9q8RgP1BXdkRllvzeylerdefX2wFEu0IrK4s09Q22Gfo7XJn52v25Ya3xqqsnm2XqSrDGDB+1QVw1UXaiDsU5u5265sna9PcYlzyD0MnI2Zo8eh7jsQGKmo/P8TTqj9/mbmOvGSqVjukoAD5fHRTjF0fkzjHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jZEN+jeH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1724963165;
	bh=BaxomN37nDwtcnmBYKiF+VC28hwTR6bK3LpyB9OgCgM=;
	h=From:To:Cc:Subject:Date:From;
	b=jZEN+jeH7HMlHpowmFwVY7eRAT9EXQ8uctKj5VMlTqiADsOZZpCG/5EtuXGzxUnSJ
	 0Kj/LdRiBz8u1ES371B2MfcpzoLYRt30QAjkxD6Tz6vFJu8+CO78F1gGAopT0jO2u6
	 3EXHuRaesdIQZ48YhlT1h2iAWAMgyzPfMQiYUpQXeL+uPPg4TxK2O/HH+t8GjmB6ZW
	 /+PjmgQAgQR1XKtxLxux2SEQ09NIDp++fjJsbKq/TX1VwTWM66WCtw1CL0MV2Dx+OF
	 DGCXhB+zS5va3dxb6/TNMWwH4uKlCFXASD89fh4NI/C63PqdCj3Jc8XAsG1O04G7DM
	 8gxcenifnjmiA==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ED21A17E0EA9;
	Thu, 29 Aug 2024 22:26:03 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 0/2] pmdomain: rockchip: Add gating support for rk3576
Date: Thu, 29 Aug 2024 16:20:46 -0400
Message-ID: <20240829202732.75961-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rk3576 SoC needs to ungate power domains before it can manipulate
their status.

This makes to to ungate the PM, changes the status, and gate it again.

Detlev.

Detlev Casanova (2):
  pmdomain: rockchip: Add gating support
  pmdomain: rockchip: Add gating masks for rk3576

 drivers/pmdomain/rockchip/pm-domains.c | 87 +++++++++++++++++++-------
 1 file changed, 66 insertions(+), 21 deletions(-)

-- 
2.46.0


