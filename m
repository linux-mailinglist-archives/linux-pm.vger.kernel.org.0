Return-Path: <linux-pm+bounces-17294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5299C3746
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 05:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8BC281605
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 04:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B566014A0A4;
	Mon, 11 Nov 2024 04:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTijIKye"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FE335D3
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 04:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298284; cv=none; b=UjJRZiEfY2vndJWWea+P75Qxe3Fs8PTMEjN8LX1QAWiZrT1KyciCNNyGDqlMPRkPz3HSAgLbs3obeGvI0fdZfIlYECEkGBaCGFwDVizK7YFI2SvUge60SSu6TD9nd0glEjBtabzTUrdr3kjpzDDtqk78+mgq+tZ/ty9sDGUIdCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298284; c=relaxed/simple;
	bh=9O0Ab0snlQqU/aOeDbp4uxXowWB39iX0K9xXwo2W1X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRScw+DgL43TiCFnC+Br4cFnGbDtIJjktKil/nX48GPS3UrJopDdi28/MVxbHIRfsfr0/Cmql7ik3hVaLpg0VEoo8cv+S8K2Q+Y+KgZCxNlVkYYdOTrrBlRf5WJW4sRuTsf7L3JonIbexO8sI3CkcGHnm9UifidXXm9xqfnde3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JTijIKye; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cf6eea3c0so39409665ad.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Nov 2024 20:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731298282; x=1731903082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYw7alURWqiNGBAIOXjLelZmQpmzN91EzRD/rQ4H6Os=;
        b=JTijIKye1/ugqJC0nOaDzksUGH7PJ9IJePpm3Prq96Ne+vki6+BACRiXZ7HkMV84wE
         DW9ZHLPZ8NGXwYX8teafbgeiPBQIaGDtYb1wdvDC2GdGXknaLgwiOY3464fvEGUKaJPF
         o0N+oceLhK4GW1H5rWly0JKyC1uQkHnU+tlOl5tYDmyhNUf3rer3oHsZP7YwxAiKypnW
         KHAZW9ePJxBzZ9Y6wsg0aZo05BdevGBrg/Gz0/cDOAy3YEtC5DF2qLHkfGCIGJIl6rbw
         1sxePsXKUeEP2tjEtLlPrcKW60yvGVy9K4rhvQj0dyxonxDTfYgqMk5eo8gtD+ARByAe
         dglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731298282; x=1731903082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYw7alURWqiNGBAIOXjLelZmQpmzN91EzRD/rQ4H6Os=;
        b=BhIuZerC0+rtXl+UrgO36HeBwDzIC1WaMinmi/I6k3Pk3tAkWOHs/jae62FyZkMuKp
         aIfEkb0pwi50VIJO/J9jPmx/MZatp7O4Up5Y8DGP2hgFuHZiF6Y1WRWWeW9Jl4wCKu2R
         mbeWZT45eAE5IEkSbpIWdiuC6LhFzhdC1GVguWIR5X6ElfnlRKH/LMLe6yRckyAO1zj5
         qOaf5riCFxzmNky06vw8e2t988CCO79Z3dQwAqFJI5zKzpTdtVvQcBso9fUvyLe9axp+
         1Necdr2clOY53q8qj8wyUZ7zsJs51GF5Pmzim1RcAgdborIPO6Jk7OPv/Sq5IXEvCKfs
         r63Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEiM/2WlDlUKoUZdNqEzZbPWEaKTASq5TEqeg8P4PwZPDaxN1xqHutq8OxyTiD2c6R5RSizxvujw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCslDBWuApUx+RYU7p0pkalYgUQGG96iq2GfjNsxeXThxRF/DJ
	gW5yOpwC+2EBkRIRksN/P5v6Xnu4Qns7sw/CTC6SLqnb4+SICk7o89gGIhaYD1I=
X-Google-Smtp-Source: AGHT+IFRGzEI71Hdu+luB1BFZRo3jerd07YG2aEwXqJww2mjVFtZo+80VCzdP3gEwUJj6Och9TmB5w==
X-Received: by 2002:a17:902:e750:b0:20e:57c8:6ab3 with SMTP id d9443c01a7336-211834e6e10mr139163805ad.4.1731298282609;
        Sun, 10 Nov 2024 20:11:22 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c343sm66805845ad.241.2024.11.10.20.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 20:11:21 -0800 (PST)
Date: Mon, 11 Nov 2024 09:41:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	WANG Xuerui <kernel@xen0n.name>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/1] cpufreq: loongson3: Check for error code from
 devm_mutex_init() call
Message-ID: <20241111041120.olx5xcwo6pom5enm@vireshk-i7>
References: <20241031134719.2508841-1-andriy.shevchenko@linux.intel.com>
 <Zy3Za5JvLjk-OYjp@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy3Za5JvLjk-OYjp@smile.fi.intel.com>

On 08-11-24, 11:27, Andy Shevchenko wrote:
> On Thu, Oct 31, 2024 at 03:46:34PM +0200, Andy Shevchenko wrote:
> > Even if it's not critical, the avoidance of checking the error code
> > from devm_mutex_init() call today diminishes the point of using devm
> > variant of it. Tomorrow it may even leak something. Add the missed
> > check.
> 
> Any comments? Can this be applied now for fixes, please?

Applied. Thanks.

-- 
viresh

