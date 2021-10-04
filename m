Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF74C4207C1
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 11:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhJDJFC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 05:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbhJDJFC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 05:05:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FDBC061745
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 02:03:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so3037181pjb.5
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 02:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lq895Nb4Ct+Ub9VR31k06exDUume1AHkepUF0n7GX6I=;
        b=DoauARro51+RAFBcQnseSJBz3MSOSMh9B5dQ2DKxxGDyXK1Qy3KbaajVARZ5C5zHco
         0+F31TdKV04Nc9fYfW1PzN24o6r857zFIy5crfaAieQfEf7xKQs+LwCdZGbCHKg49g1F
         xzXRYqBi6OsTz6GkZmY4dmwwcf3HSowpdTs+Nskd0VnIdkV7UKtGGIxOy6YSSZF2hJiY
         IDcaCGmSYWOrP6sjU9aTpKCRvRXAqSAJRmIOk35dzIsB9iqhfQf7kzE1HU1gc4OfNBB4
         XpygESY0O2aUB5U41GChlGixCY1Pc3xHMfUSXqQtQfaI2N5qKZJ7GK3QZf14ZeHOxQJn
         6xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lq895Nb4Ct+Ub9VR31k06exDUume1AHkepUF0n7GX6I=;
        b=XkZ/wo6MOnklljs7Y82WUEXDEXC5zDfnld2oW7nCAI0LaEnzBcRDokI62s52geN+iS
         3WTqrO4eECiTLd7eAcSHGQZC2JkPUR4Y350oEiRyO6BO41HGcAFmEQzchJ3+FxCFZWfi
         lNQevaHAMltO1+DKWe3TqtusSg30O+oKPtz638CetiRRcLoUqiDCpl15ssITiNMnxm+p
         bGR2TFmW1pPuBYD92zRjX76eb0JhWSsrMM25iBllLzYCSdJUodRiIwbGTN7I5Z5xr7P5
         r+Z7steaeJW6w87EQqI4zCd3WA+KKziLnjuWoK5rfJ34xDC5HhcTGlSwXtuS6plNwV6W
         S+1w==
X-Gm-Message-State: AOAM533fZxJqF6W4HKmy/U3iVHCOmrJ1OfhTipCY8DVGJTAI58RRSdOV
        B4SS28w9uNdKex/X4zZ6jRrOyA==
X-Google-Smtp-Source: ABdhPJxJcS0g7wFeeSHz3t6QcKZVb7PuQOGEmvH6cBs66mWGAKJyWwuW2FIhrKRi36aBWjXYf5WFog==
X-Received: by 2002:a17:90b:4b89:: with SMTP id lr9mr3432892pjb.11.1633338192932;
        Mon, 04 Oct 2021 02:03:12 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id k5sm15281374pfc.111.2021.10.04.02.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 02:03:12 -0700 (PDT)
Date:   Mon, 4 Oct 2021 14:33:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rafael@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML
 bindings
Message-ID: <20211004090310.pwtsjpmwajivclxj@vireshk-i7>
References: <20211004044317.34809-1-manivannan.sadhasivam@linaro.org>
 <20211004070531.sexvnqmnkoe4j6a2@vireshk-i7>
 <20211004072222.GE16442@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004072222.GE16442@workstation>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-10-21, 12:52, Manivannan Sadhasivam wrote:
> On Mon, Oct 04, 2021 at 12:35:31PM +0530, Viresh Kumar wrote:
> > On 04-10-21, 10:13, Manivannan Sadhasivam wrote:
> > > Convert Qualcomm cpufreq devicetree binding to YAML.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > I am not sure if Rob ever gave this.
> > 
> 
> I'm not fooling you :)
> https://patchwork.kernel.org/project/linux-pm/patch/20210701105730.322718-5-angelogioacchino.delregno@somainline.org/#24312445

Btw, I also wondered about this since we now have "performance-domain"
bindings and was thinking if this should be moved to use those or not.

Rob ?

-- 
viresh
