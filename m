Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD1F29956E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 19:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789879AbgJZSdk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 14:33:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1789873AbgJZSdj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 14:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603737217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rzN8xtO7O+TraWbLdrWrZIHELIhUQEP4fjr6CDKufA=;
        b=emae8Xe4NZ9DEXmQE3JchuAQyGfTifoOwm5HYsj2m9lDI3aV6bnMlrLl7Cvk9DJwXZupmU
        C/+EdNo2trRyOYFbytMhIOj3eEqjP6ASW5HdOdWWMQCoKm0tkBbwZqxUJg1LLy8/2xy2yx
        d11XviJWbcyg2mzC0OqS3xQusEWRj1I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-e0xD8ADHO22J6RgXr0x4MQ-1; Mon, 26 Oct 2020 14:33:34 -0400
X-MC-Unique: e0xD8ADHO22J6RgXr0x4MQ-1
Received: by mail-ed1-f70.google.com with SMTP id dm20so5132738edb.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 11:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5rzN8xtO7O+TraWbLdrWrZIHELIhUQEP4fjr6CDKufA=;
        b=V+zUzhLbx49yPQSGgk1sf7nZRAWu0TSaeG3i9mqYocES2W+rje82WUUbGWyXa51tQ/
         v4UWY0cwDPxiryty/k/he9MjNO5woCsbxlwR5BmD4U0JozG986KsV/W47tSJdce8A68O
         AJ4HaLxUFPWSGrYFS7gf2t/7d+wILJoVgWKnuaq0V6qcFk7DJCks9l0/T57GJJPkJ7oI
         gW4O5oIpqDGj7xhC2c0eVZNnmunPIhw6BOw6mVSzpDYiAgHgCX8z57bBbspAgNVJriq/
         nfH/RknIpUdXSug6essPjItlG5likgP8/mOugAQyFY/254MktOW5U8NItUv82DG8pxQs
         BECQ==
X-Gm-Message-State: AOAM532aVKRXvnUeo3+zrDEoaBxZXH/nljBZJiME1QRNb98mnyWzHKUG
        hBnyPVY/JbVkpqN6CoNz1qCCbI7XrBtlZgteMkTEuyXopwju5dOGjUIjW9Kcbbmd0XIcgGcNdaK
        xKC4rRHY32BBbRYaEw54=
X-Received: by 2002:a05:6402:1c10:: with SMTP id ck16mr17381976edb.7.1603737213425;
        Mon, 26 Oct 2020 11:33:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgs/35k+Brq5u2rCEN7QCpoBhRml+MyHEqCOWMYIC3NLU3vtjWplyuJHBtZKOX0+eErQdY/A==
X-Received: by 2002:a05:6402:1c10:: with SMTP id ck16mr17381949edb.7.1603737213185;
        Mon, 26 Oct 2020 11:33:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id mc4sm6333155ejb.61.2020.10.26.11.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:33:32 -0700 (PDT)
Subject: Re: [PATCH] [RFC] Documentation: Add documentation for new
 platform_profile sysfs attribute
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     dvhart@infradead.org, mgross@linux.intel.com,
        mario.limonciello@dell.com, eliadevito@gmail.com,
        hadess@hadess.net, bberg@redhat.com, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <markpearson@lenovo.com>
 <20201026174444.866545-1-markpearson@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3c850d5a-75e6-4238-74fe-610ed9860abc@redhat.com>
Date:   Mon, 26 Oct 2020 19:33:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026174444.866545-1-markpearson@lenovo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mark,

Thank you for this new version.

