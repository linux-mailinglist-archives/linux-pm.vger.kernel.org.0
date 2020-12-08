Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F832D296F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 12:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgLHLCc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 06:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgLHLCb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 06:02:31 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF45C0613D6
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 03:01:51 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 69so4023753pgg.8
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 03:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LL9iDRngVlMh6TlcyZQBhUA7ywfaExOsw/FVItl7PVY=;
        b=svsxLqnqLOJagu8c2sd0jtaVQZknFXTSYbQI4p53+5vtTY/QCDe6j7duoD3xKJ82dE
         Z97kxm34TZZcVs/7xiHmTbVd6y9aknWOJCMgggDyy1SWbLF3F/wsxpD3gCwdzMg6JMNU
         t9U4Oj9E2zrIUM/gNXvBZwciQOXcSS9f2No+0bcWXUYN2KXfjVTSH/PsuEwmSY/A1225
         eVLovL9XUgty8alj/FBg7AXRNzmU74DoZzHk5kb8o7Kg8kL3AoaeXidSddMWC1IXArPB
         lwV5oFMf1Lce4sOGg6A0rFxX8pJ8im23Y67if35cgyql5SrDWK/Ozpyzg6VpbvpfAIeJ
         SIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LL9iDRngVlMh6TlcyZQBhUA7ywfaExOsw/FVItl7PVY=;
        b=TSt8fZ4pZtCurGImglW7KQje8zdPXmgKlHqh5kzHGrwm3CKe4EomzNp8dZRpgOuMHl
         naVUgm8wICcTsPVX8b2iFt2liqlf4aXwQdX3O0lcMOCalQGrPetHF4QFCj3CymhaFvsi
         zhTHdcp2BZP6rwXDVIoQGangp2tkGLaH6jh0lvO5Feq46+CFvWwejowgTUVFKTuBVpL8
         zTrLeByD6/tUJLksrZhrwh6wOz6Tg5s7Lua5pk61pDO6IXBluyf8nGgEC8OqLGo0mR41
         BC9LiCfA0/VnyKW/n5KyN7kfhGE64uJPkPk9GAbaSLlzfjvVvenmw+CGIHS6NkTOgbaJ
         fU3A==
X-Gm-Message-State: AOAM5335fZFp/1oDeFOQKXIzfHc4T0LaAph81A+40haCzZ6bbOAmGfEG
        4AUZKXbNx8I26AyeWviL/B6w2w==
X-Google-Smtp-Source: ABdhPJxjZMzyA1l4taqVvkE4NUOj8WWuAQYJGYHZyXhzoENsxw7vhLEVXB6wjkS0qgZKfkFbzUVKBQ==
X-Received: by 2002:a63:4703:: with SMTP id u3mr22525771pga.385.1607425310817;
        Tue, 08 Dec 2020 03:01:50 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id 17sm18146963pfu.180.2020.12.08.03.01.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 03:01:49 -0800 (PST)
Date:   Tue, 8 Dec 2020 16:31:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
Subject: Re: [PATCH v4 3/4] scmi-cpufreq: get opp_shared_cpus from opp-v2 for
 EM
Message-ID: <20201208110148.7scxsjlkbzmxr43f@vireshk-i7>
References: <20201202172356.10508-1-nicola.mazzucato@arm.com>
 <20201202172356.10508-4-nicola.mazzucato@arm.com>
 <20201208055053.kggxw26kxtnpneua@vireshk-i7>
 <0e4d3134-f9b2-31fa-b454-fb30265a80b5@arm.com>
 <20201208072611.ptsqupv4y2wybs6p@vireshk-i7>
 <83b8400f-8dc4-000e-d790-0bf584a75f48@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83b8400f-8dc4-000e-d790-0bf584a75f48@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-12-20, 10:58, Nicola Mazzucato wrote:
> 
> 
> On 12/8/20 7:26 AM, Viresh Kumar wrote:
> > On 08-12-20, 07:22, Nicola Mazzucato wrote:
> >> On 12/8/20 5:50 AM, Viresh Kumar wrote:
> >>> On 02-12-20, 17:23, Nicola Mazzucato wrote:
> >>>>  	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
> >>>>  	if (nr_opp <= 0) {
> >>>> -		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
> >>>> -		ret = -EPROBE_DEFER;
> >>>> -		goto out_free_opp;
> >>>> +		ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
> >>>> +		if (ret) {
> >>>> +			dev_warn(cpu_dev, "failed to add opps to the device\n");
> >>>> +			goto out_free_cpumask;
> >>>> +		}
> >>>> +
> >>>> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, opp_shared_cpus);
> >>>> +		if (ret) {
> >>>> +			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
> >>>> +				__func__, ret);
> >>>> +			goto out_free_cpumask;
> >>>> +		}
> >>>> +
> >>>
> >>> Why do we need to call above two after calling
> >>> dev_pm_opp_get_opp_count() ?
> >>
> >> Sorry, I am not sure to understand your question here. If there are no opps for
> >> a device we want to add them to it
> > 
> > Earlier we used to call handle->perf_ops->device_opps_add() and
> > dev_pm_opp_set_sharing_cpus() before calling dev_pm_opp_get_opp_count(), why is
> > the order changed now ?
> 
> True. The order has changed to take into account the fact that when we have
> per-cpu + opp-shared, we don't need to add opps for devices which already have them.

The opp-shared thing is mostly a dummy thing to get you some information here.
What else has changed here ? I still don't understand why the OPPs would get
added and so the duplicate OPPs messages. Does this already happen ?

-- 
viresh
