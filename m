Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBC22A9923
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 17:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgKFQLQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 11:11:16 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:42436 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQLQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 11:11:16 -0500
Received: by mail-oo1-f67.google.com with SMTP id l26so449077oop.9;
        Fri, 06 Nov 2020 08:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HN4/Ao9ND5kWPrJpplFKhhNeDLISzsw+TAUT+PBf3p4=;
        b=UXwW39HyqUV1L2buG2f1HKlCreTav7UNDIhw2ZRSQwKWnXxfB6N7U6hiCY1fM8v6nC
         mru0LWHS0HTu0ywDcWAyqcUzudtkG6ZiXPQts5I2WSI37r2M1ZJzICfBj9aUdHEd7Jmi
         bPnDkEg28Twl/AicPjKCwVfxJJ4dz/pLTbrwu3b9bw3j579QieoHL055oSO9g3IZExTR
         v64lm8E9Yh7hh2QdP8LA974D8qqonGr1dlN4+TEzCXSVhPzUjCW8rA5nYmuZAjQtnHVG
         4QLkSWzoQszPzIyuZZybYSzwfju4N0JPUkyMbOp5WMlaraUQQFtgI7bEDJrt2sPtt87r
         LrjQ==
X-Gm-Message-State: AOAM533V2emhmTGoRqmWx+cT00qZlAtpehxktDDXsvWp+piqa+sUr1Xr
        6FKKcH39BmabzfDROFlH5w==
X-Google-Smtp-Source: ABdhPJz1ro/xPYZgk6r7xGiMrr0SAv+jPDZ0HJuQF0/8A2hmlkJcgCQpYNkiQBaIolsmcZwji4ImqQ==
X-Received: by 2002:a4a:b148:: with SMTP id e8mr1751178ooo.65.1604679073623;
        Fri, 06 Nov 2020 08:11:13 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h136sm355294oib.19.2020.11.06.08.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 08:11:12 -0800 (PST)
Received: (nullmailer pid 3290121 invoked by uid 1000);
        Fri, 06 Nov 2020 16:11:11 -0000
Date:   Fri, 6 Nov 2020 10:11:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: mfd: Add ENE KB930 Embedded
 Controller binding
Message-ID: <20201106161111.GA3289870@bogus>
References: <20201104203403.24937-1-digetx@gmail.com>
 <20201104203403.24937-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104203403.24937-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 04 Nov 2020 23:34:00 +0300, Dmitry Osipenko wrote:
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


See https://patchwork.ozlabs.org/patch/1394517

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

