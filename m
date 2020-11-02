Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8418F2A3170
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 18:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgKBRYS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 12:24:18 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44654 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgKBRYR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 12:24:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id m26so13292126otk.11;
        Mon, 02 Nov 2020 09:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/YrpkethS2j8QO8IRcDofvaDwCjqPfhR/1+7qq4d7g=;
        b=VJbU5PspvFOJCZMEvv9/Wpj4EOSekJjPuVkIurBnnRH03tn3SXiSUgk1eS2ifnvD3E
         NMeBWRxkMZh9ONrZgk2QRk26OfsPO8SXczsUv7/+ays+BLF6OkXoKFg1cx9ZN9Ib2rdT
         HvoVkuMw9cQwRrMnKEOrjCo4B9KxSzG+bOBQ5vwNV080xmrFiUlbprUB1JcHeGF7H1Om
         /i9bwdl4u+eJ7Df+nW2hDIkqwquzZyoWPvDEXHxbpleK96x9fTTgevBoEqUHyvNGkqiA
         k07SJIEUZ2ip3qu9qgArXGyzSws9tSTCmkfGS9cRT2VLokgbBA3WMOyyc2ktWfOqJdk0
         Sb3Q==
X-Gm-Message-State: AOAM533csCNvq/DsOyfL+PgKk3DobzRdQsrLTpSUJm0iqvR70v9VdOVP
        pvcqcP8iiW9kKrLJTJGVlwX3CwESrg==
X-Google-Smtp-Source: ABdhPJwjW84PZr6f6lPf4Z5p1grRTiYxv8VWUSIiLv5E/2IYXyIn7VH4L1wDxKMe6J/5TbpaLMqwAQ==
X-Received: by 2002:a9d:21c5:: with SMTP id s63mr13031908otb.171.1604337856583;
        Mon, 02 Nov 2020 09:24:16 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d26sm3746977otp.3.2020.11.02.09.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:24:15 -0800 (PST)
Received: (nullmailer pid 4076630 invoked by uid 1000);
        Mon, 02 Nov 2020 17:24:15 -0000
Date:   Mon, 2 Nov 2020 11:24:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: power/supply: Add ltc4162-l-charger
Message-ID: <20201102172415.GA4074876@bogus>
References: <20201102092039.16520-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102092039.16520-1-mike.looijmans@topic.nl>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 02 Nov 2020 10:20:39 +0100, Mike Looijmans wrote:
> Add support for the LTC4162-L Li-Ion battery charger. The driver allows
> reading back telemetry and to set some charging options like the input
> current limit.
> 
> This adds the devicetree bindings.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: Use microohms, add lltc,cell-count
> v3: Fix example dts to match description
> resent, previous patch mail bounced
> 
>  .../bindings/power/supply/ltc4162-l.yaml      | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/ltc4162-l.example.dt.yaml: battery-charger@68: 'lltc,rsnsb' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/ltc4162-l.example.dt.yaml: battery-charger@68: 'lltc,rsnsi' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml


See https://patchwork.ozlabs.org/patch/1392005

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

