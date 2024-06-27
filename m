Return-Path: <linux-pm+bounces-10121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E7191A918
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 16:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98BB7B2751A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3DA195F1A;
	Thu, 27 Jun 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WIGnU2zY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DCD1946BA;
	Thu, 27 Jun 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498156; cv=none; b=YIyXaqSpGoTpmz9WXbKpGgtZ6DUkR3x3eTuQfrLQe5E8GBQGiStCybWwVdfmILb+5VTnqV8lwSAQ8U/RIPTFxgYh1pWEoE3elygAJrCjIeWKZSeKhxwlYWAdlJpOQ7xvq22RPEa8O408aWdj+XPmNR9Yu5G9fuOZr1w9P/gA0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498156; c=relaxed/simple;
	bh=9xrRxnIRm7GTZ2539gbpxCSlGii5etL2gkmbrgIrNQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APfuDgZ6zDUHlgAUZzvfO/C/OTWeIAom0JIHQl7BQNF0lYlczTzYQwkqgKVFEIQvDP9Uw+NOBLHlmE6siK4OZEhXU9q7gsOgV1nuSUaPxHBt5hayZ3+x1gOtXkx+N/AZR9jdHhFfRRBAH1wi9vsygFcvNGVi4qEZRfyNfZ4WrFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WIGnU2zY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD43C2BBFC;
	Thu, 27 Jun 2024 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719498155;
	bh=9xrRxnIRm7GTZ2539gbpxCSlGii5etL2gkmbrgIrNQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIGnU2zYTIa2aISUmSCGZaR9Zy7OkpGWVYyZ/bghHv3cWF+ETvXpyTdohzSSZi56g
	 PiAiivQXV5n1iNgBw30v4N8R7R7TPHmLe39M8N7mVGbJY186QYRXeMGBCdIrAB0g4f
	 KdD/+Ad0wsi9CyfpVpAirlVrbJoeaa/cEV6IL6S0=
Date: Thu, 27 Jun 2024 16:22:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL RESEND] Immutable branch between pdx86 lenovo c630
 branch, power/supply and USB
Message-ID: <2024062722-sadness-tiger-a040@gregkh>
References: <e42fb2e9-81d4-4e40-ff3a-f9d6a46d03f9@linux.intel.com>
 <2024062440-guide-knoll-94d0@gregkh>
 <948b6f71-7a72-d03d-c36f-ff4f08987f0d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <948b6f71-7a72-d03d-c36f-ff4f08987f0d@linux.intel.com>

On Mon, Jun 24, 2024 at 07:44:26PM +0300, Ilpo Järvinen wrote:
> On Mon, 24 Jun 2024, Greg Kroah-Hartman wrote:
> 
> > On Mon, Jun 24, 2024 at 07:24:55PM +0300, Ilpo Järvinen wrote:
> > > Hi,
> > > 
> > > This is v2 of the lenovo c630 IB branch with the build fix for non-ARM64 
> > > platforms (built on top of the commits in the previous IB PR). Resent with 
> > > full Subject line.
> > > 
> > > The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:
> > > 
> > >   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-ib-lenovo-c630-v6.11-2
> > > 
> > > for you to fetch changes up to 13bbe1c83bc401c2538c758228d27b4042b08341:
> > > 
> > >   platform/arm64: build drivers even on non-ARM64 platforms (2024-06-24 18:22:15 +0300)
> >
> > So was the first one rewritten?  Or is this just the second patch on
> > top of the previous one?
> 
> Nothing was rewritten, just one patch added on top of the previous PR. The 
> previous PR had only 2 of these 3 commits:

Now pulled into my tree too, thanks.

greg k-h

