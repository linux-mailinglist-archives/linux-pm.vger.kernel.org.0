Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56507334C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 18:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfGXQEC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 12:04:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43967 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfGXQEC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 12:04:02 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so90675124ios.10;
        Wed, 24 Jul 2019 09:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RIcJtepW5SbcfF+LiygeiBx7jJNlGPWMOmmQrsLTmRQ=;
        b=qhUCgp+e+5zS0HXPwzXAZL89koL7YPSpxfSkkc0bLa007Ucw/ti3a2GVmYhCwdgEPf
         JcRXdspjuFy4cL6/hdDDOGnHMjE2soVBTDcywXm6Ire69neEOzl1YBWIkab8E4JqHBXq
         2MTjRQFnotDy0HJWCftHp6t1xa676RB/K15f8RrXUJsstGP0f7CNqWUYImr0AgZ+Uu51
         NOloyPbsICJCoBErdoJqc6odVDSFim+QXrLOZw2tG1fn1pqzmduxiyCKctEtsT1zYxIR
         5piiGrrZJWwfPt7Ya91DNL0MBtLPTN0n6HU9+NutZ2AgE03b3U7u3/1R/ugdzWJ7biKC
         d2dQ==
X-Gm-Message-State: APjAAAUHngIJmwGrUX79q8/iJnCzo5sJtOtsxWa0cfEZhuXME7uY6Xnp
        Jr4a1Cqh9pOiCOzLibDg+wKm/zY=
X-Google-Smtp-Source: APXvYqzrgInPMnaXzJdtgj8Jcq9ver6WG+45y2sE5vAfKJszqQFf+gX9pP0NAZ63WyASWT15x2Rh+Q==
X-Received: by 2002:a02:13c3:: with SMTP id 186mr84298115jaz.30.1563984240969;
        Wed, 24 Jul 2019 09:04:00 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id t133sm69197601iof.21.2019.07.24.09.04.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 09:04:00 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:03:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] dt-bindings: opp: Add qcom-opp bindings with
 properties needed for CPR
Message-ID: <20190724160359.GA32565@bogus>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
 <20190705095726.21433-9-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705095726.21433-9-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 05, 2019 at 11:57:19AM +0200, Niklas Cassel wrote:
> Add qcom-opp bindings with properties needed for Core Power Reduction
> (CPR).
> 
> CPR is included in a great variety of Qualcomm SoCs, e.g. msm8916 and
> msm8996. CPR was first introduced in msm8974.
> 
> Changes since RFC:
> -Removed opp-hz. It is already an optional property in opp.txt
> so no need to specify it with the same definition here.
> 
> Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  .../devicetree/bindings/opp/qcom-opp.txt      | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
> 
> diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> new file mode 100644
> index 000000000000..f204685d029c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> @@ -0,0 +1,19 @@
> +Qualcomm OPP bindings to describe OPP nodes
> +
> +The bindings are based on top of the operating-points-v2 bindings
> +described in Documentation/devicetree/bindings/opp/opp.txt
> +Additional properties are described below.
> +
> +* OPP Table Node
> +
> +Required properties:
> +- compatible: Allow OPPs to express their compatibility. It should be:
> +  "operating-points-v2-qcom-level"
> +
> +* OPP Node
> +
> +Optional properties:
> +- qcom,opp-fuse-level: A positive value representing the fuse corner/level
> +  associated with this OPP node. Sometimes several corners/levels shares
> +  a certain fuse corner/level. A fuse corner/level contains e.g. ref uV,
> +  min uV, and max uV.

Doesn't match the example in patch 5.

> -- 
> 2.21.0
> 
