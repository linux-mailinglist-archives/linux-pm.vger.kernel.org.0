Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A685273DA9
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 22:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390832AbfGXUTC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 16:19:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40672 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388983AbfGXUTB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 16:19:01 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so5786802iom.7;
        Wed, 24 Jul 2019 13:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ApQotHQxWJr5zyqbEl1C9NpdXsHo5uhr1/je6Huq+bI=;
        b=NqlLMQzTzcPx9v5G9pwHgv4DssgL3rdJXDK0N3kNiZHw80bZW9/HDDXM572fhL/5ZF
         SvW0zaoIFkjcNHPvHhFL5+bY/Dr2ZrMtVRZukNucY4giAQ51AWd77YWVx3EKjTqLvy/c
         vF2TNnzXapH26V15y8iHNzL4+Y/0edcMW2XfyUlkC1vbqvXoBuG9EfTta5XyMeTz4i+/
         FsyFIGMHS6pWjTTC59lJ2wbf60VFxm9jrMCCIlnnkiwwgbgs35f+zCAKOFLaAcOKuD6h
         BaAWDQ9TsG8y/A0DnQ2kEb/pkZ3RFVAddplsmpdTRyXJWZavjNbNd+oSUBM+oLjXxcLl
         UIbA==
X-Gm-Message-State: APjAAAUFM3vMfJN7kg+0pvfkn2amAYqiV5KS2tK6cEVVtAP3wVHrlhUY
        Q3G7OTHc0rWSSxkrHDn1sA==
X-Google-Smtp-Source: APXvYqxZ9dmUz3ZXKBjOYJnBYyOwokAXvh0AFf4QNJLoM+DksevICYOosUh4VFPZzV82gw2GdpbfrA==
X-Received: by 2002:a6b:fb02:: with SMTP id h2mr53385887iog.289.1563999540221;
        Wed, 24 Jul 2019 13:19:00 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id r5sm43517794iom.42.2019.07.24.13.18.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:18:59 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:18:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, p.zabel@pengutronix.de, ping.bai@nxp.com,
        daniel.baluta@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
        angus@akkea.ca, andrew.smirnov@gmail.com, ccaione@baylibre.com,
        agx@sigxcpu.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/4] dt-bindings: opp: Support multiple opp-suspend
 properties
Message-ID: <20190724201858.GA25048@bogus>
References: <20190709080015.43442-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709080015.43442-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue,  9 Jul 2019 16:00:12 +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Update opp-suspend property's description to support multiple
> opp-suspend properties defined in DT, the OPP with highest opp-hz
> and with opp-suspend property present will be used as suspend opp.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch.
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
