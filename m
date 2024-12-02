Return-Path: <linux-pm+bounces-18333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD75C9DFDDA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63234281F41
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 09:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309CD1FBEB2;
	Mon,  2 Dec 2024 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8Iv3OOg"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5583F1F949
	for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2024 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133326; cv=none; b=JZNq1LsArCsHJ1VpY3tAQCU3r49ySrHmscn2FVZXBbMykQRveinx65OuiIiByUjUR16M2nXHvVFt6jhlJtWAckJpdWiegQweAIu/c2kSP5ZHTLdolsEkfTktCSy6gmdUoO/iFj1tmeyDhm7p3yvwk8vGJMRf+5kUVaNhXwI4hJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133326; c=relaxed/simple;
	bh=giKLGGK03twsti8r6koMTfcd/cXGRA56MS0yGykpzlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG9sTj/zBT8TPg9XEza2s2avhHgywALm0bUuswN3EHDdSqxQrJQz1CYICCh1gQ+Ks9xAvUdDccPRZx2f7njLgJr0YIKxe0JsLzldWeFTMvu6KckPZP11MBC3C9b7ygA1PcH+omvPFaoBohV9IkOXPguvp1XWVmy/bzB7+ZgIhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8Iv3OOg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733133323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09MvrDFOXfmr7yZyk+mt+cZonVT5Z8HMfNE6DtwKO3c=;
	b=X8Iv3OOgshy6hHfTzZ3Y+GQMy3uNbTDBb9dm2/7MUdYnKAfrvaCLuAQaUGqk2wkMPC3LQJ
	imc1Z9gHeCoUOMTg+vyRIcJKQKKTtUxp7CmOEJ3aIVVEEfwWYUOkZNh5RuClt95/RC17wQ
	wuygd6ZFIQEYK4NpKDUvGQ0lcMTdWQU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-G8KY9jUXN5qeA6EBGRa8sA-1; Mon, 02 Dec 2024 04:55:22 -0500
X-MC-Unique: G8KY9jUXN5qeA6EBGRa8sA-1
X-Mimecast-MFC-AGG-ID: G8KY9jUXN5qeA6EBGRa8sA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4349cbf726cso29868105e9.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2024 01:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733133319; x=1733738119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09MvrDFOXfmr7yZyk+mt+cZonVT5Z8HMfNE6DtwKO3c=;
        b=sHs6uToNuQDvelDY91m7ZyCxiciL2JXUeNr2SedgIsTNZVT6FJl7StepMZIiEalQZ+
         McGg2hKiDFcb+sKWNU9Z6DNFw5fjrI+Gn5kZW9+EsZZ+C3+bPIuTIGS7OkDFzd8AEa4L
         t0JnLzS7kfBOfJ+VJWGQqowIKFHyXWBSjm/5tuzQi8yH114nSSCpBpdA3vBcPfBK6v4u
         kyUJ/s5WKnMVaCqRlA4Ne4unLxpef+wm2KEFA/ufQ4wtazGGCHDsEU8vDrRVVd5v833V
         ETBugkTTcdMPQXWfUxmkxYaMtO5VBAmLYcpGiVkK5tiNYmkmYHtR1Dkg4QleLJs4PMoS
         Mknw==
X-Gm-Message-State: AOJu0Yzfq2ErEwsloNqkFe1EudH3wsuvGtBdiJ9CMcYyPTFNyA7mfPOL
	274X3hQSKa7bHtS9qBV0S4zWVxwLS0wyx4mB50gN7I7r7Vv4bid2QTZjLsyGzEr2K6/bvA7ay87
	64lJU5++ZjPr+SPpqgd6mpLXv/XolsvN4i61nF7GbeD2/+M/wMVps34i559rLHSvtvhZMCn9qMv
	s0q4B6pr4mTxol0fMeoYbwoS2DeSMxeOX6D6ofEZ8TEi0=
X-Gm-Gg: ASbGncvjdMnDeCPAeavyDldnXky9eoBwKaVdMUwkXrPymnOo6ajpQ1IBtP+k7fgNxf+
	Mn5fXE0+WBLdQMzmT4TJfeennGGOUzv1Gca+9QJGXd8jA0gDqixm+BK0oEx0lMbnHKnxjQBkoTS
	oayoFd1nOqc+gTLFC3hlv4tW/+JDaiZKJlIKvBfSww97WweyzLCmGWjvCbwI6VUbd/6tw4kZ1ke
	/vHQfREfU6h7A6dUkOHBFzLEv2LTBbp4DkUUJe1sLZVAhl6behNS9ELj3tAyRb0iDR2EEp/w1wH
	fDE=
X-Received: by 2002:a05:600c:1c09:b0:431:44fe:fd9f with SMTP id 5b1f17b1804b1-434a9de8cc2mr172537555e9.23.1733133319157;
        Mon, 02 Dec 2024 01:55:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdrZW7CnHqIPba+h3rdUQEPKdX49BX6A51BtPfyAqpRIpHzFbEJP1x+SVenKFW+la85OBsJA==
