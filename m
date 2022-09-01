Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E9B5A9BA2
	for <lists+linux-pm@lfdr.de>; Thu,  1 Sep 2022 17:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiIAP2V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Sep 2022 11:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiIAP1s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2022 11:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B0C8769D
        for <linux-pm@vger.kernel.org>; Thu,  1 Sep 2022 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662046053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MRBNC1HE2yF6yx84dT5sACeASdUIpsotFUSThdag6so=;
        b=dDioY6qy/H6Q3Uwe3XRMwFe5q1kKoT//MC9VW9vkSxlG/Ud/5u/PAuV0ECLee1WCPNibpa
        h52Q/7bM+hEbkYtbUVhSLn36MTc1pNfYxDZjNIe8ST+9p7990YtS2tflA5G6UdfKHyBzIz
        PFQaXtsFXqGryt+plLp6qtn5qdoZwQk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-103-QFYOurGqPlOg6BzhcraS4Q-1; Thu, 01 Sep 2022 11:27:32 -0400
X-MC-Unique: QFYOurGqPlOg6BzhcraS4Q-1
Received: by mail-ej1-f71.google.com with SMTP id hs4-20020a1709073e8400b0073d66965277so6915174ejc.6
        for <linux-pm@vger.kernel.org>; Thu, 01 Sep 2022 08:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MRBNC1HE2yF6yx84dT5sACeASdUIpsotFUSThdag6so=;
        b=MLqbJ3XeUSDSJ9cGdMApey0QMapxmJOCUFOmelUBAl87+Wvas5AV2iGWtRrTCZlqDW
         SFUvBDihGpRhLxv2qSbjAQnWIa8AccgYrfUYfB6NYHzFOYTuZXj/C9WSAWfFA0fFV3p1
         CrQ3PZdlRlPyVbr+nJU4bgSKJHD8I5suSsGfAXM8oxDXFAcpfWSCxifVL9XeT9xGqLhm
         yoPUJ9N6IvBnqdz5Hi6XqbSYBeSowLVdS2UcZwIPaCfj+cSSwVOkCsk4lraImPL8eQgN
         hVkXrk7e5NyRMvAop8PIqUL2TkFhWR3OlGnbWxSZXMWjalNReaI0+Fu/nLd59m6XAn6T
         z1ug==
X-Gm-Message-State: ACgBeo3/HDWKFObQZCRoBPwZuDtYFKcy/telspvJLdGoajtiFWtY1Dlf
        +B6aqLoui7jgTAMNVuUfDXx5DxT+fKU3807yOrK0bpzGj2eI5rI5wb1CHCqPFipPn6/dON+bBoH
        RLjyximu6I82gbN7wmPg=
X-Received: by 2002:a17:907:60c7:b0:731:2be4:f72d with SMTP id hv7-20020a17090760c700b007312be4f72dmr24297900ejc.639.1662046051205;
        Thu, 01 Sep 2022 08:27:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6lZW+mGGW08k3rbm7xIpUM2bRXeAt5QvzQT5Q+B4KnUEHhTriAIHv4Fm+fWH97djKSuNGshw==
X-Received: by 2002:a17:907:60c7:b0:731:2be4:f72d with SMTP id hv7-20020a17090760c700b007312be4f72dmr24297884ejc.639.1662046050952;
        Thu, 01 Sep 2022 08:27:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 8-20020a170906328800b007414152ec4asm7661014ejw.163.2022.09.01.08.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 08:27:30 -0700 (PDT)
Message-ID: <13da9fe4-ee2b-24b1-093b-28017ecc9818@redhat.com>
Date:   Thu, 1 Sep 2022 17:27:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/3] platform/x86: Battery charge mode in toshiba_acpi
Content-Language: en-US
To:     Arvid Norlander <lkml@vorpal.se>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Azael Avalos <coproscefalo@gmail.com>
References: <20220828192920.805253-1-lkml@vorpal.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220828192920.805253-1-lkml@vorpal.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Arvid,

On 8/28/22 21:29, Arvid Norlander wrote:
> This is an improved version of the battery charge control for Toshiba
> Satellite Z830. The full background is available in the two emails linked
> below, but a short summary will follow, including only what is relevant
> for battery charge control.

Thank you for your work on this.

Overall 3 patches look good to me.

Sebastian, any chance you could take a look at patch 3/3
and maybe give me an ack for merging that through the pdx86
tree ?   (assuming you are ok with it)


2 small remarks about patch 2/3:

Remark 1:

+	rval = toshiba_battery_charge_mode_set(toshiba_acpi,
+					       (value < 90) ? 1 : 0);

Playing Devil's advocate here: to a casual reader this looks
a bit weird, why would I want to enable "charge mode"
(whatever that is).

