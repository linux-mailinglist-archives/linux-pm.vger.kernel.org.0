Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E780D202E3F
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 04:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgFVCPe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jun 2020 22:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgFVCPd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 22:15:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AA4C061795
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2020 19:15:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g12so6907463pll.10
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2020 19:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=37v9Z2NUuqEmIDRz9ZfwrUOtyxz3ECbT8f4zSnYfHZc=;
        b=KCkExZY40XAQKmTnsGnTWfYUJmKzA95HBhZPmuw4lTsn4xCJnetK+8GlvM7qExsTOC
         sJDkwc5T2E3UE65Rsuug+L2NIui/rPi/53fkrggYqHqNlRY0hcxeHraOQlXwZTsy6/bR
         bkuYWgOaY8rseIJFqUMnkRIMJ6s7qeBdjBVpy3o85QNt6uJbxibtRPi3m2MkRzWrHSTX
         UZLNOgU2+YgL5nePf9spvJZwxbe8a27Uxsys08U547TxFci9p2HHbZinkjGICt6NYo8P
         1PpNKCDWrVMrM6Ngqr4HPLa5YCWL0H3nc4oQBDfMq1uSlxSnd+MROhX0O2+cwJ+SWnfp
         jsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=37v9Z2NUuqEmIDRz9ZfwrUOtyxz3ECbT8f4zSnYfHZc=;
        b=aOSCdS/ub9dhuynE0caXSHEIGLRvsL3IwGlBfp5cH+Wi8SPXiL77mEu4vNU9DwBPxP
         SLiTwo0+lhRFDR+Ld1PLjB2r5paYVwfC7dJflg0Nxf1a3I+EmwUsO1x23ZOuSOE6hFKi
         22/w1dH2cxNC31hh2SsfyATvaZpRBXZP0GK1n3NlIoZxKPDc6TFvFut93sGlMMENbmwx
         0rFmELA7KWKyqIgKo/E/tvmXX4qc0At5KLwkb9SKXwnPTSU+zwKpjYlg20lf0o7r+i8l
         FwKSwFMlGzxnevlP/poTYNARzb0MMmL9tCvdg/HJDMZ5Kz2vMmjaBjFckEUpB8TP2Ywx
         YvoQ==
X-Gm-Message-State: AOAM532VbgokxCH42PEz+ZuFRvxJHl4puejxUEvSMzoOdcMU6LbTdPDE
        xqQmZWL+5m0ehXbenSkSEoa65PcXNdk=
X-Google-Smtp-Source: ABdhPJwPS+7RGBWUpT0GPEFKZ75DSVusV7wLo1l1FDO1Kr7CAcaD4Qq1njDS7a2sV/pjaNpTCmEjIg==
X-Received: by 2002:a17:902:fe12:: with SMTP id g18mr18694335plj.25.1592792131751;
        Sun, 21 Jun 2020 19:15:31 -0700 (PDT)
Received: from localhost ([122.172.111.76])
        by smtp.gmail.com with ESMTPSA id gp4sm11449615pjb.26.2020.06.21.19.15.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2020 19:15:31 -0700 (PDT)
Date:   Mon, 22 Jun 2020 07:45:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: opp: core: Add missing export to core.c
Message-ID: <20200622021528.gmpnvjhvq66oqhit@vireshk-i7>
References: <566735.1592672602@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <566735.1592672602@turing-police>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-06-20, 13:03, Valdis Klētnieks wrote:
> After this commit, a 'make allmodconfig' fails due to a missing export.
> commit 5f2430fb40c74db85764c8a472ecd6849025dd3f
> Author: Sibi Sankar <sibis@codeaurora.org>
> Date:   Sat Jun 6 03:03:31 2020 +0530
> 
>     cpufreq: qcom: Update the bandwidth levels on frequency change
> 
> ERROR: modpost: "dev_pm_opp_adjust_voltage" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!
> 
> Provide the export.
> 
> Fixes: 5f2430fb40c7 ("cpufreq: qcom: Update the bandwidth levels on frequency change")
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 6937bf45f497..c9336aac74e9 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2302,6 +2302,7 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
>  	dev_pm_opp_put_opp_table(opp_table);
>  	return r;
>  }
> +EXPORT_SYMBOL_GPL(dev_pm_opp_adjust_voltage);
> 
>  /**
>   * dev_pm_opp_enable() - Enable a specific OPP
> 

Applied with reworded logs.

-- 
viresh
