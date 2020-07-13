Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0352B21E3D7
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 01:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGMXqJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 19:46:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45453 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgGMXqH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 19:46:07 -0400
Received: by mail-io1-f67.google.com with SMTP id e64so15422853iof.12;
        Mon, 13 Jul 2020 16:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T6nZ0cOZJ7RCB/ypig9TkUxlGlTFi3/Lq9vMup5t3BA=;
        b=pFhD2aYYIkU4iaBaOATeWmjCgdY7eknkoonQy/MXwe38VIic2iqELxqHj1BxeIFDy/
         NTNMz1X/D4bLmxfMNuEY0tpvluUSDP8DdPSQyljAdeiaZDSglSDNKW9FkxImMvJoAOus
         c+fiVw118ZihcURX3es/IFJWbE9ygT5NCdTCsZuf1PkDUkP6F1dgGXQzkAiH9qX8On+3
         1/N0yKTC4j4RGNPeWN7dIJi1wT+VxP9tDgYz2EvcN0QOIPfi2pDOV4+r9WZq/pTplWpk
         WCpS9xzxCMfeKCX2WOLszd4+pqscjZHwZ6ysEwHgqFQ1OkXNLbvP/nMRlwbLMhWd5Aen
         xZ7g==
X-Gm-Message-State: AOAM531uupBHjxL8FRv0yKDL3Zc6hhjf47ALIMqE6T2EaTVqcHTtjb2h
        jAE90BGFLD96kGKXWJb7pQ==
X-Google-Smtp-Source: ABdhPJxh2RFsFJKfNQScdvILUrL+KW2m+tSrDtRyy1/vJm0JpYuo8Qyed6+ngOPyOJBA3WccAVXQzA==
X-Received: by 2002:a02:c903:: with SMTP id t3mr2902964jao.30.1594683966700;
        Mon, 13 Jul 2020 16:46:06 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p9sm9379929ilc.78.2020.07.13.16.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 16:46:06 -0700 (PDT)
Received: (nullmailer pid 943326 invoked by uid 1000);
        Mon, 13 Jul 2020 23:46:04 -0000
Date:   Mon, 13 Jul 2020 17:46:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>
Subject: Re: [PATCH v2 2/9] dt-bindings: battery: Add temperature properties
Message-ID: <20200713234604.GA935472@bogus>
References: <20200607144113.10202-1-digetx@gmail.com>
 <20200607144113.10202-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607144113.10202-3-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 07, 2020 at 05:41:06PM +0300, Dmitry Osipenko wrote:
> Document generic battery temperature properties.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/power/supply/battery.txt       | 10 ++++++++++
>  1 file changed, 10 insertions(+)

This is close to being converted to schema:

https://lore.kernel.org/linux-pm/20200707212914.31540-1-r-rivera-matos@ti.com/
 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> index 5e29595edd74..e0c35eff9d3f 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -45,6 +45,16 @@ Optional Properties:
>     and corresponding battery internal resistance percent, which is used to look
>     up the resistance percent according to current temperature to get a accurate
>     batterty internal resistance in different temperatures.
> + - temperature-ambient-min-alert-celsius: Alert when ambient temperature of a
> +   battery is lower than threshold value.
> + - temperature-ambient-max-alert-celsius: Alert when ambient temperature of a
> +   battery is higher than threshold value.
> + - temperature-min-alert-celsius: Alert when battery temperature is lower
> +   than threshold value.
> + - temperature-max-alert-celsius: Alert when battery temperature is higher
> +   than threshold value.
> + - temperature-min-celsius: minimum temperature at which battery can operate
> + - temperature-max-celsius: maximum temperature at which battery can operate

Perhaps 'temperature' is redundant since we have units.

Perhaps do <min max> properties given specifying only min or max is 
probably not valid?

Rob
