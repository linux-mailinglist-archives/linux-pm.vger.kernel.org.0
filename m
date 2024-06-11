Return-Path: <linux-pm+bounces-8903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3CA903128
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 07:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77ACDB25107
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 05:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F18171653;
	Tue, 11 Jun 2024 05:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xthhKOTJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55A7171079
	for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2024 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083706; cv=none; b=LZBv2WB8fvhLPWNRD/c5w8KHx2sKxPGu541w389aQ2KKHwClk14p/LE2Nw0qdrcfHWAWq36Ehpga634BLVdhuU0Y0EdoR71GK0HfbRYkULV+G3vORorFPKGJ7/Uvu7DAjmUfA2ca+2+g+PkdXL/IoACI6SzIgVSlXY/HeuMMKGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083706; c=relaxed/simple;
	bh=fzzc4a0DkDZ++C6R6CbvYeBpAZ2JN/F4aJ4Q2fbckzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sswR2Q4oLs1w/0fJYyRFBrLFD2EltXuq+E869zv3mqwqBjm1vnhDoy3F1Lqxma3gn8qCNGXsQ0ZyfURfHxDbcc9gsY/C9xxU1p/eGtqSXd3X1jVn6eM5ArIEX4S5UtDU5pkO/owDSRRKrWYrp9bgx/PPouqYT5vV90cCifZWofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xthhKOTJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f6a045d476so621725b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 22:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718083703; x=1718688503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ET389+UsQicSdzgw907HZAI0unQUJK7qvcjpNI2Srro=;
        b=xthhKOTJT9DMob+wWExahzjmugZS1M0ey/hP69BcKsohfluMexz9yjqsJvtv5qBHvK
         wEhC0aZDySjAqgiV/qC1d3ZtRxEIYP7tVOfEOZHdSa0qnhSCZd688vxBMN/A2NQk1eoO
         qzhcfTI/jU3Eun7hLwnF2aAfhF3Eccg41A80/csDQ1CLVil9p2UV12UuD5TSpuS1voDT
         oBym1Qv/AvZ/TOo9C8x3kCDRJg9Hg5Zf8bvRpY+3zLRVZqBk1WIovRqi1FwZ4eAZkUDs
         KHBN+0Pj+xohlhpUDeAOV5e4ubAdn05bHlkcFBPZoY6wQ0LTVvDtmDFRKLwq46OjECaB
         Rlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718083703; x=1718688503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ET389+UsQicSdzgw907HZAI0unQUJK7qvcjpNI2Srro=;
        b=HEJwtjAmhrkj/MT62eW7z+8uNwnHbCKIffk8a8VvJTDoGv/5W5E8shutqafhQeQoix
         FiWa5DpkGV7tpTnWsgwgfAEJiP9aGdSRTEz9Tw7ogQz9AcAShMAbKzOpEWwT86X6qY2d
         sqQ7sdpe6p1puAR6SZFXABSxIYRp0yKFxe0Xa4LK0q5sTDfIxGBEyX9y0wROG5Fv/4z+
         WsGrTTAFlTRLKm8ZR0jRhH/i1hxs/h/icsOdL/1QPi80Joki5tOKHHIjBkps3Bht2Rir
         /jpLYm90uvrIhH+rBkRehMiS0/acvTKWtdb583jEzg8GdvyqG0naOKR9puo6u2WLp+jf
         4VQg==
X-Forwarded-Encrypted: i=1; AJvYcCVzrh1EMlGbKTYNoG1AJCAy6slAHMVlVLbCbVryWLtAhJdzF8dCzmnX2oh9bURS3EVkM+j2JXRtUF8dvfGxcFtQeMx8CH2Tqr4=
X-Gm-Message-State: AOJu0Yz9iVr16isPImFXB5k6oj51GhheV9oKU9tcaasSmGtJNOumkYY3
	zrAkXzlKGMCZEVM3BGBYIYL/3gbzlbNf8SKzEiQyhABUQbXGErdJ4QrHL93A/wstvnYGr1m3XlC
	R
X-Google-Smtp-Source: AGHT+IGslTY/MyTNkwyuNBJxnlo/Ryv8vu5GPAcF1G65MjaD9DB6hguFFliFiR+QJg5FnTot23/BVg==
X-Received: by 2002:a05:6a20:3d8f:b0:1b0:3190:96d6 with SMTP id adf61e73a8af0-1b2f9a61073mr11385614637.34.1718083703368;
        Mon, 10 Jun 2024 22:28:23 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f96f18e8sm48765795ad.230.2024.06.10.22.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 22:28:22 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:58:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH 2/2] OPP: ti: Use devm_pm_opp_set_config_regulators
Message-ID: <20240611052820.tp3xoto5fbd7figr@vireshk-i7>
References: <20240606113334.396693-1-primoz.fiser@norik.com>
 <20240606113334.396693-2-primoz.fiser@norik.com>
 <20240610042250.xccda2pr277v6asf@vireshk-i7>
 <00ec4120-19ca-4b20-85d0-754c05bdc669@norik.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ec4120-19ca-4b20-85d0-754c05bdc669@norik.com>

On 10-06-24, 13:39, Primoz Fiser wrote:
> I didn't because of:
> 
> config ARM_TI_CPUFREQ
> 
>         bool "Texas Instruments CPUFreq support"
> 
> 
> is a built-in driver.

This driver has confused me so many times.. The driver looks like a module,
since it declares all module properties but is builtin only :(

> Anyway, I guess one could trigger this also with:
> 
> $ cd /sys/devices/platform/ocp/4a003b20.opp-supply/driver
> $ echo 4a003b20.opp-supply > unbind
> $ echo 4a003b20.opp-supply > bind

> -sh: echo: write error: Device or resource busy
> 
> so the error comes from drivers/opp/core.c block:
> 
> 	/* This should be called before OPPs are initialized */
> 	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
> 		ret = -EBUSY;
> 		goto err;
> 	}

This is a different issue, which is unrelated to what we are discussing here. It
happens as the driver has registered the cpufreq device from init() callback
instead of probe() and remove() doesn't undo that.
 
> > The only way to get this solved is probably by introducing a remove()
> > method, which clears the OPP config and stores the token returned by
> > dev_pm_opp_set_config_regulators().

I will apply the V1 patch itself now. That is probably the best we can do for
now.

-- 
viresh

