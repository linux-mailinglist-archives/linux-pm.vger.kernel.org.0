Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6653D2D31D3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 19:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbgLHSMi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 13:12:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40380 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbgLHSMi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 13:12:38 -0500
Received: by mail-oi1-f193.google.com with SMTP id p126so20344958oif.7;
        Tue, 08 Dec 2020 10:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cwCLzsE/tJgmmJNunjALWP2lRl/HDWi24Jsjga6oelY=;
        b=Ql95cxZLVPOJU0qIAMxf2pkjiovtATHP3WRgHi72KSgQ+bbiDRCHnv4JA8CKNJcWzx
         SittnHu/XTlqpt29zL+1jo7oGptT8KkxfppaxnXcY8JlonuzcHFNkB+8Tf1WQ+pPgG5h
         YjDlAn0Nyve6Ve5/EYSoPcCnzlnIeSvSsB+NNr3jgJ2p7UhorqApjQHAQHbsfTrcu0LP
         7fvL/lwmy6lLBdxlG2Ksl0PAWVOgjHb/Jalwb0XcvdHcC22sNUv2iKMwJ79E6+V2UIeT
         ZFOwV+xqnhHn+2B64HoEe24uLBs52PsDTzd8+37LkmivNQRmlLUA9kIHZIGvZVa2ibaA
         vo/w==
X-Gm-Message-State: AOAM533zS46ber84Hx/rbLJ5w4kLurRlryBZAxm0YlMYKWBTrh+IdMhG
        We2JycEu905JWvAntJ7fvO+c76tUGw==
X-Google-Smtp-Source: ABdhPJw0UcN/EVGDjTeY2qx4MN2AFeGn9GVguBwbcsYpNcu4JsevRGimwUvxTt+sfw31yQq1chcZTg==
X-Received: by 2002:aca:58d7:: with SMTP id m206mr3778694oib.0.1607451117420;
        Tue, 08 Dec 2020 10:11:57 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l5sm2813820ooo.2.2020.12.08.10.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:11:55 -0800 (PST)
Received: (nullmailer pid 2811959 invoked by uid 1000);
        Tue, 08 Dec 2020 18:11:54 -0000
Date:   Tue, 8 Dec 2020 12:11:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a779a0 support
Message-ID: <20201208181154.GA2811929@robh.at.kernel.org>
References: <20201126223028.3119044-1-niklas.soderlund+renesas@ragnatech.se>
 <20201126223028.3119044-2-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201126223028.3119044-2-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 26 Nov 2020 23:30:26 +0100, Niklas Söderlund wrote:
> Add support for R-Car V3U. The V3U IP differs a bit from its siblings in
> such way that it have 4 TSC nodes and the interrupts are not routed to
> the INTC-AP but to the ECM.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  .../bindings/thermal/rcar-gen3-thermal.yaml     | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
