Return-Path: <linux-pm+bounces-40651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 080B4D11BC3
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 11:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A2733018E97
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 10:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCC229AB05;
	Mon, 12 Jan 2026 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwFdn1uu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVO+Uwz3"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ECC296BD4
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212610; cv=none; b=nAn72p63UVcH2HWz+JVxpAzb3rwHwU2ZfUWpJV1sdKehMGpu1iXKTh/jbz9mkOO3Zl3Lrt0O4ozQH4P0EyzMmO2mkSsx2rqHFES+GB13M02+n6Vp6J9OgcIIgrjbdJ8wTVTqi+iuJqL9/BaU85tLbCnhVfN3PSer6Wfu7VVbnlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212610; c=relaxed/simple;
	bh=iDFXfwWSoRhROG/Vq0Ji69eB6IojPN4EMOINzPWp4nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLNWQSRfhdiZDO35KzgPh9oTXWqrOIi2CGhNndl0uUy02Y7I3drJY1HmHa8dX9vSq53ZQO3OEg+GcmV4XACwTgiVGx+Ru59EkVYpRrXxo7qS/8K3EF3qoOwhEdzCb3rWACnuEDi4KIdGk/mVhc0k41UtcAxqgj/MimsNHC1j3Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwFdn1uu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVO+Uwz3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768212608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nT/4BhiqLs8P+whMDHfwq+DdiboEiYpjxDoAfVQFdkw=;
	b=MwFdn1uud1ABKI2wfadn66cikW8OpmtUuGhqvE/4S7bQ/06gMcyEX5DCdc155OBLSgSpGA
	mI62kJfmkrUF13qhCzNDbBPRXOBtnFihW+ysOR6GoDLkof2Y4WhzowA5Oc9nYlqIIeIMxR
	D5Jg060V2RsKJxg4nnHPKi5aEOJ9kvc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-X60YPw3FOCGPk8zEIf_gMQ-1; Mon, 12 Jan 2026 05:10:06 -0500
X-MC-Unique: X60YPw3FOCGPk8zEIf_gMQ-1
X-Mimecast-MFC-AGG-ID: X60YPw3FOCGPk8zEIf_gMQ_1768212605
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d5c7a2f5dso54834975e9.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 02:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768212603; x=1768817403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nT/4BhiqLs8P+whMDHfwq+DdiboEiYpjxDoAfVQFdkw=;
        b=DVO+Uwz3KQoGJMRrvhMReupkOeciWpQhBLtfQSbbK7anl1+oZMq2g7J6emo/51H1X9
         9DeI9eNjGYUC/3GpIPup7MKzKwq1mgmKkBmgfEdyG0ei2f2ZtQXq+oOfxQtN70Eu4NQv
         MCkwBTe4iPWV/BMt7yguYZU7oAuxYCy0seQ6oQwqMG/80vhqtmIuch/xpDPDKRmbWYzr
         CEQgk3pEh+6fNAfMutG5EOQm3UUvNk4W1DGlr7Tgy1eRvUcjMqwU/W6Vo3CMjRcY8A3I
         8bptRGqubjZQFN+uDFnRPaa0tMyQJ2D6rAaZqZLM0J2CdUJqbVQrVKvKmeUdLxYNw+N6
         I5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768212603; x=1768817403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nT/4BhiqLs8P+whMDHfwq+DdiboEiYpjxDoAfVQFdkw=;
        b=OozYTdwk7PitbFGc7y3ez7eKCs22B7mWnBvzab8nexQrB8UmVtb3Hlqwp4gyRO86Ie
         fbPT6WJAbSluvaWw+S2ydjHlCvvQ235hsPOmn385woItIOb8geW3uJUcGhpxiDOJq16G
         j1JXpYX8V73ZAFiI9N7IHPG0+l3vGV5O6a/mdVEWbhQyt405RjPA0nvIgtCAa3V8L+TO
         +w/5vJqknNKw2d/l8VLEUYaICZDm5mX/UE+hmGRC6cwIbdax1jpFBQaEG568FaUbMCAv
         Pdtcqeaz5Q5rt6iSpwKoVbRfP3Tp2TdkTqW1vHZkWb+KTtdxQxzoSliIrTXC/YwV7EM0
         TnVQ==
