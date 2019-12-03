Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDFB710F7FA
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 07:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfLCGnr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 01:43:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39307 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfLCGnr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 01:43:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so1288832plk.6
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2019 22:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cEGTgxRGdDj6W2EYyG4VZuBBv7xt+SBCI6XOXHZWHJk=;
        b=jWh0uDRmn4BxfEJcpQT1SJWeF1vuWBV4t1aBQKrYRvPeqlY0LeGKunz+aL5wsFS5CB
         C9POZgQY5BMLaMZYhUT/BaJibe5aXKUkLwED4ow4eqojmZCVZkXCIjwIJ2tLqS6w0Jkz
         CboW71cXML5/ZTtJRXUgR9H/CAA077+ufOVyx7sCANZlVy6zy/83rkhgIJIRUZSutUeE
         ZWZg+LbDqW2coEBoN+KJGYSkTvXpHmP/BlV/uZPGttC/b8A+Jpu3NyNLAaABnsSJTPH+
         qyCPys3F0hFoGq5Km40JRbqRgy9No4hPP1B2HNnmxV9nwh1mwOsiQjVB5ch3qGUw6DyF
         BSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cEGTgxRGdDj6W2EYyG4VZuBBv7xt+SBCI6XOXHZWHJk=;
        b=cldKKbp8VTnYq1D9YF8hKjLn/50d8tZmoap6ehIykKkaNwhj+fU7xdivgdZsdzOXwv
         75MGwf6HadNsFAzKfFHXxVCmXHOd7vZNEoTYJtuRHQKvPfIaNzo76QMisK4NBUlWYBeK
         ih1o84uck857/f1Pv6HVkGd/BWBPXqNSALGEZL8rnV7PT9vc8uwscKpfWsGvxMM/yfpT
         Dl1QBC/FxicB6fvSDZCU3CmM26URbhGPOfigEYWD3xvPcGmiUP14ylwjV66booFJoubm
         t1BuiMpCg4Tgw6Uy9Iro/EGpSTnWY7gkXd42ObqiSHhDt7joZmIzUM2gFvxQm0Y6UxVz
         egzQ==
X-Gm-Message-State: APjAAAVOmqh9zWFzPZiuahBNJbGgrd3P7VQp6ijs5+4L3M8NO4dKHaBm
        CP/VpIQne5iLfD/vZfjgrFs2hw==
X-Google-Smtp-Source: APXvYqwcNHUHXFiQgO/rqZKPE/lAtGo5B105XBKe40csH7F5K3Nds1jXuQGP75FC1my2Q0xENSK/iQ==
X-Received: by 2002:a17:90a:a4f:: with SMTP id o73mr3787706pjo.97.1575355426450;
        Mon, 02 Dec 2019 22:43:46 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id s2sm1925598pfb.109.2019.12.02.22.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 22:43:45 -0800 (PST)
Date:   Tue, 3 Dec 2019 12:13:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, rjw@rjwysocki.net, edubezval@gmail.com,
        linux-pm@vger.kernel.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/4] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
Message-ID: <20191203064343.4lu3ut6rs6kyq7nh@vireshk-i7>
References: <20191202202815.22731-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202202815.22731-1-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-12-19, 21:28, Daniel Lezcano wrote:
> The next changes will add a new way to cool down a CPU by injecting
> idle cycles. With the current configuration, a CPU cooling device is
> the cpufreq cooling device. As we want to add a new CPU cooling
> device, let's convert the CPU cooling to a choice giving a list of CPU
> cooling devices. At this point, there is obviously only one CPU
> cooling device.
> 
> There is no functional changes.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   V2:
>     - Default CPU_FREQ_COOLING when CPU_THERMAL is set (Viresh Kumar)
> ---
>  drivers/thermal/Kconfig     | 14 ++++++++++++--
>  drivers/thermal/Makefile    |  2 +-
>  include/linux/cpu_cooling.h |  6 +++---
>  3 files changed, 16 insertions(+), 6 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
