Return-Path: <linux-pm+bounces-36677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209F2BFE364
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 22:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41FD19C05CF
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 20:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB20287245;
	Wed, 22 Oct 2025 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DxOz1zgT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57B2FC014
	for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165864; cv=none; b=FORhgSbDAPFtO9duDuApPPciDOLfWUvFFfCn1GZ9KZaUEDyFR3U1VCFKUQ49oIlwJyUYW6o3kGNi5I2/W2UV6cbiIiTwmlM1KSuTV41eVqpvWRIpuMK63iKfb+j8XkS/TNpIwpjYNE7wJGfNWoMa6FNuY2hgX4r+oGOIsc1rGQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165864; c=relaxed/simple;
	bh=rvDeefinbPv2YGUj1NeXEsIjJLXYrRehCCRZXtg9eUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3EwIia+8I+eMeDGlGTavuijdJScBMZ2GNKhEwbZ8+zD/DYF0ArFbKZCtE3eHLxU5AbDAOzqMs9HpNcmFbthhcF6hNQdrxURaw9/ysGNpBfTDxiRWtAimquxNV/nJ+B6Guxuth2KwuWFTPDuObAFixaW3AdofW2Cv7LTsRZnx+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DxOz1zgT; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ce806af3eso4108a12.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 13:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761165862; x=1761770662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ1rvUId+C38Hp2S9OgFvth2ijSipK3zgN+vwBP9Rlo=;
        b=DxOz1zgT62K10+GLVClGykQOGp9nHgzJ0cU0l2qSIbi9wc3rMcg6v9BfPHj8J1RrHS
         xNsWCGzI3fdwyubH7lvVDl6AR2LgSP0dRUCCprOU6b4pimCTIy4obGf8t+lN/f6dniRT
         VvcikHbeKjo2eUXSmvRnWghxlrNE+pvE+8IPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761165862; x=1761770662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ1rvUId+C38Hp2S9OgFvth2ijSipK3zgN+vwBP9Rlo=;
        b=BLLJL8Cib+AJ0OnBcaHpjZXITyx0G+YDnyBB0WmF3AopSQ788AJ22rPbKyBrrPKa9Z
         IJJuC3cCYzHF0W+mHizrDWNClkLx53q8uaolc6jHXeHja/QqZCFBP12aNKKT9xM0xUvD
         9WC1kF4I/DLXriHYxqyEc8SOSwXdAjEw1kl3WnGgurPt7pBcPZZnHYppiGgUMPYydTzJ
         Wd3vYmYRqGU6ZxLpIHUKwXdUsgwsnzAxRZcc3qrACFTemnKoZA3YlzNtUZbdJR4RhkcE
         yNSnv9Nmqt46N2/13NBMfsSmV3XS/2heYoDcpJwfkyoOJjWoB1rrT5Qa3CcVhd+KC95+
         o0fg==
X-Gm-Message-State: AOJu0YxJ5r/rLZZGwNuStLOUNeE/dyX5TjTB5v25JjO1q8JLM+mV0cEh
	qO1e/X30zizGNgxw8zVqY9PqszRsuw1d3Vz3W3z3G6iReWJWt/8FNabdljKFaoGYlg==
X-Gm-Gg: ASbGnctrjJPsLLwL4wmXYPDnRMIWxJ2jhNDVuY3WGgME+7TuSzNCqkiNFe2gUzXMWmn
	5aubxJFtGhZ7QllUA7+SljWjM+pOWaPoiU5lSpGtu2xDznMUv4eIgzb2c7/ymXuR9J/w6IdKlJP
	MrBMaiqacMGTdJJxJIdJtQVKZjX1AvGlW4Xvsr+GfiiJ8srdWUEcWXgM6F9KSczCQjG1N1ccQC5
	mg5/2xVdVOdbhEoJQdUfSV0AQ0uSEdnbsWCDrnr98FiCZbhbmTWGd5TIIb0yHiiM/294aNZZJUD
	Bh8bhedNFU6VNHCaIBzWIp+GWiyBm77sh+F3UvKs7TT7IFlZD+Vi5+gZZwRZBaM1Z2Qmg8pwrwk
	z1LGpWECWoAfxEKLFRsDIoTN9UVj/8uZwx3iQpOw2m69t8KzFBlwqS7xi5Ke3xSarePXDmLBZeg
	6gydMdwC4U3SIRmK4SvA09abAPL9isnWKBIT7M/XvkQRPk5APa
