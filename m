Return-Path: <linux-pm+bounces-9520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A54890E054
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 02:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE991C21251
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 00:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C94191;
	Wed, 19 Jun 2024 00:01:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160F8A38
	for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2024 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755319; cv=none; b=qvvhoYE1NpF+fGoii8LrgLk4pV2aPb0CN8gc55131J5DAOjTm309rjAsMkDQ4dxKQKsx4hAoJpdm7uoLuluaVY2XO+Rxts1zP5XjDHsRh84zhqV4fhomEj+5R20KUw770HqPFWagksxUUG3Y4pMEvi4MAJ45iBnb/CLNgWrszpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755319; c=relaxed/simple;
	bh=jMeof6mQ4m9OsdFZSVhbZbBYZBSBZlEpy+R0gWz7uwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSeW9oh+WLbuDCIhVE4ESemMP/ZD6GhlNJeRXb1XWFlv2H9ktTTbNe+Fn7/wQZChZKP4RJG1IU98zljDbw7l2GuIaLIDwz6DDQnCELQEGYS096iwcJv5YlUiiY2D+feD7Z3hknstvtiuCnteOTknCqEMolnHVvsPylv5jQNv1tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 099A9DA7;
	Tue, 18 Jun 2024 17:02:20 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28F753F64C;
	Tue, 18 Jun 2024 17:01:53 -0700 (PDT)
Date: Wed, 19 Jun 2024 01:00:21 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Ryan Walklin <ryan@testtoast.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, Chris
 Morgan <macroalpha82@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] cpufreq: sun50i: add Allwinner H700 speed bin
Message-ID: <20240619010021.5962e459@minigeek.lan>
In-Reply-To: <20240607092140.33112-2-ryan@testtoast.com>
References: <20240607092140.33112-1-ryan@testtoast.com>
	<20240607092140.33112-2-ryan@testtoast.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 21:20:33 +1200
Ryan Walklin <ryan@testtoast.com> wrote:

> Support for the Allwinner H618, H618 and H700 was added to the sun50i
> cpufreq-nvmem driver recently [1] however at the time some operating
> points supported by the H700 (1.008, 1.032 and 1.512 GHz) and in use by
> vendor BSPs were found to be unstable during testing, so the H700 speed
> bin and  the 1.032 GHz OPP were not included in the mainline driver.
> 
> Retesting with kernel 6.10rc2 (which carries additional fixes for the
> driver) now shows stable operation with these points.
> 
> Add the H700 speed bin to the driver.
> 
> Signed-off-by: Ryan Walklin <ryan@testtoast.com>

Yes, 0x6c00 is the value for the H700 SoCs in the devices we have seen:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> --
> [1] https://lore.kernel.org/linux-sunxi/20240418154408.1740047-1-andre.przywara@arm.com
> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 0b882765cd66f..969f22aadd950 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -91,6 +91,9 @@ static u32 sun50i_h616_efuse_xlate(u32 speedbin)
>  	case 0x5d00:
>  		value = 0;
>  		break;
> +	case 0x6c00:
> +		value = 5;
> +		break;
>  	default:
>  		pr_warn("sun50i-cpufreq-nvmem: unknown speed bin 0x%x, using default bin 0\n",
>  			speedbin & 0xffff);


