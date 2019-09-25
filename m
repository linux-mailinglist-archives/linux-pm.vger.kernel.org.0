Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC132BD803
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 07:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411817AbfIYF7i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 01:59:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33813 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404261AbfIYF7i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 01:59:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id k7so1360547pll.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2019 22:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sixuJfcEsKxEyNW6NClPoa+el3r6rMOWUSS7IBto0XY=;
        b=fugNAyjuuul94jLQlDha8DZAOXx0OEgTyKPvUnQEcK8AvLJ/FyP+4aF+fDv1xZ+7dB
         cL1ixpnjA7X8pyjxCmMGwBC10bTNlgxg3Y6YgN24yvXDsn5taqBjkvHUU2R0hlz6+jWJ
         Qh+re2BLHDPC6cusIbTsDAmCEwyOyH9NA7l9rdqVN+z2aqTDmjG0RqzSwt3Bp2iihG0s
         7TmqF7wLopmIRMtPvUotA8ZmVgeVHCSjuQpQYP/cHRgHZcBw4/ULNN+xo5qfpY05sqZx
         X68hklDqSibAix2Ol0HeEDkXK53MhPn+YRpYL8ll+hxM9XQlBc0f0oDmzl4ZdZSZP8ko
         pHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sixuJfcEsKxEyNW6NClPoa+el3r6rMOWUSS7IBto0XY=;
        b=rCniwA9b4YObYknzXatLnztKs8LMWFgo9FGWh2ZDuKO+oCeqTYW8StJWL8BHIYRHJU
         KrMCOvxnettUA69stRJPlp+ZRPjEuQs5s8eZmoXwilD0w5gpxahoQECQOy20bWABKxLF
         PJmpPblFKdKeDtrQdcR+OdhI+0hW9ILed4NF2XXoc1s5MW5g+Ln43Mxz7eCIrks5QrQg
         vm4YrGiZBRBFbuISXaBebs93hm5tJ//+Qys99t17boAnC86SBslIkIMlW8eyhdHL992S
         RsB1geNHZWMdbCH6ZWYItvJNi//+b9F8u/XsVj94JmN24rJ5evfllEb0g7HDhQ+RVkQ7
         6XoA==
X-Gm-Message-State: APjAAAVaEuafs8G3t38yESYWCttVGsHt9yzHCOcoGZzinj48D2QDjGrO
        Pjwuq0EMVhJoHpjTzpcIQa7FWw==
X-Google-Smtp-Source: APXvYqx7ulhyhAYLr9kjOcD6g1JpEuN670axDok3c12zNjsU6NkNSJN3yZGCTMd13XVgsr/OZTbVGQ==
X-Received: by 2002:a17:902:850b:: with SMTP id bj11mr7394125plb.39.1569391177288;
        Tue, 24 Sep 2019 22:59:37 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m2sm3836534pgc.19.2019.09.24.22.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 22:59:36 -0700 (PDT)
Date:   Tue, 24 Sep 2019 22:59:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        David Dai <daidavid1@codeaurora.org>
Subject: Re: [RFC PATCH] interconnect: Replace of_icc_get() with icc_get()
 and reduce DT binding
Message-ID: <20190925055933.GA2810@tuxbook-pro>
References: <20190925054133.206992-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925054133.206992-1-swboyd@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 24 Sep 22:41 PDT 2019, Stephen Boyd wrote:

> I don't see any users of icc_get() in the kernel today, and adding them
> doesn't make sense. That's because adding calls to that function in a
> driver will make the driver SoC specific given that the arguments are
> some sort of source and destination numbers that would typically be
> listed in DT or come from platform data so they can match a global
> numberspace of interconnect numbers. It would be better to follow the
> approach of other kernel frameworks where the API is the same no matter
> how the platform is described (i.e. platform data, DT, ACPI, etc.) and
> swizzle the result in the framework to match whatever the device is by
> checking for a DT node pointer or a fwnode pointer, etc. Therefore,
> install icc_get() as the defacto API and make drivers use that instead
> of of_icc_get() which implies the driver is DT specific when it doesn't
> need to be.
> 

+1 on this part!

