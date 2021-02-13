Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B1A31AC70
	for <lists+linux-pm@lfdr.de>; Sat, 13 Feb 2021 15:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhBMOxm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Feb 2021 09:53:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhBMOxj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Feb 2021 09:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613227931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l4ytx6mSORryC9/ckDkwUt9Y5elBZy+A8DMLR/SeLFA=;
        b=YkBb++FqeCQexIcmLPVkI5USioZuspB2wIiOToCT7mhsRmPb5LgLGjA5vsN5KfVKGLI4Sq
        boDY8iQv3jbvgvt02p1HnkG+nYZnQRLr/wr/osuMwrtu129NApDYIzz8ou21qZeXHE/vLP
        YSXa/Vpz6Vc3eu0RNddpjhrrRj2HSXU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-mzc1vP7FO1ahW6ilT4pyag-1; Sat, 13 Feb 2021 09:52:09 -0500
X-MC-Unique: mzc1vP7FO1ahW6ilT4pyag-1
Received: by mail-ed1-f72.google.com with SMTP id g6so2208732edy.9
        for <linux-pm@vger.kernel.org>; Sat, 13 Feb 2021 06:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l4ytx6mSORryC9/ckDkwUt9Y5elBZy+A8DMLR/SeLFA=;
        b=mPLwb9OwgKKJZPSA4aAshkvdr4Zwx+2LAvrYGK7eMCRyrWWMPfvPHUVL5B4GYULn+8
         cu+4riFBc2Cjtta2o88hIhmQ6PgjUVpW7XXClu96XUANRyFyYNuf4rpfk82AWEbK6gMh
         ZudM1SLNbgVNX2DpXoFUtuTTmTa9Pazbswe3dd6bchONIGA9ZRlBduPZDUeB7b0pI4di
         XB/TYt/R6/J7y+ipfSdITlsKgPbBEfS+XHQQ8V2qxK/azvj6NMXOBPVVPhTVCMQfRCDc
         W6+gZSI+luhXSUrhrYapeUhN6evEDhj/vOfqz7bkDRzb7F2b6Mt44Df51wHWxK6/ynab
         VbBQ==
X-Gm-Message-State: AOAM531yOyZiT9Qlz85RCrZt90u9StXRXxOfIuVV4gOkoyyt56afXVWO
        K9UDpJs5Hvnwi4WX3t2Y0vjwP/RwBCfe6j80dxWl5QFKPA/OMHlxqsCSNMVXRsoegBKmUCfltTo
        7BbhoA/M0kg34QxWzuec=
X-Received: by 2002:a17:907:9702:: with SMTP id jg2mr7971725ejc.48.1613227928320;
        Sat, 13 Feb 2021 06:52:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+usicOJdFKmvK0rRWYdbK1mDMpi9ZfQVA/OyFldns5N6tfGUHahQmjNCyMiVXxtGpFFsc3w==
X-Received: by 2002:a17:907:9702:: with SMTP id jg2mr7971712ejc.48.1613227928165;
        Sat, 13 Feb 2021 06:52:08 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id dk18sm7308096edb.92.2021.02.13.06.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Feb 2021 06:52:07 -0800 (PST)
Subject: Re: [RFC PATCH 1/7] drivers: base: Add resource managed version of
 delayed work init
From:   Hans de Goede <hdegoede@redhat.com>
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
 <eecf8ad6-a99d-8ad0-fc7e-f87d015add3f@redhat.com>
Message-ID: <529a5122-ff3a-2af0-52ed-b13216fa49d1@redhat.com>
Date:   Sat, 13 Feb 2021 15:52:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <eecf8ad6-a99d-8ad0-fc7e-f87d015add3f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2/13/21 3:38 PM, Hans de Goede wrote:
> Hi,
> 
> On 2/13/21 2:33 PM, Greg Kroah-Hartman wrote:

<snip>

> Having this new devm_delayed_work_autocancel() helper will allow a
> bunch of drivers to move away from mixing the 2, which is a good thing
> in my book.
> 
> As I said above I believe that having devm_delayed_work_autocancel() (1)
> in our toolbox will be a good thing to have. Driver authors can then choose
> to use it; or they can choose to not use it if they don't like it.
> 
> I know that the reason why I did not use it in the
> drivers/extcon/extcon-intel-int3496.c driver is because it was not available
> if it had been available then I would definitely have used it, as it avoids the
> mixing of resource-management styles which that driver is currently doing.
> 
> And I think that that is what this is ultimately about, there are 2 styles
> of resource-management:
> 
> 1. manual
> 2. devm based
> 
> And they both have their pros and cons, problems mostly arise when mixing them
> and adding new devm helpers for commonly used cleanup patterns is a good thing
> as it helps to get rid of mixing these 2 styles in a single driver.

I just noticed that I forgot to fill in the (1) footnote above:

1) And we probably will want one for non delayed work items to: devm_work_autocancel(),
but lets cross that bridge when we get there.

Also when reviewing: "[RFC PATCH 2/7] extconn: Clean-up few drivers by using managed work init"
I noticed that the extcon-qcom-spmi-misc.c and extcon-palmas.c follow the same standard
pattern of having an IRQ which queues a delayed work and they both miss the devm_free_irq
call before the cancel_delayed_work_sync() on driver release. So just patch 2/7 here
fixes 3 driver-release race conditions (fixing 3/4 drivers which it touches) as a
bonus to the code-cleanup which it does.

So as this clearly seems to be fixing a bunch of bugs, by simply completely removing the
buggy code driver remove callbacks, this really seems like a good idea to me.

Regards,

Hans

