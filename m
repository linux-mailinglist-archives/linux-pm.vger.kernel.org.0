Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B9E44FDB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 01:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfFMXJJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 19:09:09 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39088 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfFMXJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 19:09:09 -0400
Received: by mail-qk1-f194.google.com with SMTP id i125so513544qkd.6;
        Thu, 13 Jun 2019 16:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p5oxYtHy7Yr2XXQ3aO8PAJU4EwYdDFlGCwAcwBaO/FI=;
        b=Eya0pyUgy4UTl64vT9rz/i+jwdo5Iu0PrCPtS6fxeI+ORDW2i7/H4pFGxTtXJN7RvO
         Yb1dCMNrKs73eVPllQkJiig3tf/jg2MSJi/0/sta6TBDHdtfAytcRE4cgwcTlO/GqLv8
         dyg7cYBj8I9g5zHzthEcSWzDVXcYsriWtf6/nCOODlk/fqgW7Lf8WMCJGriacXF57KSC
         jnW2liG+Hxm7RGZtHG/Pa9M4GlTqXrGjKo8vktnUtKUKPkPXWkb15GiOzNLH5lAJpoM8
         m3t9JhL8Hq0l8NkUvDn/Li1xSEOJvv5H9kfxeXArTAddF7bcL/+eJ+OWLyrK7hLmvwLr
         OR7g==
X-Gm-Message-State: APjAAAWvTz+/SyXfA807Lx0ti8p4bBM4HvUWMK8yrLlcJKOP0P1uto0W
        8IbgKCk3VlO7ZIV7Zn8aUg==
X-Google-Smtp-Source: APXvYqwGtrTXZRGSGbC4LGuyA5Vkav93477zUXLcKvlB+g549ZiRmZB+l2NOPgb9qqkyDxNSzFpsMA==
X-Received: by 2002:ae9:df07:: with SMTP id t7mr72055835qkf.193.1560467348262;
        Thu, 13 Jun 2019 16:09:08 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id m4sm395909qka.70.2019.06.13.16.09.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 16:09:07 -0700 (PDT)
Date:   Thu, 13 Jun 2019 17:09:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: power: supply: Add documentation for
 the VINDPM properties
Message-ID: <20190613230906.GA10492@bogus>
References: <20190520180712.32405-1-angus@akkea.ca>
 <20190520180712.32405-3-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520180712.32405-3-angus@akkea.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 20, 2019 at 11:07:12AM -0700, Angus Ainslie (Purism) wrote:
> Add documentation on how to control VINDPM from the devicetree.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  .../devicetree/bindings/power/supply/bq25890.txt          | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
> index dc0568933359..fe8b709dd666 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq25890.txt
> @@ -26,9 +26,15 @@ Optional properties:
>  - ti,use-ilim-pin: boolean, if present the ILIM resistor will be used and the
>      input current will be the lower between the resistor setting and the IINLIM
>      register setting;
> +- ti,use-vinmin-threshold: boolean, if present the FORCE_VINDPM bit will be set
> +    and the input voltage limit will be configured based on "ti,vinmin-threshold"

Isn't presence of ti,vinmin-threshold enough to determine whether to set 
FORCE_VINDPM or not? Just get rid of the default being 4.4V.

>  - ti,thermal-regulation-threshold: integer, temperature above which the charge
>      current is lowered, to avoid overheating (in degrees Celsius). If omitted,
>      the default setting will be used (120 degrees);
> +- ti,vinmin-threshold: integer, lower absolute threshold for VINDPM. If the
> +    voltage falls below this threshold the charge current is reduced until the
> +    input voltage rises above the input voltage limit. If omitted, the default
> +    setting will be used (4.4V);
>  
>  Example:
>  
> @@ -46,4 +52,6 @@ bq25890 {
>  
>          ti,use-ilim-pin;
>          ti,thermal-regulation-threshold = <120>;
> +        ti,use-vinmin-threshold;
> +        ti,vinmin-threshold = <3900000>;
>  };
> -- 
> 2.17.1
> 
