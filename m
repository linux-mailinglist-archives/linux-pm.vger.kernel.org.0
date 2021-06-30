Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2203B862C
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 17:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhF3PZM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 11:25:12 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:35010 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235417AbhF3PZL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Jun 2021 11:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=9R9P8AiD4eICRk/YycK6n/jr3g/PddKIech/QyoVcCo=; b=Hb
        VyiP2kUlh1k9jUNMTHQO5z/87+0mEoOY+NB8aJPdxq1YloHOWGQuzlCZy5IEBXcqLy/iOAWJeABEm
        sX5l1eLU8jCQC4ia5O/qGoq1i5cQOLi2FCGElfQdz7AGTunhtulJLGKKSKqB2mntCbFpfuCyjmHK9
        dEvz5qkKuUR3BtU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1lyc2l-00Bg9B-Od; Wed, 30 Jun 2021 17:22:27 +0200
Date:   Wed, 30 Jun 2021 17:22:27 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Anders Trier Olesen <anders.trier.olesen@gmail.com>,
        Philip Soares <philips@netisense.com>,
        linux-pm@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Konstantin Porotchkin <kostap@marvell.com>,
        nnet <nnet@fastmail.fm>, Nadav Haklai <nadavh@marvell.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.iorg>
Subject: Re: [PATCH] cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant
Message-ID: <YNyMM20/nO3kQDVY@lunn.ch>
References: <20210630135942.29730-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210630135942.29730-1-kabel@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 30, 2021 at 03:59:42PM +0200, Marek Behún wrote:
> The 1.2 GHz variant of the Armada 3720 SOC is unstable with DVFS: when
> the SOC boots, the WTMI firmware sets clocks and AVS values that work
> correctly with 1.2 GHz CPU frequency, but random crashes occur once
> cpufreq driver starts scaling.
> 
> We do not know currently what is the reason:
> - it may be that the voltage value for L0 for 1.2 GHz variant provided
>   by the vendor in the OTP is simply incorrect when scaling is used,
> - it may be that some delay is needed somewhere,
> - it may be something else.
> 
> The most sane solution now seems to be to simply forbid the cpufreq
> driver on 1.2 GHz variant.
> 
> Signed-off-by: Marek Behún <kabel@kernel.iorg>
> Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
> ---
> If someone from Marvell could look into this, it would be great since
> basically 1.2 GHz variant cannot scale, which is a feature that was
> claimed to be supported by the SOC.
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index 3fc98a3ffd91..1ef3dde9a40b 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -104,7 +104,13 @@ struct armada_37xx_dvfs {
>  };
>  
>  static struct armada_37xx_dvfs armada_37xx_dvfs[] = {
> +#if 0
> +	/*
> +	 * The cpufreq scaling for 1.2 GHz variant of the SOC is currently
> +	 * unstable because we do not know how to configure it properly.
> +	 */
>  	{.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} },
> +#endif

I suspect you will get some drive by patches from bot handlers
removing the #if 0, since such code is not liked within the kernel,
and bot handlers blindly do what the bot tells them.

So i would suggest you avoid #if 0, and move the .cpu_req_max entry
into the comment.

     Andrew
