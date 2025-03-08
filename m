Return-Path: <linux-pm+bounces-23678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A89A57C56
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 18:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59123B193C
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 17:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D708A1E832F;
	Sat,  8 Mar 2025 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ASAHlAGm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFD52BB15;
	Sat,  8 Mar 2025 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741454928; cv=none; b=tDLc1F4gR2V9NsDBPlj0kpTx5LhPPWVxy96aHd8yDanYpUR9K7J7wPAn6lWq9xTSEOZ00wMnGPZocJ4+qD0xJs9Rvv6eh3FOoKtcX487CtZs4GsO50x6+k1A0xlN6hWXGc98gunJYwfCZuCXOhhKtbnwu3Bkqr8LDoq78M0NvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741454928; c=relaxed/simple;
	bh=HAM14ok/bHmZ/6xW9eRRuNNPVwBwIJ9kIigWkoTG+d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVpTrNDZrn6L8wd/WpO126kBJRI9LyorLhrbljFq2rcgojKYSm/y+d0+xVBilE9jyeFuau7yESIorIerWux1QxldS3QNedZnkHFjIjq9R/SiFnMgYiAfm3GM9TulvtUOWfSjx9/EsrYNac1mTf2Sx/qZ0I0ymsIfRm8Z/rPgLFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ASAHlAGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D5DC4CEE0;
	Sat,  8 Mar 2025 17:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741454927;
	bh=HAM14ok/bHmZ/6xW9eRRuNNPVwBwIJ9kIigWkoTG+d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ASAHlAGmRGCXlh5rw0SkoSgfLyLtB9qGKVWgSVw038D9p4l8Rk/26/dZ+caNrTcPS
	 WH6Wjm38cga551s4Rb5RLDMM69Vnmpg9X7EbuNRN/3kNjK2x3g1Xs3aab1v9yhhjzO
	 L1TD8+P/Jvd5GvCvf9rDxEjz5FcCkQq/iwm84ZCQ=
Date: Sat, 8 Mar 2025 18:27:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Samuel Holland <samuel@sholland.org>,
	David Lechner <david@lechnology.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/7] usb: common: usb-conn-gpio: switch psy_cfg from
 of_node to fwnode
Message-ID: <2025030831-various-monthly-4ae0@gregkh>
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-3-d5e4369936bb@collabora.com>
 <2025022542-recital-ebony-d9b5@gregkh>
 <lhtljyn52wkhotaf2cn6fcj2vqx3dzipv2663kzwtw2tjjlxye@5l3xytkyvocy>
 <2025030845-pectin-facility-a474@gregkh>
 <0401fdf9-7665-40d6-9ec7-7222b2eda866@oss.qualcomm.com>
 <eqfqv2tkfretqzvt74o5dvj5yixkfc3h3my4bhskvhtsrbmtwp@poryvs4oipnp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eqfqv2tkfretqzvt74o5dvj5yixkfc3h3my4bhskvhtsrbmtwp@poryvs4oipnp>

On Sat, Mar 08, 2025 at 05:33:05PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Mar 08, 2025 at 10:34:45AM +0100, Konrad Dybcio wrote:
> > On 8.03.2025 6:57 AM, Greg Kroah-Hartman wrote:
> > > On Sat, Mar 08, 2025 at 02:10:29AM +0100, Sebastian Reichel wrote:
> > >> On Tue, Feb 25, 2025 at 04:32:50AM +0100, Greg Kroah-Hartman wrote:
> > >>> On Tue, Feb 25, 2025 at 12:21:36AM +0100, Sebastian Reichel wrote:
> > >>>> In order to remove .of_node from the power_supply_config struct,
> > >>>> use .fwnode instead.
> > >>>>
> > >>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > >>>> ---
> > >>>>  drivers/usb/common/usb-conn-gpio.c | 2 +-
> > >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
> > >>>> index aa710b50791b0282be0a6a26cffdd981b794acaa..1e36be2a28fd5ca5e1495b7923e4d3e25d7cedef 100644
> > >>>> --- a/drivers/usb/common/usb-conn-gpio.c
> > >>>> +++ b/drivers/usb/common/usb-conn-gpio.c
> > >>>> @@ -158,7 +158,7 @@ static int usb_conn_psy_register(struct usb_conn_info *info)
> > >>>>  	struct device *dev = info->dev;
> > >>>>  	struct power_supply_desc *desc = &info->desc;
> > >>>>  	struct power_supply_config cfg = {
> > >>>> -		.of_node = dev->of_node,
> > >>>> +		.fwnode = dev_fwnode(dev),
> > >>>>  	};
> > >>>>  
> > >>>>  	desc->name = "usb-charger";
> > >>>>
> > >>>> -- 
> > >>>> 2.47.2
> > >>>
> > >>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >>
> > >> Please just merge this patch through the USB tree.
> > >>
> > >> There are no dependencies and I will send a new version for the
> > >> later patches, but they won't make it to 6.15 as I want enough
> > >> time in linux-next for them. This patch is rather simple and
> > >> getting it merged now means we avoid immutable branches or
> > >> merging through the wrong tree in the 6.16 cycle.
> > > 
> > > Attempting to merge a single patch out of a series is hard with our
> > > current tools, you know that.
> 
> Sorry, I did not know your tooling has issues with that. AFAIK most
> maintainers are using b4 nowadays, which makes it really easy. Might
> be I am biased because I mostly work on ARM stuff where series often
> have patches for the driver and the device tree and thus merging
> partial patch series is basically the norm.

I do use b4, but it wants to suck the whole series down.  If I want to
pick an individual one out, I have to manually cut the message-id out
of the email and type out the command and pick the individual commit
out (or use the -P 3 as was said).

But that's a world away from me just hitting a single key in my email
client to suck down the whole thread and apply it to my tree.

For those of us who have to apply a lot of patches, automation is key.
When sending a patch series that wants to be split across multiple
trees, that makes it harder for everyone.

Anyway, I can take this as is, I've spent more time typing this than it
would have taken me to dig out just the single email.  Give me a few
days to catch up with it...

thanks,

greg k-h

