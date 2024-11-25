Return-Path: <linux-pm+bounces-18041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15D09D7F70
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 09:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862832827DA
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E6818F2DB;
	Mon, 25 Nov 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WWOs0+lX"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F618E37D;
	Mon, 25 Nov 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525186; cv=none; b=Ku6zeJwNGKFD7Pyri5xo5d8TVOCTTnSOw5MvHEVAhRzYInO+BW8095LNAWysAtnfRRkqrpfKRQfSccwb5uVVDUAOwEZXPjeU/QOn4/aO7tCiHHg9mD4fD2h5F4wIuQNAgmEc2PFSgbXG0WF+OMYOKuYWBFD6e1O+To1n21DcPcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525186; c=relaxed/simple;
	bh=dCX+s1xdrNSmIMdb226tNvNsC2gvvLx53u4Aw5t8PoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkoTUmOBxW/X6bbwHUPf04sEnD8GwfVSEccf1VD4HbEtHrPU6MvTzH0NgHC6yRdMiGRCUyDQja64sYXqRTdQqmMJ05pgLVowfl1CqwVS7UXzKyRJVL4i2QVE3YB6wxXsysyHiIHzmoI9AYw/h30VtuyPyKMo2WSWWUe0xJ9aa1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WWOs0+lX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732525181;
	bh=dCX+s1xdrNSmIMdb226tNvNsC2gvvLx53u4Aw5t8PoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWOs0+lXM1KMF+nb+bBVDSJord1rmP4eMP1yNZRdZx21KGrVbmt7OJLCp5tE8X4Iz
	 Z6ibHRZ+PKV57cG6QNkyrzhNcu1396kwyUzJ1wtaE38RsrauNcAmq8U2oxR//LtOUe
	 W721Y/ZrZDRHSiQ3dLLro7lTGmA/7MCj70c1AlnM=
Date: Mon, 25 Nov 2024 09:59:39 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v4 5/9] power: supply: sysfs: prepare for power supply
 extensions
Message-ID: <58040aa9-e2d2-4eb4-8c4b-a80415640312@t-8ch.de>
References: <20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net>
 <20241111-power-supply-extensions-v4-5-7240144daa8e@weissschuh.net>
 <84a5b7f9-9d09-4672-9447-02de05e68f88@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84a5b7f9-9d09-4672-9447-02de05e68f88@gmx.de>

On 2024-11-24 18:57:23+0100, Armin Wolf wrote:
> Am 11.11.24 um 22:40 schrieb Thomas Weißschuh:
> 
> > The upcoming extension API will add properties which are not part of the
> > the power_supply_desc.
> > Use power_supply_has_property() so the properties from extensions are
> > also checked.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >   drivers/power/supply/power_supply_sysfs.c | 17 ++++-------------
> >   1 file changed, 4 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> > index a7351b9c8fe34a464a4e69b1a1a4a4179c1a4b4f..bfe48fe01a8d03828c2e539e1e6e5e9fc5c60167 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -378,7 +378,6 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
> >   	struct device *dev = kobj_to_dev(kobj);
> >   	struct power_supply *psy = dev_get_drvdata(dev);
> >   	umode_t mode = S_IRUSR | S_IRGRP | S_IROTH;
> > -	int i;
> > 
> >   	if (!power_supply_attrs[attrno].prop_name)
> >   		return 0;
> > @@ -386,19 +385,11 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
> >   	if (attrno == POWER_SUPPLY_PROP_TYPE)
> >   		return mode;
> > 
> > -	for (i = 0; i < psy->desc->num_properties; i++) {
> > -		int property = psy->desc->properties[i];
> > -
> > -		if (property == attrno) {
> > -			if (power_supply_property_is_writeable(psy, property) > 0)
> > -				mode |= S_IWUSR;
> > -
> > -			return mode;
> > -		}
> > -	}
> > -
> > -	if (power_supply_battery_info_has_prop(psy->battery_info, attrno))
> > +	if (power_supply_has_property(psy, attrno)) {
> > +		if (power_supply_property_is_writeable(psy, attrno) > 0)
> 
> What happens with properties supplied via battery_info? Are drivers expecting the power supply core
> to call property_is_writable() for those too?

I don't think this should be an issue.
But we could also modify power_supply_property_is_writeable() and handle
battery info properties there, they are never writable.

Maybe we could even replace the whole battery_info logic itself with a
powersupply extension.

> Thanks,
> Armin Wolf
> 
> > +			mode |= S_IWUSR;
> >   		return mode;
> > +	}
> > 
> >   	return 0;
> >   }
> > 

