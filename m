Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AAA29C92D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 20:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1818373AbgJ0Tpn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 27 Oct 2020 15:45:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37443 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372241AbgJ0TpD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:45:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id o18so2711118edq.4;
        Tue, 27 Oct 2020 12:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UXr3lQx2eUfq+7HOUXuSZyZipQWceSUVylQzeIR2XHY=;
        b=k2bp+zUNx3D42YVNTRuRKULdR6PxzohVwvXlprjLA8zzXvBIuU1gkU+BiOfCgTp17y
         MmLOiuO8Dj+jMngFlL58uNZTfUR4BPGHqnFpVdnXIDKrFtAdCfHsZEDFtx9XHHup+lTO
         iBXXJO4HvuKX9KntZjMIbfzrZIBKdgpq3o88FlDiCiSNtuIiCfnh+oLN73WBeYXRWpQE
         /mimuwnfu73qilolMc6QILZd2Od9IH/k8Is1HrxdXr80aIjB0Tfxt2xHtfnjdF528j9o
         EzATmXGalZ9f4ywvEdjw+tShWOKgOKhBuOor9V65y/jaVmO0CJU3JeCqllsyOv3EoK5K
         WgKQ==
X-Gm-Message-State: AOAM5334bEY71tkCMWPhXXmw7Imr1p9Mb0LfoCjMHpa44PQ3EhGznL9X
        31LeNaTd6DPOg7JiwLiZFjs=
X-Google-Smtp-Source: ABdhPJwaxWnGgOULlhmBmWWDlDdWjWRSKpmgBSzdn7UsD1QIbybKhpRsl5k1KJK25+ecpRYHlVMGNQ==
X-Received: by 2002:a05:6402:187:: with SMTP id r7mr3826580edv.360.1603827901570;
        Tue, 27 Oct 2020 12:45:01 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id bx24sm1609885ejb.51.2020.10.27.12.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:44:59 -0700 (PDT)
Date:   Tue, 27 Oct 2020 20:44:57 +0100
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
Subject: Re: [PATCH v6 08/52] dt-bindings: memory: tegra20: emc: Document
 mfd-simple compatible and statistics sub-device
Message-ID: <20201027194457.GD140636@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-9-digetx@gmail.com>
 <20201027090212.GG4244@kozik-lap>
 <1cce314a-1eab-61c9-099d-54f987b03761@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1cce314a-1eab-61c9-099d-54f987b03761@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 27, 2020 at 10:22:19PM +0300, Dmitry Osipenko wrote:
> 27.10.2020 12:02, Krzysztof Kozlowski пишет:
> >> @@ -31,17 +32,34 @@ Example:
> >>  		...
> >>  	};
> >>  
> >> +	emc_bw_dfs_opp_table: emc_opp_table1 {
> > Hyphens for node name.
> 
> We already use underscores for the Tegra CPU OPP table.
> 
> https://elixir.bootlin.com/linux/v5.10-rc1/source/arch/arm/boot/dts/tegra20-cpu-opp.dtsi#L4
> 
> What makes you think that hyphens will be a better choice? Is it a
> documented naming convention?

Unfortunately that's the source of confusion also for me because
Devicetree spec mentions both of them (and does not specify preferences).

The choice of dashes/hyphens comes now explicitly from all dtschema
files.  Previously, the documentation were emails from Rob. :)

Best regards,
Krzysztof

