Return-Path: <linux-pm+bounces-40629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A34D8D104EE
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 02:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C826130C38D9
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 01:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACDC246BA7;
	Mon, 12 Jan 2026 01:56:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1034523AB81;
	Mon, 12 Jan 2026 01:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182979; cv=none; b=qtefLlLzYNBDeUUvYq7prTJwQ4Q1TYC/Uc1VjtnlypwfhSzEcpdjFidpHN5COfjdoSfmuY0qvUmX0JnR2IAG2lpHtVGJ/UTipTZ5D47VIPSWtX1UkNXpda+X0u5VB9evPRFHZtfKjJOonP+PlPTw5hffaMMzG5sZa1kGYi0kC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182979; c=relaxed/simple;
	bh=DyZDhq6OpGf+3A6QGeEtyg/y1/o34+5hDXKEkLVnoVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QfGJqceMg4C5B11qaS/l/2yvxj1iYtkLPhxEass9gjvsuBILwofNRwOplDabOaRGkyFqkHUBHVvGdEpWJ4/st7fOe82OGKSrglfaaYIvcUIgMG9/ENlS1GSBEbLfRU7ay7RQV1x4lYKfERg8+AJHNFrAQOyMrKdZSywQHMQ2Ays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C112C2BCAF;
	Mon, 12 Jan 2026 01:56:08 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 27B96180730; Mon, 12 Jan 2026 02:56:04 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andreas Kemnade <andreas@kemnade.info>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <20251107123621.425633-1-lukas.bulwahn@redhat.com>
References: <20251107123621.425633-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in ROHM BD71828 CHARGER
Message-Id: <176818296415.643060.6329583569295254029.b4-ty@collabora.com>
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


On Fri, 07 Nov 2025 13:36:21 +0100, Lukas Bulwahn wrote:
> Commit 5bff79dad20a ("power: supply: Add bd718(15/28/78) charger driver")
> adds the file bd71828-power.c in drivers/power/supply/, whereas commit
> b838cecc2291 ("MAINTAINERS: Add entry for BD71828 charger") from the same
> patch series, adds a section referring to the non-existing file
> bd71828-charger.c in the directory above.
> 
> Adjust the file entry to refer to the intended existing file.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: adjust file entry in ROHM BD71828 CHARGER
      commit: 04aa3d6dddaf39ecc9735d0b62f46899db71d35e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


