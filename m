Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4A1133535
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 22:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgAGVsm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 16:48:42 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40689 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgAGVsk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 16:48:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id s21so238378plr.7
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2020 13:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2CcTg/o8UwCiVCitQqRQYGVJRDQWN4iLjNgNoNrzkRc=;
        b=L9BYBAYHoSB1I8wnIns2wgv7M6rBeVuglYc8yQJUpOC1qGlhpAuBz8XixDgoJbAE3m
         S2uedcF93wxsHV3qEnCCw2SHZq2fqcVhAsGVL/GLdEG9rwSfwNAwhX+P9v00RXWwsFZt
         gmb8hSVkiEXFLk6TXrP/UoeZxdya4uH0AMO2jKIq+68Ql9r0brqg38Q2EbUGB7OMYnnk
         UjBaLrUYIifwT6Vf+7VetRYdhawPEQ2MafCdGArgWioTaWA3Onj6FUHXYme8Bycv+k0E
         z1R3KGA6dfs1DE7FPIwblt3vCKZb5cTrANz15SiXcaJiSuEGgjjiF8+xMrBE1RZdzJb7
         3qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2CcTg/o8UwCiVCitQqRQYGVJRDQWN4iLjNgNoNrzkRc=;
        b=fm0r7+zzfMGeq4cTpFsbiVRw+6iB3nT4nU66S395axshm50OY7M7LnGK9oQcPd4G3I
         pKWiY2MM4W6wL0NrS7UcUu8BswxNl2CAv2pfg6K+KdqrTI5Ab6rTs6wnKpKBgtwLAD/g
         ZNhAKKVqj8k1//wRS6Yq+dOGslOogmJvrUeO1gWKPU4IT662c5aMuYxXTIbTtLDNnIUB
         obAY3Ew/ksY+2dw+qA3fsEv9mejJz8FZa1C5Wu8Iq7Z9CSJ7zoz3UrgM3mAdgwBficzm
         DmfOyRfUgmpSOGHCutbakMls5gvx6sGzCyhfUU5GPYYGouhh60YExbPvqokRXBb1V4Ix
         s/rg==
X-Gm-Message-State: APjAAAUIHbC9JRU6SsWWC92YdyJ5Ehm8EovJqLUFmZU9udsMa6ch35zs
        Q2vo3W0pcTeSM73y8M5L+zoVyw==
X-Google-Smtp-Source: APXvYqxeTpXMbsnJnCOtx1iWYJsGQRjwgp7O/48eAI0afmy7bdRAVVocuPCG6/35THSoAZD5+E7KXA==
X-Received: by 2002:a17:902:ac97:: with SMTP id h23mr1848472plr.237.1578433719299;
        Tue, 07 Jan 2020 13:48:39 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x11sm530623pfn.53.2020.01.07.13.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 13:48:37 -0800 (PST)
Date:   Tue, 7 Jan 2020 13:48:34 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, jcrouse@codeaurora.org,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Subject: Re: [PATCH 2/2] PM / devfreq: Add devfreq_transitions debugfs file
Message-ID: <20200107214834.GB738324@yoga>
References: <20200107090519.3231-1-cw00.choi@samsung.com>
 <CGME20200107085812epcas1p4670ae2265573d887aa75cab36c04b1ea@epcas1p4.samsung.com>
 <20200107090519.3231-3-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107090519.3231-3-cw00.choi@samsung.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 07 Jan 01:05 PST 2020, Chanwoo Choi wrote:

> Add new devfreq_transitions debugfs file to track the frequency transitions
> of all devfreq devices for the simple profiling as following:
> - /sys/kernel/debug/devfreq/devfreq_transitions
> 
> And the user can decide the storage size (CONFIG_NR_DEVFREQ_TRANSITIONS)
> in Kconfig in order to save the transition history.
> 
> [Detailed description of each field of 'devfreq_transitions' debugfs file]
> - time_ms	: Change time of frequency transition. (unit: millisecond)
> - dev_name	: Device name of h/w.
> - dev		: Device name made by devfreq core.
> - parent_dev	: If devfreq device uses the passive governor,
> 		  show parent devfreq device name.
> - load_%	: If devfreq device uses the simple_ondemand governor,
> 		  load is used by governor whene deciding the new frequency.
> 		  (unit: percentage)
> - old_freq_hz	: Frequency before changing. (unit: hz)
> - new_freq_hz	: Frequency after changed. (unit: hz)
> 
> [For example on Exynos5422-based Odroid-XU3 board]
> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
> 14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
> 14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
> 14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
> 14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
> 14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
> 14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
> 14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
> 14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
> 15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
> 15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
> [snip]
> 

Wouldn't it make more sense to expose this through the tracing
framework - like many other subsystems does?

Regards,
Bjorn
