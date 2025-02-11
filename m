Return-Path: <linux-pm+bounces-21837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF55A30D30
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 14:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E3916608C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B835324C681;
	Tue, 11 Feb 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEvbIbAf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C41F24C676;
	Tue, 11 Feb 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739281373; cv=none; b=dxIy9eeExwtkENFNNffrRRKVcgo6kCjSfZMh/vclWOna2U9+KqF36AfYSQ8xjigjZIgLWY8A5JcAPzxdwEBwAmaGQmzjRpsZawmHfGLi+P4G/ikfFxsAry0GQRA5KWkA7A9uG90BFwdFJLoOSmm6UPRH7hl9FD+xsaO6N6REeZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739281373; c=relaxed/simple;
	bh=C32LleHf5ZcsvCnzLE6ZB1YIQT48U7FTJGBmUOnQxR4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ovjeWgorEarFQqUM8C41cQoj5yjv9HzdzuegTUtJRQ2RBrZV9BNLAGXoxQx5gf0ZH/6Y5HZ21zlmJSatEQvOI5RIhqrkHtWs7YQzA61bSHbDXq5XcNuJHhalT0dYvsWV8DRgYtM66wCcJ6F/hSrVFtJzfEd9AMt8O2OjNhmkBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEvbIbAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7262FC4CEE5;
	Tue, 11 Feb 2025 13:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739281372;
	bh=C32LleHf5ZcsvCnzLE6ZB1YIQT48U7FTJGBmUOnQxR4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bEvbIbAfySxlIzXGv56uAQtOmZ/k2DoU2VZoVvx6x2hg85wRr8KM1joSjQsg7sxAs
	 iORyaF9iTEhpxC3BcPW9gFMvFT2TTYahZoxk9iG7RiNO7qAj0nmO1P6mwCIv+TybmH
	 RFMttvs3BCvI1QBtp41mNkbI3e9/MM2yEv57IqEy7/YmwFx1Bc5ySflPDuirM9/rt4
	 kEQMKgCYwOrdClIUueqHG8u3LyNm6LO/Do1qkSdrCLt3+TA1AmI7hQJJLqOVP3NsTA
	 YqI5qqAlpSTd4kj2u2cQPMSnT17MEoULFFK0d2tpJ8PHqJy2HWktpu2xnHdUJq2yoZ
	 a0/PhNJtZ/Pxg==
From: Lee Jones <lee@kernel.org>
To: linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, lee@kernel.org, 
 samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org, 
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, sre@kernel.org, 
 Chris Morgan <macromorgan@hotmail.com>
In-Reply-To: <20250204155835.161973-3-macroalpha82@gmail.com>
References: <20250204155835.161973-1-macroalpha82@gmail.com>
 <20250204155835.161973-3-macroalpha82@gmail.com>
Subject: Re: (subset) [PATCH V2 2/4] mfd: axp20x: AXP717: Add
 AXP717_TS_PIN_CFG to writeable regs
Message-Id: <173928137017.2164349.13619464947851022064.b4-ty@kernel.org>
Date: Tue, 11 Feb 2025 13:42:50 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 04 Feb 2025 09:58:32 -0600, Chris Morgan wrote:
> Add AXP717_TS_PIN_CFG (register 0x50) to the table of writeable
> registers so that the temperature sensor can be configured by the
> battery driver.
> 
> 

Applied, thanks!

[2/4] mfd: axp20x: AXP717: Add AXP717_TS_PIN_CFG to writeable regs
      commit: ab797d7faf4c28328d2e45b09991f47a9b8e08aa

--
Lee Jones [李琼斯]


