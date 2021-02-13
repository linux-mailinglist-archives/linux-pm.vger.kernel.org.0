Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBF931AC5B
	for <lists+linux-pm@lfdr.de>; Sat, 13 Feb 2021 15:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBMOkO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Feb 2021 09:40:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229617AbhBMOkL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Feb 2021 09:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613227122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1A8oLUG2I/8/kIRhBL2YlcQBqsattd0/QxapRqeMBk=;
        b=LK0o8YKhABHnumqWZDNNZihBX8uoe4XJyuDoBlDC5hie90o+yupHEbVDBf/BzSzuSEqi6c
        3tzh6POr82o5piha6c57lLNFNG4UZoJwB7hJk5OdetGCgIIRiMn2A6IoWiQydtholfG782
        zcYIWVEVfVzsZP76WOTxMfXSfk/Uc3k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-0D1Dnbb3PBuYlKIgK2s5yA-1; Sat, 13 Feb 2021 09:38:41 -0500
X-MC-Unique: 0D1Dnbb3PBuYlKIgK2s5yA-1
Received: by mail-ej1-f71.google.com with SMTP id ia14so2306605ejc.8
        for <linux-pm@vger.kernel.org>; Sat, 13 Feb 2021 06:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i1A8oLUG2I/8/kIRhBL2YlcQBqsattd0/QxapRqeMBk=;
        b=UjdIWrsooeOjl96i1b+sN5Jp9zy2yj5o82Wvyqdt9Voq9bMoyGZJ11yEMfk+ZZOOcU
         ab0YL5O3jt9Yafn8pfbRt69Sw+WtY/6oOi8XgjlTGjmeYh3IbNdmDmwvJKuvigqb0sSn
         KCN3oRhvVp3eMi9sY9Ddq+dRG3hnPer2TMQlNhIJ0/G9LNJFxwTVFwZ1ft95RoEEyH1x
         HBKzOxWjzx3ILk+5P/oPEpKdgUzmqHVRordLXc7xLhur+h3tfoFpMcpKWzH+RWCGyDTK
         lEGEGnUdx0JUnSlWe1TfJi7PY9BlnKlpBibydT7mB/B7fcMfJJhkL+9XTENY6rdnswRv
         W5zQ==
X-Gm-Message-State: AOAM530tDXnZaQBn8ZGgJ/uPJ230yVx3PbEh3AiJcAZZBO19c310bPC7
        iws2DcuwVA4XrqTNQnZPevCYqKPy1TrNBniI0MmN75i68Zj09YFHRIk2T8qu5653PvQjqxbR7+e
        /F+tGSqwZ9fk0RF361pc=
X-Received: by 2002:a05:6402:20e:: with SMTP id t14mr7983350edv.178.1613227119691;
        Sat, 13 Feb 2021 06:38:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynxGByM2oVx/Og4IMkQA8ITva1TiFO+QeeWLNWWo7/w5+yvW/DCYwGLJwOlQPE13zEewxV8Q==
X-Received: by 2002:a05:6402:20e:: with SMTP id t14mr7983339edv.178.1613227119462;
        Sat, 13 Feb 2021 06:38:39 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s16sm2157689edr.14.2021.02.13.06.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Feb 2021 06:38:38 -0800 (PST)
Subject: Re: [RFC PATCH 1/7] drivers: base: Add resource managed version of
 delayed work init
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
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
 <YCfDAly9b0zHMpJT@kroah.com>
 <284d4a13-5cc8-e23c-7e99-c03db5415bf1@redhat.com>
 <YCfVKyXbeJXNbMsd@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <eecf8ad6-a99d-8ad0-fc7e-f87d015add3f@redhat.com>
Date:   Sat, 13 Feb 2021 15:38:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCfVKyXbeJXNbMsd@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2/13/21 2:33 PM, Greg Kroah-Hartman wrote:
> On Sat, Feb 13, 2021 at 02:18:06PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 2/13/21 1:16 PM, Greg Kroah-Hartman wrote:
>>> On Sat, Feb 13, 2021 at 01:58:44PM +0200, Matti Vaittinen wrote:
>>>> A few drivers which need a delayed work-queue must cancel work at exit.
>>>> Some of those implement remove solely for this purpose. Help drivers
>>>> to avoid unnecessary remove and error-branch implementation by adding
>>>> managed verision of delayed work initialization
>>>>
>>>> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>>>
>>> That's not a good idea.  As this would kick in when the device is
>>> removed from the system, not when it is unbound from the driver, right?
>>
>> Erm, no devm managed resources get released when the driver is detached:
>> drivers/base/dd.c: __device_release_driver() calls devres_release_all(dev);
> 
> Then why do you have to manually call devm_free_irq() in release
> callbacks? 

That is only necessary when there are none devm managed resources /
resource-ish things which get manually released in the remove function
(because they are not devm managed), while the IRQ handler depends on
these.

> I thought that was the primary problem with those things.

If all resources / resource-ish things used by the IRQ handler are
devm managed then there is no need to have a devm_free_irq() call
in a drivers release (which is called remove) callback.

> I can understand devm_ calls handling resources, but callbacks and
> workqueues feels like a big stretch.

Things get hairy wrt devm resource handling when some of the resources
are not managed by devm.

Having devm managed sync-cancel of work items is IMHO actually good to
have because it helps avoiding mixing of devm managed resources with
non devm managed resources.

Some drivers are actually already doing devm managed workqueue cancellation
by using the generic devm_add_action() helper which allows calling a
driver supplied cleanup function when devres_release_all() runs.