X-Google-Smtp-Source: AGHT+IFgbVcDkHTMHyBa1wbxhDGJdwbBOb+XzqgTR8+4V5KD8VlmeRYetYHI2XsnBS3QCNh2s92Yig==
X-Received: by 2002:a17:903:19f0:b0:286:d3c5:4d15 with SMTP id d9443c01a7336-290cb947798mr327720635ad.36.1761165862351;
        Wed, 22 Oct 2025 13:44:22 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:4874:d890:58d4:a06b])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2946de02cb7sm349135ad.40.2025.10.22.13.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 13:44:21 -0700 (PDT)
Date: Wed, 22 Oct 2025 13:44:20 -0700
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Lukas Wunner <lukas@wunner.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1] PM: runtime: docs: Update pm_runtime_allow/forbid()
 documentation
Message-ID: <aPlCJB3nzSbpO-S2@google.com>
References: <12780841.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12780841.O9o76ZdvQC@rafael.j.wysocki>

Hi Rafael,

On Wed, Oct 22, 2025 at 10:26:23PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop confusing descriptions of pm_runtime_allow() and pm_runtime_forbid()
> from Documentation/power/runtime_pm.rst and update the kerneldoc comments
> of these functions to better explain their purpose.
> 
> Link: https://lore.kernel.org/linux-pm/08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/power/runtime_pm.rst |   10 ----------
>  drivers/base/power/runtime.c       |   17 +++++++++++++----
>  2 files changed, 13 insertions(+), 14 deletions(-)
> 
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -480,16 +480,6 @@ drivers/base/power/runtime.c and include
>    `bool pm_runtime_status_suspended(struct device *dev);`
>      - return true if the device's runtime PM status is 'suspended'
>  
> -  `void pm_runtime_allow(struct device *dev);`
> -    - set the power.runtime_auto flag for the device and decrease its usage
> -      counter (used by the /sys/devices/.../power/control interface to
> -      effectively allow the device to be power managed at run time)
> -
> -  `void pm_runtime_forbid(struct device *dev);`
> -    - unset the power.runtime_auto flag for the device and increase its usage
> -      counter (used by the /sys/devices/.../power/control interface to
> -      effectively prevent the device from being power managed at run time)
> -

It feels a little odd just to strip 2 of the APIs from this doc, while
the rest remain. I'm not too familiar with ReST, nor with kerneldoc
integration, but would something like this work as a replacement?

.. kernel-doc:: drivers/base/power/runtime.c
   :export:

.. kernel-doc:: include/linux/pm_runtime.h

>    `void pm_runtime_no_callbacks(struct device *dev);`
>      - set the power.no_callbacks flag for the device and remove the runtime
>        PM attributes from /sys/devices/.../power (or prevent them from being
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1664,9 +1664,12 @@ EXPORT_SYMBOL_GPL(devm_pm_runtime_get_no
>   * pm_runtime_forbid - Block runtime PM of a device.
>   * @dev: Device to handle.
>   *
> - * Increase the device's usage count and clear its power.runtime_auto flag,
> - * so that it cannot be suspended at run time until pm_runtime_allow() is called
> - * for it.
> + * Resume @dev if already suspended and block runtime suspend of @dev in such
> + * a way that it can be unblocked via the /sys/devices/.../power/control
> + * interface, or otherwise by calling pm_runtime_allow().
> + *
> + * Calling this function many times in a row has the same effect as calling it
> + * once.
>   */
>  void pm_runtime_forbid(struct device *dev)
>  {
> @@ -1687,7 +1690,13 @@ EXPORT_SYMBOL_GPL(pm_runtime_forbid);
>   * pm_runtime_allow - Unblock runtime PM of a device.
>   * @dev: Device to handle.
>   *
> - * Decrease the device's usage count and set its power.runtime_auto flag.
> + * Unblock runtime suspend of @dev after it has been blocked by
> + * pm_runtime_forbid() (for instance, if it has been blocked via the
> + * /sys/devices/.../power/control interface), check if @dev can be
> + * suspended and suspend it in that case.
> + *
> + * Calling this function many times in a row has the same effect as calling it
> + * once.
>   */
>  void pm_runtime_allow(struct device *dev)
>  {

The rewording looks helpful, as it's much more API-user-oriented now. So
this looks good to me as-is, even if there are other potential
improvements to make:

Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks!

