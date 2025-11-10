Return-Path: <linux-pm+bounces-37712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DCCC46106
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 11:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E173B7DC1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F214305979;
	Mon, 10 Nov 2025 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cU5KlekL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75328B415
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771898; cv=none; b=pFsiQj0NZlq0jT6fIfO0f+xhxmNjnxcO8emayPtsXRCbJLc+WKkrdQj3PeFklc5RGHqJDLyxLNnSrUumSl76YK69sL0tbxeOftJpdROFkLzriQdx1a+KE1PxAkf7uQWs5c4gZexdIpOdpm5131sD0F/FjhcSfNaEbzoS0gQlBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771898; c=relaxed/simple;
	bh=sV8cROs3dFOC6pjCX5PL2NJwZ3NP1xrJN8UDmNflI8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV8rwhc1uVtHvolNSz3T793FPypWNfwq1cq0kmti/byaY7N+AjYObg7ULtuHPe//Nh8KbiLr08xh2jkq51dJa1Yrtk0FzVoQYH31SDMNtyigyrEmZkX0IrJYImUSWlYfVRZDB4hieKbL9toa1+uWvaiEGO0OgQ6AVkCKNvAW08I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cU5KlekL; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-594330147efso2723960e87.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 02:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762771894; x=1763376694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3nSyx7sHEHeDeu7LgYEFiB0vbj1RV28VjEOVhrx7z8=;
        b=cU5KlekLQWeHbHVY5EazKftYRjhWKrax0JxwTsgySCGeAjJnnfy/a9EDXZme86RWsS
         DDZSMcONgBLMOrSk2U9bPqKfsUxULIKY+2LTpcelxaYuOYHr8kpoXHs4qyV3gojqeEwj
         /k25nHseOfm1yYPEXJBPDob4WwxgnCPPP0HxHLWzNJYBnoNuc9ckeK/xmVQ0/TdmDU97
         kRssIahkUIZvJCxGPBKnKL75NX2qKZ8eNGVnS5gEsCOO3OmBPOdkqId5y2TAYOSyAgDD
         QMjShlVhlC4apb+5wSMejViUdiIcBG8s4khdjOrPExKQdAAubQdeXKz0S4t5x7v5vJED
         EF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762771894; x=1763376694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W3nSyx7sHEHeDeu7LgYEFiB0vbj1RV28VjEOVhrx7z8=;
        b=qsfgYSr5uemMKitpaP2/MMRS8OAXQVhWP56iW3ET7ACAQwNsx4KGL2LiScurnQ8JFu
         GS2RuU7sxJ/yKeV5ttb/f7t+CXw57A7B6GvSEMNSpmhxI50/9ErpSuRnvnQnYGk2dDnj
         yMV4TYUBcOdEL+f4LMaAAgJJkrtrJg/W3kYL0dgY7VLH7Tjz2aXxE0SlSlXqRAcMrkGt
         HswWiTqQMr/YceIY44vDfwsboopiTHh7RYpd8wtriclRIxlppO9W9NFD2AFhr9t6/oVN
         19kJrU2pWTALW7lPhaY4pDyoJZk5gqlwmFQl2p8AwkWyouw84wk/5NYEAqx++glwEA/U
         1QBA==
X-Forwarded-Encrypted: i=1; AJvYcCVxK+CjxpC5juAwyc5spMTkiTPTCLHxBlS3eCXD0EPGcnCSEifITDOb4ABt5/8H08KnYvoTlS5Log==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvqtVU4giZ/JqgZKtGOudfrj4tzrOWk8QLS+RobxbqIWWDN4xq
	IGOU0xgRQRjT63cv0led+JQ/sKk+ozDBrOcFWsc7H8BRu+kHxjMnHqdEVtnx8DO8J3YrbBTG8SA
	aqR9W7GcJiLjvRcIW1iHcOHbDAda2OyKINorXXjuUqw==
X-Gm-Gg: ASbGnctTVWe9+VHFGhngoIzKZhtDhgkEitPyBPht3HivCLlnbUgfc0Ck0w4YODTeo5n
	NpiC8hiaGEj73cHbjTYArrSG7i9j4Mm81W5J9kF/K5ajS1+DogwtCT6yRZBsW06pEXjoFioMIeQ
	Uzlm+RmXbEJ6E4GkKpFTRxK7lcSjGGwscvmIWpgZm+MNw0md50VrJ0KRdwq0g/wKJlF7js1l2ne
	g0dVFVe+D+7tjPMTDjWKyydEiYN3CvQxGxF9lKcqrXrPDGMrXaip4y7/aCCPEdEFbzJAHkm5mMd
	FaLteyKX29gzQGI3uqyW9f+vD/b7
X-Google-Smtp-Source: AGHT+IHVTxNZg9Iea46RFVb+GORMLRps5peJQgiMFx4r9xzzIy/O3W2vJG4Z14WApk/wO+ZVzi5LspbnzJr6l7WI5dI=
X-Received: by 2002:a05:6512:108d:b0:578:f613:ed9c with SMTP id
 2adb3069b0e04-5945f1cb2f9mr1931017e87.43.1762771894136; Mon, 10 Nov 2025
 02:51:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106163341.336989-1-marco.crivellari@suse.com> <atnzuecdwp77svypw76e5z5occyh4tkswfc7rg4yqh4joeh7fn@ayygwyjdpe7x>
In-Reply-To: <atnzuecdwp77svypw76e5z5occyh4tkswfc7rg4yqh4joeh7fn@ayygwyjdpe7x>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 10 Nov 2025 11:51:23 +0100
X-Gm-Features: AWmQ_bkcdXSQHUYUpXYWbrqofEomSBTPQr7krtEx6F2AVUGd0pGtyz4_3n0RhQg
Message-ID: <CAAofZF4gSgeY7_qkHG4n375eqHhpkoZTmJu9=p2_k=qwUR3vEg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: add WQ_PERCPU to alloc_workqueue users
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 11:49=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
> [...]
> Updated subject to:
>
>     cpufreq: tegra194: add WQ_PERCPU to alloc_workqueue users
>
> Applied. Thanks.

Many thanks, Viresh!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

