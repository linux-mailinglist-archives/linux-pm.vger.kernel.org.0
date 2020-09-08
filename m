Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1910E2609BB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 07:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgIHFAd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 01:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgIHFAc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 01:00:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E760DC061573
        for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2020 22:00:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so4434832pjg.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2020 22:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=p5I0f0cr9Zk0jbT8NfArDdE5a/xV5YyqTPOFrjxdFJs=;
        b=mzrxN6sva0MNjzdM0DxiM8w2ccXXm4iFw5E6I2j2XdD5sGSKe26zraZmMOHcvsnLfc
         QsttZK0WhSqxiR64Pu+SbGRTt7t08s8jdt1gPY0+u+0iAuvbceTw8+cEZIP3S47svbDC
         h8Ce2PULmRcOYOY6vGRiUkKLLjp2ypuLFuuRuDWfZ3FW5MMsOAcvcOScvq5BY+md85l9
         Myr8ZbYqy7zKovK1H5howGAfb6OmNDkWKIS4uYEjy/oY2DuY0FHNCUCLf/F98PTU4M+T
         3g6cklKHKYTgezaTLwSGhv0/GhLNhjWbRYG9NHKSGyVs5xDSjjqcWDTtlMJRaEA6wgzE
         ZGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=p5I0f0cr9Zk0jbT8NfArDdE5a/xV5YyqTPOFrjxdFJs=;
        b=q24L0yWVYkC6qwT1FHCPeLgf/i3FF0o2r1Pj5dB+i/wAzm4qJUdUhauyy7RkZ4+M6b
         6Pcm8HeEM8/mOjCYquQQ1bAYdZPyrMfCd3oFpdiiXVB6ijwk7lSnXn1gXr2wyTYFUkPq
         GqXG3/vuwREqhCu5YvO+7hvK+dUIQXarMKPCh5/LPDCjaxBuSvKfZSucqSoKH7NSZTcS
         IdBfeNAnbTyFYA0fDSYO0YO9JgzYmWBFgOnaPytN71qbKWoAdxeQxNw4knUreY739IS7
         xZxthe5S5ddTnxPkghiJFmTiNgtsKlPGPXZK/g5W/DL51IHgWzO2pDeD7H6HmvIy1O2+
         o+aA==
X-Gm-Message-State: AOAM532a9VJOL1akd7GHAfX3GjC0dXsBxYYdyqwLM5hgZG64+fnHzSg4
        LZoMz9fPOBr2Ndh+5YewLkUqIg==
X-Google-Smtp-Source: ABdhPJxDIlLMncfQswJITWdvDIrZGm4T2rg/FBTogDVPm/HS7Q//GjaFcvSbV2iii/s2mq4LYOgL+A==
X-Received: by 2002:a17:90a:5805:: with SMTP id h5mr2221277pji.236.1599541229578;
        Mon, 07 Sep 2020 22:00:29 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id v91sm15250081pjv.12.2020.09.07.22.00.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2020 22:00:28 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:30:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: armada-37xx: Add missing MODULE_DEVICE_TABLE
Message-ID: <20200908050016.chsqxsnzyl4mnpfa@vireshk-i7>
References: <20200907132716.6379-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200907132716.6379-1-pali@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-09-20, 15:27, Pali Rohár wrote:
> CONFIG_ARM_ARMADA_37XX_CPUFREQ is tristate option and therefore this
> cpufreq driver can be compiled as a module. This patch adds missing
> MODULE_DEVICE_TABLE which generates correct modalias for automatic
> loading of this cpufreq driver when is compiled as an external module.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Fixes: 92ce45fb875d7 ("cpufreq: Add DVFS support for Armada 37xx")
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index df1c941260d1..46f33c3a7316 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -484,6 +484,12 @@ static int __init armada37xx_cpufreq_driver_init(void)
>  /* late_initcall, to guarantee the driver is loaded after A37xx clock driver */
>  late_initcall(armada37xx_cpufreq_driver_init);
>  
> +static const struct of_device_id armada37xx_cpufreq_of_match[] = {
> +	{ .compatible = "marvell,armada-3700-nb-pm" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, armada37xx_cpufreq_of_match);
> +
>  MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
>  MODULE_DESCRIPTION("Armada 37xx cpufreq driver");
>  MODULE_LICENSE("GPL");

Applied. Thanks.

-- 
viresh
