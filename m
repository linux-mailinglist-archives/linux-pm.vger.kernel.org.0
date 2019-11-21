Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFFE104A44
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 06:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKUFbG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 00:31:06 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:46382 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfKUFbG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 00:31:06 -0500
Received: by mail-pj1-f65.google.com with SMTP id a16so921360pjs.13
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 21:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rL8hsxXOm58YLNC8couVxmo6ukGppsdnsrBhdoTeJ8M=;
        b=yP4VtZZT65ZG+FSZS2cZ1NXoYGAhUkgAXQaO+2Mr2QD6iuf87JmzlP1Qwj4FXQIz+6
         83xrB3b8ZCtusD6snYqdiNWtJGPsZ6nuhPp4IA5EYHgFh3aZcnyFbi4ad0sxXyee2QmZ
         uQ3n2etgi+zEB4uyxcnLLsaSICP2zFasJIVBowNjxyBwIOS325lWkKGVzFwWHMDBdgOm
         qBZbazJ2kRj3uAjoA0yL4UfEzxEufZG08iOhRvq9Fd++6NPexCTPaE/YYszrwcevM4W9
         wT/v01VIosSCzE1dy4I+mzhH5nZDEq5uP+LgMmiiOJdD9gvxdfXTFpWeTMCGaPm4TPHy
         41UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rL8hsxXOm58YLNC8couVxmo6ukGppsdnsrBhdoTeJ8M=;
        b=srQosKUDbyFLnYvCLTkIT8q9OhcGSgg2/73mrG9Q8N+AmvCh0HTEATFhFUVCpi0qkv
         E1EMK2au9IwpBh85iQq5NjGYebHor6myzzrbutZYnG7NpQzLSQzWYLy1CVE9tGpxRHzJ
         xu1izbunGkM7a/3x5PJHtfoPeqL5bBGhh2+FL0BK8JF9rbwLXj3nwkNj9JhCLbjHtaYX
         8zST2jEx4Fmt4yww0nJGFWfrQyBrRFr0mFjBXn9KT4phh/9epTWq098NRFdfux9cEuKJ
         jrrk444/2OO6GVg/HgV90QhXYYEaylrvytuNKRlN1xpbRDG1HYv7f/0AwWoTj3X1UG7x
         vcDQ==
X-Gm-Message-State: APjAAAXRiK71NBWh5cCewj6ApKVTOcoaFPjSliikXREk3WY4OG66p4D1
        thF89oHfidYncFmU3qWIg/xh9A==
X-Google-Smtp-Source: APXvYqwa/abldXMYEl8LBuu0njPcVapw0WdE692UrwL6RedCl8fLaMrSsPHgHvqqPHrTXvLk2slBew==
X-Received: by 2002:a17:90a:989:: with SMTP id 9mr9079835pjo.35.1574314265591;
        Wed, 20 Nov 2019 21:31:05 -0800 (PST)
Received: from localhost ([223.226.74.76])
        by smtp.gmail.com with ESMTPSA id a29sm857837pgd.12.2019.11.20.21.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 21:31:04 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:01:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jun Nie <jun.nie@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/11] thermal: devfreq_cooling: Appease the
 kernel-doc deity
Message-ID: <20191121053100.n3vfo564gs2sn72v@vireshk-i7>
References: <cover.1574242756.git.amit.kucheria@linaro.org>
 <7059d82472fe12139fc7a3379c5b9716a23cce5c.1574242756.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7059d82472fe12139fc7a3379c5b9716a23cce5c.1574242756.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-11-19, 21:15, Amit Kucheria wrote:
> Fix up the following warnings with make W=1:
> 
> linux.git/drivers/thermal/devfreq_cooling.c:68: warning: Function
> parameter or member 'capped_state' not described in
> 'devfreq_cooling_device'
> linux.git/drivers/thermal/devfreq_cooling.c:593: warning: Function
> parameter or member 'cdev' not described in 'devfreq_cooling_unregister'
> linux.git/drivers/thermal/devfreq_cooling.c:593: warning: Excess
> function parameter 'dfc' description in 'devfreq_cooling_unregister'
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/devfreq_cooling.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
