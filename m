Return-Path: <linux-pm+bounces-36941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D953C12E48
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 06:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38ED463035
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 05:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2498145B16;
	Tue, 28 Oct 2025 05:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+WJOpOy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF441758B
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761627680; cv=none; b=bqqgodbBbPJCDdwAd1///0waHJkn0UX5Sc3PEMM/TpbVaarYcosdcrEE6XDlzwaZqISQh+1MojeJa6TPkSLnJgfqyjU6mEV0nFp4j2AfHafGzRQOQRvAgTrum0PfIwfeQo3SIrzU9YFZN+pmQQom1KKExikjLw57dxiAZh/PR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761627680; c=relaxed/simple;
	bh=eXt+qTwvJszO8Hou+806wGDbl19YgC8YGTf1MQAwWR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXvaLYpb7gQBNu3kL6/kLQqmf9AmpmS/vZc6Lx+Qx+1tVLngA3Qgls8cdK52ZpqxZua/1NgSUWkMYSIxtiF4FMW9nFOl17XI/fwIAihT9nt2Y38CgP7xKJEg8Gy1ZsniMvkUWQXzyoM9suVB6rsicAzdJB5j2Cj4seG261aeWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u+WJOpOy; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6cf30e5bbcso3147657a12.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Oct 2025 22:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761627678; x=1762232478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gggGLr9hK/z0x3A0Z7RsJkNUk2lbt+1rtimRnOE0YoI=;
        b=u+WJOpOy4SoPnd6RXj3kAOT+B6BIXZ2j3QrRX8qogv9tck7i88pMIMtQPGtUAm7fJd
         qRtNr+6X2JAiPOzWRhu1hbUNEqg4mBfpAzL+//8FMSKouyXhmpPbKLFqe5J6UW4FmNhV
         GaO6H/ZwtQxrQVExPVpEKBQnnj15nWpgRol9Rbcsfh2INdASamgTqolNagNAlip4my2h
         39B168kF7MOYR5CO2PoIqBhnKgBwBGgBnmvkCA5IZfwu1EE6F4cqRg8pOn02OTbDQiug
         khjqSI9RGYdHieihoCfCvG8bkOKo8GK00QVY/V3y9KcL+q9LVDAMVXr5Abccgr/w/V2F
         BOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761627678; x=1762232478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gggGLr9hK/z0x3A0Z7RsJkNUk2lbt+1rtimRnOE0YoI=;
        b=RkFzckJXZ8F1cwIvi2wjAdlzmCt+pLlCses5WE5KZVucQErSWdlOvjA3AcE0ZUhGeU
         sZF4EFxLo7zt0fi0CnTBHYS8WJG9ZcqXzHbg1fwUx5Wzvt/HrULfaKT8RHgoe6fdaOH8
         82cRVH+yyyNucrQntTNBdMXG65Ms8lmavnJ5BNOUhPzqO2dMEMrLmoUkmJoJYxHKZqNT
         VbSpyEcXLhBX3cM1qn1ZeDyqRkNYeXkTEx5iO1mew6FtgBx8GTkkXqJhaO3dV/BQr7Of
         ae3r6kIXMB0Pab57Fjiy8ipMf2PejHa80EbfMKfvFwq5gbkrJxZomSnjS1fR+5ZwleSx
         qpGA==
X-Forwarded-Encrypted: i=1; AJvYcCUjiYCYlDiJdn3xS6eB/aTlGNqZaHgS12vakuTmA21y05Z879E28AO7pU9tRVIsTu/pvG9OzQIUCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6O2jgHN7E6oGvEW2PvA9RgXZ67xRJVlWvrD5cEDk6vaS7X97F
	CBr39riToSx6H1qkcQdIldR5IL12e5+JjQ2pdkmpRheDKRGvEalc809c/g9r/fSX/9g=
X-Gm-Gg: ASbGncvs/h12cq/zN2lQjDdJGCVWrSrC9X8K0og2dmiIyO8VZB/PavfHhMibbfBiymw
	yT1ykac0t0Zv73kMS/uFkYaicrxK9wxnGLYwgawzIVfO0r2tVG1jlHgeSa6XPlE6NcY6rI18nvQ
	2gEYT4twtWVuBnbZVk90tN0Qh83pSwgCgNyMNZnH8p1QafHNeXfBPUTCnvQf6qU3hIF08aGgjhK
	4C6Czmzi2ta5MNdF++IqNHBgDyd2XgmbXd9nLESZ9oSyY46QCERN3TIyYRF1rQSyydy0klZbTuz
	AnRk9OzDxOf3VET3cDl/WnO/+UIoBlqCoGAX1xPu3tLQnbZ59jN6IpPgk68FPEd4HEjEaOJ8Yt3
	JKgo6zlZq71baAi9Q6kuDm5q8ofkcH5kMBV7qNTL/K0gREeNv8CwqlSSlttLRUuzQlOXoULxdbk
	ydkw==
X-Google-Smtp-Source: AGHT+IEbFKSVcApo2b31IgKzoejiPT54f2Ug4CUN+na1QFDYVgo35NsLKOeM5ffDDNEZ2+JecClhPA==
X-Received: by 2002:a17:903:2443:b0:266:57f7:25f5 with SMTP id d9443c01a7336-294cc69eeefmr20200985ad.7.1761627678039;
        Mon, 27 Oct 2025 22:01:18 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm99649655ad.12.2025.10.27.22.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 22:01:17 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:31:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: nforce2: fix reference count leak in nforce2
Message-ID: <v4lyy4fexh7erlokxhkm7ha3x5lqdb3fo4csuw5ltqgortapwr@dhtgpppyrwfv>
References: <20251027150447.58433-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027150447.58433-1-linmq006@gmail.com>

On 27-10-25, 23:04, Miaoqian Lin wrote:
> There are two reference count leaks in this driver:
> 
> 1. In nforce2_fsb_read(): pci_get_subsys() increases the reference count
>    of the PCI device, but pci_dev_put() is never called to release it,
>    thus leaking the reference.
> 
> 2. In nforce2_detect_chipset(): pci_get_subsys() gets a reference to the
>    nforce2_dev which is stored in a global variable, but the reference
>    is never released when the module is unloaded.
> 
> Fix both by:
> - Adding pci_dev_put(nforce2_sub5) in nforce2_fsb_read() after reading
>   the configuration.
> - Adding pci_dev_put(nforce2_dev) in nforce2_exit() to release the
>   global device reference.
> 
> Found via static analysis.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-nforce2.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

-- 
viresh

