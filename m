Return-Path: <linux-pm+bounces-35683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E92FBBB4718
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 18:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE2A19C68C9
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757DA2417C6;
	Thu,  2 Oct 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaW0TUJG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE58233722;
	Thu,  2 Oct 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421265; cv=none; b=TgoRKxXRwLHEIlU1o3n85t/IDQRgtzmMn1IihOwPgfRPKjVrk/1M2H1z/dlr2449qtXMI+1nuLPysrsaVooMEkgN7Qby8qsa0yi6HK6NzkvA4O59h1eSXYvh2gXbwpxzdPZhNneZWOpakXKMwAzwyd4UuSkiAY2ZY6Qa1cT58tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421265; c=relaxed/simple;
	bh=7HS3xDv56hiDsg1+8hgJy4KB2sJ7ucY4QIiLu0ewozc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XV8xF4I+u1+3+bWxbIH8O0NMpS86rf9+Wz4PtzHoG7fSS7E2JhMccu3OD2crnv95MoK/JLUMQydQA/D/Rv7vOhllsl33WVthyZE/jfXjXOLv3dPykrkNjdBLwogic5qUIvFtHvFLHhFx4zHxJRPN3EzXZefaTk2Ry3eBpeCjHsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaW0TUJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F105BC4CEF4;
	Thu,  2 Oct 2025 16:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759421265;
	bh=7HS3xDv56hiDsg1+8hgJy4KB2sJ7ucY4QIiLu0ewozc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RaW0TUJGjtHO6268lGs5FWYM8bDaIXCSLtQU3OQTBfqWK+Bu/YI965Qk/RH77hHhC
	 BZsET7tPw7jl0bEU18wN/up2OTJtKc8M2jv+0DQ32MJVxsx7TbDp8cojcNESMwRea2
	 wcWcGGd3edXKE63RYLTUcZgyToeCQMB8m7VYypsofwxaE4Qrf7lsUc7Pe1U09/7/1U
	 XuNwJi/gtguk59RGBUE+pGb1v41/s8SByzuXvUWx5BxBrwPAqn5CsKfwIcqlqAY3UA
	 GmlBRjcaxB4L2oV1HxeXgJ8n5mEa2dXUcaLqVEH4cFz1dCJlF9FNiFYiLeCwr49tWe
	 +f1IhhhmHeFWQ==
Date: Thu, 2 Oct 2025 09:07:44 -0700
From: Kees Cook <kees@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: RFC: Selecting an NVMEM cell for Power State Change Reason
 (PSCR) recording
Message-ID: <202510020904.1E48B7EB@keescook>
References: <20250618120255.3141862-1-o.rempel@pengutronix.de>
 <aN5pSWBFRZlNRv3U@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN5pSWBFRZlNRv3U@pengutronix.de>

On Thu, Oct 02, 2025 at 02:00:09PM +0200, Oleksij Rempel wrote:
> I'm seeking consensus on a minimal, upstream-acceptable way to identify the
> single NVMEM cell used to persist a Power State Change Reason (PSCR). Typical
> targets are battery-backed RTC scratchpads or small EEPROM. The aim is to have
> a tiny breadcrumb available before userspace, across full power cuts, and
> shared by bootloader/kernel/userspace.
> [...]
> * pstore integration (not tried): a backend that uses a nominated NVMEM cell if
>   such a nomination is acceptable.

Several years ago I wanted to have tighter integration between pstore
and nvdimm code. The thread is here, for reference:
https://lore.kernel.org/lkml/CAGXu5jLtmb3qinZnX3rScUJLUFdf+pRDVPjy=CS4KUtW9tLHtw@mail.gmail.com/

I'm not sure it it'll be a useful as background, but I thought I'd
mention it. :)

-Kees

-- 
Kees Cook

