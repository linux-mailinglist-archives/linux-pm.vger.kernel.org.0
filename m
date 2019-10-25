Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE7E4637
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 10:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392597AbfJYIvg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 04:51:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37759 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392237AbfJYIvf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2019 04:51:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so1113881pgi.4
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2019 01:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8o6EjIfqN25bChdB576+plHQp91qpYydoxPIwoMERx4=;
        b=ig5SOSgvEB3siL/ERQz6j33KrwwKzxL1zUp3xfMb5RU0dPThOC8RlTm44Jrra5oBDo
         gDoq8FmENLk3bGlty1/AZbNnVJk/bCmcoQ+JPZo4FL8oyFbwtQNXi4NAi+iwFUi8MHuY
         cKIfHTDHCl24b+kKXy6K+SFElDlXTwmHj4lEopxpWCVs8DgwS2sKQ7S7lh17HQNz2Nze
         +QP0vWaEekwMRoTJpo2pRA6NbArcLoSNKtFr0ivdXHsSpXZC317WSzljDyRh4SbTshdL
         ywU9VRy42nEuM273qR+BmINlEjy43G7v1mQiMxQHZF/mM0F+r32CLl6tJEbH0VVWRKLH
         ckTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8o6EjIfqN25bChdB576+plHQp91qpYydoxPIwoMERx4=;
        b=NTKy5nVwfFKI+pMeacPjBl11Pe7aStsYZJsAeNYVgcuaHqsX5peca+vBQdEb3wOdPZ
         psATZ7ymLIj2i/UrpTouBjw5VP/+amjg/kGFKeMlISyNXY7RaR9S0A6ADCM05g0PMOnd
         NsB0VYKgGgUaJTWlxj2CiSPNz1+tQfUZW1JF/63LAJod3DMoP2vsxxzAEgqocxW9c35B
         Y20BDPUU+dFA4WnEwunexneHWR1Zpm9mdeBMLUfGxOTjGeWkJF+5ZsKsQh8wIBucEz1z
         /vhKxK8n+xr5CTwQuhFOow2FjS/DeHJkZks/UzX6Paxls+90ATY8mx6QuZBZoeET4YIV
         Md8w==
X-Gm-Message-State: APjAAAUluUr0DpAExrFG0O/hWQRd4uQgNGwQBxAKGS9z0B1X7Omv4Jxx
        +IrnkcQcVx12TOR6f6axlfIH8w==
X-Google-Smtp-Source: APXvYqyeYikLu3j/t2D6AwdxoxPXvX51u7+dkh7OgZVYL/qG+aBDEDqw3nTis5fGL/9ccbruKTJ12g==
X-Received: by 2002:a65:5503:: with SMTP id f3mr2973662pgr.351.1571993495124;
        Fri, 25 Oct 2019 01:51:35 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id f8sm1454698pfn.147.2019.10.25.01.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 01:51:34 -0700 (PDT)
Date:   Fri, 25 Oct 2019 14:21:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: processor: Add QoS requests for all CPUs
Message-ID: <20191025085132.qk6iynyavgvp7wlm@vireshk-i7>
References: <2435090.1mJ0fSsrDY@kreacher>
 <20191025025343.tyihliza45os3e4r@vireshk-i7>
 <CAJZ5v0hyAX6zpr+2EzURg7ACmaXhbTAc7mBnr9ep11LkF1EBOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hyAX6zpr+2EzURg7ACmaXhbTAc7mBnr9ep11LkF1EBOg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-10-19, 10:17, Rafael J. Wysocki wrote:
> On Fri, Oct 25, 2019 at 4:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 25-10-19, 02:41, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The _PPC change notifications from the platform firmware are per-CPU,
> > > so acpi_processor_ppc_init() needs to add a frequency QoS request
> > > for each CPU covered by a cpufreq policy to take all of them into
> > > account.
> > >
> > > Even though ACPI thermal control of CPUs sets frequency limits
> > > per processor package, it also needs a frequency QoS request for each
> > > CPU in a cpufreq policy in case some of them are taken offline and
> > > the frequency limit needs to be set through the remaining online
> > > ones (this is slightly excessive, because all CPUs covered by one
> > > cpufreq policy will set the same frequency limit through their QoS
> > > requests, but it is not incorrect).
> > >
> > > Modify the code in accordance with the above observations.
> >
> > I am not sure if I understood everything you just said, but I don't
> > see how things can break with the current code we have.
> >
> > Both acpi_thermal_cpufreq_init() and acpi_processor_ppc_init() are
> > called from acpi_processor_notifier() which is registered as a policy
> > notifier and is called when a policy is created or removed. Even if
> > some CPUs of a policy go offline, it won't matter as the request for
> > the policy stays and it will be dropped only when all the CPUs of a
> > policy go offline.
> >
> > What am I missing ?
> 
> The way the request is used.

Yes, I missed the point :)

-- 
viresh
