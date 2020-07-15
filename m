Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35372220CC7
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 14:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGOMRC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 08:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgGOMRB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 08:17:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1982AC061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 05:17:01 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so2471611wrw.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=P9+1m3wZiqcpo0cnrnururZIQWEQrhFekUGBts30/fQ=;
        b=EKHMfQBUPRLnnQQy6i3XNrTIKLvKdaglpd3anIxBP5KtA7V0HujMdXnvEX3vUZo7+H
         t5fnqFjVnqkUKRH/hlyrsXh79yMI5l92TtpicLz4H/eS9mTJqfDmvttnyNDi2IvvIo3m
         X5VL7L7f9fqXfDap7ketUgOdL0B4HCZLZjQe/bxYv1YNbr0wJzntZpfsbyOeSVqzdf34
         dvmF/viWDyhmQRt9ktn/P9OOl50Cm9AWl1vTRjww8R1nZ+1q4NdkQ6Z6AQNGfGnIR+Gc
         Hpc+pE7t77YFeWLuHTYM+VBefRVRkEvb2oBUFG6+aHJ97Btx2gu1PdW+KJ1pTNWdB5d1
         6Y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=P9+1m3wZiqcpo0cnrnururZIQWEQrhFekUGBts30/fQ=;
        b=GiP51/hcmt5w/ubhRtnBFieXRgEAjKNaHi8hXLVP9nNQzwLmIlrnd/fiDxsvzCpPf6
         NgkYhg6nYNvc4+/poQsf0PEiikBlqkVoylXsX7x+afVLvaKCAFxlXqwa2i0wCRIyAs27
         Il5xcKFRxkMKzY1j0ScwspzUR7ndm3DL8d/araz4DNJl5eCqFByQXlqBMOOLV76P+Sa8
         aX6gjoUmuJWUR7rnVXWQNtJ1OTyHA59H8J+A2lbkq2SsGYL2zjl70H2BEYsg3+GOAelj
         iFKR748/kKZmHjrcSMZ6ly6QS7elUz+rcxx0r+p9Hk5uCRhuYOpKUc9BTFPuaoj+jDaa
         RMSg==
X-Gm-Message-State: AOAM533Gca7NMVIacyB1mfV4fhA0o8BF9MuFZ3Drf7rlbtFdwSEWoKMI
        NM+t4knQjfzkDY0q8/jlk+k9jQ==
X-Google-Smtp-Source: ABdhPJw1RlHdFlCQxqYGIvI7SbhsAtRef67AkGJAHgn0iJW7X2IQ3QQMgUd4z/mr68WLHf9teEyKyA==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr11321706wrq.104.1594815419802;
        Wed, 15 Jul 2020 05:16:59 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id p29sm3239215wmi.43.2020.07.15.05.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 05:16:59 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:16:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Subject: Re: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
Message-ID: <20200715121657.GE3165313@dell>
References: <20200714145049.2496163-10-lee.jones@linaro.org>
 <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
 <20200714210340.GJ1398296@dell>
 <20200715032442.gh2cliiddhv35fdj@vireshk-i7>
 <20200715032718.2zlo2eurhkpoayya@vireshk-i7>
 <CAJZ5v0jHJDLt6QFWG9FOpqmWMXAUuSEPHdHbVgFWcwR6FQD57Q@mail.gmail.com>
 <20200715113433.GB3165313@dell>
 <CAJZ5v0gFwYj7KKKj806s5SdWO1Wu5exiwObKKAdQWQEKg+2CJA@mail.gmail.com>
 <20200715115029.GC3165313@dell>
 <CAJZ5v0hJf2BwDvmtD6UEyyxm-CGcA=SLmAt+F8Sr0ceDZji0jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hJf2BwDvmtD6UEyyxm-CGcA=SLmAt+F8Sr0ceDZji0jw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:

> On Wed, Jul 15, 2020 at 1:50 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
> >
> > > On Wed, Jul 15, 2020 at 1:34 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
> > > >
> > > > > On Wed, Jul 15, 2020 at 5:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > > >
> > > > > > On 15-07-20, 08:54, Viresh Kumar wrote:
> > > > > > > On 14-07-20, 22:03, Lee Jones wrote:
> > > > > > > > On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
> > > > > > > >
> > > > > > > > > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Can't see them being used anywhere and the compiler doesn't complain
> > > > > > > > > > that they're missing, so ...
> > > > > > > > >
> > > > > > > > > Aren't they needed for automatic module loading in certain configurations?
> > > > > > > >
> > > > > > > > Any idea how that works, or where the code is for that?
> > > > > > >
> > > > > > > The MODULE_DEVICE_TABLE() thingy creates a map of vendor-id,
> > > > > > > product-id that the kernel keeps after boot (and so there is no static
> > > > > > > reference of it for the compiler), later when a device is hotplugged
> > > > > > > into the kernel it refers to the map to find the related driver for it
> > > > > > > and loads it if it isn't already loaded.
> > > > > > >
> > > > > > > This has some of it, search for MODULE_DEVICE_TABLE() in it.
> > > > > > > Documentation/driver-api/usb/hotplug.rst
> > > > > >
> > > > > > And you just need to add __maybe_unused to them to suppress the
> > > > > > warning.
> > > > >
> > > > > Wouldn't that cause the compiler to optimize them away if it doesn't
> > > > > see any users?
> > > >
> > > > It looks like they're only unused when !MODULE,
> > >
> > > OK
> > >
> > > > in which case optimising them away would be the correct thing to do, no?
> >
> > It would be good if someone with a little more knowledge could provide
> > a second opinion though.  I would think (hope) that the compiler would
> > be smart enough to see when its actually in use.  After all, it is the
> > compiler that places the information into the device table.
> >
> If that is not the case, then the MODULE_DEVICE_TABLE() magic is
> > broken and will need fixing.
> 
> I'm not sure why that would be the case?

Nor me.  In fact, take a look at my latest email.  I think I just
proved out that it's not broken.  The warning is valid and
MODULE_DEVICE_TABLE() appears to work just as it should.

> > Removing boiler-plate is good, but not at the expense of obfuscation.
> 
> I'm not following you here to be honest.

Never mind.  It's no longer important.

> BTW, I'm wondering if removing the "static" modifier from the
> definitions of the structures in question makes the warnings you want
> to get rid of go away.

I'm sure that it would.  But that just alludes to the fact that the
tables may be in use elsewhere, which in the case of !MODULE is
untrue.  That's probably more of a hack than using __maybe_unused.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
