Return-Path: <linux-pm+bounces-16072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB1D9A62AC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 12:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3F51F20FFA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 10:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6219B1E0DD6;
	Mon, 21 Oct 2024 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNptukgO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB316F27E
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506133; cv=none; b=mPCHA7k/a0vhEG/BbVYW4lwXObC9Xffi8K8rieDoLfuww6wfZnQVTfDy3zKJW6pby0c8og3hn7vGSgXY9u232xpVFvkEvMT/7Ltvd9CMVoJ4fKhirGnuDo338/ac3q302fqT6ee5HGesSUTy+rz22XfMy9Hb/yKVJKdAd+3q1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506133; c=relaxed/simple;
	bh=gTVfNPeavimCT/2hNDwhq2yUdYm19lypfoFC9xXuUhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjUKeDS7Zk41Z06GXPNWWcR0eRSE/OVEMdXaZdjWpqDLP+0EnchCND2oCADIpyNraQ5Bu4o2k2MoJ55ChUuWSjcNQKbpQohgWg84k3IeBeqYGZWcOBLpDpWr0E7cJLMAewZRLKqE75vpm89LxDm6sqeMsTpXsF6Ow2KuQ72OUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MNptukgO; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so3203167a12.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 03:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729506130; x=1730110930; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VqL0Zr/V2sUvi+e2LKuo4WU/hmLYOWLz9kqp7zbleeM=;
        b=MNptukgOENaS++SCLosWtRKg5jmumMUZ+qeYXZP/ni+rCihuMjaRnQ3T4E/yLXj9CM
         aet9UWR/jOtdQQy+Pe6cRTeTDebS6CwZIxjkwiirSmaAI6OCGZcy/h8vWRCLAI/xsWqg
         J7fXJOo+Mq5JDyXmToruZHAUURWO0C68KtKdNBGQTfGjQZFbyn1faRtjQe0cxFYW3abU
         g4cHmxv0AWfBXCNj0arpICXOupAJGtSj9s852TN0VXDgq28Ysh8OAyFydHDtk+2HuK2D
         ZnKQUC/9JXQQFZORHGQ47E9w6drdwS4eJNB6O0TlyU78jYPIj+8VkZr3Lge6xHzEWZ/J
         cNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729506130; x=1730110930;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqL0Zr/V2sUvi+e2LKuo4WU/hmLYOWLz9kqp7zbleeM=;
        b=oUwK854v+Ve4mLm1ApkdphoB+sv29374S0JyZVsDO+uCDfqD0RZQNLrhtqgYF+QpfQ
         gTeLya6YJDgL9DQE4IX05caR3Xrn2jASInMyXpIFJkQwKqR16LWsIdE1H/+3BWsgU0uT
         hG8LO1gTwj8Vj1vztq4C8Z8BOTXJtoXN8zt/+3hph6pLOsBE7UvB9k3C/NPjFXXVipJ7
         sjnyqOIDpXDPkCcV1hpBVHHTTvZM2f6QSvfFI2qaupyz0uY4hzB1gOyPWIJFByHAnUxt
         s/jM6zchmCUIg6gXCr+NBWn5cgN/RvMMDKEK65QqshQr7MPqWcNEGArg+nIXCIFdDRY4
         FK6g==
X-Forwarded-Encrypted: i=1; AJvYcCWuaSjIpbgGAj8op3SQEGRVmXf6fL/x7XWsKwuhZrFkrYLBfwx/N1UD0mSR/YkN1umLi5cOJQ9x4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0PLGE7nC92uS8LMufWJmkEua5LQJfh04ubSibhcxjK5qex6r1
	u6CdO8hI28nlKfd/CIOjAaPjeCKmoaag1etQUNrTWAYnGe10sPafu+mD1AlPoDM=
X-Google-Smtp-Source: AGHT+IHRv4t5hH6w71gaNvVKPmb6cCvy2DOjB8YPqfWEqouztah3MRMDlQeE5jKBPAXoLZvFRaQ+lQ==
X-Received: by 2002:a05:6a20:e617:b0:1d4:e68c:2eb9 with SMTP id adf61e73a8af0-1d92c4df7b6mr13888822637.20.1729506130618;
        Mon, 21 Oct 2024 03:22:10 -0700 (PDT)
Received: from localhost ([122.172.85.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1408b01sm2512659b3a.216.2024.10.21.03.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:22:10 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:52:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Switch back to struct platform_driver::remove()
Message-ID: <20241021102207.ujbprtc3gecxlyu3@vireshk-i7>
References: <20241020153910.324096-2-u.kleine-koenig@baylibre.com>
 <CAJZ5v0jAMr=bmZ5PexVTS0SqrXP4EytZ+RH5X8p1Nep2wMg-kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jAMr=bmZ5PexVTS0SqrXP4EytZ+RH5X8p1Nep2wMg-kQ@mail.gmail.com>

On 21-10-24, 12:20, Rafael J. Wysocki wrote:
> On Sun, Oct 20, 2024 at 5:39 PM Uwe Kleine-König
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> > return void") .remove() is (again) the right callback to implement for
> > platform drivers.
> >
> > Convert all platform drivers below drivers/cpufreq to use .remove(),
> > with the eventual goal to drop struct platform_driver::remove_new(). As
> > .remove() and .remove_new() have the same prototypes, conversion is done
> > by just changing the structure member name in the driver initializer.
> >
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> > ---
> > Hello,
> >
> > given the simplicity of the individual changes I do this all in a single
> > patch. I you don't agree, please tell and I will happily split it.
> >
> > It's based on Friday's next. Feel free to drop changes that result in
> > a conflict when you come around to apply this. I'll care for the fallout
> > at a later time then. (Having said that, if you use b4 am -3 and git am
> > -3, there should be hardly any conflict.)
> >
> > Note I didn't Cc: all the individual driver maintainers to not trigger
> > sending limits and spam filters.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
 
> Viresh,
> 
> I'll pick this up unless you'd prefer to apply it, so please let me know.

-- 
viresh