On 10/26/20 6:44 PM, Mark Pearson wrote:
> From: Hans de Goede <hdegoede@redhat.com>
> 
> On modern systems the platform performance, temperature, fan and other
> hardware related characteristics are often dynamically configurable. The
> profile is often automatically adjusted to the load by somei
> automatic-mechanism (which may very well live outside the kernel).
> 
> These auto platform-adjustment mechanisms often can be configured with
> one of several 'platform-profiles', with either a bias towards low-power
> consumption or towards performance (and higher power consumption and
> thermals).
> 
> Introduce a new platform_profile sysfs API which offers a generic API for
> selecting the performance-profile of these automatic-mechanisms.
> 
> Co-developed-by: Mark Pearson <markpearson@lenovo.com>
> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../ABI/testing/sysfs-platform_profile        | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
> new file mode 100644
> index 000000000000..37cb6275946c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform_profile
> @@ -0,0 +1,85 @@
> +Platform-profile selection (e.g. /sys/firmware/acpi/platform_profile)
> +
> +On modern systems the platform performance, temperature, fan and other
> +hardware related characteristics are often dynamically configurable. The
> +profile is often automatically adjusted to the load by some
> +automatic-mechanism (which may very well live outside the kernel).
> +
> +These auto platform-adjustment mechanisms often can be configured with
> +one of several 'platform-profiles', with either a bias towards low-power
> +consumption or towards performance (and higher power consumption and
> +thermals).
> +
> +The purpose of the platform_profile attribute is to offer a generic sysfs
> +API for selecting the platform-profile of these automatic-mechanisms.
> +
> +Note that this API is only for selecting the platform-profile, it is
> +NOT a goal of this API to allow monitoring the resulting performance
> +characteristics. Monitoring performance is best done with device/vendor
> +specific tools such as e.g. turbostat.
> +
> +Specifically when selecting a high-performance profile the actual achieved
> +performance may be limited by various factors such as: the heat generated
> +by other components, room temperature, free air flow at the bottom of a
> +laptop, etc. It is explicitly NOT a goal of this API to let userspace know
> +about any sub-optimal conditions which are impeding reaching the requested
> +performance level.
> +
> +Since numbers are a rather meaningless way to describe platform-profiles
> +this API uses strings to describe the various profiles. To make sure that
> +userspace gets a consistent experience when using this API this API
> +document defines a fixed set of profile-names. Drivers *must* map their
> +internal profile representation/names onto this fixed set.
> +
> +If for some reason there is no good match when mapping then a new profile-name
> +may be added. Drivers which wish to introduce new profile-names must:
> +1. Have very good reasons to do so.
> +2. Add the new profile-name to this document, so that future drivers which also
> +   have a similar problem can use the same new.

s/same new/same name/

> + Usually new profile-names will
> +   be added to the "extra profile-names" section of this document. But in some
> +   cases the set of standard profile-names may be extended.

With the change from a more generic API to this new one more targeted towards DPTF
I would drop this part.


> +
> +What:		/sys/firmware/acpi/platform_profile_choices
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Reading this file gives a space separated list of profiles
> +		supported for this device.
> +
> +		Drivers must use the following standard profile-names whenever
> +		possible:
> +
> +		low-power:		Emphasises low power consumption
> +		quiet:			Offers quieter operation (lower fan
> +					speed but with higher performance and
> +					temperatures then seen in low-power

I think the description here is a bit too specific, this may cause userspace
to have expectations which are not necessary true. I would describe this as
just:

		quiet:			Emphasises quieter operation

> +		balanced:		Balance between low power consumption
> +					and performance
> +		performance:		Emphasises performance (and may lead to
> +					higher temperatures and fan speeds)
> +
> +		Userspace may expect drivers to offer at least several of these
> +		standard profile-names! If none of the above are a good match
> +		for some of the drivers profiles, then drivers may use one of
> +		these extra profile-names:
> +		<reserved for future use>
> +
> +What:		/sys/firmware/acpi/platform_profile
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Reading this file gives the current selected profile for this
> +		device. Writing this file with one of the strings from
> +		available_profiles changes the profile to the new value.

The part about custom profiles below may be dropped. That was intended for use
with e.g. GPUs but since this now strictly is a system-level profile API, the
part below can be dropped now.


> +
> +		Reading this file may also return "custom". This is intended for
> +		drivers which have and export multiple knobs. Such drivers may
> +		very well still want to offer a set of profiles for easy of use
> +		and to be able to offer a consistent standard API (this API) to
> +		userspace for configuring their performance. The "custom" value
> +		is intended for when ai user has directly configured the knobs
> +		(through e.g. some advanced control-panel for a GPU) and the
> +		knob values do not match any of the presets represented by the
> +		platform-profiles. In this case writing this file will
> +		override the modifications and restore the selected presets.
> +
> 

Regards,

Hans

