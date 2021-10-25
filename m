Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100D1438EFF
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 07:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhJYFwT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 01:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJYFwS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 01:52:18 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47929C061764
        for <linux-pm@vger.kernel.org>; Sun, 24 Oct 2021 22:49:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id v193so3002049pfc.4
        for <linux-pm@vger.kernel.org>; Sun, 24 Oct 2021 22:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OLUoFvcnXJsV36mII3CYYj12VXrTqki3jWuDbCES2JY=;
        b=aZ5rRalBvppMi6hMByu2QUpaLsQPfMvCLFX7TRHT9r4r/G9SakxDcLidS9C0GW7yCp
         SmQVeYm6/BO3MNgAwLNhy3XwvPEmmvkEMavby+ILxLFwwuNCyZfUfrRaFFPriWgxo7qR
         KxG2TOLYwPopmjtq80qPFfAmSXGQr/OvpOHPvk4pVth2vFQdKQwze1nz13KOjqmDHMgR
         3K0OyX4hKR/y7WyWRHvW0LQZoaOHE3BWfekI6pF1fJeHjWvEPj7UdMCVzHOebi6P4hc9
         YDpuiHZwhaVk5aHjergWUAq4Nf/Jtz/a36/p8RGn2OKgjKxAB75NPQH2utPE2iFzN059
         odoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OLUoFvcnXJsV36mII3CYYj12VXrTqki3jWuDbCES2JY=;
        b=ytgwNP58LLTkgbvFe4New/vkPKehdIPeZWiJDKrt+btNbJCo+d6fj0tj0lHK6cpjMm
         c4+tbURZDnhgfOUionsqrswhUCkCkDwCgWh8Bpm3mxcYZHKZnCY6Ktraqf1ojGgKrRBz
         LUer7U+WsdDyEuH6X8M2g03p1ORf+tywfpXg46vUJ2Un7pbGeneHT/1O+YY8wTfTKzSS
         LTIZhitdgMTtstyB6J7Z2Q4YJqMhDtUnbdzezKMqX34HXZFw4os3jwqgJpHhgyxxxTkY
         T9+YPGHCEPc1mFsMiUAUvfM/n8sxFG06z+6hM+KNgpfR4MPte5sxz1nUDLc2GdQgfQLI
         OPmg==
X-Gm-Message-State: AOAM531aZqcwUqiJRDZue3xwq61TMyfH/qi6K21O3fZzaCFgZRjczm9l
        7IzXhjWCPLYD93+fuPYV3Fhzrcw2J7D2Og==
X-Google-Smtp-Source: ABdhPJwL1/cRZr7pvL5hQi8o1HypAK9RyoatX0kbtdbUPv35NBh8PjOwqVSlxwyYLD8fcdQ2bkGV2w==
X-Received: by 2002:a05:6a00:2309:b0:44d:bc24:4db8 with SMTP id h9-20020a056a00230900b0044dbc244db8mr16416348pfh.84.1635140996832;
        Sun, 24 Oct 2021 22:49:56 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id x190sm783655pfc.212.2021.10.24.22.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 22:49:56 -0700 (PDT)
Date:   Mon, 25 Oct 2021 11:19:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: opp: Allow multi-worded OPP entry names
Message-ID: <20211025054954.4oab47n7p6iga4m2@vireshk-i7>
References: <20211024215718.28969-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024215718.28969-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-10-21, 00:57, Dmitry Osipenko wrote:
> Not all OPP entries fit into a single word. In particular NVIDIA Tegra OPP
> tables use multi-word names where first part is freq and second voltage
> because different hardware versions use different voltages for the same
> freqs. Allow OPP entry to have multi-worded name separated by hyphen.
> This silences DT checker warnings about wrong naming scheme.
> 
> Reviewed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v3: - Viresh Kumar suggested that we shouldn't support postfix variant.
>       I dropped variant with postfix naming scheme and multi-wording
>       support of table names.
> 
> v2: - In addition to a multi-wording support, support of the postfix
>       *-opp-table naming scheme is added to the updated pattern.
> 
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> index ae3ae4d39843..f79343960539 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> @@ -33,7 +33,7 @@ properties:
>      type: boolean
>  
>  patternProperties:
> -  '^opp-?[0-9]+$':
> +  '^opp(-[0-9]+)*$':
>      type: object
>      description:
>        One or more OPP nodes describing voltage-current-frequency combinations.

LGTM, will apply once Rob Acks it.

-- 
viresh