IMHO it would be better to call the set (and get) function something
like e.g.:  toshiba_battery_set_eco_charge_mode()  So basicaly
add "eco" somewhere in the name. IIRC that is what Toshiba themselves
use right ?  I think that makes the meaning of the mode being 0 vs
it being one more clear.

That and/or add an enum for the 0/1 values and use the enum instead,
the enum could e.g. look something like this:

enum {
	TOSHIBA_CHARGE_FULL_CHARGE,
	TOSHIBA_CHARGE_ECO_MODE,
};

Note either of the suggested changes would be enough to make
the code more clear. Also this and especially the suggested
names are just a suggestion.


Remark 2:

+static int toshiba_acpi_battery_add(struct power_supply *battery)
+{
+	if (toshiba_acpi == NULL) {
+		pr_err("Init order issue\n");
+		return -ENODEV;


This will never happen. The hook is only registered when
toshiba_acpi != NULL and it will get unregistered before
toshiba_acpi gets set to NULL on remove.

+	}
+	if (!toshiba_acpi->battery_charge_mode_supported)
+		return -ENODEV;

If toshiba_acpi->battery_charge_mode_supported == false then
the acpi_battery_hook battery_hook will never get registered
and thus this will never get called.

+	if (device_add_groups(&battery->dev, toshiba_acpi_battery_groups))
+		return -ENODEV;
+	return 0;
+}

So you really only need the device_add_groups() which should never
faill and if it does fail then propagating the actual error would
be better.

So all in all IMHO this function can be simplified to just:

static int toshiba_acpi_battery_add(struct power_supply *battery)
{
	return device_add_groups(&battery->dev, toshiba_acpi_battery_groups);
}


Regards,

Hans







> 
> 
> Background (from link 1)
> ==========
> 
> The Toshiba Satellite/Portege Z830 supports not charging the battery fully
> in order to prolong battery life. Unlike for example ThinkPads where this
> control is granular here it is just off/on. When off it charges to 100%.
> When on it charges to about 80%.
> 
> According to the Windows program used to control the feature the setting
> will not take effect until the battery has been discharged to around 50%.
> However, in my testing it takes effect as soon as the charge drops below
> 80%. On Windows Toshiba branded this feature as "Eco charging"
> 
> In the following example ACPI calls I will use the following newly defined
> constants:
> #define HCI_BATTERY_CHARGE_MODE 0xba
> #define BATTERY_CHARGE_FULL 0
> #define BATTERY_CHARGE_80_PERCENT 1
> 
> To set the feature:
>   {HCI_SET, HCI_BATTERY_CHARGE_MODE, charge_mode, 0, 0, 0}
> To query for the existence of the feature:
>   {HCI_GET, HCI_BATTERY_CHARGE_MODE, 0, 0, 0, 0}
> To read the feature:
>   {HCI_GET, HCI_BATTERY_CHARGE_MODE, 0, 0, 0, 1}
> 
> The read may need to be retried if TOS_DATA_NOT_AVAILABLE is returned as
> the status code. This rarely happens (I have never observed it on Linux),
> but I have seen it happen under Windows once, and the software did retry
> it.
> 
> 
> Improvements
> ============
> 
> As discussed in link 2 & 3 below, the original approach was suboptimal.
> 
> This patch series instead consists of two patches.
> 
> The first patch implements detecting the feature as well as internal
> getter/setter methods.
> 
> The second patch adds battery hooks (heavily based on the code for this in
> thinkpad_acpi) which creates the standard charge_control_end_threshold file
> under /sys/class/power_supply/BAT1.
> 
> Side note: There is no BAT0 on this Toshiba, I'm not sure why the numbering
> ends up starting from 1 instead of 0 here. This differs from my Thinkpads,
> where the numbering starts from 0, with BAT1 being the second battery.
> However, I haven't spent much effort investigating this, as it did not seem
> important.
> 
> Patch 3 updates the ABI test documentation as suggested by Hans de Goede.
> Note that only the charge_control_end_threshold is updated, as this is the
> only limit supported by the Toshiba Z830. Possibly
> charge_control_start_threshold should also be updated similarly, or would
> it be better to wait for an actual example of this in the wild first?
> 
> Link (1): https://www.spinics.net/lists/platform-driver-x86/msg34314.html
> Link (2): https://www.spinics.net/lists/platform-driver-x86/msg34354.html
> Link (3): https://www.spinics.net/lists/platform-driver-x86/msg34320.html
> 
> Arvid Norlander (3):
>   platform/x86: Battery charge mode in toshiba_acpi (internals)
>   platform/x86: Battery charge mode in toshiba_acpi (sysfs)
>   docs: ABI: charge_control_end_threshold may not support all values
> 
>  Documentation/ABI/testing/sysfs-class-power |   5 +-
>  drivers/platform/x86/toshiba_acpi.c         | 162 ++++++++++++++++++++
>  2 files changed, 166 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555

