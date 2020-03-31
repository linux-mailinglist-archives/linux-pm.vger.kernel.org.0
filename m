Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C119A250
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 01:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbgCaXNx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 19:13:53 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:22988 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731535AbgCaXNv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 19:13:51 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200331231349epoutp04d9877e4c4f4779e5f322a200d10d3691~BhoA6_nI-1919919199epoutp04q
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2020 23:13:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200331231349epoutp04d9877e4c4f4779e5f322a200d10d3691~BhoA6_nI-1919919199epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585696429;
        bh=snJ5QtAqJDsNt4Xfl4YcXCTOWzgVAR2yWKPNPvtOn7o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NyBjcxiE90sj9Bh14AgVAAf/Yhp5WytcqxvMZ7vgV1jHeFxOUJt/d3HdykOEyXYFD
         VBHT4KVdxyekJkjDH95TR/9/hYyjqlgzO8j/VstlqifBPdcoHROu54XrhhIyqQYaH7
         KCgb2jti5hUEOvI38okYSoMR28PJxHQRCU2wUSEw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200331231348epcas1p161ca93bc171927e4eeac52e605b47f0e~BhoAIwSsW0986109861epcas1p1E;
        Tue, 31 Mar 2020 23:13:48 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48sQB20pDmzMqYkZ; Tue, 31 Mar
        2020 23:13:46 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.F8.04071.4AEC38E5; Wed,  1 Apr 2020 08:13:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200331231340epcas1p2aa4b2e9484afcb9d55276d704058bac3~Bhn4khfth0625706257epcas1p2A;
        Tue, 31 Mar 2020 23:13:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200331231340epsmtrp22956baba3080982625fa5b60996b5086~Bhn4jrR681277512775epsmtrp24;
        Tue, 31 Mar 2020 23:13:40 +0000 (GMT)
X-AuditID: b6c32a37-7afff70000000fe7-9b-5e83cea4ca9f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.F4.04024.3AEC38E5; Wed,  1 Apr 2020 08:13:40 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200331231339epsmtip2901b266e694dbec2d2a33ceab8b3d5d5~Bhn4RUL3c1925719257epsmtip24;
        Tue, 31 Mar 2020 23:13:39 +0000 (GMT)
Subject: Re: [PATCH v1 4/5] PM / devfreq: tegra30: Use
 clk_round_rate_unboundly()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <147b571a-bae1-8a58-942c-579a5297299b@samsung.com>
