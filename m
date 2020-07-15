Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9BC220BF2
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 13:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgGOLei (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 07:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbgGOLeh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 07:34:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623A6C061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 04:34:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so2317176wrn.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=amnN+tZUOWZ5o5gu9/BaU8xfX8cw/6xXvE3/vXYjLKQ=;
        b=ac8gFt6fc03EWqx72+kQBSxrokYP8Po1DjfRHYCNQrzqX05C3sc2XfWosLGeUwuqFb
         AR0p4SntE+94Wjh0RgBBTXE7ap6QeVlhHKGrMSuj42b4VkbNmSy2a6XyeWVqK87AgYJM
         VAYU1x0RvG7GQt/kmIjyvBYmI8sLOwm0TN8VoKvP2BP17Dy8pH78dqu95LoSYTYZ5MoC
         q3IJU90DUo3WCrxa0a74Qtl1pwezPtZXw9GrsROhf8Sx1Il76qkt72xdO001hJkXPOSa
         ngSLzazrCRBOgC2fw15NhfoDssQXKXMoxW01qSHz74TvDXySb7fKxYJddXRSO5iPZHDS
         6EEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=amnN+tZUOWZ5o5gu9/BaU8xfX8cw/6xXvE3/vXYjLKQ=;
        b=sjDaDcM5n5PgZJgcCk17SXf0CP3g36TjZHm6Gmb/Qwably+VZITE0Lik9KspbOs5fT
         +N9yFKZNkpbp5KsZUSbEJzaRL7rFokuCzRhPCXrw3MmdZ/x8SzbimPWg8jzWuC7eWKWL
         m5skKFuPEcR7jlBYQ5FJf/q93zHVwi64FD8AVyesuBKnIOipTX7hTZh9NO54jWbBs7V8
         53qNlfrQkXFIsNT9edfhuDgaP/jCQ34uZiwtW2lYNKSPtM1zsRCVBvK8FmGYVRRlEh4r
         GXzrKLTbqU1njZuzo0vi5jpoyAnfTK2p8W9wlRxvC+uv9ElgVvx1cZoSTd+bOpVRztDj
         0/MA==
X-Gm-Message-State: AOAM532cz3mEWpjvDD100DnBpRxzm/bI7VFW0oPj6Z10TzxGXyiTH8an
        dqASlcYR2bRBnJ9yXJGAjVnn+w==
X-Google-Smtp-Source: ABdhPJyOJ594kO/nH68gr/cagcLRLVrx6mi5PcaDxcb85XAJBXlNoyaEdFSfKDZf+nd45/NNKHZNlQ==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr10886895wrp.412.1594812876029;
        Wed, 15 Jul 2020 04:34:36 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id f15sm3020213wmj.44.2020.07.15.04.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 04:34:35 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:34:33 +0100
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
Message-ID: <20200715113433.GB3165313@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-10-lee.jones@linaro.org>
 <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
 <20200714210340.GJ1398296@dell>
 <20200715032442.gh2cliiddhv35fdj@vireshk-i7>
 <20200715032718.2zlo2eurhkpoayya@vireshk-i7>
 <CAJZ5v0jHJDLt6QFWG9FOpqmWMXAUuSEPHdHbVgFWcwR6FQD57Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jHJDLt6QFWG9FOpqmWMXAUuSEPHdHbVgFWcwR6FQD57Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020, Rafael J. Wysocki wrote:

> On Wed, Jul 15, 2020 at 5:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 15-07-20, 08:54, Viresh Kumar wrote:
> > > On 14-07-20, 22:03, Lee Jones wrote:
> > > > On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
> > > >
> > > > > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > >
> > > > > > Can't see them being used anywhere and the compiler doesn't complain
> > > > > > that they're missing, so ...
> > > > >
> > > > > Aren't they needed for automatic module loading in certain configurations?
> > > >
> > > > Any idea how that works, or where the code is for that?
> > >
> > > The MODULE_DEVICE_TABLE() thingy creates a map of vendor-id,
> > > product-id that the kernel keeps after boot (and so there is no static
> > > reference of it for the compiler), later when a device is hotplugged
> > > into the kernel it refers to the map to find the related driver for it
> > > and loads it if it isn't already loaded.
> > >
> > > This has some of it, search for MODULE_DEVICE_TABLE() in it.
> > > Documentation/driver-api/usb/hotplug.rst
> >
> > And you just need to add __maybe_unused to them to suppress the
> > warning.
> 
> Wouldn't that cause the compiler to optimize them away if it doesn't
> see any users?

It looks like they're only unused when !MODULE, in which case
optimising them away would be the correct thing to do, no?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
