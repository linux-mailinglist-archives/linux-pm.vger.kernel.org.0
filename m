Return-Path: <linux-pm+bounces-261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD727F9EB7
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 12:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6901C208E8
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9501A29B;
	Mon, 27 Nov 2023 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7921101
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 03:36:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1r7ZuO-0002fw-4d; Mon, 27 Nov 2023 12:36:12 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1r7ZuN-00BvkY-9x; Mon, 27 Nov 2023 12:36:11 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1r7ZuN-0045L0-72; Mon, 27 Nov 2023 12:36:11 +0100
Date: Mon, 27 Nov 2023 12:36:11 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Message-ID: <20231127113611.GD877872@pengutronix.de>
References: <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh>
 <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <20231124185725.GA872366@pengutronix.de>
 <2023112520-paper-image-ef5d@gregkh>
 <20231125085038.GA877872@pengutronix.de>
 <a85b2d7e-4036-4bab-addf-45e0c2f6c335@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a85b2d7e-4036-4bab-addf-45e0c2f6c335@arm.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On Mon, Nov 27, 2023 at 10:13:49AM +0000, Christian Loehle wrote:
> > Same problem was seen not only in automotive devices, but also in
> > industrial or agricultural. With other words, it is important enough to bring
> > some kind of solution mainline.
> > 
> 
> IMO that is a serious problem with the used storage / eMMC in that case and it
> is not suitable for industrial/automotive uses?
> Any industrial/automotive-suitable storage device should detect under-voltage and
> just treat it as a power-down/loss, and while that isn't nice for the storage device,
> it really shouldn't be able to brick a device (within <1M cycles anyway).
> What does the storage module vendor say about this?

Good question. I do not have insights ATM. I'll forward it.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

