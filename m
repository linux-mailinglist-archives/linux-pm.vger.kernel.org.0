Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAF232D3F3
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 04:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfE2CpI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 May 2019 22:45:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34592 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfE2CpI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2019 22:45:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id h2so413835pgg.1;
        Tue, 28 May 2019 19:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=meFcpphhYV4WBekdUl819xcACyT3cK1yVAImW+DBKZg=;
        b=vKBpnhMUDxXTVfuhHDxSGA1iGNoWy3YA3IHXPpTxcif532Scne8fac2TqqgiBZbJdV
         cBCTi0KlDsXgds2uJHDvIwg2ZApzm12OVP2YxeQzzGuqo0FDtGZ0BDHdyOx8Q1dA3J9c
         5pHtrq5F0+133Com3l8FCMG45vSgHq1B7cq1fwR4z5EIshk99/SoPSb8GEYjDLHDLsyP
         5esli1PkXCbx14yFJE0W4t7/5AIlvmPzo/TtGLND0Ba9rzjfmlCP9OBNjb6LiShxFcAO
         ICzrEfJMhWwPbFwpDt2dutzIX7U9qd01HWoaKVh8ZL0/gys2zB290h512+6yuBeH5RLw
         gqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=meFcpphhYV4WBekdUl819xcACyT3cK1yVAImW+DBKZg=;
        b=TqvAAlMCtA59y2u+lBcCNh3uccwIbyCie45YArj0LSNK3iRS4QPCy8fTSgv9kioISJ
         gQRk8u5h4/QcsjkEkdm9wnwPOuGYR+bOg379nkOPFygoNCZbzx3Ut7Wfpl17KosKAQhY
         qOz/3HQORsNC++N80W1qXj8feNv402NDQbil307d/6on6nFhlfCpG5HAsUJl+h41oT63
         PXFfkTHGEISIsiMREtuYZWD7YJkbH2gQ2tdOlpUcae6fo5DlqMTAPN7NxaEZUgQGDNlC
         11XQNHyr3OBjQ0ej+uK6xneVQG1+kOkkJUO6A3k4ZVI/6XW+xUuXpnn4YYtfXmRodRpG
         P7gg==
X-Gm-Message-State: APjAAAV2RE/w/SMeOJgPIwdtdDtcOO/6saRkiQN2Anig/kY+ZUiNdXTp
        vg4z1Ga1XzOMXnNTkBn0wxA=
X-Google-Smtp-Source: APXvYqyepIlzlzxv7jUpcOcApw7qp6nkDcesi6SJS9N2s0ltYOCCbBg/NYVvA+9xguWWmnk1BOjmqw==
X-Received: by 2002:a17:90a:9289:: with SMTP id n9mr9481868pjo.35.1559097907598;
        Tue, 28 May 2019 19:45:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id r3sm18050032pgn.12.2019.05.28.19.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 19:45:07 -0700 (PDT)
Date:   Tue, 28 May 2019 19:45:05 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     amit.kucheria@linaro.org, agross@kernel.org,
        david.brown@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH -next] drivers: thermal: tsens: Change hw_id type to int
 in is_sensor_enabled
Message-ID: <20190529024501.GA2355@localhost.localdomain>
References: <20190527134124.14784-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527134124.14784-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

YueHaibing,

On Mon, May 27, 2019 at 09:41:24PM +0800, YueHaibing wrote:
> Sensor hw_id is int type other u32, is_sensor_enabled
> should use int to compare, this fix smatch warning:
> 
> drivers/thermal/qcom/tsens-common.c:72
>  is_sensor_enabled() warn: unsigned 'hw_id' is never less than zero.
> 
> Fixes: 3e6a8fb33084 ("drivers: thermal: tsens: Add new operation to check if a sensor is enabled")

Thanks for the patch, but we had to revert this commit which was
causing some issues. So, your patch is not applicable.

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thank you anyways.

> ---
>  drivers/thermal/qcom/tsens-common.c | 2 +-
>  drivers/thermal/qcom/tsens.h        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 928e8e81ba69..5df4eed84535 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -64,7 +64,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
>  	}
>  }
>  
> -bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id)
> +bool is_sensor_enabled(struct tsens_priv *priv, int hw_id)
>  {
>  	u32 val;
>  	int ret;
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index eefe3844fb4e..15264806f6a8 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -315,7 +315,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mo
>  int init_common(struct tsens_priv *priv);
>  int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp);
>  int get_temp_common(struct tsens_priv *priv, int i, int *temp);
> -bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id);
> +bool is_sensor_enabled(struct tsens_priv *priv, int hw_id);
>  
>  /* TSENS target */
>  extern const struct tsens_plat_data data_8960;
