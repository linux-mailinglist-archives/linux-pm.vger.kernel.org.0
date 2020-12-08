Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A63B2D2E16
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 16:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgLHPWf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 10:22:35 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:35716 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgLHPWf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 10:22:35 -0500
Received: by mail-oo1-f67.google.com with SMTP id s1so856704oon.2;
        Tue, 08 Dec 2020 07:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C5Acc0ICokF2oxfe/fuyTY8R9eWUIjutjVKsOg+au2o=;
        b=HdgtGPkBHwKnoSPaQCEJu1VYFfv0DGga8UGoqNXuucqyaqbIttMsdp0IpyvwFApCNB
         hwLxce6yaYxQQyu73Tck0znCJCPlhrktZLu8iCyNlCOuRXsOH5+H5kdxGSTsUBA90NBG
         mWVmLIi7gPv8Gz/njrQIXfHEdzyt29bQnaMhc2UbLPJn/1H0nNw6Zchrko/4N/RlS8HJ
         0P6x9eFzkRl25w6LVF82ZibDNJzGux/rs+kKDeCKn8ZvHvoSSiLVe9+QTpwcSFm5BjG4
         acDGk+qQ8X4JowGmSoNL1tX4KzQzaiSYi3qX02l7K98xBk2F5qQ1DiIl25GUl8Qw3na5
         mwfQ==
X-Gm-Message-State: AOAM530RIPhcGrIC4XDuX0es8z+mJ++2/SrMv5Rr4VMhPdlulPioRvr3
        bxcglKSDkQBaHiw7KgkI4lnPJZKesg==
X-Google-Smtp-Source: ABdhPJzkmdNmqS+dh2m97q/lOIeF2VXeYq7Y+mxyU9jm4DamaV4w8FaJVykv1l78z5kmmyM5ayvK5A==
X-Received: by 2002:a4a:751a:: with SMTP id j26mr9483573ooc.68.1607440914338;
        Tue, 08 Dec 2020 07:21:54 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x12sm454432oic.51.2020.12.08.07.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 07:21:53 -0800 (PST)
Received: (nullmailer pid 2540461 invoked by uid 1000);
        Tue, 08 Dec 2020 15:21:52 -0000
Date:   Tue, 8 Dec 2020 09:21:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Klein <michael@fossekall.de>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>, linux-pm@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Documentation: DT: binding documentation for
 regulator-poweroff
Message-ID: <20201208152152.GA2539955@robh.at.kernel.org>
References: <20201128103958.q6glewhhch7vtczr@gilmour>
 <20201207142756.17819-1-michael@fossekall.de>
 <20201207142756.17819-3-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207142756.17819-3-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 07 Dec 2020 15:27:55 +0100, Michael Klein wrote:
> Add devicetree binding documentation for regulator-poweroff driver.
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>  .../power/reset/regulator-poweroff.yaml       | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/reset/regulator-poweroff.example.dt.yaml: regulator-poweroff: 'REGULATOR-supply' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/reset/regulator-poweroff.example.dt.yaml: regulator-poweroff: 'vcc-dram-supply', 'vcc1v2-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/reset/regulator-poweroff.yaml


See https://patchwork.ozlabs.org/patch/1412084

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

