Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831ED1D52C0
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 17:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgEOPAf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 11:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726174AbgEOPAf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 11:00:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472FFC061A0C;
        Fri, 15 May 2020 08:00:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: evelikov)
        with ESMTPSA id A7C892A2DB7
Date:   Fri, 15 May 2020 15:57:55 +0100
From:   Emil Velikov <emil.velikov@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: Re: [PATCHv1 15/19] power: supply: sbs-battery: add ability to
 disable charger broadcasts
Message-ID: <20200515145755.GD2836808@arch-x1c3>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
 <20200513185615.508236-16-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513185615.508236-16-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020/05/13, Sebastian Reichel wrote:
> From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> 
> In certain designs, it is possible to add a battery on a populated i2c
> bus without an sbs compliant charger. In that case, the battery will
> un-necessarily and sometimes un-desirably master the bus trying to write
> info in the charger.

Nit: s/un-/un/

> 
> It is observed in many occasion that these battery "broadcasts" are even
> corrupting other ongoing master to slave communication. I.e. the
> multi-master support in the battery is inadequate.
> 
> Thankfully, the CHARGER_MODE bit allows designers to disable that SBS
> battery behaviour.
> 
> This needs to be done once when the battery is first seen on the bus.
> 
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> [rebased code]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

> @@ -1017,6 +1043,9 @@ static int sbs_probe(struct i2c_client *client,
>  	}
>  	chip->i2c_retry_count = chip->i2c_retry_count + 1;
>  
> +	chip->charger_broadcasts = !of_property_read_bool(client->dev.of_node,
> +					"sbs,disable-charger-broadcasts");
> +
This patch adds the of_property_read, only for it to be replaced in the next
patch. Consider flipping the patch order?

-Emil
