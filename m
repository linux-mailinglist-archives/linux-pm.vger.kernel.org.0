Return-Path: <linux-pm+bounces-37242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C42BBC27D04
	for <lists+linux-pm@lfdr.de>; Sat, 01 Nov 2025 12:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CA6189B27C
	for <lists+linux-pm@lfdr.de>; Sat,  1 Nov 2025 11:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0222F2612;
	Sat,  1 Nov 2025 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwLj3MaS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F7285C8D
	for <linux-pm@vger.kernel.org>; Sat,  1 Nov 2025 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761997817; cv=none; b=s9v/9KMuSUVQnD4qVlo5sXYbqYuzNEvuGHbiO7EVJm80BTpDNsdkqais7ljL8c56hWtSs2Dh0DPpNRAtGX6nx2yHzXiz/buUFRFciceOIx900bTFaod07rIoN1ifCj08Le5s7rKc6f45Pdnk89eChNpLGiBmroPJfk5NzhASBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761997817; c=relaxed/simple;
	bh=HaqqRDPrZWoyjq8JRavr3wToxJeyCzQAvF+S4eMFlcE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+VJ3AFChAJ4ZRGUcjGHdD5VcS5Y2OvmFl48wfxYrSyyu6AW8IMm5d6pnNIOnGU1b/s4RP5fwUgNQyhMnq6QHD42IwQ6zfesDEHvFpj40M1mmzabLy4Z81ZW29PfkonBG/0dXU/myTxbndemnuJ352DwERAezUPsyIkbLTzuHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwLj3MaS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429c7869704so480150f8f.2
        for <linux-pm@vger.kernel.org>; Sat, 01 Nov 2025 04:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761997814; x=1762602614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sZ1LVmNuWNRShkFgZkqHZfQpdnjfb66+76NdCRKKg0Y=;
        b=jwLj3MaSe/N73KvxVxRodKnwYBgcC4UwTUhEZTtatCwzGKIbt9GzBn/wuUsKoU2dpG
         NhUfFyMUIRTEdX9SKWE5qeGIzfmQzmeqrb5mjlkc3uBoAidT1+nCsJ/mIOwSbKGYYMZU
         OHb5TU6lUrp7ljRx5lJBu9c+oaxYbFIzdyI1OAGFKOe6crzCL89HKMBlnSnly6zO02Wa
         Qa7fDI4s6JXqmfwLhTcq5RPLHPwNW2iq9YyBpAYF7v9sT/YjSymxrS16rT2X6HdQ25zh
         FmQ5OR3cSlMGPGLJkdYooNAu8a5xFRPTxModYyL6++tGA3EAjrWZa4lQTww5dABOQ8yX
         B8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761997814; x=1762602614;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZ1LVmNuWNRShkFgZkqHZfQpdnjfb66+76NdCRKKg0Y=;
        b=rBal3Q43WqwLv8q27HNVBBwx5yC/GKP3pIE8GOh8CdEv9UfS3mZIHc7vwNBuJRUv6t
         4lzztCRQ9wgiFIDctx/OoMTFILd0fKpa1n8H6hgRiS0A3Vtb4FHbHI0ZXoiU7Xridysj
         +YYWrnMi62QDj39e6S4Uu3B5ceQ/vRVDobNKxdPcysC+QyF5GM7D2rK44FA9tS5QJWHC
         3Uj9aoMZkA+oxrz+NisGLHEMsnMBs45fAQ1aJZ6iie+PEE4G7XE4gTTQWEaqQzJk44n+
         bgsjtxKqRpotw+WmpHwBaRr9upYInA1ePupml5C4LkzoxddJ0XGDu1dhhxk0Zfqz5FJn
         94iw==
X-Forwarded-Encrypted: i=1; AJvYcCVX1UvUZgv/orBQGGj2OnL0nDWHyncUZ2qg8Bj0p9Jm7CwgAo2XZMGAF3+HbLIfeh9HwGz9sqk9vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgLm4vYmY5xu97088X1Rr3T4T32Pn17kK7oBoVTnQosx15MVhE
	3Wxb15Rt5iXBwi6Z4WPEKRIcnnQmNr0s1SFK6GxIXhJU1VgdWUnj0PNd