X-Received: by 2002:a05:600c:1c09:b0:431:44fe:fd9f with SMTP id 5b1f17b1804b1-434a9de8cc2mr172537265e9.23.1733133318732;
        Mon, 02 Dec 2024 01:55:18 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.75.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm144865155e9.15.2024.12.02.01.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:55:17 -0800 (PST)
Date: Mon, 2 Dec 2024 10:55:16 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Frauke =?iso-8859-1?Q?J=E4ger?= <frauke@linutronix.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel VII edition (OSPM-summit 2025)
Message-ID: <Z02EBA_0SwWPhTAi@jlelli-thinkpadt14gen4.remote.csb>
References: <ZytlAkTiuZApK23Y@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZytlAkTiuZApK23Y@jlelli-thinkpadt14gen4.remote.csb>

Hello Everybody,

Quick reminder that deadline for topics submission is approaching
(December 9, 2024 - next Monday).

Please use the form to submit your topic(s) or reply to me privately
with topic's details.

https://forms.gle/Vbvpxsh8pqBffx8b6

Don't wait until last minute or Santa will add you to the naughty list!

Best,
Juri

On 06/11/24 13:45, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) VII edition
> 
> March 18-20, 2025
> Alte Fabrik
> Uhldingen-Mühlhofen, Germany
> 
> ---
> 
> .:: FOCUS
> 
> OSPM is moving to Germany!
> 
> The VII edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. Summit will be held in Uhldingen
> (Germany) on March 18-20, 2025.
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
>  VI  edition - https://lwn.net/Articles/981371/
> 
> .:: FORMAT
> 
> The summit is organized to cover three days of discussions and talks.
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
> .:: SUBMIT A TOPIC/PRESENTATION
> 
> To submit a topic/presentation use the form available at
> https://forms.gle/Vbvpxsh8pqBffx8b6.
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
> Deadline for submitting topics/presentations is December 9, 2024.
> Notifications for accepted topics/presentations will be sent out
> December 16, 2024.
> 
> .:: ATTENDING
> 
> Attending the OSPM-summit is free of charge, but registration to the
> event is mandatory. The event can allow a maximum of 50 people (so, be
> sure to register early!).
> 
> Registrations open on December 16, 2024.
> To register fill in the registration form available at
> https://forms.gle/Yvk7aS79pvNR6hbv8.
> 
> While it is not strictly required to submit a topic/presentation,
> registrations with a topic/presentation proposal will take precedence.
> 
> .:: VENUE
> 
> The conference will take place at Alte Fabrik [1], Daisendorfer Str. 4,
> 88689 Uhldingen-Mühlhofen, Germany
> 
> The conference venue is located in a 2 minute walking distance [2] to
> the Hotel Sternen [3] that has been pre-reserved for the participants.
> Since it is a very rural area, we recommend booking this hotel as it is
> close to the conference room. The price ranges per night incl. breakfast
> between 85€ (Standard Single Room) up to 149€ (Junior Suite). There is
> an availability of 37 rooms in the hotel. Another 13 rooms are
> pre-reserved in the Hotel Kreuz which is also a 5min walking distance to
> the conference location [4]. Cost is 75€ inkl. breakfast. Please choose
> your hotel (and room) and arrange booking yourself. We recommend arrival
> on March 17 and departure on March 21 due to the length of the trip.
> 
> Please use the code ‘LINUTRONIX’ when booking your hotel room. 
> Deadline for hotel booking in Hotel Sternen is February 28, 2025.
> Deadline for hotel booking in Hotel Kreuz is January 17, 2025.  
> After these dates, cancellations are not free of charge anymore.
> 
> You can reach Uhldingen-Mühlhofen best from Zürich Airport [5] or
> Friedrichshafen Airport [6]. From both airports there are train and/or
> bus connections to Uhldingen-Mühlhofen which you can check here [7]. The
> rides are quite long, so another possibility is to organize yourself in
> groups and share a taxi/shuttle [8].
> 
> [1] https://www.fabrik-muehlhofen.de/
> [2] https://maps.app.goo.gl/S6cnTgx1KJAGRkMr7
> [3] https://www.steAlte Fabrik Mühlhofenrnen-muehlhofen.de/
> [4] https://www.bodensee-hotel-kreuz.de/
> [5] https://www.flughafen-zuerich.ch/de/passagiere/praktisches/parking-und-transport/zug-tram-und-bus
> [6] https://www.bodensee-airport.eu/passagiere-besucher/anreise-parken-uebernachten/
> [7] https://www.bahn.de/
> [8] https://airporttaxi24.ch/?gad_source=1&gclid=EAIaIQobChMIo_y9l56iiQMVfp6DBx16NxPtEAAYAiAAEgJOO_D_BwE
> 
> .:: ORGANIZERS
> 
> Juri Lelli (Red Hat)
> Frauke Jäger (Linutronix)
> Tommaso Cucinotta (SSSA)
> Lorenzo Pieralisi (Linaro)


