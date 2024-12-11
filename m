Return-Path: <linux-pm+bounces-19062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821E69ED67B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 20:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E938B28260D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 19:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD742594B0;
	Wed, 11 Dec 2024 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sF1sJ020"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33B2594AA;
	Wed, 11 Dec 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733945272; cv=none; b=rXqGuvZdyqUbpoQfeawLV48UzWrIv2v86po5ywrSp67xM2uhld7UGqgVvU9pvFdHwVCDArA7sbS6Wzdn1u6nu3oM0Bik4/FkttgqUKhehzxb/ap16ITtzcKNHDYljI/ndWLU18zy8KL/9gA1E3u0NEgH9HBq7/Kc1A2Uv2lE0CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733945272; c=relaxed/simple;
	bh=OjYic29IcKVmNevf2yaITYpjRTRcbO40aV8yLKuDN7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyhu90/f7u/SCDJlYxUEQJjAv5nRBUDMTfF/5GL0IezC0IZkExE1Ey8RPtrHiP/AXTH2Gu3sH7iQq+0bZo2/e4Ptv4f2feyTv9ZgDP6WgGS2xMhJsc8KsTZQok2UjXwymozcgWom3aBnh03/N2nRw7Xd+nqehq1xMwBhyKAQBfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sF1sJ020; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733945268;
	bh=OjYic29IcKVmNevf2yaITYpjRTRcbO40aV8yLKuDN7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sF1sJ020HX4k2/b0oC72MK64VxmJlfSfbjC0OTHsGnr31mROCA1WSJo9f5U1yRoZ2
	 dS64SmxTbq9/P2qjK0o7QWOcDS2tdoXKP1eRk9JGeA9pbKClVV3Ma6zN9swWEHafzd
	 GGNCQmYDx8QYIkaqcAEBbAT7iK+IkTbWEtduFob4=
Date: Wed, 11 Dec 2024 20:27:47 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Jelle van der Waa <jelle@vdwaa.nl>, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/4] power: supply: core: Add new "charge_types"
 property
Message-ID: <e4b8a90b-bae1-433a-90b0-3073144448ed@t-8ch.de>
References: <20241211174451.355421-1-hdegoede@redhat.com>
 <20241211174451.355421-3-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211174451.355421-3-hdegoede@redhat.com>

On 2024-12-11 18:44:49+0100, Hans de Goede wrote:
> Add a new "charge_types" property, this is identical to "charge_type" but
> reading returns a list of supported charge-types with the currently active
> type surrounded by square brackets, e.g.:
> 
> Fast [Standard] "Long_Life"
> 
> This has the advantage over the existing "charge_type" property that this
> allows userspace to find out which charge-types are supported for writable
> charge_type properties.
> 
> Drivers which already support "charge_type" can easily add support for
> this by setting power_supply_desc.charge_types to a bitmask representing
> valid charge_type values. The existing "charge_type" get_property() and
> set_property() code paths can be re-used for "charge_types".
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

[..]

