Return-Path: <linux-pm+bounces-6306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B858A289C
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 09:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075981F214D8
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202B64CDF9;
	Fri, 12 Apr 2024 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iMUzF3ED"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06893218B
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908668; cv=none; b=d+EzbpiwMdva06JSOQa233El3Js5tX8o21kQo+OHkmHzDGBW1rh/aonPtlgE4+IFshlWH6YSTBbFHHPiF8Bq7mXqg3SJQt5GhqzcJN1o0++ylUTdx0iUDHA6+5zUUZ+t91gcQOuxjHzaL7J2wFyVvrll3J2GeDEZYuaB+4ILqF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908668; c=relaxed/simple;
	bh=aOxbYAu2JrwN7sxXoZ9Cv2/lHZwASgPf4CIIA0j5XhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ub99q+r9EK1pFefiV620VGEO/JXwQER0VxREsqK/E4y2J5nbzr7r7zPWlZhLy9x/IW+Iuvf8SCQVdi0xM226zLIT+mIgvN8s11uAnPROycdTdyw3Bm7kXRes1RLakPSSOsC6stCYuvDktww/LKLPY45xh0V7awGdUfuGDKTRa3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iMUzF3ED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B88C113CC;
	Fri, 12 Apr 2024 07:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712908667;
	bh=aOxbYAu2JrwN7sxXoZ9Cv2/lHZwASgPf4CIIA0j5XhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iMUzF3EDKOXbuFp7fEdm4tWAjNtYOUhJETQqpahiNhlHuOgEe+0A6Cz8h7wFxq9ax
	 eBOwLkU4ZCrmTaMhCcuCS2hPV7x3cV9VZtv0iPbCUYVdxNkhwXG9EXKXJZhIyTOiQ5
	 N6o0myDbNihfG/6QLrxvJ0wxWxmLnqLpx3/INcO4=
Date: Fri, 12 Apr 2024 09:57:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: lizhe <sensor1010@163.com>
Cc: "viresh.kumar" <viresh.kumar@linaro.org>,
	"grygorii.strashko" <grygorii.strashko@ti.com>,
	"gregory.clement" <gregory.clement@bootlin.com>,
	"grant.likely" <grant.likely@secretlab.ca>,
	bsegall <bsegall@google.com>, broonie <broonie@kernel.org>,
	bristot <bristot@redhat.com>, brgl <brgl@bgdev.pl>,
	"f.fainelli" <f.fainelli@gmail.com>,
	"fancer.lancer" <fancer.lancer@gmail.com>,
	festevam <festevam@gmail.com>, Finn Thain <fthain@linux-m68k.org>,
	rafael <rafael@kernel.org>, linux-pm <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: exit() callback is optional
Message-ID: <2024041212-bony-emphasize-75dd@gregkh>
References: <b97964653d02225f061e0c2a650b365c354b98c8.1712900945.git.viresh.kumar@linaro.org>
 <5759bc29.32d04.18ed0ef5037.Coremail.sensor1010@163.com>
 <20240412062407.ntahibzv6xsbrnxs@vireshk-i7>
 <1b53a162.32e95.18ed0fdb13e.Coremail.sensor1010@163.com>
 <20240412063246.tk5z245miakbxws4@vireshk-i7>
 <2117690204.533771.1712904398042.JavaMail.root@mail-tracker-145-3ep34-c9h23-5f64cf7787-82gdh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2117690204.533771.1712904398042.JavaMail.root@mail-tracker-145-3ep34-c9h23-5f64cf7787-82gdh>

On Fri, Apr 12, 2024 at 02:46:25PM +0800, lizhe wrote:
> Look at what you've done, it really makes people feel extremely disgusted with your company. Your company will receive a very bad reputation.

I think you need to stop now, this is not doing anything productive at
all and is not acceptable.

greg k-h

