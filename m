Return-Path: <linux-pm+bounces-18049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 606539D8590
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211ED284C7A
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6DC19F120;
	Mon, 25 Nov 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG4NUTFR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F7C1552E3;
	Mon, 25 Nov 2024 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732538592; cv=none; b=btz6bg6iIH74Y6wGmwtWVcKJPYf+6Lw6wqOCWXiuescp6fx18zo+zexPm/PW4BUtMW6tyIgMSMMaLqwtM3KlD/ruxvLaDIP/PRD2c/O1bBBSfpICku5HZqOoYg8KG361TaGAXTPM+3ESVPzaaswYpKBYNjVbfCo3UnI8qH8mgmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732538592; c=relaxed/simple;
	bh=//JnPDEH0l1vfKzZTtmvIktKX1t11vSXsJkyLu9qdn4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuAqRyWMgAuSHtLUKdU4BDHrjg2k2AbS8ml3K6jlP7t4K5bF/kuGdiTGlmGuVALlzgxO4TfwCidkj1RaIy/o+MjmliRh6d2eQfDNzmXbB8ldLwMgEIjiTwHGjeX/li0Y0/9VmR6f2KThuGnReY4MZ1DpV+mh9KP2GsDDVm+oR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG4NUTFR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so1558035e9.3;
        Mon, 25 Nov 2024 04:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732538589; x=1733143389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oD/QgJahcfnToWDDwsHEJMn7c05e3uM5Rszb7udPu3s=;
        b=OG4NUTFRxKb8DSFnvtTHGOo17K4rbQb+ENn2fp/3Jbqkx+PIbyADc08pLMylTWOnVn
         GI5WyRT3L9SFkpl4sqZzdSez1VG+cdsCLQVm2fAzBeQQlImbyr+xptx4MnkPzv77gu94
         24iDg+VIbuNnv143YnJWR03/1n5ioJC1sgsBXQN4hkhZfGFdYa8XjjRptufYvM1Gs7uQ
         Ipb4bcMakA6VN0FE/Y2jx4+BFDwT6GXi80bDj+9c+/1eC0ViW3vrJ7xYDKGcuLwX/kcO
         tQi/Sk3Ru7aNz11VNCmY3UpTvnGd4zO0z+yeznkfxcu/lYvDjfNC8lNinwNW2/mcMREC
         xpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732538589; x=1733143389;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD/QgJahcfnToWDDwsHEJMn7c05e3uM5Rszb7udPu3s=;
        b=ZJE+khTDz21dRhlYv4xkql9azKltExTv7xze28w/8ZwD/GxPmhfNkKgGPETGGvBRnw
         mTkQOj4H/XHOeW73qK+VmSBnkVIuwNgxzlZMjkYJnbzUiMvnSrcc6amrLtWTZ4xR9sjw
         5DqVdN1C+q9nHq75hZsbPpLf7MbNyojunlnQBq04B19woRDFUPuQWTkoI/GF/yhc3CPU
         68atUlGu/PRRlcg+vtF9Wm4CEq5U/LIwvHXgcVGDqb2CqvBwU/v5XOPpbvExUGqRQuoh
         rGanK9aJTsDx5LaKqwgvcpKWz/bTKfXd/VCyaiPm8WwZBT5a/zdTNc3oNNmTCIc3+ATF
         /YSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOSOwHFSSzb9LWuRrrXoMh0hckNe7xtPkL0Emm+p9VdbjEWPfvarheoavo0UPHqKyCXy9Yn2anVmQ=@vger.kernel.org, AJvYcCVpZTB5g0DhXD+K+MYA8DptcDI73MCTYziLSHYLGb69IRoLWk8cbHPjd8kV/Fy0VZvcTjg6KhcAyrvh+kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNU6Pjcvw78KQIbgwG6j1kyAPq5OAm8+QIj6rU2HCFUEALbJSI
	hjDukiZHhJ9wXyWaeeQkNAIRlsIHxmuG2nmt+QOf+YaEHINd++RH
X-Gm-Gg: ASbGncsoLx7RwwgBi3kNZFjqvkCSbzhoVTvl12CMPtBBq/KBXa/QFFuBgvQsnpx6FDw
	p+X60yrzQfynpVtxNyUeC2CwhS7dFd/fGe8xIAN/iq/j9FbnwakBPMuJVV0H/kVvJunY8TgCWf3
	/9Yj3w/85xQ68PJ/8Ri+NEh5v1ZNufrcJxBocxjDj+B4+KBV+heyK+wwKyYbhYhNQNpv8FyIzk0
	0UhYYTlUB5lH3vAYOciOUd5fZ6obyqvgc1WhQj7TH7KFZPOaofOtwTGNXESlWH+1uRRH7AtUi4w
	TTqYgg==
