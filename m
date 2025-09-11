Return-Path: <linux-pm+bounces-34492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F80B5383B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 17:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781ADAA75A8
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994C34AB16;
	Thu, 11 Sep 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFnDgDqu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71417135A53;
	Thu, 11 Sep 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605867; cv=none; b=KQG5sThFLuLtmGguRR96BfokJOhaKPyBqnuGQDgF0yvOV2Hoc6MSPpf/CFWqe3P4e3F1orfNMnwIer7BOGFEj2lZJQj+ucd9idKObqPMmyO0XxL7Z81u+USYL28mA2ldszKCdvlb5odqgLkDSnAcUZfYeXVFFzlyiOKSzDdPqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605867; c=relaxed/simple;
	bh=D+Kiy6o94m1pRNW35/OkOm3daFa7P2zcK4Au4ZPzqxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udqgbWqJKxOxnQCtIUVl8FxP839RdF966teGsj7Qhc14llpR++2rhEI4Y0tGCVNOYnt7Zl4sDlRHrrHLfs8a8ibfQy5RsgiygNUdwC/fAg3hqBpdsSK5+oZulE/l9e7p1Cn2VkNYeDml0pVponU1lpilthNXRGaMe6GdJtJd3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFnDgDqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A446CC4CEF0;
	Thu, 11 Sep 2025 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757605867;
	bh=D+Kiy6o94m1pRNW35/OkOm3daFa7P2zcK4Au4ZPzqxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AFnDgDquTQ4yMZNrF/l3efaw61XvagSaqRTcqUNm2kYVUlgPqlHzMggjyZWecy8mr
	 yqf7yie6CvD2Un7SKUu5Axyk47npfDJfDfPp7/LrAOhnshXgGnes96Vzn9ALEbAQEF
	 KTt4O7sXRZWjYjik02lYyltg9Qiasu/Z5h1Bd5gJxhqRZ6JoNu0WkAzQGQqzsWGXAR
	 lOcwjAouDJM7lGgaMcT9dW/XFFnOosZIRye+xBqYwjTAVGer1Ypc5otdezY4T96QRs
	 eQbm9/yNKZqkN+KYSI/1vFFm2wR3YIIjx188IXYk2UyRkQtE/z3rTgDIt9gumGvNjJ
	 cqj5lkn5Rn4Hg==
Date: Thu, 11 Sep 2025 16:51:01 +0100
From: Lee Jones <lee@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
	sre@kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [GIT PULL] Immutable branch between MFD, Power and Regulator due for
 the v6.18 merge window
Message-ID: <20250911155101.GA1637058@google.com>
References: <20250904160530.66178-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904160530.66178-1-macroalpha82@gmail.com>

Enjoy!

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-power-regulator-v6.18

for you to fetch changes up to 981dd162b63578aee34b5c68795e246734b76d70:

  regulator: bq257xx: Add bq257xx boost regulator driver (2025-09-11 15:55:41 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Power and Regulator due for the v6.18 merge window

----------------------------------------------------------------
Chris Morgan (4):
      dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
      mfd: bq257xx: Add support for BQ25703A core driver
      power: supply: bq257xx: Add support for BQ257XX charger
      regulator: bq257xx: Add bq257xx boost regulator driver

 .../devicetree/bindings/mfd/ti,bq25703a.yaml       | 117 ++++
 drivers/mfd/Kconfig                                |  11 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/bq257xx.c                              |  99 +++
 drivers/power/supply/Kconfig                       |   7 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/bq257xx_charger.c             | 755 +++++++++++++++++++++
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/bq257xx-regulator.c              | 186 +++++
 include/linux/mfd/bq257xx.h                        | 104 +++
 11 files changed, 1290 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
 create mode 100644 drivers/mfd/bq257xx.c
 create mode 100644 drivers/power/supply/bq257xx_charger.c
 create mode 100644 drivers/regulator/bq257xx-regulator.c
 create mode 100644 include/linux/mfd/bq257xx.h

-- 
Lee Jones [李琼斯]

