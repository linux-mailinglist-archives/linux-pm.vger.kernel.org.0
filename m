Return-Path: <linux-pm+bounces-3857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B778529AD
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 08:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD93282F7C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Feb 2024 07:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892F017564;
	Tue, 13 Feb 2024 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OW3TreqW"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CA41756D
	for <linux-pm@vger.kernel.org>; Tue, 13 Feb 2024 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808954; cv=none; b=IDH9RH1T6RYIyvKUdgYDPK9vOMJvmDyIfq4x66LGD46gXL34m0fCq5pwmpOQ1xJmDCC9fqoqOKgJYxTvznN5XHt6h9z0+Ol6mofYdzIuFH5ldTvGpDdsNiWMMln2Pdg3TFhsUZus3RHTTeb1f/P/6eA2ayiutCxMtazI7IGT2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808954; c=relaxed/simple;
	bh=ozeZ7FqGPCKUWXvXyQuga6WAhbDvE50uGIz70z7K9Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD69rMSTqNYS2rYC2lOagFd4sphw7ShEgKHu2rrn24DSspd89P7nDBwjajU/21E193YfGyBECzJlMHPCnJ1uXaUYcHyiLYqteuDbq+Q+ty6BhmZ8+s9qWmjUESiW2b0sWXKGwZOt8wQuMf2nENVAlTvISy5oswn0xxCWWJf7A7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OW3TreqW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707808951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGhe/YEZnEtGdd9u8LC35GLq72EBNiME+lxjrDlx7s4=;
	b=OW3TreqWCNQoLI/30aHGA1Y9tDM2oNbhLR+c9PPsBc1jTfVZ431FJ++fx+9jdbcugyNYdl
	j26as5iFJ56VGss0SfivYWX5Ycw0lI7w/+9ANHGS9FfxJPsL6oeyaMkkhAp9ls5UvwIdg+
	e5oumJkxgp4pQ1mN3PEf6+btyQEWPGY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-G9PNtV1SNKiAwRGiyzlSEg-1; Tue, 13 Feb 2024 02:22:29 -0500
X-MC-Unique: G9PNtV1SNKiAwRGiyzlSEg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bbaf0ee0d9so5930019b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Feb 2024 23:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707808944; x=1708413744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGhe/YEZnEtGdd9u8LC35GLq72EBNiME+lxjrDlx7s4=;
        b=eoCmrEh4Iu/D48xOasspEfGnKc0xvzkkQDXmi43rLVuOZbQfble8XbDGExwgbc6myy
         9X9DKx+2LqewEhYTPMc1aD2bFpQIy6z+e3ERg2sD69MUneUqIBWc+2JErsZMyMjP1ROI
         P9zFzCzrkLXNePNZ78r4GFlPiid/WutrICO8wg/vNFqsbsWXI+nW585y1NEP3+uIkh4j
         0aKNfPgNIFPg/s1ktxD3PwZMiNlHKAeAAEIkT3LxGJIuEcqkMvpnp2BS9hK2iCXocPyS
         aeS6ktByLsbxk3RDEWryzwmou836anfS9T9XeVskPk5eQdURzMJjIkW/DYvD2VT8yMdY
         GhWw==
X-Gm-Message-State: AOJu0Yx6aJdHTMtdyKlWcLe4MbpeSemNUtRJ9EhfYtfOonN09a26jMLA
	aY9CIFEylo5jOjAj8OkbxBwAvHeLPGFgyxE7Bwoe/9UeU5QQj8ExzIOtEgkRejgIKf1M6Squ/EP
	oWvr86ozvu9IOR8kTppxBtg30vTkNpFjAZkzasGMa+xD6+YheNhYDCALT5IKzKOa6B8z/mXQtll
	g22jUHR+waMvg7gZwENnybfhwnO7FToXH5SLmrgf5ZOQE=
