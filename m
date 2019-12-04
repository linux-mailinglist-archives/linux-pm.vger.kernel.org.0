Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C39112931
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 11:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfLDKVn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 05:21:43 -0500
Received: from mail.kapsi.fi ([91.232.154.25]:38167 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbfLDKVn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Dec 2019 05:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lXkM2TiakZNWEer24NnBU2s4hqmdaq894N1amWO3xwU=; b=rlYVOhaHmSwAOLiBcI9DwOvenr
        gX8xA9bN6W8vbD13Q9Q3z4CiCKVYK8IqzXgRiflrhDM0CBRJRVZQKfkYaMLkCRgQh2FIvLqDFAL0Y
        6KKx5oZKzKuQDR8G5YdcU3LAJWI6CjHI2fbpfKaDoPh+6z7B3ulwVIVpCzXul1u1RCjiaN6RkHt0T
        OP+svFIIBKcgAggm+wW19khbF6hdcQyC25UOynrd7rVPZA4UcGNRBstE1bMeibgDRJ5gsjljRCOsN
        TXxKFMtheZpM18pQeBZ+9hf7xOpG2dRM+THKOMQ7t9Y3UOXZqetqM52D+ojk+JL8P8NoDF6NODW2a
        Cci6wq/Q==;
Received: from [193.209.96.43] (helo=[10.21.26.179])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1icRmk-0001Ce-NM; Wed, 04 Dec 2019 12:21:30 +0200
Subject: Re: [TEGRA194_CPUFREQ Patch 1/3] firmware: tegra: adding function to
 get BPMP data
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sumit Gupta <sumitg@nvidia.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, jonathanh@nvidia.com,
        talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <20191203174229.GA1721849@ulmo>
 <9404232d-84ce-a117-89dd-f2d8de80993e@kapsi.fi>
 <20191204091703.d32to5omdm3eynon@vireshk-i7>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <cdb685a4-4d00-4635-df12-c67a6faa81e2@kapsi.fi>
Date:   Wed, 4 Dec 2019 12:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191204091703.d32to5omdm3eynon@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ah, it seems I was mistaken here. Thanks for the information.

Thanks,
Mikko

On 4.12.2019 11.17, Viresh Kumar wrote:
> On 04-12-19, 10:45, Mikko Perttunen wrote:
>> Now, my original patchset (which this series is based on) did add
>> nvidia,bpmp properties on the CPU DT nodes itself and query BPMP based on
>> that. A change is still required for that since tegra_bpmp_get() currently
>> takes a 'struct device *' which we don't have for a CPU DT node.
> 
> I may be missing the context, but the CPUs always have a struct device
> * for them, which we get via a call to get_cpu_device(cpu), isn't ?
> 
