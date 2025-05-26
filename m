Return-Path: <linux-pm+bounces-27664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3EFAC41C1
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 16:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C8C16B7AE
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F326C202C4E;
	Mon, 26 May 2025 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6VzZtRL"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8E8632E
	for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748270990; cv=none; b=Vvon27Rl0t7rPjD7KPRQMga8EOudB8F4WJx9tAyXxcj0nzWV5oRmJhWvix0ppw2sBXORHtDCCzvvxb4IHQ0AWfUU1g4CfvhlBU41GyaNXs/bpNc2TqJY8zIGHEaB3KmaQf8NnkVGeQVYzlI6vzIpdKJ+ieV9E/GZ1WC5wgakJS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748270990; c=relaxed/simple;
	bh=W0/hyEwuqgPFvCrdO4dCJvxI2sNISkt+32J7IVABea0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roz4blbxPx7a3SkkClt6VdRo/MmN8dD0umuq0waebzyzyzVqT8tAAH1QmCd2WHjAiAYhO0Y4YRP1HQuHMTu+O7Y3HVxLmwJnPkCBJUTyxUQqa+/2kTzxqfnaSP0iFxAFhgOlQx2VAe8Cr+SlqXRQa4USCCbfw1X9CVuALlyAc90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6VzZtRL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748270988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tbRsQjXJhtCNd3c3uCPjlNU72gknC55NyPzUX0RnmC4=;
	b=G6VzZtRLDoyRQPlSxefVuDcufTXeR9HMecn7B212BckD+Soq8G1NXQUDuHhpjHGqbOCZJV
	xGv8OwzUJgWk3h1MPbaZeSdbW0vDvt+w3IaSgQThAEVErfvGkTxgCCvDF2saT5cOJkcOLi
	BYM6AR1tcdU7aK5Uc9P4eah085dSapY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-PPFGJBB_MJi8_IJ_IRnSsg-1; Mon, 26 May 2025 10:49:47 -0400
X-MC-Unique: PPFGJBB_MJi8_IJ_IRnSsg-1
X-Mimecast-MFC-AGG-ID: PPFGJBB_MJi8_IJ_IRnSsg_1748270986
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so14087075e9.3
        for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 07:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748270986; x=1748875786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbRsQjXJhtCNd3c3uCPjlNU72gknC55NyPzUX0RnmC4=;
        b=dp0+Zcjp95SvQt+k9QyVkHegpFwEX6vrCoD3H/JRE88O4vlfWyMKJ/01AkNOz5SUQ/
         6rsa7CY6HfSPQE92q+zPVGF+NO6OdtfYnCKlKDhL7eyOEFTktX9zRwcD4OmOKaMuXUBn
         JiCG5QicEy19+2cQo23UUKkZwEYMUhRSVq+VzBNwEB/20cIzkYA7cdgmmZjrbmQvgkex
         SSH82UoTkXPj8GMHSufwh9ptBq+cGwNYC9GUN6yEgDcOA9OhrfEqTIgiF3o2LwdsHC8K
         SnwRUNdXbbM/nCxEPj9QrnTJvTM7SmTibbuzX0Wg8WzZS2gXe3loZBfdAC6k64n9vHft
         Ntbg==
X-Forwarded-Encrypted: i=1; AJvYcCVpaSXWNKGjQVdIkl6/mSI865mDjcTSIjnH2G/joZf5itjfKOydTqLQw+lBvKpD4tsTdb2XSKHUxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqEs1bHNhNp3rO5ea4JdyspX7xAVkDt8SXgp0xyZWyR9s9vrq
	QIdQAQOQgbwBpK93g83wS22s2vNjxcUuJg5WuxlPvtdH+L4sE5wRj4AmY6CNVtz8OZhXkdldLfR
	+YRFmyOk76YgnsiUjck5x4foXp0QIk+5SIDcTKgAT0DLzAcwrdk+Px/X3xtyh
X-Gm-Gg: ASbGncvLq+1CMSUlY37cvUHbt6YECasVbJR0BL8Eg/+GQqLjQ8PVJs0YC6m5hlbMkm0
	Mt1rP4yOEVLm7/fwGPg31Yk20rRk8A7dMY//uzbHyPgwORiSp7POEw9QS6l2TM9R13Jt/kJ8zNp
	3WxOBUSNuhvpquQCqtc5nuhrFsr8vryCVdfzDLwXKUPv+DK3Hyu1VehLmRgKsztYurGsV11u26t
	6fu6AFZv7fKDCPqgLe/YsHhWcEmLL87lH3lh6P1dwRQUCZ4v8tcYzPRIPCKNzoui3pUgX8Gu8XK
	QyN91yPO4T7RhoPo4fe0wgnDxxA2QC9S/80L9ANyNQ==
X-Received: by 2002:a05:600c:3c93:b0:43d:fa58:81d3 with SMTP id 5b1f17b1804b1-44c933f0edfmr65831315e9.32.1748270985829;
        Mon, 26 May 2025 07:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEquk3MK1EwO75qTut3w5b91J9jZc5mObLtXUOPqbGkVkc0NrRzBSxJyEDfbLBKJarvXMNWxg==
X-Received: by 2002:a05:600c:3c93:b0:43d:fa58:81d3 with SMTP id 5b1f17b1804b1-44c933f0edfmr65831105e9.32.1748270985456;
        Mon, 26 May 2025 07:49:45 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.57.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44804e89c42sm247878465e9.21.2025.05.26.07.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 07:49:44 -0700 (PDT)
Date: Mon, 26 May 2025 16:49:42 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, rafael@kernel.org, viresh.kumar@linaro.org,
	mathieu.desnoyers@efficios.com, paulmck@kernel.org,
	hannes@cmpxchg.org, surenb@google.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH] sched: Make clangd usable
Message-ID: <aDR_hptEDqSxf112@jlelli-thinkpadt14gen4.remote.csb>
References: <20250523164348.GN39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523164348.GN39944@noisy.programming.kicks-ass.net>

Hi,

On 23/05/25 18:43, Peter Zijlstra wrote:
> 
> Due to the weird Makefile setup of sched the various files do not
> compile as stand alone units. The new generation of editors are trying
> to do just this -- mostly to offer fancy things like completions but
> also better syntax highlighting and code navigation.
> 
> Specifically, I've been playing around with neovim and clangd.

Me too very recently. :)

> Setting up clangd on the kernel source is a giant pain in the arse
> (this really should be improved), but once you do manage, you run into
> dumb stuff like the above.
> 
> Fix up the scheduler files to at least pretend to work.
> 
> (this excludes ext because those include games are worse than average)
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This indeed works for me as well. Thanks!

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


