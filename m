Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1561F22232A
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 14:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgGPM5q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 08:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgGPM5p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 08:57:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2540C061755;
        Thu, 16 Jul 2020 05:57:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: wlozano)
        with ESMTPSA id B67CB2A570D
Subject: Re: [PATCH] opp: Increase parsed_static_opps on _of_add_opp_table_v1
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, kernel@collabora.com,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org
References: <20200716025452.25761-1-walter.lozano@collabora.com>
 <20200716032259.l5ybqetpg74ybogh@vireshk-i7>
From:   Walter Lozano <walter.lozano@collabora.com>
Message-ID: <34634b9e-2f6f-d8d8-ccf3-39841301cd65@collabora.com>
Date:   Thu, 16 Jul 2020 09:57:37 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716032259.l5ybqetpg74ybogh@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 16/7/20 00:22, Viresh Kumar wrote:
> On 15-07-20, 23:54, Walter Lozano wrote:
>> Currently, when using _of_add_opp_table_v2 parsed_static_opps is
>> increased and this value is used on _opp_remove_all_static to
>> check if there are static opps entries that need to be freed.
>> Unfortunately this does not happens when using _of_add_opp_table_v1,
>> which leads to warnings.
>>
>> This patch increases parsed_static_opps on _of_add_opp_table_v1 in a
>> similar way as in _of_add_opp_table_v2.
>>
>> Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
>> ---
>>
>>   drivers/opp/of.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>> index 9a5873591a40..b2bc82bf8b42 100644
>> --- a/drivers/opp/of.c
>> +++ b/drivers/opp/of.c
>> @@ -917,6 +917,8 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
>>   		nr -= 2;
>>   	}
>>   
>> +	opp_table->parsed_static_opps++;
>> +
>>   	return ret;
>>   }
> Merged with this and added relevant Fixes and stable tags.


Thanks for apply the proper fix.


>
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index b2bc82bf8b42..314f306140a1 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -902,6 +902,10 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
>                  return -EINVAL;
>          }
>   
> +       mutex_lock(&opp_table->lock);
> +       opp_table->parsed_static_opps = 1;
> +       mutex_unlock(&opp_table->lock);
> +
>          val = prop->value;
>          while (nr) {
>                  unsigned long freq = be32_to_cpup(val++) * 1000;
> @@ -917,8 +921,6 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
>                  nr -= 2;
>          }
>   
> -       opp_table->parsed_static_opps++;
> -
>          return ret;
>   }
>   
