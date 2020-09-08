Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7E5261016
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 12:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgIHKjw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 06:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgIHKjK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 06:39:10 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39447C061756
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 03:39:10 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u3so4590769pjr.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 03:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HkPB3R9O6sMsMd9dcUXIlXN4Isqu12Nsn8RKRzxq5sA=;
        b=pmcyoVTKycQfasYTZxfLUtFhSQv0ybyrZCo4IN6u6xwXD4apG3gW8J2XkWC0mHQ9qB
         RnEZ11gfA33JChSteMjJjrr3wxT3Fj//XADN+6L4gjPeeaUospmPkVOylRHRbXTUZntS
         4d4esBOxuiEtv1Wj81HZXjKgSsTUgXd7kD8DJxJDPSR+jDzuowQzbGfDrxdZuKQB8hLO
         0i9cuxYBDRYn4AYg/Kj7/5/INr0JGWTzJfCIjwoH3zQo0zVZ2BDfLYsK5iPJt1t26zGi
         bSgYct7wQPeC4jB71q2oO2z4K5Y2Y92+5nkMparsFKNsTH3gBqgBWCZED88Ohu0nSJNO
         QZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HkPB3R9O6sMsMd9dcUXIlXN4Isqu12Nsn8RKRzxq5sA=;
        b=JV8xEWMdIqxKQYAqAOq5btXzslBPjvbSZn7GxCp3+Psuk8hulX6wILAzjYUow4J2oo
         Tkq8hnchByRNh9tgTSXj6poNELh8U19PS//tKdfVfj0E25p3nzGVAXDrCdtzyGfMrjSv
         DwmPvx9OAzXuI67XuzwkheSxN5EDb66HoyPMCcAUvGBgHo3BIa3qkwS9QeqnFWoEHjLx
         vZpkDVVf0jxQ0LCJ6s6z0G1e4pKGKasPWxZIH6R9bVmmVztbPD4uTtG4NfM4Qz+jfG08
         xpH1CYWu7WJnly5H8HYLtyw+CqS0/g43KZMeCbGuen5Mvg/erT1gUQuPM+bzlimMZ9CT
         AWhg==
X-Gm-Message-State: AOAM533yXhgUc1ByxMordhl9+RzPjUcT+GD79gP7yI2wudmfmk4aqeOs
        g75uwPy14+klwP1SnH6ahms3uA==
X-Google-Smtp-Source: ABdhPJzDeWCog+ZMAU2G7JYbGUhamkdwx/s5HwT41dUbTU93nfQWpzRJAEPDazYH7J2RzcfE6n7jvQ==
X-Received: by 2002:a17:90a:160f:: with SMTP id n15mr3327841pja.75.1599561549629;
        Tue, 08 Sep 2020 03:39:09 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id y13sm11455913pfr.141.2020.09.08.03.39.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 03:39:08 -0700 (PDT)
Date:   Tue, 8 Sep 2020 16:09:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmitry.baryshkov@linaro.org, tdas@codeaurora.org
Subject: Re: [PATCH 2/7] arm64: dts: qcom: sm8250: Add cpufreq hw node
Message-ID: <20200908103906.sgbaw3shfdpv5pma@vireshk-i7>
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

You want this to go through my tree or ARM Soc ?

-- 
viresh
