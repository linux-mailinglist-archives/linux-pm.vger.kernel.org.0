Return-Path: <linux-pm+bounces-21293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CFCA2577A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 11:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01C03A821C
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFADE201256;
	Mon,  3 Feb 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDJ9aP9Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB97201028
	for <linux-pm@vger.kernel.org>; Mon,  3 Feb 2025 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580262; cv=none; b=MYBL/UUIuTml3qUC9K5hEWqtNU7x9lu2ua9ticBZuO0CCnrf4wpdQSl0ZtltAD/gvep1HGaWas+el5i0AFBmMR+gGjq3dIXLiM/e7lwtNBvfStFgSldVA4YS1IKPArgSNWVhM84hyZoWhs0eQH+80Bo8djnuonaDhznAZ0aXb7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580262; c=relaxed/simple;
	bh=RSm57b1dkEfJMPQ6LC6fNuCid7ssRIrM/WbGvIrovN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FA/GWTnq3qiGLBZuFR25iMzHx0HFIOndh4F6IkNJariiIYNM9yvs1FDhgKmTgxRl1bJLELldUqvF0/VNp0jnvV3FOpIvy9llWzoByhdPGAyi8biF4i7ixM6MM8qwO8duwWQqgiA1zLYG2WIpIuDstLonTSzdwhTJtDwjQrX1tbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TDJ9aP9Y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2164b662090so81628045ad.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Feb 2025 02:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738580260; x=1739185060; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T5wzLBJUEmaueHPGAWBI0Wr2N1tn0LQYWkY5tyBdPNM=;
        b=TDJ9aP9YocUsU+BEbFGfSIfD6hafCWhysYjp3Mk1ILqF06ioY93zeDVGtB5/IjpXLZ
         7SdrQEb4O9i56tfD1iu3NvKFSkI/tOzGBsIw2P1ebjli7G+KAHNrjOW0t+gPDgcjE4UY
         wX5PwFkEgo8sf8al049ozz2F8xMcrnoQIFLe4RMCIpe+11fqokWj2AAekI2yJHhu+M7b
         uuy9JT/o7vcxRIh8zfqejmfvKOtqkZ/IWMu9hxgXd0UnSKw47htftctJb25Zr8S1PPkt
         W9vtqtxCUTM79hkTwr7w7Fl1Dr6NeEixYJ0aif3NBndMdjv1YboAllTPsikOrr9mb/Gy
         Se7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738580260; x=1739185060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5wzLBJUEmaueHPGAWBI0Wr2N1tn0LQYWkY5tyBdPNM=;
        b=ZRFwXKSeLf28hrGGD/1DpLocd/0OLLBpjwR/q1GToqfJi0CpM5yZCI313NNv3I3GYJ
         siqXjblLXp5lQb4WUKYF7lLCbDvd6rZeYUZ7IC88EGl1sUDj7Q3t8jfcWG+Rh3pYygrA
         78m0rF8ojxSKMnmRT4OM+9qgdEcqlQfPe53205OOvxd0XXvm8RaJh0yDBQU7Mhl3gdoH
         YxqtfrrNCRiicWJJm4eBliLRXkOo/2aPZV7rr5idzYXhtuh/UceYMdDJTiVNFV/mDQDy
         YqIDGL91G14YvIHFwmdBCX2m5Pq6cnfVY1CLiS3LNCtv+ETxQXdKhp0pkUo5DttV9Drc
         uHGg==
X-Forwarded-Encrypted: i=1; AJvYcCVzCKDD3n9lnBS2joZ/Q2S1+ljpSUxlqAxKurphdsyn7xEYJ5KPFBhVoS559/Y5ddJedAcVmyow4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuacTTxoJFVNb4viHyHxHkew3/GNL631oCs2HTfhtQ1TQ2Gf4a
	jxzFMQMuhAquGjyvqG8e9H4H7cVmlQAOodpnCKXKRxTrpyL6eu8YrhYQbx4/bxE=
X-Gm-Gg: ASbGncsHjoK9QmAvJuDP1Kd7QtLtM9kllLxn6gNuhdUejCq4e28zkcP7M9dSn4inwx5
	RAoLhu0fJ3f6mNR4B00PnSM5t/UK4DPswY1R8Ihfkjik4X648Qjv//N6iabRAQqMUi7oXKmO9LE
	b3ZQmjUaXVOOIwuYXwk8CJc7ZfG0bwLIOxCznKJCC4ovGR4BRJFlWiEF7/Ru4S7KziP/JDYP+HT
	o5be3pmhdn0CFhNBL/02TCRpgLn56gfU/RYvqV9q0GtqFHEpvkBh1myRgF6DdEHmSMMX/kaI72L
	XgHHABpgQQDGk73nHA==
X-Google-Smtp-Source: AGHT+IGmjWIWKYEvHYasG0wmYEL/dNtj1S2N14U+kYyH1kl5FnrXzEkQXJKqSrqibFN1LCe+FoWnVg==
X-Received: by 2002:a05:6a00:2908:b0:726:64a5:5f67 with SMTP id d2e1a72fcca58-72fd0c03db4mr30024540b3a.12.1738580260474;
        Mon, 03 Feb 2025 02:57:40 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba3c1sm8370690b3a.108.2025.02.03.02.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 02:57:39 -0800 (PST)
Date: Mon, 3 Feb 2025 16:27:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc: bschnei@gmail.com, "Rafael J . Wysocki" <rafael@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Benjamin Schneider <ben@bens.haus>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Message-ID: <20250203105737.ilu6kldt4onzcygs@vireshk-i7>
References: <20241125211452.14987-1-ben@bens.haus>
 <20241212070712.txkxgmiugzji3doz@vireshk-i7>
 <fjdblv62k3nhqgy7decdldtieo4zyv6phxofx72dreyq7jbm4f@qmkp3e2wyplb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fjdblv62k3nhqgy7decdldtieo4zyv6phxofx72dreyq7jbm4f@qmkp3e2wyplb>

On 15-12-24, 22:23, Marek Behún wrote:
> On Thu, Dec 12, 2024 at 12:37:12PM +0530, Viresh Kumar wrote:
> > Marek,
> 
> ...
> 
> > Any inputs on this before I apply it ?
> 
> Viresh, let me try to test it this week on Turris Mox.

Hi Marek,

I am inclined to apply this unless you have an objection ..
Please let me know.

-- 
viresh

