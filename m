Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC26091F0C
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 10:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfHSIhI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 04:37:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45817 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfHSIhI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 04:37:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id w26so749920pfq.12
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S4GHfSKQyx9obgpD6pUQlhguun535Iv+9qQdLHTCQIU=;
        b=ir9OqPH+14qK5lFOFTNB+sPUzt3MSL7+W/lXJqrmVbjMEUxHpV9idwMPgGnT/J60Yt
         f+jNFB+7G/kVPp5l/0nm08Brh2asukPu9IxfrczHHQyieOLLYPiwjABxf4aD8NEQxsQL
         qNFY+zzVc4suuEeb3qUkrTrxWX/7hVoxlGGiN8g6e0det561n0VNcJhNYzLG/oUUwJHY
         TU8hk1nmGcz6Qn8kxY+XQ0hX3VjFTYc7MR8IK+sXiodffvkzG9VpBISpS+HyQm/7+dwG
         gzd21ZIwtboOMV1L0I1QwlmEpGXTeNuQcIQrmvUMh/dxTkSBNfW+IC4aj4upgNwz+U3p
         bCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4GHfSKQyx9obgpD6pUQlhguun535Iv+9qQdLHTCQIU=;
        b=l6DM5C4uNeexfZTnu3ucKwtvss1WOA1XZO/Cc4vB8vLQ4fnQQzRkDVGZqO0zWauQPn
         /d03pqgjO27x4Vlthwp7hNJLTIgBLVLP+ofxCMRYAk/bdt16PBV2dhmfVPUUix036HGy
         euPUPBT2Kqw89R/r3iXTc90Ed2nU2ev8t9tpc+9fcH3k8DRjMU1bDn1FCGKColVRNf2F
         ZSFSnVblKEI/j3rO81js1+wRWRqIPp2GLhXHN7xfF3D9Q2A3QcX48HqlniWj6RflOD/D
         NL+3WJgqBzsuCD0cirNymHaa2eWYZb/IoQLSWShOSXQndcn7qnzdurpSoz0otcIeYCb0
         GTOg==
X-Gm-Message-State: APjAAAWsbJyAiaIaLRS2FfeSGPrbedc2MUEsqdjTVCMnjRstSwTHnih/
        im8RG+1unQMil5SYDvJPREXsUg==
X-Google-Smtp-Source: APXvYqzxl6MDX+m2ZXx/oOOpJ6HFlbhtvNzG4FiAtQifvybxRcF5ONNGhiWAU87pm52wiqpLLtBfPQ==
X-Received: by 2002:aa7:938d:: with SMTP id t13mr22083730pfe.180.1566203827811;
        Mon, 19 Aug 2019 01:37:07 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id s16sm15700182pfs.6.2019.08.19.01.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 01:37:07 -0700 (PDT)
Date:   Mon, 19 Aug 2019 14:07:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net,
        leonard.crestez@nxp.com, abel.vesa@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH RESEND V2 3/7] cpufreq: Use imx-cpufreq-dt for i.MX8MN's
 speed grading
Message-ID: <20190819083705.fqpsyk7rgqmul6y4@vireshk-i7>
References: <1566109945-11149-1-git-send-email-Anson.Huang@nxp.com>
 <1566109945-11149-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566109945-11149-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-08-19, 02:32, Anson Huang wrote:
> Add i.MX8MN to blacklist, so that imx-cpufreq-dt driver can handle
> speed grading bits just like other i.MX8M SoCs.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
> No changes.
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index ec2057d..febcec8 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -109,6 +109,7 @@ static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "fsl,imx7d", },
>  	{ .compatible = "fsl,imx8mq", },
>  	{ .compatible = "fsl,imx8mm", },
> +	{ .compatible = "fsl,imx8mn", },
>  
>  	{ .compatible = "marvell,armadaxp", },
>  

Applied. Thanks.

-- 
viresh
