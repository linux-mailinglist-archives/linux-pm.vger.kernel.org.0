Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966851A83F9
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391139AbgDNP5v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 11:57:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45264 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732332AbgDNP5t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 11:57:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D5F312A04F7
Subject: Re: [PATCH 4/4] power: supply: core: Constify properties
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20200413183853.1088823-1-sebastian.reichel@collabora.com>
 <20200413183853.1088823-5-sebastian.reichel@collabora.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <48f5fbce-2eb3-a4dc-8f0f-bde0be0bea6f@collabora.com>
Date:   Tue, 14 Apr 2020 17:57:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200413183853.1088823-5-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 13/4/20 20:38, Sebastian Reichel wrote:
> properties is a list of properties supported by the
> driver. It is not modified by the power-supply core
> and drivers are not supposed to change it once the
> list has been registered. Let's mark it as const for
> improved security.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  include/linux/power_supply.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 0392c9cc8f1c..6a34df65d4d1 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -225,7 +225,7 @@ struct power_supply_desc {
>  	enum power_supply_type type;
>  	const enum power_supply_usb_type *usb_types;
>  	size_t num_usb_types;
> -	enum power_supply_property *properties;
> +	const enum power_supply_property *properties;
>  	size_t num_properties;
>  
>  	/*
> 
