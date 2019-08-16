Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93C290A17
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 23:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfHPVOd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 17:14:33 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40761 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfHPVOd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 17:14:33 -0400
Received: by mail-oi1-f194.google.com with SMTP id h21so5794998oie.7;
        Fri, 16 Aug 2019 14:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4gRR6HvBg6u5veUlkvaSp6+HCcvQCdmIeBVhPgvLg/I=;
        b=NLghpoLPSElcRSsklqLLctbkIfqC6ZkjLvrSvw60ruskZmUsNtHJ551HeTCg1Pw785
         UgBb81J34MpcvYUj/YyXgh5X16p9EM+FUvkIh2aPBjOLePmGDHFQfUHAnY6Jia0t627B
         rjoa/ARNU/U7/0oXkDjPLSz6UrILJQfVZAl9e3nY9olUbwKFSpb0xVoEHDTRQ0yNkpaZ
         tX9tcTrIOUQVsco6qsakLyEGJpWtyDacswN9pqFvK2WLpG/9VjYZClX9UDnCCuv/I5uZ
         LIpNJosHsZqJ+1MN3wbyPqZreezLeCddfyuSCAn8ROlyLzOPGzF6X4NNiXW1IWOvM/Ti
         GO2g==
X-Gm-Message-State: APjAAAWNgVR7c97BLfUmy8rs+tWBtpiw7S5iAee+EwfNZxRe1jYBsRzz
        zTsqzC4g4M0smm78sj4WKNMv57M=
X-Google-Smtp-Source: APXvYqyGpQgU9LoPcwD1U3cdu93f8C8iY9sv3eSKzx9WuZ10PDu6m4tPQlcQpTQ6ajbc+Hs+/Zam7A==
X-Received: by 2002:a05:6808:903:: with SMTP id w3mr5765893oih.119.1565990071859;
        Fri, 16 Aug 2019 14:14:31 -0700 (PDT)
Received: from localhost (ip-173-126-47-137.ftwttx.spcsdns.net. [173.126.47.137])
        by smtp.gmail.com with ESMTPSA id c11sm1095758otr.54.2019.08.16.14.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 14:14:31 -0700 (PDT)
Date:   Fri, 16 Aug 2019 16:14:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Tresidder <rtresidd@electromag.com.au>
Cc:     sre@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: power/supply/sbs_sbs-battery: Addition
 of force_load binding Add device tree binding documentation for addition of
 force_load boolean value to allow loading a battery during boot even if not
 present at that time.
Message-ID: <20190816211430.GA8175@bogus>
References: <1564037445-22936-1-git-send-email-rtresidd@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564037445-22936-1-git-send-email-rtresidd@electromag.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 25, 2019 at 02:50:45PM +0800, Richard Tresidder wrote:
> Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
> ---
> 
> Notes:
>     Add device tree binding documentation for addition of force_load
>     boolean value to allow loading a battery during boot even if not
>     present at that time.
>     Accompanying patch to drivers/power/supply/sbs-battery.c submitted to linux-pm@vger.kernel.org
> 
>  Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> index 4e78e51..187d7bb 100644
> --- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
> @@ -15,7 +15,8 @@ Optional properties :
>     after an external change notification.
>   - sbs,battery-detect-gpios : The gpio which signals battery detection and
>     a flag specifying its polarity.
> -
> + - sbs,force-load : Allow loading of a hot-pluggable battery when there is no
> +   GPIO detect available and the module is statically built.

What's a module? That's Linux specific and nothing to do with the 
binding. 

Can't you just force load if sbs,battery-detect-gpios is not present?

Rob
