Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AF2452E14
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 10:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhKPJgj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 04:36:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233274AbhKPJgd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 04:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637055216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cp+iJp9i4ryXcYEsq7JrwWGaLxc1Aah1uRr7rdH93y0=;
        b=jF7ysspmqMGRMovvGljrtz58D7vv3N0VXb0S/d4TKmmtbSBILp7MFxYbhPZA4VLMTjpaWJ
        OTWMFVqMXCmxItI8SH91aq0io08lor/ljvc6EQTIIeljc0k5nXl4jFCEGgzzBMfl3624HA
        fxBgKWWdFaC5P97ifg4f8tVKac5mCBQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-55hqH5FOPTCUbPQvLz-ViA-1; Tue, 16 Nov 2021 04:33:35 -0500
X-MC-Unique: 55hqH5FOPTCUbPQvLz-ViA-1
Received: by mail-ed1-f72.google.com with SMTP id l15-20020a056402124f00b003e57269ab87so10003392edw.6
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 01:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cp+iJp9i4ryXcYEsq7JrwWGaLxc1Aah1uRr7rdH93y0=;
        b=jnVvCEJYHjysDOd75+AP8qkVnezaGcTHgrFbWNTTHqCGwCkSGRd2lrEARl1mQtCejH
         W0Mj9R0xV+crswiKuhuOw8eYmOHFyYssKs3d1BKTCMjU2CDb2rYBP08xvAyvqWcpo6XN
         iS7LWlx2x03VKN9DKaBBzRTm2ApgxOHrqrnnIoy8DpCyIvo+ThJIaN2/p380Mp8Yg1C2
         SZU+iqq2jWTm9esTYm8qYdFCDuIydPlweT18cRtctcE9S9Io8vY7mcjoGJvSluRhaelf
         aDi0MiKje6kRtZkvNT/lfKs9k4VZ7rxYcuPRxWB2K3FTOQYptiAsqMVIkflyEzVj99cC
         pJzg==
X-Gm-Message-State: AOAM532ZTAlkH8jhACfmospTf/DKKLMyBddU+DOdLm3crXVTvP7qp2Kl
        AlkenE3dxyqYnifOp+Ig1HEz1w+whsbfc+w0xd1iXHwMiGH0DNDw4WnXaGnXf2kVcMcHYxND1zC
        WnK8tbCnMB1U6XQaUooA=
X-Received: by 2002:aa7:c30e:: with SMTP id l14mr8284325edq.370.1637055214312;
        Tue, 16 Nov 2021 01:33:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZQ5qagfzDYQuhUC2t64EV/F/AOPWgKM5JWXb4ICFnVrOvU/v3eiYcU4LF5nMays3/4VeoLw==
X-Received: by 2002:aa7:c30e:: with SMTP id l14mr8284306edq.370.1637055214132;
        Tue, 16 Nov 2021 01:33:34 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ne33sm7972654ejc.6.2021.11.16.01.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 01:33:33 -0800 (PST)
Message-ID: <66fbed75-7b48-6d91-1ef5-5df1c075e91c@redhat.com>
Date:   Tue, 16 Nov 2021 10:33:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 10/20] power: supply: bq25890: Add
 bq25890_set_otg_cfg() helper
Content-Language: en-US
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
References: <20211114170335.66994-1-hdegoede@redhat.com>
 <20211114170335.66994-11-hdegoede@redhat.com>
 <YZIyQ1BdJ0v8QTtj@jeknote.loshitsa1.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YZIyQ1BdJ0v8QTtj@jeknote.loshitsa1.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Yauhen,

On 11/15/21 11:11, Yauhen Kharuzhy wrote:
> On Sun, Nov 14, 2021 at 06:03:25PM +0100, Hans de Goede wrote:
>> Add a bq25890_set_otg_cfg() helper function, this is a preparation
>> patch for adding regulator support.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/power/supply/bq25890_charger.c | 28 ++++++++++++++------------
>>  1 file changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
>> index 2bdfb58cda75..3c41fe86b3d3 100644
>> --- a/drivers/power/supply/bq25890_charger.c
>> +++ b/drivers/power/supply/bq25890_charger.c
>> @@ -801,6 +801,17 @@ static int bq25890_power_supply_init(struct bq25890_device *bq)
>>  	return PTR_ERR_OR_ZERO(bq->charger);
>>  }
>>  
>> +static int bq25890_set_otg_cfg(struct bq25890_device *bq, u8 val)
>> +{
>> +	int ret;
>> +
>> +	ret = bq25890_field_write(bq, F_OTG_CFG, val);
>> +	if (ret < 0)
>> +		dev_err(bq->dev, "Error switching to boost/charger mode: %d\n", ret);
> 
> Just a note: if a connected USB device has relative big capacitor
> at power wires inside, then a starting current pulse may be enough to
> overload the boost reguator and VBUS will not be powered. I met this
> at Yoga Book: the firmware set boost current limit to 1.4 A (default
> value for bq25892) but when USB hub connected, the BOOST_FAULT event
> appeared.
> 
> To avoid this, Lenovo uses following trick in its kernel: set a boost
> current limit to big value (2.1 A), wait some time (500 ms) and set
> the current limit to right value (1.4A). This provides enough current to
> charge capacitors in the connected device but saves desired long-time limit
> to prevent overloading if the device consumes too much power itself.

Right I saw this in your git repo, but I cannot reproduce the issue (1)
I was hoping that since you can reproduce this, that you can rebase
your fix on top of my patch-set ?

Also I'm wondering if this behavior should be the default, I believe
that the max. boost current may also be dependent on some external
factors, so maybe we should make this behavior conditional on a
new device-property ?

Regards,

Hans



1) I must admit I did not try really hard, I guess I could try an
USB powered hdd enclosure with a spinning disk

What device are you seeing this with?

