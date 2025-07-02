Return-Path: <linux-pm+bounces-29992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97832AF6297
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 21:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194863B9415
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 19:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B462BE652;
	Wed,  2 Jul 2025 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9VqZc2u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9D8270ECB;
	Wed,  2 Jul 2025 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751484385; cv=none; b=fypbWIbUpQ6T5jP1TxwUr8aZvwYyqJWhrvJwHs2elqNu2JZ55fgxtcTYibDlHhYWFD4Mej1mC32MYsBXZxdYyg/7YysOX4JUXpRn6/AGJZx7v3qzjcPAG/mtMz9QLCpFRa1xugLtgqq5Hq3QmWpTU1tRz9O3ncsAo3CT8CvTLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751484385; c=relaxed/simple;
	bh=GpPi9wOBi7C3jjvU4V8pYmSE5merOth92NItvmAnnJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlMdqOBJ4VNs0RT9pCn8ioLHY9AAE7gaDoADpStgdCJck/YXudJ7r9RvU2uZAn4Ocf2xU0dTUtX6e7+6gXX/3NUvaya03ZPrXma1vfZ50lh4wI5GB9i+Ot9sdEGNTyZSXEmRQwTmgGl5owk4gvRXtwtstluwkaJSF9oqC0L+7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9VqZc2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4298EC4CEE7;
	Wed,  2 Jul 2025 19:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751484385;
	bh=GpPi9wOBi7C3jjvU4V8pYmSE5merOth92NItvmAnnJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9VqZc2uScNupz5RiyJKrkeyc/RhXPj7B8PqYC0NSU7jgadvkuC5KRG9GQsExvrH4
	 1JD14vqYuic+VfdWdHa1DD2tg67s8eD7SKPRtnqCTuWBMsUtoaP9Z2pNnv+CZLvN6j
	 sL67Ka5P1gaP5I+LRFKE9U8YV6iLHlwYewPM27PN9oOJ2oLGb5i+PG+QeFGN4CaX6e
	 DnhW+tqAh3AkCeAaW3FOMLBUx31l4gRP7a0YOs7VmNnjxSmC8a7yshNwjk2P01wKfE
	 HTmCXGoTXHQrcb4KyBxQeJ47YX4CCRI3ExB+HY/F3z5I9B4ZtVF6rNLvfmfYRyBK/d
	 I5OUyVFXbobBQ==
Date: Wed, 2 Jul 2025 21:26:18 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/24] driver core: Export get_dev_from_fwnode()
Message-ID: <aGWH2mH6iZJ3s3lL@pollux>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <20250701114733.636510-18-ulf.hansson@linaro.org>
 <2025070205-ignore-passive-17b4@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025070205-ignore-passive-17b4@gregkh>

On Wed, Jul 02, 2025 at 09:34:12AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 01, 2025 at 01:47:19PM +0200, Ulf Hansson wrote:
> > It has turned out get_dev_from_fwnode() is useful at a few other places
> > outside of the driver core, as in gpiolib.c for example. Therefore let's
> > make it available as a common helper function.
> > 
> > Suggested-by: Saravana Kannan <saravanak@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
> > Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/core.c    | 8 ++++++--
> >  include/linux/device.h | 1 +
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I'm a bit concerned about exporting get_dev_from_fwnode() -- at least without a
clear note on that this helper should be used with caution.

AFAIK, a struct fwnode_handle instance does not have a reference count for its
struct device pointer.

Hence, calling get_dev_from_fwnode() with a valid fwnode handle is not enough.
The caller also needs to ensure that the device the fwnode has a pointer to has
not been released yet.

If this really needs to be exported, can we please add documentation covering
this properly?

- Danilo

