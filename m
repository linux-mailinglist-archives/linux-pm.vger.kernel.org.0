Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAFAC8B4E
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfJBOdQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 10:33:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54611 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfJBOdQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 10:33:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so7476217wmp.4;
        Wed, 02 Oct 2019 07:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AVTETs+oGeEC2u9tBgMMkGrKf43RbFMMIseBuCEUcM8=;
        b=MuyHgSkNJQ2AeuGS+WNbkSvVcdfYoaJlIoTr5Ces1bmPbfcp8R4EhdwJ6XMZeNLy9s
         UCrqpTs5Z3/mj8gd3EjGhuPfeexPZg1bdysYZ59RDWmY5mjXVZZLJowskbO+SW8frfme
         +2jg2moqgbApt1vk7nqN6EfCvrGy5M26/5VdgulnH9i7FaHz7+aQwYAmXvM/KIqkp+FM
         fOMnC4cVqJgCyRW76IFKWisReV0AZpz8KyZVkdzXsSDzVZPlbkN9HDk4foE1KkVvkKvx
         SHDeWdHh+8Fah/jQRL8IvWGcxBgl0QLWuLBB+I7PIceYyeCtOH0FWOOW4o8cdep8tUou
         v+BA==
X-Gm-Message-State: APjAAAWGB/Lzn99cFjBaPm86AhWkWuRGNVxpSuUfQ7j/V0RFCqc2StGm
        QmrEdQjxCX64+W0OGL6syBLv3Z01
X-Google-Smtp-Source: APXvYqwmFvHm7rFsTvQq0Zwc4A11TsV7mmn1KrgwfBt5cGv22d6M4/7ffFDvl4S5Z0mArAq50hK9rw==
X-Received: by 2002:a1c:4d0d:: with SMTP id o13mr3249429wmh.19.1570026793907;
        Wed, 02 Oct 2019 07:33:13 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id s12sm40423949wra.82.2019.10.02.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 07:33:12 -0700 (PDT)
Date:   Wed, 2 Oct 2019 16:33:10 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     vireshk@kernel.org, robh+dt@kernel.org, kgene@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH v4 1/6] opp: Handle target/min/max voltage in
 dev_pm_opp_adjust_voltage()
Message-ID: <20191002143310.GA15898@pi3>
References: <20190910123618.27985-1-s.nawrocki@samsung.com>
 <CGME20190910123636eucas1p250ec04901f227b947cc38936563f63b2@eucas1p2.samsung.com>
 <20190910123618.27985-2-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190910123618.27985-2-s.nawrocki@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 10, 2019 at 02:36:13PM +0200, Sylwester Nawrocki wrote:
> To be squashed with patch "PM / OPP: Support adjusting OPP voltages
> at runtime".
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v3:
>  - new patch
> 
>  drivers/opp/core.c     | 10 ++++++++--
>  include/linux/pm_opp.h |  3 ++-
>  2 files changed, 10 insertions(+), 3 deletions(-)

I'll take the ASV driver via samsung-soc but I see it depends on this
one.  Please provide me a stable tag with it or an Ack.

Best regards,
Krzysztof


> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 407a07f29b12..4ebe5a6c280b 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2057,14 +2057,18 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
>   * dev_pm_opp_adjust_voltage() - helper to change the voltage of an OPP
>   * @dev:		device for which we do this operation
>   * @freq:		OPP frequency to adjust voltage of
> - * @u_volt:		new OPP voltage
> + * @u_volt:		new OPP target voltage
> + * @u_volt_min:		new OPP min voltage
> + * @u_volt_max:		new OPP max voltage
>   *
>   * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
>   * copy operation, returns 0 if no modifcation was done OR modification was
>   * successful.
>   */
>  int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
> -			      unsigned long u_volt)
> +			      unsigned long u_volt, unsigned long u_volt_min,
> +			      unsigned long u_volt_max)
> +
>  {
>  	struct opp_table *opp_table;
>  	struct dev_pm_opp *tmp_opp, *opp = ERR_PTR(-ENODEV);
> @@ -2098,6 +2102,8 @@ int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
>  		goto adjust_unlock;
> 
>  	opp->supplies->u_volt = u_volt;
> +	opp->supplies->u_volt_min = u_volt_min;
> +	opp->supplies->u_volt_max = u_volt_max;
> 
>  	dev_pm_opp_get(opp);
>  	mutex_unlock(&opp_table->lock);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 86947d53e8c4..0ee1daafe6af 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -113,7 +113,8 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq);
>  void dev_pm_opp_remove_all_dynamic(struct device *dev);
> 
>  int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
> -			      unsigned long u_volt);
> +			      unsigned long u_volt, unsigned long u_volt_min,
> +			      unsigned long u_volt_max);
> 
>  int dev_pm_opp_enable(struct device *dev, unsigned long freq);
> 
> --
> 2.17.1
> 
