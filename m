Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC51D31DE
	for <lists+linux-pm@lfdr.de>; Thu, 14 May 2020 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgENNyv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 09:54:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56442 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgENNyv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2020 09:54:51 -0400
Received: from 89-64-84-17.dynamic.chello.pl (89.64.84.17) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id d4c883bd97bc7369; Thu, 14 May 2020 15:54:48 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     viresh.kumar@linaro.org, Souvik.Chakravarty@arm.com,
        Thanu.Rangarajan@arm.com, Sudeep.Holla@arm.com,
        guohanjun@huawei.com, john.garry@huawei.com,
        jonathan.cameron@huawei.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] cpufreq: fix the return value in 'cpufreq_boost_set_sw()'
Date:   Thu, 14 May 2020 15:54:47 +0200
Message-ID: <28914151.3vfbF0e6KZ@kreacher>
In-Reply-To: <1588929064-30270-2-git-send-email-wangxiongfeng2@huawei.com>
References: <1588929064-30270-1-git-send-email-wangxiongfeng2@huawei.com> <1588929064-30270-2-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, May 8, 2020 11:11:02 AM CEST Xiongfeng Wang wrote:
> When I try to add SW BOOST support for CPPC, I got the following error:
> cpufreq: cpufreq_boost_trigger_state: Cannot enable BOOST
> cpufreq: store_boost: Cannot enable BOOST!
> 
> It is because return value 1 of 'freq_qos_update_request()' means the
> effective constraint value has changed, not a error code on failures.
> But for 'cpufreq_driver.set_boost()', a nonzero return value means
> failure. So change 'ret' to zero when 'freq_qos_update_request()'
> returns a positive value.
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4adac3a..475fb1b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2522,6 +2522,8 @@ static int cpufreq_boost_set_sw(int state)
>  		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>  		if (ret < 0)
>  			break;
> +		else
> +			ret = 0;
>  	}
>  
>  	return ret;
>

I would change cpufreq_boost_trigger_state() to take the 1 into account properly
instead.

Thanks!



