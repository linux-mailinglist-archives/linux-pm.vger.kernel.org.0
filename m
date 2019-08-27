Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA8369EC92
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 17:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbfH0P1W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 11:27:22 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33643 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfH0P1W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 11:27:22 -0400
Received: by mail-oi1-f196.google.com with SMTP id l2so15276653oil.0;
        Tue, 27 Aug 2019 08:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5a2qkMONKijUeeWaRhR2tzwZA4N/jTBHB+gjYWsBgqk=;
        b=tlj1SJevynUVUZLRKLzsZVVbtpvRpOw6Fe38hneWTMFz5D1qWSc+KvugQojJRWWhFD
         Mt1D04yudb4klsjVgqEegtY5fab0MLVuIB4YU2W7osCSirYEvXEyZ0V1AUdpg157fdZO
         7Vgltb7M0iCXMU87QZ8hVqJG8IwZRKF8Xl50iIiOH8liPRB/bhwwHEDvQFHFnPAtXNvv
         mJyl7HZ1/6tclNZvTzP+XOca7dT4yeafyD3lU+mKGqhiZow+sQ3JIe2Jqw5iwkWBlBGg
         r9tJCEtU0okPBOE1ZwLSWqRfVYqKldGzVcTKUet0cuiR3EJKrYgxhsRbBYqcm2sjXHyZ
         +fTA==
X-Gm-Message-State: APjAAAWMonLY+baoPqOEMdE4R4qwfbUm60ZrfzbMYdd9jIDSAW0P6NML
        Tr7/OK0t3xGMCUzxEQc7hg==
X-Google-Smtp-Source: APXvYqz++OPbvepRcKtjgMn+dNQGml3FmGpPuBLHTxhzF0nrXokDGXGy1WXvHQuOxkbhOS6VRJHraQ==
X-Received: by 2002:aca:c449:: with SMTP id u70mr16884592oif.5.1566919641033;
        Tue, 27 Aug 2019 08:27:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w10sm5367778otm.68.2019.08.27.08.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 08:27:20 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:27:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH v5 17/18] dt-bindings: thermal: add binding document for
 r40 thermal controller
Message-ID: <20190827152719.GA26972@bogus>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
 <20190810052829.6032-18-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810052829.6032-18-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 10 Aug 2019 05:28:28 +0000, Yangtao Li wrote:
> This patch adds binding document for allwinner r40 thermal controller.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
