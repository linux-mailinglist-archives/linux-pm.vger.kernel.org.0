Return-Path: <linux-pm+bounces-35694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F130EBB7A4B
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 19:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBCA04ED6CE
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3F02D780C;
	Fri,  3 Oct 2025 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eyO2G74h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101F2D46CC
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510969; cv=none; b=ANsQ+MZztNmWmKnyWHbfNl9trY94NFBuD5i1bYuIQwP+8I0+IxpAuEkDWrT+NDBC+/1fLzSsNEpMGfQRClyuU/xB3ThbqTurHBn/3mjLqiXEQy8B45GyRgwV9tYIRyhhK3c2qbKzeMWgBL0iUEfk4V+8E1DgH229bXEqP2Z399E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510969; c=relaxed/simple;
	bh=uUL4M6USjXif7+Zg4JLkgLeVCj1yxgT886bmk0gM+/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9tZBlx6foFzLEIJoydcHCqKZunrynnDMFm/cxwf/3qtViVKdvDcJkE1qUfZAdnecEVOKWA9g1SiYd7ZVXf4iUd0lanK8m8S4V9KauO1pH3mpSbBJnPR55sb5VKvQwH9jpnPFsSDqT0cBngCcGq4r2TQ02vklJDszLZsbDKfz1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eyO2G74h; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so1881022a12.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2025 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759510967; x=1760115767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRMekBaFzTjIb38gYN8i89LXzPK5ha2Znw032LPsVsM=;
        b=eyO2G74hdIrYrldzJIgP12opx7vwCRt1H4fwH+AheW/DnOCQBazSiSHKzNI6QMTYmG
         ZmUd9pu1SFT5BIhgI+OIkkE6fXj/6wGa+dpme9oB/nJEBojBpQXaN2UCWYdLw8orAYNL
         1idvVfBTPxIkq8NH4Q9ATxZmrp3hYWwt1kDsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510967; x=1760115767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRMekBaFzTjIb38gYN8i89LXzPK5ha2Znw032LPsVsM=;
        b=xHFAgU8TpEogpgvMshLND0BfsOac8cQALCPsRkIq4/VJ9YK1jwl6vR1bNUXHxXJi3/
         K0Fej/3/JGeMWP3ttHbPaisOg3vCmhOiE/eGj+l03HQ71MoteVjDH0gzBIdxWnE7L1Af
         YkUaWHNtajxvS02bSMhyqCF4JLlmXGyrDD09zBmPonX5TW15QlRH+kuSeeOX8zUl+W5a
         SxnFTUj01fgTx7JlkurcOt65t+69C2BFkwvbc59K8Q6FMDA18/L/+HzU1M2k/4U7CqPA
         E3QVEgUw/UyUbu1M5JCdP8QdtIy/+lsKys6RPKikXSyZ9c4SXZuk7bFiWXFTupdk4UWo
         orHA==
X-Forwarded-Encrypted: i=1; AJvYcCVCVAHpIQ7gtkbKZf/TWncjGKotPskir7v5FDhiA9ViXbB2Z3S9eEowLKUfhjpSNXu6+xE4EwU5jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+U8sg903STR8VSq42NP1/eMdY5ygtXGI0FSnLq2FW0hCbEuB
	q9JNsycKcEJ9jb5Ie9UGWL0Q2jfQdDRKtwbmC+Oa8+HpAD+rtifhRpgNyohEmZwf2g==
X-Gm-Gg: ASbGncvl819CIGf5hqrZOEs4UKwTFo9M+uffeFlt2n9yYVtDRCp6RyzL28Ab2esm7t9
	v090TIn/m5eqzZ5crj7C4BkylLTq+Ps5lB4AqV4ecra617zyekD/XzHoEpTIFW/CSErzWO/iu33
	wCOULqCW7fyfj7ePS2GbUeENDCNIxqTeyDxzVodK7r6G2u4cjKs9XW8JnC3ruLKuvRyrD75Rfy2
	LJy3DHto225X7OME+1pL11BuwZ4L7w97Nl8gOjIwAt8TKK1S5dj7wYnm+IrkjneJMEZkwsbtY0L
	528c6elk/k6c9zAn0Fv6f4QfMr52hEWL84tR3hJCK250zlBAi6ohAbldOu22uHWLYDnHsoxKt3h
	i9/DyrRcMdOWEl8AhBsGvoKlGb792ESnHsT3pI76hYL5lNj50IjFTbaZ0SHLN5N9xoWlxMcX4o/
	koQJcoss2W1j8iFaeNrx1cvmb7IHEu
X-Google-Smtp-Source: AGHT+IGw+xASGD5iDLfdgpAflDlmLL0c/ls7XDKeDwt3g+ZHIWOjmN0GPr8i61t/oBD1yS/q76AXeA==
X-Received: by 2002:a17:902:f602:b0:24e:3cf2:2450 with SMTP id d9443c01a7336-28e9a5cdadbmr43162355ad.2.1759510967432;
        Fri, 03 Oct 2025 10:02:47 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:9212:ce9:ffd0:9173])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d1d5358sm54712665ad.103.2025.10.03.10.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:02:46 -0700 (PDT)
Date: Fri, 3 Oct 2025 10:02:45 -0700
From: Brian Norris <briannorris@chromium.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] PM: runtime: Fix error checking for
 kunit_device_register()
Message-ID: <aOABtRxgm7maMsy_@google.com>
References: <aN-Xe4lgox1cCAaR@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN-Xe4lgox1cCAaR@stanley.mountain>

On Fri, Oct 03, 2025 at 12:29:31PM +0300, Dan Carpenter wrote:
> The kunit_device_register() function never returns NULL, it returns
> error pointers.  Update the assertions to use
> KUNIT_ASSERT_NOT_ERR_OR_NULL() instead of checking for NULL.
> 
> Fixes: 7f7acd193ba8 ("PM: runtime: Add basic kunit tests for API contracts")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks for the catch:

Reviewed-by: Brian Norris <briannorris@chromium.org>

