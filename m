Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F9C57BAA
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 07:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfF0F4L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 01:56:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0F4L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 01:56:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D59BA6019D; Thu, 27 Jun 2019 05:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561614969;
        bh=NQmFaOvOVJfUDh5Dl+DU341nQ5fC4vPdyjSO6MXe63c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ITVHzzgh2L0K1yzwIy89XgnF7z73DhjoKe2/J5HVswHKBHxKP7Gi7brrxe2XUaWvb
         vnBl2VT5BfAGwNMWhbCOyPqoz5CYSKgSiUBBY2C9htTHbUmgtYiErqvD9R48w3HbhM
         uYutOKXhIPFyTKCOjo+MXnHcHXyaOy8p4zANVRdI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 54D706019D;
        Thu, 27 Jun 2019 05:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561614968;
        bh=NQmFaOvOVJfUDh5Dl+DU341nQ5fC4vPdyjSO6MXe63c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f7jJhVo5WGvo+YvXasBsVAJl09bTSQ8O9ZdgEONJBZ6+MQj5oSCU8DMhPq/UfBetJ
         FVMxTWqXkEo089NWutkXKkO0imULf09xHJprNL3nYa13i2n2Nm/E8dUinUlXfrlA3l
         Fvxq7ZVaX5yayyMvasKVt3OnKJburFJxynpHrRaU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Jun 2019 11:26:08 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org,
        sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net
Cc:     jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 2/5] interconnect: Add of_icc_get_by_index() helper
 function
In-Reply-To: <e6469e3b-3653-d20b-b27d-242547a777df@codeaurora.org>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-3-georgi.djakov@linaro.org>
 <e6469e3b-3653-d20b-b27d-242547a777df@codeaurora.org>
Message-ID: <199da2ca8a21b179e3e153623c69e8a0@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Georgi,

I heard there is a follow up discussion
planned to finalize on the which approach
to follow. If we do end up with your series,
I found some fixes that you might want to
use when you re-post.

On 2019-05-07 17:29, Sibi Sankar wrote:
> Hey Georgi,
> 
> On 4/23/19 6:58 PM, Georgi Djakov wrote:
>> This is the same as the traditional of_icc_get() function, but the
>> difference is that it takes index as an argument, instead of name.
>> 
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>   drivers/interconnect/core.c  | 45 
>> ++++++++++++++++++++++++++++--------
>>   include/linux/interconnect.h |  6 +++++
>>   2 files changed, 41 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>> index 871eb4bc4efc..a7c3c262c974 100644
>> --- a/drivers/interconnect/core.c
>> +++ b/drivers/interconnect/core.c
>> @@ -295,9 +295,9 @@ static struct icc_node 
>> *of_icc_get_from_provider(struct of_phandle_args *spec)
>>   }
>>     /**
>> - * of_icc_get() - get a path handle from a DT node based on name
>> + * of_icc_get_by_index() - get a path handle from a DT node based on 
>> index
>>    * @dev: device pointer for the consumer device
>> - * @name: interconnect path name
>> + * @idx: interconnect path index
>>    *
>>    * This function will search for a path between two endpoints and 
>> return an
>>    * icc_path handle on success. Use icc_put() to release constraints 
>> when they
>> @@ -309,13 +309,12 @@ static struct icc_node 
>> *of_icc_get_from_provider(struct of_phandle_args *spec)
>>    * Return: icc_path pointer on success or ERR_PTR() on error. NULL 
>> is returned
>>    * when the API is disabled or the "interconnects" DT property is 
>> missing.
>>    */
>> -struct icc_path *of_icc_get(struct device *dev, const char *name)
>> +struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
>>   {
>>   	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
>>   	struct icc_node *src_node, *dst_node;
>>   	struct device_node *np = NULL;
>>   	struct of_phandle_args src_args, dst_args;
>> -	int idx = 0;
>>   	int ret;
>>     	if (!dev || !dev->of_node)
>> @@ -335,12 +334,6 @@ struct icc_path *of_icc_get(struct device *dev, 
>> const char *name)
>>   	 * lets support only global ids and extend this in the future if 
>> needed
>>   	 * without breaking DT compatibility.
>>   	 */
>> -	if (name) {
>> -		idx = of_property_match_string(np, "interconnect-names", name);
>> -		if (idx < 0)
>> -			return ERR_PTR(idx);
>> -	}
>> -
>>   	ret = of_parse_phandle_with_args(np, "interconnects",
>>   					 "#interconnect-cells", idx * 2,
>>   					 &src_args);
>> @@ -383,6 +376,38 @@ struct icc_path *of_icc_get(struct device *dev, 
>> const char *name)
>>     	return path;
>>   }
>> +
>> +/**
>> + * of_icc_get() - get a path handle from a DT node based on name
>> + * @dev: device pointer for the consumer device
>> + * @name: interconnect path name
>> + *
>> + * This function will search for a path between two endpoints and 
>> return an
>> + * icc_path handle on success. Use icc_put() to release constraints 
>> when they
>> + * are not needed anymore.
>> + * If the interconnect API is disabled, NULL is returned and the 
>> consumer
>> + * drivers will still build. Drivers are free to handle this 
>> specifically,
>> + * but they don't have to.
>> + *
>> + * Return: icc_path pointer on success or ERR_PTR() on error. NULL is 
>> returned
>> + * when the API is disabled or the "interconnects" DT property is 
>> missing.
>> + */

please change the description since it does not
return NULL when the property is missing.

>> +struct icc_path *of_icc_get(struct device *dev, const char *name)
>> +{
>> +	int idx = 0;
>> +
>> +	if (!dev || !dev->of_node)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	if (name) {
>> +		idx = of_property_match_string(dev->of_node,
>> +					       "interconnect-names", name);
>> +		if (idx < 0)
>> +			return ERR_PTR(idx);
>> +	}
>> +
>> +	return of_icc_get_by_index(dev, idx);
>> +}
>>   EXPORT_SYMBOL_GPL(of_icc_get);
>>     /**
>> diff --git a/include/linux/interconnect.h 
>> b/include/linux/interconnect.h
>> index dc25864755ba..0e430b3b6519 100644
>> --- a/include/linux/interconnect.h
>> +++ b/include/linux/interconnect.h
>> @@ -28,6 +28,7 @@ struct device;
>>   struct icc_path *icc_get(struct device *dev, const int src_id,
>>   			 const int dst_id);
>>   struct icc_path *of_icc_get(struct device *dev, const char *name);
>> +struct icc_path *of_icc_get_by_index(struct device *dev, int idx);
>>   void icc_put(struct icc_path *path);
>>   int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>>   @@ -45,6 +46,11 @@ static inline struct icc_path *of_icc_get(struct 
>> device *dev,
>>   	return NULL;
>>   }
>>   +struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
> 
> This should be static inline instead
> 
>> +{
>> +	return NULL;
>> +}
>> +
>>   static inline void icc_put(struct icc_path *path)
>>   {
>>   }
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
