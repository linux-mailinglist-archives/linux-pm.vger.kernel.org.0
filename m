Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74DF18614E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 02:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgCPBaQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 21:30:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50618 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgCPBaQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 21:30:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id a5so15879221wmb.0;
        Sun, 15 Mar 2020 18:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=khe4KFBHWIvVlXCYbcMcXc8nhkO4avLgz0CPmf17M5Q=;
        b=kt2T6xGVcQouz1eJTSgdGpraxyjZgHRVpAFhL+9UK6pUJi/LxoePPqeVUbCplhqHbv
         rUTlv4zEaWQb7X1wykqSZA79Q+wK5fBYIufqTjjkwwKTDIVpJzWTN09CAo87JUx2Qenf
         xKIefbR6E7djE8A7us5AgAm9a4yJ7HiU87HYbkmcfrCK3HG8cl1zi8C4Y1zbPrS3li7b
         EaOWnH2F+bt9KUo/ceH4LzOLLH82d0mSvLOUcm0alwywaijcHP74WjiYrXWIihNpSsrQ
         rZoRyoJ6tnKD642zecXqjlzhNhsQz51SM1I7S+ySN08E8Bii9b6izJRHMnpHxiw54fue
         RGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=khe4KFBHWIvVlXCYbcMcXc8nhkO4avLgz0CPmf17M5Q=;
        b=K/uWWrmmRa2LBdVChQ1dkfwrv8pjkmEr3uRnlysmk8W5y41EpPiXiB3K3oBLXksG+l
         IharAxfUyWUVYGG1f84/QFuGtAx4nIUP/CY8vzFkx3F8NS2b1msykCIZPHLRzDuvCN/Q
         0eltO1I3KvhI1/e4LZsNe13X282Gor0ZQ/F7bfvGBrRySqqV0kIr7HJhqp54w/kz/k2R
         IfxgnCfOPNzQAyhs/RNJCxcdym+hGti+13fYWSNhF40Xj1cCjDnrtrrNFUdNOUS3z/e5
         kaN4ztllEpN3w8GhCIybEBwP77WKhFH4C7jErDDCOfA10Ht70a8/0pNZjMoOJJVlHSu/
         Sycw==
X-Gm-Message-State: ANhLgQ2j4w+IHZyhlZTRNrSLQdpvRICFrIFPaJyj3rzw9Ww2DI17sLs6
        3RCItc9xPjIqJgmItYo7q8o=
X-Google-Smtp-Source: ADFU+vu+2lwO/tEkZx52yGdLG/1jzSEekhIbcki43t41egXIEdiqD8fQSotzRh6OvTS8fQvuL4X3Ng==
X-Received: by 2002:a05:600c:410b:: with SMTP id j11mr25275005wmi.86.1584322212681;
        Sun, 15 Mar 2020 18:30:12 -0700 (PDT)
Received: from supervisor.net28 ([46.53.248.79])
        by smtp.gmail.com with ESMTPSA id q13sm40015063wrs.91.2020.03.15.18.30.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 15 Mar 2020 18:30:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To:     "Tony Lindgren" <tony@atomide.com>
Cc:     "Pavel Machek" <pavel@ucw.cz>,
        "Merlijn Wajer" <merlijn@wizzup.org>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 01/15] power: supply: cpcap-battery: Fix battery full
 status reporting
References: <20200315151206.30909-1-spinal.by@gmail.com>
 <20200315185857.GA4914@amd> <op.0hjf7fb5hxa7s4@supervisor.net28>
 <20200315215949.GK37466@atomide.com>
Date:   Mon, 16 Mar 2020 04:30:10 +0300
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Arthur D." <spinal.by@gmail.com>
Message-ID: <op.0hjs4kk2hxa7s4@supervisor.net28>
In-Reply-To: <20200315215949.GK37466@atomide.com>
User-Agent: Opera Mail/12.16 (Linux)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Tony.

It seems like a misunderstanding here. There's no problem in detecting
if the charging is in progress. The green led is switched off and
the battery current sign is changed from "-" to "+" (which means
that the battery is being discharged). So there's no need in additional
checks. For cpcap-battery this situation seems like a battery stopped
charging. And it doesn't matter if that was a user who disconnected
the charger or it was done somewhere in a driver/firmware/hardware.

The problem is that the charging current cant get to the point <100 mA,
not talking about <50 mA. And that's why I set the value of 112 mA for
the end of charge current: to help the kernel to detect this plateau and
to stop the calibration cycle, so the userspace can get all the battery
parameters I mentioned in the previous mail.

Please note, that the behaviour I mentioned was observed only when the
conditions written in my last mail were met. The important one was:
> 2) the display backlight is off

Because when I unlocked the display the charging current was able
to go below 112 mA. Of course I couldn't rely on something like this:
the user should stay with backlight on to have the battery calibrated.
Think about it: waiting for the charging current to drop from 100 mA
to 50 mA can take dozens of minutes (it depends on the age of battery -
the older the battery the longer it will take), and the user should
force somehow the device to not switch off the display hightlight
until the battery is calibrated.

Of course it's unacceptable, so I decided to set the end of charge
current limit to 112 mA. Which allows the user to just put the device
on a table and to wait until it's fully charged without a need
to interfere the charging process with some action from the user.

--
Best regards, Spinal


>> Now about the chosen limits. For some reason the charging is
>> interrupted (and restarted after a while) when the following
>> conditions are met:
>> 1) the charging current is < 112 mA
>> 2) the display backlight is off
>>
>> This behaviour was observed in Maemo Leste with hildon-desktop
>> running. I tested these patches for several days, so I picked up
>> the parameters for optimal (from my point of view) work in practice
>> taking into account the current "features" of Droid 4 drivers.
>>
>> If we could somehow fix this behaviour (charging interruption),
>> I'd reconsider the end of charge current value to be 50 mA.
>
> Hmm well we do have two chargers, the usb charger and the
> unknown inductive charger for the pins on the back.
>
> It would be best to keep cpcap-battery.c independent of the
> chargers to avoid depndencies as the chargers do usually start
> charging briefly always when connected.
>
> Maybe just adding something like below would be enough of a check:
>
> static int
> cpcap_battery_get_counter_rate(struct cpcap_battery_ddata *ddata,
> 			       int poll_time_ms);
>
> And then based on the value being negative or positive you
> would know if it's charging or not. I guess we could then
> use this also for POWER_SUPPLY_PROP_CHARGE_NOW with poll_time_ms
> value of 0. I think the charge counter is configure to poll
> at 250 ms right now.
