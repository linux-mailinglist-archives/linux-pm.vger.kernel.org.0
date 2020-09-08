Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD1E26120C
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 15:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbgIHNg2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 09:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729670AbgIHLMY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 07:12:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0209C061757
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 04:12:23 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e33so9822962pgm.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 04:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b/dTSd0VySeqdw+oHH5saZdOjvictxCnAIOYaR0Fqfc=;
        b=keMQtUX2wYyK30rfR8xpSOFfmhiSDRRt6wNACCYY/bHebJ2IS8ScWKmh+wC5k/8sxI
         rJlpOGcY0yJ5FN+48B4SOsfJ6oxMA1ZJ7WO5eMjwXsDoYtZojnjoqRKCUdxhnCYSkCzG
         PHc3jcTIEUmYl7da7nyqMXcMehURkFBW1BovUnvGODJWVYfdefdFaw3OCtYO/BDztTts
         0Xkep27byHQXJYoRKxvuwox+A74K80Te1/z1jZAVn5RM819HV1pmylHzc8P4APtlry54
         nyqNt3knlrBfx4nyNNUV5nE6WSlJkiPhqea0bWoVmI6h/b1mPlSfk0SN9rMpdhSVvdrb
         AzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b/dTSd0VySeqdw+oHH5saZdOjvictxCnAIOYaR0Fqfc=;
        b=YMpv08YzG7o+4chJL55boFucmIO8axVVzzOYyjwrs3BbTTyjiCNnAuxmTce+huKCFn
         lxeK1RX/VUJiCPg5AlF9F54HRXmZDYDfIusVddfLjVBCsuY+DI1vQqWIlLVWnrxY2juU
         Sfs7nA0YhUMSutndBD+0AmI2GiUn8/aaJOBx1S3xx3kgYS/D//SgJzyQlojimEdYmuMm
         hUj/UxjmBVN+HmSfphQHWy6Zg2DzDEhx0sNsejI2tENE0MjY1Pjy2RG6PqMgFOSNNHXM
         l+7DTkTnGnWr55U94qRJD8NU9OnXC1ny2NozrGK3kGP1lEa3+xBhFSi4vDIFzXtQu0Md
         CJ3Q==
X-Gm-Message-State: AOAM5304gtVmMEyaW0kINGlBlxKWaYwWUZOUGS/BgV3d0WVAhWCFk7PF
        ptMX1MJsRa0BD8Fb+a0eFP/z5w==
X-Google-Smtp-Source: ABdhPJyNPwtjuZnW2qpkxc76UJcL07jTHomxfIocwdxp/SV8hx2SqxnFPK0uIWSB5rloKJlZyVEK2w==
X-Received: by 2002:aa7:961b:0:b029:13e:d13d:a140 with SMTP id q27-20020aa7961b0000b029013ed13da140mr654781pfg.40.1599563543192;
        Tue, 08 Sep 2020 04:12:23 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id b15sm17466608pft.84.2020.09.08.04.12.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 04:12:22 -0700 (PDT)
Date:   Tue, 8 Sep 2020 16:42:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmitry.baryshkov@linaro.org, tdas@codeaurora.org
Subject: Re: [PATCH 2/7] arm64: dts: qcom: sm8250: Add cpufreq hw node
Message-ID: <20200908111215.hqrenh4gvo6otkdp@vireshk-i7>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
 <20200908075716.30357-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908075716.30357-3-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-09-20, 13:27, Manivannan Sadhasivam wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add cpufreq HW device node to scale 4-Silver/3-Gold/1-Gold+ cores
> on SM8250 SoCs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
