Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E77605E1F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Oct 2022 12:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJTKpx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Oct 2022 06:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJTKpu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2022 06:45:50 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8484C1C2F04
        for <linux-pm@vger.kernel.org>; Thu, 20 Oct 2022 03:45:49 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EA0675C0048;
        Thu, 20 Oct 2022 06:45:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 20 Oct 2022 06:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666262748; x=1666349148; bh=3i9CEmk2eCVnbmZlcrVEWWg9nuuv
        8GdpzkiURpH+/UA=; b=IsPLyBtZ29Ca/flqP6EMbMKne5jJsmyybxUJEMD2cssn
        vPp3iT7nHbzp0qFUHKDQXidFPEH0o+p9Cj4FFpL/9As9SdrseXwWiXhKMBkUPdm4
        mtyMNQS82rwqbyoKaa37s3gs/j2SZKc6RJZ4pqe/Mpxdhf8OqmEAY9f2ZcHOxnFQ
        4VxFoE7lJvI+vzsAWqQtstvuW2gHC6l1XPA9B5/QHWWapaNCelwWqPaB+PdMTA2+
        sovsm3F5VMQJrKTE5fP7Mz1BSOLOH0DeZ4x9pPRUp9RCN2BtCYcNVKc7o71SLhy4
        Ggy+Eck3t2Mzv+0KvY/Hro0CqOv176eaAr8AyJ6puw==
X-ME-Sender: <xms:2yZRYyfUj9H-swfU_kF3bzcHiWKzph-6-37gzgXRxEYTIeNTHfm2gA>
    <xme:2yZRY8N6wiAdGg9S8qJvUYoKFrNTfDDpIYgW1NKYc281RSvD9jq56rI_raY0zxnoK
    EmUGFaVnwjB4ag>
X-ME-Received: <xmr:2yZRYzjPPerF_eZT69DMl2LR1N_R-xvNe2U0NUCaJ7LYBGpNzyayJReigfB60UepJeb8-7la8aUvUF5Vg2GVQt7nVv9IPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeliedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfh
    jeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:2yZRY__2ACGbBmWKlCETGNwBePjg9dZHCwwgkuWT5cY59zq0bIl1dg>
    <xmx:2yZRY-sIqvwIAp3XP6buSwagDV63aONagxSlLQER03DRtveNopL37A>
    <xmx:2yZRY2GK89tU1pABxUFcbUbs8RwrdAKkR7Ax9cw1vMoYp7O0CxJ2aA>
    <xmx:3CZRYyJ7BMJWeYv8--04MW75woi-xBz7UJsFOhfnIKU3NR_B0yFtDQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Oct 2022 06:45:46 -0400 (EDT)
Date:   Thu, 20 Oct 2022 13:45:43 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal/of: Fix possible memleak in
 thermal_of_zone_register()
Message-ID: <Y1Em16K5jxk3BQ0h@shredder>
References: <20221020080048.56377-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020080048.56377-1-zhangqilong3@huawei.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 20, 2022 at 04:00:48PM +0800, Zhang Qilong wrote:
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index d4b6335ace15..fc8fa27480a1 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -596,10 +596,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
>  	int ntrips, mask;
>  	int ret;
>  
> -	of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> -	if (!of_ops)
> -		return ERR_PTR(-ENOMEM);
> -
>  	np = of_thermal_zone_find(sensor, id);
>  	if (IS_ERR(np)) {
>  		if (PTR_ERR(np) != -ENODEV)
> @@ -626,6 +622,12 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
>  		goto out_kfree_trips;
>  	}
>  
> +	of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> +	if (!of_ops) {
> +		ret = -ENOMEM;
> +		goto out_kfree_tzp;
> +	}
> +
>  	of_ops->get_trip_type = of_ops->get_trip_type ? : of_thermal_get_trip_type;
>  	of_ops->get_trip_temp = of_ops->get_trip_temp ? : of_thermal_get_trip_temp;
>  	of_ops->get_trip_hyst = of_ops->get_trip_hyst ? : of_thermal_get_trip_hyst;
> @@ -656,6 +658,7 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
>  	return tz;
>  
>  out_kfree_tzp:
> +	kfree(of_ops);
>  	kfree(tzp);
>  out_kfree_trips:
>  	kfree(trips);

The patch looks correct, but it can be cleaner. Ideally, you would have
a separate label to free 'of_ops' like we have for other variables.
Also, the error path is not symmetric with thermal_of_zone_unregister()
where this variable is the last to be freed, not the first.

I also encountered this issue and posted a patch:
https://lore.kernel.org/linux-pm/20221020103658.802457-1-idosch@nvidia.com/

Unless you see something wrong with it, can you please test and see if
it fixes your issue?

Thanks
