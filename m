Return-Path: <linux-pm+bounces-19390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7D79F5681
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 19:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19971892DC1
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 18:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F387C1F8ADA;
	Tue, 17 Dec 2024 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pYIONDXe"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68713D891;
	Tue, 17 Dec 2024 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461410; cv=none; b=XBPu00eQxodx1So5Bh2449awXBM5X/W5LJ/0DUosWT748oO0LGueRD54cYy/zalcjSQLuIZcuRFoet0NhufBzL2xk2dXCiTuQqsgINIXHyrdhvco9RWlBK5GYwwLAFwAQ9DFl7kp9zUTafYigIol3nq9+P6SouVMBjgTEgv0vx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461410; c=relaxed/simple;
	bh=G40LjJrXzGvTeGa7ZXEnOFARV4ydsEIj57Okp9nY12Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFM/OFuF8j93O0GooTpiZlmrF0QfCyusA5G2CyZI0s2pzsXa1f6VPNMxZb5cJG+HhOQ239DSomG0SZz6e5AjiaDMCyEgR78BmQ/F1IeAthrTDINPbAlGxS/m3fNg3Q3319wZqGFXDl4428ANXRA3Lp5CyPczKcbvlkmMjOBFRsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pYIONDXe; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734461398;
	bh=G40LjJrXzGvTeGa7ZXEnOFARV4ydsEIj57Okp9nY12Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYIONDXeFCMQy1GxAr3Q8ayx5hBLarUNrSbajwdqe7FN7O4+cKaHVWql+7LV8VTcB
	 xT2ha8Bx68+kVOmIOVCjRvY/Mm/XDyRqfT24KxaekGXWWVB9QXFs9zRJ6Ax9/H7qOe
	 wit4Myy0J6GlAPpzPLkxkTTKN6Se2ha8N1sOzSbg=
Date: Tue, 17 Dec 2024 19:49:57 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Jelle van der Waa <jelle@vdwaa.nl>, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] platform/x86: dell-laptop: Use
 power_supply_charge_types_show/_parse() helpers
Message-ID: <c59ed113-6a43-4807-a006-ceb5a807fb90@t-8ch.de>
References: <20241211174451.355421-1-hdegoede@redhat.com>
 <20241211174451.355421-5-hdegoede@redhat.com>
 <0030c3dd-c70c-d21b-de2b-ace0aeb4030d@linux.intel.com>
 <6760c9d3-ccf4-47de-bfe5-b59b8b9fca07@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6760c9d3-ccf4-47de-bfe5-b59b8b9fca07@redhat.com>

Hi Hans,

On 2024-12-17 16:18:47+0100, Hans de Goede wrote:
> On 17-Dec-24 1:01 PM, Ilpo Järvinen wrote:
> > On Wed, 11 Dec 2024, Hans de Goede wrote:
> > 
> >> Make battery_modes a map between tokens and enum power_supply_charge_type
> >> values instead of between tokens and strings and use the new
> >> power_supply_charge_types_show/_parse() helpers for show()/store()
> >> to ensure that things are handled in the same way as in other drivers.
> >>
> >> This also changes battery_supported_modes to be a bitmap of charge-types
> >> (enum power_supply_charge_type values) rather then a bitmap of indices
> >> into battery_modes[].
> >>
> >> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

[..]

> Note that merging this requires the earlier patches from this
> series which have been merged into:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/log/?h=for-next
> 
> so this either requires an immutable tag from Sebastian for you to merge,
> or this should be merged through Sebastian's tree.

If this goes in via the psy tree, you could already make it a power
supply extension. The necessary code is in psy/for-next.

Not necessary obviously.


Thomas

