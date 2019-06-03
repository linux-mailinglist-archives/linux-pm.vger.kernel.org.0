Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E67E732819
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 07:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfFCFm6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 01:42:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36952 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfFCFm6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 01:42:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id 20so7614216pgr.4
        for <linux-pm@vger.kernel.org>; Sun, 02 Jun 2019 22:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I+cs9eaGYc8ZeuwC+POeS4O6No+gk9upqRJery6C4XM=;
        b=nxMGW1j/fKDIfZvhKeOllR/fg/yOqiZiyS6AzFGZbxPxrEA7ZVT3GEiQ+70VNwXahX
         h/g/Na00WwdBAP0brV8zWVlld76ZJ8EFJhnm4eJh4EF+lFYF8T2oaq2yC4zl/6hNQZ83
         zzw13MvTYT2O3TDW9BuG7IPIoEyXSWhrSrQo3uozlMM4IqNELfTXXhx1pnnqJrG3p7c3
         c6wFeCzRKmbsstcQRhXtaYvWCgz338NMn/va+MbV+w5uJpotB5gKRx+E8xbAB6VDN/nh
         9wWMXaETgM2JPdkfhmebk+H3fRaIPSCQ8Y/tWcs/nu1dZttpwrHLABWpVn14qq0ar39o
         hQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I+cs9eaGYc8ZeuwC+POeS4O6No+gk9upqRJery6C4XM=;
        b=dvlM+Z8MdoH1zwO/YMbVoXcHySNmLKibhrfve4uTtdWiJD0Fs8HS48opUIAJtE+Ydq
         jOA+W0IT+Fl3j75K4Nl0P6xBqeo9diZqUfdDfy8606F0+tlgTAS9FHZdO7LO9wmtFxHe
         12x7ohBzpeGKFG66k7u6f/RcsGbesGqv5usqqUpf17zGllYbB1642O2o/ej4YOiESJ23
         fkwbR9fmMUc16nwOAdfLuWW/0hqwVjMRYilEjvdu61KTd7a56CZ+HkdSg9KTaKZDmQSR
         AzqTTMqi9y/xuv2VwtqZb6ex6/8tgQdS60Ob7/6yFs/gW4VNBu7T4LUmcyEK/uWHD11a
         6kAQ==
X-Gm-Message-State: APjAAAXYLuyvRKm73YG0gorxfPXU1ffdec21welaV/uPhvtyJmMa0EvF
        Rwwv8ZSQZe5NPEgUDL/uTu760MboeOE=
X-Google-Smtp-Source: APXvYqxGTg589i5WZUbOYu57f5zabxQ5xPih4ahJgsa+A/aq9eQGeINiR5EiQKH1BWDVHD4nU/EKyA==
X-Received: by 2002:a63:c744:: with SMTP id v4mr26137288pgg.370.1559540577657;
        Sun, 02 Jun 2019 22:42:57 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id j64sm6660823pfg.24.2019.06.02.22.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 22:42:56 -0700 (PDT)
Date:   Mon, 3 Jun 2019 11:12:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] cpufreq: imx-cpufreq-dt: Fix no OPPs available on
 unfused parts
Message-ID: <20190603054254.gfnyfsglo5valg6m@vireshk-i7>
References: <64c450d4ee5119ef21ae744a3ca90d7172f973fd.1559130569.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c450d4ee5119ef21ae744a3ca90d7172f973fd.1559130569.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-05-19, 11:52, Leonard Crestez wrote:
> Early samples without fuses written report "0 0" which means consumer
> segment and minumum speed grading. According to datasheet the minimum speed
> grade is not supported for consumer parts so all OPPs are disabled
> which results in stack dumps later on.
> 
> Fix by clamping minimum consumer speed grade to 1 on imx8mm and imx8mq.
> 
> Fixes: 4d28ba1d62c4 ("cpufreq: Add imx-cpufreq-dt driver")
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/cpufreq/imx-cpufreq-dt.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Applied with following changes:

s/minumum/minimum/

Thanks.

-- 
viresh
