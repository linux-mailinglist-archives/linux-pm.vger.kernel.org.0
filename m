Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4C3A11FD74
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 05:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfLPEIL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 23:08:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46945 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfLPEIL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2019 23:08:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id y14so4828919pfm.13
        for <linux-pm@vger.kernel.org>; Sun, 15 Dec 2019 20:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wbgkQqezR8N6zK1NxAmtxoUZIE9QlaMc+PiyGq2r8lE=;
        b=TEjIG57/5hRxBRlaIU6s/Q1HgzaSt/twdXhbjgBoH7h5H4BMDsI+TuphUfDLk/xK9Q
         52ZbWfzx2TdmfWHsmxqo6WZpprJgv82SjY7Y/S651ii2BFuc5t2Pb6YjtIJxNHpEjC+D
         PhRufMFN45KROjk7+qrBNxX4GEaUURodO0oDcHhHHo743/1QNRS7MXIlXsxczyG5eFb4
         DiJ+inSReLlrKt9/u2PA/s5wReInxvoIYTllPEyZeN2YzbvDlKHo3IpQiE3QyMlbsJ0V
         CRq4xXIUj6teqe+2HwBWH/pvktsLhlK/S0j3wRZTBMbRqKgcGA05kNUJ3rJBT8SZdRSl
         +pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wbgkQqezR8N6zK1NxAmtxoUZIE9QlaMc+PiyGq2r8lE=;
        b=tow4zCcboqJPS+a10o3Wg/udtqxT7xMxTnfDTfueVWGImrfFJLsKKNnPWpEVF5+A0g
         jL7XMkRVGRm0eul3t5+U9vu2KWRz7NXEI5LXlm4yQ/EZN2EKaUjqw8oJG8OiioVJLODv
         ywbmYABZNaVAUB+o02tdTUo9k5gPwslMW4QLhIZ3JV82dw7YAhOkmpTvM+wTQNLtW8xL
         cEzl44woODGdbsvcbFfdysq7GvsIWFX/yBtk8faO+86Tbxa9FdTaSUtjdb8Tv8B7z0N6
         jNy3jX/qhSTXysB+zi9wGavu4E4hfifCQrP9A6DFI8K3PdclA9csXEIdsSzjRIaBgOQ3
         xTpQ==
X-Gm-Message-State: APjAAAW18G/kK1TdZA6SNrm+bIkCpjjvwWsoBt8S6XSCfArczlSVyjZ/
        rZJJK+uycXrdK7qXu9iqQwLmNw==
X-Google-Smtp-Source: APXvYqwCJ4AhFHObrnA/fbRW0LZUa1YD8casinAzvz15hQR21yibms9/hcOl1D9V0rsOa2dPjAv9hQ==
X-Received: by 2002:a63:774a:: with SMTP id s71mr15807335pgc.57.1576469290920;
        Sun, 15 Dec 2019 20:08:10 -0800 (PST)
Received: from localhost ([122.171.234.168])
        by smtp.gmail.com with ESMTPSA id f9sm19793220pfd.141.2019.12.15.20.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 20:08:10 -0800 (PST)
Date:   Mon, 16 Dec 2019 09:38:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/11] cpufreq: dt-platdev: Blacklist NVIDIA Tegra20
 and Tegra30 SoCs
Message-ID: <20191216040808.w67jxu7oapxgm7yh@vireshk-i7>
References: <20191118164512.8676-1-digetx@gmail.com>
 <20191118164512.8676-8-digetx@gmail.com>
 <20191216040532.mzdovqoub5rdztwb@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216040532.mzdovqoub5rdztwb@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-12-19, 09:35, Viresh Kumar wrote:
> On 18-11-19, 19:45, Dmitry Osipenko wrote:
> > Both NVIDIA Tegra20 and Tegra30 SoCs should be blacklisted because CPU
> > OPPs use supported_hw and thus platdev isn't suitable for these SoCs.
> > Currently cpufreq-dt driver produces a bit annoying warning splats
> > during boot because valid OPPs are not found, this will be fixed once
> > tegra20-cpufreq driver will be update to support cpufreq-dt. The warnings
> > will also happen on older stable kernels using newer device-trees, thus
> > this patch should be backported to stable kernels as well.
> > 
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Fixes: 4053aa65c517 ("ARM: tegra: cardhu-a04: Add CPU Operating Performance Points")
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index f1d170dcf4d3..aba591d57c67 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -121,6 +121,8 @@ static const struct of_device_id blacklist[] __initconst = {
> >  	{ .compatible = "mediatek,mt8176", },
> >  	{ .compatible = "mediatek,mt8183", },
> >  
> > +	{ .compatible = "nvidia,tegra20", },
> > +	{ .compatible = "nvidia,tegra30", },
> >  	{ .compatible = "nvidia,tegra124", },
> >  	{ .compatible = "nvidia,tegra210", },
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Oops, pasted the wrong register here :(

Applied. Thanks.

-- 
viresh