> The DT binding could also be simplified somewhat. Currently a path needs
> to be specified in DT for each and every use case that is possible for a
> device to want. Typically the path is to memory, which looks to be
> reserved for in the binding with the "dma-mem" named path, but sometimes
> the path is from a device to the CPU or more generically from a device
> to another device which could be a CPU, cache, DMA master, or another
> device if some sort of DMA to DMA scenario is happening. Let's remove
> the pair part of the binding so that we just list out a device's
> possible endpoints on the bus or busses that it's connected to.
> 
> If the kernel wants to figure out what the path is to memory or the CPU
> or a cache or something else it should be able to do that by finding the
> node for the "destination" endpoint, extracting that node's
> "interconnects" property, and deriving the path in software. For
> example, we shouldn't need to write out each use case path by path in DT
> for each endpoint node that wants to set a bandwidth to memory. We
> should just be able to indicate what endpoint(s) a device sits on based
> on the interconnect provider in the system and then walk the various
> interconnects to find the path from that source endpoint to the
> destination endpoint.
> 

But doesn't this implies that the other end of the path is always some
specific node, e.g. DDR? With a single node how would you describe
CPU->LLCC or GPU->OCIMEM?

> Obviously this patch doesn't compile but I'm sending it out to start
> this discussion so we don't get stuck on the binding or the kernel APIs
> for a long time. It looks like we should be OK in terms of backwards
> compatibility because we can just ignore the second element in an old
> binding, but maybe we'll want to describe paths in different directions
> (e.g. the path from the CPU to the SD controller may be different than
> the path the SD controller takes to the CPU) and that may require
> extending interconnect-names to indicate what direction/sort of path it
> is. I'm basically thinking about master vs. slave ports in AXI land.
> 
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: <linux-pm@vger.kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/interconnect/interconnect.txt    | 19 ++++---------------
>  include/linux/interconnect.h                  | 13 ++-----------
>  2 files changed, 6 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> index 6f5d23a605b7..f8979186b8a7 100644
> --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -11,7 +11,7 @@ The interconnect provider binding is intended to represent the interconnect
>  controllers in the system. Each provider registers a set of interconnect
>  nodes, which expose the interconnect related capabilities of the interconnect
>  to consumer drivers. These capabilities can be throughput, latency, priority
> -etc. The consumer drivers set constraints on interconnect path (or endpoints)
> +etc. The consumer drivers set constraints on interconnect paths (or endpoints)
>  depending on the use case. Interconnect providers can also be interconnect
>  consumers, such as in the case where two network-on-chip fabrics interface
>  directly.
> @@ -42,23 +42,12 @@ multiple paths from different providers depending on use case and the
>  components it has to interact with.
>  
>  Required properties:
> -interconnects : Pairs of phandles and interconnect provider specifier to denote
> -	        the edge source and destination ports of the interconnect path.
> -
> -Optional properties:
> -interconnect-names : List of interconnect path name strings sorted in the same
> -		     order as the interconnects property. Consumers drivers will use
> -		     interconnect-names to match interconnect paths with interconnect
> -		     specifier pairs.
> -
> -                     Reserved interconnect names:
> -			 * dma-mem: Path from the device to the main memory of
> -			            the system
> +interconnects : phandle and interconnect provider specifier to denote
> +	        the edge source for this node.
>  
>  Example:
>  
>  	sdhci@7864000 {
>  		...
> -		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
> -		interconnect-names = "sdhc-mem";
> +		interconnects = <&pnoc MASTER_SDCC_1>;

This example seems incomplete, as it doesn't describe the path between
CPU and the config space, with this in place I think you need the
interconnect-names.


But with a single interconnect, the interconnect-names should be
omitted, as done in other frameworks.

>  	};
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index d70a914cba11..e1ae704f5ab1 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -25,23 +25,14 @@ struct device;
>  
>  #if IS_ENABLED(CONFIG_INTERCONNECT)
>  
> -struct icc_path *icc_get(struct device *dev, const int src_id,
> -			 const int dst_id);
> -struct icc_path *of_icc_get(struct device *dev, const char *name);
> +struct icc_path *icc_get(struct device *dev, const char *name);
>  void icc_put(struct icc_path *path);
>  int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>  void icc_set_tag(struct icc_path *path, u32 tag);
>  
>  #else
>  
> -static inline struct icc_path *icc_get(struct device *dev, const int src_id,
> -				       const int dst_id)
> -{
> -	return NULL;
> -}
> -
> -static inline struct icc_path *of_icc_get(struct device *dev,
> -					  const char *name)
> +static inline struct icc_path *icc_get(struct device *dev, const char *name)

I like this part, if mimics what's done in other frameworks and removes
the ties to OF from the API.

Regards,
Bjorn

>  {
>  	return NULL;
>  }
> 
> base-commit: b5b3bd898ba99fb0fb6aed3b23ec6353a1724d6f
> -- 
> Sent by a computer through tubes
> 
