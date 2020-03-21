Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1C618E505
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 23:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgCUWJE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 18:09:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34136 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgCUWJD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Mar 2020 18:09:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id z15so11912471wrl.1;
        Sat, 21 Mar 2020 15:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=2YkF1Hfiig3nQb5ErviFHuY07FA8xUVf81hUPHdsSZE=;
        b=evs5dSOess5x8vTSgfZvAyNxWhjxS6oKJ9Bv4FdklRR3SqbT/aT6lCtl3u3pO3snO5
         0Hm8RC1rcu8qE4/XDV5nDhf8jzeSduivdX32JamT5rCuS5zL5NLd2ORgIl5tqeSgFKq9
         ZqjTsBv9kXBn89HQsLIIP/zWAcMvDuKTuChkTEdIZWMsUJ8/W8J975bVt42OeiguYZm+
         HCx7AdjeZICD9cJou61IOXEYGY4qbqEu+P55A6t6yf160BKkR5k4mqPvDyqFoK9gKlTf
         6Gfu6RmddTTfUgnVr5mwW7o/Si7FCjL9cgbBt30A0jeH2wneUUvVAJaYp5Ag7lAxDHq5
         bCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=2YkF1Hfiig3nQb5ErviFHuY07FA8xUVf81hUPHdsSZE=;
        b=PBIEDdSlLQNaLjQjvEabsFjYMkpTgYFjcFs5KTJWILGsc0UFLHa5jV4cQOxgykmbLX
         //rMCC3vtYg2SawjWhgeTUicVz6LNskdBnMGDnmXNmKTmr0AM2eVTbwrDY5Yx/aLVSlp
         hwgwD+k4uIVAXnvS7l7jxTfPXKA0A9x7XgLTTPO0I6vZUxXa7onMT+/FXWwaxmgqq9eb
         uhhoaJaRV35tLTy9fI6AKG1mlinVSzX0fmKuNx9nje+2NGd1GRtodbNg/3jjI44KLDjo
         Q9Ku94Q8ooBtNVV6YsDN3pDW68v1YYu4UeH9cnFwpEPRJW4W0yGEW8VR1slmOUQONyZy
         YA2g==
X-Gm-Message-State: ANhLgQ1OKoQLizDJyHRb6sKT8AX9c4ILL6z9UZFdPF6EbAqZGzUKGE/8
        5o8tR6mb0BtnPAO5Eer/99c=
X-Google-Smtp-Source: ADFU+vteyJW1IFkxMyXB176ZoZzILyQrMXIwNQ95kwAr5F6WrlaLkY22gjVjofnjvlpo85ZnUVHKVg==
X-Received: by 2002:a5d:4b09:: with SMTP id v9mr18938284wrq.85.1584828541537;
        Sat, 21 Mar 2020 15:09:01 -0700 (PDT)
Received: from supervisor.net28 ([46.53.253.27])
        by smtp.gmail.com with ESMTPSA id b187sm14651307wmb.42.2020.03.21.15.09.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 21 Mar 2020 15:09:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To:     "Tony Lindgren" <tony@atomide.com>
Cc:     "Merlijn Wajer" <merlijn@wizzup.org>,
        "Pavel Machek" <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 06/15] power: supply: cpcap-battery: Initialize with user
 provided data
References: <20200315151206.30909-1-spinal.by@gmail.com>
 <20200315151206.30909-6-spinal.by@gmail.com>
 <20200321145405.GW37466@atomide.com>
Date:   Sun, 22 Mar 2020 01:08:59 +0300
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Arthur D." <spinal.by@gmail.com>
Message-ID: <op.0huns9h5hxa7s4@supervisor.net28>
In-Reply-To: <20200321145405.GW37466@atomide.com>
User-Agent: Opera Mail/12.16 (Linux)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi.

> Hmm I'm getting -EINVAL when I do echo 1600000 > charge_now but yet the
> value does get updated?

Hm. I'm getting "Permission denied" when trying to do this.
Anyway, charge_now value is not supposed to be initialized by the user.
Only charge_full should be writable.

> And I'm still not seeing capacity show up after that though even with  
> full battery.. I think we should be able to calculate it if either a  
> high or
> low value has been seen?

There are two steps needed to calibrate the battery: to hit the "fully  
charged"
state and to hit "battery empty" state. When the both states were hit the  
driver
will initialize charge_full value. And it will start reporting correct  
charge_now
and capacity (battery charge percentage) values.

Once the charge_full value is calculated it's recommended to be saved by  
the user
to a permanent storage between reboots.

Saving/restoring the value can be done in init scripts.

For saving the calibration value just use the command like:
cat /sys/class/power_supply/battery/charge_full > /battery_cf

To restore (after device reboot or power on):
cat /battery_cf > /sys/class/power_supply/battery/charge_full

This will allow the kernel to do fast calibration. I.e. you will
only need to fully charge _OR_ fully discharge the battery to start
seeing correct charge_now and capacity values.

> Also, we should have the driver default to using the charge_full_design
> value if nothing is written from userspace and we see a high or low  
> value.

I'd prefer to have charge_full value undefined until the battery is  
calibrated.
This way the userspace can estimate current battery capacity using voltage  
as a
fallback for uncalibrated battery. The voltage estimation will be  way more
accurate than having charge_full = charge_full_design on pretty old Droid 4
batteries. For example, my battery after calibration has about 1000 mAh,
while charge_full_design is 1740000.

> Maybe some pessimistic estimate could be used instead of just using
> charge_full_design if no value is initialized from the userspace?
> Something like (charge_full_design / 4) * 3 maybe?

It's better to rely on voltage estimated percentage.
In Maemo Leste we patched upower to use the following formula, which gives  
pretty
good results:

percentage = (voltage - voltage_empty) / (voltage_full - voltage_empty) *  
100

Actually, the formula we use is a bit more complicated.

If you're curious, here's how it's actually done:
https://github.com/maemo-leste/upower/blob/master/src/linux/up-device-supply.c#L756

--
Best regards, Spinal
