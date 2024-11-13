Return-Path: <linux-pm+bounces-17521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6DD9C7CBF
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 21:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B111F21A9A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 20:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB1218A6C5;
	Wed, 13 Nov 2024 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcRE5qh1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41CD433CB;
	Wed, 13 Nov 2024 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529172; cv=none; b=tlGoJU5XEksIxqmDR2Iu1PtYEJd3LLPg9a3nY08VOHnGq31dU5MP0M7ISbMl5O3DbmmUkpSG2C4NHN6vMwjZ6EzNVoZuU5/MXsOdBZn5LFJd3QH8FSLhPY/89jcGzcDmDrtpeHvOMj4ZHukuPo6SLFySc4F3GpDR3cWkRGvyhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529172; c=relaxed/simple;
	bh=nOcp2BGkJTbB1WB0/4E5GwsPWV5vAwFo/R8ivUK+xQY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaVdtvT5nhVJrtN9zGwiUcbOopcWKNH2AzAa5Rv26Gd+88EUKQuuGpUfSArwTJnOj/Q88UCBoCVTvGMaTTixR8H1A5rdPITdskhDbT3uw/JSIfwu/J+S+qcUkjJsZSujl/cnJv53HucrsF+Ei4Az8wQMa+hh2M9HoXuFvmg98x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcRE5qh1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43169902057so60024645e9.0;
        Wed, 13 Nov 2024 12:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731529169; x=1732133969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uozj+IUhgH5kgvq1CLAqj0EK/solb2mpQrmuRStNx1s=;
        b=NcRE5qh1s6njqpb2r5l0Z06L6aE0eccMdP+engLNc12SmtopQ7NzgX85d4RnFkJ/9B
         iNly2Vs2WCoJoCBIN0UlorutfOduBbWVoz7Wjc5PJp3voCrKbfh6LYNI/sDggUoFB4Ao
         EKrkxkIYAGpIp36gvV6OswpCgEHFtdoZdFBSaMSZjuy34nyKEFUHtMwU/g1HRQfuEJZo
         +OUtsySjSnMrs65Kxsq9vM976HXYm6+zDJS426YhJR5wus1lqGUlKmk7IYtV7rf0h/E4
         mu4GaGuzAlA67DIY6mYAVSX+kcBn55VAAi1mb/BcrvXdz9a8cZPQ/sCHcJildQqE7VVh
         aIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731529169; x=1732133969;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uozj+IUhgH5kgvq1CLAqj0EK/solb2mpQrmuRStNx1s=;
        b=km3/eYv/4lSNst2vOI/Dggwtz/dUf0EtF59sF1LlZtyCtNJodaVAknF/sHu4V3gkhB
         LP3pZfBdhowh4lAy0//oGnh6/FUF29b2mnlsPO7xCJp7WTucPu12S0F56NAX2pOp+Ttx
         8Nwmh8O0A9GbJ6hGNaQ8nE2SKxKzOEnzpMP8QM/uhAbd69jalZHGEUAzH2sFz0Wrphph
         gR0CKTSBDDAglO/ikK1beqHtXlfS41s3ulj1YLXEYFaM9vYucwriRGADupScHmr4z/pk
         jNS2IaV5M1Lec8jJ25X72nW74dMF/j5AglrzMxZndGenWbsmN/WBVMbHfLegy7PEJ9ln
         amrw==
X-Forwarded-Encrypted: i=1; AJvYcCW7GeAk0Gd7ZfiKjzi++1CUQIxIRQe11Y7eZO4o/uQxtKpUrbj41jQrVjWf1QnJHvCg7KX0ArZ5L9s=@vger.kernel.org, AJvYcCWQhZcX2sWQzErvXTyDnmKjQwHBx1zeoYLg0InLhVjtPOBL/jI4TRcOBgExUty6994TajhL/Lv1tsFgtjSO@vger.kernel.org, AJvYcCWZLDguawavP64atuqjzbsH7onk5vAmuz1USIRIsmDrZuYWxlbfR6NcH7FRGAnylvdtZ2VfYW8IyEAS@vger.kernel.org
X-Gm-Message-State: AOJu0YyL8KpgLnLo7Fxv6gJc9OOs85hTs2y7Q5cgflhxav7U1sFr1ACe
	9JxTfT49sXI8EOM6CE+nJoFeSSDt416/xJhvzkkZNrbKYmsnzAMaqJYXyw==
X-Google-Smtp-Source: AGHT+IHbcZiXmA5YaT7upHrjuXpXA+C0fNy4KAMtE3K+gj1VjK3R+U7if+4Vi5xDoXXPGa+j8zKdEg==
X-Received: by 2002:a05:600c:c0a:b0:431:58cd:b260 with SMTP id 5b1f17b1804b1-432cd474696mr67764975e9.25.1731529168673;
        Wed, 13 Nov 2024 12:19:28 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d55520e5sm34562165e9.41.2024.11.13.12.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 12:19:28 -0800 (PST)
Message-ID: <673509d0.050a0220.f4111.c090@mx.google.com>
X-Google-Original-Message-ID: <ZzUJzZ9-d3SfOMD0@Ansuel-XPS.>
Date: Wed, 13 Nov 2024 21:19:25 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>, upstream@airoha.com
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal: Add support for Airoha
 EN7581 thermal sensor
References: <20241018104839.13296-1-ansuelsmth@gmail.com>
 <6734cc42.df0a0220.4521f.ac78@mx.google.com>
 <487d0de5-6f70-4b82-a22b-5e74ba32da11@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487d0de5-6f70-4b82-a22b-5e74ba32da11@linaro.org>

On Wed, Nov 13, 2024 at 07:18:04PM +0100, Daniel Lezcano wrote:
> 
> Hi Ansuel,
> 
> On 13/11/2024 16:56, Christian Marangi wrote:
> > On Fri, Oct 18, 2024 at 12:48:04PM +0200, Christian Marangi wrote:
> > > Add support for Airoha EN7581 thermal sensor and monitor. This is a
> > > simple sensor for the CPU or SoC Package that provide thermal sensor and
> > > trip point for hot low and critical condition to fire interrupt and
> > > react on the abnormal state.
> > > 
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > 
> > Any news with this series? Everything wrong with the thermal core small
> > patch?
> 
> I understand why you are trying to achieve this but usually it is the kernel
> which overloads the firmware description, not the opposite, no?
> 
> Either way, we ignore the offset/slope from tzp and use a couple of private
> variables offset/slope in the driver (iow do not call
> thermal_zone_get_offset() thermal_zone_get_slope()). Or add the
> thermal_zone_set_offset() and thermal_zone_set_slope() helpers.
> 
> I would prefer the first solution as for today I can not see any DT for
> ARM64 with the coefficients set. So may be we can consider the slope and the
> offset as a legacy which should be removed from sysfs and the thermal zone
> device parameters in a near future.
>

Hi Daniel,

Having set OPs is problematic as that would diverge from what is set in
DT that should always have priority.

Well yes my idea was trying to make use of them as currently there are
many driver that set these values but have the slope and offset in
thermal core always set to 0 and 1.

Thing is that reading temp with ADC is very common and in some way or
another you always have a slope and an offset so it makese sense to
permit to have those values preallocated instead of handling them in
priv struct.

Anyway if the idea is to drop that, I will happly move those values
handling back in the driver. Just need a confirm on that.

Also thanks for the feedback!

-- 
	Ansuel

