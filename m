Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810846D879
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 03:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfGSBhI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 21:37:08 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:27692 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfGSBhH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 21:37:07 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190719013702epoutp017e4d2406bcc4b740271a66610ee6129e~yqysb-cFY1008910089epoutp01e
        for <linux-pm@vger.kernel.org>; Fri, 19 Jul 2019 01:37:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190719013702epoutp017e4d2406bcc4b740271a66610ee6129e~yqysb-cFY1008910089epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563500222;
        bh=OaDLSbeM0DLaC6y08t6j3d2P4cNYBXvw0FSPQykH0ko=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OUAQozjJdrKkbHUmvBPUBgC6swfWs6kxo377axdQRAF6DTvbqvnTyIc48e9Mj/ZK0
         qcEbHw2QZnsGsgdtwlqCnX/5G0R9GPiXiHjsdLCfS9aCF3LfxLwKSKUHH9jap/6rIr
         H6eIbr/HVmwuSGDEW/C0kmUab8N+vE+K575VNvvs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190719013701epcas1p49bb343cc888162790d628c860e06714c~yqyr5noO11892318923epcas1p4z;
        Fri, 19 Jul 2019 01:37:01 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 45qYWv18QhzMqYkb; Fri, 19 Jul
        2019 01:36:59 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.88.04085.BBE113D5; Fri, 19 Jul 2019 10:36:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190719013658epcas1p2349c3deef7a8fdd9cdcff4d2bdab89f3~yqypLRyVS2872828728epcas1p29;
        Fri, 19 Jul 2019 01:36:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190719013658epsmtrp1f49d35cb9bd6e05488e93c2f540b6616~yqypKAiNP3027730277epsmtrp1h;
        Fri, 19 Jul 2019 01:36:58 +0000 (GMT)
X-AuditID: b6c32a39-d03ff70000000ff5-30-5d311ebbf4cc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.92.03706.ABE113D5; Fri, 19 Jul 2019 10:36:58 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190719013658epsmtip1c37ad697c053f65da4d67ae31fdf4126~yqyo8dK8s3163931639epsmtip1p;
        Fri, 19 Jul 2019 01:36:58 +0000 (GMT)
Subject: Re: [PATCH v4 21/24] PM / devfreq: tegra30: Synchronize average
 count on target's update
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <eed89254-9960-7572-635c-12b114821e85@samsung.com>
Date:   Fri, 19 Jul 2019 10:40:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719033152.1d4c3003@dimatab>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BMcRTH/fbu3r3bWH7W0rEzsq5h1Kj2VpubyhjCGhlrjAkzTa660+60
        r9m7NfKYQSaJvP9gPcf7VSoha4jk9QfyHMqORaKGQjEhw969Gf33Oed8z+97zu/3owhNBamj
        rA4P73ZwNpoMk1+4EWmIvhzBZBr8Vwn29Je3iF3nPSRn7639qGQf+/aSbFdZA2I3dHtJtnnN
        CZL94dsvZzeXPyKnqEy1/iPIdMnrV5rKijpI0+aaU8jUVR1hVizOS7HwXA7v1vOObGeO1ZGb
        Ss+enzUty5hoYKKZJHYirXdwdj6VTks3R8+w2oID0foCzpYfTJk5QaBjJ6e4nfkeXm9xCp5U
        mnfl2FxJrhiBswv5jtyYbKd9EmMwxBmDwiV5lt0Vv5CrfOSyLRfvK1ejN+GlSEUBToBDpw+g
        UhRGaXAtgutN2wkp+IrgeOtNhRR8R7DmxHXiX8u22nNKkTX4CoLOZymSqBNB5fsOmVgYirOh
        u+yFQmQtHgfHb/aGTiJwlQxuV54JiUgcBXUfnpMiD8aj4WnPWySyGk+G3q6qUF6Ox0LX6wsh
        52F4IXwN3FBImiFwd3eLvBRRlArHwJMHBWKawOHQ1HJAJvEoKDq/p2/oPyT8uAYSp8Gntkal
        xEOh/XZNH+ugbUtxH6+Ak3cbSHFmwCUIauoaFVIhHuqO7pCJvgSOhLO+WCk9Gi792ock30HQ
        8W2TQpQAVkNJsUaSjIHHAb9M4hFweP0Gciuivf2W8fbbwNtvA+9/s4NIfgoN512CPZcXGJex
        /2NXo9BfjUqqRbfup9cjTCF6oNpsN2RqFFyBUGivR0ARtFbd3BabqVHncIXLebczy51v44V6
        ZAze9TZCNyzbGfz5Dk8WY4yLj49nE5hEI8PQ4er9vZGZGpzLefg8nnfx7n99MkqlW40yVr4L
        r0/e1WTQqnDjuSlEe0vy2uLkhwuKGt78jusp71EOXnpywueBevPPGjt/hbLGGKe3mDMCbaOs
        U8t8ukfdmyLTbiUm1FnClv8uHD6+M33RVLRyz9w7zUdL9LEzd/oKAwO0Wv/Fl8fmVbS/c7VG
        bKRbX3lWBXyOAbNK9s6RWXppuWDhmCjCLXB/AWhG0DLBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnO4uOcNYg+1HNCxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyZq77zViwVraif/s59gbGR+JdjJwcEgImEhN3
        bGbvYuTiEBLYzSjxefUPRoiEpMS0i0eZuxg5gGxhicOHiyFq3jJKrF7dAlYjLJAssfXgamYQ
        W0RATWL50T+sIEXMApuZJM6eWs0G0dHLJLHiwQKwDjYBLYn9L26wgdj8AooSV388BovzCthJ
        /Pm8ESzOIqAq8fnhNrCpogIREod3zIKqEZQ4OfMJC8hFnAJ6ElfOl4GEmQXUJf7Mu8QMYYtL
        3HoynwnClpdo3jqbeQKj8Cwk3bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgWGeanlesWJucWl
        eel6yfm5mxjBMaaluYPx8pL4Q4wCHIxKPLwBuQaxQqyJZcWVuYcYJTiYlUR4b7/UjxXiTUms
        rEotyo8vKs1JLT7EKM3BoiTO+zTvWKSQQHpiSWp2ampBahFMlomDU6qBsdJxhcYjpjXWL7PP
        uzq+qJ9X6irMsdRJovLJPzXtOgmJ7Pnb2Gbu6nr0u49rdnHygpunJ7Gp55qt+/mAg3WVWUPh
        jZMWbS8+LG2w+xmmGx2nuSzo4pcHP5asPDaT6aYNRxjTT6l909a+/SYsajSVb43gZZ8S/alx
        IpPUylP8zt0rN8jSYy78p8RSnJFoqMVcVJwIAOjRf2+tAgAA
