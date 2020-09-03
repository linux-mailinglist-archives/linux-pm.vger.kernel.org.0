Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8147B25C63A
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 18:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgICQK1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 12:10:27 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35034 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICQK1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 12:10:27 -0400
Received: by mail-il1-f194.google.com with SMTP id l4so3157741ilq.2;
        Thu, 03 Sep 2020 09:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ub/YDXcxHDsGS0dDuXZfKNg7N1487AgGtWs2ISNYV0w=;
        b=KO3s42VYbzabC5gmMd9r54DJ0SZxApw7havc6vUUF8c+m0HBQkdS9PSyAKB1PvDkhH
         xPVchF6YkwfTjUy2QW+KIRmp26MfNammQVt8hiqwWeqax2zvOH/ZH0XEAPFjKbSUtZWr
         AOpUEc4c6F6JWeM+1A2MLCuAxyxhmEV2KGkFrMvNduXNfnbwFsfx6Gc60eAgd/wkj91M
         rE371is2dFvMLtLDT3LCfU5Su/RIXy0cKVOq4qJJu2ahtsSYg6UW3K+lCPCM9AP84OqA
         G3zYj5tkqP/XuTz53YdQMGFYXpUyzDiACbiWAYHPWJs5RXXGISbcMRlFcdmuGF11Xijv
         VHJQ==
X-Gm-Message-State: AOAM531ISQGDoCUQVwcz0dk4IVQUZ5k0hjqgIIeLmvaXVlw+sIZktbYE
        YW4NaVXWeok470OX/Zxf6Q==
X-Google-Smtp-Source: ABdhPJxLZ9ZiPkSL+rOvAxAf3g+LEBXr7Jjhv24bCXU19LypWZMrwzhwOhCFPx9l8w9NZ9RW+7oU5Q==
X-Received: by 2002:a92:7991:: with SMTP id u139mr3437463ilc.62.1599149426172;
        Thu, 03 Sep 2020 09:10:26 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id c7sm1610386ilk.49.2020.09.03.09.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:10:25 -0700 (PDT)
Received: (nullmailer pid 2870752 invoked by uid 1000);
        Thu, 03 Sep 2020 16:10:22 -0000
Date:   Thu, 3 Sep 2020 10:10:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        linux-tegra@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: mfd: Add ENE KB930 Embedded
 Controller binding
Message-ID: <20200903161022.GA2707794@bogus>
References: <20200830185356.5365-1-digetx@gmail.com>
 <20200830185356.5365-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830185356.5365-2-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 30 Aug 2020 21:53:51 +0300, Dmitry Osipenko wrote:
> Add binding document for the ENE KB930 Embedded Controller.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/mfd/ene-kb930.yaml    | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/ene-kb930.example.dt.yaml: battery-cell: 'operating-range-celsius' does not match any of the regexes: '^ocv-capacity-table-[0-9]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/battery.yaml


See https://patchwork.ozlabs.org/patch/1354004

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

