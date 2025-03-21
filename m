Return-Path: <linux-pm+bounces-24397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B3AA6C016
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 17:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F73F17D82F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280822CBC8;
	Fri, 21 Mar 2025 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bWeQBzj7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCA91EBA1E;
	Fri, 21 Mar 2025 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575015; cv=none; b=WEdhf0uF85sp9QoQlzlOjy/YFfV2t+GDVooN9xysJdtNmttvuiU0zLvnKc1AyELruGNMBJyuvxIlUqt8opwGuIqjcxPbIOqJ9TOxUKvdimbcV+y2mvppd2vOgPHBwPEiI8+m+UUuMduVERiZnrtK1XTMN9Xs0VkgbHnXgNPeqD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575015; c=relaxed/simple;
	bh=z2M1KgvZACzDXW3+9ZoAXZoPdOgW03NFuntv5MFO/ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnfzek5rd2g9XXVqyUqJwy8YB7jI946eMWkhb0QcyPDdRq2ho9Za3L2NjoS3m2RnXfAEmTE2stWfHGRj0zeXtsXhxorIqHfjB/OaMcS4wnG4r3Lfkvix4hDGUGZGtpxu4XcFeszMF+ToJ048YbHJPRMMyZrjR7rO5qym0KAB1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bWeQBzj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBD5C4CEE3;
	Fri, 21 Mar 2025 16:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742575014;
	bh=z2M1KgvZACzDXW3+9ZoAXZoPdOgW03NFuntv5MFO/ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWeQBzj7jOmHh2UpO1isuMraMqZTKJrnTjbc21oTqlbHDEQnlZ5KZmUmMp70nHZkJ
	 XsphGTfme6ZF9ThZowsOA7A01Aa6gzVNy407fPLu9tITMSaLeyFI95fcwzZqcsD5F1
	 q7Y2v1aCVE+SayNuxsw+GI9YrlUjldSK0vHK9ufc=
Date: Fri, 21 Mar 2025 12:36:53 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Samuel Holland <samuel@sholland.org>, 
	David Lechner <david@lechnology.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Konrad Dybcio <konradybcio@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/7] usb: common: usb-conn-gpio: switch psy_cfg from
 of_node to fwnode
Message-ID: <20250321-famous-acrid-monkey-ab9c07@lemur>
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-3-d5e4369936bb@collabora.com>
 <2025022542-recital-ebony-d9b5@gregkh>
 <lhtljyn52wkhotaf2cn6fcj2vqx3dzipv2663kzwtw2tjjlxye@5l3xytkyvocy>
 <2025030845-pectin-facility-a474@gregkh>
 <0401fdf9-7665-40d6-9ec7-7222b2eda866@oss.qualcomm.com>
 <eqfqv2tkfretqzvt74o5dvj5yixkfc3h3my4bhskvhtsrbmtwp@poryvs4oipnp>
 <2025030831-various-monthly-4ae0@gregkh>
 <5ef97125-2b27-4961-8755-09fcea062f78@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ef97125-2b27-4961-8755-09fcea062f78@oss.qualcomm.com>

On Sat, Mar 08, 2025 at 07:27:28PM +0100, Konrad Dybcio wrote:
> > I do use b4, but it wants to suck the whole series down.  If I want to
> > pick an individual one out, I have to manually cut the message-id out
> > of the email and type out the command and pick the individual commit
> > out (or use the -P 3 as was said).
> > 
> > But that's a world away from me just hitting a single key in my email
> > client to suck down the whole thread and apply it to my tree.

Would it help to have an "interactive cherry-pick mode" where it grabs the
whole thread but before it applies it to your tree, it lets you pick the
subset of the patches you want? So, instead of passing -P 3,4, you have a file
open in your $EDITOR where you can just delete the patches you don't want?

-K


