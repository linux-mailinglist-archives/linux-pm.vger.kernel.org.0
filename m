Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DB8331DD3
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 05:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhCIERW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 23:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCIEQq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 23:16:46 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF610C06174A
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 20:16:46 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id x29so7891041pgk.6
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 20:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OOzXeoaDPDG4o7C6QAmsob4sFXF0PCvgXzZVS0klYx0=;
        b=VkTs3X6JDzLp04bSLBCOaODP8wcxa6dTq9kp8PLjDNTn2k/wKlA8YDK7QIUb+gAxUw
         eIQZuiHknEQKeUyy36vzovwOLSUIuGrCnwITT8IJ1t55doh6c6wgr5RUH8puDFSGVP8V
         gy8tZ1hbaEhrExEsXy9cSK6yNBh+79lsX/Iexzilbh2cLtzfyVUi2NvCRRz1s034Tzct
         Nr2IkssxTMW7qd9DCY/ANZkwFAPkQZrFeXNc0K5wLFPe6uN1h48RaCeQ+KieVcEq07U9
         Khqqf5WZ/rxW8mNHilHP8Ojsom/4bvR/uJfHZZCN809av8gbgjGEk7vCTHomH27BT+zM
         L/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OOzXeoaDPDG4o7C6QAmsob4sFXF0PCvgXzZVS0klYx0=;
        b=BJSIcOcIZR3iUsWBJtOKz3T9OuTF2WAvHanZgGVEAxvgbU9FZfuwrjROz3zjBRI2zQ
         XuOpEzBVwi/W2VQdxzVIeaFpB00eRJ0/lQuZI7nPJXHqcMhh/+79QXQXTL6fjuBg3/eV
         AxlkN2o+oC5gNqgDCjJZDa7bMFDeYcDcPSpkG9RAzDCbpQa8j8Z6gzLvq3HthnSwZA5d
         VbC+Rs1GJKVXQcpYAwrdQ95k0ug3xG0klxPtPJgcB6kcaySYWRu+gJ8iLdAZUsZR5cD3
         oMSxEDiY1jAsRi8oAiuTkywjpPl1BfzLNMhr4XL2oUw4VbfQYp13NoYA6pmeJHMMcrAt
         LC0w==
X-Gm-Message-State: AOAM532v9lY15ZBX/CEibfL129cAL1ZDBWtIbOhk1cgaMEioN2ITKkxo
        1m9cl4qF/hVpGPTKSp/SuRJd/Q==
X-Google-Smtp-Source: ABdhPJxlnCGX2ecU6fCM4SKglrm857xKd9/sHAb+MjRrm2nf7HrUVkpgeXZh0ZbsNdK2qBqheigI5A==
X-Received: by 2002:a63:1813:: with SMTP id y19mr15956854pgl.317.1615263406257;
        Mon, 08 Mar 2021 20:16:46 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id l19sm864473pjt.16.2021.03.08.20.16.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 20:16:45 -0800 (PST)
Date:   Tue, 9 Mar 2021 09:46:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210309041643.tcyv6rpto4k3sv5v@vireshk-i7>
References: <cover.1614580695.git.viresh.kumar@linaro.org>
 <a34f549bc75eecd4804aebb7b7794b45769eccf0.1614580695.git.viresh.kumar@linaro.org>
 <20210308145209.GA26458@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308145209.GA26458@willie-the-truck>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-03-21, 14:52, Will Deacon wrote:
> On Mon, Mar 01, 2021 at 12:21:17PM +0530, Viresh Kumar wrote:
> > +EXPORT_SYMBOL_GPL(topology_set_scale_freq_source);
> 
> I don't get why you need to export this in this patch. The arm64 topology
> code is never built as a module.
> 
> > +EXPORT_SYMBOL_GPL(topology_clear_scale_freq_source);
> 
> Same here.
> 
> > +EXPORT_SYMBOL_GPL(freq_scale);
> 
> And here.

After this patch, any part of the kernel can use these
helpers/variables to run their own implementation of tick-freq-scale
and so this patch looked to be the right place for that to me.

And the second patch in the series updates the CPPC cpufreq driver
(tristate) to use these exported symbols, so we have the first user
who needs the exported symbols as well.

> This one probably wants a less generic name as well if it's going
> to be exported.

x86 names it arch_freq_scale, perhaps we should stick to that instead.

-- 
viresh
