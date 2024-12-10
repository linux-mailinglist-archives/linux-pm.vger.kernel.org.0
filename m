Return-Path: <linux-pm+bounces-18922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101779EB6BC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 17:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEC91639A2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C5022FE11;
	Tue, 10 Dec 2024 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="f07kYqtW"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C012080C0;
	Tue, 10 Dec 2024 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848963; cv=none; b=VWbdVA9f1A9Z9b/Yp2RdrUBFGHQKqqd8ZizzbO1jmG6/GNNaTezhOQ5oBVpOzQWCZJJ/XFWf1zexTISbIrPJPwAenBEYDLX4wPlzIzvLr4iHJaiIlgvpp1oD26eXx0lQ1Z95HZojFNbCMl9ijlfracr2VNdxO4HXq8juHyF2yzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848963; c=relaxed/simple;
	bh=8UgbxDtpVAKp5DkHJqnnP3H5z3t9ezVduDOhIftxeGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+e/1NMzn7B0RgFtTQHjnTgimXrao3dEaCe9AcyXGc0RzNgIrFR5iLQY/vIWE9tRwlG10yfXLUOIRVPgRODljmLt515tYwkLc9vGlPT9LX//z7l6By7mD91sS78wv9FMRg3YngPKCBwTZrHSVN2EOioMVWYHo+zsrz3yHCLWqFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=f07kYqtW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733848949;
	bh=8UgbxDtpVAKp5DkHJqnnP3H5z3t9ezVduDOhIftxeGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f07kYqtWytQcpZQsFpnz9/zhgyTTmdRglQgfR+RWvR/lWKDLY02bfuztpOTTfRGhu
	 +GTvVoy4G3PHFsaoFOWpncy1vaT3GWsdjb93REJkLhfsu3L1X7wuaVDr472M6Yvr3W
	 7V6VRHh1rZPMvfCiJmtFLxtrO05BXsnCGljrvUBI=
Date: Tue, 10 Dec 2024 17:42:29 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	platform-driver-x86@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/4] power: supply:
 power_supply_show_enum_with_available(): Replace spaces with '_'
Message-ID: <a5f42d6a-0c32-4343-9d6a-db3aa3d6c759@t-8ch.de>
References: <20241209204051.8786-1-hdegoede@redhat.com>
 <20241209204051.8786-2-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241209204051.8786-2-hdegoede@redhat.com>

On 2024-12-09 21:40:48+0100, Hans de Goede wrote:
> Some enum style power-supply properties have text-values / labels for some
> of the enum values containing a space, e.g. "Long Life" for
> POWER_SUPPLY_CHARGE_TYPE_LONGLIFE.
> 
> Make power_supply_show_enum_with_available() replace these spaces with
> '_' when showing the available text-values. After this the output for
> a battery which supports "Long Life" will be e.g.:
> 
> Fast [Standard] Long_Life
> 
> or:
> 
> Fast Standard [Long_Life]
> 
> Modify power_supply_store_property() to accept both the original text-value
> with space and the alternative value with the spaces replaced by '_'.
> This allows users to write the value with '_' after seeing this on reading
> the property.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
> Changes in v2
> - Replace spaces with '_' instead of surrounding the text-value by ""
> ---
>  drivers/power/supply/power_supply_sysfs.c | 37 ++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 571de43fcca9..034e1848f1ca 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -237,23 +237,52 @@ static enum power_supply_property dev_attr_psp(struct device_attribute *attr)
>  	return  to_ps_attr(attr) - power_supply_attrs;
>  }
>  
> +static void power_supply_escape_spaces(const char *str, char *buf, size_t bufsize)
> +{
> +	strscpy(buf, str, bufsize);
> +	strreplace(buf, ' ', '_');
> +}
> +
> +static int power_supply_match_string(const char * const *array, size_t n, const char *s)
> +{
> +	int ret;
> +
> +	/* First try an exact match */
> +	ret = __sysfs_match_string(array, n, s);
> +	if (ret >= 0)
> +		return ret;
> +
> +	/* Second round, try matching with spaces replaced by '_' */
> +	for (size_t i = 0; i < n; i++) {
> +		char buf[32];
> +
> +		power_supply_escape_spaces(array[i], buf, sizeof(buf));
> +		if (sysfs_streq(buf, s))
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static ssize_t power_supply_show_enum_with_available(
>  			struct device *dev, const char * const labels[], int label_count,
>  			unsigned int available_values, int value, char *buf)
>  {
>  	bool match = false, available, active;
> +	char escaped_label[32];
>  	ssize_t count = 0;
>  	int i;
>  
>  	for (i = 0; i < label_count; i++) {
>  		available = available_values & BIT(i);
>  		active = i == value;
> +		power_supply_escape_spaces(labels[i], escaped_label, sizeof(escaped_label));
>  
>  		if (available && active) {
> -			count += sysfs_emit_at(buf, count, "[%s] ", labels[i]);
> +			count += sysfs_emit_at(buf, count, "[%s] ", escaped_label);
>  			match = true;
>  		} else if (available) {
> -			count += sysfs_emit_at(buf, count, "%s ", labels[i]);
> +			count += sysfs_emit_at(buf, count, "%s ", escaped_label);
>  		}
>  	}
>  
> @@ -332,8 +361,8 @@ static ssize_t power_supply_store_property(struct device *dev,
>  
>  	ret = -EINVAL;
>  	if (ps_attr->text_values_len > 0) {
> -		ret = __sysfs_match_string(ps_attr->text_values,
> -					   ps_attr->text_values_len, buf);
> +		ret = power_supply_match_string(ps_attr->text_values,
> +						ps_attr->text_values_len, buf);
>  	}
>  
>  	/*
> -- 
> 2.47.1
> 

