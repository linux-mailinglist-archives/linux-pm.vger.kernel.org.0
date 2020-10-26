Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0745298D1E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 13:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775547AbgJZMt5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 08:49:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35440 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775402AbgJZMtz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 08:49:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id w191so10363204oif.2;
        Mon, 26 Oct 2020 05:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oAb942PkprtooTAkcphjHuX+nYeTcTWj5DRWfq1D+/8=;
        b=Fx6+ilX6zNcVEWQN8GzHs7PNSN/U6Ek3Mx9Rf6K5EDSvm+vRCY9B8JSNm0Qtw3l1GK
         eAtasA91pHu53a7Gia4e250hXe7fNk7b6kSb2iHnPyMk1Ic6N4cmFLqyyGloKYtH9B5A
         4tLCTTcjSrQLXpxuIz/ZXiSCAKiiN9OpYHnE0GVkCKTVJH7XBkUWXxhmyghJ/ejN8/qK
         1CqelbDtDymm5nXUV7z41rFYeGsCK6N1SZ71JsdDIA3KFYGc6B4tjrvZ7wrgmC975vMB
         aPtIn9yt0pBTur3XMFiTgWp4H5CIqxDvfLctkqfGjtHVhQ31XfITOdjrIWXeTt9Z/HJ+
         TPcA==
X-Gm-Message-State: AOAM532NG6N60Q2vakqk/pRk6yGguszYbzLzWMn8QnxUv3Pft7YiZxh/
        dlB4fGVR5NXPgl7/yn+LKQ==
X-Google-Smtp-Source: ABdhPJyw8X8wHgRmnVOj73HYL5Yt/7SSSmhyblzN5O3WGOsS2MFEvEEq1YMx197Ky6/S+smUlunNeA==
X-Received: by 2002:aca:4e4b:: with SMTP id c72mr969519oib.96.1603716594205;
        Mon, 26 Oct 2020 05:49:54 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b8sm3824400oov.29.2020.10.26.05.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:49:53 -0700 (PDT)
Received: (nullmailer pid 4167734 invoked by uid 1000);
        Mon, 26 Oct 2020 12:49:52 -0000
Date:   Mon, 26 Oct 2020 07:49:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        dri-devel@lists.freedesktop.org, Mikko Perttunen <cyndis@kapsi.fi>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH v6 12/52] dt-bindings: memory: tegra124: mc: Document new
 interconnect property
Message-ID: <20201026124952.GA4166359@bogus>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-13-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-13-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 26 Oct 2020 01:16:55 +0300, Dmitry Osipenko wrote:
> Memory controller is interconnected with memory clients and with the
> External Memory Controller. Document new interconnect property which
> turns memory controller into interconnect provider.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra124-mc.yaml      | 5 +++++
>  1 file changed, 5 insertions(+)
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.example.dt.yaml: memory-controller@70019000: '#interconnect-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml


See https://patchwork.ozlabs.org/patch/1387321

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

