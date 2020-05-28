Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043A81E6E5B
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 00:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436835AbgE1WFu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 18:05:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43823 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436758AbgE1WFt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 18:05:49 -0400
Received: by mail-io1-f65.google.com with SMTP id h10so154974iob.10;
        Thu, 28 May 2020 15:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JCx+B8/wy3Lm5+1erx0AXzwlVtooOFiW3OXY1z5WrVI=;
        b=sgVZIayis9cHF4pQBVLFJg7qlgQStkoVJzQ17llCq+f3BlZAqIBoHGa9VPRb/Egj4w
         e2RLtLn6NU2ACCqYP+Asxg7YvP7as7FZwHHMSg2ouaB+dbGL6dKX5yMhO+WvsAhw6s/7
         zo/HXypjsPfPt9Q2jL3WCYiSyKNmJ+1Mgb1z8mXqGnLX7o8qF7wIikh7bMOhd+5BqJUw
         3gkesRVShXDJMxfPbjzgSxWq0RCghQqhEdXRpWZzs2JrvVIIfMKSAIWXvsiiy9Nv9nWy
         uczcjZOehwN+LdgHY/qVnW7/T8AwXvZGQS2m3vcxTzw64zX5hqipGBX8fVc05Ut6D2Qo
         clVg==
X-Gm-Message-State: AOAM533/sErPQ/CXfY19kaXB/egnK7cCjMy+0gZipAL1oylcbjlWGZPG
        ScC7OoRT8HWdhPreOq5we3lsD0o=
X-Google-Smtp-Source: ABdhPJymRsKL3lqmN13SyW5hyaIflvljxb+U0UEli++/rLp1hKpM3QJkg33Adjy7OEh4BconDlGkxA==
X-Received: by 2002:a02:3002:: with SMTP id q2mr4432217jaq.19.1590703548599;
        Thu, 28 May 2020 15:05:48 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n8sm3030119ioo.2.2020.05.28.15.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:05:47 -0700 (PDT)
Received: (nullmailer pid 765873 invoked by uid 1000);
        Thu, 28 May 2020 22:05:46 -0000
Date:   Thu, 28 May 2020 16:05:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        daniel.lezcano@linaro.org, kernel@pengutronix.de,
        Linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org,
        festevam@gmail.com
Subject: Re: [PATCH V4] dt-bindings: thermal: Convert i.MX to json-schema
Message-ID: <20200528220546.GA765825@bogus>
References: <1589967737-1128-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589967737-1128-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 20 May 2020 17:42:17 +0800, Anson Huang wrote:
> Convert the i.MX thermal binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> Changes since V3:
> 	- improve "fsl,tempmon" description.
> ---
>  .../devicetree/bindings/thermal/imx-thermal.txt    |  61 ------------
>  .../devicetree/bindings/thermal/imx-thermal.yaml   | 102 +++++++++++++++++++++
>  2 files changed, 102 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/imx-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/imx-thermal.yaml
> 

Applied, thanks!
