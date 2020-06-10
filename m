Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BA11F5636
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 15:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgFJNw0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 09:52:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36199 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbgFJNwW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2020 09:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591797140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YL2CUX+ytcqKztbtjkEaTAotWFK6JYYqCnPu2fBEOuA=;
        b=RNgBmriM4ahFUxcS7Fg9c2XAKyovRc1vbF3yWBevYkrsDtYMZYq+0YkfnznkHE7+87EJiz
        8cG3QCQqdrGNc0n8sVym0ptbpk5JY0AId2TxhStM8tX/tw86bzhGaE0OS+2A4XTehSFOHL
        SbVZ2Gna7dWtJJxjK6K+HwBkthAcMJ4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-0FTNmQL-NEKTIiSAlo656g-1; Wed, 10 Jun 2020 09:52:18 -0400
X-MC-Unique: 0FTNmQL-NEKTIiSAlo656g-1
Received: by mail-ed1-f71.google.com with SMTP id y5so676030edw.19
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 06:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YL2CUX+ytcqKztbtjkEaTAotWFK6JYYqCnPu2fBEOuA=;
        b=dN+2udXCYZcPc6utV+zW4w/Y1uqwxkBuYiylyXVYlF6mI53mj5BO7HAY9twZZYIKKy
         2SU1iWEUfqD9XsR2TPsdQ8mXfS5D8hby0XSnvaUM9nbqPnZbd8SHKdW5Jgcf98kEC0uc
         1wlSeNuQ3SCKrvfKZH2rz+4fbiCHWd0Omh/Npjxx114hJby3RBwt1fmD/IN07M358i1q
         36U5xHVAJiJu7c1qaC8R5KQshXBxAJA7xevb8OkyqokvXiZGfUqCudx6jjDhMZb7p93S
         rdn7wUbk6yoy2IL/e3DckwtR7AZLh8v9lcJsgPmv2ywI2nh3inGDBGwv6cnO52TpM6MB
         ESWA==
X-Gm-Message-State: AOAM530yuAYFYDFFCexSS+HxyDuiee7bt3UYTBoKW1pTleEv7oPqYBTF
        7aa6wFG1fY06DHwF8x5slbEgHYzxXuetDWdum7wHH390c9UPNYRIw0C1VeIt+Vm066uRZ61wWYA
        BESip/NIvBIet7Yz7tDw=
X-Received: by 2002:a50:b2e1:: with SMTP id p88mr2582799edd.198.1591797137517;
        Wed, 10 Jun 2020 06:52:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEJek1TXZYUkZ6pG2p869jbxR9ODYMKVkeJa1/sT8kaPG7Zk4zmYdct4EtD9GIM7FcH0rbNA==
X-Received: by 2002:a50:b2e1:: with SMTP id p88mr2582761edd.198.1591797137192;
        Wed, 10 Jun 2020 06:52:17 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id dm1sm16655504ejc.99.2020.06.10.06.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 06:52:16 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] Support inhibiting input devices
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        linux-input@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Collabora Kernel ML <kernel@collabora.com>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <964ca07a-3da5-101f-7edf-64bdeec98a4b@redhat.com>
 <CAJZ5v0hB2ra2K=dd9ZjVyy1V2b1PmFHm79uDO2HtHU1D_4YUbw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cd0dc625-c0bf-8322-fc31-c5eccb4be1cd@redhat.com>
Date:   Wed, 10 Jun 2020 15:52:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hB2ra2K=dd9ZjVyy1V2b1PmFHm79uDO2HtHU1D_4YUbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 6/10/20 12:38 PM, Rafael J. Wysocki wrote:
> On Wed, Jun 10, 2020 at 11:50 AM Hans de Goede <hdegoede@redhat.com> wrote:

<snip>

>> A different, but related issue is how to make devices actually use the
>> new inhibit support on the builtin keyboard + touchpad when say the lid
>> is closed.   Arguably this is an userspace problem, but it is a tricky
>> one. Currently on most modern Linux distributions suspend-on-lid-close
>> is handled by systemd-logind and most modern desktop-environments are
>> happy to have logind handle this for them.
>>
>> But most knowledge about input devices and e.g. heurisitics to decide
>> if a touchpad is internal or external are part of libinput. Now we could
>> have libinput use the new inhibit support (1), but then when the lid
>> closes we get race between whatever process is using libinput trying
>> to inhibit the touchpad (which must be done before to suspend to disable
>> it as wakeup source) and logind trying to suspend the system.
>>
>> One solution here would be to move the setting of the inhibit sysfs
>> attr into logind, but that requires adding a whole bunch of extra
>> knowledge to logind which does not really belong there IMHO.
>>
>> I've been thinking a bit about this and to me it seems that the kernel
>> is in the ideal position to automatically inhibit some devices when
>> some EV_SW transitions from 0->1 (and uninhibit again on 1->0). The
>> issue here is to chose on which devices to enable this. I believe
>> that the auto inhibit on some switches mechanism is best done inside
>> the kernel (disabled by default) and then we can have a sysfs
>> attr called auto_inhibit_ev_sw_mask which can be set to e.g.
>> (1 << SW_LID) to make the kernel auto-inhibit the input-device whenever
>> the lid is closed, or to ((1 << SW_LID) | (1 << SW_TABLET_MODE)) to
>> inhibit both when the lid is closed or when switched to tablet mode.
> 
> I agree that the kernel is the right place to handle this, but it
> requires some extra knowledge about dependencies between devices.
>
> It'd be kind of like power resources in ACPI, so for each state of a
> "master" device (in principle, there may be more states of it than
> just two) there would be a list of "dependent" intput devices that
> need to be inhibited when the "master" device goes into that state.

So a big part of the reason to punt the decision on which input
devices to enable this auto-inhibit is that we don't really have
information about those relationsships / device-links you are
suggesting here.  libinput is already doing inhibiting inside
userspace for e.g. the tablet-mode switch but it relies on heuristics
+ quirk tables to decide which keyboards should be inhibited and which
not.

E.g. for a 360 degree hinges 2-in-1 we want to disable the builtin
keyboard, when folded into in tablet mode, but not any external ones.

Mostly the builtin kbd will be PS2 but I have one such 2-in-1 here
in my home office with a USB kbd ...

In general of the master devices there will be only 1, there will be
only 1 lid switch and only 1 tablet-mode switch. So my idea with the
auto_inhibit_ev_sw_mask, is for it to be a per input-device setting.

So using your terms, all input devices with the (1 << SW_LID) bit
set in their auto_inhibit_ev_sw_mask will be dependents of the
(master) device which actually is reporting the SW_LID bit.

The idea here is for this to work the same as how the rfkill code
from net/rfkill/input.c works, except instead of binding e.g.
KEY_WLAN to toggling the sw-state of rfkill devices with a type
of RFKILL_TYPE_WLAN. This will bind SW_LID to inhibiting input
devices with the SW_LID bit set in their auto_inhibit_ev_sw_mask.

Regards,

Hans

