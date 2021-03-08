Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B7A3310AA
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 15:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhCHOVD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 09:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhCHOU5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 09:20:57 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D67BC06174A;
        Mon,  8 Mar 2021 06:20:57 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id v2so8239346lft.9;
        Mon, 08 Mar 2021 06:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0qSqLyKBzw4nb8j17jU5SupuAgYw/Y4EGFPBpUKaihs=;
        b=H1L0Z5d54+bKkv1NMZjlGMdv2lvvIaogWTE4at+h3hahV4w7UFyPR7pcmfObjw2SQQ
         9K0qL4nLHig0eSQpmZzm6K5Vy2/VwG39JxGa29NIRBlEsRLCeTGHsO9OFpq6RiQ9++7l
         eoJ5nB1iV47JAXv2LLW0YwiqsqvtVmypkSXlG6MNAQzSomEJZJCIdc+vh1rVQ62JL/2y
         dWv+qMyUjBhA6MH8CJpwAJ35KwXVjBgR3KKtSTVD6LCRIlRiwz5UcYEich/+TuZybcs2
         T27tgfeWT9FtKn+gMEKmMx5zg2LkuKixR50cY9tkIloCU6c4H+3oFTFcGzNYAMF9xq4f
         8+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0qSqLyKBzw4nb8j17jU5SupuAgYw/Y4EGFPBpUKaihs=;
        b=XR9bHxy/gOo0qrNOI+3HWxW8sMT387hHuEHy6+b4pv5r91Vr0M95ND9pVK9bLqlDE5
         BnCxgbvcdInceuRkNFp/xO2iZ35jTOIR7INKSltSU4PsQusLY+zCsscZy9cUMgRHggDP
         8pzVhpyLwg3VQ430O49cEKLGC5Z+FaGxi2ZMt+/6324WZa2Vdo1QGOqrR6T28MJSKa8r
         PC/GzdSr3h8qymB+8ZncRCwqNi9rLKxkq+Azk3NGPl+9LLSL+IHT8rhHkWZ6e3XB7B6l
         JfkCBrGYqZs9ZNOJwGGfxfnwkdWReLyrDjypzMaYeULqeufR8Mw5K9BE0xBBPVHowaU0
         d2Og==
X-Gm-Message-State: AOAM531tylGJStEkX0Z97aR5AM1MqsISh9sAwPJCe/8FObB5eRSJFDPL
        Ii+mzQnO/ohwPHEc1ST7aX0=
X-Google-Smtp-Source: ABdhPJznNPgojN/nObRq+gs8Ca5XApc8sug9k/GrLjNKYrfLSpPuBe0IYA6WM0BuWX8Ci3xWPlXlhQ==
X-Received: by 2002:a19:ac42:: with SMTP id r2mr5176532lfc.548.1615213255627;
        Mon, 08 Mar 2021 06:20:55 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id v10sm1367316lfb.238.2021.03.08.06.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 06:20:54 -0800 (PST)
Subject: Re: [PATCH v13 1/2] drm/tegra: dc: Support memory bandwidth
 management
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20210302124445.29444-1-digetx@gmail.com>
 <20210302124445.29444-2-digetx@gmail.com>
 <20210303230827.GA22628@qmqm.qmqm.pl>
 <1b352c7e-cc72-ba08-32ba-08c05cc3aa03@gmail.com>
 <20210305230222.GA28867@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5cc7aaa9-1168-64ba-f311-2f27038dcf4a@gmail.com>
Date:   Mon, 8 Mar 2021 17:20:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210305230222.GA28867@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

06.03.2021 02:02, Michał Mirosław пишет:
> On Fri, Mar 05, 2021 at 12:45:51AM +0300, Dmitry Osipenko wrote:
>> 04.03.2021 02:08, Michał Mirosław пишет:
>>> On Tue, Mar 02, 2021 at 03:44:44PM +0300, Dmitry Osipenko wrote:
>>>> Display controller (DC) performs isochronous memory transfers, and thus,
>>>> has a requirement for a minimum memory bandwidth that shall be fulfilled,
>>>> otherwise framebuffer data can't be fetched fast enough and this results
>>>> in a DC's data-FIFO underflow that follows by a visual corruption.
> [...]
>>>> +	/*
>>>> +	 * Horizontal downscale takes extra bandwidth which roughly depends
>>>> +	 * on the scaled width.
>>>> +	 */
>>>> +	if (src_w > dst_w)
>>>> +		mul = (src_w - dst_w) * bpp / 2048 + 1;
>>>> +	else
>>>> +		mul = 1;
>>>
>>> Does it really need more bandwidth to scale down? Does it read the same
>>> data multiple times just to throw it away?
>> The hardware isn't optimized for downscale, it indeed takes more
>> bandwidth. You'll witness a severe underflow of plane's memory FIFO
>> buffer on trying to downscale 1080p plane to 50x50.
> [...]
> 
> In your example, does it really need 16x the bandwidth compared to
> no scaling case?  The naive way to implement downscaling would be to read
> all the pixels and only take every N-th.  Maybe the problem is that in
> downscaling mode the latency requirements are tighter?  Why would bandwidth
> required be proportional to a difference between the widths (instead e.g.
> to src/dst or dst*cacheline_size)?

Seems you're right, it's actually not the bandwidth. Recently I added
memory client statistics gathering support to grate-kernel for Tegra20
and it shows that the consumed bandwidth is actually lower when plane is
downscaled.

So it should be the latency, which depends on memory frequency, and
thus, on bandwidth. I'll try to improve comment to the code in the next
version, thanks.
