Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E631125B3
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 09:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLDIp3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 03:45:29 -0500
Received: from mail.kapsi.fi ([91.232.154.25]:33607 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfLDIp2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Dec 2019 03:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Br0dk1bpsyd+4qzgRWaxPCZRu6nFMIoIlIvyu3JM4TQ=; b=GiqY50pjtFIxFoiDaFb3QMvRk/
        wyBqfad1DlP0jVA/tyk5o9bj6nr5Xz+phyKnxrZN8JOSDfM45yH0G3AmYRV5RSN92LrRQS2qhh6xh
        NfZPe6jt/Qt4hBYw7duKijAgiD71N6PgoDy5m4v6FjaewWoTwkHQgcR5eLt3XUujZBDYciPNi4ljK
        jemAMAPNEUw0AoX73KRgadG/XzvXepJIoGLh1cEdCkC1u2mrtjBCKNf97GXlPgHt3Keea7Wfy2c9m
        aipp83JOOoZcK8bmxlsrvLbchu8oOiTjTbc4Ns09aqcaAig0zrqZsdemfLeyQtYwuqep3NHdSxN+V
        ZQDN2+LA==;
Received: from [193.209.96.43] (helo=[10.21.26.179])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1icQHk-0000se-Bn; Wed, 04 Dec 2019 10:45:24 +0200
Subject: Re: [TEGRA194_CPUFREQ Patch 1/3] firmware: tegra: adding function to
 get BPMP data
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, jonathanh@nvidia.com,
        talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <20191203174229.GA1721849@ulmo>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <9404232d-84ce-a117-89dd-f2d8de80993e@kapsi.fi>
Date:   Wed, 4 Dec 2019 10:45:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191203174229.GA1721849@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The difference here is that whereas on Tegra186 the frequency is managed 
through a specific memory-mapped device, on Tegra194 the frequency is 
managed through a CPU MSR leaving no "specific" node for this property 
apart from the cpu nodes itself.

Now, my original patchset (which this series is based on) did add 
nvidia,bpmp properties on the CPU DT nodes itself and query BPMP based 
on that. A change is still required for that since tegra_bpmp_get() 
currently takes a 'struct device *' which we don't have for a CPU DT node.

Mikko

On 3.12.2019 19.42, Thierry Reding wrote:
> On Tue, Dec 03, 2019 at 11:02:26PM +0530, Sumit Gupta wrote:
>> Adding new function of_tegra_bpmp_get() to get BPMP data.
>> This function can be used by other drivers like cpufreq to
>> get BPMP data without adding any property in respective
>> drivers DT node.
> 
> What's wrong with adding the property in the DT node? We already do that
> for Tegra186's CPU frequency driver, so it makes sense to continue that
> for Tegra194.
> 
> Thierry
> 
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/firmware/tegra/bpmp.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   include/soc/tegra/bpmp.h      |  5 +++++
>>   2 files changed, 43 insertions(+)
>>
>> diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
>> index 6741fcd..9c3d7f1 100644
>> --- a/drivers/firmware/tegra/bpmp.c
>> +++ b/drivers/firmware/tegra/bpmp.c
>> @@ -38,6 +38,44 @@ channel_to_ops(struct tegra_bpmp_channel *channel)
>>   	return bpmp->soc->ops;
>>   }
>>   
>> +struct tegra_bpmp *of_tegra_bpmp_get(void)
>> +{
>> +	struct platform_device *pdev;
>> +	struct device_node *bpmp_dev;
>> +	struct tegra_bpmp *bpmp;
>> +
>> +	/* Check for bpmp device status in DT */
>> +	bpmp_dev = of_find_compatible_node(NULL, NULL, "nvidia,tegra186-bpmp");
>> +	if (!bpmp_dev) {
>> +		bpmp = ERR_PTR(-ENODEV);
>> +		goto err_out;
>> +	}
>> +	if (!of_device_is_available(bpmp_dev)) {
>> +		bpmp = ERR_PTR(-ENODEV);
>> +		goto err_put;
>> +	}
>> +
>> +	pdev = of_find_device_by_node(bpmp_dev);
>> +	if (!pdev) {
>> +		bpmp = ERR_PTR(-ENODEV);
>> +		goto err_put;
>> +	}
>> +
>> +	bpmp = platform_get_drvdata(pdev);
>> +	if (!bpmp) {
>> +		bpmp = ERR_PTR(-EPROBE_DEFER);
>> +		put_device(&pdev->dev);
>> +		goto err_put;
>> +	}
>> +
>> +	return bpmp;
>> +err_put:
>> +	of_node_put(bpmp_dev);
>> +err_out:
>> +	return bpmp;
>> +}
>> +EXPORT_SYMBOL_GPL(of_tegra_bpmp_get);
>> +
>>   struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
>>   {
>>   	struct platform_device *pdev;
>> diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
>> index f2604e9..21402d9 100644
>> --- a/include/soc/tegra/bpmp.h
>> +++ b/include/soc/tegra/bpmp.h
>> @@ -107,6 +107,7 @@ struct tegra_bpmp_message {
>>   };
>>   
>>   #if IS_ENABLED(CONFIG_TEGRA_BPMP)
>> +struct tegra_bpmp *of_tegra_bpmp_get(void);
>>   struct tegra_bpmp *tegra_bpmp_get(struct device *dev);
>>   void tegra_bpmp_put(struct tegra_bpmp *bpmp);
>>   int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
>> @@ -122,6 +123,10 @@ void tegra_bpmp_free_mrq(struct tegra_bpmp *bpmp, unsigned int mrq,
>>   			 void *data);
>>   bool tegra_bpmp_mrq_is_supported(struct tegra_bpmp *bpmp, unsigned int mrq);
>>   #else
>> +static inline struct tegra_bpmp *of_tegra_bpmp_get(void)
>> +{
>> +	return ERR_PTR(-ENOTSUPP);
>> +}
>>   static inline struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
>>   {
>>   	return ERR_PTR(-ENOTSUPP);
>> -- 
>> 2.7.4
>>
