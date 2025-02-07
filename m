Return-Path: <linux-pm+bounces-21558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97BCA2CA71
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 18:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D308D188D4D9
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B5B19992D;
	Fri,  7 Feb 2025 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPzVucqY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8CA18E050;
	Fri,  7 Feb 2025 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950181; cv=none; b=hTmQN5SlL5z6FTthwNomkHrhAEqOAtO2cSd1HccYmKbiMGdGhg26uo5F3yBynLmsSXZ9LbtS31LQntEPrirYy8aa0ZxX9j+A06DcX63/apzJCyOAZYjkyK7NyMaD6A/EtlRrF1zZ/gBysRvxnA/BlzAA5LJ86gcLBkrSQCnF8Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950181; c=relaxed/simple;
	bh=ZenoNmF0riWMGf/aW8UIPtWaG8UbAzKLSI4ehKi+4lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVcPdNzVTgTn0ANJyeUWswL9q3pan/nwi8EtqVgvwn+VJdx5+3VtugLpGLlJkT6/a67z4PyO1Rfm0O6rHphizTB4xE4qztOT+Hy9IOooFQvqIButq+2Dz28r/2hMAe9i4nL7+uwXJDfZu6h07mXISHD5Rrt2UVIfHuXssAv1GOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPzVucqY; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46783d44db0so23861381cf.1;
        Fri, 07 Feb 2025 09:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738950178; x=1739554978; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u54wyKy08YVTcdsmqPxr1bFLRjYzOxYrbgu4ALnLyls=;
        b=dPzVucqYjbvI5BK2NfJFp4RDcdcAGFc/EyYuYa0k5OhmkNAYhEu7qINaOyF8hy4w2y
         Yy5USVH9fhtkBSxstCKXTZynlSfwrOOhsU+veWSU+QSjXzp7OXqSdhc+eu7iq+egJlpV
         yBkBkoyvT/sK3FIphjW0bjCQOKYxbPzhhS9l/6wNoVtrBrMWQjluKfIY4z9iEccys9XX
         lx08FbK8Y6gSu8AeZb3i8syIhxZKjUzfOlFiO/ZuGdg9OlHA2GlXfuvJp3+saW86hc37
         8MZ8zlsiAk9i7mqMN3REkRqywvinswftm5nIAef5HAz7NeOsw2aDimIMBlCDWc3ugl+m
         F+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738950178; x=1739554978;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u54wyKy08YVTcdsmqPxr1bFLRjYzOxYrbgu4ALnLyls=;
        b=JWtNAm6lKn19xgJzUi0Bq2mAsTQ/m8Cfya95kW+LSKxa5K+rbIJRQe114B2FsGNjzv
         oAqWWUJEEQqr5O4DYDhY4LpE+pLHjWlSH39olhzEBvFpu16yY2lhPG4O3QboECBMzVR+
         6yh5i47bNy5n0DzZIrsa6ZcfxOwXQFDE3FwBgRJO7+Sp3XnZSpFP6rfJtxEySeDURAuP
         QJ1YIFfZTAutaLrT668ti0wERrwXA8mHT54MzJ9fx2RwsPupQ3AVJGW7CFeR2PugK2Zc
         Bpe6Id5AbR4z+dz5+JNQBenecvmGNqy1Zv1cGKnblKFBpv9icn5cUNdr2mcPRXj+5vXc
         Hy2A==
X-Forwarded-Encrypted: i=1; AJvYcCXZLQGfmTOBBOMV1cqhqDFOTHPjpWo9385zZn3I3Z+7pUqX10dYaiRRTnhLnRLCQAXsk4efW+lnEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPjcpEdiSXaUBfFdVRX5xraLlUeW5Uxq508jxLTVMqgwoQSgc+
	0JyjfezNOIkclc4POwtQA8LmQQyJSEX2lJzHAeQ0xcaB1ic2jpac
X-Gm-Gg: ASbGncsSYEfgqYECOX5QI5t8Bz+dsTvtQ7BHBrKr4Qf+G5pu1rYwctjkQBKiLZypMZI
	ZV5knf5m5aOA2qaQRAFOGrraVicFRukW21XZkACen1U62wF0HGoJQZWoIrP0QaB9e3MrwZkB5Wp
	cEthfdlyPRJq37MNrgjMO5kfac3XTQsqPszD5Iq+taXVDK5xZ78ox9wigVZakBjV3g42IdDiYKo
	cFHzwgzsaWciA5LymBlCLfobGRCndTQEv9dl6nX3R98Dbt2UBsXU9/JFzcrqLBt7E3IwamQna2I
	H688NNA5vUhPJMuQzMDrheL2Snm2SYYJyufvfJEqivU=
X-Google-Smtp-Source: AGHT+IH3DF2ccE09vTzNT3aWXfr9o8hGV8lDRWlk4BMtyiA39cvcPxbJvfohs7KwFEtPpIsYgHBr/g==
X-Received: by 2002:ac8:7d89:0:b0:46c:7252:927f with SMTP id d75a77b69052e-471679a02c0mr46777051cf.6.1738950178512;
        Fri, 07 Feb 2025 09:42:58 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47149275d5esm19033831cf.8.2025.02.07.09.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:42:57 -0800 (PST)
Date: Fri, 7 Feb 2025 12:42:55 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] thermal/drivers/rockchip: add missing rk3328 mapping
 entry
Message-ID: <20250207174255.GA29827@localhost>
References: <20250207164740.14475-1-twoerner@gmail.com>
 <fc3c4542d5cc4d95f74692140e5ea8b5@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc3c4542d5cc4d95f74692140e5ea8b5@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri 2025-02-07 @ 06:15:22 PM, Dragan Simic wrote:
> Hello Trevor,
> 
> On 2025-02-07 17:47, Trevor Woerner wrote:
> > The mapping table for the rk3328 is missing the entry for -25°C which is
> > found in the TRM[1] §9.5.2 "Temperature-to-code mapping".
> > 
> > NOTE: the kernel uses the tsadc_q_sel=1'b1 mode which is defined as:
> >       4096-<code in table>. Whereas the table in the TRM gives the code
> >       "3774" for -25°C, the kernel uses 4096-3774=322.
> > 
> > Link:
> > https://opensource.rock-chips.com/images/9/97/Rockchip_RK3328TRM_V1.1-Part1-20170321.pdf
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> 
> Thanks for the patch.  I think this should also include a Fixes tag

Okay, I'll send a v2. It's not really a big fix. The TRM instructs the code
to interpolate linearly between values (which I assume the Linux kernel does?)
and the table is completely linear in this range.

> and be submitted for inclusion into stable kernels.
> 
> > ---
> >  drivers/thermal/rockchip_thermal.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/thermal/rockchip_thermal.c
> > b/drivers/thermal/rockchip_thermal.c
> > index f551df48eef9..a8ad85feb68f 100644
> > --- a/drivers/thermal/rockchip_thermal.c
> > +++ b/drivers/thermal/rockchip_thermal.c
> > @@ -386,6 +386,7 @@ static const struct tsadc_table rk3328_code_table[]
> > = {
> >  	{296, -40000},
> >  	{304, -35000},
> >  	{313, -30000},
> > +	{322, -25000},
> >  	{331, -20000},
> >  	{340, -15000},
> >  	{349, -10000},

