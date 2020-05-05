Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9D1C5B96
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgEEPiX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 May 2020 11:38:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37259 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbgEEPiX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2020 11:38:23 -0400
Received: by mail-oi1-f194.google.com with SMTP id r25so2335440oij.4;
        Tue, 05 May 2020 08:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kqQrkElLVWgKrW0ocIK6no1Eo72/15ji6o+a599XdUg=;
        b=CfrW0kZs1N7xQV8YSJo4KJASPyM3oQVRbxwp7dA2dnXgoBSBlOU7YUlIS0xJc8LuPn
         /u2WkdAJF0NhnLM1tjTvvzPxU623oE7kZveH8TCciBLIRe8q9bFz5wKwWqakiCLmujIX
         nEXLwlIyvFhb1VEby7nld0ii9WUb+YfmhuwU4gzNwxli4LOorPvxweka8IIDDi2rFt8T
         dyBpyl+FRLyvyI1Amso0EI+qE0b7isQVzUz9W3ijjDwxqYKFtxmsOjFba0NXcJDglQgU
         apJIIXyMBdgmnh/k0pVrMqYcK5PSTVEftW+azO9kUWhaXgjlWzCOwzHNin3XzGNlATAS
         Y6nQ==
X-Gm-Message-State: AGi0Pubnz5beSXZjdv7yPFLZoCQSpYvjKaPt2feb1xjhFGYwsDu6UleQ
        w6j6/4g08jFbVAi4/snOPw==
X-Google-Smtp-Source: APiQypKYusD1gPoY+0joGmEA7TK8cSMo/0ZQO2nI0p43i7rGC3r3RtktHEbFfvgfs6RduoaUzLO7zg==
X-Received: by 2002:aca:5806:: with SMTP id m6mr2830103oib.178.1588693102213;
        Tue, 05 May 2020 08:38:22 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p17sm656724oot.17.2020.05.05.08.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:38:21 -0700 (PDT)
Received: (nullmailer pid 28227 invoked by uid 1000);
        Tue, 05 May 2020 15:38:19 -0000
Date:   Tue, 5 May 2020 10:38:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Subject: Re: [PATCH 2/2] dt-bindings: thermal: tsens: Add zeroc interrupt
 support in yaml
Message-ID: <20200505153819.GA19181@bogus>
References: <20200505111204.963-1-manafm@codeaurora.org>
 <20200505111204.963-3-manafm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505111204.963-3-manafm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue,  5 May 2020 16:42:04 +0530, Manaf Meethalavalappu Pallikunhi wrote:
> Add 0C (zeroc) interrupt support for tsens in yaml.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-tsens.example.dt.yaml: thermal-sensor@c263000: interrupt-names: ['uplow', 'critical', 'zeroc'] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-tsens.example.dt.yaml: thermal-sensor@c263000: interrupts: [[0, 506, 4], [0, 508, 4], [0, 510, 1]] is too long

See https://patchwork.ozlabs.org/patch/1283470

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
