Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A81A338B54
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 12:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhCLLPp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 06:15:45 -0500
Received: from foss.arm.com ([217.140.110.172]:51974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233643AbhCLLPi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Mar 2021 06:15:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23E3EED1;
        Fri, 12 Mar 2021 03:15:38 -0800 (PST)
Received: from [10.57.17.106] (unknown [10.57.17.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2D9B3F793;
        Fri, 12 Mar 2021 03:15:36 -0800 (PST)
Subject: Re: [PATCH 2/3] thermal/drivers/devfreq_cooling: Use device name
 instead of auto-numbering
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, amitk@kernel.org, linux-pm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <20210310114600.27178-1-daniel.lezcano@linaro.org>
 <20210310114600.27178-2-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <8f17dc8b-3259-8e6a-f46b-b97495ecd550@arm.com>
Date:   Fri, 12 Mar 2021 11:15:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210310114600.27178-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/10/21 11:45 AM, Daniel Lezcano wrote:
> Currently the naming of a cooling device is just a cooling technique
> followed by a number. When there are multiple cooling devices using
> the same technique, it is impossible to clearly identify the related
> device as this one is just a number.
> 
> For instance:
> 
>   thermal-devfreq-0
>   thermal-devfreq-1
>   etc ...
> 
> The 'thermal' prefix is redundant with the subsystem namespace. This
> patch removes the 'thermal prefix and changes the number by the device

missing ' after 'thermal

> name. So the naming above becomes:
> 
>   devfreq-5000000.gpu
>   devfreq-1d84000.ufshc
>   etc ...
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/devfreq_cooling.c | 21 ++++-----------------
>   1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index fed3121ff2a1..62abcffeb422 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c

same here, you can now remove the idr.h header

> @@ -25,11 +25,8 @@
>   #define HZ_PER_KHZ		1000
>   #define SCALE_ERROR_MITIGATION	100
>   
> -static DEFINE_IDA(devfreq_ida);
> -
>   /**
>    * struct devfreq_cooling_device - Devfreq cooling device
> - * @id:		unique integer value corresponding to each
>    *		devfreq_cooling_device registered.
>    * @cdev:	Pointer to associated thermal cooling device.
>    * @devfreq:	Pointer to associated devfreq device.
> @@ -51,7 +48,6 @@ static DEFINE_IDA(devfreq_ida);
>    * @em_pd:		Energy Model for the associated Devfreq device
>    */
>   struct devfreq_cooling_device {
> -	int id;
>   	struct thermal_cooling_device *cdev;
>   	struct devfreq *devfreq;
>   	unsigned long cooling_state;
> @@ -363,7 +359,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
>   	struct thermal_cooling_device *cdev;
>   	struct device *dev = df->dev.parent;
>   	struct devfreq_cooling_device *dfc;
> -	char dev_name[THERMAL_NAME_LENGTH];
> +	char name[THERMAL_NAME_LENGTH];

This is probably too short (20 char) array. For example in my phone's
devfreq dir, there are really long names:

---------------------------------------------------------
redfin:/sys/class/devfreq # for f in `ls ./` ; do echo $f; cat $f/name | 
wc -m ; done 

18321000.qcom,devfreq-l3:qcom,cdsp-cdsp-l3-lat
47
18321000.qcom,devfreq-l3:qcom,cpu0-cpu-l3-lat
46
18321000.qcom,devfreq-l3:qcom,cpu6-cpu-l3-lat
46
18321000.qcom,devfreq-l3:qcom,cpu7-cpu-l3-lat
46
3d00000.qcom,kgsl-3d0
22
soc:qcom,cpu-cpu-llcc-bw
25
soc:qcom,cpu-llcc-ddr-bw
25
soc:qcom,cpu0-cpu-ddr-latfloor
31
soc:qcom,cpu0-cpu-llcc-lat
27
soc:qcom,cpu0-llcc-ddr-lat
27
soc:qcom,cpu6-cpu-ddr-latfloor
31
soc:qcom,cpu6-cpu-llcc-lat
27
soc:qcom,cpu6-llcc-ddr-lat
27
soc:qcom,cpu7-cpu-ddr-latfloor
31
soc:qcom,gpubw
15
soc:qcom,kgsl-busmon
21
soc:qcom,npu-llcc-ddr-bw
25
soc:qcom,npu-npu-llcc-bw
25
soc:qcom,npudsp-npu-ddr-bw
27
soc:qcom,snoc_cnoc_keepalive
29
---------------------------------------------------------

We should allocate tmp buffer for it, to not loose the meaningful part
of that string name or end up with only the same prefix, like for the
first 3 from top:

devfreq-18321000.qco

or for the GPU:
devfreq-3d00000.qcom

This is tricky area and vendors might put any non-meaningful prefix.

The rest of the code looks OK, only this name construction part.