X-Google-Smtp-Source: AGHT+IHO6C4GC4v7/G4VYy/Jt8htlwAc1ke0AFX5Xj4sqJfxpTcCxLqwuJMk3AQHitvn6YSumcDc4A==
X-Received: by 2002:a05:600c:46c4:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-433ce411003mr113060105e9.4.1732538589030;
        Mon, 25 Nov 2024 04:43:09 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedf35sm10229371f8f.99.2024.11.25.04.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 04:43:08 -0800 (PST)
Message-ID: <674470dc.5d0a0220.119e75.b012@mx.google.com>
X-Google-Original-Message-ID: <Z0Rw2pKlNpVIMSar@Ansuel-XPS.>
Date: Mon, 25 Nov 2024 13:43:06 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com, ulf.hansson@linaro.org
Subject: Re: [PATCH v2] cpufreq: airoha: Add EN7581 Cpufreq SMC driver
References: <20241017190809.16942-1-ansuelsmth@gmail.com>
 <20241119072054.64hi347qmv7ng3un@vireshk-i7>
 <673c549c.5d0a0220.3a3476.517a@mx.google.com>
 <20241119104421.hqsil2uvklxok7lz@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119104421.hqsil2uvklxok7lz@vireshk-i7>

On Tue, Nov 19, 2024 at 04:14:21PM +0530, Viresh Kumar wrote:
> On 19-11-24, 10:04, Christian Marangi wrote:
> > On Tue, Nov 19, 2024 at 12:50:54PM +0530, Viresh Kumar wrote:
> > > On 17-10-24, 21:07, Christian Marangi wrote:
> > > > Add simple Cpufreq driver for Airoha EN7581 SoC that control CPU
> > > > frequency scaling with SMC APIs.
> > > > 
> > > > All CPU share the same frequency and can't be controlled independently.
> > > > Current shared CPU frequency is returned by the related SMC command.
> > > > 
> > > > Add SoC compatible to cpufreq-dt-plat block list as a dedicated cpufreq
> > > > driver is needed with OPP v2 nodes declared in DTS.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > > Changes v2:
> > > > - Fix kernel bot error with missing slab.h and bitfield.h header
> > > > - Limit COMPILE_TEST to ARM64 due to smcc 1.2
> > > 
> > > Hi,
> > > 
> > > Sorry for delay at my side to review this driver.
> > > 
> > > Now that I looked at it, I don't see a lot of special stuff happening in the
> > > driver. There are many other platforms with similar situation. What we have done
> > > for all them, which rely on OPPs coming from DT, is to add a clk for the CPUs
> > > and do all this magically smcc stuff from clk_get_rate() and clk_set_rate().
> > > Once that is done, you should be able to reuse the cpufreq-dt driver as is.
> > > 
> > > So a CPU clk is the only missing thing in your case I guess.
> > >
> > 
> > Hi Viresh,
> > 
> > thanks a lot for the follow-up. I will see what I can do, 2 main problem
> > I see is that, contrary to other driver, for this Airoha SoC, there are
> > no parents or no clock to enable... It's really just entirely handled by
> > ATF and smccc call.
> > 
> > And also the SMCCC requires an index and not the clock itself. This was
> > handy for a cpufreq driver as it passed the OPP index
> 
> Right, but the OPP table for the CPU must contain frequencies too, isn't it ? So
> you already have index to frequency conversion available ?
> 
> Can't you just add a clk driver for the CPU, which uses OPP core to parse the
> OPP table of the CPU and set a clk-index table in the clk driver ? So once the
> clk driver gets a request for a particular frequency, it just finds the
> respective index and sets it ?
> 
> > problematic for a
> > clock driver as set_rate pass the clock. So I guess I will have to
> > define the OPP phandle also in the clock node struct. (and map it?)
> 
> I am not suggesting a clk in DT, but just in code, added by a cpufreq driver for
> your platform, which at the end creates cpufreq-dt device. There are many which
> are creating the device on the fly, like tegra20-cpufreq.c.
> 
> > The main problem in doing that is the performance hit on having to cycle
> > every time the OPPs to find the correct index...
> 
> I think it would be traversing an array in the clk driver eventually and that
> won't be that bad ?
> 
> > (yes they really implemented this thing with the ATF specifically with
> > the cpufreq scenario in mind)
>

Hi Viresh,

sorry for the delay... I checked the example and other cpufreq driver
that register a simple cpufreq-dt. None of the current driver implements
a full clk provider internally and I have some fear it might be
problematic to have mixed stuff, eventually I feel I should implement a
small clk driver that implements determine_rate, set_rate, a compatible
and all sort. And still we would have the double reference of OPP
Index->Freq Clock->OPP index.

I wonder if a much easier and better solution for this is (similar to
how we do with suspend and resume) add entry in the struct
cpufreq_dt_platform_data, to permit to define simple .target_index and
.get and overwrite the default one cpufreq-dt.

This permits to both reduce greatly the airoha-cpufreq driver, register
a simple cpufreq-dt and prevent any kind of overhead. After all the
.target_index and .get doesn't do anything fancy, they just call the OPP
set and clk get rate.

What do you think? Changes are really trivial since this is already
implemented for suspend and resume.

-- 
	Ansuel

