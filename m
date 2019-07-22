Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADB270DC2
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 01:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbfGVXzi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 19:55:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35091 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbfGVXzi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 19:55:38 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so77973752ioo.2;
        Mon, 22 Jul 2019 16:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vqJ5d9ZQlPSxepkXpdg9L0L47AP0FG3UApIywG0tHP0=;
        b=ZjvT4g8/RrqT/7F2IqpwxubN8t1rdzm7UaqsHhSB2bezzgDOFDHR+hEaEt9zdAquV8
         1N8DPmhQ9fmyvT/cFLkPhv18CDO7BhuJAykj75jf395B9aqwRhGgmJzkxxoimPVIsgVl
         mroSveLKCNQVakGWWHsVicTQ2uWkhIu+/dhEuqAG0/PpYJGEKcZDSGz7a3Hb1xVyjLpt
         LjF7LGU2FlBapDyYSLysdluex2wlQmkrrkrezxP8ExiDhG6lSI7ZPjcDyvQZYGrJw5hp
         p+1LbYiVCDubwvuIqU1sTAaK4jm2n5KTomdjDy3EPW81UwXXHilXiM/RWdUswl8MsQ+u
         Mw5A==
X-Gm-Message-State: APjAAAXk9gMRmXxQFgdmnJ09aCJ1nimwCdtksQPtCH91etsfZQ6F3vIx
        +H64TLg96+WgEvSaOqZm0A==
X-Google-Smtp-Source: APXvYqw58MCXgfGnS9niRqusPKURAiF8Clqzetlow7uAqDRR7t+ARIZAti8gzv0k2RxJyHEpymaXCQ==
X-Received: by 2002:a05:6638:281:: with SMTP id c1mr75013085jaq.43.1563839737044;
        Mon, 22 Jul 2019 16:55:37 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id c23sm34794384iod.11.2019.07.22.16.55.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 16:55:36 -0700 (PDT)
Date:   Mon, 22 Jul 2019 17:55:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, angus@akkea.ca, ccaione@baylibre.com,
        agx@sigxcpu.org, leonard.crestez@nxp.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 3/6] dt-bindings: thermal: qoriq: Add optional clocks
 property
Message-ID: <20190722235535.GA2063@bogus>
References: <20190705045612.27665-1-Anson.Huang@nxp.com>
 <20190705045612.27665-3-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705045612.27665-3-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri,  5 Jul 2019 12:56:09 +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Some platforms have clock control for TMU, add optional
> clocks property to the binding doc.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