Date:   Wed, 1 Apr 2020 08:22:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200330231617.17079-5-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta0hTYRjHebfj2bSWbzPryaDmKSgNdcc1O1lW0G2glBFE9UE76GmK29nY
        OdrtQyu7OLNIVlBDM8rSjKxUzIxlLCONEkvK7llKWJa21m0U0bZj5Lff+7z/5/J/L0q52k3G
        KPN5kbPxrIkiI4jmW3GJCdVdxVnagxc1zAVvP2L2uk4TzP09HxWMt+xVGNPTWkEyvkPtiHF8
        dZHMg7srmOe7a0nmz+MrBONvPUksHWcYebJPYbjmeqkwNNQ5SMOh4mHScLipDhl8DdMzyU0F
        i/I4NpezaTg+x5KbzxvTqPR12cuy9SlaOoFewMynNDxr5tKo5RmZCSvzTYHxKE0RayoMhDJZ
        QaCSFi+yWQpFTpNnEcQ0irPmmqwLrIkCaxYKeWNijsWcSmu1yfqAcHNBXnXxO5nVj7ft6e2Q
        2dGAqhSFKwHPg8aeXlkpilCqcQuC4zW3SWnxBcHNqoejO98RNP5pIP+lXHhRQgRZjd0IXh9O
        lUQjCDzeLkVwIwqvgwNH74VKTcJnZDDUWBnKkGMRrpe3y4JM4nhoG3wSqhqJY+HRz34UZBVe
        DG/f3A7FCTwL/O4bIY7G66Gzee+oZiJ0nhgI1QzHKeDscJBS/SnwbKBKJvEMuPqpQi5N7VRA
        XQUn8XI45/GHSRwFH+40KSSOAd+we9TlTjjf2R4yALgEQVNb92iCDtrOOgMNlIEGcXCpNUkK
        x8K1X5VI6jsBhr+VhQUlgFVQsl8tSWZCT99LmcRT4cwBB3kEUa4xblxjHLjGOHD9b3YKEXVo
        MmcVzEZOoK26sbfdgEJPN35+C7rcleFBWImo8SpNanGWOowtErabPQiUcmqSilxjz1Krctnt
        OzibJdtWaOIED9IHDrtcHhOdYwl8BF7MpvXJOp2OmUen6GmamqI61mvKUmMjK3IFHGflbP/y
        ZMrwGDvaXVrt/THi41etjXw/sXmtYcKch+ej37rTnwpzl8z+fcm9esvW6PAt6Kw6bqjqTU2/
        s8+4qzutflrfoKtW9EWm22N3+O59PrdRu4G8vkqkuiNWbooSnZ1MUvXC5NOeV1b/V77Mg1uK
        3id6DQu3dREZSwuGyMEOuymuvL6+SH7SQRFCHkvHy20C+xenMJbR0AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvO6Sc81xBreaGS1Wf3zMaNEyaxGL
        xdmmN+wWH3vusVpc3jWHzeJz7xFGi84vs9gsLp5ytbjduILN4t+1jSwWP3fNY3Hg9nh/o5Xd
        Y+esu+wem1Z1snn0Nr9j8+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6MJc3PmAp+ClQ0XT/B
        1MD4hLeLkZNDQsBEYvWdDpYuRi4OIYHdjBKrrt5ggkhISky7eJS5i5EDyBaWOHy4GKLmLaPE
        lE8fwGqEBYIl2qecYQNJiAgsZZJYcfMLO0iCWaBE4sSzf6wQHVsZJV5duMECkmAT0JLY/+IG
        G4jNL6AocfXHY0YQm1fATuLRw6NgcRYBFYmfe/eB2aICYRI7lzxmgqgRlDg58wnYHE4BM4nJ
        JzrZIJapS/yZd4kZwhaXuPVkPhOELS+x/e0c5gmMwrOQtM9C0jILScssJC0LGFlWMUqmFhTn
        pucWGxYY5qWW6xUn5haX5qXrJefnbmIER6CW5g7Gy0viDzEKcDAq8fAqWDXHCbEmlhVX5h5i
        lOBgVhLhZfNviBPiTUmsrEotyo8vKs1JLT7EKM3BoiTO+zTvWKSQQHpiSWp2ampBahFMlomD
        U6qBkenStwjrnkVSer4LTBrF/ypuX3Bw5Z6W6LA4rc7mDTqL4vtklx3eH8tyL3x3q76dXU1J
        7O09mk+UD5pf0Lm1qH3bgbCLmqGtMzZU6K441eLtsafWMaIyZsL591EcKlc3Zyn0t4ic+Nt2
        ls/bx7/ysdi6yxFG07mCZyZcXna3VLfx9uwfOw9EKbEUZyQaajEXFScCAIZ8n/y8AgAA
X-CMS-MailID: 20200331231340epcas1p2aa4b2e9484afcb9d55276d704058bac3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200330232025epcas1p37cf026c6e46723d416f94b1f005ac5ab
References: <20200330231617.17079-1-digetx@gmail.com>
        <CGME20200330232025epcas1p37cf026c6e46723d416f94b1f005ac5ab@epcas1p3.samsung.com>
        <20200330231617.17079-5-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/31/20 8:16 AM, Dmitry Osipenko wrote:
> The clk_round_rate() doesn't work for us properly if clock rate is bounded
> by a min/max rate that is requested by some other clk-user because we're
> building devfreq's OPP table based on the rounding.
> 
> In particular this becomes a problem if display driver is probed earlier
> than devfreq, and thus, display adds a memory bandwidth request using
> interconnect API, which results in a minimum clock-rate being set for
> the memory clk. In a result, the lowest devfreq OPP rate is getting
> limited to the minimum rate imposed by the display driver.
> 
> Let's use new clk_round_rate_unboundly() that resolves the problem by
> rounding clock rate without taking into account min/max limits imposed by
> active clk users.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 28b2c7ca416e..34f6291e880c 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -834,7 +834,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  
>  	reset_control_deassert(tegra->reset);
>  
> -	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
> +	rate = clk_round_rate_unboundly(tegra->emc_clock, ULONG_MAX);
>  	if (rate < 0) {
>  		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
>  		return rate;
> @@ -849,7 +849,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  	}
>  
>  	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
> -		rate = clk_round_rate(tegra->emc_clock, rate);
> +		rate = clk_round_rate_unboundly(tegra->emc_clock, rate);
>  
>  		if (rate < 0) {
>  			dev_err(&pdev->dev,
> 

Firstly, patch2 have to be reviewed for this patch.
I have no any objection. It looks good to me.

If patch1 get the confirmation from clock maintainer,
feel free to add my acked tag:
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
