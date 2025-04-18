Return-Path: <linux-pm+bounces-25699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0E1A935DF
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 12:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1B81B61ABC
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CCD254AEF;
	Fri, 18 Apr 2025 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtFZUBCw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80C270EBD
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744971306; cv=none; b=mxiNkTjdf67AaRNBGnVe4kfLL4v/Mb5CwU4GIYGfKpHOnanK2TRhshhPORy788XNVWbGRCyAF+3ED9PQn2/3QCoCIR7fIbhcFv2EK7J8wlksdqJbIHPjmoyEBPbUq+MDaBWFPFV6HU9Sx8pS7qa1TIhNOdJbUuJ9PFks+3cvp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744971306; c=relaxed/simple;
	bh=FDL0XuqWdCNXKCV6rHzlLDqABeeuPDwzCJF2k8OG2Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt6i6L5mzi0nc0nTR6/papor/qLgnagKFs4RUsvtwS9tqGaM/MVbK1cXzopxivSQY2FOD7DufgxxkB+oERBajzrRjk4kjivSjPNoo6bGfaoYoZA+fS72CZqc6u8LHNcyToSvpX/yz6NJco3rK8unOEqo/0rHO0MTN0YeivmnhwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vtFZUBCw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso8078545e9.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 03:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744971303; x=1745576103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Brm5STyxzbguEtMeEkkW8xOR3kBb6To3TGxKet6+640=;
        b=vtFZUBCwab7lW7w367P/fF3aFzK+uRlrsco+e5slPu2ySl0iJ478Wjt+CovRi87a4o
         R31qOA1CqokQxSdD7V64wtHMaiCSYdMkuma/kcfKNl+j3rTyucX5HRLBK78fwVu3Ztu0
         hYVnCQklXKdWCaVUip1twl5p07ppKWnn5IzbX51BKH7C+Td8L8vHDbuvncBd77j4Tu3M
         V4R7HigEfhiMS5KLmqAGs21aXjv8YzK+aVG2YCa8BFwxVruWxm7+jDYk1tQ3O4wYv0Nf
         7PV54OEx0txN+qA7VO+VunTR6YOP6cl/CaT35aTWz48sbFUW25bAAIGQIITJ0AiEwsES
         bb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744971303; x=1745576103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Brm5STyxzbguEtMeEkkW8xOR3kBb6To3TGxKet6+640=;
        b=Pl7z1GGMMAOSPdGcdLks082+HyZpeniwRbTsnuDP2ArlaWvwrv9xHf/hvYw58SEs27
         SqC+U+og25YYP6wBb5zMXvh+Wh6UnRqByAgVxFSavrNflVrGGJI1BGVIDW5ff476Gfxi
         iRic5gTV1iPjhM1rNItJ8An/ordRMDO7uVMuPi/RWnedH2qPNROare/FFqPidauMLx12
         6cjDJTEVMFld3bpAV/m8UF1MbcDxoDuMEfrIv7zQFVGV1mSToJxqpI8Nyje6MjKsD/1i
         92Vmnf5naSi9m77KhkFmsl17ltluAUwYSICJyMp/DncLHXj0/iKfBhB1XXKhMscviLd7
         UPDA==
X-Forwarded-Encrypted: i=1; AJvYcCULnpmHX+yPJ5ZwwxoMrxN10INSPknC+v+Wh/GwUYOXf7NtLr+oQl6huldLYmyHjphyrhMCqLQekQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ8w8Ut6J9n5Dnef5v9iAkYtFeQJjJ+o+sQMs5Q823BrTvdDWf
	cXGKORuiuIxRZALHHstZ1BTaOhzCu16awbhjG8QqQzMWKky19Np+vaJPdqRc91Y=
X-Gm-Gg: ASbGnctfcrgxJfsSVGV1BaP9+Z3Yjd4uDwCMvi4i6jmNSqoiuIbYPFd4mXThKLzBoos
	7d1O3oLT6vlQeSosjWeHVouIin/v+YG3a6Q5PCEbBbS4p2ghbOj8JtmPIIdt/LKJ5OEmnT2hVGh
	X0eB1ZphP3X+m+E2C9s140LdXTr1Mftm2AnY8kJLg5+G6vEwAnZcBCtM/WHwkPa5DvHNLCdErIB
	SGnFgaxRZloUsEAYRDs2J4rhUgfIB20yELvRZK3t5/CpWAOy4ZgdbEAJm2ywXIQlNM4LZodholE
	H0tn/BcGpIykjbM6p+pZHa/A20Cmz7C08McVbcC7AlOHRsSJDaEPXcjTJhv6N6mshyz931MbRUw
	Yhrs=
X-Google-Smtp-Source: AGHT+IEcKk9KGrLL6sDXqR3gMjy5WEdmXo67OfFx7M6ZB2w1ef+PTXxi1HWDOSvixA62VlDaDy3SRw==
X-Received: by 2002:a05:600c:4e8f:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-4406ab99521mr16674895e9.11.1744971303184;
        Fri, 18 Apr 2025 03:15:03 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4403605892fsm59513175e9.2.2025.04.18.03.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:15:02 -0700 (PDT)
Date: Fri, 18 Apr 2025 12:15:00 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Enrique Isidoro Vazquez Ramos <kike.correo99.f@gmail.com>
Cc: glaroque@baylibre.com, rafael@kernel.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, linux-pm@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: amlogic: Rename Uptat to uptat to follow kernel
 coding style
Message-ID: <aAImJGYXFDx_q8D_@mai.linaro.org>
References: <Z-MEZNMLUmj75uxN@debian.debian>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-MEZNMLUmj75uxN@debian.debian>

On Tue, Mar 25, 2025 at 01:30:44PM -0600, Enrique Isidoro Vazquez Ramos wrote:
> The variable Uptat uses CamelCase, which violates the kernel's coding
> style that mandates snake_case for variable names. This is a purely
> cosmetic change with no functional impact.
> 
> Compilation tested with:
> - checkpatch.pl --strict passed (no new warnings/errors).
> 
> Signed-off-by: Enrique Isidoro Vazquez Ramos <kike.correo99.f@gmail.com>
> ---

Applied, thanks

