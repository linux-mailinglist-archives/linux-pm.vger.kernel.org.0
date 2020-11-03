Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7592A4185
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 11:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgKCKSp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 05:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgKCKSp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 05:18:45 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0307DC061A47
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 02:18:45 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id g12so13313818pgm.8
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2020 02:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RDvIF1kZN3zkD9reaN+0hjZqAnDKGT3mu11oH7z1rZk=;
        b=PYTAA4VBZtkOuiu4/lJH4sroVfYs6hhDXEyDjaVkp+KyFgq0urkK2Ubb30zNlx8Oti
         K0summB5erxd87h+VVC+TZq4BYZG9RwQvMi5Vi4GJtFmk9SSK1WGKxbtLfTT87IivJG+
         L9mmAidaYcL3F5U7dVcibiCFP6nDDJFHG1klxFNfNkR4jp8v0kumZI50tM2dR/Rk/Pkw
         3HVUlaOcUnopie+l77L5CIJgTF+fGp1GjAkRYJlGRMd4T5951xT8jfMefBXCrdNKZeYD
         aL5K0kLZXhzRYTH8R9DYi7Ktk6CYAnp+39Is0zM3VA7rI07hWh7PHYyL66ZWOle0gfX3
         FMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RDvIF1kZN3zkD9reaN+0hjZqAnDKGT3mu11oH7z1rZk=;
        b=YAakcpBMWBzN2g0TFUISSs3McgmPuxj9umWeRf0uZHVsgeL+zGSmQ5p3/DeQ/lLMJm
         gVDnrotzlr6wqwsUBBTOlQ/W/4K2lDvNrEF1QZwnv8aonSv2c6oFpzP/z/n3rwElB8Dx
         z2n5XRcUrQAn/WEgVd4wXDziR5mWJMTl4dlf2IXHI8EXiNeKyMhAm/BeIleaQ6vRD9gk
         8ZakBjCKhh+MgCCK18Ybt5u+jNtxtMuKXilr3T9heav/uxCWCBrnCaECC6xKX9vzt5GZ
         SkC7YCDVTX5dX6dnOCX57WSQj89b+vXl/QS34SrWKKISAyUIbWd06F95pLWB964hQ5pC
         88tA==
X-Gm-Message-State: AOAM532j2Q7vAnvQY7li7bNuhuEUtRBRVLZ3UVhw0XKelM8F6bcEV9Nq
        +5zGjjpbe7sI8BXDeSoIQIBO0Q==
X-Google-Smtp-Source: ABdhPJxO0ESwD10DRaRp6mZGFi5A0HOVTZllk0/QnJsx0OHhMdLIKz1G6UqPZbN3gfC4m6LEl4xk1w==
X-Received: by 2002:a17:90a:7e4:: with SMTP id m91mr3222563pjm.47.1604398724518;
        Tue, 03 Nov 2020 02:18:44 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id n27sm10247445pfq.59.2020.11.03.02.18.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 02:18:43 -0800 (PST)
Date:   Tue, 3 Nov 2020 15:48:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
Subject: Re: [PATCH v3 0/3] CPUFreq: Add support for cpu performance
 dependencies
Message-ID: <20201103101840.yrgwmcjrnjn7n5q6@vireshk-i7>
References: <20201102120115.29993-1-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102120115.29993-1-nicola.mazzucato@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-11-20, 12:01, Nicola Mazzucato wrote:
> Hi All,
> 
> In this V3 posting I have replaced the new dt-binding with minor changes/
> improvements for opp (since we are now using opp tables instead).
> The RFC still stands on how to make this info available to sw consumers.
> 
> In the RFC, I am proposing a simple addition of a performance dependencies
> cpumask in CPUFreq core and an example of how drivers and consumers would
> make use of it.
> I also propose an alternative approach, which does not require changes in
> CPUFreq core, but - possibly - in all the consumers.
> 
> This is to support systems where exposed cpu performance controls are more
> fine-grained that the platform's ability to scale cpus independently.

I was talking to Vincent about what you are doing here and we got a
bit confused and so here are few questions that we had:

- Based on my previous understanding, you don't want software
  coordination of frequencies (which is done by cpufreq today), but
  want the hardware to do that and so you want per-cpu cpufreq
  policies.

- What's the real benefit of hardware coordination ? Want to make sure
  I fully understand that.

- Because of hardware co-ordination of otherwise co-ordinated CPUs,
  few things break. Thermal and EAS are some of the examples and so
  you are trying to fix them here by proving them the missing
  information again.

- One other thing that breaks with this is freq-invariance in the
  scheduler, as the scheduler won't see the real frequencies the
  various CPUs are running at. Most of the hardware we have today
  doesn't have counters, like AMUs, not sure if all future ones based
  on SCMI will have that too, so how are they gong to be fixed ?

  And if we even have to fix this (freq invariance), what's hardware
  coordination giving us that makes all this worth it ?

Sorry about the long list :)

-- 
viresh
