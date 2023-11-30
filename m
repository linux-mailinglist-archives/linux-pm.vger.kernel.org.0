Return-Path: <linux-pm+bounces-582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7AC7FFE23
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 22:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D972819E0
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9151E5EE7F;
	Thu, 30 Nov 2023 21:59:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64331D48;
	Thu, 30 Nov 2023 13:59:31 -0800 (PST)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C664E1F8C9;
	Thu, 30 Nov 2023 22:59:27 +0100 (CET)
Received: from livingston (unknown [192.168.42.11])
	by gaggiata.pivistrello.it (Postfix) with ESMTP id 15BA07F848;
	Thu, 30 Nov 2023 22:59:10 +0100 (CET)
Received: from pivi by livingston with local (Exim 4.96)
	(envelope-from <francesco@dolcini.it>)
	id 1r8p3t-000149-2p;
	Thu, 30 Nov 2023 22:59:09 +0100
Date: Thu, 30 Nov 2023 22:59:09 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Christian Loehle <christian.loehle@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <ZWkFrY1k2C_7LovQ@livingston.pivistrello.it>
References: <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh>
 <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <20231124185725.GA872366@pengutronix.de>
 <2023112520-paper-image-ef5d@gregkh>
 <20231125085038.GA877872@pengutronix.de>
 <a85b2d7e-4036-4bab-addf-45e0c2f6c335@arm.com>
 <20231127113611.GD877872@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127113611.GD877872@pengutronix.de>

Hello all,

On Mon, Nov 27, 2023 at 12:36:11PM +0100, Oleksij Rempel wrote:
> On Mon, Nov 27, 2023 at 10:13:49AM +0000, Christian Loehle wrote:
> > > Same problem was seen not only in automotive devices, but also in
> > > industrial or agricultural. With other words, it is important enough to bring
> > > some kind of solution mainline.
> > > 
> > 
> > IMO that is a serious problem with the used storage / eMMC in that case and it
> > is not suitable for industrial/automotive uses?
> > Any industrial/automotive-suitable storage device should detect under-voltage and
> > just treat it as a power-down/loss, and while that isn't nice for the storage device,
> > it really shouldn't be able to brick a device (within <1M cycles anyway).
> > What does the storage module vendor say about this?
> 
> Good question. I do not have insights ATM. I'll forward it.

From personal experience I can tell that bricked eMMC devices happen because of
eMMC controller firmware bugs. You might find some recently committed quirk
on this regard.

Waiting for any additional details you might be able to find, given my past
experience I would agree with what Christian wrote.

Francesco