X-CMS-MailID: 20190719013658epcas1p2349c3deef7a8fdd9cdcff4d2bdab89f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223619epcas4p3dea48e3e09983cd2a76af39fbf7bf99b
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223619epcas4p3dea48e3e09983cd2a76af39fbf7bf99b@epcas4p3.samsung.com>
        <20190707223303.6755-22-digetx@gmail.com>
        <f83fb873-9214-9649-9435-9f211c4cba9e@samsung.com>
        <20190719033152.1d4c3003@dimatab>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 19. 오전 9:31, Dmitry Osipenko wrote:
> В Thu, 18 Jul 2019 19:15:54 +0900
> Chanwoo Choi <cw00.choi@samsung.com> пишет:
> 
>> On 19. 7. 8. 오전 7:33, Dmitry Osipenko wrote:
>>> The average count may get out of sync if interrupt was disabled /
>>> avoided for a long time due to upper watermark optimization, hence
>>> it should be re-synced on each target's update to ensure that
>>> watermarks are set up correctly on EMC rate-change notification and
>>> that a correct frequency is selected for device.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/devfreq/tegra30-devfreq.c | 30
>>> ++++++++++++++++++++++++++++++ 1 file changed, 30 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/tegra30-devfreq.c
>>> b/drivers/devfreq/tegra30-devfreq.c index
>>> 4d582809acb6..8a674fad26be 100644 ---
>>> a/drivers/devfreq/tegra30-devfreq.c +++
>>> b/drivers/devfreq/tegra30-devfreq.c @@ -466,11 +466,41 @@ static
>>> void actmon_isr_device(struct tegra_devfreq *tegra,
>>> dev->boost_freq, cpufreq_get(0)); }
>>>  
>>> +static void tegra_devfreq_sync_avg_count(struct tegra_devfreq
>>> *tegra,
>>> +					 struct
>>> tegra_devfreq_device *dev) +{
>>> +	u32 avg_count, avg_freq, old_upper, new_upper;
>>> +
>>> +	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
>>> +	avg_freq = avg_count / ACTMON_SAMPLING_PERIOD;
>>> +
>>> +	old_upper = tegra_actmon_upper_freq(tegra, dev->avg_freq);
>>> +	new_upper = tegra_actmon_upper_freq(tegra, avg_freq);
>>> +
>>> +	/* similar to ISR, see comments in actmon_isr_device() */
>>> +	if (old_upper != new_upper) {
>>> +		dev->avg_freq = avg_freq;
>>> +		dev->boost_freq = 0;
>>> +	}
>>> +}
>>> +
>>>  static unsigned long actmon_update_target(struct tegra_devfreq
>>> *tegra, struct tegra_devfreq_device *dev)
>>>  {
>>>  	unsigned long target_freq;
>>>  
>>> +	/*
>>> +	 * The avg_count / avg_freq is getting snapshoted on
>>> device's
>>> +	 * interrupt, but there are cases where actual value need
>>> to
>>> +	 * be utilized on target's update, like CPUFreq boosting
>>> and
>>> +	 * overriding the min freq
>>> via /sys/class/devfreq/devfreq0/min_freq
>>> +	 * because we're optimizing the upper watermark based on
>>> the
>>> +	 * actual EMC frequency. This means that interrupt may be
>>> +	 * inactive for a long time and thus making snapshoted
>>> value
>>> +	 * outdated.
>>> +	 */
>>> +	tegra_devfreq_sync_avg_count(tegra, dev);  
>>
>> I think that you don't need to add the separate function to calculate
>> the 'dev->avg_freq'. It is enough with your detailed comment to add
>> this code in this function.
> 
> The separate function is indeed not mandatory here, but I'm finding that
> it usually makes easier to read and follow the code when it is properly
> split up into logical blocks. Don't you agree?

It is right to make the separate function if function is too long or 
function is called on the multiple points.

But, in this case, I think that it is enough to add this code
to the actmon_update_target() because you already added the detailed comment. 

It is enough to understand the role of this code with your comment.

> 
>>> +
>>>  	target_freq = min(dev->avg_freq + dev->boost_freq,
>>> KHZ_MAX); target_freq = tegra_actmon_account_cpu_freq(tegra, dev,
>>> target_freq); 
>>>   
>>
>> And also, is it impossible to squash this patch with patch19/patch20?
>>
> 
> It should be possible to squash this patch with #20, but wouldn't
> be better to keep changes in the chronological order? It's also better
> to keep changes separate simply to aid bisection in case of a problem.
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
