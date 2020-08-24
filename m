Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB64250359
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 18:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgHXQng (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 12:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728715AbgHXQmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 12:42:18 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8A0C061573
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 09:42:17 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h3so8820694oie.11
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cCBCq0smwjMsQiJp7+SlIOuIjjFC1mVZRWyztc0HMaw=;
        b=tzUKyh8cbZXfplMGX1hzIr2igvRn/W0uccmqfu1ctMcLyMVDkN+CQZbHVWbzsMZ7Ho
         fewxaFLsEY8HT7IBt2VFzqVoPlvcHqSD8GJocHx7tRYLWWDwOCyTul/8MBpW1dtK7kDo
         Bga3bS3sMCdSXNMqEEPKOy2ZYe91oCJP53bNEQe/dcRNGn29NuZdlIGgMGpOENhtZzOn
         OUxjHSwDvAgAbcVlPRvusMYP2tPvo7WaGc9EEsphpsl/jCxZtvipPGX5RP+ICQ7GPsRG
         Ynt2gRdgXua5zKC8omb3OrkyX1QqIKspR3qTI6BhDrPk9JS0FHIPnhg+uQPzMnBp7f6M
         GOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cCBCq0smwjMsQiJp7+SlIOuIjjFC1mVZRWyztc0HMaw=;
        b=NtajceNr1IWuj8LBgVVpLu+1j+qSa+hEgb3cmbtE8khum5JalPuaWyjAo+K8E77ZEB
         xJSZQofcgFIhRgahs2VkvhqkL+slG0R6gYeR5RCa+BMo0p6/I/0tSv4+hTR0ZxvfKWO1
         ceu5XSeXfPZFW6Xd1aOhVyZFtKcWmCUNSMzuYGJNcGGvgALhrJnY028guu9PI7nn1bdm
         MjnP3yPkY+Y6qmyqRNIk03tYfL+w0BgPvslh2FVkJFdMv8UMYC5nKso+Gqi5/8a+upf0
         kv1uG90BFsrQWUqXCjCxgCLXmeWm1P0fMYYheiqJAJe2Zw4HVPyAJNqJbAD0hhDPQXIP
         LBFg==
X-Gm-Message-State: AOAM5326KLk8eSsyJF8S75sPir1om474oRJU+svqP86dacQHtvCoCsuw
        1DMa3N9BaNt2+2zWsopqvjANDw==
X-Google-Smtp-Source: ABdhPJyUsgnTMuoRHaD0AXUL/sdNx23OYcYq/51u75IfcA3X1IE5/xmqfStdQKejGbL8gHVy8NqSbA==
X-Received: by 2002:aca:a9d0:: with SMTP id s199mr125719oie.154.1598287336742;
        Mon, 24 Aug 2020 09:42:16 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id 143sm2102701oie.11.2020.08.24.09.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 09:42:16 -0700 (PDT)
Date:   Mon, 24 Aug 2020 09:42:12 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, khilman@kernel.org,
        ulf.hansson@linaro.org, rjw@rjwysocki.net, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, pavel@ucw.cz,
        len.brown@intel.com, rnayak@codeaurora.org, dianders@chromium.org,
        mka@chromium.org
Subject: Re: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME
 flags
Message-ID: <20200824164212.GA3715@yoga>
References: <20200821204921.32536-1-sibis@codeaurora.org>
 <159804608868.334488.2486130699850456264@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159804608868.334488.2486130699850456264@swboyd.mtv.corp.google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 21 Aug 14:41 PDT 2020, Stephen Boyd wrote:

> Quoting Sibi Sankar (2020-08-21 13:49:20)
> > Add GENPD_FLAG_NO_SUSPEND/RESUME flags to instruct genpd to keep the
> > status of the PM domain unaltered during suspend/resume respectively.
> > The flags are aimed at power domains coupled to co-processors which
> > enter low-power modes independent to that of the application processor.
> > 
> > Specifically the flags are to be used by the power domains exposed
> > by the AOSS QMP driver linked to modem, adsp, cdsp remoteprocs. These
> > power domains are used to notify the Always on Subsystem (AOSS) that
> > a particular co-processor is up. AOSS uses this information to wait
> > for the co-processors to suspend before starting its sleep sequence.
> > The application processor powers off these power domains only if the
> > co-processor has crashed or powered off and remains unaltered during
> > system suspend/resume.
> 
> Why are these power domains instead of some QMP message sent during
> remote proc power up?

The understanding I gained as I researched this, was that with this
property enabled resources related to the particular subsystem will be
kept enabled when the apss enters some power save mode. So my
interpretation was that it does "keep something powered".

> If this has been discussed before feel free to
> disregard and please link to prior mailing list discussions.
> 

There where some discussions related to the "QDSS clk" in that series,
but I don't remember getting any feedback on modelling these things as
power-domains.

> I find it odd that this is modeled as a power domain instead of some
> Qualcomm specific message that the remoteproc driver sends to AOSS. Is
> there some sort of benefit the driver gets from using the power domain
> APIs for this vs. using a custom API?

We need to send "up" and "down" notifications and this needs to happen
at the same time as other standard resources are enabled/disabled.

Further more, at the time the all resources handled by the downstream
driver was either power-domains (per above understanding) or clocks, so
it made sense to me not to spin up a custom API.

Regards,
Bjorn
