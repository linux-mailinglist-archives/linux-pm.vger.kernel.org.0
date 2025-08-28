Return-Path: <linux-pm+bounces-33253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7099B39B62
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 13:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6C51C814BA
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B75244691;
	Thu, 28 Aug 2025 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZL23K32e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA430BBA6;
	Thu, 28 Aug 2025 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380056; cv=none; b=Sme2/D6dpLLw/+LFGdpHShhexBZ/BLTb0lLLQRrLb7a5fs6Qb8sv4HWv9TMa1EmAKFGYYT6QTO8rH8w+taifMFTyIyO36dkJW8ywiEeqQnsWdpIS6roq6MOM/Mp1LYdYw2H8Uc9JDcDKDReJ8TACO82jAew+TJU6WsIe+F5aWRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380056; c=relaxed/simple;
	bh=ZUW7QYQP+ERoh6dA5jhnuepdaTDm7o1u7hd3BaBN9CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSrfuzCBrD1t+tuyJTxGdHX38UWYdxgSfjtvdGRo2Wr1ImRKYjrZs12SIK2+RxdDzs9+hqNseZI1b8fJCLJrwroZVPufCozuc2mQFiIVK6YAeXH7lM7ljq7TTAOzNdsFRwF+PRHZiNXPQO6EWjR8LrRyzJnK1KNh6ozdaU6LEQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZL23K32e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C550C4CEF5;
	Thu, 28 Aug 2025 11:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756380056;
	bh=ZUW7QYQP+ERoh6dA5jhnuepdaTDm7o1u7hd3BaBN9CU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZL23K32eY1T+1kvBn91FT9am02RErtAJf3HV5FYxSudjqMts0ac0mpnVWWf5GEi3i
	 13IRKcDuQ0CyIxMPgAG09MUwAabB/OBT7iphVIgWvem0g0Yfw+Yf17PQJ1forciQqB
	 O2X3gKe2L7U+g3wrlKdDR1m4x0d7oq2q7TNepG+17HwDqlwqXj+26FSqZXYqhBEhzI
	 KbNEE8CnFO/dHUbmgcXXtHcTh0MdiWpBzf3Rc+Is+hNGviht9rUbiCJrZ6ahCfCXb7
	 WPgG2yXPNcZ2y/reXqPT6vcZysBco7y97Fn5U1KIyjlhfOc5sj2lP3jahv4KrRc+d8
	 ynUbz3oEvlNMA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-314f332e064so317850fac.2;
        Thu, 28 Aug 2025 04:20:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUU9u8L0SEmHnIOsGoikBiupvyO05Ve8oFMs3TQAYvdhCKWNv1NNJziWQiXYhFfngKqsXd5fr271KNKL2M=@vger.kernel.org, AJvYcCV2/219HrGHkE48fXHKtBnIeePDpkM1khixe5yL2qepmcDl/nIJDUnVGjAGZ1WSAXEj/t6zTXggXjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy07Qg4bH+FEgDc+eKCcESd10QnwVd/O48vKYs6aHP1teV4hJPa
	s5ZAgWtJGd4J+rpde0bHL9HF+F+CPlVEHvDt9owXDwy7WI0FOZrC+XWHGwVsw+pz34qIFFL1HeT
	AZV39ZpGHokaXIK77d9lskx7QGYlTH3o=
X-Google-Smtp-Source: AGHT+IEb1PP9Rx4YJQiIUc7JaiFoEhoGiEkGEZmEmj7Bk6LhY8xA17bF9tx12sPzOvhpnF7R+EQgSqiA/l++fOeYC6w=
X-Received: by 2002:a05:6870:6281:b0:314:b6a6:6876 with SMTP id
 586e51a60fabf-314dce268f9mr10908649fac.44.1756380055777; Thu, 28 Aug 2025
 04:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12749467.O9o76ZdvQC@rafael.j.wysocki> <2025082851-progress-unsliced-ade4@gregkh>
In-Reply-To: <2025082851-progress-unsliced-ade4@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Aug 2025 13:20:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hn9NXvHPy6zV4R4y0AHtN2BfN41wjd5s7dos0wx6ih0Q@mail.gmail.com>
X-Gm-Features: Ac12FXz_eg4sN5AP9MTyIR37oLK_D5zAvmuatZC4G2w_uOQZc_vUWawLI_FidXQ
Message-ID: <CAJZ5v0hn9NXvHPy6zV4R4y0AHtN2BfN41wjd5s7dos0wx6ih0Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] driver core/PM: Two updates related to power.no_pm
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 1:07=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 28, 2025 at 12:55:50PM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > Applying this series will cause power.no_pm to be set for faux devices =
(so they
> > don't get processed unnecessarily during system-wide suspend/resume tra=
nsitions)
> > and power.no_callbacks to be set along with power.no_pm (for consistenc=
y).
>
> Oh, nice!  I forgot about that entirely.  Should these be backported to
> older kernels as well?

Doing it shouldn't hurt.

Cheers, Rafael

