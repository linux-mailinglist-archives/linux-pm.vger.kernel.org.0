Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C34DB6F
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 07:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfD2FQk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 01:16:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37732 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfD2FQk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 01:16:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so4584066pgc.4
        for <linux-pm@vger.kernel.org>; Sun, 28 Apr 2019 22:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rV+0C/EON+pvDwsZQc/OUGkTOpYnucsaznZ9bpbDOkk=;
        b=FLVNsElEyponMvp2tw0g1/rwadVUC3oIEVxbL5Pt/yKLjYQyZcB+f0QArwRbnoGwyw
         RK+akSUCU0EiZcbuUnu5FyzuCStfNuoV6RDGDf/Nb1ajKutbPduzMvA6zW+uYFR5igX/
         eeThXFLw3vSjQiJl+mctB21oEXlFPYjOKRlLOU9zOm7GRUSmW25Ny4dpk9Y8mEGxM4Qf
         uoV4jvsPyGUcELNXu08VUCbxljMIQzZBw1SArflS8kE7KnixyCPNYiMnS7mb2LPOHFeC
         oeANbLiO4apfOBtZRuoAnMtpiH34xCvO1YG+qtQurskT7A3KC0WSf2Fs+uWIpLZ/NrBK
         yMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rV+0C/EON+pvDwsZQc/OUGkTOpYnucsaznZ9bpbDOkk=;
        b=RKfcuXuO5OxQNt6JBOhbTnGyVkRffDvVVQWvYStm/0yev9dysNh1IuHW2QiyScWfjn
         cmhesuoOBhPpdkpvtZ3Q4rkXmdC0e+KZrJRdYOem0FO7jLJLDtdBda3tBZnskh07QyS0
         mOdQ34orlBPYiTNYK4yLU4zzxZb+NoHy4dgek81AAxAZxlgVJgzCCyAdpmOegRz5t1Qr
         MLsKdEbsLlgUpGfq9T9+g/g6Cq1QhWqOQZ60DGTxrCFFztXMrPauoSGlyeZFjI3gU6QT
         NPH0WcI9C3V1Cmy9jwNtHJWc0Tftx+xPwizpBKJ+zVmzkZIeQ9rE7+7kJz43KQU1W1bf
         jeQg==
X-Gm-Message-State: APjAAAV6g46eH7Ifg3eIzmxEI447JCYSQNrIrjkxFkYbYe9mR+y03RYI
        UioEslvBjWwueGZ2SxHp78Uh6Q==
X-Google-Smtp-Source: APXvYqw9OtoTofFhkVXnADqbQ31Jt9Iv4WhmeGWuuddOU2HvaUXX65CnrzcWl37LRwe1n2EXyX3XfA==
X-Received: by 2002:a63:730f:: with SMTP id o15mr38706699pgc.315.1556514999383;
        Sun, 28 Apr 2019 22:16:39 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id g6sm2474079pgi.70.2019.04.28.22.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 22:16:38 -0700 (PDT)
Date:   Mon, 29 Apr 2019 10:46:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vabhav Sharma <vabhav.sharma@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        Andy Tang <andy.tang@nxp.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH v4] cpufreq: qoriq: add support for lx2160a
Message-ID: <20190429051637.d5y4cfiekrysli3w@vireshk-i7>
References: <1556261743-20584-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556261743-20584-1-git-send-email-vabhav.sharma@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-04-19, 06:55, Vabhav Sharma wrote:
> Enable support of NXP SoC lx2160a to handle the
> lx2160a SoC.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Acked-by: Scott Wood <oss@buserror.net>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Changes for v4:
> - Incorporated review comments from Stephen Boyd
> 
> Changes for v3:
> - Incorporated review comments of Rafael J. Wysocki
> - Updated commit message
> 
> Changes for v2:
> - Subject line updated
> 
>  drivers/cpufreq/qoriq-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 4295e54..81f0288 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -284,6 +284,7 @@ static const struct of_device_id node_matches[] __initconst = {
>  	{ .compatible = "fsl,ls1046a-clockgen", },
>  	{ .compatible = "fsl,ls1088a-clockgen", },
>  	{ .compatible = "fsl,ls2080a-clockgen", },
> +	{ .compatible = "fsl,lx2160a-clockgen", },
>  	{ .compatible = "fsl,p4080-clockgen", },
>  	{ .compatible = "fsl,qoriq-clockgen-1.0", },
>  	{ .compatible = "fsl,qoriq-clockgen-2.0", },

@Rafael, please apply this version. Thanks.

-- 
viresh
