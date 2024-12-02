Return-Path: <linux-pm+bounces-18347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 647449E046D
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 15:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A420B25C8E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 13:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8751FC115;
	Mon,  2 Dec 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiNEk7Os"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9FDEEDE;
	Mon,  2 Dec 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144901; cv=none; b=ahGXB+RgzX1QZ5fU6/XOZShwsroYuWHaopfcbywo2igoYCtzOD28/jq6FB99QLpzmtN6GoIPJzUAQIcAhdfRAAMmIscUfhleRbi+ptBEU1T7NWsLIznGN1L/0yaU1v/5zCuBkXgb/wTXIdWsRcfRDeYIbcC3WnL3gvJcTaBA2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144901; c=relaxed/simple;
	bh=gutyObQKsachHq0/nA2oAKqQxOFoQ3uvLG/DLWbnDiw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D1pQFnlTl3E6f/kd80sv5PcjlgE3W0LTnGfT/yM41pTrwr/FclW2/VHd2UVEhm1f18pQpoF8R/XXk/0tvGccY3/5CjBbH6t/P6azuRrvaK7c8DKCepyKStpqZw3Xpe6BOJfBGVhZ5nap5bU8DBOx+7X+QQLXfURaGCN0ZDBMVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiNEk7Os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23D19C4CED1;
	Mon,  2 Dec 2024 13:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733144901;
	bh=gutyObQKsachHq0/nA2oAKqQxOFoQ3uvLG/DLWbnDiw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=UiNEk7OsXFe+cdf8+I5BfuYbG8+O7eT9931PcfkI5ezc7fUDYYY/w1NfNsGWA7ZbQ
	 5GTh6RHIfgTqm1+DfLmV9/HAB9RUanscHZanEj/iU5thJWnRRIwfxyTc+24F+RJSuQ
	 qaDyYcfek3n0lFdt/cEKenRoDhBab0CBwe61xLf2b4hbJ5kk0sRA0A/1aF8Ru6/rvv
	 VIV4ODtHr/mo/l6nReLjupBo8WUASknk5cPV5WvmLk05triWjuwuKBeWUKtW6WWSaB
	 ocE5Uf/t6Fjd9bi9olvKvfDbXL4VFDjojurvGnYhO+JL7rKJAe5nuiUbAJdvPANJI4
	 Oi8MkTR9L95dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3B3D7831B;
	Mon,  2 Dec 2024 13:08:20 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Subject: [PATCH 0/4] Google Pixel 6 (oriole): max77759 fuel gauge
 enablement and driver support
Date: Mon, 02 Dec 2024 14:07:14 +0100
Message-Id: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAKxTWcC/x2MywqAIBAAfyX2nOCqIfUrEWG12h56oBCC9O9Jl
 4E5zBRIFJkSDE2BSA8nvs4q2Daw7u4MJHirDkoqgxViMSIklDgfLltru372QRipSGl0ZtEaanp
 H8pz/7Ti97wc7Q2hxZgAAAA==
X-Change-ID: 20241202-b4-gs101_max77759_fg-402e231a4b33
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733144859; l=1133;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=gutyObQKsachHq0/nA2oAKqQxOFoQ3uvLG/DLWbnDiw=;
 b=Bhzd4ybqtj55n/U2YOZSfbuvXzTGyNb206Tg8GJtVh03aqvqpmF8Nj8CDa4qgOCKVsNZyXzzf
 NKlykWlpZGdAQoXH5iuxKaEXiFeZPBrvAsOb3+wQlD3Lviex1H6Bmen
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

The Google Pixel 6 has a Maxim max77759 which provides a fuel gauge with
the same interface as the Maxim max1720x, except for the non-volatile
memory.

Modify the Maxim max1720x driver to be compatible with the Maxim max77759 and
enable it for the gs101-oriole board.

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
Thomas Antoine (4):
      power: supply: add support for max77759 fuel gauge
      dt-bindings: power: supply: add max77759-fg flavor and don't require nvme address
      arm64: defconfig: enable Maxim max1720x driver
      arm64: dts: exynos: gs101-oriole: enable Maxim max77759 fuel gauge

 .../bindings/power/supply/maxim,max17201.yaml      | 14 +++++
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts |  7 +++
 arch/arm64/configs/defconfig                       |  1 +
 drivers/power/supply/max1720x_battery.c            | 71 ++++++++++++++++++----
 4 files changed, 81 insertions(+), 12 deletions(-)
---
base-commit: 12e0a4072e8edc49c99418a4303bd7b96916de95
change-id: 20241202-b4-gs101_max77759_fg-402e231a4b33

Best regards,
-- 
Thomas Antoine <t.antoine@uclouvain.be>



