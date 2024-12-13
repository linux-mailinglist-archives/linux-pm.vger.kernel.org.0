Return-Path: <linux-pm+bounces-19219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA8B9F17AE
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 22:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE5C188F6D8
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 21:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A21819146E;
	Fri, 13 Dec 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jR1BiDCj"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA38C18660F;
	Fri, 13 Dec 2024 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123656; cv=none; b=FYIOsksYyK5vYGBYQ54ZOe/wmSK+ZSGZkq5dhNeV9MnCKiB/a4AOyUba2JlCSgxqhOoJ0PKaBvZxB45upRCQRfQG8coDk52HE8YQay48vCePwKXLCKM21vcVUtZeA5bkTmBeDGNOzwGFlEi0FspNeVHAhXlbDviK0S6Um0/jguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123656; c=relaxed/simple;
	bh=In/CvyBOIy7P/fcaUpqhO1y9bSBdanIyX1QtjfBWla0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5Zo1CXhyuCCL9aJNgVx2I1kAlZKTpZCH43Hwh2aBXzh7r/Viya6k6WpDyt2FuCAgFJ6GE6gC/CANvcLSHeEZCQgSOVeik5KiSh46qCFimujW6lVGOys+eqkyRMMLMywH5e3UykcbSf5T/4IJ7nPPnvhFj7xSx7pqxWTd9NXFDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jR1BiDCj; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734123650;
	bh=In/CvyBOIy7P/fcaUpqhO1y9bSBdanIyX1QtjfBWla0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jR1BiDCj6/a1leQjIquNf4GB4P45ny1qx+0C72dsUyB9hfGG4oiyMY6VyRnmmrzBx
	 xW2YwSSAEeri6zldGU9SjsIfd/0CRpn/STIpik6oLcQYVDZNqfg3ybup7BMlJpKg+3
	 IE2Wag1KC/OggCdrGjTMk1ReZnGx8mWLUQFRGNhQ=
Date: Fri, 13 Dec 2024 22:00:50 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 0/4] power: supply: extension API
Message-ID: <0f6b04ea-c8e9-4fc5-b7c7-72080ed0c954@t-8ch.de>
References: <20241211-power-supply-extensions-v6-0-9d9dc3f3d387@weissschuh.net>
 <2e2f4845-7500-40ec-985d-3a495842e020@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e2f4845-7500-40ec-985d-3a495842e020@gmx.de>

On 2024-12-12 15:27:52+0100, Armin Wolf wrote:
> Am 11.12.24 um 20:57 schrieb Thomas Weißschuh:
> 
> > Introduce a mechanism for drivers to extend the properties implemented
> > by a power supply.

[..]

> > ---
> > Changes in v6:
> > - Drop alreay picked up ACPI battery hook rename patch
> > - Only return bool from power_supply_property_is_writeable()
> > - Improve naming for test_power symbols
> > - Integrate cros_charge-control fixes from the psy/fixes branch
> > - Add sysfs UAPI for extension discovery
> > - Use __must_check on API
> > - Make power_supply_for_each_extension() safer.
> >    (And uglier, ideas welcome)
> 
> Maybe we can use a do { ... } while (0) construct here.

I don't think so. The macro needs to expand to a dangling loop
condition. So whatever statement comes after gets executed in the loop.

[..]