X-Received: by 2002:a05:6808:21a3:b0:3bf:e6c5:9b1f with SMTP id be35-20020a05680821a300b003bfe6c59b1fmr11167877oib.43.1707808944037;
        Mon, 12 Feb 2024 23:22:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEigHFXP+2h7Q/N0HEHy6RpNKMeeDNhg5ntkf8WvHxyDqYobAdFtx48sRQblZ+4wCHqA8X5g==
X-Received: by 2002:a05:6808:21a3:b0:3bf:e6c5:9b1f with SMTP id be35-20020a05680821a300b003bfe6c59b1fmr11167851oib.43.1707808943512;
        Mon, 12 Feb 2024 23:22:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkh3GDANAyn31CsDbSSGINl5Qk0DsLS4jKDouEEYysktm4LhSXTreW0BSz9bBaLGM2PH1TEXw8yWTuEJHZqD8SWq5kdBbCef6l9d6bMeylSPkPKn63WKKPyOi/JjGNr19PTQr8J7H2zkugFZyWkVY0e1BGY/KCCJUvL77FVgM/+q3/NPWcD1QD0c/RLfC4vDM4U8fP9fRmsy2vKTCH/FmNWQM0nH+UUll3hP+w8VHDuVMjETcmcWRK+PNel5D6bOBcDxGlMBIgXxIMZ7FPho0sNHelmYHzJojFGk9QQ/kaget2/zK7mO05b7eRzMMzPprfNBiAS7hOPim2q7uvGVPn1e8xPDzDY/BwyA==
Received: from localhost.localdomain ([151.29.75.172])
        by smtp.gmail.com with ESMTPSA id p9-20020ac84609000000b0042c7a76d267sm910557qtn.36.2024.02.12.23.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 23:22:23 -0800 (PST)
Date: Tue, 13 Feb 2024 08:22:18 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Georges Da Costa <georges.da-costa@irit.fr>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel VI edition (OSPM-summit 2024)
Message-ID: <ZcsYqkkMa-4mk4G6@localhost.localdomain>
References: <ZbJHfiWnujLz2Pfm@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbJHfiWnujLz2Pfm@localhost.localdomain>

Hi All,

Gentle reminder that the deadline for submitting topics/presentation is
approaching: 19th of February 2024 (this coming Monday).

So, please go ahead and add your proposal to the shared doc

https://docs.google.com/spreadsheets/d/13lOYsbNWhQU7pNbyHI97fC7GT0Eu8aMbU9ATvPJfV0A/edit?usp=sharing

or reply in private to this email with details.

Don't hesitate to reach out if you need help!

Best,
Juri

