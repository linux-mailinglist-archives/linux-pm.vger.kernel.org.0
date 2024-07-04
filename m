Return-Path: <linux-pm+bounces-10591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8EF9272EE
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 11:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEE2288715
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C186D1AAE32;
	Thu,  4 Jul 2024 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XdQl5w4h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDA01AAE2A;
	Thu,  4 Jul 2024 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084983; cv=none; b=Y8L+J3V7xL9bdov4OoBLjKhjdvGCrH40AVbCWOZr/7MG6C1V36Nc1y9fuK/55fXXq5EecNF8baRMBz9oA/4EbtwS4SuwBvxcaTRTF/d5K6JzndPPE+21oGB27l6qW3+vIDcnD+Q4bDS8lFYzpAGSCsgIPCg5IqRilS40QS8PV9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084983; c=relaxed/simple;
	bh=06as5BSvzilWjvhyp+ERYWakzCKolExpyqn7MKb+tp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6hmCHI9Kgm5eSmRaU2HJcuq+rIOxQurR+Q9Sdy2lkvk6h/SBtaWPyTgxjcRroPAS/KkTzfhvL76OFHOnpnWpe9oSQODK6RSWIS+kV7o17XT3PUm2qCgRoW2TiJs4gatMgiELx9qORcP2HAS+yFr6MQfbsH1+qAKI9YRcBBLd9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XdQl5w4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05D9C3277B;
	Thu,  4 Jul 2024 09:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720084983;
	bh=06as5BSvzilWjvhyp+ERYWakzCKolExpyqn7MKb+tp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdQl5w4hibwsvoFcvyqbIF6922YZwN8ioFVVi1XjsiUP57Cc/N6U5OmyiCfiDLjw4
	 SLMIgxen0L/I+Qyf5u0rKUTHPAlMHeJT/f9T+GtrONuSjpbLBh5lyf3wxPM2WTIVI9
	 CzPt34rPX6MvAimaC+M5eN1Dg9DEKaHFbpCppPqs=
Date: Thu, 4 Jul 2024 11:12:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rhyland Klein <rklein@nvidia.com>,
	Anton Vorontsov <cbouatmailru@gmail.com>,
	Jenny TC <jenny.tc@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH] power: supply: core: return -EAGAIN on uninitialized
 read temp
Message-ID: <2024070430-backer-cedar-f1ea@gregkh>
References: <20240704-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-9d66d6f6efde@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-9d66d6f6efde@linaro.org>

On Thu, Jul 04, 2024 at 10:52:08AM +0200, Neil Armstrong wrote:
> If the thermal core tries to update the temperature from an
> uninitialized power supply, it will swawn the following warning:
> thermal thermal_zoneXX: failed to read out thermal zone (-19)
> 
> But reading from an uninitialized power supply should not be
> considered as a fatal error, but the thermal core expects
> the -EAGAIN error to be returned in this particular case.
> 
> So convert -ENODEV as -EAGAIN to express the fact that reading
> temperature from an uninitialized power supply shouldn't be
> a fatal error, but should indicate to the thermal zone it should
> retry later.
> 
> It notably removes such messages on Qualcomm platforms using the
> qcom_battmgr driver spawning warnings until the aDSP firmware
> gets up and the battery manager reports valid data.
> 
> Link: https://lore.kernel.org/all/2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org/
> Fixes: 5bc28b93a36e ("power_supply: power_supply_read_temp only if use_cnt > 0")
> Fixes: 3be330bf8860 ("power_supply: Register battery as a thermal zone")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/power/supply/power_supply_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

