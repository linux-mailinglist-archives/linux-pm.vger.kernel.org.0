Return-Path: <linux-pm+bounces-36068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3C6BD9D2E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 15:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F46C3B2DF5
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 13:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44DF30C36C;
	Tue, 14 Oct 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jO2zU59t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F2419F48D
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450199; cv=none; b=kz+msAX4FIIBGjDpOdof980GrblZusiO5tZzzwB+KiLx63viJhcwnRcyZCMzfMO/H2ogiu1RR7BBsE6Jzrqcj59skUQUTLQhdLOffgajharGBxxAPgMssv0iirR4qJ2H8ettfBerQ7Q7D6t+HsV5BlQt6t7kX7CohJM74717RHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450199; c=relaxed/simple;
	bh=Q4/GoNBIxcfJU4OvgQlSaRNFKEqeX55zgRostC9LIc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/4hzvGh0zElPy9Q9GT1U1Xch90oSI8Lm45SeSt5H9QGgDKR9NfOFlVZH98EMEla+vnxLqRmynH33ggtX/fHOUmStzmo1a1IIvGCDw2m0GGoG+L+EBkXOk+DXzplk1Rg3QyyhcQIDYxri2BX1Iq8BX8ZdOw8lYuuJUSsmEdZDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jO2zU59t; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2907948c1d2so12688055ad.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760450198; x=1761054998; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L2JBdlCNVHbh6ekaYzoo4Q2V4kVXYeSiuY6W4L0bPjk=;
        b=jO2zU59tqfHuc+A02ATtPo8yjwx7p1qrnbVxxxT6uo0AZRJrbVxudNjIZFZPqoU3nD
         cARo0HNOrY/YSSuitp+Zua8/28PZ8QS/xfVJoxBd/SdGc/dN1LX/uTTln2S3TZELMZJd
         H3Vi2J2fbFt7gi3Z4t+jYpY+/AiTLL+RVPecM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760450198; x=1761054998;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2JBdlCNVHbh6ekaYzoo4Q2V4kVXYeSiuY6W4L0bPjk=;
        b=JW/400azQM+botdpw+Zqi0CgCc9ljgg1Z2CEH1WKYZ+SRKASCuGo7oSG/n9VPz82kJ
         VDJWgP39WsMJcn1N7rl9l9qR7FCBZS+qjIfd0WMCjA0vC3MCSVyJ2EuXVYF4+rCzm2Qe
         Hyjca1XkJjwNphzDedU8o3e1U4eJnPRAf+x06H0hoIchxF59/4x6mOujpoe3660jC+Gt
         tXcXsd+46JN7iVrNxtknJhww3ZT6NH3ohdvlQoJUM/i+MhMrDeV7XEQllwEqEsjqUPOO
         N/ygPupzDi8jCfJSUcczGWYlTfDIZKR1ph1OMTe+7Jmp2aVs4+ydGVaDij6e/mbUstWx
         DPlw==
X-Forwarded-Encrypted: i=1; AJvYcCXt4pkMfQ2w7IZog4+awzOGSn9eeDhZVMkiYSJlvvdlk9dx7W8KzozdjXPhnG1tjnGR8Pcc5sa2+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0bJ32kmVfwX28wIyvG22sQ+/Sl6BHqcxQvXOnAyASC8pIFkI
	B+1/6RHNHHaPOtfeiBZKEsv1JY56ppVc1TBq0UGYKqZHPf7W72wVRDGGVoDUftKGRg==
X-Gm-Gg: ASbGnctPulGuGD4q9HbxjFrehaSLjs21bqB92BYqCwHuXTpDOoryZD4WnKs+civ6NwK
	e9SC0d6LEhbNqoqBvvqlqxfcjoAOW19hx+54sOLHP7jHiqS7e6Ejp+yaBHqmrRcSU0FzDca0g9s
	MCojtWBmAwikTXluv/cswSw4J7XkEtDtOFgzNhoyZ5atRtxoHifmgtqxT357UAqnP2uwLJIaUNQ
	S0aXHU8PoT7Kofq1aRsskaaCC604/Rfmq7Lc3WoJ2OL8qnrQurfJxTv4kCehp1QFzHsEcGFzxaI
	CR0NQzsItiqRh6PwBgAwepgDwtgW5G/b5N+tNuDV+xO3MRKcsaF8/y9NGZMj6oBZdDWmku/PeFV
	Izcck6RlhFSmVWdCvCWxWXE+BDwKBWR3zGOX66mpBFRG4mWzGN//nmg==
X-Google-Smtp-Source: AGHT+IFom6gnN5okXgH4ljiWIYO99mKWEOVLNkApX62i3COUI3Ge2cjYBTcSk6VjeaaXYz+cDhldKg==
X-Received: by 2002:a17:903:1b4b:b0:271:479d:3dcb with SMTP id d9443c01a7336-29027213537mr324664955ad.6.1760450197603;
        Tue, 14 Oct 2025 06:56:37 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de658bsm166127145ad.22.2025.10.14.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:56:37 -0700 (PDT)
Date: Tue, 14 Oct 2025 22:56:32 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, 
	stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <ns2dglxkdqiidj445xal2w4onk56njkzllgoads377oaix7wuh@afvq7yinhpl7>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>

On (25/10/14 15:47), Rafael J. Wysocki wrote:
> On Tue, Oct 14, 2025 at 12:23 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > > Any details would be much appreciated.
> > > How do the idle state usages differ with and without
> > > "cpuidle: menu: Avoid discarding useful information"?
> > > What do the idle states look like in your platform?
> >
> > Sure, I can run tests.
> 
> Would it be possible to check if the mainline has this issue?  That
> is, compare the benchmark results on unmodified 6.17 (say) and on 6.17
> with commit 85975daeaa4 reverted?

I don't think mainline kernel can run on those devices (due to
a bunch of downstream patches).  Best bet is 6.12, I guess.