On 25/01/24 11:35, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) VI
> edition
> 
> May 30-31, 2024
> Institut de Recherche en Informatique de Toulouse
> Toulouse, France
> 
> ---
> 
> .:: FOCUS
> 
> OSPM is moving to France!
> 
> The VI edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. Summit will be held in Toulouse
> (France) on May 30-31, 2024.
> 
> We welcome anybody interested in having discussions on the broad scope
> of scheduler techniques for reducing energy consumption while meeting
> performance and latency requirements, real-time systems, real-time and
> non-real-time scheduling, tooling, debugging and tracing.
> 
> Feel free to take a look at what happened previous years:
> 
>  I   edition - https://lwn.net/Articles/721573/
>  II  edition - https://lwn.net/Articles/754923/
>  III edition - https://lwn.net/Articles/793281/
>  IV  edition - https://lwn.net/Articles/820337/ (online)
>  V   edition - https://lwn.net/Articles/934142/
>                https://lwn.net/Articles/934459/
>                https://lwn.net/Articles/935180/
> 
> .:: FORMAT
> 
> The summit is organized to cover two days of discussions and talks.
> 
> The list of topics of interest includes (but it is not limited to):
> 
>  * Power management techniques
>  * Scheduling techniques (real-time and non real-time)
>  * Energy consumption and CPU capacity aware scheduling
>  * Real-time virtualization
>  * Mobile/Server power management real-world use cases (successes and
>    failures)
>  * Power management and scheduling tooling (configuration, integration,
>    testing, etc.)
>  * Tracing
>  * Recap/lightning talks
> 
> Presentations (50 min) can cover recently developed technologies,
> ongoing work and new ideas. Please understand that this workshop is not
> intended for presenting sales and marketing pitches.
> 
> .:: ATTENDING
> 
> Attending the OSPM-summit is free of charge, but registration to the
> event is mandatory. The event can allow a maximum of 50 people (so, be
> sure to register early!).
> 
> Registrations open on February 26th, 2024.
> To register fill in the registration form available at
> https://forms.gle/SooSmYMChBcn5rmM8
> 
> While it is not strictly required to submit a topic/presentation (see
> below), registrations with a topic/presentation proposal will take
> precedence.
> 
> .:: SUBMIT A TOPIC/PRESENTATION
> 
> To submit a topic/presentation add its details to this list:
> https://docs.google.com/spreadsheets/d/13lOYsbNWhQU7pNbyHI97fC7GT0Eu8aMbU9ATvPJfV0A/edit?usp=sharing
> 
> Or, if you prefer, simply reply (only to me, please :) to this email
> specifying:
> 
> - name/surname
> - affiliation
> - short bio
> - email address
> - title
> - abstract
> 
> Deadline for submitting topics/presentations is 19th of February 2024.
> Notifications for accepted topics/presentations will be sent out 26th of
> February 2024.
> 
> .:: VENUE
> 
> The workshop will take place at IRIT [1], University of Toulouse [2],
> France.
> 
> The workshop venue is accessible [3] from downtown, where you can find
> most of the hotels/accommodations suggested below, by metro (line B) in
> 30 minutes [4]. You can reach IRIT by the metro B (approx one every 2
> minutes in rush hours) or by bus (several lines, between 40 and 60
> minutes depending on the line and the traffic). Several buses arrive at
> the metro station of the university. A map of the city center with the
> venue, transportation and food/drinks places is provided here [5].
> 
> It is recommended to pick a hotel close to a “Ligne B” subway station,
> anywhere between “Jean-Jaures” and “Les Carmes”.
> 
> From the station, choose “Ramonville” direction and get off at the
> station “Université Paul Sabatier” [6]. The station is right inside the
> university. From there follow the map [7] to reach the IRIT building
> entrance. 
> 
> Toulouse airport, “Aéroport Toulouse-Blagnac (TLS), Blagnac”, has a lot
> of direct flights from European airports like Paris, Amsterdam, London,
> Munich among others. There is a shuttle “La Navette” [8], every 20
> minutes, bringing you to downtown in more or less 30 minutes depending
> on the traffic. 
> 
> A list of hotels on the metro line B (direct to the workshop location):
> http://www.hotel-oursblanc.com/
> https://www.athome-ah.com/
> https://www.discoverasr.com/fr/citadines/france/citadines-wilson-toulouse
> https://www.pullman-toulouse-centre-ramblas.fr
> 
> [1] https://www.irit.fr/
> [2] https://www.univ-tlse3.fr/
> [3] https://maps.app.goo.gl/rdcrKx6x8ntm4uij6
> [4] https://maps.app.goo.gl/Y8UPRvHmbrjCSnvu5
> [5] https://www.toulouse-visit.com/interactive-map
> [6] https://metro-toulouse.com/ligne-B-metro-toulouse.php
> [7] https://goo.gl/maps/ojiAeQoL5Ewgb2gp7
> [8] https://www.toulouse.aeroport.fr/en/transports/public-transport?tabs4633=tab_4631
> 
> .:: ORGANIZERS
> 
> Juri Lelli (Red Hat)
> Daniel Bristot de Oliveira (Red Hat)
> Daniel Lezcano(Linaro)
> Georges Da Costa (IRIT)
> Tommaso Cucinotta (SSSA)
> Lorenzo Pieralisi (Linaro)


