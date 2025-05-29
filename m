Return-Path: <linux-pm+bounces-27807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFACCAC7D5A
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 13:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BF01C01A8C
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 11:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7805A223716;
	Thu, 29 May 2025 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3++koYs"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E522370F
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748519293; cv=none; b=c4nVtr78bYk+d8adXLJeQUkM9Kx0jfNGgiVGy1Q6+0oUiuqwABHdAolMry0ztL1d+/pLcYx6cASkd7Qbz3STxXPHIpK/T1ErmWgnI62MV296CfQHvZWlZRxnIZOKQZ+EvEwo/S7WzodaF00w62aSVkUsupea+752Rko6mjIt2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748519293; c=relaxed/simple;
	bh=v3hY30nRmImnHwGi0UTTlXOgANRkQjAhzdIRchakAbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INL4Sl0bxYz0kXZJLJU5VzzRhA6ndCJY6OD1Nedmj6ckMdeXR8vBe1SryfUaj6eiU0CyisV4O+pvGNq3jw25dOvYkfQ6faMOQ1aMWuKrnwZytm5ChyQDgUtnkNzqI7WFOFEs+ZGLdbxNlE5NB2+z2sg3/RU2z0ayOY4PksDfs/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3++koYs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748519290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S4FAuUtIwDWMT4NYmHX6VvziC3AQhYiVZgYgYuZl1oc=;
	b=G3++koYsgMv4aQRDVvKqfvipNt94aO57D3OLFmITCQ8g95I+f6VrCr2GeOVePSLdfl4VYM
	SO5t1PriXD1Zx/WJ3sgzBhtXvX6UvXaZFqlHoj6WcaeDhQVjr3x2+xMUNj4aNVZL8x4VY2
	nMIlk5/8JCtBffoFNLgNk5oo0vGgDHc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-LwtboIH7P5yTMq-flu5YrQ-1; Thu, 29 May 2025 07:48:09 -0400
X-MC-Unique: LwtboIH7P5yTMq-flu5YrQ-1
X-Mimecast-MFC-AGG-ID: LwtboIH7P5yTMq-flu5YrQ_1748519289
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d0981315c8so94409585a.0
        for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 04:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748519289; x=1749124089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4FAuUtIwDWMT4NYmHX6VvziC3AQhYiVZgYgYuZl1oc=;
        b=rmbAEoBm46o0KXBwd/IgO0C+GKHvKyEygAyxx7rjEWoS0ODSSf/hhAiaRffweyMKiC
         jCbDUb35u6XbVr7FZDCvpf4BteoqDM6TrqWj6uFRFa2X/MLk/G5qfOjm/yhSeSKh98xO
         CkzbyCK2lyhBXMZyXwz7sY//lGVzvriHuHgRAC/H6psJb3qzweZSJ7zzAIPjJdaXAgvx
         ImQuPpBRZ4+N3NR6jv/PAdhtuyqIp/3YRAtueXwR8mEUC2JZfUwRTcZA+lelYCzUVV1g
         WKF1tGSGG0L4dolH6AhILeS4W1pJvFdW6Hm1wSHGEb5CYfSyh4OrR4v8MgM7skFwXAdq
         j1LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZrdA/Qza6EbSBEiNKmdEBjMDdVFUxzJgWC3jEZNUFhmv2lx8srLG1rAXlMIih7xpZs4LcKrdHgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxClTCGx+7x3u8Qa0AYb0Mb3PvWj5nH9h+VCPw8f88HW9orlLXj
	TdoCvJIRqM+8+oCVVtzjHyouRwi9BthWtp28mjnQbM3m1PeXvi9V43Dw8QcD8zmHIwzKVhQlPEd
	Em92cOporwRcE/S1GvuawPYppSIt2/sJZIgSFBXNNWHcB0oMj8GhkiSgzPjBjowXoR6YVJDw=
X-Gm-Gg: ASbGncv37FQ7HTWmkU/wTQjFvOVB981uTuXTGsguSASugLIzgUu+9tR8k+zGCxVEw5Z
	aYp21XPijmto1lG6RSvL7fKPehJSadTvN9WGkNxM6yTeLw9/G2Bh8ld+Up/m1KUlL8RplapmSgi
	IhKncltfZ+JF10PoRcpVGNJtHcrL8k33v3vGOXKbkRqtRiNSQguEZ5zEM+TM84qXoBsEc83365M
	5/vYTkk85A5w4Pwx1kothc6BjcCDcOmC2VqoLQZxXgk10X3JP4jnV2J90owS/qlubgQdytSlDhV
	TaXcvRc=
X-Received: by 2002:a05:620a:3723:b0:7ca:f40c:c1c6 with SMTP id af79cd13be357-7ceecbe0761mr3449460985a.44.1748519288726;
        Thu, 29 May 2025 04:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGz1jWGH1Xl1+iHv8W7jy7T3u04fgOFgKY4M/nMJaXF++uobBUOQZcZvHceBp3q+sYifPF9g==
X-Received: by 2002:a05:620a:3723:b0:7ca:f40c:c1c6 with SMTP id af79cd13be357-7ceecbe0761mr3449457085a.44.1748519288338;
        Thu, 29 May 2025 04:48:08 -0700 (PDT)
Received: from thinkpad2024 ([71.217.74.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a10ed2asm83898485a.53.2025.05.29.04.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 04:48:06 -0700 (PDT)
Date: Thu, 29 May 2025 07:48:05 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shinji Nomoto <fj5851bi@fujitsu.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] cpupower: Allow control of boost feature on non-x86
 based systems with boost support.
Message-ID: <aDhJdTWzDihchywc@thinkpad2024>
References: <20250522061122.2149188-1-fj5851bi@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522061122.2149188-1-fj5851bi@fujitsu.com>

Hello Shinji, ty for your patch.

On Thu, May 22, 2025 at 03:10:57PM +0900, Shinji Nomoto wrote:
> The cpufreq subsystem has a generic sysfs interface for controlling boost
> (/sys/devices/system/cpu/cpufreq/boost).
> The sysfs interface can be used to enable boost control from the cpupower
> command on non-x86 platforms as well. So, allow boost controlling on
> non-x86 system if boost sysfs file exists.

Did you test this on non-x86 systems? If so, would you please provide
details on those architectures and systems?

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


