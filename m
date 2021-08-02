Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180BC3DE2B9
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 00:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhHBWyY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Aug 2021 18:54:24 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:39865 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhHBWyU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Aug 2021 18:54:20 -0400
Received: by mail-il1-f181.google.com with SMTP id r1so17933288iln.6;
        Mon, 02 Aug 2021 15:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ws7DlLtnnswMnz4Iv79PgHKEEMwGY+Hyjh4kHnupODQ=;
        b=T9BBnnXgg7Uz3FTRybQ1tIozJMbDV6yo4ie+/LC6ENaRWaMlvZqFkIhWwstwRcUcm5
         cpLquYBedVtJlm3VELIPMQYvgA0mFvrCH4EzvFYJuFjIZ3qj6kM4cIPIudMq6EKwXqXZ
         U4N5DUGsPk3vjJ0bew9X/gid0EX8ikDF+CoB6iW0SUpfjtV8+BnlR9lIvnwkfL9TbbDF
         p/3OM3ZN22AjqOla8en7aMqabWb4VXwP9oxLKP5XQCP9CRN56RMeNTCLW+/BE0ODJDbh
         ktOtG/+TaAs7vwodcT0HWiEuKw/kSltFGe3b267g0AdPX68zE85M6pRkGmXk6dBUcJXp
         rwEw==
X-Gm-Message-State: AOAM532bmZevb6wfnFhMUvWChZ1ZfoUUMTKCgNrvLxTUoB6E4rPHUeFk
        gBk1o7AKytj1v1nuhftYAA==
X-Google-Smtp-Source: ABdhPJxR+DvEPJiW5Ohrap4Z45QueUlCz6siPp+LC7c3y/KSGP97bxFsq9mhb7deasgXjUf0AOOfrg==
X-Received: by 2002:a92:cb52:: with SMTP id f18mr2529805ilq.97.1627944849513;
        Mon, 02 Aug 2021 15:54:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t24sm8106777ioh.24.2021.08.02.15.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:54:08 -0700 (PDT)
Received: (nullmailer pid 1776439 invoked by uid 1000);
        Mon, 02 Aug 2021 22:54:06 -0000
Date:   Mon, 2 Aug 2021 16:54:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     marijn.suijten@somainline.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        bartosz.dudziak@snejp.pl, bjorn.andersson@linaro.org,
        jeffrey.l.hugo@gmail.com, martin.botka@somainline.org,
        agross@kernel.org, konrad.dybcio@somainline.org,
        jami.kettunen@somainline.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, stephan@gerhold.net,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org
Subject: Re: [PATCH v8 5/5] dt-bindings: soc: qcom: spm: Document SDM660 and
 MSM8998 compatibles
Message-ID: <YQh3jjIUTnmHyzft@robh.at.kernel.org>
References: <20210729155609.608159-1-angelogioacchino.delregno@somainline.org>
 <20210729155609.608159-6-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729155609.608159-6-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 29 Jul 2021 17:56:09 +0200, AngeloGioacchino Del Regno wrote:
> The driver was updated to add SAW2 v4.1 support for new SoCs: document
> the new compatibles.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../bindings/soc/qcom/qcom,spm.yaml           | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
