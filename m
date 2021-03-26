Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052DA34B128
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 22:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCZVR6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 17:17:58 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:33683 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCZVR6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Mar 2021 17:17:58 -0400
Received: by mail-il1-f173.google.com with SMTP id r17so14762ilt.0;
        Fri, 26 Mar 2021 14:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zsTvpCrYT0Lc4X3Z73PNNolhuuDLCbvnaIUlG9Bl/gA=;
        b=Xgxt+Z3/86kJcgRtHgm5Lghgtp6+Nr25fTxVjgKRrauSVqXd7/8skxWdBOcRRWORlD
         X6SoanePPNjP62C9ZOViJZDxHNlYS3w5yDyHsxxCy465dUPz/+0fX2/SEIWUGxLIANYq
         tRAftnHCLE6XwQV/aNCP8kKfk+4oCvmc3icm2ef1K7HTuxKxzMVgnT8bB8/D7w47dldf
         Dr3GWgaSyR9J/otJim5h7YfuU66igfxXj3sBjOpkHS5Z10SgjCXDg5qDA4DIaBCoW6qX
         +EpgtVggLOhZkp1cyKTIQUUHU3gcJmEbpDEc59+x1Dr1h3sMs9YAEu2Yzac369nFgeJB
         S5nw==
X-Gm-Message-State: AOAM532uL8rrPkk5t502uKaKnrk4SjID9foE09jYKos9+FMZAySgxyfZ
        akV34ejLF0x/DfmPSY0x4A==
X-Google-Smtp-Source: ABdhPJymPho/jDMKEZRBOFRsIGbnBuOV45w3lMbXDDVrh2c6zpyvhIrqJWUfBfpsvmt+1BRd+56+4g==
X-Received: by 2002:a92:c0c6:: with SMTP id t6mr11978351ilf.210.1616793477754;
        Fri, 26 Mar 2021 14:17:57 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a4sm4714882iow.55.2021.03.26.14.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 14:17:57 -0700 (PDT)
Received: (nullmailer pid 3876305 invoked by uid 1000);
        Fri, 26 Mar 2021 21:17:54 -0000
Date:   Fri, 26 Mar 2021 15:17:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Gross <agross@kernel.org>, martin.botka@somainline.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: tsens: qcom: Document MDM9607
 compatible
Message-ID: <20210326211754.GA3876275@robh.at.kernel.org>
References: <20210319220802.198215-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319220802.198215-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 19 Mar 2021 23:08:01 +0100, Konrad Dybcio wrote:
> Add the compatible for MDM9607.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> v4: separate from the main patch
> 
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
