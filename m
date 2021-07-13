Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF243C79C8
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jul 2021 00:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhGMWpl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Jul 2021 18:45:41 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:45921 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbhGMWpk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jul 2021 18:45:40 -0400
Received: by mail-il1-f174.google.com with SMTP id b6so15266187iln.12;
        Tue, 13 Jul 2021 15:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lsdCSpnf6ZiX83NlGYzoBdbib31n+VNXkgCApsj7nLM=;
        b=Z1Q/A5TNbwI2IdwMaC0xCigJJejksDH4+iY3IaOFrFm0GzpYSRGuBMLudA75lfUIJg
         Sl1HC/DHNwnnodlOsL/VqtrKq1Lzy1yPp0EBD3Zbq4Bo4FGP2sWTIvdmfNMleJqzJ7bY
         Ytm6EVOUoSzlegTZ4Wf9zYLHv9Uc2C38q+M9hdxyahVXzKojhVp4SIG2H44cZLhGRJAW
         O4CCe14x4WLjBc+jKn+l+58T65hA8TNfVxXw38oeQeJ1Epp20GT8/9mpNCWYomMSTz9g
         WBy/I9TncXUNRrPdBVWT3UTdgsQDB+xDzrH6uWIU56ksktfUoShzntivu+m66hhQcKuo
         AoqQ==
X-Gm-Message-State: AOAM530W1vEvEezVioQhyXLbfpeN7VkPfaS9um4Fb4UUpBUprAF/9OfW
        xh+Uzdh1OZFWLcdx9YY5hQ==
X-Google-Smtp-Source: ABdhPJyBP0Vwy0xP55H7Iy5+swmvS2mXaRlbYo72hNyvVC3lYhapXdsdp3wMpbQQcMkPLHtj0RgrfA==
X-Received: by 2002:a92:c883:: with SMTP id w3mr3687073ilo.76.1626216169897;
        Tue, 13 Jul 2021 15:42:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p10sm177941ilh.57.2021.07.13.15.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 15:42:49 -0700 (PDT)
Received: (nullmailer pid 985485 invoked by uid 1000);
        Tue, 13 Jul 2021 22:42:45 -0000
Date:   Tue, 13 Jul 2021 16:42:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jami.kettunen@somainline.org,
        paul.bouchara@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, jeffrey.l.hugo@gmail.com
Subject: Re: [PATCH v6 9/9] dt-bindings: cpufreq: qcom-hw: Make reg-names a
 required property
Message-ID: <20210713224245.GA981311@robh.at.kernel.org>
References: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
 <20210701105730.322718-10-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701105730.322718-10-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 01, 2021 at 12:57:30PM +0200, AngeloGioacchino Del Regno wrote:
> The property reg-names is required after the addition of the OSM
> programming sequence, as that mandates specifying different register
> domains; to avoid confusion and improve devicetree readability,
> specifying the regions names was made mandatory.

Can't take patches missing a S-o-b.

Making existing properties required breaks compatibility. That's okay on 
*all* the platforms using this? If so, that needs to be crystal clear in 
the commit msg.

> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index 29b663321a0b..17fd6a6cefb0 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -98,6 +98,7 @@ else:
>  required:
>    - compatible
>    - reg
> +  - reg-names
>    - clocks
>    - clock-names
>    - '#freq-domain-cells'
> -- 
> 2.32.0
> 
> 
