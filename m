Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E137408C1D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 15:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhIMNMx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 09:12:53 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:54483 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhIMNMx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Sep 2021 09:12:53 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 5EF17C7F22
        for <linux-pm@vger.kernel.org>; Mon, 13 Sep 2021 13:11:36 +0000 (UTC)
Received: (Authenticated sender: hadess@hadess.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 76F4EC0005;
        Mon, 13 Sep 2021 13:11:14 +0000 (UTC)
Message-ID: <ce83276a3d7b0f838c983c77a7e6313b1a97f8f7.camel@hadess.net>
Subject: Re: [PATCH] docs: ABI: sysfs-class-power: Documented cycle_coint
 property
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
Date:   Mon, 13 Sep 2021 15:11:13 +0200
In-Reply-To: <20210913120925.591608-1-hdegoede@redhat.com>
References: <20210913120925.591608-1-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-09-13 at 14:09 +0200, Hans de Goede wrote:
> Commit c955fe8e0bdd ("POWER: Add support for cycle_count") added a
> POWER_SUPPLY_PROP_CYCLE_COUNT "cycle_count" property to the set of
> standard power-supply properties, but this was never documented,
> document it now.

Thanks very much Hans.

There's a typo in the subject line, and I had a couple of comments.

> Link: https://gitlab.freedesktop.org/upower/upower/-/issues/152
> Reported-by: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power
> b/Documentation/ABI/testing/sysfs-class-power
> index ca830c6cd809..643637c6bb58 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -480,6 +480,17 @@ Description:
>  
>                 Valid values: Represented in microvolts
>  
> +What:          /sys/class/power_supply/<supply_name>/cycle_count
> +Date:          January 2010
> +Contact:       linux-pm@vger.kernel.org
> +Description:
> +               Reports the number of full charge + discharge cycles
> the
> +               battery has undergone.

What happens if a device doesn't report cycle_count, the property just
doesn't exist?

> +
> +               Access: Read
> +
> +               Valid values: Possitive integer representing full
> cycles

positive

> +
>  **USB Properties**
>  
>  What:          /sys/class/power_supply/<supply_name>/input_current_l
> imit


