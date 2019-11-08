Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D469F59A0
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 22:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbfKHVRV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 16:17:21 -0500
Received: from muru.com ([72.249.23.125]:41258 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfKHVRV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Nov 2019 16:17:21 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4CFFA80D4;
        Fri,  8 Nov 2019 21:17:56 +0000 (UTC)
Date:   Fri, 8 Nov 2019 13:17:17 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-omap@vger.kernel.org, hns@goldelico.com,
        adam.ford@logicpd.com, Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: ti-soc-thermal:  Enable addition power
 management
Message-ID: <20191108211717.GR5610@atomide.com>
References: <20191108205954.20136-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108205954.20136-1-aford173@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Adam Ford <aford173@gmail.com> [191108 21:00]:
> +static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
> +				  unsigned long cmd, void *v);
>  
>  /***   Helper functions to access registers and their bitfields   ***/
>  
> @@ -1025,6 +1033,9 @@ int ti_bandgap_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	bgp->nb.notifier_call = bandgap_omap_cpu_notifier;
> +	cpu_pm_register_notifier(&bgp->nb);
> +

Hmm looks like you're missing the related call to
cpu_pm_unregister_notifier(), right?

Other than that, it also works on droid4, so please
feel free to add:

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>

