Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986DC292F03
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgJST6K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 15:58:10 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43200 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgJST6K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 15:58:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id l85so1286154oih.10;
        Mon, 19 Oct 2020 12:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mAIEX3MCxnydcfZQGLl5+Qr/ufAD4KGlqDGMYeDQQbk=;
        b=DYehqOOWVRENeV9LpG+0PW9AVW6kbFhmo2F3UgDblwvAJqQg8dJobK7ZOToOyo6xDF
         5jdD1r7zb8OvvFPRBEC8KcXJOfL1qkficmZP2a2SPRBf+ZuPeJZ9SOyFIFd2vqBJWszj
         br27Y82ogtVBYxOqEODDdWMiwEyQggSGxbhXEqdU0S4Tz5NMqkQVSNNYlkaM45Jln56m
         QObVczD0IcZTjYzUoyhhVT2WZH6wH/drVax1uQUL1q/Md1oToNYH/2z6+EhagVSOLLob
         ggjLn3gq+4LoBTOqm/xYxQMKlPE7bA2ja9gSaHeoiGxTu5IjKBaD2iM3gPQ3JpTLXMou
         Pvhg==
X-Gm-Message-State: AOAM533As2/QljPZCxDRT4p6+4ousBIJRB61cu/M7S1XSkw8VaNNoQpR
        XcA6D1hstC13qluXxnm8lw==
X-Google-Smtp-Source: ABdhPJyfj11L8m9ewvYmM1xdCvfyfgXKQb9URLFFSGhjrk8e/3vvZfFYKTtbRi/55SOwtaIciwi6lQ==
X-Received: by 2002:a05:6808:4b:: with SMTP id v11mr717033oic.117.1603137488863;
        Mon, 19 Oct 2020 12:58:08 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g65sm177171otb.35.2020.10.19.12.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:58:08 -0700 (PDT)
Received: (nullmailer pid 3508604 invoked by uid 1000);
        Mon, 19 Oct 2020 19:58:07 -0000
Date:   Mon, 19 Oct 2020 14:58:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     kholk11@gmail.com
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        agross@kernel.org, martin.botka1@gmail.com,
        devicetree@vger.kernel.org, marijns95@gmail.com,
        konradybcio@gmail.com, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, georgi.djakov@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: Add bindings for
 Qualcomm SDM660 NoC
Message-ID: <20201019195807.GA3508546@bogus>
References: <20201017133718.31327-1-kholk11@gmail.com>
 <20201017133718.31327-2-kholk11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017133718.31327-2-kholk11@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 17 Oct 2020 15:37:17 +0200, kholk11@gmail.com wrote:
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> Add the bindings for the Qualcomm SDM660-class NoC, valid for
> SDM630, SDM636, SDM660 and SDA variants.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>  .../bindings/interconnect/qcom,sdm660.yaml    | 147 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sdm660.h    | 116 ++++++++++++++
>  2 files changed, 263 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm660.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
