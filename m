Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5A130DA6
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 07:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgAFGoi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 01:44:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39285 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgAFGoi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 01:44:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so18535108plp.6
        for <linux-pm@vger.kernel.org>; Sun, 05 Jan 2020 22:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EtTkEMlum47Eo5QGpV+9ONHr5+Y1zR1ZsS8D7gLSzu8=;
        b=yO2AwmQ+Q8RgVsCI8cdNTM8ykEE1L0NA2W2MKMAFbiZ+Z3VwGZIIU64YA+C/mAVeMk
         I3e3M6YzZCKziiO7ZSh0OUToMQgZNSAd3Vhz72GBsvy+qNH3v7hT5JnKQuOAgKO/+N1l
         cQ5J4J4xnyx0kYKeEc4gV1eHB3+hi2lKxxSdu1GaBqnFcaFmaKNtNPwvpoiWhrMewj9v
         LqTAyFabvrmIQvYz8S7ttjFbADCVUHaKL7jKs2QXnbHf4+szVm9iRj3v8VB6QyJhFcAO
         BegkOjRecBccj2XDUW0XAsgTvBkeikV1Ii5NCmAbkxefD0/8JVRPDtwwN8FT1kUnP9N5
         kJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EtTkEMlum47Eo5QGpV+9ONHr5+Y1zR1ZsS8D7gLSzu8=;
        b=RZfiAAkLjurC+nGUE5oSKNqSsuMctJ1WJVyTpY+hppx785+r+jB8ZW5LBbZHi/xUrp
         gKPPUJPYuQRfgyUGCnWDpzMjCs4pZDCu3rliyXw21/f/OG6lfWJLt61k07bqMrqf1zhs
         MqiR5BmrzKpIbzjeIkIhB5qfLkflmpJ9KMUWocJqDmxNyY6EqlYf0YR043IX5kuFuRnc
         1Ghd3pAbC/4bWiX6e+3pryJNjhNTKJrz/AuISU4Ui4VFvTt5L63Gvo/I36oLjRcQEdyc
         UbM1qL4fCC/fN+iJVUC32ZuiAcOOgpymI2CMIHWSUv6bdres70we78P6ACoSNcotWj0A
         wbcA==
X-Gm-Message-State: APjAAAWDe1XV0KAWL9rwqU9bFIb7j8Gkt6PgYpy/xXLxI0IivHWtfSHr
        48sMCp35goC5xAgXFGf3qPxuZw==
X-Google-Smtp-Source: APXvYqzWI+lJf+c6E2JQwLAcXgFQCe17ew2SqYD91/pThAY1j0/MUPGl/r5pUEAFSVMR4ldm12hbvA==
X-Received: by 2002:a17:902:8685:: with SMTP id g5mr106362163plo.5.1578293077952;
        Sun, 05 Jan 2020 22:44:37 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id k3sm73183955pgc.3.2020.01.05.22.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jan 2020 22:44:37 -0800 (PST)
Date:   Mon, 6 Jan 2020 12:14:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rjw@rjwysocki.net, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] cpufreq: Use imx-cpufreq-dt for i.MX8MP's speed
 grading
Message-ID: <20200106064434.y6lgh6nekiomt6wv@vireshk-i7>
References: <1577343167-16376-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577343167-16376-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-12-19, 14:52, Anson Huang wrote:
> Add i.MX8MP to blacklist, so that imx-cpufreq-dt driver can handle
> speed grading bits just like other i.MX8M SoCs.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index f1d170d..a2e5f3a 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -109,6 +109,7 @@ static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "fsl,imx8mq", },
>  	{ .compatible = "fsl,imx8mm", },
>  	{ .compatible = "fsl,imx8mn", },
> +	{ .compatible = "fsl,imx8mp", },
>  
>  	{ .compatible = "marvell,armadaxp", },

Applied both (after minor formatting fixes). Thanks.

-- 
viresh
