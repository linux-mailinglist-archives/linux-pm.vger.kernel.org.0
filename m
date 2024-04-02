Return-Path: <linux-pm+bounces-5807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A68951F9
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 13:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06E21C2285C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 11:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6913965BD1;
	Tue,  2 Apr 2024 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJvXdfvh"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9259A1F619
	for <linux-pm@vger.kernel.org>; Tue,  2 Apr 2024 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057809; cv=none; b=DY6RkehWjzkl6zKXi7V4zlmTgM4lbEyzD8XBJjHHpWyiktLmblLvbI3p/ycooKalByDpAHY7C3bwsIdK3w6RHSiLAN+dYGPbkpp8spIUjOioPGz2xHuK7Refn0IweoKLRQSe5LID7mIakYlT6aCPLtE6t4goiNAONoUTLyK+ShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057809; c=relaxed/simple;
	bh=MPqhH4oVJKEVbY3HV4Zqgwg0+ZDYLgfB3Q23f3RsGk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCYegcsO6++BnSXvvJHpeU+RyZb/eM01hTQQWduvv7yRq9GZFW2eMWKaanaNRIGTmJIrHKJvK1zMLXM8Nu6ZERfw8+g7g7r7Lpei6JDWX6Za1MapxEOdw7FgEWQPUtCjsGszn/4/XOyj5AJQ8ftfG0/5BnHjf8UqjDpf/n4CtLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJvXdfvh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712057806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IV3WfH/O72HH8lAtgEOs7RmA/oZj1+zsmGqnJChmHR8=;
	b=gJvXdfvhoo0hsPiAmXFqaSj/aq23QSSQNHcYjnbUffkb8iAiRU8OUm2NnGD213x/VLOEoV
	DAPzsvSZZPWfN+fl9XWfNBXVMB2miE7RKl8fbnCKZfTKEMJ47No6HRKDGuQmxVtf95nfvv
	q8rqUnAteZPf4V4bBEpXJGxvon+79is=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-RN_LU_zJMY6v6GUn9KCzmw-1; Tue, 02 Apr 2024 07:36:45 -0400
X-MC-Unique: RN_LU_zJMY6v6GUn9KCzmw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a474bf2839dso78681866b.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Apr 2024 04:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712057804; x=1712662604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IV3WfH/O72HH8lAtgEOs7RmA/oZj1+zsmGqnJChmHR8=;
        b=JnbnbeEdhK9Ff39ll3x9BouuGBRbGeb1DpFwRJ540HIt0zlvLx1vXp/hJgB98RZyy/
         c6+ck0SP34VCrAODXFS9nfx/IhnXrZESvoYpL6CURdDcEEn95o0o6mfVwb8Kzw8DmjmC
         KZn5grTN1OobGmYqUVd/PcqpbdqLqsoIcHprAAhD6NYGb0cEe1F6k6y3GFfZXsdGQGjt
         yAFgjPCPusI7PhWvzvRypDxwNQZgfo8PXcb93AyIdBwkyPBWvQA6Qk4V857i6RVIJz/A
         qVFnUDQxCxwyhlAJmh7q1Hdvh8joatas2U8oxUvReC/JPcvLJm85l2wmiGkZvY/o8RsN
         rK7g==
X-Forwarded-Encrypted: i=1; AJvYcCULpW+udu6PwQDCBKKU5Du4zyMR2cYDGln5IULa9GUTUfwmDR2UKObU14D+snsqas+zgDjFEDGXlyQfe5FFselo16p5iItDG0o=
X-Gm-Message-State: AOJu0YwUrey22sNzqYl1+RzkSfqK99mvYGIExbt7/F7AQbA8UX9UmfzD
	u1rXlMTGkKAHoSFVPdVyUgM7x3h/v5c1spvykZrRBnShmsLKtf/Cn23cLdRXxhZaPklQLwCYKAJ
	p03F6mA1oPQYVNcdaMXLpbZeGrvcVdsgbfgDI5jpOVnUNzPYfyNBY8+j9
