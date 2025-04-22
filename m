Return-Path: <linux-pm+bounces-25827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E929A95CF2
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 06:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF8C169E22
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 04:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E762D1A3162;
	Tue, 22 Apr 2025 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwxRVvv/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05BC1A0BC9;
	Tue, 22 Apr 2025 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745296055; cv=none; b=AMwVGI1MYVwIXZZQNHEhgWo4o4JvP7v2brTH4oJDV+gd/fYaUzX8ZEdZ0wLWeCx+G0mWWaW3ZaQ7f+VoSst0F0ObSBSbbVjtxHo2od7oKh1jhLljckBCfWVlseu6/T58W1JQ4jq0FnS53foZseXUD9kbyHOeyvd3D9928y3jZ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745296055; c=relaxed/simple;
	bh=Fq2jiJWeXkpHf9bZrGaOYFjubx/HEzHAg8dgrWDcSb4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u3AN9FTivbheVpWtDHbeXo2yWLWVkj+flLy/NVGn6DW49RAO39wcoXh9YqIdgb0HbNjrB9/saDAztIhoEcFsCxvy/tqJBfutfG6tadE3he0Pst0YXNbpABO5zYl1E5mDcPP7wVH/ypxy3ebxi9rK1ACSpumNDnrzaMIa3vGfY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwxRVvv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E6B8C4CEEC;
	Tue, 22 Apr 2025 04:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745296055;
	bh=Fq2jiJWeXkpHf9bZrGaOYFjubx/HEzHAg8dgrWDcSb4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jwxRVvv/3VQV090c31ixZiiaa7zEqHQbOifOO8y+hb2Bba86pCI+NsdIa8xoiqGDQ
	 Ke5/59FRVRdROWFiO0T7qSUU4G+Ile/ae8jZ4krO8an3g9Nmt7MkPnsUcUq9iytbSE
	 Io+7HUKhDCIHORnpsYS86o/eP4dKqz50zTtlS3xLW9zJfzqsB/xSCOfcKrqCdSX0FG
	 KVsJYdEPMvTJk9+qoE6A+LZScbr9Qc1zX3lCppVNggJG3eSFErKLiqZa1bm3fzoljf
	 lFRRcA0kqQv3A4Z9HbUE/H/2vIcIMcbl8YNpPRtDxrxWYHtuo8U2nHVYVtLmL8KJuB
	 8wWdj2d1dRqcQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A90C369D7;
	Tue, 22 Apr 2025 04:27:35 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH 0/2] power: bq24190: Add BQ24193 support
Date: Mon, 21 Apr 2025 23:27:32 -0500
Message-Id: <20250421-bq24193-v1-0-f125ef396d24@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALQaB2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyND3aRCIxNDS2PdZJOk1CQLy6SkJEszJaDqgqLUtMwKsEnRsbW1ABs
 W7d9ZAAAA
X-Change-ID: 20250421-bq24193-c4beb89bbb96
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745296054; l=533;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=Fq2jiJWeXkpHf9bZrGaOYFjubx/HEzHAg8dgrWDcSb4=;
 b=GRCOGOgn3GfkllHsnZKOdlGAJrKKqIid2EUxM14fCUK0PTQ/+ZVq6zae/WIE7tjoVEC54LCsJ
 ICpJ2zHv9GfCQeKtXF+HLOQ0G4WkcGQChFbaCWO3imAExhWNhMvCq9E
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Aaron Kling (2):
      dt-bindings: power: supply: bq24190: Add BQ24193 compatible
      power: bq24190: Add BQ24193 support

 .../devicetree/bindings/power/supply/bq24190.yaml          |  1 +
 drivers/power/supply/bq24190_charger.c                     | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
---
base-commit: a33b5a08cbbdd7aadff95f40cbb45ab86841679e
change-id: 20250421-bq24193-c4beb89bbb96

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



