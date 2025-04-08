Return-Path: <linux-pm+bounces-24926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F84BA7F66A
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 09:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2540B1720A8
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 07:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E8F263F21;
	Tue,  8 Apr 2025 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cIUXVNy5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9796121ABB3
	for <linux-pm@vger.kernel.org>; Tue,  8 Apr 2025 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097644; cv=none; b=sJ6evrh8cXaD0SO6S8i3GYvllVbs5eHhMrhtxs3dStkFl8eKvCgZebZKugPLFaD4b95ZZUsve6E1rbdtBBXGT5RiUQLj6pWm9bmmTqbE0vt47XC3VLb8xiMI/y96MVtJWkLh0QQjOz49PBvWzvTs5X7UccJyjiWW0XsDeIcLQPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097644; c=relaxed/simple;
	bh=+jZrueS3bdTwyiNJBuV89/uZubp/GRCAmixpmEl+VtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJzxiOCaaOOOZwr4otgtqsV+H489k1HEdTWfQRSLSiCselIlANZ9PWV2MeF82POwBRd9EnwLLLqtWlkZ6VPvtRFR6XVXID50T9Yqx6PsTbByTP0Y+YywmrbzuNlSwPZhcJ9x7YLQDoa/j3c29p3Y2rj4Y062vnXh8ePWxSWe1+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cIUXVNy5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so40836875e9.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Apr 2025 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744097640; x=1744702440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IlfwFDH+X8G+NwPj7Vy2IIvOezxV6eu9OtIzRCGvuLs=;
        b=cIUXVNy5frg2xXz55t926pqT3udjeQXh7/c91WAtXAzDnROI/Zz9izM0fes3emg02O
         HQDamcjzmQBqOEXhfaO3xJ7rh7uIxdND/0/9Ki8Jre9ZWmM1G2/d2ZBhM3csh4MLVdOd
         9J71nD6XexKEnPRm2yXJaK3rALstuhKoMnO5Hl8ToFiOfiMmg0QFowKUVEpWMTDbX33T
         4U6RQvX3grvvMcjMlzp7tfU2anpsWI32rmKoLZEqzuMv9aavt1DyB290yxryFN53FIi3
         ZIZHh3gD+QYJsDZc2EcqRDr211M0i5JLNKRZm58PKzlF5TKTEsHaq0kWIlkbv5U9l0Q9
         09bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744097640; x=1744702440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlfwFDH+X8G+NwPj7Vy2IIvOezxV6eu9OtIzRCGvuLs=;
        b=IBOq3yJGnIaDTLO1ZjTIQIq4BI+s6Pn7WEPq7se532LHc8O2Eh0cfg/74WTo2lnxSF
         TPz7QgTVsl6jK1sCox775vdf7UUd8BT50ZgiQkvrz2Ik717FTSZHYV1w5I/3lEc99IrG
         26ORkcepPc2YH0QJHiQ1oOZGjI6Dx8AAyW/mPKxU9j7d3yXzLpr21vlgbr4YOMR7DZvb
         IL5VfJfIwYmt35RPJ/8d4R9boEryeiDnWavd7UI8D1+VcnevDAupPiXmSovW3KLusAxm
         JT4FuswfuDRdc/B6pL4L1xvakdIyHgCc4WefJg/ZIVojAmpWI9aIP0vwbpqXlkNCoX98
         Kbdg==
X-Forwarded-Encrypted: i=1; AJvYcCVaK8c+IImTtsL3OpjAw95xWIdCNBVO/mZS8ddh7GzhxqDaA3tZTcREXgqgmj1t0fXsBZAWkp7ZLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO19GPfjTdsNG2IPS4id0XzrIMkEDPVPjTB5kW9bYMO/M6mVOM
	MTZkGSIX2elefMeVUWJLK/CmiXd2rVxVQV/jRdtGi6owBqk3U74qMWH3/lo3JFI=
X-Gm-Gg: ASbGncutH5mgF5U9q472B+svp4GyyhxBcNjQHwD2rqpWsHZBl6MVpxgsjOLobiI8gT/
	XSR2OPqoeI17MbMea2/jOgrlAwxK7Sm7k1iCLax8fb4MQRXV2cvRhdRtzEA7+WFjpHZwImvmBqB
	wok4QKPSzSxy0lJUkQzY43bE54vJHly4dTvollzBvn459k2BUodhXFuEoL5oEUd371fsDzvMQ70
	8H4iY6ahwV6M4ZyWBTzsbY1CHYj3JbRPd13RpBtvT7OYyhRB2rTUMGDJJxuYcGilFmFX3ReyjfE
	GmXu36iIGB6mCKF9sbMWPffm2QNhODofiJbzmo41ss85OJo=
X-Google-Smtp-Source: AGHT+IH/VksFsEyoBKI9nFdRHY5jYoHhuOC/STuFedynMg/f/yUaVw5RUYHsEjKD7l2EEe/Jqd89dA==
X-Received: by 2002:a05:6000:4616:b0:39b:f44b:e176 with SMTP id ffacd0b85a97d-39d821116bemr1896403f8f.24.1744097639781;
        Tue, 08 Apr 2025 00:33:59 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a8952sm151781455e9.10.2025.04.08.00.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 00:33:59 -0700 (PDT)
Date: Tue, 8 Apr 2025 09:33:57 +0200
From: Petr Mladek <pmladek@suse.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Liu Ying <victor.liu@nxp.com>, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vsprintf: remove redundant and unused %pCn format
 specifier
Message-ID: <Z_TRZSxwzfAZ9u6I@pathway.suse.cz>
References: <20250311-vsprintf-pcn-v2-0-0af40fc7dee4@bootlin.com>
 <20250311-vsprintf-pcn-v2-2-0af40fc7dee4@bootlin.com>
 <Z9BKW_06nLAOzYfY@pathway.suse.cz>
 <20250407184647.3b72de47@booty>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407184647.3b72de47@booty>

On Mon 2025-04-07 18:46:47, Luca Ceresoli wrote:
> Hello Petr, Daniel,
> 
> On Tue, 11 Mar 2025 15:36:11 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Tue 2025-03-11 10:21:23, Luca Ceresoli wrote:
> > > %pC and %pCn print the same string, and commit 900cca294425 ("lib/vsprintf:
> > > add %pC{,n,r} format specifiers for clocks") introducing them does not
> > > clarify any intended difference. It can be assumed %pC is a default for
> > > %pCn as some other specifiers do, but not all are consistent with this
> > > policy. Moreover there is now no other suffix other than 'n', which makes a
> > > default not really useful.
> > > 
> > > All users in the kernel were using %pC except for one which has been
> > > converted. So now remove %pCn and all the unnecessary extra code and
> > > documentation.
> > > 
> > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>  
> > 
> > Makes sense. Looks and works well, so:
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > Tested-by: Petr Mladek <pmladek@suse.com>
> > 
> > Daniel, if I get it correctly, you have already taken the 1st patch.
> > Would you mind to take also this patch using the same tree, please?
> > Otherwise, we would need to coordinate pull requests in the upcoming
> > merge window ;-)
> 
> I see none of these two patches in linux-next.

I see.

> Anything I should do? Resend? Or just wait a bit more?

Daniel,	Rafael, Zhang, Lukasz,

would you like to take both patches via the linux-pm.git thermal tree?
Or should I take both patches via the printk tree?
Both ways work for me.

Best Regards,
Petr

