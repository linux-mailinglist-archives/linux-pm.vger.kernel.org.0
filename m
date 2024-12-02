Return-Path: <linux-pm+bounces-18360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3759E06C8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 16:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B6B282DEE
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 15:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C9D207A26;
	Mon,  2 Dec 2024 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ4irreq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732B205ACD;
	Mon,  2 Dec 2024 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152690; cv=none; b=r/xYa0J3Q91wHqID6PumYTJggtdRB5KBHGbbWW+IEoMxXbXDvMd6k//xwKBZeQJnw60fCsACrJ1BTx7/lcV1ejYKTHgTWzGBIHUpraDtqvG4BgZKMbXRld1kxqDZFA4pi3hL2BXlYVDW9pItfrE1F0pnH4RCoWwr99RSrOT7JTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152690; c=relaxed/simple;
	bh=epsKa02lgjRq/EvyESY+6wcUtaLtir2MXbx6s6so3CU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyvxiqyeLEmmfMWtd92hThGWofdxj+hVNOwanQFG7+v0SMw1GKMYlH9lawlo+Yv+MCUriJYbwtcU905iacPr8WFTqLASDpFpuNiNWzCvCsFznkhNoy9FzPJyn0RNmojlhUKW2cgmNKtqQepRNVQJpcD3v2ECHE2kEZ3hX/yQoXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ4irreq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a95095efso31591975e9.0;
        Mon, 02 Dec 2024 07:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733152687; x=1733757487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TD2Kez+EwJNQZ8hSRecZkUtcdwA0yP1phsQ1edA+02Q=;
        b=UQ4irreqbF2ie4X8qBEiojGOjDt6n93ghwVcyLEmNg8Ql7RgaO43R8eURUGyaGSIvN
         +nlwJHpR/DHp2ZxlxdAF51laFsh8pDIwvstSijhDqpElvoBXYUSBaH39m4uKldsEr2rn
         AzrMm6z31EY7WbzLWZUr8ERfakVDZi38FBaEApOCIiovN8ZvFC1/Mm1Y2s5a/+Ya92M9
         oh3Iax68qrH7wjQeMPjqIMUdgu0EUx2Y5zQl+7IfeMqct5HIc3QEaZTkBL+CIHCCG1wn
         pB+P0EEpP6mvGN2nGU8Hj66EmcOp0c6ebqYZKMrYaXfzJPu4fQSnCEErutJnI4EExYyD
         pVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152687; x=1733757487;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TD2Kez+EwJNQZ8hSRecZkUtcdwA0yP1phsQ1edA+02Q=;
        b=bDN+k9sjwCdkfyM/v1bBXmFoMcqch2Jo+baD0GtaP+xoLTanIJWFG4k2KR9XfWTU8E
         NlQEBNMcGoFksamvks//EZ6oboE4DJGEt8X8DP8r08uUBUzv1B9f7CbQvzWDy4ar4Gp9
         1H0ZENGjdRiue8/7z/wdLzwJ4ltNQ+qRAWTZLzwtVjXu97h8B0AFu7rWmHh0u+/6Nc3A
         jpd3G/jJTrU+q+1bW7trsiEGkNMgaVi+1UxROfCx5DT8niFie0cyBOHEUcA/OFzU8Gat
         41I5qDns+tTOq66cRy+O7lxrolWGFuqgoCClAXxGUdQhbzHSgtKbuhisrjM8HQDQNpB+
         3uHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGVAD45oxdGqc4m3wyhhK4D5w1y/qACXZeZAipXsaw8D7Ok5+iSx8HJY3DRlZcZmvBeqJ9ZNQ7za4yahQ=@vger.kernel.org, AJvYcCVbMhAjy3kxmyG08kbspe2XxmfTRWxI2abdK/aTZK0i/YvPOjBBDx7A2N5hNh7PqXrrszPXpQA2y/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUybq2vqvjSPAHuLrtVPYWUfCoCOt4gpEYH1C1FT2L2U4EaFD6
	Ewy14kfopXh1evKxoKLABDQ8SUM44eo2GrrzfNFRv3PwKTYTEqKj
