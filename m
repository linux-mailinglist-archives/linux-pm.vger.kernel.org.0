Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DD22E25B9
	for <lists+linux-pm@lfdr.de>; Thu, 24 Dec 2020 10:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgLXJqe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Dec 2020 04:46:34 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:38337 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbgLXJqd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Dec 2020 04:46:33 -0500
Received: by mail-wr1-f52.google.com with SMTP id r7so1675112wrc.5;
        Thu, 24 Dec 2020 01:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EVammL4k3ju4OHyFY6U6viuGAjOA87chovVJY25qjSU=;
        b=VwDjSeNE5astSoHjJJHXbFVNraGY5WnHdmRSx6xXSqES0HDVwBIA+4PPEdQMkKJiQA
         ABfp2v2MNm9ZcBqNZtbaj13jh48Y2bGX0S9OlvxsYHXJxV2A1sXpdHOoZ9yllBdezNek
         GWv9IQOHd0TBMLN9XAqkkaJCKP7NWRodlHVZdGLESLY76qiYdDZg1E3RP6v5LIyFB8KR
         qYulCf2bPfpcwjtuJlw5R32i77hTRzG70iu5ebz66nGjaueOeUC+VXdEWQOJKuBcwz+Q
         cVk9USTb77IAF/Ap2EHk+2gmeUJDR/prRet6XQeZz+TlXjJwyo09XHk93YkjZI4xYP0N
         3IKw==
X-Gm-Message-State: AOAM531H3UOj5k4wa1Jh0ysl2vx+mHV5M8cuI3N2ZfiWZ/CKhTq/iZC9
        kkXQNXi7wkY0VEAAY3vDYl4=
X-Google-Smtp-Source: ABdhPJwyCv9CKcCd7knbFEp+L09KWlRSWHijomb35gc9QLD2TEPA5Xi5/Qa7TRSBT9IAgzEhAUc2nw==
X-Received: by 2002:a5d:4e92:: with SMTP id e18mr34550116wru.66.1608803151517;
        Thu, 24 Dec 2020 01:45:51 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id l8sm2705979wmf.35.2020.12.24.01.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Dec 2020 01:45:50 -0800 (PST)
Date:   Thu, 24 Dec 2020 10:45:48 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 2/7] regulator: dt-bindings: Document max8997-pmic
 nodes
Message-ID: <20201224094548.GA10937@kozik-lap>
References: <20201223134221.804943-1-timon.baetz@protonmail.com>
 <20201223134221.804943-2-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201223134221.804943-2-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 23, 2020 at 01:42:43PM +0000, Timon Baetz wrote:
> Add maxim,max8997-battery and maxim,max8997-muic optional nodes.
> 
> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>

I already acked this, why did you skip my tag?

Best regards,
Krzysztof


> ---
>  .../bindings/regulator/max8997-regulator.txt         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/max8997-regulator.txt b/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
> index 6fe825b8ac1b..faaf2bbf0272 100644
> --- a/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
> @@ -53,6 +53,18 @@ Additional properties required if either of the optional properties are used:
>  - max8997,pmic-buck125-dvs-gpios: GPIO specifiers for three host gpio's used
>    for dvs. The format of the gpio specifier depends in the gpio controller.
>  
> +Optional nodes:
> +- charger: Node for configuring the charger driver.
> +  Required properties:
> +  - compatible: "maxim,max8997-battery"
> +  Optional properties:
> +  - extcon: extcon specifier for charging events
> +  - charger-supply: regulator node for charging current
> +
> +- muic: Node used only by extcon consumers.
> +  Required properties:
> +  - compatible: "maxim,max8997-muic"
> +
>  Regulators: The regulators of max8997 that have to be instantiated should be
>  included in a sub-node named 'regulators'. Regulator nodes included in this
>  sub-node should be of the format as listed below.
> -- 
> 2.25.1
> 
> 
