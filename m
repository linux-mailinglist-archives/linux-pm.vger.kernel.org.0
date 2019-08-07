Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01FFD8485F
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 11:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfHGJFM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 05:05:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43767 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbfHGJFM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 05:05:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so32800083pld.10
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2019 02:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J4ZFvTXe+zTVR2M5ZBZS8AXmh/aoWceUxNcpzmTU7Uw=;
        b=NsPlvCGahqKL6UxzvtvcHQ/HirhN9BDf2ppat0hC9TPHLVHpLY9s95fX53JbOZhIPv
         Z5XqIT9H203n8G5v+pSp8n0/cBfYjp2MuhBO5wrt6xGk3Tfkrkx7ezxyYP2PEUC7ad0h
         89yaIBfX97z/Gmvkc3MkqlFkxhhlVROqzzJ/N5yrKpCOFHGeKlvAYExc7qHGZ522Fi2U
         Wd9eS+4FG6mg/W+Tw5mmnd3tJhOABj3QAEV8GuNja20qzp4WsEK1RiayBgMNBz6psTj4
         1yu4jjzu/fWjMbycIl+hd3h3GJ3rXM7uJsTVcXiGvcxH5H3lFqGbwJzBKQiYBTkLjxhq
         A+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J4ZFvTXe+zTVR2M5ZBZS8AXmh/aoWceUxNcpzmTU7Uw=;
        b=Yt9k3/7I9AyEvbMAm6Tm/vKBaoanqvUX3AWrPsiLtbdYhUxFsXVrqlSKbocwtBBiRv
         mSOp6BrN6X8uEn+vG5EwT20rd/QjrcMnGpbBjijyABWbEdz3NUj3826sKr0KBBDJLWy2
         CQUr09Qe8/voXprFnajhrPPewHNQ5vp2FtxVNs/sM8KVDQOl7pV2sZoyXmxriyIdELs3
         re1ZYvyIyCuAJSnaIzyLdEzxH1nywi54gwTFQWC5tN7QWt9tyDsRMtUQdMUYp27F74AM
         7gIgV6HTJvFE8nBRjyAwQhJp0fbKkOKRV5uDxJ+B+kq3+zAZ/CaMxyazGDFReLDeXr1h
         tdrA==
X-Gm-Message-State: APjAAAWpNat+w583hxILUWDFRwefnS009uGtwj+4q1ActypIZt5mccSV
        6O3L1pkgJFSJGrKCIykslspoBA==
X-Google-Smtp-Source: APXvYqwfH6D7XhoDyWG2BYBL/s5POj834n5L7zMUmOgrJb8o7wh9ak/X/IpezahPVk9H4JXKtlfOkA==
X-Received: by 2002:a65:68d9:: with SMTP id k25mr6855707pgt.337.1565168711202;
        Wed, 07 Aug 2019 02:05:11 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id 33sm103194231pgy.22.2019.08.07.02.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 02:05:10 -0700 (PDT)
Date:   Wed, 7 Aug 2019 14:35:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     rjw@rjwysocki.net, matthias.bgg@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek-cpufreq: Add compatible for MT8516
Message-ID: <20190807090508.vhc3o3jhmiooyr4m@vireshk-i7>
References: <20190806095029.4758-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806095029.4758-1-fparent@baylibre.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-08-19, 11:50, Fabien Parent wrote:
> Add the compatible for MT8516 in order to take advantage of the
> MediaTek CPUFreq driver for Mediatek's MT8516 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index f14f3a85f2f7..10bc06f5dd45 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -535,6 +535,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
>  	{ .compatible = "mediatek,mt817x", },
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },
> +	{ .compatible = "mediatek,mt8516", },
>  
>  	{ }
>  };

Applied. Thanks.

-- 
viresh
