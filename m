Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F86230B4E8
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 02:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhBBByX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 20:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhBBByW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 20:54:22 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B72C061573;
        Mon,  1 Feb 2021 17:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=YxWfLCZ++XySlUZIlHdupbrsffrTbHqEUP48NT9i2kw=; b=j0mmeXYuwSUk5KyZiz5UWnayRV
        sJ1IJqIp1D4aS2X7JVveUGNjjwL7SlNLtNsf93Rrj0bJDRqvTyczl7pBbDw8Fx6dblfO4v7PdT/wW
        e2HWqtGIYjs9SnZHQJq1dZaLjJJCyaMAX6n/7yPoO/7FzPy8FqP/Z6h9dQOxs5f9eIk42d8+WQqpd
        n/MQL0o11LVRyiU+5iLZ2BAROyRHvrIBR+qYvydaDxl4U6VI9pPfAZXLj5URCmWeeGj/rbSw5nGze
        RujGCBFi30yERvlv8QnkxbcDSWJPQ2fFaTuQlOMGSCOxfNfISjhzfRzj7qK5wRXQPUEruamb1/VqS
        YT0kqpcg==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6ksu-00032k-3W; Tue, 02 Feb 2021 01:53:40 +0000
Subject: Re: do not suspend/sleep
To:     =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <f4cfa048-f612-8e38-2899-988471d84faa@infradead.org>
 <_fXGHc0QxoA6O5ljZuheCXVM4m0EDO5yDitURpjxeesPWQ-etoD0Im3937FdotSufu1ZRtBaLFFsCzAY2qtNANeP829mo-YbOZhHksxn8HM=@protonmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <521702af-b5af-02a6-d58d-ff1e63d49e1d@infradead.org>
Date:   Mon, 1 Feb 2021 17:53:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <_fXGHc0QxoA6O5ljZuheCXVM4m0EDO5yDitURpjxeesPWQ-etoD0Im3937FdotSufu1ZRtBaLFFsCzAY2qtNANeP829mo-YbOZhHksxn8HM=@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/1/21 5:51 PM, Barnabás Pőcze wrote:
> Hi
> 
> 
> 2021. február 2., kedd 0:47 keltezéssel, Randy Dunlap írta:
> 
>> Hi all.
>>
>> I usually run my systems (laptops) so that they will suspend to RAM
>> after 30 or 60 minutes of no use (no input), but when I am building
>> e.g. 3 kernels, that will take more than 30 minutes and I don't want
>> the system to suspend during that time.
>>
>> I was wondering what options are available to prevent entering suspend.
>> I am willing to manually enter a command to make that happen if one
>> is available.
>> [...]
> 
> Have you looked at systemd-inhibit(1)?

No, I'm wasn't aware of that, but I'll take a look.

Thanks.

-- 
~Randy

