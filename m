Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 576AA177CBD
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 18:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgCCRDw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 12:03:52 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42507 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgCCRDw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 12:03:52 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so3710620otd.9;
        Tue, 03 Mar 2020 09:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PjbKJGUmviegTrwgU+MLxk9QSGF2P0N3kmKzVENOADo=;
        b=X/ETlug2jLvRqFhMf/MV2YXOmsfdI+muug3dDS05HAkdd3Coa26SwShDPF9imAX+Yb
         3X7jYiK/+ubIiErHQ9bNt3rOHjoQYWpjGgVwHdM0VYoSP7OLPHvKju7pMJWTTrZx+s9T
         sQhP+3Jq2XqOW3k4zPUPgcDOixM/ukj5y5BO84O0rKtZWPW7YlRh9fZXR1Yq9oLfSHb4
         gTZa0mG727wRJdKd1ZEyltv5OYWwZKp0sKyex+Th12ZqJ45ssz68MdUhCuNVzOtQZE00
         HDPsXUwVHpQXln6M4gQtl0s2DAmHrwfnl8AK0YrvVtJBZQ1MBtFL7V+MKZBG86vuY52v
         syvA==
X-Gm-Message-State: ANhLgQ2CPWyfL3OxH814Fq0gbO9VaiNYnhwdXe0uwVG55fHC6X5Zy0PI
        WMgldeoFwt7HwzrKmGUPOA==
X-Google-Smtp-Source: ADFU+vv8UBfBmId0F/IsDNBZkut3LGAPI6W5tybrGJw+OG5zvO312QOb7rUyGsvJgN+9hWl9Mgej/Q==
X-Received: by 2002:a05:6830:60b:: with SMTP id w11mr4198360oti.350.1583255030953;
        Tue, 03 Mar 2020 09:03:50 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y14sm7798449oih.23.2020.03.03.09.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:03:50 -0800 (PST)
Received: (nullmailer pid 8052 invoked by uid 1000);
        Tue, 03 Mar 2020 17:03:48 -0000
Date:   Tue, 3 Mar 2020 11:03:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: power: Extend nodename pattern for
 power-domain providers
Message-ID: <20200303170348.GB26191@bogus>
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
 <20200303150749.30566-5-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303150749.30566-5-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 03, 2020 at 04:07:46PM +0100, Ulf Hansson wrote:
> The existing binding requires the nodename to have a '@', which is a bit
> limiting for the wider use case. Therefore, let's extend the pattern to
> allow either '@' or '-'.

That's fine, but...

> Additionally, let's update one of the examples to show how the updated
> pattern could be used.
> 
> Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/power-domain.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
> index 207e63ae10f9..dc232759013e 100644
> --- a/Documentation/devicetree/bindings/power/power-domain.yaml
> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
> @@ -25,7 +25,7 @@ description: |+
>  
>  properties:
>    $nodename:
> -    pattern: "^(power-controller|power-domain)(@.*)?$"
> +    pattern: "^(power-controller|power-domain)([@-].*)?$"
>  
>    domain-idle-states:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
> @@ -71,13 +71,13 @@ required:
>  
>  examples:
>    - |
> -    power: power-controller@12340000 {
> -        compatible = "foo,power-controller";
> +    power: power-domain-foo {
> +        compatible = "foo,power-domain";
>          reg = <0x12340000 0x1000>;

When you have 'reg' you should have a unit-address.

>          #power-domain-cells = <1>;
>      };
>  
> -    // The node above defines a power controller that is a PM domain provider and
> +    // The node above defines a power domain that is a PM domain provider and
>      // expects one cell as its phandle argument.
>  
>    - |
> -- 
> 2.20.1
> 
