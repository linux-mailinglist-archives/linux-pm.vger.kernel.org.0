Return-Path: <linux-pm+bounces-13381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827D0969493
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 09:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404D528347E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 07:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745A01D618D;
	Tue,  3 Sep 2024 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wjtvTAJc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AA31CFEDF;
	Tue,  3 Sep 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347096; cv=none; b=S012kAYHRrEu/NurFrVsc5ces7rCQ8SBa1ZI+O3A1MsI7dabU18n3FOe668dLedHG6ufcq7c1HRfsdN+NkXUOHnvAPFH89YGQcM3jRZZ8CIh7TGBuwzoJ3IhfBYtUbUCrCayDvbIvjelLLipa4sGNCuPInx9nJIW6qwNDWJhvoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347096; c=relaxed/simple;
	bh=KfpUJwPIkdByyK2eQ8JyzjZah5wqNhIliyGW7R4pti0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL1fxtRyzFAROfsnFxB8R9erL0snD0NE9RMCFSOGMK3sIQwHDKAXvZn3SY0DjnxgaXTQmzYgphSWfHUBAyRMmncF01ZfJLCVEOpC5hLYRFvZjal78CgxEvPXFJA/duyArt7F+8UEEQGMjpc2NwJntu/MtBMbYf2V+9Gva4wJHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wjtvTAJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3FFC4CEC5;
	Tue,  3 Sep 2024 07:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725347095;
	bh=KfpUJwPIkdByyK2eQ8JyzjZah5wqNhIliyGW7R4pti0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wjtvTAJc1Xo+M62VHxjD7poicRHGhMge/exUMWMO+hA/aFjeuvc6b94ebwwS9oFai
	 YLTyEqKqSHsEDs397XoDynvmjE6DBCd1tB+zkAc0JmqYSje8X98CjVOznC+0k4CdNL
	 jFREm1GEf476vvHy4CO9OrtTB/KAq+WXbpPTgVOg=
Date: Tue, 3 Sep 2024 09:04:52 +0200
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
Message-ID: <2024090340-mumbo-worsening-9a55@gregkh>
References: <20240831142039.28830-1-hdegoede@redhat.com>
 <20240831142039.28830-7-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831142039.28830-7-hdegoede@redhat.com>

On Sat, Aug 31, 2024 at 04:20:39PM +0200, Hans de Goede wrote:
> The bit_types array just hold a list of valid enum power_supply_usb_type
> values which map to 0 - 9. This can easily be represented as a bitmap.
> 
> This reduces the size of struct power_supply_desc and further reduces
> the data section size by drivers no longer needing to store the array.
> 
> This also unifies how usb_types are handled with charge_behaviours,
> which allows power_supply_show_usb_type() to be removed.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Nice!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

