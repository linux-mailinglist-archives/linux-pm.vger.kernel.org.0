Return-Path: <linux-pm+bounces-26093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F78A9A30E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 09:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402473AC9F5
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 07:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEF61F1520;
	Thu, 24 Apr 2025 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TssHAO+Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A91E8837
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478908; cv=none; b=fKDRO+Xkkga0EQ1VcTL8MTQwye+iHonAcxUW20+YT88WEOfqDramqlRcCj4z2KGoAYN/tj/Va0kJsrYXlOyh5iXOukZLglbE/S6fJjVt3gnmRBFAuVMoWBq9zLvsLw2lOx5f+Che0VJhLqgit4UwbqE8d1s0P/WNLXgKGO8hYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478908; c=relaxed/simple;
	bh=HLF6aCv6C5wEiEROOgDMQe1Qv0eWgRpHCqlfkMScl2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYo2ucQzHuKyxZhn2xr2Je9y1mI+X0T4qWL+xbxFfC5+2NSOn1seoVnEylQ+3wWrCcso7J1o0VNI7dnhf17S55ay4STh2qQg5i6jRBGyYn7/D133EMMtMrSh/73uZ9Xqb5oe1+uW1NESYJjlR+o574SgLzbwRgEG0XOIrROW7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TssHAO+Y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c33e4fdb8so6599285ad.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 00:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745478906; x=1746083706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4hIW6QfieiutszXA0t3nPv2ey02o7qfmGs6Yu69D7U=;
        b=TssHAO+Yp3AwbOyRs8yXet7o+JeUsxAibiR0+TPvxmwMCsjku9/L0fTRXiEQggaPPq
         Uu3I34TibIyvkn9dOrk6anPVh4U9Df8DyFKozDLnevQs/75c86Fe6tXstL/BJb/iPz44
         Zk+eA/J1qu9NUEpdczNXrQYTXza3618Iz3vT5CVPpw1GQKNk9etnmMuBeP7a58ni5Dby
         JLpSSwHpaU4K+5VZY3i+vBvv05VhETzA6Yon3uI3Jpo4XsJTK+JR0HsTtbwlTsw8r5Mj
         2DlZel958CQU5c/zfEkdGkz6GBEgvUBNeY8AwBC0PY1fX9+eTx0CxFNh+XEWImFYFAPu
         vMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745478906; x=1746083706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4hIW6QfieiutszXA0t3nPv2ey02o7qfmGs6Yu69D7U=;
        b=AV8Wmq8aGbOkXKEXzqXoH3YP69jZ5IdOrnVJQrbIxLxAqW38OPM3moZnNwH5Mv7Cqq
         ilf+PC0xjJwUfPen0NFUAoUq+6orgPopd14HLVdyy3OODtuyPF7XwZLLg+SctkLv1VaP
         /urBEYUZ+ASZVlBDnmEH9mQhkHGxbygsURIpxXr4Qh1OWBLevZK8Ajnio7knR379VyAP
         b9l2ml6KNIntPNARgZvqNOCzpnJtNNE0ZSdjJHvygTDyYizOiPOyuoP3D7EdmqJqQTeB
         Dffwc4eCDo/H3uTJKy7vtbQnTRNblhkh/Rya5G8oDKiGfsrX3sGnQCT8SCFx1b0GQGx0
         G1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHkqWFBXyzLbvY1F1Vq2UH3vZ3NHUXvIEweGKgEI+U+NZdjzokB0RCH3pEIBz/Bfti+0UC7O1fHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWqyPT+XPMmRNX2jwCAa5C3++j/05eJrnWI72v833442Hb33fr
	9csd8Ru+VIdL4NYpSHnqCcOEHg0Ot2icFvVn+9wo+wetRZW2XywYUMykawSsI6E=
X-Gm-Gg: ASbGnctB6tZaHjpb3EB3/ekCOU89XW9NxVqIZ8qtAcVIuratHwwqpqiq1OQ+h+gvSLt
	FduRdurFEs/Zeqcuq48nUzKNhfgvXioGcZu7VDsIyBp1c8OSPNqzAN6aNSKNmP8OYxWMgbUBpB6
	ppTjO2StPjccTA7bIvyMIv5cAS08Fnq91SIM1eOsD8U/XbQ/wlwWmKoXgtEbL+UWcHBHuNSJAOD
	6NiptbTRUy8qd9Hl4A617EAItzrs3RjOXVI4EC1s+cv6a4N3eR0tmsdoh7QS/wZoTSZcGznlvTu
	p2zO2YbqjtQqnSr84+HuUrrNlE1OcJ41EBX5Qx3eh+MGKpxryZLz
X-Google-Smtp-Source: AGHT+IFUA3CFU1cnWJg1SQjByjtnMsCuSRrIGtPclWuY/yN5NfiaQKwIcJo9x+tWDpK+DYGspM41Mw==
X-Received: by 2002:a17:902:db05:b0:224:249f:9734 with SMTP id d9443c01a7336-22db3bd4cd5mr23000755ad.4.1745478906561;
        Thu, 24 Apr 2025 00:15:06 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db510219bsm6148735ad.165.2025.04.24.00.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:15:05 -0700 (PDT)
Date: Thu, 24 Apr 2025 12:45:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] cpufreq: acpi: Don't enable boost on policy exit
Message-ID: <20250424071503.2uhc4k3jxy7x5mo2@vireshk-i7>
References: <cover.1745315548.git.viresh.kumar@linaro.org>
 <7ce4ffb166beef83cf1bd703a41bf91622011585.1745315548.git.viresh.kumar@linaro.org>
 <CAJZ5v0iCrQeKs=4S-x83Fgf-W4u=2JYLA5VmgKPaLCvYAkNpig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iCrQeKs=4S-x83Fgf-W4u=2JYLA5VmgKPaLCvYAkNpig@mail.gmail.com>

On 23-04-25, 16:14, Rafael J. Wysocki wrote:
> Even after commit 2b16c631832d, the code removed by this patch does a
> useful thing.  Namely, it clears the boost-disable bit in the MSR so
> that the offline CPU doesn't prevent online CPUs from getting the
> boost (in case the boost settings change after it has been taken
> offline).

I didn't understand this part earlier (and even now). How does a CPU
with boost-disabled, prevents others from boosting ? I have tried
looking at git logs, and still don't understand it :(

Also, IIUC this and the boost-enabling at init() only happens for one
CPU in a policy, as init() and exit() are only called for the first
and last CPU of a policy. So if a policy has multiple CPUs, we aren't
touching boost states of other CPUs at init/exit.

And yes, this patch isn't mandatory at all for the 

> Moreover, without the $subject patch, the change made by the next one
> will cause the boost setting in the MSR to get back in sync with
> policy->boost_enabled during online AFAICS, so why exactly is the
> $subject patch needed?

Right, this is merely a cleanup patch and isn't really required for
the next patch to make it work.

-- 
viresh

