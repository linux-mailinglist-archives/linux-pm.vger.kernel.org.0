Return-Path: <linux-pm+bounces-25697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3F0A935D5
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 12:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649DE8A23CA
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3926E270EA5;
	Fri, 18 Apr 2025 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHcTT8YH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E0211A0E
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970921; cv=none; b=bsEgNNSQn/cx52awkfwPmIyJXRiqTjYz2vQLv0EGnADt58i6bHDZQg3vj31iKTgjO22tqhJ4QIGyg1tvPEJBalkjQVlkDXsxExqj6J59tAHQASakbQ0512AGxtnHlLoNNZZt5/hfEo2XwHnIV/LMVTgAKJc0AaT/XowsQzLA218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970921; c=relaxed/simple;
	bh=+RdKaGSYUCfEJiJFPdvtZA8GDr+MXvsxZc3B1z2ldAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhQ6ihLqYlBb47r90yS5Hsa6DubsghiTJliy7qxkdypnHekHQKZpC1+WHAYuzmGgh+P6/H/rjP8x3ZIqfMFUE2iBFGxJGfktmTnlLrJLlilkvApNarZH96VecAuAz1P0Yxu0y9gS/pVvVmmI3JGNBdo90LadHYPtbQOHnEhZuaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MHcTT8YH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c266c1389so1193883f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744970917; x=1745575717; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S/qSOlMwG1tBEqwfJZ1I0Em2NJMBVmrSeT8vIpdwl2s=;
        b=MHcTT8YHqz0sPIsVXD3PjHYlZOJYmOSryhjogdewJJh/JRO/PPQEfABxDHFbvXi2z/
         TxSJ2GVuBkflbuZF7FZDkphpx7k0tlWQrr34twF3Bzt9HG497z2zFqaf/eOZGo/m2tS0
         c0kj+c29EqVoTgAgOATw0xgb+uwucPZrO7NX7qmOq1CbsphQQvlu+UsV0RTWJjt4UHoR
         dVaB5GbGhPT8xIBh5fe6PCHMaLVPW9MR6+hL+kLLib5xzbJVi0mISRG1w+/U/iri6xGI
         sKM0NXpXqyIOmScvXHoeLpfYRwL11ocwK8AuYrp14HpLc3L2ek5zTly0vsym/qAQkYqi
         jwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744970917; x=1745575717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/qSOlMwG1tBEqwfJZ1I0Em2NJMBVmrSeT8vIpdwl2s=;
        b=n3updY6sCRQJHserSNNqzmfYbaM5/iYjDuhux42ueNL+XapUz/Y3WH5SoV95oL36zl
         1BbF7xa5NFhWRBvPlFU81965j43X2Vr5yEh/xynI5apw8RYtyYgWNqkWvtFMcLx3imsk
         s2otkCt/lH5wfwl96qOD6qrdgsHV3uPkRzP5W50dJHfc6/YL+F/jRk3rMtj282dbWzBB
         tchPLd6SbjPVGk7Auci0EiLxFs1hhj6szArjS0Fk7VZHM0GLpZqNJQN3J2DS3onu4S3X
         6S1nh3FPhcmZ6CWuHPnCClMElV7kV+EZcvjDCtMc5cRL8p+NXIxF8SLzyCLuC7XBKJv2
         uIUg==
X-Forwarded-Encrypted: i=1; AJvYcCWHNXq3KDrFL2BmVSenzLfqa22G/gd4Q6Qg0aScI1W4vAmH5BTFsPf4BC27F08dFFAM+aLfF9gzLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQM17pnYEFZq7x5OLQnM62vdFaGRAJBPcnyPqmtkUhNL7UXF+
	SULsG3lZ3sXh1CzLS0I9UFDM8MNiJ8pT5fWLXtw1rDEaqZvxl60z/kHwDs1ls/k=
