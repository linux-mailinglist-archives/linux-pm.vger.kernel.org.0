Return-Path: <linux-pm+bounces-30905-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22920B075C8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCFC16B2FE
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 12:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C322F4A07;
	Wed, 16 Jul 2025 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q58Adt5E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26D22E3F0;
	Wed, 16 Jul 2025 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669284; cv=none; b=Akd7hU3E31JFoP70ta+o7mUr5RShh26HE2+m6t4mBfNfkVsmRH9zN1L75c1zCwDT7g143mNTl4auabmYjLI6Hi7ij867wmRfWEuANI+9yAKK5obtM37DHTS/fX3k79QcpgL0ZZBjkryjzcEN3zXEMYHSpDeXI4XuqNykcMoqrlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669284; c=relaxed/simple;
	bh=jHDYw4ESklm/VKhxFo+O0C+zXDN64hsLeUp3h3kaXxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8qafK+jVd3CYTxeWjg5AmZr6hJQ+P4SS+c3qSseR/Tr3lCsUQ2mH+6BEO76Xji406rtqm0I0ZkfbjiWdHXsQmhxvHlqiU6RJanbnk0dTAmwA1uuSEvXMSDR9EA3mCIJN6ZlJUFRnb4DyFEo9Y+GwvYW6Q8egVh6PX5qo2FUjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q58Adt5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA04C4CEF0;
	Wed, 16 Jul 2025 12:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752669284;
	bh=jHDYw4ESklm/VKhxFo+O0C+zXDN64hsLeUp3h3kaXxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q58Adt5EVwHoRG29a8V8TY3lAbjHTNaYAnDBWOh/Vc+eW/Xwhx/sYyYDWWdnHT54N
	 VGBkRrJxGlWlOhWZ04Q4GiiEWZHDN4yQqRRwg4wcozrthMjps1PpIIzvszPG0/3NI9
	 8LdqHa6tpsNBoxBLW85vkNyL5x1PGBRt9yu62Up4=
Date: Wed, 16 Jul 2025 14:34:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v11 0/7] Introduction of PSCR Framework and Related
 Components
Message-ID: <2025071619-dyslexic-slam-546e@gregkh>
References: <20250618120255.3141862-1-o.rempel@pengutronix.de>
 <aHTZTFxfS6Bn4yhz@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHTZTFxfS6Bn4yhz@pengutronix.de>

On Mon, Jul 14, 2025 at 12:17:48PM +0200, Oleksij Rempel wrote:
> Hi Greg,
> 
> this patch series doesn’t belong to any single existing subsystem. It
> spans drivers like power/reset/, touches nvmem, regulator, and adds new
> interfaces.
> 
> Since there's no clear maintainer fit and the code is self-contained,
> I’d like to ask you to pick it up.
> 
> The latest version is v11 and has addressed all review comments.

I have some comments as I haven't reviewed this yet :)

Let me go download the series and respond to what I found...

thanks,

greg k-h

