Return-Path: <linux-pm+bounces-35681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C96BB3F6B
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 14:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC90192340A
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 12:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978E83112C4;
	Thu,  2 Oct 2025 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GgnZDdYj"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B946279DD3;
	Thu,  2 Oct 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409950; cv=none; b=fEkeodD/RcXzhWl+poyHunxmb9I6EzIsL118Sgs/6+jRm4mpa2fhq4PykaivPlwYoHRJrRaPYHOePhrZSLuvJ1rF/a+wTsohzi5cF44vraB71H/8qg81sotNYsUwtBOEZX1TTcTxAigQ/t8Nqh89I4pC4UzHzlggmmOcr5Y2v54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409950; c=relaxed/simple;
	bh=OY6KJ1cnrmSQKTHuQpxnxgR86H+8o7i/jX5qg0r50as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uip1w/WIP1GbSupc7SmqNZjt6EYUYn2+UuP0ZhcJImYAKQqlEWK4/8W9SeMzJrWzHtLo5AJKncVbTRe5u2hoZq6W5wSQ1sN/WdKkaMFnpwNmXbkzlvlZfInQ9TD+lju9ElR7R/UMtsx744HVbtsTwq3TGx4sGuEBiwyuxnqtUaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GgnZDdYj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759409939;
	bh=OY6KJ1cnrmSQKTHuQpxnxgR86H+8o7i/jX5qg0r50as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgnZDdYjMGacTTJFQjyv44CoQO3sdnIZbfa7BdrzLSGTYhg3CWOrFw/QrWmj7fEi5
	 MDhTlaFDadOU0FL+ZtmmAikssvsq1n0H7+vH5h+n/IMh7+NoA+aqdkVVLOBosmbJnQ
	 H8i5ntqnyAHsRJHT/mE0zMgm5mZSYjUkupojZ/Y+h/cHgmwEifAfi5R8AIiONWyGFK
	 29swS5AoHj1tVM/jPgnNkcp0Eskg61i8VS6jmkimmbKBgYlys9RbLIgz5/WFyuMdxO
	 ETg8P/Y37uG7ILYFRHzN8N1rSWQW4b6q+cpEDnS90GrJZdDXWd/lTGDEPr6IJgAfG6
	 Q8nIarGZYn81w==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4c71:ac9f:71a:857])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6135917E0AC3;
	Thu,  2 Oct 2025 14:58:58 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: laura.nao@collabora.com
Cc: andrew-ct.chen@mediatek.com,
	angelogioacchino.delregno@collabora.com,
	arnd@arndb.de,
	bchihi@baylibre.com,
	colin.i.king@gmail.com,
	conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	devicetree@vger.kernel.org,
	frank-w@public-files.de,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	lala.lin@mediatek.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	nfraprado@collabora.com,
	rafael@kernel.org,
	robh@kernel.org,
	rui.zhang@intel.com,
	srini@kernel.org,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v3 0/9] Add thermal sensor driver support for Mediatek MT8196
Date: Thu,  2 Oct 2025 14:57:46 +0200
Message-Id: <20251002125746.107012-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804133035.309990-1-laura.nao@collabora.com>
References: <20250804133035.309990-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/4/25 15:30, Laura Nao wrote:
> This patch series extends the MediaTek LVTS thermal driver to support the
> MT8196 SoC.
>
> MT8196 requires a different implementation of the lvts_temp_to_raw()
> function.
>
> To support this, the series introduces:
>
> - A new struct lvts_platform_ops to allow platform-specific
>   conversion logic between raw sensor values and temperature
> - A variant of the lvts_temp_to_raw() implementation
> - Platform data and controller definitions for MT8196
>
> Link to v2: https://lore.kernel.org/all/20250730152128.311109-1-laura.nao@collabora.com/
>
> Changes in v3:
> - Make ops in struct lvts_data a pointer to const struct lvts_platform_ops
> - Changed mediatek,mt8188-efuse const entry in eFuse binding to an enum
> with mediatek,mt8196-efuse and mediatek,mt8188-efuse, dropped mediatek,mt8196-efuse
> const entry

Hello,

Following up on this patch series to see if there’s any further 
feedback. I’ve verified that it still applies cleanly on 
linux-pm/thermal and next-20250929.

Best,

Laura

