Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C0BEF998
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 10:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfKEJhX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 04:37:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37340 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbfKEJhW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 04:37:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id z24so9135420pgu.4
        for <linux-pm@vger.kernel.org>; Tue, 05 Nov 2019 01:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jDulaD8yGPSw9RKsvK4+mof/PDtVuO9RYsvVXQwxzXM=;
        b=o27oGeaQFxD86u8gIGPhrzIR6SfI9fMQiBcCgp5sHCQPiaD27PrDoNQBJWtB0QX+dP
         qzXuOric5LOnQdEqqsdBrNIrsOh6QfgTwdZqm8w+5Bbo7Aqbc1nQr+Z2iKKg2xNmpSdW
         XBp/BuUmEQddIvttxGZhA/tCgUFUvbqjcFk/iOpIDzFyrlKHe+nOzDET9BacRvs9g3AQ
         /Z7xa0vBzFtlr1TRIsIb3T8BpEzi5Alw/tFY56gRnfYNBVsRaHVVTnHprjy2VeynAt1u
         HVe3f6kmQpXlYTtVHFnMAEw897EAarckuA+gTg39J3OAKNz5oqgDex9R818HEacqL0TP
         74jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jDulaD8yGPSw9RKsvK4+mof/PDtVuO9RYsvVXQwxzXM=;
        b=REok3ERvaMFgNgMi01f2lwP3ifEs3eBQLOmn0r6w8ceBXJ0yfXyUee72f89qcyhWiY
         0MYqLJpoLZHdrD77ZChvlFGQoOg/onkrvAQrWajvmVI/2r/tVdHyzYS7y62bnw8VohMS
         WiBT6soLN+I/LZ/O+BL1GTZ0QTQF63m3J6F2Ldi2tdZp/jBdp6eUjMwARqg1Z7Z5dt2j
         yxwbN3g+x30a+bMkQ+ZqEurlMI1RGZRZk7me3IlWcMyiwlVIaKeOioAaXAQBLHaw9Fvm
         g5W8WGXwNueKHMGVdo1xiT8k7y3AttVwA3vpqUujd2tcMja1XmaOHPiyFWcf5s/2meK/
         5Ipg==
X-Gm-Message-State: APjAAAXiMAK+kDsZezUcMvHP0sl/+EjFTbPQ7hXrpqoAiairy/n1OhdV
        Zow0HgSEQYglM94VsdH/1dhAVg==
X-Google-Smtp-Source: APXvYqyzuRVgyvTXTyQjC8xtu0nRUNtH/fWQGOgOhCgO04UFjuK/wTl+n0U3uw5++iupsawbMVoZEA==
X-Received: by 2002:a17:90a:ab83:: with SMTP id n3mr5259220pjq.21.1572946641205;
        Tue, 05 Nov 2019 01:37:21 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id 135sm17540908pgh.89.2019.11.05.01.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 01:37:20 -0800 (PST)
Date:   Tue, 5 Nov 2019 15:07:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Ondrej Jirman <megous@megous.com>, linux-sunxi@googlegroups.com,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: sun50i: Fix CPU speed bin detection
Message-ID: <20191105093717.q5ixjjsnb3aqzxql@vireshk-i7>
References: <20191101164152.445067-1-megous@megous.com>
 <20191103155901.GC7001@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103155901.GC7001@gilmour>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-11-19, 16:59, Maxime Ripard wrote:
> On Fri, Nov 01, 2019 at 05:41:51PM +0100, Ondrej Jirman wrote:
> > I have observed failures to boot on Orange Pi 3, because this driver
> > determined that my SoC is from the normal bin, but my SoC only works
> > reliably with the OPP values for the slowest bin.
> >
> > By querying H6 owners, it was found that e-fuse values found in the wild
> > are in the range of 1-3, value of 7 was not reported, yet. From this and
> > from unused defines in BSP code, it can be assumed that meaning of efuse
> > values on H6 actually is:
> >
> > - 1 = slowest bin
> > - 2 = normal bin
> > - 3 = fastest bin
> >
> > Vendor code actually treats 0 and 2 as invalid efuse values, but later
> > treats all invalid values as a normal bin. This looks like a mistake in
> > bin detection code, that was plastered over by a hack in cpufreq code,
> > so let's not repeat it here. It probably only works because there are no
> > SoCs in the wild with efuse value of 0, and fast bin SoCs are made to
> > use normal bin OPP tables, which is also safe.
> >
> > Let's play it safe and interpret 0 as the slowest bin, but fix detection
> > of other bins to match this research. More research will be done before
> > actual OPP tables are merged.
> >
> > Fixes: f328584f7bff ("cpufreq: Add sun50i nvmem based CPU scaling driver")
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>

Applied. Thanks.

-- 
viresh
