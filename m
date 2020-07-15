Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273D2220CA6
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 14:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgGOMHr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 08:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbgGOMHq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 08:07:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CCEC061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 05:07:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so5535785wml.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 05:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4Ce16eeyEmToVm1NyTuv8byPgefbOw/xQlLRuQI5vZU=;
        b=f0bfEQZqTKoRNeLTWWsp+zkIDgSFJWBKwFbKQfO2fXZlKbPptdDII0Jk2YdDLrE0iH
         icpSZnlr67PJZGT4osLoC2AzAriW8M//EE+9wS1LBsoBO3tf/T9SYGHAft585vjtuA8b
         JZEN93Nih7lc1/dU5BgHIGLgqv1TWIG9UwQlOJJcXBRz4JZMCdkc/aibeTpCTVqOlM08
         baawOh99cZBhycFMiFUUBgvwC3bADLYZGm74B6yXygYf9f1uZrRRO7VGncyBQuwQvKFv
         0QSBBggsuQJUYOJ1E0Vi7OZLo7/f7Ww/8uBLTWT7HHQUnx/wh/kY56QJ1F/V4EiJ0xA6
         sMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4Ce16eeyEmToVm1NyTuv8byPgefbOw/xQlLRuQI5vZU=;
        b=hEcrKzfQ3FwXkibZEkSMx4dun1zd63qjIoiNcgb/xQ+HuSLpN5YVivqmNK7uNEnkHk
         2xuPruRO1GBKphDucpxAtm/ylPh5i5+V9lQv3gXwNbEnToK77YHwUtFzZPi0Efrlh8tJ
         TRFSadJQxxpePclcZ8bvX0U2PyPCrE8UjjYvuQXXI6Q3BMsN9dk68hE5Tz1VL4GrCc5P
         I5ccD8aQObphBwRTsTVdumaidPTw084sLoK0izZQKMzkW9eSTuJicYKvwuWWl0UhpF3h
         geTiayy2hH8QZT1XrnU7zAGgaOb/gYaav6DL4yFgbYDaI/hffOeazBhPDM/Xp12xcgVV
         rOOA==
X-Gm-Message-State: AOAM532Ik56sbklYTX57eE3/Nky+pjC2Ljnn6hq+XBT97j3fS2jGhpyd
        b0NOWz7+oJm8eGM2iLDcVcYosw==
X-Google-Smtp-Source: ABdhPJzGN43S3RJ1eZFN9X1bggN1kL3iVKtEOsRuQxQlaxuxgrdeeXcNpbyaLSqe+xJ6h09Y4Ul15g==
X-Received: by 2002:a1c:9994:: with SMTP id b142mr8151396wme.141.1594814864992;
        Wed, 15 Jul 2020 05:07:44 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id 5sm3056248wmk.9.2020.07.15.05.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 05:07:44 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:07:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Grover <andrew.grover@intel.com>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Subject: Re: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
Message-ID: <20200715120742.GD3165313@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-10-lee.jones@linaro.org>
 <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
 <20200714210340.GJ1398296@dell>
 <20200715032442.gh2cliiddhv35fdj@vireshk-i7>
 <20200715032718.2zlo2eurhkpoayya@vireshk-i7>
 <CAJZ5v0jHJDLt6QFWG9FOpqmWMXAUuSEPHdHbVgFWcwR6FQD57Q@mail.gmail.com>
 <20200715113433.GB3165313@dell>
 <CAJZ5v0gFwYj7KKKj806s5SdWO1Wu5exiwObKKAdQWQEKg+2CJA@mail.gmail.com>
 <20200715115029.GC3165313@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715115029.GC3165313@dell>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020, Lee Jones wrote:

> On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
> 
> > On Wed, Jul 15, 2020 at 1:34 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:
> > >
> > > > On Wed, Jul 15, 2020 at 5:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > >
> > > > > On 15-07-20, 08:54, Viresh Kumar wrote:
> > > > > > On 14-07-20, 22:03, Lee Jones wrote:
> > > > > > > On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
> > > > > > >
> > > > > > > > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Can't see them being used anywhere and the compiler doesn't complain
> > > > > > > > > that they're missing, so ...
> > > > > > > >
> > > > > > > > Aren't they needed for automatic module loading in certain configurations?
> > > > > > >
> > > > > > > Any idea how that works, or where the code is for that?
> > > > > >
> > > > > > The MODULE_DEVICE_TABLE() thingy creates a map of vendor-id,
> > > > > > product-id that the kernel keeps after boot (and so there is no static
> > > > > > reference of it for the compiler), later when a device is hotplugged
> > > > > > into the kernel it refers to the map to find the related driver for it
> > > > > > and loads it if it isn't already loaded.
> > > > > >
> > > > > > This has some of it, search for MODULE_DEVICE_TABLE() in it.
> > > > > > Documentation/driver-api/usb/hotplug.rst
> > > > >
> > > > > And you just need to add __maybe_unused to them to suppress the
> > > > > warning.
> > > >
> > > > Wouldn't that cause the compiler to optimize them away if it doesn't
> > > > see any users?
> > >
> > > It looks like they're only unused when !MODULE,
> > 
> > OK
> > 
> > > in which case optimising them away would be the correct thing to do, no?
> 
> It would be good if someone with a little more knowledge could provide
> a second opinion though.  I would think (hope) that the compiler would
> be smart enough to see when its actually in use.  After all, it is the
> compiler that places the information into the device table.
> 
> If that is not the case, then the MODULE_DEVICE_TABLE() magic is
> broken and will need fixing.  Removing boiler-plate is good, but not
> at the expense of obfuscation.

Okay, I'm satisfied.  This test build is without __maybe_unused:

# All configs built as modules (MODULE) - the compiler knows to use the tables

 $ ccache make -f Makefile -j24 KBUILD_OUTPUT=../builds/build-x86 allmodconfig
 $ ccache make -f Makefile -j24 KBUILD_OUTPUT=../builds/build-x86  W=1  drivers/cpufreq/
 [...]
   CC [M]  drivers/cpufreq/pcc-cpufreq.o

# All configs built-in (!MODULE) - the compiler sees that they are unused

 $ ccache make -f Makefile -j24 KBUILD_OUTPUT=../builds/build-x86 allyesconfig
 $ ccache make -f Makefile -j24 KBUILD_OUTPUT=../builds/build-x86  W=1  drivers/cpufreq/
   CC      drivers/cpufreq/pcc-cpufreq.o
  drivers/cpufreq/pcc-cpufreq.c:619:36: warning: ‘processor_device_ids’ defined but not used [-Wunused-const-variable=]
  619 | static const struct acpi_device_id processor_device_ids[] = {
      |                                    ^~~~~~~~~~~~~~~~~~~~

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
