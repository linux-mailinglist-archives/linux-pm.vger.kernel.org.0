Return-Path: <linux-pm+bounces-41210-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKV5BFZpcGkVXwAAu9opvQ
	(envelope-from <linux-pm+bounces-41210-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 06:51:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52D51B6F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 06:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 741FA48624D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 05:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFFA410D22;
	Wed, 21 Jan 2026 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wM0dQ12I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56433793A7
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 05:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974667; cv=none; b=VcywYUggLta8UYGimvAp1VPGeOkuUJDaplAtAlMrj0EBZZwIy5o/2JhdMaj7AzmNIU0Dy3hTV4EIXEUwTYlcMfNxTCNs3TzhFRcZFng0yBNyby/616xkzcihTkSvy81p5tmTYauRB1dMGxTGI2kA+Oxn/J+LbkrXGpU4lj4a4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974667; c=relaxed/simple;
	bh=lApbjY1oggBMkhHnN4eucCGGRbKTZP6/hKGSm+Y9lb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtDUpOiA9Y40WnKBu6BhoTdwjTrxc6IwUCrX5IaClR2D5/0ErqB9Zxlgmi0fdHs5Ra93SJn35VwK0bmrmCqvfvuHMW1JBmePO35WeLfhWWLBvbgE+Kxk1OeHnZ8xhN70kw18mHbxiiUZdzVNPJ/IlILALazlCbPdRhmhSO8nwvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wM0dQ12I; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81e9d0cd082so4796916b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 21:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768974664; x=1769579464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQupNyyJzXVmPDVjOxDa6EgZN5djksw+64HreMgPYBk=;
        b=wM0dQ12IhppkU/GDXYt3/aPrBVuB0sBqibKwdvCyEr3nlc2CjZWQRQqTjVy6TxxBp/
         nKhiO6qy0ed5ta896tvA8aHYNA2mYQr5iolrHeM5krxJ8F0xeW0IHwKANhkS+BBMEOsF
         Opl4w0nygGWoPNkTg/EqnZAvzUlS2RlakxVQUxkaH2lZ9nlBfzxKZckku5hgwVe/Pt3E
         I0mRjRy+T7Ow7mRFnARh6ye2pxUI+TkkK4CYH+tE1EiiXkSPH7jEmSKzX552TmKUeVmP
         GPHxkPHGHD62ohOYFFuPGU4XBK/n/v2lT/dyMWRit0xnfXhltBWEsNshWb79tBJQYJ9K
         daEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768974664; x=1769579464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQupNyyJzXVmPDVjOxDa6EgZN5djksw+64HreMgPYBk=;
        b=wNT6bOPnviHUvHNYB7FYW3yc8ZQBPFz0CszspqnQggslao1rq+TUhZRf/nlV4HkxyZ
         eRE8SPXubOSqYCJRVugLwb+QMT0UaYfB7L7odp5WR9Qb2RJg56K/16f+DzuC7NAxNRYQ
         k3gf5y6wyEigvC1jvJhqWIA4OJGYQ8RpQit8QnR5nVGnS5zYXgZrBQseADSVbOcgjmnc
         ZFhnUIlY9dK5mgLNPIyGR2BXwCy7Ww6Q9ITdDjf3jK2miFmCY7J12vLgOjU/tpFhZOtK
         EmFip5viBNQwSVPr3h2a8eBAwhEzt2Um4BiXutLXlzNg4fhWCl8ztHREQ/4IylTEtMVo
         hLbw==
X-Forwarded-Encrypted: i=1; AJvYcCUdX/4FRKfTnRO2JohSfKAPgLGPPk6RgnarvnIr/l8O3DJGTZM5s1o51HV8gCq4+Q9A4D/+FOea5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfi4mRpTQAJmTkwx0aErgGf+CsD6VcvEE9zSUD4TiYynyOwuJt
	4sVKBjxRm7eZdyZkwpwirQpePmPiTrwJdNFVNUdnSBhpOxrDzzH7f8qHkooum/bfRxQ=
X-Gm-Gg: AZuq6aLVvs0iSDVg9YONBUW9s2nxP7ddHS9rdWvjOwesfPYiKqC7G3ps51OBUHTXYXc
	5s2UanTVzplYQuJ1Ywcm5kZd5irF+U2C2se0vlOVsZzTaxvaSxQTwk7PA0fW0EV00PlqGqiLQUI
	sML5n/mAMu7QxUVm/a3aC5Q0wMTtOZu9nU/hMnxVF+CpcKcxd78Y03U8/1LH5AX/MTBK8mHBKL8
	2DiYcqRWEVH0kllQkUucAsj26PsLyF//l6AYwXJiikzzyF00J9UdAskm4Mlh3YBL3NpV8PkN6g2
	6gCjEKKF5mZ6rGIQJ96loAdXgssTafTK40b8DCOMgf85Ec2xAmWGIWu9yMNVEcHbnE/WdFFsZ6I
	V9VLQJv5Qm5WZw1UTfildISaqiM+NmViHorswvcy+LsJxBJfcXO+lRsmIazsP29egcki2dgNXXZ
	dB5zZgmxJwvmJNTPBeZc+1Ig==
X-Received: by 2002:a05:6a00:852:b0:81f:3957:2772 with SMTP id d2e1a72fcca58-81fa17812bemr13464996b3a.3.1768974663648;
        Tue, 20 Jan 2026 21:51:03 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa108c51dsm13772302b3a.14.2026.01.20.21.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:51:02 -0800 (PST)
Date: Wed, 21 Jan 2026 11:21:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com, 
	LindaChai@zhaoxin.com
Subject: Re: [PATCH] cpufreq: Add CPU frequency policy change notification
 support
Message-ID: <pdp3oabac4g6bakm46w5wj7edl446dqhggdfrlke55gniuju5b@jzodjar7tc2e>
References: <20260120092445.5711-1-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120092445.5711-1-TonyWWang-oc@zhaoxin.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_FROM(0.00)[bounces-41210-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2C52D51B6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 20-01-26, 17:24, Tony W Wang-oc wrote:
> Implemented CPUFREQ_CHANGE_POLICY notification in cpufreq subsystem.
> This enhancement allows kernel modules to be notified when a CPU frequency
> policy is modified, facilitating more integrated system management.
> The notification is dispatched after a successful governor switch during
> policy updates.
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 ++
>  include/linux/cpufreq.h   | 1 +
>  2 files changed, 3 insertions(+)

Who is using this stuff ? Please explain why you need this and how you
are going to use it. I don't think it is a great idea, but I still
want to see what you are doing in the first place.

-- 
viresh

