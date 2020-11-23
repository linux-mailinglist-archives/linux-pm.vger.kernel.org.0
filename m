Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88D42BFF28
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 05:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgKWEt2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Nov 2020 23:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgKWEt2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2020 23:49:28 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D63CC0613CF
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2020 20:49:28 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id 34so13093230pgp.10
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2020 20:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3DKOd9QZU+OQ+Uxsiq+URVDTtNdfohLq7Kaal7jBrUY=;
        b=ryraa9qM/VUQp3UH046zn7bKvZSSbM5orPtwBUUAE18p6LlCR9AVsl26i0sbJUIB5b
         fN//IwR7zbRrDraS+HbnRY2wcAJrq+y0jaSTY97ttFNCOM1EHhuq6dHFSDCMK4E3DeyX
         xGzUtXGD23SKKdchu89ktBW/yLSwp5j4cQqhYYxQ4+rezNi8YNyWUAe/R92fLv+ebFdK
         2oT53lnkww6YvZi4U1r8kDLkmZkrAIKgoXxUID5YwckjvhMaq62dAhfn4S1c0bQXSbH7
         o3s9uMzhof1NyieixGqnSHLWnj/bWKoqfWgbA3CM3e6h2QPOKgKxQoEW122SihWl9m5W
         f1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3DKOd9QZU+OQ+Uxsiq+URVDTtNdfohLq7Kaal7jBrUY=;
        b=nWiK68o91KrSBIUQrkYhgyqARV809E3hW8vQY2y7l5im/EyZGB9RFGYewGh0z9dI/l
         Trej3us9ViyFKc9Sll+GkfAoL8b019lvx+jQ1OHhkeK117nLf2K9u7CjvYGfFDGUKyLj
         sykCBLbHWRKsxBlVF4YB1HrUIGEskh7nMIPxggDI5g/Fe+8IHeIGAz1C+BSAc5XteyQH
         /OkURAyLkhk7zf9wjCdzYyyg7pSBrj+QNMZQnrJWXlIW9E9weT82Wmxbqim/JpKgRlm6
         mfk5Lt8WEHnI0UxXWUmV+SN+yP+CS0fYC9n9Mt2liyp66s7Pk6jQa60pF+pbj1D6N2bl
         aYaQ==
X-Gm-Message-State: AOAM531y5K523mOeIS2GTgL5LELPt9rYNA1iVhMkQkq86RZbormat5jj
        aypnhL8mIO0nXQPUkqa0ed+NyA==
X-Google-Smtp-Source: ABdhPJz/l0rwQQC5wAMZv7PZ8hOTbLf/+wdy1zwNRs87SHnieS/zTSHOjI/uHQjG/DlUqa/k6s8o2A==
X-Received: by 2002:a17:90a:8044:: with SMTP id e4mr23027728pjw.231.1606106968028;
        Sun, 22 Nov 2020 20:49:28 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id q4sm2168776pgl.14.2020.11.22.20.49.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Nov 2020 20:49:27 -0800 (PST)
Date:   Mon, 23 Nov 2020 10:19:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: scmi: Fix build for !CONFIG_COMMON_CLK
Message-ID: <20201123044920.ohr7czvictntpe4o@vireshk-i7>
References: <20201120101252.1113298-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201120101252.1113298-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-11-20, 10:12, Sudeep Holla wrote:
> Commit 8410e7f3b31e ("cpufreq: scmi: Fix OPP addition failure with a
> dummy clock provider") registers a dummy clock provider using
> devm_of_clk_add_hw_provider. These *_hw_provider functions are defined
> only when CONFIG_COMMON_CLK=y. One possible fix is to add the Kconfig
> dependency, but since we plan to move away from the clock dependency
> for scmi cpufreq, it is preferrable to avoid that.
> 
> Let us just conditionally compile out the offending call to
> devm_of_clk_add_hw_provider. It also uses the variable 'dev' outside
> of the #ifdef block to avoid build warning.
> 
> Fixes: 8410e7f3b31e ("cpufreq: scmi: Fix OPP addition failure with a dummy clock provider")
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Hi Viresh,
> 
> Addtional change to replace &sdev->dev with dev is to avoid build warning:
> 
> drivers/cpufreq/scmi-cpufreq.c: In function ‘scmi_cpufreq_probe’:
> drivers/cpufreq/scmi-cpufreq.c:232:17: warning: unused variable ‘dev’ [-Wunused-variable]
> 
> Alternatively I can create a block and pull the variable in, but it looked
> odd given there is possible user outside the ifdef block which I clearly
> missed in the original patch.
> 
> Regards,
> Sudeep
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 78318508a6d6..8286205c7165 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -236,13 +236,15 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>  	if (!handle || !handle->perf_ops)
>  		return -ENODEV;
> 
> +#ifdef CONFIG_COMMON_CLK
>  	/* dummy clock provider as needed by OPP if clocks property is used */
>  	if (of_find_property(dev->of_node, "#clock-cells", NULL))
>  		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
> +#endif
> 
>  	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
>  	if (ret) {
> -		dev_err(&sdev->dev, "%s: registering cpufreq failed, err: %d\n",
> +		dev_err(dev, "%s: registering cpufreq failed, err: %d\n",
>  			__func__, ret);
>  	}
> 

Applied. Thanks.

-- 
viresh