This is also useful to make sure the workqueue is cancelled at the
right time during tear-down on error-exits from probe(), which
also runs devres_release_all().

See drivers/power/supply/axp288_charger.c for an example of this.

Note that no-one is going to force people to use this new
devm_delayed_work_autocancel() functionality. IMHO it is a useful
tool to have in our toolbox.

> 
>>> There is two different lifespans here (well 3).  Code and data*2.  Don't
>>> confuse them as that will just cause lots of problems.
>>>
>>> The move toward more and more "devm" functions is not the way to go as
>>> they just more and more make things easier to get wrong.
>>>
>>> APIs should be impossible to get wrong, this one is going to be almost
>>> impossible to get right.
>>
>> I have to disagree here devm generally makes it easier to get things right,
>> it is when some devm functions are missing and devm and non devm resources
>> are mixed that things get tricky.
>>
>> Lets look for example at the drivers/extcon/extcon-intel-int3496.c code
>> from patch 2/7 from this set. The removed driver-remove function looks like
>> this:
>>
>> -static int int3496_remove(struct platform_device *pdev)
>> -{
>> -	struct int3496_data *data = platform_get_drvdata(pdev);
>> -
>> -	devm_free_irq(&pdev->dev, data->usb_id_irq, data);
>> -	cancel_delayed_work_sync(&data->work);
>> -
>> -	return 0;
>> -}
>> -
>>
>> This is a good example where the mix of devm and non devm (the workqueue)
>> resources makes things tricky. The IRQ must be freed first to avoid the
>> work potentially getting re-queued after the sync cancel.
>>
>> In this case using devm for the IRQ may cause the driver author to forget
>> about this, leaving a race.
>>
>> Bit with the new proposed devm_delayed_work_autocancel() function things
>> will just work.
>>
>> This work gets queued by the IRQ handler, so the work must be initialized (1)
>> *before* devm_request_irq() gets called. Any different order would be a
>> bug in the probe function since then the IRQ might run before the work
>> is initialized.
> 
> How are we now going to audit the order of these calls to ensure that
> this is done correctly?  That still feels like it is ripe for bugs in a
> much easier way than without these functions.

We already need to audit probe() functions to make sure that all resources
which the IRQ handlers need are allocated before the IRQ gets requested.

This is why requesting the IRQ is usually one of the last things which
driver's probe functions do.

Using devm (and only devm without mixing and matching) avoids to have to
_also_ audit the probe-error-exit teardown and driver-release paths.
Those will automatically be done in the right order since devm will
release everything in reverse order of allocation.

So this reduces the amount of auditing work we need to do.

In my experience the probe-error-exit teardown and driver-release paths are full
of bugs, bugs which are often never caught because most drivers bind once and then
stay bound until reboot / shutdown so this paths are often not exercised during
testing. So automating this teardown is a good thing to do, it removes a whole
class of bugs.

>> Since devm unrolls / releases resources in reverse order, this means that
>> it will automatically free the IRQ (which was requested later) before
>> cancelling the work.
>>
>> So by switching to the new devm_delayed_work_autocancel() function we avoid
>> a case where a driver author can cause a race on driver detach because it is
>> relying on devm to free the IRQ, which may cause it to requeue a just
>> cancelled work.
>>
>> IOW introducing this function (and using it where appropriate) actually
>> removes a possible class of bugs.
>>
>> patch 2/7 actually has a nice example of this, drivers/extcon/extcon-gpio.c
>> also uses a delayed work queued by an interrupt, together with devm managing
>> the interrupt, yet the removed driver_remove callback:
>>
>> -static int gpio_extcon_remove(struct platform_device *pdev)
>> -{
>> -	struct gpio_extcon_data *data = platform_get_drvdata(pdev);
>> -
>> -	cancel_delayed_work_sync(&data->work);
>> -
>> -	return 0;
>> -}
>> -
>>
>> Is missing the explicit free on the IRQ which is necessary to avoid
>> the race. One the one hand this illustrates your (Greg's) argument that
>> devm managed IRQs may be a bad idea.
> 
> I still think it is :)

I understand and I'm not under the illusion that I'm going to change
your mind about this :)

>> OTOH it shows that if we have devm managed IRQs anyways that then also
>> having devm managed autocancel works is a good idea, since this RFC patch-set
>> not only results in some cleanup, but is actually fixing at least 1 driver
>> detach race condition.
> 
> Fixing bugs is good, but the abstraction away from resource management
> that the devm_ calls cause is worrying as the "magic" behind them can be
> wrong, as seen here.

Here being the gpio_extcon_remove() example ?

Yes that is bad, but again that is due to mixing manual and devm managed
resource management.

Having this new devm_delayed_work_autocancel() helper will allow a
bunch of drivers to move away from mixing the 2, which is a good thing
in my book.

As I said above I believe that having devm_delayed_work_autocancel() (1)
in our toolbox will be a good thing to have. Driver authors can then choose
to use it; or they can choose to not use it if they don't like it.

I know that the reason why I did not use it in the
drivers/extcon/extcon-intel-int3496.c driver is because it was not available
if it had been available then I would definitely have used it, as it avoids the
mixing of resource-management styles which that driver is currently doing.

And I think that that is what this is ultimately about, there are 2 styles
of resource-management:

1. manual
2. devm based

And they both have their pros and cons, problems mostly arise when mixing them
and adding new devm helpers for commonly used cleanup patterns is a good thing
as it helps to get rid of mixing these 2 styles in a single driver.

Regards,

Hans

