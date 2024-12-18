Return-Path: <linux-pm+bounces-19409-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4855F9F5F85
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 08:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946B31657A0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 07:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C7115A86B;
	Wed, 18 Dec 2024 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WditV7Yb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A262156F5E
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734507816; cv=none; b=Nlq29eprEy4qcJACu2ONKD5ZTyn9nGQgQKGN1dgcIqlChRuajQf5qb26fOC6ltVrvb1lC8cPWFizC1bSoQE9pK6Lb2WVnrtzsf/IHB1b7iiMwWZF3fKlw4rXesJzxnmRbQWEYAkf8rLMU/pryejLqsywhToiO5W6hgyw1FbJI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734507816; c=relaxed/simple;
	bh=iQr70TC1Ge/e9uv2v8P1WfYKhCbyQDlgvqs3HHrTTYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGlmk7yJfWs0q2lpUlQ2VgO4t/r3KT/Wvq+UaGbkrR5gZvGEfNNZnZDFtLkmtG3Lv1xdwFmkTr81I3rs6sOxWMoF6OFriSwPYsBypnvdsHIFeDDZ1l1lcOFQZL36yLxNhtijNpDpBPz1kf93dCTnLAask1kjqKdfoc7FCKo7kw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WditV7Yb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728e81257bfso5064038b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 23:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734507814; x=1735112614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1aJYya+2E3L9DNld25usr78Elxh9+B64FFy4tnm/LI=;
        b=WditV7Yb6gZ/v/BrvwX2DySgRE27r4j+FLokwQZgtJT9h8EdJv4FSGavGZ8igCIgUA
         YR0wJACsmpSeyDyTolmgRaquULBl8MXSyGZuDVCrt/gQrt2b7hJBk6PJFB2bJ6UrhDfI
         QYoF7LCuu8+L/ThkIXTUIK4X6Crayxf5q8KxMJ6ck1G8r3gCbuf7nt3teovVCe0FBsFP
         cnHqlvFfg+spLpdYiePRXwDIrI6GbWSojGSh6e64Qnp1GUFlflDZ5edS20wkXb7npfTU
         W9F9qGdtfPokXAl9FPM77FC6KTuieyy4zdpDQZtDI5zMgRq3sLedoj9jpGPED/TjltVD
         ftMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734507814; x=1735112614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1aJYya+2E3L9DNld25usr78Elxh9+B64FFy4tnm/LI=;
        b=JJgZMndfd7zhFd0s6FXCttKIb+SBi2zFXj2gzE6Zm0/1ehk1shOtbqIY3DkL6SFM/+
         672EnqyJwnvSv1pFkRx8xy67R2TGuc2TCfj6KiJIipR9gMYX7cIJjYCwmrYv4lXXBJC/
         8j9GSEiCUcy6hvLCpaSEu4VGXLASRD1xO5g/jTDPYqh/RscdXeXsSfvY71m0vtflbhsL
         dR2kv6yxS0D35gTpHrhWrT5gtUxAY6Bxk9nkUzwBSji3l2hAm+7ZH495WY/9Ve4C5yXk
         /YQmkLf3QnR9w7lyKZYyeiC7iAfzctGt6+a+S+oOyni0Cx/MDLzYdCPpzgpM/Cv5APxn
         b9Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWgKlSlvebIR8iJzK5K0Bc9HFHExOi3NbKmb+n+m22JWLofF1/4c7D9AHxv+UkgvycfjYUrIq6J2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zjTIIFagXol3UPzpbEzU5+hN8QzVkYPCo9pt3PDkPmRtFaus
	+Ld+iGNU1Z2vQty5KG3M7mKkgXdvFvTLNX7vIp5WTd9aHBr+YFINk4lERI0FkWs=
X-Gm-Gg: ASbGncv+hC2UegRAaR0aiRmPzlutYcUToxPkdaUURIiHh73sbhTtQp4rrelw/+XDNN0
	Z7RMDJovYeqVP8aT/EeJ64aU+pIxDWjKVNZgaSRn+5qjgvbsc7JyVoYHuJCPDhl1VvTZDFZ1p2Y
	gzyDf3TaNmVKLH8AcFKb4yc0O3ZSpHM7O0Hua809lz1AmfwXGvxPQ6vXioUIbhD49dYgZzNJKL2
	WvjmEQByH84wEDybo92J8gF66++thBPyzchr2zPBhkP18vwihHUql75X1Q=
X-Google-Smtp-Source: AGHT+IEA6Sa4ujE9QFfv0BQAbIVG+jhMAQXQN0u1B35kYf+P9c9Qutr90IDoa5pVp7VjIyS7ZvEuYg==
X-Received: by 2002:a05:6a21:9002:b0:1e1:b28e:a148 with SMTP id adf61e73a8af0-1e5b45ffc3dmr3247283637.5.1734507814668;
        Tue, 17 Dec 2024 23:43:34 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bad760sm7890628b3a.152.2024.12.17.23.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 23:43:34 -0800 (PST)
Date: Wed, 18 Dec 2024 13:13:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v7 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Message-ID: <20241218074331.vdrfthbrl3mil24p@vireshk-i7>
References: <20241206211145.2823-1-ansuelsmth@gmail.com>
 <20241206211145.2823-2-ansuelsmth@gmail.com>
 <CAPDyKFovtfR7BiXBfH-79Cyf1=rd-kmOoEnEdMArjGUxSks-Aw@mail.gmail.com>
 <20241213040001.jaqeuxyuhcc73ihg@vireshk-i7>
 <675cb6b2.050a0220.149877.5bab@mx.google.com>
 <67627c91.5d0a0220.ce2b3.f329@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67627c91.5d0a0220.ce2b3.f329@mx.google.com>

On 18-12-24, 08:41, Christian Marangi wrote:
> On Fri, Dec 13, 2024 at 11:35:25PM +0100, Christian Marangi wrote:
> > On Fri, Dec 13, 2024 at 09:30:01AM +0530, Viresh Kumar wrote:
> > > On 12-12-24, 13:01, Ulf Hansson wrote:
> > > > On Fri, 6 Dec 2024 at 22:16, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > Hmm, it looks like this needs to be moved and possibly split up.
> > > > 
> > > > The provider part (for the clock and power-domain) belongs in
> > > > /drivers/pmdomain/*, along with the other power-domain providers.
> > > > 
> > > > Other than that, I was really expecting the cpufreq-dt to take care of the rest.
> > > > 
> > > > To me, the above code belongs in a power-domain provider driver. While
> > > > the below should be taken care of in cpufreq-dt, except for the device
> > > > registration of the cpufreq-dt device, I guess.
> > > > 
> > > > Viresh, what's your view on this?
> > > 
> > > Sure, no issues.. These are all cpufreq related, but don't necessarily belong in
> > > the cpufreq directory.
> > >
> > 
> > Problem is really DT schema... I wonder if it's acceptable to push a
> > name-only driver in pmdomain just do detach from cpufreq. The cpufreq
> > driver would manually probe the pmdomain. Is it acceptable?
> > 
> > Or do you have alternative solution for this?
> >
> 
> Hi Viresk I notice the DT patch has been applied to -next but no
> cpufreq patch. I'm confused how to further proceed and what changes are
> needed. Any hint?

The DT patch was fine and so I applied. I was waiting for Ulf to reply
to your above query.

-- 
viresh

