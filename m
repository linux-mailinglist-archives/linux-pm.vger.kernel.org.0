Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF11220523
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 08:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgGOGhK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 02:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbgGOGhJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 02:37:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0DCC061755
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:37:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so1140553wrv.9
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=u2kB3u3B7AZFrOCGW7RIbsXke2HgLh3kljbiXXyptSU=;
        b=DflabSqtgomXfgwzbBO59rDFG7DmZF0QwxlvgHDY6SG4gFvuxxTOEsqI3Qkbm9/cNL
         Vyz37o9ET2TVqtRXZUanFcuC//q/iMBNCpFoSN7v7zFgDgw4mVFx6iScqPSvJDhNc+95
         z1Oilh02U3ccJ9Zqz8QS8e5CeXiKjFK2bmpShMHe2yqZi2UjcU5Kdfd1m91OAzSPrslo
         aGz9pMcQIhY9wBm+6DDe3X82YQ4wulFwdWuz0XeifgiAGqZBT+e009TzxntlQIwYp9LP
         GuVahIDsrQQSA7LXKheMxUoVZNhPQgJaIuzrgMUN2JUWHRPfzvRqdQvsq+LUil4AY8+V
         H2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u2kB3u3B7AZFrOCGW7RIbsXke2HgLh3kljbiXXyptSU=;
        b=ka/FbDbwfDJhVJ7DZl3PaQ5dfJGHOez1QyEhXiTxQohW3tloBT05Vl5QbLQS4qHSqO
         /v1EBxxacYMV5IiKsSFDr3Y/n49iPejPYgH9rbkGALYkHTBVY4LIleTNm++PYv3j8+xB
         dshxGCintWBbzJwdSRc93dazTaIyb5qXvqz7Se/ZSP5hhxFum0i+0rXmJQPGxBU/aYL5
         GYzzv1iMScyvWAPHd6LTBIg+0phbOM1PjI9+4NNmPf5+20l8dtwW/K7Z5Bofna1X3YnZ
         gjYQy4NlgyaRwBvzIISMq63VaXoJtTEPzs5gajF5JdzsBt23S1LpymMA90u18Tx6VzaX
         omiQ==
X-Gm-Message-State: AOAM532b9q529xpDdNYtJGdZlxAWlNKnrkjpbfdduE9fvgma2IfqL2nz
        AqnT/ByUMpPqljKPGl94YYOWqQ==
X-Google-Smtp-Source: ABdhPJyQKOyuNDVm5aBX/CZ5eLSSM6VnDrMQdMe2T5HTFw69fLdvnITpMrkrEn88NJswxqQv5MWxXg==
X-Received: by 2002:adf:eec8:: with SMTP id a8mr9640759wrp.421.1594795027904;
        Tue, 14 Jul 2020 23:37:07 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id 51sm1946742wrc.44.2020.07.14.23.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 23:37:07 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:37:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Grover <andrew.grover@intel.com>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Subject: Re: [PATCH 09/13] cpufreq: acpi-cpufreq: Remove unused ID structs
Message-ID: <20200715063705.GR1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-10-lee.jones@linaro.org>
 <CAJZ5v0iB0K6H28DSDQj9T7k_kV10THxV6-HwN9qfmkLsYNHfiA@mail.gmail.com>
 <20200714210340.GJ1398296@dell>
 <20200715032442.gh2cliiddhv35fdj@vireshk-i7>
 <20200715032718.2zlo2eurhkpoayya@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715032718.2zlo2eurhkpoayya@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020, Viresh Kumar wrote:

> On 15-07-20, 08:54, Viresh Kumar wrote:
> > On 14-07-20, 22:03, Lee Jones wrote:
> > > On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:
> > > 
> > > > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > >
> > > > > Can't see them being used anywhere and the compiler doesn't complain
> > > > > that they're missing, so ...
> > > > 
> > > > Aren't they needed for automatic module loading in certain configurations?
> > > 
> > > Any idea how that works, or where the code is for that?
> > 
> > The MODULE_DEVICE_TABLE() thingy creates a map of vendor-id,
> > product-id that the kernel keeps after boot (and so there is no static
> > reference of it for the compiler), later when a device is hotplugged
> > into the kernel it refers to the map to find the related driver for it
> > and loads it if it isn't already loaded.
> > 
> > This has some of it, search for MODULE_DEVICE_TABLE() in it.
> > Documentation/driver-api/usb/hotplug.rst
> 
> And you just need to add __maybe_unused to them to suppress the
> warning.

Right.  That's Plan B.

Will fix.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
