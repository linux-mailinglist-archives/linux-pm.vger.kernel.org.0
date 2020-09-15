Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEF726AA87
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgIOR06 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 13:26:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35256 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbgIORX2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 13:23:28 -0400
Received: by mail-qk1-f196.google.com with SMTP id q5so5079680qkc.2;
        Tue, 15 Sep 2020 10:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ClwNCqwNiTH+XbMc92JG9icvO7o9+oFNp+rebPbtpQk=;
        b=Io7nTpU88AO85hwL0s05iYAGQS8aVabfvLG8tkDcFdXD2Y6wN5CNQle1XuUD6IrPUL
         EkiG+YT0cuANBZnc0yOZ/SM/v542fKhM2N69oxE2isacRFxIxs7lcRv0ewc4nDm3L/SY
         0ntgCPhNln+Ek5laW7VKkXingaMfayLSb4kq3oRMTqyy65g4myXO8qAab0y8WHg0FIPk
         rQQC8rPn244i95RV9wFPnJAqY15iq6bEmVvNSP5o+PmQwrEnvIJLYXU/cHc24wcyIIlK
         ejoMQIAsjOnjTJlokl8U2x90CkhvL548iOiF1jgMi+E6TQAmNVt2bdsi4NRZs1HYaJmL
         hJVA==
X-Gm-Message-State: AOAM5308goe6crjbf5FG41sQ88Ce0fsT4lBjMMppOd1FETiDiLUFcpEN
        8vl1tR69ssZsCbm8A+f2wxyc2GEfOtYAaOA=
X-Google-Smtp-Source: ABdhPJwUPs+xqsam0hWo1VC/pVIhKOtSpU9OYqsl4ucdtoUjPGvGTkYmx0ZEHEn+ymnIqzI930+xjQ==
X-Received: by 2002:a05:6638:f07:: with SMTP id h7mr18604455jas.25.1600189945364;
        Tue, 15 Sep 2020 10:12:25 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v14sm7911124iol.17.2020.09.15.10.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:12:24 -0700 (PDT)
Received: (nullmailer pid 2142753 invoked by uid 1000);
        Tue, 15 Sep 2020 17:12:22 -0000
Date:   Tue, 15 Sep 2020 11:12:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Dan Murphy <dmurphy@ti.com>, devicetree@vger.kernel.org,
        "Andrew F. Davis" <afd@ti.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: power: bq27xxx: add bq34z100
Message-ID: <20200915171222.GA2142699@bogus>
References: <20200908201319.3567-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908201319.3567-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 08 Sep 2020 22:13:13 +0200, Krzysztof Kozlowski wrote:
> Add compatible for bq34z100 charger.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
