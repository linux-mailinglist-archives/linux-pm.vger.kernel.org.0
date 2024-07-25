Return-Path: <linux-pm+bounces-11385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E21F93BB3E
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 05:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F83C1F22271
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 03:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE79A1799D;
	Thu, 25 Jul 2024 03:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arYavAvZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86A11711
	for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2024 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721878269; cv=none; b=QVkT7DreyHiQXHPctnW3DGqedYCXobkoYO9unYhV5/IrPtb2Kq7L63wuvqgUqR7lPH0N+d6OxJNjXxEAoKrB8Zsvx3gZHqqANhPr1H1l4R6n7kKTKuA/m/W7nfceWjV0DixBmtVHKJ7CV9o8EkcnbaHehaxdfH/fijD/GXiqmp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721878269; c=relaxed/simple;
	bh=d4Md/pmd9aAH6BP2SJNyitKaq4lM6GrSPXh+qAunH6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xf4Lw37/h2XE1We2kaEFPzFgIqZRLKoc0g7GvBT2wazBSfztTweMTvZUvw2GQ+QbuK+bBjVTPP/Pw3PtpHR1kCOvqZiYPddJ6/ONJ3V1jOhbFvUUx9shBlXCVwSbNWWbksCENawkB0NhvusIYZ/xehruhJWxeuMFL+t3f7hvcMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=arYavAvZ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f008aa351so478421e87.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 20:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721878262; x=1722483062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhbT1eQ9YPVhIQslZbZZbHdi4UGZ5NhIA5kAWua5Lkg=;
        b=arYavAvZnL/vVCTWS9TvqTL7SyHo2HJYo6xsUwOy57I7cahOBK9sH0XNh3ugN74ufY
         ucz3wjoaOlUEnAlmcA6ykMKwzBoIVG/YKHCAz6hNmIG4qMrnQp4Eu8W5gyCDOVVlCbd9
         CH55OYeC/2A05N8akgPn/PvANCrx4O1aT7q1YiZT/l/2CsO/tWeVYoEe3FLC3d7Gpupb
         obW4Z+USMDXZT6SLnWf9Qhtq/YSWpaHZHuhBBewJovTwZv5arHA5JUwzx19BA7gvMA/G
         4I9qj12ekLW+8nbf2CY028lAzMyaTJt0+ebt6Fqt8MZ5Br90WZxEs/z+TjSfzi2LgV+p
         +kIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721878262; x=1722483062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhbT1eQ9YPVhIQslZbZZbHdi4UGZ5NhIA5kAWua5Lkg=;
        b=bwIjvvsI7B1Q9/pHDOLuZ2EErJflo+SWRszV6uQBPqNJJ8xzCD2b+Oz1eg1zVjZq1t
         RYwyM1Y/fq4Qutz/pi4qULLNNjmbas0xhg5WQroN0Dy5pJfNAwGN4ipREpA1rRrHF4+8
         xFhddeynsqN+kmH6VMe9OZvGYoyccrTp8D7C8ukHoQFy6Nv/ozsZDejEqvnTqkr+6z6Q
         jWgnZmqFphrnbd2ui6HinkJPy5+JVhFGGvVOu2Yh6d/3/3HTb0D/Yan1Dyds/W65Zcsx
         QhP3bdQraK2e2WFjqyka0OBS/Xdtk9i81McBXXbsIUSnkfK5tTZXsd+GDWfNxjXQ+i02
         VLzw==
X-Forwarded-Encrypted: i=1; AJvYcCW74UpJy7YukhFiK/BzlGzTiDEHgay6S5nXv/a2/tvB/sMmsoX1j8ozc13HJeA/QwYve4IaC2O3oRmNHpszka1GZq7HzY7Wthg=
X-Gm-Message-State: AOJu0YzhzLjnTdR8/3iXr1QSG3auqN9H7meuXQ8NNd7JR3wEUsfHHGTr
	y/ovqiaelD5IeuMmQuWfJKj55s1axxIMD28I751WafEjkyzLkRYSZpTstn3zA2k=
X-Google-Smtp-Source: AGHT+IFjMhfs1uKv8o8eDUmQrRbd/e1o4QszP3+4qeKeaqccHoFSZFfQnx4HsVLlt3eN+89oHv6Bbg==
X-Received: by 2002:a19:f70d:0:b0:52c:e0fb:92c0 with SMTP id 2adb3069b0e04-52fd60439a8mr261657e87.34.1721878262339;
        Wed, 24 Jul 2024 20:31:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08248sm63127e87.125.2024.07.24.20.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 20:31:01 -0700 (PDT)
Date: Thu, 25 Jul 2024 06:31:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jameson Thies <jthies@google.com>, Sebastian Reichel <sre@kernel.org>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	bleung@google.com, abhishekpandit@chromium.org, andersson@kernel.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Add status to UCSI power supply
 driver
Message-ID: <tzljywuym6jsh5q5iuc7rrtq564d3ffl3e4ltuii7xzkd6cf7d@2nmj5qkusbkt>
References: <20240724201116.2094059-1-jthies@google.com>
 <20240724201116.2094059-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724201116.2094059-2-jthies@google.com>

On Wed, Jul 24, 2024 at 08:11:13PM GMT, Jameson Thies wrote:
> Add status to UCSI power supply driver properties based on the port's
> connection and power direction states.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>

Please CC Power Supply maintainers for this patchset (added to cc).

At least per the Documentation/ABI/testing/sysfs-class-power, the status
property applies to batteries, while UCSI psy device is a charger. This
is logical, as there might be multiple reasons why the battery is not
being charging even when the supply is online.

> ---
> Changes in V2:
> - None.
> 
>  drivers/usb/typec/ucsi/psy.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index e623d80e177c..d0b52cee41d2 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -29,6 +29,7 @@ static enum power_supply_property ucsi_psy_props[] = {
>  	POWER_SUPPLY_PROP_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>  	POWER_SUPPLY_PROP_SCOPE,
> +	POWER_SUPPLY_PROP_STATUS,
>  };
>  
>  static int ucsi_psy_get_scope(struct ucsi_connector *con,
> @@ -51,6 +52,20 @@ static int ucsi_psy_get_scope(struct ucsi_connector *con,
>  	return 0;
>  }
>  
> +static int ucsi_psy_get_status(struct ucsi_connector *con,
> +			       union power_supply_propval *val)
> +{
> +	val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +	if (con->status.flags & UCSI_CONSTAT_CONNECTED) {
> +		if ((con->status.flags & UCSI_CONSTAT_PWR_DIR) == TYPEC_SINK)
> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +		else
> +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ucsi_psy_get_online(struct ucsi_connector *con,
>  			       union power_supply_propval *val)
>  {
> @@ -249,6 +264,8 @@ static int ucsi_psy_get_prop(struct power_supply *psy,
>  		return ucsi_psy_get_current_now(con, val);
>  	case POWER_SUPPLY_PROP_SCOPE:
>  		return ucsi_psy_get_scope(con, val);
> +	case POWER_SUPPLY_PROP_STATUS:
> +		return ucsi_psy_get_status(con, val);
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 2.45.2.1089.g2a221341d9-goog
> 

-- 
With best wishes
Dmitry