X-Gm-Gg: ASbGncsjWuFgg33fc8u9FWtYUJUV3zZGgTasI4JuzXtvr1TiZpFHtXH1wnZNV6aNU8F
	iA5eu70s2ZszWb6Fv+rUxFlqxwMWpjnrLQbBaMO1gRe0Sg5iO9Y85wNktnpx0z1jHZnaR1fZs9m
	Vtb38RilEqZUxg5rFopm+mE5u6eQGCh0A9LG4+ZSW1w6XKfRWOSXvR8s0oRhTtHqjapUSS75Nms
	xskrfLfXRPMPbg43+ghzOnTu4Pa0f4CBAZH42AnoNM/F7SZ4lZ5zWV6Rb0u/yTBs2DADBY1sHHB
	a4svu0LLylIn0g6U64MdGo4g17iSrQswpoVEIKFHPMgjwGG7U2UfXvEIP4hZLn5qA0/MlLSll0a
	nmP4=
X-Google-Smtp-Source: AGHT+IG1L3VfWz9J+obAaFerB2Z59MsSd2dFbffUprl7yAb1d+1L7oSTlRW/aqUm+C4DsUsSsv8Z1w==
X-Received: by 2002:a5d:6da1:0:b0:39e:e259:91fd with SMTP id ffacd0b85a97d-39efba3cbbbmr1721753f8f.17.1744970916627;
        Fri, 18 Apr 2025 03:08:36 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4207fcsm2342052f8f.19.2025.04.18.03.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:08:36 -0700 (PDT)
Date: Fri, 18 Apr 2025 12:08:34 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
Message-ID: <aAIkouhM_ePdhgJY@mai.linaro.org>
References: <20250311-vsprintf-pcn-v2-0-0af40fc7dee4@bootlin.com>
 <20250311-vsprintf-pcn-v2-2-0af40fc7dee4@bootlin.com>
 <Z9BKW_06nLAOzYfY@pathway.suse.cz>
 <20250407184647.3b72de47@booty>
 <Z_TRZSxwzfAZ9u6I@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_TRZSxwzfAZ9u6I@pathway.suse.cz>

On Tue, Apr 08, 2025 at 09:33:57AM +0200, Petr Mladek wrote:
> On Mon 2025-04-07 18:46:47, Luca Ceresoli wrote:
> > Hello Petr, Daniel,
> > 
> > On Tue, 11 Mar 2025 15:36:11 +0100
> > Petr Mladek <pmladek@suse.com> wrote:
> > 
> > > On Tue 2025-03-11 10:21:23, Luca Ceresoli wrote:
> > > > %pC and %pCn print the same string, and commit 900cca294425 ("lib/vsprintf:
> > > > add %pC{,n,r} format specifiers for clocks") introducing them does not
> > > > clarify any intended difference. It can be assumed %pC is a default for
> > > > %pCn as some other specifiers do, but not all are consistent with this
> > > > policy. Moreover there is now no other suffix other than 'n', which makes a
> > > > default not really useful.
> > > > 
> > > > All users in the kernel were using %pC except for one which has been
> > > > converted. So now remove %pCn and all the unnecessary extra code and
> > > > documentation.
> > > > 
> > > > Acked-by: Stephen Boyd <sboyd@kernel.org>
> > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>  
> > > 
> > > Makes sense. Looks and works well, so:
> > > 
> > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > > Tested-by: Petr Mladek <pmladek@suse.com>
> > > 
> > > Daniel, if I get it correctly, you have already taken the 1st patch.
> > > Would you mind to take also this patch using the same tree, please?
> > > Otherwise, we would need to coordinate pull requests in the upcoming
> > > merge window ;-)
> > 
> > I see none of these two patches in linux-next.
> 
> I see.
> 
> > Anything I should do? Resend? Or just wait a bit more?
> 
> Daniel,	Rafael, Zhang, Lukasz,
> 
> would you like to take both patches via the linux-pm.git thermal tree?
> Or should I take both patches via the printk tree?
> Both ways work for me.

I'll take care of them now

Thanks for the heads up

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