X-Gm-Gg: ASbGnctMJwTO9rDd6iJHS7rL9AfxwYI8VpGTfJBpcphYAm75BenpanS6aUDyw+OxCyP
	VETuh2UxcIkCORXk4IztlqFCTh98c8M73jD8ifGzH3BwzUNPCAlExaadyU6v+1k4up+dLUk9O4D
	ZbEz8BIdqqCWX/pCRa1kaj873/UngMSzUa0hBJEzbEq9Ry30BG5xGjLf+HnxKKrEBn0JC4qli+r
	tLJTmkfhkr+WrBKN4wj2e3L3kLKlcq7EsrW8nxE4T+xlyUUynl2hH6dpLHdepDtS8XyZFbhEKbo
	d/+5f7PNsLtZweP69VWucjLZ0y5CP7Cm0oimhfcM24i+RT2YUzPesnAs/xz5CaFa1qcDGebBnnQ
	yE4VY66qnwhdfuioAcD6TDwmhBPzvFE4aDSrNPmwoknY/IEaWYeLbo2aCO3ScUuNeAw+4qi8m04
	34ZkXMY5/Jopg=
X-Google-Smtp-Source: AGHT+IF5Vi/R2DP1IElourozRko5CrLa0/NoKSzqRc9YHLEWiuOxxp/36gk0/Flt/0Dln2p1OLfZhQ==
X-Received: by 2002:a05:6000:400d:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-429bd6be4e8mr5734048f8f.43.1761997813915;
        Sat, 01 Nov 2025 04:50:13 -0700 (PDT)
Received: from Ansuel-XPS. ([109.52.237.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1c9esm8842790f8f.22.2025.11.01.04.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:50:13 -0700 (PDT)
Message-ID: <6905f3f5.5d0a0220.27a792.7a13@mx.google.com>
X-Google-Original-Message-ID: <aQXz8Wz10HnVaiMm@Ansuel-XPS.>
Date: Sat, 1 Nov 2025 12:50:09 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Raag Jadav <raag.jadav@intel.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
 <20251031130835.7953-4-ansuelsmth@gmail.com>
 <aQS5FpuOWk1bWnQd@smile.fi.intel.com>
 <6904c563.050a0220.a13ee.0212@mx.google.com>
 <aQTI7o1HQYbQ_Pl2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQTI7o1HQYbQ_Pl2@smile.fi.intel.com>

On Fri, Oct 31, 2025 at 04:34:22PM +0200, Andy Shevchenko wrote:
> On Fri, Oct 31, 2025 at 03:19:12PM +0100, Christian Marangi wrote:
> > On Fri, Oct 31, 2025 at 03:26:46PM +0200, Andy Shevchenko wrote:
> > > On Fri, Oct 31, 2025 at 02:08:34PM +0100, Christian Marangi wrote:
> 
> ...
> 
> > > > +		if (of_machine_is_compatible("qcom,ipq8062"))
> > > > +			msm_id = QCOM_ID_IPQ8062;
> > > > +		else if (of_machine_is_compatible("qcom,ipq8065") ||
> > > > +			 of_machine_is_compatible("qcom,ipq8069"))
> > > > +			msm_id = QCOM_ID_IPQ8065;
> > > > +		else if (of_machine_is_compatible("qcom,ipq8064") ||
> > > > +			 of_machine_is_compatible("qcom,ipq8066") ||
> > > > +			 of_machine_is_compatible("qcom,ipq8068"))
> > > > +			msm_id = QCOM_ID_IPQ8064;
> > > 
> > > A nit-pick (in case you need a new version of the series): I would expect
> > > the conditionals be sorted by assigned value.
> > > 
> > > 		if (of_machine_is_compatible("qcom,ipq8062"))
> > > 			msm_id = QCOM_ID_IPQ8062;
> > > 		else if (of_machine_is_compatible("qcom,ipq8064") ||
> > > 			 of_machine_is_compatible("qcom,ipq8066") ||
> > > 			 of_machine_is_compatible("qcom,ipq8068"))
> > > 			msm_id = QCOM_ID_IPQ8064;
> > > 		else if (of_machine_is_compatible("qcom,ipq8065") ||
> > > 			 of_machine_is_compatible("qcom,ipq8069"))
> > > 			msm_id = QCOM_ID_IPQ8065;
> > >
> > 
> > Hi as said in the commit, parsing 65/69 before 64 is needed as we might
> > have compatible like
> > 
> > "qcom,ipq8065","qcom,ipq8064" so we might incorrectly parse msm_id
> > ipq8064.
> 
> Oh, this is unfortunate. Wouldn't it be possible to use some API that returns
> an index (or an error if not found) of the compatible? I believe we have a such
> for the regular 'compatible' properties.
> 

Well also using something like checking for the virst compatible might
be problematic as real device have something like "netgear,r7800",
"qcom,ipq8065","qcom,ipq8064".

I will check if I can implement some alternative logic to have
consistent order.

-- 
	Ansuel

