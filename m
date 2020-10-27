Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E0F29A80A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 10:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895737AbgJ0JmR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 05:42:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46569 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895736AbgJ0JmQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 05:42:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id 33so696998edq.13;
        Tue, 27 Oct 2020 02:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lHBBkHuI0IUnOYJdkmLUqOouaAvwVU9iVEiJW9WoiK0=;
        b=I7Vin3CsZp+ryTWOH6S6g5E5lehY6iWOkdwUj551VB260HcAeQo/M4DeiiTrwrlH5c
         anA7G3XDjEIVEDNrJeG4tYu2LeyQsFbM1ygpQOyKBuiqVKjOJzUTODygdCxIKlvpcWFB
         rCAli1wpLoULxWA5Bz4JUFuCGlAyPnYL9uIkv78uhvgneUJE9vXvP8NW2Hz+2y4IBhr9
         5H7CC7PzQwId7S1kipZGusryeDTPWhImHQ8bwI/wYrLbffKnyuQlWUHzZ4DJlfhnYalT
         8AA25e2uMdJrgFWox+ouLJZsZ0H44phdVVTCwldMG1QNbnYBi+m/M5mVemFCO2ElVUUS
         fyPg==
X-Gm-Message-State: AOAM53107Yo+jMMESb55d9vOKw21OcWV3ZE9ejL/GUejiqFeGjwV+Qce
        wbFkRYMMwRYfhWGoHVQxnq4=
X-Google-Smtp-Source: ABdhPJz72Eh4ixWHKjawYoG+VJV8TMQNsshX247FygzKAqPkSLsgpy1VBkkcxgwv76i5r6OyRrv9sw==
X-Received: by 2002:aa7:c608:: with SMTP id h8mr1255855edq.16.1603791734178;
        Tue, 27 Oct 2020 02:42:14 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id p17sm610248edw.10.2020.10.27.02.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 02:42:12 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:42:10 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 28/52] memory: tegra: Add and use
 devm_tegra_get_memory_controller()
Message-ID: <20201027094210.GD10762@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-29-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-29-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:17:11AM +0300, Dmitry Osipenko wrote:
> Multiple Tegra drivers need to retrieve Memory Controller and there is
> duplication of the retrieval code among the drivers. This patch removes
> the duplication and fixes put_device() which was missed in the duplicated
> code.
> 
> EMC drivers now use new common devm_tegra_get_memory_controller() helper
> instead of opencoding the MC retrieval.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c                | 48 ++++++++++++++++++++++++
>  drivers/memory/tegra/tegra124-emc.c      | 18 ++-------
>  drivers/memory/tegra/tegra210-emc-core.c | 39 +++++--------------
>  drivers/memory/tegra/tegra30-emc.c       | 18 ++-------
>  include/soc/tegra/mc.h                   | 10 +++++
>  5 files changed, 74 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index ec8403557ed4..12ea2c79205a 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -42,6 +42,54 @@ static const struct of_device_id tegra_mc_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
>  
> +static void tegra_mc_devm_action_put_device(void *data)
> +{
> +	struct tegra_mc *mc = data;
> +
> +	put_device(mc->dev);
> +}
> +
> +/**
> + * devm_tegra_get_memory_controller() - get Tegra Memory Controller handle
> + * @dev: device pointer for the consumer device
> + *
> + * This function will search for the Memory Controller node in a device-tree
> + * and retrieve the Memory Controller handle.
> + *
> + * Return: ERR_PTR() on error or a valid pointer to a struct tegra_mc.
> + */
> +struct tegra_mc *devm_tegra_get_memory_controller(struct device *dev)

Usually 'get' is a suffix (for example in clk, gpiod, iio, led), so:
devm_tegra_memory_controller_get()

Best regards,
Krzysztof