X-Received: by 2002:a50:c34e:0:b0:566:b09e:8d24 with SMTP id q14-20020a50c34e000000b00566b09e8d24mr1196112edb.12.1712057804095;
        Tue, 02 Apr 2024 04:36:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQbFni9zObgPoWcOLp8+07dCay4mZL+uKOB9ksx/s3qoD0ZCggDdwS6HFktGmtS9C9sOT8jw==
X-Received: by 2002:a50:c34e:0:b0:566:b09e:8d24 with SMTP id q14-20020a50c34e000000b00566b09e8d24mr1196091edb.12.1712057803767;
        Tue, 02 Apr 2024 04:36:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l12-20020a056402230c00b005693985c35dsm6700104eda.36.2024.04.02.04.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 04:36:43 -0700 (PDT)
Message-ID: <ed891842-a86f-4ca8-af29-f7921a259146@redhat.com>
Date: Tue, 2 Apr 2024 13:36:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] platform/x86/intel/hid: Don't wake on 5-button
 releases
Content-Language: en-US, nl
To: David McFarland <corngood@gmail.com>, linux-pm@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Enrik Berkhan <Enrik.Berkhan@inka.de>
References: <20240318191153.6978-1-corngood@gmail.com>
 <20240318191153.6978-2-corngood@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240318191153.6978-2-corngood@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David,

Thank you for your patch.

I became aware of this patch because the discussion on the regressions
list. Next time for patches to files under drivers/platform/x86/
at a minimum please Cc: platform-driver-x86@vger.kernel.org and
preferably also send the patch directly to me and Ilpo as shown
by get_maintainer.pl:

[hans@shalem linux]$ scripts/get_maintainer.pl -f drivers/platform/x86/intel/vbtn.c
AceLan Kao <acelan.kao@canonical.com> (maintainer:INTEL VIRTUAL BUTTON DRIVER)
Hans de Goede <hdegoede@redhat.com> (maintainer:X86 PLATFORM DRIVERS)
"Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com> (maintainer:X86 PLATFORM DRIVERS)
platform-driver-x86@vger.kernel.org (open list:INTEL VIRTUAL BUTTON DRIVER)
linux-kernel@vger.kernel.org (open list)

Please make sure you are sending this to the right people for v2.

On 3/18/24 8:11 PM, David McFarland wrote:
> If, for example, the power button is configured to suspend, holding it
> and releasing it after the machine has suspended, will wake the machine.
> 
> Also on some machines, power button release events are sent during
> hibernation, even if the button wasn't used to hibernate the machine.
> This causes hibernation to be aborted.
> 

As discussed by Thorsten this needs a fixes tag, to help with backporting
it to relevant stable kernels. Also for v2 please don't forget to add
Enrik's Tested-by from elsewhere in thread:

Tested-by: Enrik Berkhan <Enrik.Berkhan@inka.de>



> Signed-off-by: David McFarland <corngood@gmail.com>
> ---
>  drivers/platform/x86/intel/hid.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
> index 7457ca2b27a6..707de9895965 100644
> --- a/drivers/platform/x86/intel/hid.c
> +++ b/drivers/platform/x86/intel/hid.c
> @@ -504,6 +504,7 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
>  	struct platform_device *device = context;
>  	struct intel_hid_priv *priv = dev_get_drvdata(&device->dev);
>  	unsigned long long ev_index;
> +	struct key_entry *ke;
>  	int err;
>  
>  	/*
> @@ -545,11 +546,16 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
>  		if (event == 0xc0 || !priv->array)
>  			return;
>  
> -		if (!sparse_keymap_entry_from_scancode(priv->array, event)) {
> +		ke = sparse_keymap_entry_from_scancode(priv->array, event);
> +

I would prefer for there to be no empty line between the "ke =" assignment
and the "if (!ke)".

Otherwise the patch looks good to me, so for v3
you can add:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

After fixing this + adding the Fixes and Tested-by tags.

Regards,

Hans




> +		if (!ke) {
>  			dev_info(&device->dev, "unknown event 0x%x\n", event);
>  			return;
>  		}
>  
> +		if (ke->type == KE_IGNORE)
> +			return;
> +
>  wakeup:
>  		pm_wakeup_hard_event(&device->dev);
>  



