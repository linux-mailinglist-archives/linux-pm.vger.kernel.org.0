Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579AF31AD86
	for <lists+linux-pm@lfdr.de>; Sat, 13 Feb 2021 19:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhBMSSP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Feb 2021 13:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBMSSO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Feb 2021 13:18:14 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A946CC061574;
        Sat, 13 Feb 2021 10:17:34 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id e4so2405152ote.5;
        Sat, 13 Feb 2021 10:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HOn2/z8mqg+rGPT+Y/Aq1lFl/aq6tLIGwds8V2BocAI=;
        b=k8LI9jwcQy44WxZmxXT4QLcLL6ng0HD4fNSHxTO3mqaHxsSm0BfNjMU+Lu/hyLFQsp
         W02Nx1jsCvyOW+pjXprp6dCdMG6AaZPe3FI37DhV/kMhLp9a97HRupdVI2ApFvLpmZqm
         me636eoZmGr09rhVDUis26bbd+kBQb4eJ6IoX9YwYMQBT7zkLhiYs5whtaSVEYcvFMM5
         ZWQ7w5Db7ViqorTMrhMVtL8LB2GlpQVGTLqn6EczXhcMoTCDgIonHX/ASkCHl9RZKo7g
         NbLcwm6DcL+qNJmwTXcBArVtpk+fd25qU5U8KKcV6WoKuWrqu2h7Cq0ViiOaUIzs3xhX
         rriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HOn2/z8mqg+rGPT+Y/Aq1lFl/aq6tLIGwds8V2BocAI=;
        b=WuMoSK4rjXtxtNn90Kb0qGNS3GB3jxUbV1LsTVQNdl+nPEjEptZM4gXVaL+E46WkCb
         ukipgXdZrEuGwPpt6G6JgbQg4TdVgsenYQR370efWkRUXIyzOu6mJPL163MT3c8Pq4Ia
         5jY+a0F7ffYy61pYNkLXhonz6eF1cLOpW4XvBVRxQ1CFyuKvCpx9BKMVgagqe8AOaKFN
         032Zy9WasiA/zSpP1xOCHt+P9gAvMIsrk00jIKFKTR9vtYyiFAZIgZrzCk1T2LiMzU1s
         3aQcNq9VgxlAMnPdPQF+7y3uHgl1/6AFoEYsug+FKUzGgvkq7x56yvy2+pWs/l84dEwK
         tAog==
X-Gm-Message-State: AOAM5301iYxrvRTpc1ANBxN05K9pyWbDyCE1ewN7PWCJpWg1Z1asa9Ex
        0gHiJ4jRFfRhUp/xtwxy+uq9mxmtmBs=
X-Google-Smtp-Source: ABdhPJxD1MoHOqLUvWpxhIvYmzPvyYyRDEcMznpsG2SE+YrctzI+Td8G0CIBIlCGQJjCi1iiUkFgrw==
X-Received: by 2002:a9d:6c4c:: with SMTP id g12mr6176921otq.53.1613240253599;
        Sat, 13 Feb 2021 10:17:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g11sm2722206oif.9.2021.02.13.10.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Feb 2021 10:17:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [RFC PATCH 1/7] drivers: base: Add resource managed version of
 delayed work init
To:     Hans de Goede <hdegoede@redhat.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
 <1230b0d2ba99ad546d72ab079e76cb1b3df32afb.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
 <2fb4b305-a93f-f91e-3001-dab5057e39cc@redhat.com>
 <084893a3-0071-13e9-5ce6-b7b027e6cd2a@roeck-us.net>
 <16140f5b-c504-1c07-9f0c-3813d686d157@redhat.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <7fc66c14-5dc5-d7b4-60ec-060bcf2d78cf@roeck-us.net>
Date:   Sat, 13 Feb 2021 10:17:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <16140f5b-c504-1c07-9f0c-3813d686d157@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/13/21 7:59 AM, Hans de Goede wrote:
> Hi,
> 
> On 2/13/21 4:27 PM, Guenter Roeck wrote:
>> On 2/13/21 7:03 AM, Hans de Goede wrote:
>> [ ... ]
>>>
>>> I think something like this should work:
>>>
>>> static int devm_delayed_work_autocancel(struct device *dev, struct delayed_work *w,
>>> 					void (*worker)(struct work_struct *work)) {
>>> 	INIT_DELAYED_WORK(w, worker);
>>> 	return devm_add_action(dev, (void (*action)(void *))cancel_delayed_work_sync, w);
>>> }
>>>
>>> I'm not sure about the cast, that may need something like this instead:
>>>
>>> typedef void (*devm_action_func)(void *);
>>>
>>> static int devm_delayed_work_autocancel(struct device *dev, struct delayed_work *w,
>>> 					void (*worker)(struct work_struct *work)) {
>>> 	INIT_DELAYED_WORK(w, worker);
>>> 	return devm_add_action(dev, (devm_action_func)cancel_delayed_work_sync, w);
>>
>> Unfortunately, you can not type cast function pointers in C. It is against the C ABI.
>> I am sure it is done in a few places in the kernel anyway, but those are wrong.
> 
> I see, bummer.
> 
>> This is the reason why many calls to devm_add_action() point to functions such as
>>
>> static void visconti_clk_disable_unprepare(void *data)
>> {
>>         clk_disable_unprepare(data);
>> }
>>
>> which could otherwise be handled using typecasts.
> 
> Hmm, wouldn't something like this be a candidate for adding a:
> 
> devm_clk_prepare_enable() helper?
> 
> This seems better then having the driver(s) make + error check separate
> clk_prepare_enable() + devm_add_action_or_reset() calls ?
> 

I don't really want to go there anymore. The maintainer rejected it several times.

Guenter
