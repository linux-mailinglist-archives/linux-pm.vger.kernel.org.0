Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70B61009B8
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 17:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfKRQve (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 11:51:34 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40615 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfKRQve (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 11:51:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2so19785390ljg.7;
        Mon, 18 Nov 2019 08:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QIcIAsn2Tf0hkT0Z0sJamAE1Kw/AvLRMcFk9OjqUWjM=;
        b=KGoCvOctUYzAbf+D8Qeg9cKHfvolwhQwQzRbpilFEQYy0PWqIB4q7E8vSjwj1x0tdj
         JMK54DnI1f3+q8KTswy9YJHZHjpCiWaEDLPknFKpvOGWjDNF59XAzDqkcTcfoHywy2jJ
         4+tKZ5b6VuihC+inJ/fEOhGIhevIBrDrSynVNkHrh4Nn05WyAKg3Va7+KsPenv4Am/gW
         TD1urnxXjcpctCruZZOnlwVfRGoEMzsk/S4azNTQU9uH9eMLRaJS4Ed0+rpgiN5F3U89
         MagdfaXE4L5EJD2A7gBkYZf6lVcQlv8ex83NCsYKKo5QP00jaCNNd0Aa2w2qnea96AFO
         CEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QIcIAsn2Tf0hkT0Z0sJamAE1Kw/AvLRMcFk9OjqUWjM=;
        b=SRTDu7DgSA4sO+ZimXe2cZc2SGBVshgYnEDVlW6JdNwszzKLnSgNdNZ7O5EPkmQaE5
         P2OP6aDRqMB8u3nnBKiFNWY4d0VCuLFH5NNPwjUwjO0v2iVwFVVybw3Z/QnQ7QP6NXvn
         1wAMrLdioiT6P/9No2s9giRFWqMaYSSe99ViwhjcXV5G5leS2vZPERJI9bGsKwrrrvnk
         T/zzuBYsvBp00OVE6qfLtDvQCdy9ufdNzmoM3DycGfzRVE0Ge/Bz8zde7FwOFvqGsE7Z
         sy68gfK4VJplx5Q4Eo0z17I82Cn/AuzldqnVXfjLSW2FiONFiH/P7SYYdXz5GuoNiHhX
         faGg==
X-Gm-Message-State: APjAAAW36naq8d9fgFEvcAGNlrueuqKF2ZERO3w2A1oSXkmQH0PXO4p2
        1GV+R60aN4CdT5Y5m8dG9/+Sdyrw
X-Google-Smtp-Source: APXvYqyIDIyQH+wxnyQ43wMrMEc7zy9I5q6GvixZCd4ZmGs++uwhGKLQq8Lj79Z133rV7pXJmP3mfg==
X-Received: by 2002:a2e:9985:: with SMTP id w5mr293360lji.162.1574095891151;
        Mon, 18 Nov 2019 08:51:31 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id t15sm4593889lff.15.2019.11.18.08.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 08:51:30 -0800 (PST)
Subject: Re: [PATCH v5 07/11] cpufreq: dt-platdev: Blacklist NVIDIA Tegra20
 and Tegra30 SoCs
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191118164512.8676-1-digetx@gmail.com>
 <20191118164512.8676-8-digetx@gmail.com>
Message-ID: <2776e3c7-999e-5e6f-3a0e-211226dc30e6@gmail.com>
Date:   Mon, 18 Nov 2019 19:51:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191118164512.8676-8-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.11.2019 19:45, Dmitry Osipenko пишет:
> Both NVIDIA Tegra20 and Tegra30 SoCs should be blacklisted because CPU
> OPPs use supported_hw and thus platdev isn't suitable for these SoCs.
> Currently cpufreq-dt driver produces a bit annoying warning splats
> during boot because valid OPPs are not found, this will be fixed once
> tegra20-cpufreq driver will be update to support cpufreq-dt. The warnings
> will also happen on older stable kernels using newer device-trees, thus
> this patch should be backported to stable kernels as well.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 4053aa65c517 ("ARM: tegra: cardhu-a04: Add CPU Operating Performance Points")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index f1d170dcf4d3..aba591d57c67 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -121,6 +121,8 @@ static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "mediatek,mt8176", },
>  	{ .compatible = "mediatek,mt8183", },
>  
> +	{ .compatible = "nvidia,tegra20", },
> +	{ .compatible = "nvidia,tegra30", },
>  	{ .compatible = "nvidia,tegra124", },
>  	{ .compatible = "nvidia,tegra210", },
>  
> 

Hello Viresh,

Could you please pick up this patch for v5.5 fixes? Thanks in advance!
