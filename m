Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1B23793A2
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 18:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhEJQV4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 12:21:56 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:38764 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhEJQV4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 12:21:56 -0400
Received: by mail-ot1-f54.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so14939803oth.5;
        Mon, 10 May 2021 09:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lK9/oyY3m8MgUruhYK2DPu5cjgnBxY2p95ZouQCulpI=;
        b=Jv6wo+A7F3rZu4ZtPJJzJhJCIgqU8ccysDFnvPgDUFCh0KhGSliQo3yGciyQBLlJu1
         xNo2KWft5HI4lL7iJMr9+pkGJtDTpl+/F+q38aFFTWO8LFQ0HTpNdylDE35P80ncIKSh
         XSoZyqvGrjuJb7cGPycaUuL2h3K+xN/LD4sDLuEtFFoVKNRl+/p6wPsJzps9oTllfmK/
         xa9TmuA0cG3M+NVOPfm7xoAl1Vq7w5+Gyp5NzaQrSqHuHywHasf5nslWliH5jb6HQZEh
         gEXMadtkksgimMbBG6Ygl2SeFowTGZes+LffO897VcNJICNlGqo1Fz1e3GecgONPUHPy
         eXsQ==
X-Gm-Message-State: AOAM533F4ygwWEjxlR2RTobaJX13KetU1L39fQRnF0ggh49qZaj3YPxw
        N4yk95IFYdPBP7lorEA9+uVQwhB7jw==
X-Google-Smtp-Source: ABdhPJwjr2gIDHJ9GnOXJIxijY4RjHXEfNYDzfLT+l/6t2ZnFp61g/9gPgf7e1AUIuBUpMN+TIVnlA==
X-Received: by 2002:a9d:73d7:: with SMTP id m23mr22219775otk.325.1620663649533;
        Mon, 10 May 2021 09:20:49 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j18sm3192624ota.7.2021.05.10.09.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:20:48 -0700 (PDT)
Received: (nullmailer pid 228437 invoked by uid 1000);
        Mon, 10 May 2021 16:20:47 -0000
Date:   Mon, 10 May 2021 11:20:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     linux-input@vger.kernel.org,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        kgunda@codeaurora.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH V3 3/5] dt-bindings: power: reset: Change
 'additionalProperties' to true
Message-ID: <20210510162047.GA228385@robh.at.kernel.org>
References: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
 <1620630064-16354-4-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620630064-16354-4-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 10 May 2021 12:31:02 +0530, satya priya wrote:
> Change 'additionalProperties' to true as this is a generic binding.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> Changes in V3:
>  - This is newly added in V3.
> 
>  Documentation/devicetree/bindings/power/reset/reboot-mode.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
