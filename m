Return-Path: <linux-pm+bounces-14473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5194097CC90
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 18:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0D6285E7C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881DC19EED6;
	Thu, 19 Sep 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/KsiQ+a"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC63919DF9C
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726763926; cv=none; b=Wvi6pEy98eOaEb6TzkmLk+bWIyBHh4QQzqePWqr9jEE3x84gTmZdzGV/9cypa45NSEKuR77adWwrJcQHBlV+tWAq83nrihkI/DUHc6CWJfsfvJnuFwoRx3WQDX2jtD2UWG6G3+ktROLiiNW8n5sh9NkgbvL3MJVLr1CA+d72HFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726763926; c=relaxed/simple;
	bh=tFCXd8J0YrW1eOZcUrItEsolB4qhbKvhdsVyCQRO2XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO45DyWlcleA3Y1K7QVOq5H4O5zUQ6r3hVIZMR48DUFcG5AXDRTqeGp5Dt8SmDkXBs6ucoQiLGhQr1sPpPV6vU+t+vUvwd3VWiDvcp1xUpxdwRTU3dXMzlNsfM/jFGBZV8mCcjg17d89SS7BsNQAI75TQJ7nVJpjA5k92OvRzMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/KsiQ+a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726763923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puvOlZY3VXgV3pFjUXPhkvTkqDKiAGbtX/SwNTF0nsQ=;
	b=T/KsiQ+acpb6MMkxZ5yoZf9pGw1jO1lhbFhc39JYvBJsVtq2pHBwGkfJbIJw61Rs4sFyu9
	0IWBo4KF+EDIlQletP6jT3oF6u9FISkCf5lHLzFEHbRo/7AK80IzjRMGXnSbe868umrjOT
	0T9ojCrLYh/91POzs3wKcSW1d9XaCqI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-hEvJ8AX1P1i36HSmhfTiVA-1; Thu, 19 Sep 2024 12:38:42 -0400
X-MC-Unique: hEvJ8AX1P1i36HSmhfTiVA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a9a74d39b5so196425885a.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 09:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726763922; x=1727368722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puvOlZY3VXgV3pFjUXPhkvTkqDKiAGbtX/SwNTF0nsQ=;
        b=AEjq3eBCPQjwkn8FJa5So2/n7FTDBslMsSIoYeHZ+jG90mbfXODsdbeMtyEbkAu2fl
         C15FaPr71B+BHP31+d7WwzigQgmWyPnz5VZftraHZaVEGf6BbSXkRPELTF5KsoBYKUey
         lPTwdzVQWOqsqw752volTq0jx12yFl7z2pUHnA5cbRntnb3Fg/lJWrotCujlicNnNJJB
         pskC92hQA3jpR57az4j1uUCYL2yBgDUw2oDCWIDsrNyIKBqTDvPcW5S+Nb4y9zd4rGhO
         W0Nc+mUuWQABBekYSQfZuMgIKknmmHhDCPxYcqKrUYDz4O3q56lR59/hBos96k8Lot+S
         Ownw==
X-Forwarded-Encrypted: i=1; AJvYcCXXX6JFo+Dz2E4GHCrJHqNtwF5zDomwqOFA0BMUgzuHwJTphQorc78XcE8Mgy644WeQRwlCfvOm+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJwLgajTNcZS3WIvHxDmSS6Muv7YropinMms6+zyC3AOXvZjc
	30LzYqMQASwZ2IQnpq77n5TBSQoZzglQeS9HpT8CD8NjsCh//46YyedkuUDvBLvCxLHENfh/Oir
	mMbeO4DWuZuMR7M6VYeBnGUAKatEouDrCV48Q1weVCVYN3oeZs6FqJNSwyhTjnwZR
X-Received: by 2002:a05:620a:4092:b0:7a1:c40b:b1e4 with SMTP id af79cd13be357-7a9e5f90beamr3784153385a.55.1726763921918;
        Thu, 19 Sep 2024 09:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOQyCgCmq4QyrHzZ4p5qsO1B4L1YkAT9YjQERg/EFspjqv6f7g3/fFnquq2WE7Lx4S7FIgJw==
X-Received: by 2002:a05:620a:4092:b0:7a1:c40b:b1e4 with SMTP id af79cd13be357-7a9e5f90beamr3784150885a.55.1726763921650;
        Thu, 19 Sep 2024 09:38:41 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08eba0csm88741785a.131.2024.09.19.09.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 09:38:41 -0700 (PDT)
Date: Thu, 19 Sep 2024 12:38:39 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
 cross-compiling envs
Message-ID: <ZuxTjy7I-pZBcXa0@rhfedora>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919-pm-v2-0-0f25686556b5@nxp.com>

Hi Peng,

A few comments:

> V2:
>  subject update, commit log update in patch 1, 2
>  Use strerror in patch 1
>  without patch 2, need update Makefile with 'CROSS =
>  [cross toolchain path]/aarch64-poky-linux-'

Version information is applied per commit patch. Not in the cover letter.

Example:

https://lore.kernel.org/linux-pm/20240905021916.15938-2-jwyatt@redhat.com/

Reference:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

You will need to submit a V3 version of this.

>  without patch 2, need update Makefile with 'CROSS =
>  [cross toolchain path]/aarch64-poky-linux-'

I am not sure what this is saying exactly. Please clarify.

> Subject: Re: [PATCH v2 0/2] tools: power: cpupower: Allow overriding

Not sure you need 'tools: power: cpupower:' in the cover letter.

> pm: cpupower: bench: print config file path when open cpufreq-bench.conf fails

I do not think you need bench either.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


