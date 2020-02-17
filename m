Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4533F161060
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 11:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgBQKqD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 05:46:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37871 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgBQKqD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2020 05:46:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so8653728pfn.4
        for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2020 02:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=svQBb2pE2QDQnmXJ2ubumEvy+YYsjoxi5Gck3ouG2Pw=;
        b=VSgxNoy3lGhMfX52oQ6yUxFZlbLuvX1XQGrJ37RVE7JDDtOq0NzfyJMiAndI/obPga
         FRIJ3BH8RMheb1KS0hm431MUigHhUUGG+yFg9AK1bOacl9Q7kHwDxSlI4rVMJ/vB9U7I
         Cu1FCwflCaNV+HHeDqUmzJqnn2xSXHEU8S/RzAj8b3M5Bt2tN8tK//B6VFvXhHvjPWDH
         yXzGIU9Sfwcx92rbolAciLKyx5QhtNHLqz3ngD107WFx/JadZ/5eZ9kRSly8CQTKQYuc
         HaYWqY1ea1mp19t2N8kdC/4n+m+YfQ1ZLfEfLLIPJ+/3+Ai1BpIEv3CYlUKgWBMT9O6+
         t/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=svQBb2pE2QDQnmXJ2ubumEvy+YYsjoxi5Gck3ouG2Pw=;
        b=KNYeQt9EFIqnHPhShM/6/bkFxQOOtMyuXRuY3Q2+fm3ENJBPlUZNfYt/2CvGaqd2L+
         UpRIbGJqkxzzO4OENmXqGVzXmEHaljU9uppK/KtFKjT2PfELRMxLdyoA+zOHSEKCbmbQ
         SJ+yIcqokOtvWFzyiS0wdGL9CLWRQpBFgU2Gu7D/ilf7gUYXePs9q09UnMXnEZrtudh7
         ju1XCHe8GUZymu+2nMYC323wiGBP8W8XEYLFLa6AENWsnLuLoq6BPFPnPVa5DlYApGGr
         wVxK0g0GrhhhjmUb3zAb/TdhpiAMgEgOetbVoqOvF5oT5xbpaJPbsg7x7skjbIouZnVN
         VuJg==
X-Gm-Message-State: APjAAAU3m6/nsy9GOdZPuHP7VdbjrWghmKFZ8/R4SxyyqWvoC8X0w6GL
        n/WgHbwxOTjJWXBa7/zOKvhnKQ==
X-Google-Smtp-Source: APXvYqyXp8U1tk+ME6RA6QMdmXVIxA4ED5Cr/xo6hKDH+QebkM5tx/yuEXLTrJzkQ3LHPLrBblH/nA==
X-Received: by 2002:aa7:9a8b:: with SMTP id w11mr16691847pfi.38.1581936362610;
        Mon, 17 Feb 2020 02:46:02 -0800 (PST)
Received: from localhost ([223.226.55.170])
        by smtp.gmail.com with ESMTPSA id 199sm16748003pfu.71.2020.02.17.02.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 02:46:01 -0800 (PST)
Date:   Mon, 17 Feb 2020 16:16:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rjw@rjwysocki.net, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] cpufreq: imx-cpufreq-dt: Add "cpu-supply" property check
Message-ID: <20200217104600.5hkb6hclglb2x4fk@vireshk-i7>
References: <1581932575-13177-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581932575-13177-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-02-20, 17:42, Anson Huang wrote:
> The cpufreq-dt driver allows cpufreq driver enabled without valid
> regulator assigned, however, all i.MX platforms using cpufreq-dt
> driver now require valid regulator, add "cpu-supply" property check
> to avoid i.MX platforms' cpufreq enabled without valid regulator
> and lead to system unstable.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx-cpufreq-dt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
> index 6cb8193..0e29d88 100644
> --- a/drivers/cpufreq/imx-cpufreq-dt.c
> +++ b/drivers/cpufreq/imx-cpufreq-dt.c
> @@ -31,6 +31,9 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
>  	int speed_grade, mkt_segment;
>  	int ret;
>  
> +	if (!of_find_property(cpu_dev->of_node, "cpu-supply", NULL))
> +		return -ENODEV;
> +
>  	ret = nvmem_cell_read_u32(cpu_dev, "speed_grade", &cell_value);
>  	if (ret)
>  		return ret;

Applied. Thanks.

-- 
viresh
