Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6786DBD37
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 07:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442074AbfJRFrn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 01:47:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40027 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391949AbfJRFrn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 01:47:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id e13so2715137pga.7
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 22:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TiE6mrXNG7EqkcZ/U+Q35uelbhpLaDsgu+uQOO85Zos=;
        b=GT5coTqMgC0RpqXd7gG3yW2ilpPm5cZzvkTxi6FzIbbY4la707DrP5/nepX/YIM/bv
         GNro45KaBJKsI5YcmWVrWhP6svfuswi+XwUiuyZ7OEekpNi7yQjuK+6jsfJrnmOlkDGS
         9Dgd2fc4GS5TWS2CSTSqyZCJMhPQrEMqtmMpeWTk3qmIrrIevK9laoksrPssfgcYfFNa
         TekjbitHqxjwfjC2KyUWsW2pTDXKdvxxZOY29ROPr6m0oQsZSYd96kDGL9GQoj3WGIuR
         TRITWtWwpnRTHiXrarQOP9xfJFptIyyOQvxXnifzplyJ8r9hDJPMu56oQq6bv/3OVRax
         oPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TiE6mrXNG7EqkcZ/U+Q35uelbhpLaDsgu+uQOO85Zos=;
        b=KXkapE+WM4TxEymRzwPzJYPZNJvsJe+KLnoPBBaHtAcAXbGgOK4zUu4z3Bp4Hxzhfu
         EuSto9mvWF5H0S9Ew28ncmD7AYzdzMsGYWD8mwjviIvmHLdavOFXCh2KeCv7ortXm2tw
         XV1WPdb9i2LYFksaIHvNmLy0BAhwypMxD1Ti+XKA9lMlTupVfCcXR+13ZOaI/r2XTOF0
         xeApZQZ16RnbqFHL7eya4hsUH5IZDzEun3JZi2q8azY8OqysnC/azw9YONEDxxFeXhBI
         ILGC7oS5AdT3DR/AgOvJq/T/oLsox5WsA0gQasA2WUsBvvQR6J9ZWxeSEv0SYUvzeUBR
         /AkQ==
X-Gm-Message-State: APjAAAXLduIyrd/BWwdehD4sYC70tex1tKIQ699jXXQ8ppQyXJ3IzFLz
        fxdmlWt5CAttie7I1ru9pib35Q==
X-Google-Smtp-Source: APXvYqw0u5pU/YJB1pLyMOrYy32vfv7QWsaj3jE6gcSYufUNISW7CLe9bQeAT3MtxfOTk99PbjIt1g==
X-Received: by 2002:aa7:96ba:: with SMTP id g26mr4667261pfk.132.1571377662879;
        Thu, 17 Oct 2019 22:47:42 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id c11sm5741274pfj.114.2019.10.17.22.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:47:42 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:17:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: Re: [PATCH v2 2/5] cpufreq: merge arm_big_little and vexpress-spc
Message-ID: <20191018054740.maqbzbk7secgpc2r@vireshk-i7>
References: <20191017123508.26130-1-sudeep.holla@arm.com>
 <20191017123508.26130-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017123508.26130-3-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-10-19, 13:35, Sudeep Holla wrote:
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> similarity index 90%
> rename from drivers/cpufreq/arm_big_little.c
> rename to drivers/cpufreq/vexpress-spc-cpufreq.c
> index 7fe52fcddcf1..b7e1aa000c80 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> @@ -1,20 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * ARM big.LITTLE Platforms CPUFreq support
> + * Versatile Express SPC CPUFreq Interface driver
>   *
> - * Copyright (C) 2013 ARM Ltd.
> - * Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> + * Copyright (C) 2019 ARM Ltd.

Should this be 2013-2019 instead ?

> + * Sudeep Holla <sudeep.holla@arm.com>
>   *
>   * Copyright (C) 2013 Linaro.
>   * Viresh Kumar <viresh.kumar@linaro.org>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
>   */

-- 
viresh