X-Gm-Gg: ASbGncvW2qwtQPiX487F8eOa8JANxuDNXJvhq3EgPueN/Dy5PsMaeNM+JcTpEfHt6HC
	tZGd9bLJWYVzQ/GApQPWiWzvJs0dv5ZHcDol+jwS1ThPg49xMHfqlCqIsKoD7uDjghlFQCuLU35
	22Pfev1X18tNqvaEG0Yw1lfyfn/62pbhDQiYK8NeFaUkxaq6JpVzoYPnyMt/sjFjpUJy9n+KLNz
	PpHenAc8vlGpZVtqa2U5Y/zWqzwmSGUTuuCk5beH7bzBfht7DRiQXtUIrhwXWGvFU91zY+HLz+8
	eCq4/g==
X-Google-Smtp-Source: AGHT+IFcSULjdaN7t5h+TsvQGpnBOmeaUpqb6hRSZUfNtZBcrLVx8jxCGeSpZmNlhrsyBjhzGyYFcw==
X-Received: by 2002:a05:6000:144e:b0:385:fa30:4f87 with SMTP id ffacd0b85a97d-385fa30503emr1100550f8f.0.1733152686789;
        Mon, 02 Dec 2024 07:18:06 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385df9ef1d6sm9581922f8f.102.2024.12.02.07.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:18:06 -0800 (PST)
Message-ID: <674dcfae.df0a0220.2cb93b.c1bd@mx.google.com>
X-Google-Original-Message-ID: <Z03PqWEPlJ45pq4Z@Ansuel-XPS.>
Date: Mon, 2 Dec 2024 16:18:01 +0100
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
 <674470dc.5d0a0220.119e75.b012@mx.google.com>
 <20241129040234.enfb2vpehpzhmtmc@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129040234.enfb2vpehpzhmtmc@vireshk-i7>

On Fri, Nov 29, 2024 at 09:32:34AM +0530, Viresh Kumar wrote:
> On 25-11-24, 13:43, Christian Marangi wrote:
> > sorry for the delay... I checked the example and other cpufreq driver
> > that register a simple cpufreq-dt. None of the current driver implements
> > a full clk provider internally
> 
> Yeah, that may be done from platform code for those drivers instead of the
> cpufreq driver.
> 
> > and I have some fear it might be
> > problematic to have mixed stuff, eventually I feel I should implement a
> > small clk driver that implements determine_rate, set_rate, a compatible
> > and all sort. And still we would have the double reference of OPP
> > Index->Freq Clock->OPP index.
> 
> One way to avoid that would be to use performance-state stuff and model this as
> a genpd. In that case, opp->level field (which you can set as index only in your
> case) will be programmed as is by the genpd core. That's why I cc'd Ulf earlier
> as it looked more suited to your case.
>

Hi I just sent v4 that exactly implement that. It was hard but at the
end I manage to make use of it :D

> > I wonder if a much easier and better solution for this is (similar to
> > how we do with suspend and resume) add entry in the struct
> > cpufreq_dt_platform_data, to permit to define simple .target_index and
> > .get and overwrite the default one cpufreq-dt.
> 
> Easier, sure. Better, I doubt that :(
> 
> The OPP core currently configures a lot of stuff from set-opp API, like clk,
> regulators, genpd (performance state), bandwidth, etc and I really want to use
> that infrastructure for everyone instead of starting to open code that in
> drivers. The suspend/resume callbacks are special as the OPP core doesn't know
> what to do in that case and so it was left for the drivers to handle that.
> 

Yep, totally understandable and i can see the problem in open coding it.
Easier fort devs but leaves space for random implementation that can be
implemented with OPP and PD

> > This permits to both reduce greatly the airoha-cpufreq driver, register
> > a simple cpufreq-dt and prevent any kind of overhead. After all the
> > .target_index and .get doesn't do anything fancy, they just call the OPP
> > set and clk get rate.
> 
> Yeah, clk-get is pretty simple but opp-set isn't and then there is scope of
> further enhancements / improvements in the future which can be best handled if
> we keep that code common for everyone.
> 
> > What do you think? Changes are really trivial since this is already
> > implemented for suspend and resume.
> 
> I think you can model it as a performance state (which lot of platforms are
> doing as well), and then you won't have the index->clk->index issue anymore.
>

Hope you can check v4 if everything is OK. A dedicated node was required
for the clk provider and the PD provider but that is O.K. if that means
transparent handling for cpufreq-dt.

Thanks a lot on the hint on how to correctly implement this!

-- 
	Ansuel

