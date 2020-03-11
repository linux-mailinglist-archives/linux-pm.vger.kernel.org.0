Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E114181055
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 07:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgCKGDh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 02:03:37 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33422 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgCKGDg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 02:03:36 -0400
Received: by mail-pj1-f65.google.com with SMTP id o21so1133353pjs.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2020 23:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zKMeRF7HddfnHVb8kWv4OBPengz0IeuN3e5fJnxthh4=;
        b=XY/Wn/PtObZyN+lUZ0ITV6i54XXummuNQunhHm89lzSahh96SL/vERmPc5DQ13Oxdr
         rX9EFR2Vu0qciNxUbD4Gy2F+6xaVPnp0Q1CHBeOhco8qhPdXAX35rWc9w+w05/J9dcmq
         MyYz1ZNma8kkOdAF7d8HY2nGgg9Hp+n6QQQzfErjgYsmTBvqTXjuVOtwwAhFuS2GK0nt
         MM/Q8ZyhQ0lbShT8+DX/YmjscF0JEO7KHOlN4L8MbcFgdD5rhHDm+m+oUEg0ktaDVehi
         dia4FG7fmZ0bp8XqcThxy5zkJgqwAekU+OU90QhNkJ0YBMsy7atRMBx91QEEnLsJbaF0
         IQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zKMeRF7HddfnHVb8kWv4OBPengz0IeuN3e5fJnxthh4=;
        b=E3TtXhDGi5U4Gu/FcUEmQM/2Rv06rbShVbehn2xbYWfz2HuBqkECrNFt+J5fMNx0VB
         mNRY9HJwfQtAXju9LDz/TXipH+YV7gifPO3fkmXNSwxlouNKir8K3CxvFav4uZpUPN20
         J2aL55fQ0E30cUZtKu+BX9f9OGc7J8qNpWvR5dGVbppCvIdqxRSc7XEYHeyb8EB4fqGf
         jArvGUqFWEe6v8fFoLxTQy9MHooUmKAnGvgqYqE04mxZVIOg5pnGb5aE337ONoT75+o8
         HXkhdTb4q8cRD+CJoYxAyz40bkdzFoPGIv8ahClaCrGBJdMTNlOeZZauHKVUGKQ55eKV
         OfDw==
X-Gm-Message-State: ANhLgQ3st08vNPSpDNPBpwEgVQTVIPsdeQ4/wae1SmIKD2ijIypEfNJr
        Egly36b3y+9SpSwwQYxqOPS1jw==
X-Google-Smtp-Source: ADFU+vv2VGjfxeyu1ttxNqb7u11XkmIE28Oo4Hsp+hyTV5zUueINr9oVpMPKaqCQ7o66UFKyy/Iirg==
X-Received: by 2002:a17:90a:32c1:: with SMTP id l59mr1766500pjb.36.1583906613321;
        Tue, 10 Mar 2020 23:03:33 -0700 (PDT)
Received: from localhost ([122.171.122.128])
        by smtp.gmail.com with ESMTPSA id x72sm11377214pfc.156.2020.03.10.23.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 23:03:32 -0700 (PDT)
Date:   Wed, 11 Mar 2020 11:33:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rjw@rjwysocki.net, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, abel.vesa@nxp.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] cpufreq: imx-cpufreq-dt: Correct i.MX8MP's market
 segment fuse location
Message-ID: <20200311060330.ecvdlvflahdbptsi@vireshk-i7>
References: <1583819296-7763-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583819296-7763-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-03-20, 13:48, Anson Huang wrote:
> i.MX8MP's market segment fuse field is bit[6:5], correct it.
> 
> Fixes: 83fe39ad0a48 ("cpufreq: imx-cpufreq-dt: Add i.MX8MP support")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx-cpufreq-dt.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
> index 0e29d88..de206d2 100644
> --- a/drivers/cpufreq/imx-cpufreq-dt.c
> +++ b/drivers/cpufreq/imx-cpufreq-dt.c
> @@ -19,6 +19,8 @@
>  #define IMX8MN_OCOTP_CFG3_SPEED_GRADE_MASK	(0xf << 8)
>  #define OCOTP_CFG3_MKT_SEGMENT_SHIFT    6
>  #define OCOTP_CFG3_MKT_SEGMENT_MASK     (0x3 << 6)
> +#define IMX8MP_OCOTP_CFG3_MKT_SEGMENT_SHIFT    5
> +#define IMX8MP_OCOTP_CFG3_MKT_SEGMENT_MASK     (0x3 << 5)
>  
>  /* cpufreq-dt device registered by imx-cpufreq-dt */
>  static struct platform_device *cpufreq_dt_pdev;
> @@ -45,7 +47,13 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
>  	else
>  		speed_grade = (cell_value & OCOTP_CFG3_SPEED_GRADE_MASK)
>  			      >> OCOTP_CFG3_SPEED_GRADE_SHIFT;
> -	mkt_segment = (cell_value & OCOTP_CFG3_MKT_SEGMENT_MASK) >> OCOTP_CFG3_MKT_SEGMENT_SHIFT;
> +
> +	if (of_machine_is_compatible("fsl,imx8mp"))
> +		mkt_segment = (cell_value & IMX8MP_OCOTP_CFG3_MKT_SEGMENT_MASK)
> +			       >> IMX8MP_OCOTP_CFG3_MKT_SEGMENT_SHIFT;
> +	else
> +		mkt_segment = (cell_value & OCOTP_CFG3_MKT_SEGMENT_MASK)
> +			       >> OCOTP_CFG3_MKT_SEGMENT_SHIFT;
>  
>  	/*
>  	 * Early samples without fuses written report "0 0" which may NOT
> -- 

Applied. Thanks.

-- 
viresh
