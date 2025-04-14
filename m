Return-Path: <linux-pm+bounces-25386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F648A88982
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 19:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331761746D7
	for <lists+linux-pm@lfdr.de>; Mon, 14 Apr 2025 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22582289342;
	Mon, 14 Apr 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="PgREn5vW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C3528935E;
	Mon, 14 Apr 2025 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650909; cv=none; b=dmH/lJ2/VfhrQzK+UPT2zUC5ExAfeJfsWi6CfDfz0fAN+4599eZ7A4k7wipK2TbWHOyD0sHgPiIruHqZiglsDojeKv2Wd3e3rV9b4hOf6ZlnWKslSieG95SXoFzVoII9YKeJUyaU6AuaC5n5q/IbGAHfDZephkanNMrCDJ3roeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650909; c=relaxed/simple;
	bh=hrm3bDbXY8C8IJMHIADWnR6xcGxHgGqv1qSTTQBZv3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jlmUMDwqAZxFnY2j7W1pAx89DgfG9E4UKUymg23g+6dOFhO9OdVMGRyxYpG8gaUC6cuRKh/vq7GhVnqxQXn6/oWt6r9Lj5UjfwQHnJKo6mqC167GBz25Lik7+4qiUYsUqyGdAlTI/tNzv5XtbVk1RrPnzCGFRffdBUVgQ8JwuBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=PgREn5vW; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id C1AEF1F92A;
	Mon, 14 Apr 2025 19:15:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744650903;
	bh=PqVHueJRpAhv1dOFZj3wC4Af7yM65cFfcx4OGPfp3lw=; h=From:To:Subject;
	b=PgREn5vW2zyNGOk5LaECHIxSmiWRtOTv2iJIlxjBw9wZ69VnjniBFqFbZQP5fWHh3
	 ChNdgKNu2QMTGfM+YkMaEvOOLxbtUNznTU7pxsNQuuhD4F2Z+iFM/b9k6YDuJMcOdc
	 MqMpPF/ESAH2xeH5YjFTnGIZhql/PBq4pAxTqMvAgtGQfOUhrmWRP3g8mOUM41Hphc
	 MN4VjuRRvAPpupuPaWKD6+kZ/dj8kRtgvW0smMRQpNK2ODRvLeYmV9IWrjfTndmNRK
	 tsFqUo1v+s72ClMyoPhW+bE+tmshBBTGGIedbhlUlWrwtJzYAfpJkQ/10Lx84QaWSI
	 dXUYUq+3cIP2Q==
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
Subject: [PATCH v2 0/2]  power: reset: Add Toradex Embedded Controller
Date: Mon, 14 Apr 2025 19:14:53 +0200
Message-Id: <20250414171455.155155-1-francesco@dolcini.it>
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


v2: fix commit message
v1: https://lore.kernel.org/lkml/20250407114947.41421-1-francesco@dolcini.it/

Emanuele Ghidoli (2):
  dt-bindings: power: reset: add toradex,smarc-ec
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


