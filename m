Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8BC3185BF
	for <lists+linux-pm@lfdr.de>; Thu, 11 Feb 2021 08:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhBKHg6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Feb 2021 02:36:58 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:50426 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhBKHgs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2021 02:36:48 -0500
Received: by mail-wm1-f43.google.com with SMTP id 190so4268722wmz.0;
        Wed, 10 Feb 2021 23:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E26hZOSO5nzk8NbHVh8lMEvNWJuXXaFzCrR8OzusdyE=;
        b=We63PQza2HLRippQolEjUUARRhEMsJe29DJ5SNX9plh/S91dgui3iSe+vP9nen1gRH
         VfYYuZGAjWlrqRWTKw7dEOcHxNXQJ1UHfMxSeZYGI07Hfe+ohiySLa4KbPXnQgP7Cw7F
         C/0v93yUOc+9rMfo2NDciv0eySNolUq0ktztzV/S2NRZ+j1Uwt0uIpAy+7Eypk4UbXpW
         5H96c+hfGbXOvS5ljuQkErGlzvq233PaO29oeR2t5pgLumD3fuKLnByUZE4LmT2O9IMS
         Iz/em3aYBK/NtxfNB+ll95sVKkmvgvCa4uVxB8K3QtS45M57eEuonLmuCIjWRMHN85Jg
         tAYg==
X-Gm-Message-State: AOAM530yFLzW9ocL2rjHNosiFmtveYGYqNzveMQ3TrmkiIVjTot1i+Bx
        q6BsH1DkKHYxxPCwYEEZZM4=
X-Google-Smtp-Source: ABdhPJzjzQ9SM7h2BMWNvKU17v7S7HY7ZJJ6ETtUZ2HH5CDONYHSIwOBWZbJZJTlC79MrACoGtpvUg==
X-Received: by 2002:a7b:c206:: with SMTP id x6mr3400884wmi.81.1613028965890;
        Wed, 10 Feb 2021 23:36:05 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id v1sm8230438wmj.31.2021.02.10.23.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 23:36:04 -0800 (PST)
Date:   Thu, 11 Feb 2021 08:36:03 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] power: supply: bq25980 Apply datasheet revision
 changes
Message-ID: <20210211073603.fjguvzwpnna35hbw@kozik-lap>
References: <20210210225646.10055-1-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210210225646.10055-1-r-rivera-matos@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 10, 2021 at 04:56:45PM -0600, Ricardo Rivera-Matos wrote:
> The latest datasheet revision for BQ25980, BQ25975, and BQ25960 changed
> 
> various register step sizes and offset values. 
> 
> This patch changes the following header file
> 
> values for POWER_SUPPLY_PROP_CURRENT_NOW, 
> 
> POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> 
> POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> 
> POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> 
> POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT, and POWER_SUPPLY_PROP_VOLTAGE_NOW.
> 
> Additionally, this patch adjusts bq25980_get_input_curr_lim(),
> 
> bq25980_set_input_curr_lim(), bq25980_get_const_charge_curr(), and
> 
> bq25980_set_const_charge_curr() to perform the get/set math correctly.

Your formatting is so odd, it is not readable. Please open "git log" and
try to write something similar to existing commits, e.g. without
additional blank line between lines.

> 
> Fixes: 5069185fc18e ("power: supply: bq25980: Add support for the BQ259xx family")
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> ---
>  drivers/power/supply/bq25980_charger.c | 141 ++++++++++++++++++++-----
>  drivers/power/supply/bq25980_charger.h |  77 ++++++++++----
>  2 files changed, 173 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
> index 530ff4025b31..7c489a9e8877 100644
> --- a/drivers/power/supply/bq25980_charger.c
> +++ b/drivers/power/supply/bq25980_charger.c
> @@ -52,6 +52,10 @@ struct bq25980_chip_info {
>  	int busocp_byp_max;
>  	int busocp_sc_min;
>  	int busocp_byp_min;
> +	int busocp_sc_step;
> +	int busocp_byp_step;
> +	int busocp_sc_offset;
> +	int busocp_byp_offset;

Does not look like related to changing offsets of register values in
header.

>  
>  	int busovp_sc_def;
>  	int busovp_byp_def;
> @@ -73,6 +77,20 @@ struct bq25980_chip_info {
>  
>  	int batocp_def;
>  	int batocp_max;
> +	int batocp_min;
> +	int batocp_step;
> +
> +	int vbus_adc_step;
> +	int vbus_adc_offset;
> +
> +	int ibus_adc_step;
> +	int ibus_adc_offset;
> +
> +	int vbat_adc_step;
> +	int vbat_adc_offset;
> +
> +	int ibat_adc_step;
> +	int ibat_adc_offset;
>  };
>  

Does not look like related to changing offsets of register values in
header.

>  struct bq25980_init_data {
> @@ -275,13 +293,22 @@ static int bq25980_watchdog_time[BQ25980_NUM_WD_VAL] = {5000, 10000, 50000,
>  static int bq25980_get_input_curr_lim(struct bq25980_device *bq)
>  {
>  	unsigned int busocp_reg_code;
> +	int offset, step;
>  	int ret;
>  
> +	if (bq->state.bypass) {
> +		step = bq->chip_info->busocp_byp_step;
> +		offset = bq->chip_info->busocp_byp_offset;
> +	} else {
> +		step = bq->chip_info->busocp_sc_step;
> +		offset = bq->chip_info->busocp_sc_offset;
> +	}
> +

Does not look like related to changing offsets of register values in
header.

and so on... Fix one thing at a time.

Best regards,
Krzysztof
