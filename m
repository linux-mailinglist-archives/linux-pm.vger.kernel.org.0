Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A534B287C11
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 21:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgJHTHE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 15:07:04 -0400
Received: from static-213-198-238-194.adsl.eunet.rs ([213.198.238.194]:53556
        "EHLO fx.arvanta.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJHTHE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 15:07:04 -0400
Received: from arya.arvanta.net (arya.arvanta.net [10.5.1.6])
        by fx.arvanta.net (Postfix) with ESMTP id 1D7C41C302;
        Thu,  8 Oct 2020 21:07:02 +0200 (CEST)
Date:   Thu, 8 Oct 2020 21:07:01 +0200
From:   Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel@collabora.com, Vicente Bergas <vicencb@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] power: supply: sbs-battery: chromebook workaround for PEC
Message-ID: <20201008190701.GA10495@arya.arvanta.net>
References: <20201004224601.420786-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201004224601.420786-1-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, 2020-10-05 at 00:46, Sebastian Reichel wrote:
> Looks like the I2C tunnel implementation from Chromebook's
> embedded controller does not handle PEC correctly. Fix this
> by disabling PEC for batteries behind those I2C tunnels as
> a workaround.
> 
> Reported-by: "Milan P. Stanić" <mps@arvanta.net>
> Reported-by: Vicente Bergas <vicencb@gmail.com>
> CC: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Fixes: 7222bd603dd2 ("power: supply: sbs-battery: add PEC support")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Hi,
> 
> This is compile-tested only, since I do not have a chromebook at
> hand. Please test if this fixes your issue.
> 
> -- Sebastian
> ---
>  drivers/power/supply/sbs-battery.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 13192cbcce71..b6a538ebb378 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -279,6 +279,12 @@ static int sbs_update_presence(struct sbs_info *chip, bool is_present)
>  	else
>  		client->flags &= ~I2C_CLIENT_PEC;
>  
> +	if (of_device_is_compatible(client->dev.parent->of_node, "google,cros-ec-i2c-tunnel")
> +	    && client->flags & I2C_CLIENT_PEC) {
> +		dev_info(&client->dev, "Disabling PEC because of broken Cros-EC implementation\n");
> +		client->flags &= ~I2C_CLIENT_PEC;
> +	}
> +
>  	dev_dbg(&client->dev, "PEC: %s\n", (client->flags & I2C_CLIENT_PEC) ?
>  		"enabled" : "disabled");
  
Just for info, yesterday I built kernel 5.9-rc8 from:
https://gitlab.collabora.com/eballetbo/linux/-/commits/topic/chromeos/somewhat-stable-next
for Acer R13 chromebook (Mediatek mt8173, Machine model: Google Elm)
without above patch, and on it sbs-battery works without any problem.

Maybe problem is only on rk3399 (just guessing)

-- 
regards

