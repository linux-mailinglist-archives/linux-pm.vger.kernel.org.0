Return-Path: <linux-pm+bounces-17750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2978B9D23BC
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 11:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE98C282F19
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C8B1C3026;
	Tue, 19 Nov 2024 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDYuhTXZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5401BCA0A
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013066; cv=none; b=l5eiKtSsJK9al7xkP1MBjsFc2t0378tVXSKAyZcoQdRmm0nxE5RQQp5vn59plm4uGyWaNhijCNH5xIg6ZjFXsorI1ea3kBx92e8eZ2f5XAsi7l2G/+BR20KF4Yp7bwPPyhM3AH7QGOH/8SfOqxlmkbKCtpA6uKMMc7od+xSUt/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013066; c=relaxed/simple;
	bh=LoolTPBtBhyWAQwPzsppYhoLsD18qbSzuZ30p9qqx68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEGnAjQm8LmI4h76FxZXXRtE6woFY3hL58bU2oNRrGgsBVK2VwYQZpCMqg88pbXjDCXhlfJrm8tL6RMYlIPK7XOY/3fWcfqvr2Bl2WGFkX/J4/C+eyUoa0LA+KOJXA/IDFmqqEbLe5sSxlkj91jVOKwhuDyQMrsFtCTF7feozlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CDYuhTXZ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7f12ba78072so579451a12.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 02:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732013064; x=1732617864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fbiYfkgpw7U78lkQNN2jDbUBVUWR0q89jyTvXZ9m3WE=;
        b=CDYuhTXZam2Jxp7OwL+UgBrfwVNayAUWkhAaZnOFamVSYsRmP2NIT92TwAB3iJ+Vmt
         Zwmnrsb4flAM6LW2I22G+ujLVeeVVCBcBQoth3CdPKMuf2V55wbB6FL9I9deafJkWXjL
         NnaR1z6gP3GXm95B2deDT2POxVLxiSLWd+CWai9qpZKzPr9TmxO4EJI77lTq0+aX+UyC
         k8IdTp/0vUBhoEYyZM+ZwGBRLP3Gb3e5ekojBnHHHjVD7UnGSJPjLDmK1cPqnNT0fNkv
         3nwTc9oxo3BYLTwwPLp55rzs28XNfnw3e7eGOWwWZv6TNm/dPDiT4LIfvGp4ZktdRU/z
         Gf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732013064; x=1732617864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbiYfkgpw7U78lkQNN2jDbUBVUWR0q89jyTvXZ9m3WE=;
        b=Uy4y/C6UxVlNf9nIDvnhHIhTMqQhJqp0crTvyNr3tUyOd99nyEsxl110cDNq82MgB/
         uTyJOIRrC0L/VZaVwJlDwyzUbA2cLBbrhjrstW7nktn4ra3UZ4Gce5vP0Zj3J8cG3xLK
         vaSJIvh7dc261F/eStUSEm71cZc+jmp6bYWY7Oq1SNixgPsd62JGwbnodh4QdZaqZDyY
         jL2Qct7qKvA8v5bmtWcq1IeLPH59rUPp1RPcw1dcCDlN5LJlW9dqFReCT7UQ0jNDf4cQ
         gdbNdZtSzZRaZDK9zjK6oqmCC3BY8uhJlbOoT4pfGF0102Fu6/VIOpRd87GUWKRbkluz
         7EEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHugjd8+27vK6Ef5fYpCojMmD32s5DDW3I9ZOfcWAmiERQKgIGWWtcvLalBPrhp+DbgZ2ZHihPSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1j0vNHWBCTRL3wEcBXG1on+KRKLWcjkiA8bpPHCkzyopK32L
	IMz+EFyLF3kP1Lito7U4tzjx0fM82X2n6JETyZFOYWC5+fGiz6JV//7oc5u1Occ=
