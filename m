Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E136298D50
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 13:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775783AbgJZMyE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 08:54:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36013 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773220AbgJZMyD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 08:54:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id y186so3254966oia.3;
        Mon, 26 Oct 2020 05:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yKhaiyp8o4C1y5luwNhjTKE76jL0ByEm2cHFMlzWIhk=;
        b=tdmczljyldK6Msd3NJ2b8nUoyRGDdvA8pwPfW9Qiy73wUo/YwX05/8U03b+eqlBXzz
         +1/677ukU/lW7IDgDOL7l3DYyMZU+6zoAg8ux9+4Fgl1SJp4EYbiiUsqb37IrfZKhTVq
         0wFYLPEmo7kFaB1Og3Fy8k6unxCJ8uXj28Z6Vsg7/JmnCQahvi01XFxL6WMSbSe4ViqM
         CQn4CxRbL8I6ts5HF+RfOr472IIwPlcYqExkjIwEoxcvcFVUeeyB8T2V8xfBChV5Mn4O
         4FjuL/RBqh7KkstdYCuib/4cioDRNY3dfTnA/qAvtiLsZTTCVsjjJNSIidCdsUt0mxN0
         ByoQ==
X-Gm-Message-State: AOAM532fE9n+bAEJvl2P2iyubZqx7c8D6khoSqE/PGDGrhUqChEJ5vtM
        onxqLIsPIVIR5eWVGKJ5jQ==
X-Google-Smtp-Source: ABdhPJybZJ5oswZfP815J5Hc0QpjQXYiSS307yqcvpo6u3h8YYof7K/iDB4HdQOIkBYqDLqj8Xt2Uw==
X-Received: by 2002:aca:3687:: with SMTP id d129mr6612346oia.100.1603716842449;
        Mon, 26 Oct 2020 05:54:02 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m65sm3499761otc.36.2020.10.26.05.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:54:01 -0700 (PDT)
Received: (nullmailer pid 4173474 invoked by uid 1000);
        Mon, 26 Oct 2020 12:54:00 -0000
Date:   Mon, 26 Oct 2020 07:54:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, Dan Murphy <dmurphy@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH RESEND v4 1/4] dt-bindings: mfd: Add ENE KB930 Embedded
 Controller binding
Message-ID: <20201026125400.GA4171254@bogus>
References: <20201025230153.11729-1-digetx@gmail.com>
 <20201025230153.11729-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025230153.11729-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 26 Oct 2020 02:01:50 +0300, Dmitry Osipenko wrote:
> Add binding document for the ENE KB930 Embedded Controller.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/mfd/ene-kb930.yaml    | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/mfd/ene-kb930.yaml:20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/mfd/ene-kb930.yaml:22:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/ene-kb930.example.dt.yaml: battery-cell: 'operating-range-celsius' does not match any of the regexes: '^ocv-capacity-table-[0-9]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/battery.yaml


See https://patchwork.ozlabs.org/patch/1387346

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

