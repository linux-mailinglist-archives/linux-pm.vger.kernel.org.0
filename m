Return-Path: <linux-pm+bounces-40623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E40D104B5
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 02:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D446130158DC
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 01:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6BC241695;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35823ABA9;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182966; cv=none; b=W4PEhrTH94hmP5Nw6jwCJS1w3Mv5lLBeAzHoOe93aaHLTtsO5D8Ka7hxXlGPYp0cr3tomfRtNdvYY2v7aj40Bch7OW0h2w15Gkcy/2xrcyCFTDrbOa9H2ng//Vkua4OJkE2CH1a7k6J+26jSLfIjJ6hrde3PbAOOWzkDSwb65rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182966; c=relaxed/simple;
	bh=3k/tHvMiY/k3YX5UL2WiVCDe46JBdAyyNOmUUt1aHVk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dY+T5LLOopBgq0NAXGkyvEblrKmymVSSofxZOs8P+2SYXk1Vb31QrxbmkpeMIi6ae79OPBTY4Ktp9rARkAfa7/NpnoBDAB58fkx2gnDO1TCS3K4e/YfWZV8lDfBuZHFIh8qj8khvzxqdc5qPaHVkcMoVjw/cMolPzLY0qO6krqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB0CC4CEF7;
	Mon, 12 Jan 2026 01:56:06 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 1AD571805A3; Mon, 12 Jan 2026 02:56:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Haotian Zhang <vulab@iscas.ac.cn>
Cc: matt@ranostay.sg, pali@kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251204083436.1367-1-vulab@iscas.ac.cn>
References: <20251204083436.1367-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] power: supply: bq27xxx: fix wrong errno when bus ops
 are unsupported
Message-Id: <176818296410.643060.3254298529254404514.b4-ty@collabora.com>
Date: Mon, 12 Jan 2026 02:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 04 Dec 2025 16:34:36 +0800, Haotian Zhang wrote:
> bq27xxx_write(), bq27xxx_read_block(), and bq27xxx_write_block()
> return -EPERM when the bus callback pointer is NULL. A NULL callback
> indicates the operation is not supported by the bus/driver,
> not that permission is denied.
> 
> Return -EOPNOTSUPP instead of -EPERM when di->bus.write/
> read_bulk/write_bulk is NULL.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq27xxx: fix wrong errno when bus ops are unsupported
      commit: 688364a11647dc09ba1e4429313e0008066ec790

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


