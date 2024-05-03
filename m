Return-Path: <linux-pm+bounces-7469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0190E8BA750
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 09:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F001C20C83
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 07:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4132E1465A4;
	Fri,  3 May 2024 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqRaGi4j"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A401E491;
	Fri,  3 May 2024 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714719808; cv=none; b=oysx/Tj5yEfuoQqHMfzBa1AaE6OX1jfnUgOBiRACWEqV8Bjb0oqhcKEjcVQdrAozZRb7Idwf75SZS6iv+SDI6Arw3oWT3Xo7FGk/F8nrbX2sHKjFbSb+WBE9crpwf/lXUU5dGxQL1DPLZ/Mb/3PoCseqB3BPpBM2f70Ue8rK6ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714719808; c=relaxed/simple;
	bh=uw8g/pSgrfWfO0FiEhsyhGR4QN/3Mzn7J1v74hc0kRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsLqxGJWrln9SiB/LeE/BEJD1Q4FCr+K1OfKHLhe/yXgkCHnJIP3oWGqK2IejTYbfkjN3ZOBsmo8wDEw9X4jYm5mJ282xpRrKi5M0Sx4fuNCbbh7EUbkfLOyxQ/t8oXKMqvW+Ew2Nkd5Nt8q2zmYRSl882YEmABkmnKSdJDmnAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqRaGi4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D88C116B1;
	Fri,  3 May 2024 07:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714719807;
	bh=uw8g/pSgrfWfO0FiEhsyhGR4QN/3Mzn7J1v74hc0kRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqRaGi4jB2Tm2sAd5wvCrrKMhCOm90bkCMJ+4G7P+423toFlYyKt42Tf/BTr6USAL
	 PT9aa7UIAJPmeaGNjotuJyaiqiqT0A2GYcEpuY490hCnit/FY5N/TzsyjJMMpduzoV
	 Tqts3nnoMG2bV03W9bojJAdjsA6ytprau3pF1Pz2EymNvnAj0KtjhvGzlrAyaVOJkI
	 2V6CMoc7p++cWIF9H82guLN7hEZVbGfflpN8bCR48iYjz4PykTwOv7g+0XjJSFEnd4
	 Y4trNiUrDIFmvqQdKxMfgoMkGFRh6PdN2EXkwQP/OZKXsDaM8SBrfJZj2heMX3ktXb
	 beeLL0qMNxixw==
Date: Fri, 3 May 2024 08:03:22 +0100
From: Lee Jones <lee@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Kate Hsuan <hpa@redhat.com>, Sebastian Reichel <sre@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 3/7] leds: rgb: leds-ktd202x: Initialize mutex earlier
Message-ID: <20240503070322.GA1227636@google.com>
References: <20240502211425.8678-1-hdegoede@redhat.com>
 <20240502211425.8678-4-hdegoede@redhat.com>
 <CAHp75VdSHGXuvGtPBuQSeDLTg0FjPNStcgG3-p07cfVLi_D_YA@mail.gmail.com>
 <88d18069-3327-463e-afa6-b80645dfbb7f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88d18069-3327-463e-afa6-b80645dfbb7f@redhat.com>

On Fri, 03 May 2024, Hans de Goede wrote:

> Hi,
> 
> On 5/3/24 5:43 AM, Andy Shevchenko wrote:
> > On Fri, May 3, 2024 at 12:14 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> The mutex must be initialized before the LED class device is registered
> >> otherwise there is a race where it may get used before it is initialized:
> >>
> >>  DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> >>  WARNING: CPU: 2 PID: 2045 at kernel/locking/mutex.c:587 __mutex_lock
> >>  ...
> >>  RIP: 0010:__mutex_lock+0x7db/0xc10
> >>  ...
> >>  set_brightness_delayed_set_brightness.part.0+0x17/0x60
> >>  set_brightness_delayed+0xf1/0x100
> >>  process_one_work+0x222/0x5a0
> > 
> > ...
> > 
> >> +       mutex_init(&chip->mutex);
> > 
> > devm_mutex_init() ?
> 
> That is not in Torvald's tree yet.

Neither is this.  :)

Since we're nearly at -rc7, I think it's safe to say you have time.

-- 
Lee Jones [李琼斯]

