Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474482F6AA8
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 20:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbhANTPb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 14:15:31 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:46521 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbhANTPb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 14:15:31 -0500
Received: by mail-ot1-f53.google.com with SMTP id w3so6184634otp.13;
        Thu, 14 Jan 2021 11:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WzAyTjck5VNq3GorX0qlmMkVncxZPl9Fylne3/uG+Bk=;
        b=BFEDfMtHIdJP36JGALXCJSj4iQSlMKNxiWJn3N7Gyctqay2OsoxYzl4kpJzx2bBKJX
         197OwvhbKGPM5d14WnAHxRvIs86051R17jhJaS1bCZkL0g8ChWlGM+c40F95Qv+imbCE
         QHzo+Y7/ed2qAT+nD6TbixJQQkVL4d6xbG9WcIJXHwf36A6VGB9z+PTxhSZtZ7/x3MOx
         dlW9Ye/s0XTeHhLJhpM0wQkkxv35KfFqLbJibcTyYQGS792P5FkoSZe4UXiTR5Zf4KUI
         cXyXWZFIGYITRkxAnjxmOGiEt667dZRxktXuixtiH7wne6mBgdnZBtyH7gWCp55Ysfpb
         /PQw==
X-Gm-Message-State: AOAM531ORSQS+Yx/B8zcUX1Lho2HMKLQ4Qe2WI6d8fthInMYIa1u+X4W
        75SSE580pWmWAul7fYCsPA==
X-Google-Smtp-Source: ABdhPJynsLO4CFhjws/utmf+yuRYsXbydDIE4TO7RkRifb9aLMovWwrOyWS6Men1QPw5WPvKgAZxpg==
X-Received: by 2002:a9d:2ae3:: with SMTP id e90mr5698821otb.105.1610651690420;
        Thu, 14 Jan 2021 11:14:50 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t26sm1242137otm.17.2021.01.14.11.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:14:49 -0800 (PST)
Received: (nullmailer pid 3400941 invoked by uid 1000);
        Thu, 14 Jan 2021 19:14:48 -0000
Date:   Thu, 14 Jan 2021 13:14:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     shawnguo@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, georgi.djakov@linaro.org, cdleonard@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: mxsfb: Add interconnect bindings for
 LCDIF path
Message-ID: <20210114191448.GA3396163@robh.at.kernel.org>
References: <20210111045103.GH28365@dragon>
 <20210111082240.27691-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111082240.27691-1-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 11, 2021 at 09:22:40AM +0100, Martin Kepplinger wrote:
> Add optional interconnect properties for the dram path requests.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  Documentation/devicetree/bindings/display/mxsfb.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Looks fine, but I believe there's an in flight patch to convert this to 
schema. Please coordinate with that.

> 
> diff --git a/Documentation/devicetree/bindings/display/mxsfb.txt b/Documentation/devicetree/bindings/display/mxsfb.txt
> index c985871c46b3..d494a2674290 100644
> --- a/Documentation/devicetree/bindings/display/mxsfb.txt
> +++ b/Documentation/devicetree/bindings/display/mxsfb.txt
> @@ -15,6 +15,12 @@ Required properties:
>      - "pix" for the LCDIF block clock
>      - (MX6SX-only) "axi", "disp_axi" for the bus interface clock
>  
> +Optional properties:
> +- interconnects : interconnect path specifier for LCDIF according to
> +		Documentation/devicetree/bindings/interconnect/interconnect.txt.
> +- interconnect-names: the name describing the interconnect path.
> +		Should be "dram" for i.MX8MQ.
> +
>  Required sub-nodes:
>    - port: The connection to an encoder chip.
>  
> -- 
> 2.20.1
> 
