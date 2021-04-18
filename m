Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F70363462
	for <lists+linux-pm@lfdr.de>; Sun, 18 Apr 2021 11:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhDRJMP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Apr 2021 05:12:15 -0400
Received: from mout02.posteo.de ([185.67.36.66]:44917 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhDRJMO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 18 Apr 2021 05:12:14 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 6D0D52400E5
        for <linux-pm@vger.kernel.org>; Sun, 18 Apr 2021 11:11:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1618737105; bh=WKRW0XXKC2fipPBs9zdITrBVtmnVHuSd55wYWDnZwxo=;
        h=Date:From:To:Cc:Subject:From;
        b=WM3XWGKtXKYrHGYNzvnlhUgABC6QSkTTOkdOaAAAymeby4Tgdzla/05eFd/B++32z
         ZQkt6y4BCX2Vb3532nCFSlbZXw7PDoICdateI+jSzWSDDdKoK2FUoKWgDyKV6HBDVC
         vL6wCanPDGodKMnJPRKTmV3wEl3SNQ7j9zaYC1a/WZzNoQ7hDwC+A6ZtiFB7efXIKm
         NVf7Ij4aTN5w5gsupjHjfv2+XLr4paJxKwN0iNjqOxVl9px2EUMMXgrLqZHoSwhbdb
         ptnSB2q14J8X/u0pftHINFBhv9gfizl13IQ1A+9w9uZhHfYS6VNAcokrOmEnWNgI9Y
         lqo0e6DJIk+PQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FNPMh1d41z6tmG;
        Sun, 18 Apr 2021 11:11:44 +0200 (CEST)
Date:   Sun, 18 Apr 2021 09:11:43 +0000
From:   Sebastian Fricke <sebastian.fricke@posteo.net>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] base: power: runtime.c: Remove a unnecessary space
Message-ID: <20210418091143.6h466qqd52uf766z@basti-TUXEDO-Book-XA1510>
References: <20210418060800.8833-1-sebastian.fricke@posteo.net>
 <794c957472f826b0f2860aecd365376266e2253a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <794c957472f826b0f2860aecd365376266e2253a.camel@perches.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Joe,

On 18.04.2021 00:09, Joe Perches wrote:
>On Sun, 2021-04-18 at 06:08 +0000, Sebastian Fricke wrote:
>> Remove a redundant space to improve the quality of the comment.
>
>I think this patch is not useful.
>
>It's not redundant.

Thank you, I actually found this pattern a few more times but I wanted
to check first if this is a mistake or chosen consciously.

Sorry for the noise.

>
>Two spaces after a period is commonly used to separate sentences.
>It's especially common when used with fixed pitch fonts.
>
>A trivial grep seems to show it's used about 50K times in comments.
>Though single space after period may be used about twice as often.
>
>$ git grep '^\s*\*.*\.  [A-Z]' | wc -l
>54439
>$ git grep '^\s*\*.*\. [A-Z]' | wc -l
>110003
>
>For drivers/base/power/runtime.c, that 2 space after period style is used
>dozens of times and changing a single instance of it isn't very useful.

True and if I understand you correctly you would rather keep it as is
right?

Greetings,
Sebastian

>
>> ---
>> Side-note:
>> I found this while reading the code, I don't believe it is important but
>> I thought it doesn't hurt to fix it.
>> ---
>>  drivers/base/power/runtime.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 18b82427d0cb..499434b84171 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -786,7 +786,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
>>  	}
>>  
>>
>>  	/*
>> -	 * See if we can skip waking up the parent.  This is safe only if
>> +	 * See if we can skip waking up the parent. This is safe only if
>>  	 * power.no_callbacks is set, because otherwise we don't know whether
>>  	 * the resume will actually succeed.
>>  	 */
>
>
