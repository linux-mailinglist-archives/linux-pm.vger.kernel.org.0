Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E9622C54
	for <lists+linux-pm@lfdr.de>; Wed,  9 Nov 2022 14:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKINZ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Nov 2022 08:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKINZ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2022 08:25:57 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58AA12606;
        Wed,  9 Nov 2022 05:25:55 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 42F2385010;
        Wed,  9 Nov 2022 14:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1668000353;
        bh=gIr1evkrDrAchD9D2RSOu0XKLT0rBIAyjkZHMkIRAik=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J7vhYDIFmEVIJiMAcP/hyAvJUQVr60707XUP6ONd7jE7PDiUfAsURXG5k2EZ7JDFo
         RU4izMCYKZNYrUmKS5DOEx4X1cQ4gOZLtinondP3Re90r54A87IvmoTlUU0cqhogRJ
         OQzxj4ukPjdI7crmaflnX8jMqnQZLZ3lZ2AWB6l56wVAU15MqQwpmk5vCOYeCHX/+X
         heanftMDmbPBKX4PWfcsICR6zkyGMqOz+Nz0UyjaXT+nfLbxeTUh0FWuBokUzHF80Z
         GqL+cz6msIqHUARd++s1exgIbT7oovO+kNSFFifmXiVeoaj4dY36kfwFJCKE/f6Sv9
         00Kjbzs6+G+qQ==
Message-ID: <187e6074-c232-3f56-d3b6-aaefc26eea14@denx.de>
Date:   Wed, 9 Nov 2022 14:25:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/3] [RFC] PM: domains: Introduce .power_pre/post_on/off
 callbacks
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-pm@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Pavel Machek <pavel@ucw.cz>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, linux-imx@nxp.com
References: <20221108013517.749665-1-marex@denx.de>
 <Y2uoxuAXrVSD0r6k@pendragon.ideasonboard.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <Y2uoxuAXrVSD0r6k@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/9/22 14:19, Laurent Pinchart wrote:

Hi,

[...]

>> @@ -1413,6 +1479,7 @@ static int genpd_restore_noirq(struct device *dev)
>>   static void genpd_complete(struct device *dev)
>>   {
>>   	struct generic_pm_domain *genpd;
>> +	int ret;
> 
> This variable is unused, causing a compilation error.

I suspect only with -Werror, but anyway, already fixed locally, it's a 
rebase on latest next artifact.

[...]

>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index ebc3516980907..3cf231a27cb1b 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -134,8 +134,12 @@ struct generic_pm_domain {
>>   	unsigned int prepared_count;	/* Suspend counter of prepared devices */
>>   	unsigned int performance_state;	/* Aggregated max performance state */
>>   	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
>> +	int (*power_off_pre)(struct generic_pm_domain *domain);
>>   	int (*power_off)(struct generic_pm_domain *domain);
>> +	int (*power_off_post)(struct generic_pm_domain *domain);
>> +	int (*power_pre_on)(struct generic_pm_domain *domain);
>>   	int (*power_on)(struct generic_pm_domain *domain);
>> +	int (*power_post_on)(struct generic_pm_domain *domain);
>>   	struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
>>   	struct opp_table *opp_table;	/* OPP table of the genpd */
>>   	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,

I am looking more for a feedback on this extension of the callbacks, and 
on the overall approach. Is this something which looks OK, or would 
there be better way to handle this ?