X-Gm-Message-State: AOJu0Yz4UD1vmRQiYGUfASdnX3BbS3nDeSEVfl4t9XQri4nkpra+WFC7
	djb3nIAPZceRLECYAApqBZorCj16tyv+zFrICZN2QyWAdkcpH+0JZFXYxnPWG6fxUzW+hiCdROm
	9kY64m/v3RGXuV8Mz/DsNScAiBoVhG1SvipDSEcjRMZcf3OU6e4v2fAPWKwzQKEsQLdfyfjJ/F2
	1JC/lhmCpaedDgDSyh2KlG9KSvDU1TUWCBQWGEMJf6bUlpN/Q=
X-Gm-Gg: AY/fxX5JGSQefTzdX9/7HUItTOQuaTxvtD1DH8ZB7ThR4Q4c5OD8p/k5SliEZj7j2pc
	soD1e23iMdVk1V3qKx4ye/1LP0KrMPlJacneaCCiXTUY8i2utcJDoFdPBw7gIdzCch+3QTf25BE
	TgDtE9yJhbSSZNbuRBdWJU7q8uFLbvhF9iN7+MQgHUWvNisfJcsZ9//AiXsOg8ZE8NywpX55YIu
	O7bYYRjWi1zuEInifaK9Ihu/vmJyqF9AQ1xnRlCHskue9EvREFnLP5Arge5IMbeNz0sBaYXaToN
	7LFePtXEhn9KITuFAzaGxLZQO53+A/Boa5MyVTSKE/kDzU4syJ9le2xq5Nwb/p17HNNalOheuB3
	y33S12VNgs5JaOH6f2Cnux5kMWbHWMtbbLzqQMyhY
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d84b32788mr193390625e9.21.1768212603503;
        Mon, 12 Jan 2026 02:10:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHxXn/UA4trykZ5T+SQc9F6yA7v1dNyRS4eMXq4oY/fXdGhX4AlgW2jGMNsGOSw5qPOxfWew==
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d84b32788mr193390185e9.21.1768212603022;
        Mon, 12 Jan 2026 02:10:03 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432dd78f5a8sm17906870f8f.27.2026.01.12.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:10:02 -0800 (PST)
Date: Mon, 12 Jan 2026 11:10:00 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel VIII edition (OSPM-summit 2026)
Message-ID: <aWTIeLbQXalZtOGc@jlelli-thinkpadt14gen4.remote.csb>
References: <aULDwbALUj0V7cVk@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aULDwbALUj0V7cVk@jlelli-thinkpadt14gen4.remote.csb>

Hi All!

Happy new year. :-)

On 17/12/25 15:52, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) VIII
> edition
> 
> April 14-16, 2026 - Arm, Cambridge (UK)
> 
> .:: FOCUS
> 
> The VIII edition of the Power Management and Scheduling in the Linux
> Kernel (OSPM) summit aims at fostering discussions on power management
> and (real-time) scheduling techniques. The summit will be held at Arm in
> Cambridge (UK) on April 14-16, 2026.
> 
> We welcome anybody interested in having discussions on the broad scope
> of scheduler techniques for reducing energy consumption while meeting
> performance and latency requirements, real-time systems, real-time and
> non-real-time scheduling, tooling, debugging and tracing.
> 

...

> Presentations (50 min) can cover recently developed technologies,
> ongoing work and new ideas. Please understand that this workshop is not
> intended for presenting sales and marketing pitches.
> 
> .:: SUBMIT A TOPIC/PRESENTATION
> 
> To submit a topic/presentation use the form available at
> https://forms.gle/dR5FuzQRFNXZEQBb8.
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
> The deadline for submitting topics/presentations is January 30, 2026.
> Notifications for accepted topics/presentations will be sent out
> February 6, 2026.

Quick reminder that the deadline for submitting topics is approaching!

Also, I'd like to mention that the proper event website address is

https://retis.santannapisa.it/ospm-summit/

Don't hesitate to reach out if you need any help.

Best,
Juri


