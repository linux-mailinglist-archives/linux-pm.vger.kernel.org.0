Return-Path: <linux-pm+bounces-185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AF77F7865
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 16:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676E21C208D6
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A10631740;
	Fri, 24 Nov 2023 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ee0EI2/5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404222C840;
	Fri, 24 Nov 2023 15:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60918C433C8;
	Fri, 24 Nov 2023 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700841381;
	bh=ktg76xInNz3yDgDKOGDrZoRtJBgbawiwaapZiqgE40s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ee0EI2/5wbrPZb0t6H/nRBY5COnaGWkio79vCZ4JFyqmnZZyG6OWEVCUsop8dB6NX
	 yN/0ECO9mkIq8lSvTO1wsYwq/Y0bwmkf6g8p7hd20C4fwGKmoXW7YYBPsSepUjd9jt
	 1WweiLl581OiNu/jwpbQYnZApjHoPOFW0kA+wSYY=
Date: Fri, 24 Nov 2023 15:56:19 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <2023112435-dazzler-crisped-04a6@gregkh>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh>
 <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>

On Fri, Nov 24, 2023 at 03:49:46PM +0000, Mark Brown wrote:
> On Fri, Nov 24, 2023 at 03:27:48PM +0000, Greg Kroah-Hartman wrote:
> > On Fri, Nov 24, 2023 at 03:21:40PM +0000, Mark Brown wrote:
> 
> > > This came out of some discussions about trying to handle emergency power
> > > failure notifications.
> 
> > I'm sorry, but I don't know what that means.  Are you saying that the
> > kernel is now going to try to provide a hard guarantee that some devices
> > are going to be shut down in X number of seconds when asked?  If so, why
> > not do this in userspace?
> 
> No, it was initially (or when I initially saw it anyway) handling of
> notifications from regulators that they're in trouble and we have some
> small amount of time to do anything we might want to do about it before
> we expire.

So we are going to guarantee a "time" in which we are going to do
something?  Again, if that's required, why not do it in userspace using
a RT kernel?

thanks,

greg k-h

