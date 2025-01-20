Return-Path: <linux-pm+bounces-20667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C18AA16704
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 08:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F3DE7A42AF
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 07:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7622118C92F;
	Mon, 20 Jan 2025 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcHCvlJn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB32145A18;
	Mon, 20 Jan 2025 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737357102; cv=none; b=gFuuBkg/RHoZ/YAn5wcXgBqASlnrpep0sUNpXj2K5edT7wtI1eHu28XELzXg1r/1caDEN7YlMRQFfTLhib5wWUKE5trsszteE0niYn8IS7gjuu8xH0sc6LayFX8dQXQ5diamNTOFmEGMyMUySXhIkT2DzUkD7b5TFBL/szc8K4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737357102; c=relaxed/simple;
	bh=UsYUJ1dfu3HtvbDCIPPjsGBIQ9q1bsv5BjYbYRwgLhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITxJ/73O1n5sPuPMlyKUxDyh3ImRB+G0mF7s3kxlW7QPv+ac8pE6Z5i1M27tTG/0dtiOyAwq42v1kQDBrul1psensETsKmP1bLyU/x+UDsRqxCdGxqvCLuRkL1B9s1eRTiSQMEl3JRcMM6aBJ9nwdXqbq0IxRxoXoPmeWUJinuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcHCvlJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCBDC4CEDD;
	Mon, 20 Jan 2025 07:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737357101;
	bh=UsYUJ1dfu3HtvbDCIPPjsGBIQ9q1bsv5BjYbYRwgLhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcHCvlJnmp98NjrBfT917l6/uHCgT+k9MAAKjubdYZ0IvLCvez8gh5Aa/vAthn04s
	 rhnn/GN+1OZaDDeGcUQbQp5KPkZBEeURwciye3uHChkURT2Kk0wnRLzfhJ6xG5eBBk
	 Eq9/i1KimsJKvDJbVA8qb+533tJV716ZeTsNqua7k+Qy6WogVsInTcy18j/ufut4qO
	 jT3eOAJEnFcqCQt/Wn1LK0E+jn/BnJMPgee3YetSeaymOIlOiUTl9fNBF6Js2x68Fx
	 EJhDSTBUVYvZdapQBDjgeTXgy3+lvFpVzO0qpplWNfclEywuKmpGaqccHcF0yGoAxD
	 TmgkhhVhgE5lw==
Date: Mon, 20 Jan 2025 07:11:35 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@denx.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v2 05/12] reboot: rename now misleading
 __hw_protection_shutdown symbols
Message-ID: <Z433JzVyGWK2Lq2C@google.com>
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-5-161d3fc734f0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-hw_protection-reboot-v2-5-161d3fc734f0@pengutronix.de>

On Mon, Jan 13, 2025 at 05:25:30PM +0100, Ahmad Fatoum wrote:
> The __hw_protection_shutdown function name has become misleading
> since it can cause either a shutdown (poweroff) or a reboot
> depending on its argument.
> 
> To avoid further confusion, let's rename it, so it doesn't suggest
> that a poweroff is all it can do.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

