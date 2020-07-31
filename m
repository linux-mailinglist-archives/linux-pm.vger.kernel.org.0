Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF449234C74
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 22:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGaUrG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 16:47:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34544 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgGaUrG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 16:47:06 -0400
Received: by mail-io1-f67.google.com with SMTP id q75so24792693iod.1;
        Fri, 31 Jul 2020 13:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RB00g1jQXZ6Bb9+PZy/KFtGEl3EC1jQ5rDd2W8wczN0=;
        b=uVsHWJYOs/XPmltwCT2EhzVxEdxPJLPvP0R4WxxFOiwRv0hiJIlp05YTyb8/2e+9qe
         N5XPf8ccUc5FpTy9CE3c9H/U51b8mH6lFBS/ftLnauuz+ZlEYd3dGwohHgTd+bsG42HR
         uzUtOhjpnWYIsyaXZCO+SjfWLVILPgTT4A/Z68Ojh7f5a8egH9QWnvS0ECZa8zHXWMyv
         43phgDkNoiLkd60Mb89yKGM5XttemvkZFrp4JuDfp8ssMco1PFiTr6jHC5zMkOvpHcxF
         gjSUBoi/o83QCAaygfmWWuzVaGEvu+Eg8QxtCZub6KjJZQSzGCtQ7EkX3drqLrvngNnt
         cJFg==
X-Gm-Message-State: AOAM530V2qdhETGw2M70ttXIGhRlh13tRW8AKPIAaTfGWFhFF3SHRakF
        LAYbVo/7Plpb1TpYVxWrWQ==
X-Google-Smtp-Source: ABdhPJwEcVesRAv6xuF9lKc82DjJG0leBtkckB+qcJCfeV9wmVrA4IGlp/jkc/uo9o5uUf2NwHzVXQ==
X-Received: by 2002:a5e:c703:: with SMTP id f3mr5245265iop.185.1596228424954;
        Fri, 31 Jul 2020 13:47:04 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id e84sm5550872ill.60.2020.07.31.13.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 13:47:04 -0700 (PDT)
Received: (nullmailer pid 756710 invoked by uid 1000);
        Fri, 31 Jul 2020 20:47:00 -0000
Date:   Fri, 31 Jul 2020 14:47:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     Odelu Kukatla <okukatla@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: interconnect: single yaml file for
 RPMh interconnect drivers
Message-ID: <20200731204700.GA756344@bogus>
References: <20200728023811.5607-1-jonathan@marek.ca>
 <20200728023811.5607-2-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728023811.5607-2-jonathan@marek.ca>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 27 Jul 2020 22:38:00 -0400, Jonathan Marek wrote:
> These two bindings are almost identical, so combine them into one. This
> will make it easier to add the sm8150 and sm8250 interconnect bindings.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  .../{qcom,sdm845.yaml => qcom,rpmh.yaml}      | 20 ++++-
>  .../bindings/interconnect/qcom,sc7180.yaml    | 85 -------------------
>  2 files changed, 17 insertions(+), 88 deletions(-)
>  rename Documentation/devicetree/bindings/interconnect/{qcom,sdm845.yaml => qcom,rpmh.yaml} (76%)
>  delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
