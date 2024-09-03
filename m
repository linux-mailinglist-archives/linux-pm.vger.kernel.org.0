Return-Path: <linux-pm+bounces-13390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E7596971F
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 10:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C0A1C21188
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 08:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC421C179;
	Tue,  3 Sep 2024 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cc+KDwbW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4DB21C16B;
	Tue,  3 Sep 2024 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352336; cv=none; b=gzV4QH4eAk+4TwDrP10ezPefexeELcEQMZ9mSCunhtDuBrPzb9CA+DtDZ70Zb0YHeCu5mFxamsxRGJUzhFtfMRKcne+h1sK3nC/Y6sEuHsfqOAGQaiP7t/U15JQ4jyaM2k9s2l/6u1k/Jr1tGGYPVCj8XqGk+78zLPxEd9wG/ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352336; c=relaxed/simple;
	bh=RIuf/aEL89DX2+EKoF8e7PpiBo6v3Bm+nSSkkwxOHdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmuNa5TS2Mq5xAgUV4JfifEfMAgHlSfhuZthS51NdI2PP9JwbpwV+JogkMqxC0G1pohEuvc42bDjXZDCNvxVYIVJ1k2x+UzFAi/not7JC/evdOKrO5oASI1KIczCPEbmJre6+tUA/4i3uDo4VvHDg+N87d/oEq6O8rfN9jmK+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cc+KDwbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751AFC4AF09;
	Tue,  3 Sep 2024 08:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725352336;
	bh=RIuf/aEL89DX2+EKoF8e7PpiBo6v3Bm+nSSkkwxOHdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cc+KDwbWX9G8khKq4ZglLTf6b8GWR8okboip7/LWlJvrOdLAcpgKUczNx4Uab+GKw
	 dJilAflccnRZS8rghorICxdB1+IBO/oRkgvXYW5Xz4pQTYVp+5sXrWeJ7oPEKJnnS1
	 Zkop6D7NQ1rZ0xb0xxc7IyrTpOqlUxImjmOkRv54=
Date: Tue, 3 Sep 2024 10:32:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Enric Balletbo Serra <enric.balletbo@collabora.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH 6/6] power: supply: Change usb_types from an array into a
 bitmask
Message-ID: <2024090308-retying-playpen-cc51@gregkh>
References: <20240831142039.28830-1-hdegoede@redhat.com>
 <20240831142039.28830-7-hdegoede@redhat.com>
 <2024090340-mumbo-worsening-9a55@gregkh>
 <6f4e23ce-2f32-44fc-93d9-ab7d0867b0ee@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4e23ce-2f32-44fc-93d9-ab7d0867b0ee@redhat.com>

On Tue, Sep 03, 2024 at 10:27:08AM +0200, Hans de Goede wrote:
> Hi Greg,
> 
> Thank you for the reviews.
> 
> On 9/3/24 9:04 AM, Greg Kroah-Hartman wrote:
> > On Sat, Aug 31, 2024 at 04:20:39PM +0200, Hans de Goede wrote:
> >> The bit_types array just hold a list of valid enum power_supply_usb_type
> >> values which map to 0 - 9. This can easily be represented as a bitmap.
> >>
> >> This reduces the size of struct power_supply_desc and further reduces
> >> the data section size by drivers no longer needing to store the array.
> >>
> >> This also unifies how usb_types are handled with charge_behaviours,
> >> which allows power_supply_show_usb_type() to be removed.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Nice!
> > 
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I assume this also counts as an ack for merging this through
> the linux-power-supply tree ?

Yes please.

