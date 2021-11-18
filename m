Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF60456580
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 23:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhKRWQ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 17:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhKRWQ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 17:16:58 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E316C061574
        for <linux-pm@vger.kernel.org>; Thu, 18 Nov 2021 14:13:58 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so5970465wme.4
        for <linux-pm@vger.kernel.org>; Thu, 18 Nov 2021 14:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=tZl2BN55c9nxvN98+IIn8ra567E4ddOU9gxhiJKnjZ4=;
        b=RCvJUJZm2FtNYHDP4bhbw14jPuqAPAqC280nrvc+vDEF7cUGY4g35nU4hKnBhHU3cO
         IxPGaUKEw4RIRTzcsXdBDExdFyqeNJLA2XLbD/2wK5rsv0IehkEBQRGzekcDyjJRRapw
         cNWwMHOTyEnxMdkfxnjg+NL+RMNtl0FF2BOzARCywGZ5dbI4UdthJFXNnUo3PQpjgtac
         wEyNj0L8+2CuLIS8IKL0EqR4aU4S03CYwpjmxCy7avLkq6tIyBGQEGhTX4D1wzvv1+Pe
         1N8LcnCVOt38YFOTO8IhazZxGB1KOPvl+GoLtg4hip1v74gfvimSxA0PSgM7cE7f/HR4
         JBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=tZl2BN55c9nxvN98+IIn8ra567E4ddOU9gxhiJKnjZ4=;
        b=6n/RJXLdGdPJxi1/I51ADW5zfYbYYOeLvbie007tJFjv6t6XU0VNBQi7yZQ5stFnmV
         FrBCcea82CzHIfgR8A6UM+dLV/jnNbRudQdnQdr83cotn7HEJWMfQuKYYBQapfqwEMTg
         Q1+9SbzayOjxKlu4twEi7Y2Pq5js6sdGXbCYe7hyKYoLlnCZEtycqETEDoi9VfGFvrml
         HJMATUweXen8O5vmjAE4RAuwLn58m2+MFejevYs4CuVeqcCWZ1jYYYhOQHyVWQHWMs73
         dbdpWnGKGTKTAYn9Lo4r72YoVaNLBlEIyTtYrT+yuub0LvTDdUixPz79bCG2BwQumvxK
         MMMA==
X-Gm-Message-State: AOAM531zuY1kYCMSaQTuroev/Y0Iy607DTDRlVyLJeUnMIb2dTHA1E2O
        xOtgOdqcSoqs8DbWWlDEeMY=
X-Google-Smtp-Source: ABdhPJyfx4zsZAdKEmZFB/+BHjEh/dN07fNPVH81OesgGKkTZrxc3uHxCpsZhYRA6QYujiVtY+LT8Q==
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr675327wmq.8.1637273636786;
        Thu, 18 Nov 2021 14:13:56 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:fc8d:4de8:c1d1:9213? (p200300ea8f1a0f00fc8d4de8c1d19213.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:fc8d:4de8:c1d1:9213])
        by smtp.googlemail.com with ESMTPSA id o3sm11868127wms.10.2021.11.18.14.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 14:13:56 -0800 (PST)
Message-ID: <bc281416-e28d-4c18-2475-add92d38a554@gmail.com>
Date:   Thu, 18 Nov 2021 23:13:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Linux PM <linux-pm@vger.kernel.org>
References: <d9d76980-966a-e031-70d1-3254ba5be5eb@gmail.com>
 <s5hczmxgnm2.wl-tiwai@suse.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Warning due to "ALSA: hda: intel: More comprehensive PM runtime
 setup for controller driver"
In-Reply-To: <s5hczmxgnm2.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18.11.2021 22:28, Takashi Iwai wrote:
> On Thu, 18 Nov 2021 21:33:34 +0100,
> Heiner Kallweit wrote:
>>
>> I get the following warning caused by 4f66a9ef37d3 ("ALSA: hda: intel: More
>> comprehensive PM runtime setup for controller driver"):
>>
>> snd_hda_intel 0000:00:1f.3: Unbalanced pm_runtime_enable!
>>
>> Not sure how this patch was tested because the warning is obvious.
>> The patch doesn't consider what the PCI sub-system does with regard to
>> RPM. Have a look at pci_pm_init().
>>
>> I'd understand to add the call to pm_runtime_dont_use_autosuspend(),
>> but for all other added calls I see no justification.
>>
>> If being unsure about when to use which RPM call best involve
>> linux-pm@vger.kernel.org.
> 
> Thanks for the notice.  It's been through Intel CI and tests on a few
> local machines, maybe we haven't checked carefully those errors but
> only concentrated on the other issues, as it seems.
> 
> There were two problems: one was the runtime PM being kicked off even
> during the PCI driver remove call, and another was the proper runtime
> PM setup after re-binding.
> 

Having a look at the commit message of "ALSA: hda: fix general protection
fault in azx_runtime_idle" the following sounds weird:

  - pci-driver.c:pm_runtime_put_sync() leads to a call
    to rpm_idle() which again calls azx_runtime_idle()

rpm_idle() is only called if usage_count is 1 when entering
pm_runtime_put_sync. And this should not be the case.
pm_runtime_get_sync() increments the usage counter before remove()
is called, and remove() should also increment the usage counter.
This doesn't seem to happen. Maybe for whatever reason 
pm_runtime_get_noresume() isn't called in azx_free(), or azx_free()
isn't called from remove().
I think you should trace the call chain from the PCI core calling
remove() to pm_runtime_get_noresume() getting called or not.


> For avoiding the former, only the pm_runtime_forbid() (and maybe
> pm_runtime_dont_use_autosuspend(), too) would suffice?  Also, for PCI
> device, no need for pm_runtime_set_supended() at remove, right?
> 
> 
> thanks,
> 
> Takashi
> 

