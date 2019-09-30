Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF5C2384
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbfI3OmH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 10:42:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40422 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731190AbfI3OmH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 10:42:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so11313632oib.7;
        Mon, 30 Sep 2019 07:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EYSKNqzhWZ5pBYySik+qJ+6jR/qzoTuoas9JM4Wu8F8=;
        b=pD/WFvJzTeQ75IM0qSoU/zoj0oyNc55V9h2o5gf6+VxQZyvRTpVUIZ5kkCLYLALTdf
         Jil0VAMrjmjkELoI8H7u0dUiVhHcslE5HaE+lJ96CYlag7/3K2dCpQ37WAWEhDWlcI6I
         Iso4P0SXDE5SuTKU40gbfeLLruqkxAkrGIa8kjI4hBLZzZm89Vhn2WHDPQiDNY1IXXRt
         hEHzNcdjCsuR6FTjfvkAjREkHOtq0w3mobpM4RhP7QGmPF55Oc9NDjxLJ33kD5xKBk3m
         A4FjlI5Bx7eZlo5sfd8bSS6YPz6eQ+4+A7Z81g6a8SR2zULYEMrM5t6/7tmRynJINB/q
         a41Q==
X-Gm-Message-State: APjAAAU22yfYSKVMBngCO18ym0VGVibZyPA8UTH9XnoCpszSwo6Z9Ao6
        92fyubusjCzhHS4BXSuB4w==
X-Google-Smtp-Source: APXvYqwX8v05lHHK67LEiARr1bwtyadlGwKRScnVJBehvPR1uH/YfAs2RwR6L1jOvqsZkjnT81Z0uA==
X-Received: by 2002:aca:d9c4:: with SMTP id q187mr18629684oig.45.1569854526386;
        Mon, 30 Sep 2019 07:42:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 34sm3825189otf.55.2019.09.30.07.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 07:42:05 -0700 (PDT)
Date:   Mon, 30 Sep 2019 09:42:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, amit.kucheria@verdurent.com,
        mark.rutland@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: thermal: Add generic power domain
 warming device binding
Message-ID: <20190930144205.GA11539@bogus>
References: <1568135676-9328-1-git-send-email-thara.gopinath@linaro.org>
 <1568135676-9328-4-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568135676-9328-4-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 10, 2019 at 01:14:34PM -0400, Thara Gopinath wrote:
> Add binding to define power domains as thermal warming
> devices.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  .../bindings/thermal/pwr-domain-warming.txt        | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/pwr-domain-warming.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/pwr-domain-warming.txt b/Documentation/devicetree/bindings/thermal/pwr-domain-warming.txt
> new file mode 100644
> index 0000000..25fc568
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/pwr-domain-warming.txt
> @@ -0,0 +1,32 @@
> +* Generic power domain based thermal warming device.
> +
> +This binding describes the power domains that can be used as a
> +thermal warming device.

This looks like just a gathering of properties and way to instantiate 
some driver.

I think this all belongs in the power domain provider. Make it a cooling 
device and you should know which domains are relevant based on the 
compatible (though perhaps we could consider a list in DT). If you want 
to instantiate a separate driver to handle this, then make the power 
domain driver do that.

Rob

> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be "thermal-power-domain-wdev"
> +
> +- #temp-reg-cells:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Must be 2
> +
> +- power-domains:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to power-domains that match power-domain-names
> +
> +- power-domain-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: The power-domains that can behave as warming devices
> +
> +Example 1
> +thermal_wdev: rpmhpd_mx_wdev {
> +		compatible = "thermal-power-domain-wdev";
> +		#cooling-cells = <2>;
> +		power-domains =  <&rpmhpd SDM845_MX>;
> +		power-domain-names = "mx";
> +	};
> -- 
> 2.1.4
> 
