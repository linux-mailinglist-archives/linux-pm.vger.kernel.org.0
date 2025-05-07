Return-Path: <linux-pm+bounces-26829-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43329AAE68E
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 18:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2AA525520
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76123215197;
	Wed,  7 May 2025 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKQjP0u7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAAE156237
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635030; cv=none; b=f9Pf2aDAjMb+3qx2mnwJhlzEgF2zNKr82Ju7pkeOyQWdMhmil1W5iulQANXoc7wxTnrOPWeORhZ4QqUd+UyOkYcp9GC3kaUVlwtldS9SI97iNZfNYPWaU36Fyb+jfUyvvlj1wS2IOkNH81Lt0qVvJ6+0uNiy1O6dQST/P2Aq4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635030; c=relaxed/simple;
	bh=GVDVeBab869aYBvCQlDw416oEjXOoR2zkFp+c7adIZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knwP/7ZamPUrMXGCSsckizLPyPC1k4aFvYgjlXqRH25wCQIO3rRUyNnzusXG3oZPeCqm1soUShhZLNjgoeRdMAKr1yjUFSx+ggMpEoaJmGzYSWgqisls7awU2V2S6QyKxpPraP4d7X3IsMc4+fRWGkDnwbaTKx/r/K75n4tZSgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QKQjP0u7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso296855e9.3
        for <linux-pm@vger.kernel.org>; Wed, 07 May 2025 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746635027; x=1747239827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NdgRnYflnPlN6KlJOaYP1q0InGmD8pNNwfuxpkTXEio=;
        b=QKQjP0u7j6tV0U62Bbj/W89PJ8hwqtbNlR8DMr8z2ONWvT1O0/64dta2QE7V7FuqyI
         uDHgMDgT8xPZS8BIJnrN/Y1Ua/QGjY+hhyPWMJGv9aCP9ZTvrNkRCuVyjHYvcB8pv5QW
         niB7ougtqQmCmuoNC2jYr1/P87vE1STe8RUlhNez8VQ+ECG+61a4z29ltD0B6GtPC8uj
         XqZMBCF1ijGJVds1W4vsIuHV6BlzAjfAW2RT/MHxW40Y9C4tuuPJm4PRR5FmfTQ4Zv06
         qKp36Kl99XH01i0N0DRo8e/emXChWby2Z9U6GnVOjPk5TA5ceTEMqzLmFgUadQsNXhJz
         3VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746635027; x=1747239827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdgRnYflnPlN6KlJOaYP1q0InGmD8pNNwfuxpkTXEio=;
        b=ofw2NYaBCvcOlJRL/7JdzfkJ8Z0XF4WXsYF0uQH9KLKJee49OnO+iIZnqlq3AeC0WL
         xQNJ4SpmVfSi1EP7U2OSnF5ShQ5eOoD3GXl5w80jHyyBHjlkHhnI4ewr64cE7+4HQwvz
         m7aNa3MThWfVFsKitEYbqC5hhIytFeARyABUuYHt5oieTYF5Gz+NOJo8CR55foyTgoQe
         hLYFyg978wuzDGCSiFyBnjjBLgDKVRLt46lJ+16vrlfacXXY09KSRN27oZLIGCJ56MM0
         GQnRiSY1pxRV6tn7UMJqzMXSZb7/3XirhmYGM2z5XU8M4Ywa4cnWId0B1POEpOz6urt+
         tR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnwZEbmVjmz3A4cdJAV/QBs2KdXFmvPbvWK4KKvNz6OMCfql+mZpkqoD12j0QM8+0mEhts3uaWxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUm8O5bO37JE8+j7wuoDeJuzA2GcgtcvBSojRhgh/Df86iMUpr
	S5GRmh7/qJbr23tLFY9LtvG0AW9kDgRcJAKhm+wXjrrfoP4oPP9j0vdSUTsAERg=
X-Gm-Gg: ASbGncsE2HPxBxMzLXvOGXwoNqVmeQW0SzL9NRbT9XPXo8vtlPbDqkqRwgBe8b4PSVG
	KN+M0yyp83LseH9dBdwRsOzmLZ4lgYdtZK9NsilaQJbvlh6O6CMR41jHQy7q4c8IWqu0syDq4N9
	sSdWvpFVyToku2jhZ4QIMsgxTk7syO6n21UXhU06pu1mPhFHQdfrtRuoaaZzx6/BVPxDa4Rwoj3
	G0O92//DpdZInwt4/yLDxtiFy/Ko01ORiDxlbss5WNQvmR6DWLhuV9VVsyLV6F5xkFId7NYYJtZ
	FvQ8f6mm2dKrtJ52bsMKmeRqZ2O50t0m+DDqYpW6me4bzA==
X-Google-Smtp-Source: AGHT+IE6y0LlIV4IlIooPu6OJTNcYKnkqYqnx0WCylTRROLNd4cSZyHpQkJmtgiFMm+bT9j1cn2H6g==
X-Received: by 2002:a05:600c:4e47:b0:43d:36c:f24 with SMTP id 5b1f17b1804b1-442d02ed455mr1853855e9.13.1746635026951;
        Wed, 07 May 2025 09:23:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442cd32f0easm5943165e9.12.2025.05.07.09.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 09:23:46 -0700 (PDT)
Date: Wed, 7 May 2025 19:23:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] pmdomain: core: Export a common ->sync_state()
 helper for genpd providers
Message-ID: <aBuJD1izaMqKUJ_s@stanley.mountain>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
 <20250417142513.312939-8-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417142513.312939-8-ulf.hansson@linaro.org>

On Thu, Apr 17, 2025 at 04:25:05PM +0200, Ulf Hansson wrote:
> +void of_genpd_sync_state(struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct generic_pm_domain *genpd;
> +
> +	if (!np)
> +		return;
> +
> +	mutex_lock(&gpd_list_lock);
> +	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
> +		if (genpd->provider == &np->fwnode) {

Presumably this would be "== of_fwnode_handle(np)) {" as well...

regards,
dan carpenter

> +			genpd_lock(genpd);
> +			genpd_power_off(genpd, false, 0);
> +			genpd_unlock(genpd);
> +		}
> +	}
> +	mutex_unlock(&gpd_list_lock);
> +}


