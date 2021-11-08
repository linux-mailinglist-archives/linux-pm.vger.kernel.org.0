Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0620449ED6
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 23:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbhKHW7i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 17:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbhKHW7i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Nov 2021 17:59:38 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FECC061570
        for <linux-pm@vger.kernel.org>; Mon,  8 Nov 2021 14:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=8tRnMQv4FwUWN653ON+dGDikLqtsFV4w3eTOzWPQWHQ=; b=G7R4xdELwNWjeR6EHKjuhUccYD
        OUukDikDwnRH9G25lsw/jd+ddB5pha04H9mkSNhGhcrRpaRC/D0I7rwbYuiY5voNQh5Vc2CziJR0M
        V822xo/2Vui19eJbZwhKZVc+C1KhH2NkLs9O9o5OLx3170bWCISv8oiMhDeujvry/ZJW9qJUgftZV
        YpcEBex7P1QvSNlELbHuWeDi+QGsGRN21rLm8TdwYNdtICvYSkVsodupyxAuGnOGgRjhW1mZaqOjY
        8qXq3G93AekT/a/bb7rdlb1VO4wLCAEb3DPi2FKozbuiNJHmkV2UtnQwInl0+PDSILp4yzfXQ+JkT
        /LNDR7VA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by merlin.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkDZL-008js5-IE; Mon, 08 Nov 2021 22:56:51 +0000
Subject: Re: [PATCH] power: supply: core: Add kerneldoc to battery struct
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
References: <20211105003026.970184-1-linus.walleij@linaro.org>
 <d296ee8c-f6f0-aa42-e261-ed631f598fd0@infradead.org>
 <CACRpkdb0BT43Zm5=OgKFTgYeabNy7B0oRFO9aOJCy4Pbz1TJtQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fe207a84-4728-5efb-f48a-15c52ca18921@infradead.org>
Date:   Mon, 8 Nov 2021 14:56:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdb0BT43Zm5=OgKFTgYeabNy7B0oRFO9aOJCy4Pbz1TJtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/8/21 2:50 PM, Linus Walleij wrote:
> Hi Randy,
> 
> thanks for your review, I incorporated all of them, but I have one
> question:
> 
> On Fri, Nov 5, 2021 at 3:20 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>>> + * @ocv_temp: array indicating the open circuit voltage (OCV) capacity
>>> + *   temperature indices. This is an array of temperatures in degrees celsius
>>
>>                                                              preferably    Celsius
> 
> I understand spelling Celsius with big C (he was even Swedish, I should know...)
> but what is "preferably" here?
> 
> If the idea is to reuse these properties between different chargers and
> batteries we should rather state that this has to be Celsius or
> we will have trouble.
> 
> Since no driver is using this yet I think it is fine to mandate Celsius?
> 
> Or am I misunderstanding the comment?

Yes, misunderstanding, I think.
I just meant that "Celsius" is preferable.
Sorry for the confusion.

-- 
~Randy
