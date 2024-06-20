Return-Path: <linux-pm+bounces-9709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F94911096
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 20:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F36A28481B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 18:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055BE1C0051;
	Thu, 20 Jun 2024 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8VVoN6C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9580A1C0049;
	Thu, 20 Jun 2024 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906916; cv=none; b=V8u4LWRER0eGV/bRNGxtOUBPWyELpAOxRPLmvZi1MQaPHG1I4S9mMCKrt+cdoufE9N2+cn26hXgvAynE9gaLzoUGurYND6hceXlSNY8eJorV6MX59ujWPoXdCSzbAIZWRaVJUgsbNr66TGe34upODRbspfH3n7hNvZ2gJZfoXuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906916; c=relaxed/simple;
	bh=RmTUkgIbisgmu5NGs0B6uk2CJ7jiGJG9C7GPIIc0uKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcG3d+TQH4SKfTCpnqG41nbJr6uvNHP23X3LSqZ2F3nvLIvDZG8UbqH0AhSXu9OUhGRM2a3SKY2gJB0pWexH7dI9836emZ2jCYNllUwiY9Txa7zAYcrx7N/gqVfcur4AbkxKnHwyw1mcZGHoRVL05yYTnv5HcsGpvn2ROSZE020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8VVoN6C; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9aeb96b93so9350955ad.3;
        Thu, 20 Jun 2024 11:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906915; x=1719511715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4idhvUsSBZuxb0acSR7UlgXt7Z0V07BIN0WU/iMFeKk=;
        b=M8VVoN6Cz/KQpY9LDZA+z4PPeSZCKeKe2wb36KTs6DCm8/hZPWBigAQQSW1V0x9fNq
         Og0wA47+ePYj0yd6YNn2qaXNQmtZ9TUoxaP0z3c5F9j1KGXIGCR2bxNwBgK6XlOXmXPV
         eMyk+qFVgJAW9SD8sjtxqY0j9uisuSP9f06PyksW+Ou5niW/Qa4/odwSsNBDxVmQMoqI
         h5kYbLUXG+KlfiLiHka4qkD9UyY6+JGV4pilbIyyJXRSmQ2pTdc7pXt/7xS15wBpUJxy
         HZoqpNUmofjwf6098cfPDzV7k73K2YBnh7LThFwpBDkayuKSJSdZFTZb8z/L2ijCSWON
         T2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906915; x=1719511715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4idhvUsSBZuxb0acSR7UlgXt7Z0V07BIN0WU/iMFeKk=;
        b=xDoFwlAP5hBivhkFtnZMsuFBUFZnClQ+ol5n1rBVr2czB+7GJZfK4ayc9dBiR5CG/5
         sY+i//7i96JOr5+A+KpoiO+4Vgwqfbg2JQcfHmHkggBMnL+Aqb0BUHgjBtjGYE+XHREc
         5PGBtvRJx7B7xJGrv5/JBQCBNLwmh0m2ZUJqVigcgfJ4hQFsE0MrMw8YylGWdav/XObf
         wgwqVdBPNNFDfyJnbuRG0Gp/a3qv+rVclQefzjAh+wRR6D8UsyveZbLAuDWzgOk3BWIg
         0nfg4UTmlb8Ae6FEXnNySR7yAEkffH++rBpw5ZYju0HgNtzaM/+I8aqYdAYEKj+hhiJA
         jsdg==
X-Forwarded-Encrypted: i=1; AJvYcCUkT7TveILSs6X2Kc80I0JeM31Aqu9T6fHd3T5chrmdDYb8zV6PI64dW1GLms7BuFj0ihmTyVfcbWw7vWmkXPHXlfVxrqqd9pIjFQRgiZAquKRsJTA/L51fBdZdsvb7IzLb7EVe4H4=
X-Gm-Message-State: AOJu0Yw/hTiR9b9tP/XPhtoQeuN39h3N3koPBsic42I2vXhe8Xv69mNX
	GEvMGVczBzOcybflezS2umFZLqKTTzGVemsX9jGLc3iDbrWp8PUd
X-Google-Smtp-Source: AGHT+IHJxoYDbt/GRQMoYEySElVkA93VhG31vC0KyE90HUGlDvIOFzt8rR32jjiuMOEDMn+9XtxswA==
X-Received: by 2002:a17:902:cece:b0:1f7:3d44:1f1c with SMTP id d9443c01a7336-1f9aa3bc92emr67411895ad.5.1718906914716;
        Thu, 20 Jun 2024 11:08:34 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4d13esm140203695ad.287.2024.06.20.11.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 11:08:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 20 Jun 2024 08:08:33 -1000
From: Tejun Heo <tj@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, void@manifault.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] cpufreq_schedutil: Refactor sugov_cpu_is_busy()
Message-ID: <ZnRwIWgZuvPupJK-@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-2-tj@kernel.org>
 <CAJZ5v0i=0QqkvjA9mnqcX6Yv-T+rQ7ZKvuF1HPJL8pG2kqicGQ@mail.gmail.com>
 <ZnM3J7pvg6fyksby@slm.duckdns.org>
 <CAJZ5v0hSZSExp=h3=V9=41BkAX2d9nxjVd+ZhENETSJ-hg9Seg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hSZSExp=h3=V9=41BkAX2d9nxjVd+ZhENETSJ-hg9Seg@mail.gmail.com>

Hello, Rafael.

On Thu, Jun 20, 2024 at 07:57:47PM +0200, Rafael J. Wysocki wrote:
> Please feel free to pick up the $subject patch (with my ACK).

Will do. Thanks.

> As for the [2/2], I don't think I'm sufficiently familiar with the
> scx_* stuff to make any comments on it, either way.

Yeah, as long as the cpufreq part isn't objectionable to you, it's all good.

Thank you.

-- 
tejun

