Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB36D1CE305
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 20:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgEKSvH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 14:51:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45000 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbgEKSvH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 14:51:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id j4so8409369otr.11;
        Mon, 11 May 2020 11:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kE5/Go6t2fYGvoXtO9HkWgvHFtqFj74OSf+x9Glf+U8=;
        b=UjZSYw4RSv+TpNcr0pTQrHpT/aFHcX2Idooxt6BBtneGl17MTpstYmDCesutGWFs4E
         Rdu6GMJp9K4J3MA9YzxgDfn95uUWvaIQ50neusqdJ1ymMeuLzdkAjIarS9dqYV0JlJ0D
         66kpTqhMNYptELLPUGwp6T23lJS2D3x/8MQAVgT6Yr/CZ8wUZQ7aikql7H620+6GY4mE
         v+y8EEXZ1SYa7DtR1fKYxt4KaoPSFox6LfgiuEd5ewn9M/MrroeIV8u3mHcvvS92bSqj
         tM7uoKXpD9nSZTLtaVOVNPxB9ZdFdoi3fZEoM6PVrP+EBx3qQDTzrXDrw/sNH9kQKb67
         IJHA==
X-Gm-Message-State: AGi0PuaUyBJ7/weP7U+zxzskrOtkZX4i3Tgi8EzIfrVR9eslWYENBVYX
        Ttb9Y+BhBpDBmp0hksoi6R6qHMo=
X-Google-Smtp-Source: APiQypIRsow20DA+OFWNNQtxZ4M+f9YRd4zN3KlQ4rWozGy8h57PD0s4/z5hpOktemuW1PcKm94mMw==
X-Received: by 2002:a9d:19af:: with SMTP id k44mr13367362otk.80.1589223065262;
        Mon, 11 May 2020 11:51:05 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k84sm4766130oib.10.2020.05.11.11.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:51:04 -0700 (PDT)
Received: (nullmailer pid 25902 invoked by uid 1000);
        Mon, 11 May 2020 18:51:03 -0000
Date:   Mon, 11 May 2020 13:51:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     amit.kucheria@verdurent.com, rui.zhang@intel.com,
        s.hauer@pengutronix.de, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com, festevam@gmail.com, kernel@pengutronix.de,
        robh+dt@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [PATCH V3] dt-bindings: thermal: Convert i.MX8MM to json-schema
Message-ID: <20200511185103.GA25293@bogus>
References: <1587477544-20052-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587477544-20052-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 21 Apr 2020 21:59:04 +0800, Anson Huang wrote:
> Convert the i.MX8MM thermal binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
> 	- drop unnecessary description for reg/clocks;
> 	- improve compatible;
> 	- use thermal-sensor as node name.
> ---
>  .../devicetree/bindings/thermal/imx8mm-thermal.txt | 15 ------
>  .../bindings/thermal/imx8mm-thermal.yaml           | 58 ++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> 

Applied, thanks!
