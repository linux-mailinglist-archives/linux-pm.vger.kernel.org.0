Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1743AD40C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 22:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbhFRVBn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 17:01:43 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:42507 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbhFRVBl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 17:01:41 -0400
Received: by mail-ot1-f54.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so10973954oth.9;
        Fri, 18 Jun 2021 13:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fxuu1SlR00O4JYHpGmnvASug0gVCRNmL3ZS7usO7Ju0=;
        b=pNTPzoOabho2hDywhkSpEcgLbxxkW8+PAJk97s6TGpM6KHW1OOQMgcJSKv80xIDY8T
         sd8bAAC2g2XGlBAJ1myv/wQrUfCnojAe8NJSSGwhMsCKVDlbu+zifQ7H9Q8Zd1rQmAQy
         URFsYNdPyCCli7nZPZrkcNd+GeiHvF66J66IgfaSiO6nVV4Q+AzR9Fcmy/+UgkB79m8M
         kCq3azrmD1uBfTCTd6EksV4x7a44FDN1pXcI5d1MYDkJ2FsR8F1PvaWfOE9lmrqu0TQO
         ZUy6QbBTTfgidnU0zN27xe/cvf1+Hk3CY3PGDgIzuq4JslOcd9Zw3e3rrP2OzhOeBBbs
         ujVw==
X-Gm-Message-State: AOAM530C4OLOYK9vgEJxZvmpi0qcve5bxAXaTz6/EXYLTt+QNOKcrY+8
        a5Yg57ukJoMmXWN/5Ez0Kg==
X-Google-Smtp-Source: ABdhPJzgMu6Dq+QyQC3ugTfOKRbyXl64THAQvcc4/kPxTHEwhFyDac3jVKWcnUlscY6aFq282Zw+4g==
X-Received: by 2002:a05:6830:3490:: with SMTP id c16mr10915272otu.80.1624049971527;
        Fri, 18 Jun 2021 13:59:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q26sm2075987ood.7.2021.06.18.13.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:59:30 -0700 (PDT)
Received: (nullmailer pid 2864619 invoked by uid 1000);
        Fri, 18 Jun 2021 20:59:26 -0000
Date:   Fri, 18 Jun 2021 14:59:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Subject: Re: [PATCH] dt-bindings: thermal: tsens: Add sc8180x compatible
Message-ID: <20210618205926.GA2864590@robh.at.kernel.org>
References: <20210608201638.2136344-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608201638.2136344-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 08 Jun 2021 13:16:38 -0700, Bjorn Andersson wrote:
> The Qualcomm sc8180x platform has the usual tsens blocks, add compatible
> for this.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
