Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC97F1D06A0
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 07:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgEMFqG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 01:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728131AbgEMFqG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 01:46:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F313C061A0C
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 22:46:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u35so4299669pgk.6
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 22:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Oz56MRFJpfUGGGj0sKO9eTTiimVDj5rUQC9/anhfFJs=;
        b=x6N42/+FY3sVUZNT8RULkXbiLBjaxoT3U+FnilW/MXMuam7BnckzXafVdH+F9UXiSK
         5sf/oF/1wHoZ6q3cCz+cWEI6pXLwiyER7VEVqQLdznfvhmp7rpNBOzHYXBId0YdVowwt
         Of8LKQ0HLIH+2+FhCDjx/mIWZYrNyRZYfAvcmgZvOIizDxWH5S4V3qjVDZe3bJNB2YA9
         v7jbKHaXp81iduoFpoZ8/1rsgxcfOe4CSR0+/vwfVQ1b2vUa0n/13kFNfNEn2fa/nxq1
         R2lZveAQ9T/wVO/d7ehntLdyhfvjBWrqzsBcUuRaZvl4mAwWq/WVl8WEtQmx3NybtHbk
         v9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Oz56MRFJpfUGGGj0sKO9eTTiimVDj5rUQC9/anhfFJs=;
        b=p3lpz5TEgXM1tx2T2W3C/jyFFxpFZY1XCZuiZdo+YI6zL9gjz4Yi5dSgvuHS3+2oXe
         bfD9k5Um9KTwJZaSi/NQr7WpTCma85fr9DEywptFpRWIAq/tWMIELfv8LuC1QeEZYHQU
         CfXXsQb9ntFHlbCWhiWB9DLYdftIgAhL7MzDqIF78VjE68dNIwgtikdGLlmZv73Vacnt
         9hDZ3lr3jI3cG74DB+Mk3+BpsBIjM3DZ4cbwrkgISuM5f4sOaF4M1ylXnVNEMhLvoQ+9
         gfBEk0qHmHtkSRZ1czd3XqWhbiT4rjr8w1rT81fFcJJKPd+3dEEysKD44/ZEI02fOUW+
         T2Ow==
X-Gm-Message-State: AOAM53294qsGPG3ZVgQ7pIaykNjQb2MbP6lDhB5HOLzPcFFuMzwdwA9x
        8upXD2vo0t4kHSxPXy+o4OPejNQ1Jjg=
X-Google-Smtp-Source: ABdhPJx28DjbM2IrEtlxbqyFRjwOui9eYPSSTSiWM7YErIoYhW591Z9M5IYxEc+Tjy0ps2uiYI5SYQ==
X-Received: by 2002:a62:3642:: with SMTP id d63mr6534613pfa.222.1589348764572;
        Tue, 12 May 2020 22:46:04 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id a136sm13807345pfa.99.2020.05.12.22.46.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 22:46:03 -0700 (PDT)
Date:   Wed, 13 May 2020 11:16:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: Question about OPP regulator for Panfrost Devfreq
Message-ID: <20200513054601.nvwsjhk6i4bjmgt7@vireshk-i7>
References: <CAJiuCce9ZxeXnQzEW_3dbBDNZmmtWmKeft0hX+F9+SYu80NU=Q@mail.gmail.com>
 <20200511052530.iazkduojnba3abil@vireshk-i7>
 <CAJiuCcfRmDbBxEms=HAFQhaiBTznEd1of3TOcnAAc2yuTq0XtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCcfRmDbBxEms=HAFQhaiBTznEd1of3TOcnAAc2yuTq0XtA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-05-20, 22:51, Clément Péron wrote:
> Hi Viresh, Marek and Mark
> 
> On Mon, 11 May 2020 at 07:25, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 09-05-20, 21:56, Clément Péron wrote:
> > > Dear OPP Maintainers,
> > >
> > > I'm working on adding DVFS support using the generic OPP framework to Panfrost.
> > > I'm using the dev_pm_opp_set_regulators() to let OPP framework get and
> > > manage the regulator.
> > > https://github.com/clementperon/linux/commit/be310c37b82010e293b7f129ccdcb711a2abb2ce
> > >
> > > However it seems that this function only get the regulator but never enable it.
> > > This result that the regulator is disabled later by the
> > > regulator_late_cleanup().
> > >
> > > In a previous version I let the Panfrost driver to get and enable the
> > > regulator in addition to OPP but this create a conflict in debugFS
> > > because the regulator is "get" two times.
> > >
> > > Quick discussion with Mark Brown point that we should try to avoid
> > > getting two times a regulator as it can create "confusion in your code
> > > with two different parts of the device controlling the same supply
> > > independently."
> > >
> > > Is my understanding correct? If yes,
> > > Should we not add a call to regulator_enable() in the
> > > dev_pm_opp_set_regulators() ?
> > >
> > > My WIP branch :
> > > https://github.com/clementperon/linux/commits/panfrost_devfreq
> >
> > https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@samsung.com/
> >
> > We tried that sometime back and faced issues with it.
> 
> Regarding GPU it uses also the OPP framework and the regulator is not
> always-on so it seems quick logic the use_count should be increased
> for this regulator.
> 
> Does declaring the regulator as 'regulator-boot-on' could fix the issue?

The bootloader would still be required to power it on first and it
would be wastage of power as GPU isn't getting used then..

What about doing runtime_pm_get/put() from the driver which should
enable/disable all power related stuff for the device ?

-- 
viresh
