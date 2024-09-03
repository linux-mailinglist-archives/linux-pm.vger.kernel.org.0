Return-Path: <linux-pm+bounces-13380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AA596948E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 09:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512B3282EFB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 07:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC901CFEDF;
	Tue,  3 Sep 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CB6s09fH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838921CCEEC;
	Tue,  3 Sep 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347045; cv=none; b=JbCZ4oR1pJFnu2WHLDzWcaZaM6zY6CarLLsYy1dzGT6cn3BHPLxU/yin1ED8xEeM0NlFPmFoc8Af//fbcaUR/VH9XJibQBUJiTkqCCq4e1C7xy7/JHSFTAsgH0igNNJnKdkmH0QsD7OHfgacmJsJuXooMXva8mJ9XGVO3SrPFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347045; c=relaxed/simple;
	bh=Slca8lD1DlvSk2D0BUDJG9aG9GeCUTaKROfks2UHNiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5O2BxRWzonx+tkU3t6fFAi8RhXRew27Blbs1sXB4E+/4Hc1xW01AF3LiySCEaJRAIO02eBEu+67qeVCzBEF/Y8UJ63ydNhglbUaKtBeQCo78LuhBELg+/aJcDgC1wPJsDnUMh+ivX0YpXpo54qsCJadaq48UQ4XAjTsAPe4s14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CB6s09fH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AFBC4CEC6;
	Tue,  3 Sep 2024 07:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725347045;
	bh=Slca8lD1DlvSk2D0BUDJG9aG9GeCUTaKROfks2UHNiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CB6s09fHVKI8KSqLISVCSqr00f49L2O+jAJfDiv/EQPHQH5xaxdvEayXMJ0BtN0xY
	 ACdON3+y+2K70BLZR8oung6+fO1hdye1bUsulUTXLF7x4HtALOZlims/IfFC5kWv2h
	 37YdzRLufUNX7PLRJBJdjk3jwseKo8V8GLy0Ez3o=
Date: Tue, 3 Sep 2024 09:04:02 +0200
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
Subject: Re: [PATCH 1/6] power: supply: "usb_type" property may be written to
Message-ID: <2024090342-succulent-unkempt-666c@gregkh>
References: <20240831142039.28830-1-hdegoede@redhat.com>
 <20240831142039.28830-2-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831142039.28830-2-hdegoede@redhat.com>

On Sat, Aug 31, 2024 at 04:20:34PM +0200, Hans de Goede wrote:
> According to Documentation/ABI/testing/sysfs-class-power the "usb_type"
> property is Read-Only.
> 
> For power-supplies which consume USB power such as battery charger chips,
> this is correct.
> 
> But the UCS1002 USB Port Power Controller driver which is a driver
> for a chip which is a power-source for USB-A charging ports "usb_type"
> is actually writable to configure the type of USB charger emulated
> by the USB-A port.

Ick, crazy hardware :(

> 
> Adjust the docs and the power_supply_sysfs.c code to adjust for this
> new writeable use of "usb_type":
> 
> 1. Update Documentation/ABI/testing/sysfs-class-power to document that
> "usb_type" may be writable
> 
> 2. Change the power_supply_attr type in power_supply_sysfs.c from
> POWER_SUPPLY_ATTR() into POWER_SUPPLY_ENUM_ATTR() so that the various
> usb_type string values from POWER_SUPPLY_TYPE_TEXT[] such as e.g.
> "SDP" and "USB_PD" can be written to the "usb_type" attribute instead
> of only accepting integer values.
> 
> Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

