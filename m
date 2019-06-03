Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 759233353D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 18:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfFCQwK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 12:52:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39933 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfFCQwK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 12:52:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id a10so13662166ljf.6;
        Mon, 03 Jun 2019 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KnyOXSIopN/Ka24mmzbYok8zeywL4IgEj6G0AfcpK3A=;
        b=d+B93gDZ4Zk80L8xsAhKGDk4unnUHBGzGpeAymLI25/KfdgoS9X/IUyTOlVXfeCdPs
         Mk5RwWdM1RK0oR3opCh9kR4PI8ZzeT3bk1DTubMa+dY1+5Ss3uhgvhu7/SM71Ez27r+2
         jc54KlG60/IPrSWzRw07yu3VhieKip16jZU0EZeXofJi3bftO6kxPJKqBK+yGpVKqf8g
         FmZe275fw4uz9mQ2dxRoEOPSFyOhlS8E1gKljsxtHGxwM2K7OwEvBnseyloATe8+sdy7
         GY4VbobDxwzy58KQRhUdKjfvM5m4rg6RRHFfd7yL113PIwdXLFHRk2nx6bRdNp2bMB9n
         Q8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KnyOXSIopN/Ka24mmzbYok8zeywL4IgEj6G0AfcpK3A=;
        b=cn1IEZlLo2KVpX7ULhT83m8vjpB6S7G34HGCOyP1mA3e27YxCKBvzUVjB7TGc5vk6S
         9AxJe3sA13X+Lok8BpCyBeIyuQTh2yy+om1WsXWly0Oc8qLvnRXPbWCNkmA/7o2OXA3E
         kqfZbbN7mSYyk7qEI96HBqiGzjoKf2p8/MU9SZdjSrjuLhr/lRd6xmvtQBXhmih5nmsV
         dke2TEKS6jXXavhbzoKDsD6PFn4FmsitVLoYR+I+TO/pM3yIbqfGfhn6oIDUSBVPE/az
         6CCADXWQDkk7Pw8kKapR4ajLAVyXyRj4+ZjV6eZ/ac2ygVgAuEl8QjkK+k5WasahWmS+
         W7Lg==
X-Gm-Message-State: APjAAAVCGjWrfy66WHhzuhgMKhNSUWfhE2IQKdyQJBvh65/KMukHxDm3
        1T4zinJ5tAtLOdAXwvJYfSwoS3Fw
X-Google-Smtp-Source: APXvYqyGlRWcTRlcdz2/rbx1rjdp70p0Jn2ZIFv0VW4Jvkh/0sW6DGGqWSmvRBpuwfEvYQR/X9IZFQ==
X-Received: by 2002:a2e:7d09:: with SMTP id y9mr10782512ljc.110.1559580727119;
        Mon, 03 Jun 2019 09:52:07 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id q1sm2631361lfc.79.2019.06.03.09.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:52:05 -0700 (PDT)
Subject: Re: [PATCH v4 00/16] NVIDIA Tegra devfreq improvements and Tegra20/30
 support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20190501234148epcas5p1cc9a8dafa9ee6d8d046d1292b8270727@epcas5p1.samsung.com>
 <20190501233815.32643-1-digetx@gmail.com>
 <60ef6e47-e61b-3a92-e90d-90debedfcfc4@samsung.com>
 <fa061a65-f108-6c5e-1f87-950a9a8caafc@gmail.com>
Message-ID: <0fb50eb1-a173-1756-6889-2526a10ac707@gmail.com>
Date:   Mon, 3 Jun 2019 19:52:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fa061a65-f108-6c5e-1f87-950a9a8caafc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.05.2019 3:52, Dmitry Osipenko пишет:
> 03.05.2019 3:31, Chanwoo Choi пишет:
>> Hi Dmitry,
>>
>> On 19. 5. 2. 오전 8:37, Dmitry Osipenko wrote:
>>> Changelog:
>>>
>>> v4: Addressed all review comments that were made by Chanwoo Choi to v3:
>>>
>>>     - changed the driver removal order to match the probe exactly
>>>     - added clarifying comment for 1/8 ratio to the Tegra20 driver
>>>
>>>     Chanwoo, please also note that the clk patch that should fix
>>>     compilation problem that was reported the kbuild-test-robot is already
>>>     applied and available in the recent linux-next.
>>
>> I knew that Stephen picked up your path about clock.
> 
> Hi Chanwoo,
> 
> Okay, good. Thank you very much for reviewing this series! I assume it's
> too late now for v5.2, but it should be good to go for v5.3.
> 

Hello Chanwoo,

Will be nice to see the patches in the linux-next before they'll hit mainline. We have tested that
everything works fine on a selective devices, but won't hurt to get some extra testing beforehand.
AFAIK, at least NVIDIA people are regularly testing -next on theirs dev boards. Please note that
this not very important, so don't bother if there is some hurdle with pushing to the tracking branch
for now. Also please let me know if you're expecting to see some ACK's on the patches, I'm sure
we'll be able to work out that with Thierry and Jon if necessary.
