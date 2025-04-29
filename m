Return-Path: <linux-pm+bounces-26392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAB2AA1C92
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 22:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068E14C4F69
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 20:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DA32586EB;
	Tue, 29 Apr 2025 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f73tmMEM"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC8B21D3F4
	for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2025 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745960352; cv=none; b=bTnwB7oym5slPUZJsofJ5qK3RlvoGmjW6wzl5zH8x+la+Xz0OZLElDLQGQl+OMdh+XDpJqGPWs20Mmd7PB1DnMxu3AXnc1xVgBuCAbIKitvegb0cZJNDrNAWB2xulW3AtKLBNrmHNo45FBMC570likphohh6lIObX7+wXJEWF4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745960352; c=relaxed/simple;
	bh=2foY8aJkUqXuzy5/740zw/k5H8Z8Qx7GC1j+qef3k30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCx/kc4ioSh1LFJ7hlDVeNBAwJYZLOjj41bwuqDOBb8RS+um+vXrtVo8F8EZpAK4CiivpBcZibHmJFKkefnaZgz0HQ1vxjVbddXVpnbRvHZCPmvOxpUO1zKWSvHwR9IS2u8p17jfn5ZeBu1M+EG7LPsKAm4Sj3nxXuoQPOiWOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f73tmMEM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745960349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5RhYr/UyCLS/XEsTQgp+7mb2ke0gGzsz5aTxylR9M4s=;
	b=f73tmMEMX5Bp2GmcivAKUDkOCe8k93NfoZHCRvcX3N59Jg+TUW93MV3f8gqB9pNw1P03xg
	xTW5AbJzZwd3a4VuSHuEvxuFUWLnp0gOUj+KPzSCkCTEoHMBUswFE3sGaLr+tEyE4zfNcP
	H7HED8mSqCZPzT6TR8xInE9R3GUWE/I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-dL6sQ9SLPQu_7AN7rrR48A-1; Tue, 29 Apr 2025 16:59:07 -0400
X-MC-Unique: dL6sQ9SLPQu_7AN7rrR48A-1
X-Mimecast-MFC-AGG-ID: dL6sQ9SLPQu_7AN7rrR48A_1745960347
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5c9abdbd3so600787285a.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2025 13:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745960347; x=1746565147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RhYr/UyCLS/XEsTQgp+7mb2ke0gGzsz5aTxylR9M4s=;
        b=dERxp/wENXezrajkEiydCVedH++viFcKsyNOgSEtErX7O0Y3iszh5jM7u5LbsMBt0a
         QJD+xbJJ8MFNxI2lcGopUjl9PT8m/awwrYufZ/8XUrFL7/NAPBnftAHqg3F9y2JQ9CS9
         mlTN9xSkxsy1GZO7KbHBBY05EgqYOQZ5cqLmpchfO979ew2nJDDocG1PIqk6dIp6IhiG
         3rcPRhrcEJzubqbO2Vn5Y5MbvIw19zuD69+t3yWsSTnrPgCnoFWpf0fkdExT3TrsmMAl
         6H71F/paW40GrqkGyOVRnueoKgHLy/u/xaUNuZM9kuDXG/lO8s/Ud00Rc6s7wA7WNG2j
         oupA==
X-Gm-Message-State: AOJu0Yy8DguHCI82e+m48U06fYY2i7oJ22EA0qXD7V8iTLN5Bs+5yqbC
	O/GiokX5VyUXWDs7VS2zjXg5DHJEQQGytDrYEcKAATiXzfSE8pLU9Zj/VLHVjiEwYgh3GTmd0kz
	s8lqSpClq6cxaHhL0zaz+1T/X+MVKEiZJuz+kNMqAGoOk43eaGsZjL+6o
X-Gm-Gg: ASbGncsSRfX9qTww9NZPJoT9kWmc5uKWHXa5OAHajBAFNJg75MZAUfuwka8M2z6eFtv
	D4qOK1EaL+zusQbqkaKsz5hpZFuUEGIUF5HjL/riHxMd8SeX4su2+Bbwhd6VVX508bkBXZzMFno
	PrjYX9WSRAKSe3vtQD2Z/t4SnNWHqaw5FN8LHCsLPy7uBEzGo3d2B10a8jjEUSTUVfeWJoxeTDQ
	FSUeFa7sPyIUXKf1SrRQM5ynMzzd/a4AC5eem02OJld0uv6R7DpBCz6LZ9b/Q8fJNEWA5Lgb3K7
	HK2S0dAK
X-Received: by 2002:a05:620a:4546:b0:7c5:642f:b22f with SMTP id af79cd13be357-7cac760a931mr92023185a.18.1745960347397;
        Tue, 29 Apr 2025 13:59:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3Jp+sfoDg4/YvtqNqY+3qnmF4j/fslcRIu7CqyIY73tOjVob+6SaGYhk/jsbTUA+NJpJqIw==
X-Received: by 2002:a05:620a:4546:b0:7c5:642f:b22f with SMTP id af79cd13be357-7cac760a931mr92020785a.18.1745960347113;
        Tue, 29 Apr 2025 13:59:07 -0700 (PDT)
Received: from thinkpad2024 ([71.217.50.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958eb5550sm774859785a.116.2025.04.29.13.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:59:06 -0700 (PDT)
Date: Tue, 29 Apr 2025 16:59:03 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Francesco Poli (wintermute)" <invernomuto@paranoici.org>
Cc: linux-pm list <linux-pm@vger.kernel.org>,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] cpupower: add a systemd service to run cpupower
Message-ID: <aBE9ly7vP0eryfMO@thinkpad2024>
References: <20250425151024.121630-1-invernomuto@paranoici.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425151024.121630-1-invernomuto@paranoici.org>

On Fri, Apr 25, 2025 at 05:07:31PM +0200, Francesco Poli (wintermute) wrote:
> One of the most typical use cases of the 'cpupower' utility works as
> follows: run 'cpupower' at boot with the desired command-line options
> and then forget about it.
> 
> Add a systemd service (disabled by default) that automates this use
> case (for environments where the initialization system is 'systemd'),
> by running 'cpupower' at boot with the settings read from a default
> configuration file.
> 
> The systemd service, the associated support script and the
> corresponding default configuration file are derived from what is
> provided by the Arch Linux package (under "GPL-2.0-or-later" terms),
> modernized and enhanced in various ways (the script has also been
> checked with 'shellcheck').
> 
> Link: https://gitlab.archlinux.org/archlinux/packaging/packages/linux-tools/-/tree/dd2e2a311e05413d0d87a0346ffce8c7e98d6d2b
> 
> Signed-off-by: Francesco Poli (wintermute) <invernomuto@paranoici.org>

Tested by installing the new systemd files, amending the
cpupower.default file and trying out the governor and frequency options.
I did encounter the systemd service exiting on boot after setting
performance options. The service set my options mostly correctly; my
machine has a limited number of cpu governors. This may have been my error and
I will need to test more when I have time.

Adding my tags.

Reviewed-by: John B. Wyatt IV <jwyatt@redhat.com>
Reviewed-by: John B. Wyatt IV <sageofredondo@gmail.com>
Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