X-Google-Smtp-Source: AGHT+IH+wFyP5DOzkfropBLx8xgtPRJ8RhA4Ip/3OTHNA92SyfqSC1dBAbMt5ztWFaCXJ4+oxwHmrQ==
X-Received: by 2002:a05:6a21:9986:b0:1d6:fb3e:78cf with SMTP id adf61e73a8af0-1dc90bef256mr22770118637.41.1732013064171;
        Tue, 19 Nov 2024 02:44:24 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea45daccbesm5312703a91.15.2024.11.19.02.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:44:23 -0800 (PST)
Date: Tue, 19 Nov 2024 16:14:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com, ulf.hansson@linaro.org
Subject: Re: [PATCH v2] cpufreq: airoha: Add EN7581 Cpufreq SMC driver
Message-ID: <20241119104421.hqsil2uvklxok7lz@vireshk-i7>
References: <20241017190809.16942-1-ansuelsmth@gmail.com>
 <20241119072054.64hi347qmv7ng3un@vireshk-i7>
 <673c549c.5d0a0220.3a3476.517a@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <673c549c.5d0a0220.3a3476.517a@mx.google.com>

On 19-11-24, 10:04, Christian Marangi wrote:
> On Tue, Nov 19, 2024 at 12:50:54PM +0530, Viresh Kumar wrote:
> > On 17-10-24, 21:07, Christian Marangi wrote:
> > > Add simple Cpufreq driver for Airoha EN7581 SoC that control CPU
> > > frequency scaling with SMC APIs.
> > > 
> > > All CPU share the same frequency and can't be controlled independently.
> > > Current shared CPU frequency is returned by the related SMC command.
> > > 
> > > Add SoC compatible to cpufreq-dt-plat block list as a dedicated cpufreq
> > > driver is needed with OPP v2 nodes declared in DTS.
> > > 
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > > Changes v2:
> > > - Fix kernel bot error with missing slab.h and bitfield.h header
> > > - Limit COMPILE_TEST to ARM64 due to smcc 1.2
> > 
> > Hi,
> > 
> > Sorry for delay at my side to review this driver.
> > 
> > Now that I looked at it, I don't see a lot of special stuff happening in the
> > driver. There are many other platforms with similar situation. What we have done
> > for all them, which rely on OPPs coming from DT, is to add a clk for the CPUs
> > and do all this magically smcc stuff from clk_get_rate() and clk_set_rate().
> > Once that is done, you should be able to reuse the cpufreq-dt driver as is.
> > 
> > So a CPU clk is the only missing thing in your case I guess.
> >
> 
> Hi Viresh,
> 
> thanks a lot for the follow-up. I will see what I can do, 2 main problem
> I see is that, contrary to other driver, for this Airoha SoC, there are
> no parents or no clock to enable... It's really just entirely handled by
> ATF and smccc call.
> 
> And also the SMCCC requires an index and not the clock itself. This was
> handy for a cpufreq driver as it passed the OPP index

Right, but the OPP table for the CPU must contain frequencies too, isn't it ? So
you already have index to frequency conversion available ?

Can't you just add a clk driver for the CPU, which uses OPP core to parse the
OPP table of the CPU and set a clk-index table in the clk driver ? So once the
clk driver gets a request for a particular frequency, it just finds the
respective index and sets it ?

> problematic for a
> clock driver as set_rate pass the clock. So I guess I will have to
> define the OPP phandle also in the clock node struct. (and map it?)

I am not suggesting a clk in DT, but just in code, added by a cpufreq driver for
your platform, which at the end creates cpufreq-dt device. There are many which
are creating the device on the fly, like tegra20-cpufreq.c.

> The main problem in doing that is the performance hit on having to cycle
> every time the OPPs to find the correct index...

I think it would be traversing an array in the clk driver eventually and that
won't be that bad ?

> (yes they really implemented this thing with the ATF specifically with
> the cpufreq scenario in mind)

-- 
viresh

