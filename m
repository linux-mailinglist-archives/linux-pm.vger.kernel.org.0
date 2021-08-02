Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6603DE29B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 00:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhHBWkI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Aug 2021 18:40:08 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:36648 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhHBWkI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Aug 2021 18:40:08 -0400
Received: by mail-io1-f48.google.com with SMTP id f11so22119565ioj.3;
        Mon, 02 Aug 2021 15:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pFBRzjRcM5qNGFlcKejLJeXbXCwSwAnUFA6aYzfNWKI=;
        b=S4DqVjjbBZNQVgXppKn/Vp7sr4BWsoeywIzNwLTmwKxTUxlb8cYxTPtMJLU69CR/ue
         U27cM5DHnbSIlWjTyB/7rnc2guLFKx2bO5K1YVuc61MmpgystyMzLgSO+pPHhr0OrHNt
         1WvQwzPTnxLow3f/QACoyqPlg6nAvFtGwbJRnJ7n3qoNyPY2DXy2PYktDB1H+yqTdfwy
         fRjIOS8x0eP4U0w4AAKA2PZqe3XBrXHsRHd9Snu/nTCGyAAPJDRk9lQMcgvp1AdRLfdq
         BCzHS1HR1MZQ8kHoA4z8Bz/8nodtWAV6SLrzrkQpfwJ3GzE4Ypozk5en0ShiOGEXBZo5
         dV5g==
X-Gm-Message-State: AOAM532OsyK2tOj/SHHTH4kmrp6OLLSzeGpZ0uKXCSNkSI65+DT9B3fW
        Ue+vwKP0SrCKIbtYudcmzuZw+mgZ4A==
X-Google-Smtp-Source: ABdhPJyMWYb1aCIj3OMxJEaJ3WTWPmisiebeWwCIg/q42qrpaKJfO3p26LqWpx7tSOFLpvlt3jSneQ==
X-Received: by 2002:a5e:8f0d:: with SMTP id c13mr867924iok.57.1627943997001;
        Mon, 02 Aug 2021 15:39:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v14sm7938252ioh.11.2021.08.02.15.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 15:39:56 -0700 (PDT)
Received: (nullmailer pid 1754264 invoked by uid 1000);
        Mon, 02 Aug 2021 22:39:54 -0000
Date:   Mon, 2 Aug 2021 16:39:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     martin.botka@somainline.org, marijn.suijten@somainline.org,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        jamipkettunen@somainline.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 14/39] arm64: dts: qcom: sdm630: Add TSENS node
Message-ID: <YQh0OgJxgCbbHHTs@robh.at.kernel.org>
References: <20210728222542.54269-1-konrad.dybcio@somainline.org>
 <20210728222542.54269-15-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728222542.54269-15-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 29 Jul 2021 00:25:17 +0200, Konrad Dybcio wrote:
> This will enable temperature reporting for various SoC
> components.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.yaml       |  1 +
>  arch/arm64/boot/dts/qcom/sdm630.dtsi                  | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
