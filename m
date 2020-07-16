Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3077D222BC7
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 21:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgGPTWH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 15:22:07 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43219 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgGPTWH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 15:22:07 -0400
Received: by mail-il1-f196.google.com with SMTP id i18so6054000ilk.10;
        Thu, 16 Jul 2020 12:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=khkn4T4UpW3MWVOEs8OJAq3mrIQ/B8iZQcHJwo8TpP0=;
        b=geDUBvWr04isbEMX+Qopu5Au+yeBzTAj0q3o5AAqWXCy86K1k6XXGuKAXwKC8praic
         UGYtPwIcYU1/MV1V1vRa6h4U8eUgGNjcgbTVXKhHECRl+BfeO+fPHIpqLZDIsVluzotz
         aEJgt4uqoMJIdwLjlNeqeIlIRvpec/L0FS7ONolINVIlXcmZuFd1wwRK8Wr3YjyM749D
         Tsp374Yc1c3vg7wk4d4VortSMcIFPEsY1r8QnTV2mivzPaD9ezrmvL4pikbrh/HCWjDF
         U+6F2rCsCh/RM0sJYajSgkOu22FRbeq+hah3upSmIVY8PPFjMCF5yvRYTwh7OKLvulcm
         iflg==
X-Gm-Message-State: AOAM5300e4yM4n2mSOj2ciPbIB+0y2e3p/PMaRj+oQgyhnKjd6tiSSbu
        vKRI8JV3Km5iXiDxrko5vPWWRvDZ46+Y
X-Google-Smtp-Source: ABdhPJzKRvOl5dJErYnlVV9nkZglTeQrubGKWVUGLK4EA2N846XRgBL/oS7PcTa/GtfaBKer7H7BXg==
X-Received: by 2002:a92:41d0:: with SMTP id o199mr6212179ila.205.1594927326323;
        Thu, 16 Jul 2020 12:22:06 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q2sm3109196ilp.82.2020.07.16.12.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:22:05 -0700 (PDT)
Received: (nullmailer pid 2696847 invoked by uid 1000);
        Thu, 16 Jul 2020 19:22:04 -0000
Date:   Thu, 16 Jul 2020 13:22:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: interconnect: Add Qualcomm SM8150 DT
 bindings
Message-ID: <20200716192204.GA2696793@bogus>
References: <20200713154121.22094-1-jonathan@marek.ca>
 <20200713154121.22094-3-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713154121.22094-3-jonathan@marek.ca>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 13 Jul 2020 11:41:11 -0400, Jonathan Marek wrote:
> The Qualcomm SM8150 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      |  11 ++
>  .../dt-bindings/interconnect/qcom,sm8150.h    | 163 ++++++++++++++++++
>  2 files changed, 174 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8150.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
