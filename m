Return-Path: <linux-pm+bounces-12066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DB894E5E9
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 06:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638AC1F221EF
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 04:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B4014A4E0;
	Mon, 12 Aug 2024 04:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loQXyudo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8471DFFD
	for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2024 04:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723438485; cv=none; b=qGifWlYSGm+ijqbEcyWA9d9j7SJi9X1dMINHt0YZk46itUq8JDC+EvMcODfeWey+uVzKdPU9tCaTHw4Os4KVGDCCy8zdFHXZsXHLo5hfIEO4KC6tgVnfgbUAi/hn8rgpKyi+L6ha8c3Z4+3gKYFzn7jaVSmPxOE8fxL9ynWODPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723438485; c=relaxed/simple;
	bh=/7JNJRSA6Qai8rSOw/cLVCEzVurU5rT/F+Aq6+y0Oe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlDl52FP33maFwoLDxjmnZTTSxR/LC0PPafsFS892oTRdwuYShkpI2YB2l9WSZjEOmMHE4vNVChn3hgIGKAPYapZkzL3SD147najBKqJz6h/0GpThF/YgxG2poP1vTIagPJzZ6i3aqeJje+fgYvdJdpD+tq8+F/Mj3OzItNkP20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=loQXyudo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c3e0a3c444so698334a12.1
        for <linux-pm@vger.kernel.org>; Sun, 11 Aug 2024 21:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723438483; x=1724043283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mM8hIk0Il1OoNYTiO69SEs09clvslubSlLyTOMarmXI=;
        b=loQXyudoUtfD1nXJou73uJficJgn8I8omRJAndOy6PwHV+dtrNDKPbGsRecVxB3idJ
         nlmdfD0xIQPlfYvwaoKprJmBITljBAR24FCZZ9boyQV2v0kT1H6SwD59HstOyIeFwO4D
         Zzv3kTRx/bervfrv6DyTzS2oO3aGLIJla4o+kNLn8yhYw/ZoQWSY0Jhx4QCrPWORlrOP
         7+fC6WSaMXl0BQbDsRn4O2BOE/FcV2l/fDQFmv8jIFhj4nNM08lnZrkyalTrUx+0To8I
         c+s+1EoW4rYbVzcW8ShzDNQ5k4lL+K1pIskPsT6fJhsaKX9wJYmQEJEcLCzHNqydJhjl
         Qtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723438483; x=1724043283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mM8hIk0Il1OoNYTiO69SEs09clvslubSlLyTOMarmXI=;
        b=qIuuGxfTG3WLsj+PpDDMiR+44AHsAGcVc3M1uZWvyvxyoGlqdIijBz3VIyYTok6ylS
         /ok6NDjnkLyScuSLsiGPTKEqYSwBzdW/kIXz47ch1yMJcFJ2fa1hZVq50xgKqMDzCnoR
         qsZ+l2XXzA7x8YNqcYRRp0RdrS1r7SsTuGvYBWCAa3wCM6//jP7dZrVaX+tEvw3De5h+
         n4IRNYhd2KEifiIhgIrhzSkOKiiMwHdQkTnFMjhOARK47mrvFPnfYeF3x7olGOzUXfEd
         SFcdSLxod6Z8kyIC7lSAKAISStJI/8GKYyDNh1kXpPwM8VevPlqvoUE4BN9J2EtBML5L
         cIqA==
X-Forwarded-Encrypted: i=1; AJvYcCUir1Ex4SV+tA1+jFkDCMooG+QxjOhoYR+XZymJu+kE1T60r4MwEvhvri9SRuxQhy3YnLl+zZ76EllsIgqcdOCESUscTRjSZFI=
X-Gm-Message-State: AOJu0YxaJ4h3qyaWUr3Zw+8C9ubHTEv62nPco0RuFgVWOZV2IDzWQ3jF
	HmVJ5h7ldUMHRUWV4Dvj7f8cj/4tQunC7BdmiPLWBtJTdqVKjcqzVw2BxDm16lQ=
X-Google-Smtp-Source: AGHT+IG9Hm7mz2IYGlrpM4SuzTL62Qbzr6jN0CUn18M/7AjFxPVmd28eUBvkwj+lz/oTj1+27nZaOg==
X-Received: by 2002:a17:902:e845:b0:1f9:e2c0:d962 with SMTP id d9443c01a7336-20096baa066mr174277115ad.31.1723438482987;
        Sun, 11 Aug 2024 21:54:42 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9fd0dfsm29338335ad.202.2024.08.11.21.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 21:54:41 -0700 (PDT)
Date: Mon, 12 Aug 2024 10:24:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ilia Lin <ilia.lin@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel test robot <lkp@intel.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Fix warning on unused of_device_id tables for
 !CONFIG_OF
Message-ID: <20240812045439.tbdsbdwcxntoafdh@vireshk-i7>
References: <20240809172439.908092-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809172439.908092-1-robh@kernel.org>

On 09-08-24, 11:24, Rob Herring (Arm) wrote:
> !CONFIG_OF builds cause warnings on unused of_device_id tables. This is
> due to of_match_node() being a macro rather than static inline function.
> Add a __maybe_unused annotation to the of_device_id tables.
> 
> Fixes: c7582ec85342 ("cpufreq: Drop CONFIG_ARM and CONFIG_ARM64 dependency on Arm drivers")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408090714.wcrqU6Pk-lkp@intel.com/
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Note that 0-day only reported 1 warning, but x86 W=1 build gave me these
> 4.

Applied. Thanks.

-- 
viresh

