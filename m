Return-Path: <linux-pm+bounces-12170-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57F9509C1
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 18:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB57CB28148
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509C41A2579;
	Tue, 13 Aug 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhRbnsqg"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BBB1A256B
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564957; cv=none; b=dFKv83zR2FamrpaSNDnGvy+M1nVnxgvip+N8BrdM5Ba7a5+t1Qroiy98j23qK8LdpG+EYWsjLugIHXSvsUYCYWMvHOzuDG27pCrunIttpw9/YsDdvLfg3VcMdQ/MHudJhkNXk2OEqf+KMvqRNpbpoFZksBQDelpCEP722uNGyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564957; c=relaxed/simple;
	bh=yI4QT6NbkEI2TnpG1DH/ktsdWdj4x/PaPPzhWgaN5nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZkVBOPPVua7MsJ6LPtpixVs4CGktS1VToVtDGk+EH0a6zhYhxyNSG5qAeXfBDDdKE66D97NhnwQ79zqX6e2MlTH00nc18waR35/BEKTNJ6D7AU3gOYZIwp+Fzy78yvvNLUfz5iAvOoo3IjP7yEpBisCk+PDIDzyH+odyfWlaLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhRbnsqg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723564952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D++Qz8miXiOrQPRHHoq7zKM0nUNq5aQKlQv/1zqdyj8=;
	b=FhRbnsqgc9U/oQLpeR+eCSrYPv8WWQ3lVhiobKdQgJMoDe0pNVqxImToPsu+hFUZFTUYf0
	Qk4WcBl5nOnt6ItQgYzfF96l4S1yUOAwgU0xMLlKSB7lET34VniuzIUuNIbKJG9s1RXHGD
	DSczayoqC9YS8KgSncpf7jyrWBfnIqM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-zS_FJMJJOg2bUsrE-CEkqA-1; Tue, 13 Aug 2024 12:02:31 -0400
X-MC-Unique: zS_FJMJJOg2bUsrE-CEkqA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4281d0d1c57so31705365e9.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 09:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564950; x=1724169750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D++Qz8miXiOrQPRHHoq7zKM0nUNq5aQKlQv/1zqdyj8=;
        b=Gjxt0uUPEUvDJEaYU4wj1RRH6mCvALLL71pF0uIOBZ7H+w8lqYi5QTwU2qA9vQqoKM
         pJvskcmuDsaHZTIFiwLelrY8BWtdZSvm1od1pDqCX20NinG73cVBPi/Wk2Foy6z2qtUo
         RgH0QpirpaA2QC7BWYb43U1Qhg33/tstasY2i5kFzakJDaLYkKXt2pCoXSUAri2NO77h
         Gdqs2+covMofnnePyPoFotYIrIZMdtVQOb4JNnR/MBhy+x7VuD8Csgj9CJcd+OItXDEQ
         +rC+mkjr8SMLJ4zcKzffncLnA9fT3xCv1bLPM+n+FPxRgiM3BxLxHcVLOXcCNfMMbbgB
         ijbA==
X-Gm-Message-State: AOJu0YylusMi0Fz7T13WpJ2rBmDYGl7UV5+ruM66WNnhhkDymcbZlVxY
	cpIngmP0/FOxDU78+JSw6Z95XzsQmZQPCygufPw00EwCg4C6Fibn+5maxBuPcA9oOe6GSxQSSUi
	skyUwpHGfwOPVZRDe5zy2LYJj34LFjxtwxzXUFDBBbL9PCiFjZ6DyelTg
X-Received: by 2002:a05:600c:3b11:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-429dd08a9f3mr1464005e9.11.1723564950021;
        Tue, 13 Aug 2024 09:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3A88gFDYhC58A8Kf9B/0ejJ6yVjHXP8p29e8MFNq/2z0phpryiFnmZRdavxV6qepB75pIXQ==
X-Received: by 2002:a05:600c:3b11:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-429dd08a9f3mr1463595e9.11.1723564949521;
        Tue, 13 Aug 2024 09:02:29 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([2a00:23c6:4a1d:e001:d365:918d:a79e:2a1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7736b05sm150179755e9.29.2024.08.13.09.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 09:02:29 -0700 (PDT)
Date: Tue, 13 Aug 2024 17:02:27 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, vincent.guittot@linaro.org, qyousef@layalina.io,
	peterz@infradead.org, daniel.lezcano@linaro.org,
	rostedt@goodmis.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH 0/4] sched/deadline: nanoseconds clarifications
Message-ID: <ZruDkw2XB8iXMepz@jlelli-thinkpadt14gen4.remote.csb>
References: <20240813144348.1180344-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813144348.1180344-1-christian.loehle@arm.com>

Hi,

On 13/08/24 15:43, Christian Loehle wrote:
> A couple of clarifications about the time units for the deadline
> parameters uncovered in the discussion around
> https://lore.kernel.org/lkml/3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com/
> 
> While at it I changed the documentation example to chrt instead
> of the schedtool fork.
> 
> No functional changes.

Looks good to me!

At least for docs/uapi,

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


