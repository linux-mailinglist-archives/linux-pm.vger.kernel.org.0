Return-Path: <linux-pm+bounces-31703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E7B17546
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 18:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A61584138
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8BE23E329;
	Thu, 31 Jul 2025 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TfiIr0R0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC923AB85
	for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980725; cv=none; b=q1SupkRVZ1fUdP93HzNa/qPekVUatwhAI2tz8S7aIg4ZY+GvReHHi0KsTEeA86sjsQ1NB7GNDvyRobD35cdycb9ODqXDkXfE82Qnu0dNvbYv+IgDgHs1nCgDXtVzmwS3KdzrR1UZw6rShJSteukm3XNyiEzoAW7ac22GWYyZrCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980725; c=relaxed/simple;
	bh=X4whMG41aO7BZzSGFF9lLvZmt1LeyhS4Bg583nr5ybY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oy+rPmdoCDolExs7OwxWx38bsfuFfvWhD1E5UTPl002Q2K7UrGXAvECioiT2B6kB77NaBOZiQ3wPyBhe0DAHnEGB9xCdAapE46NxovBUjiEWwPP/FjGGA4gQqXmI5MiMOt/QlCccfKMqbWMl7nSGiZzw0YK2r2cJ6FuuxacUTCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfiIr0R0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso11771cf.0
        for <linux-pm@vger.kernel.org>; Thu, 31 Jul 2025 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753980723; x=1754585523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X4whMG41aO7BZzSGFF9lLvZmt1LeyhS4Bg583nr5ybY=;
        b=TfiIr0R0m3y9Gqmp2iz/+j/rtLe00hmfxElobXEz1iwORaGNJRKLUDAfnh+co/QQPS
         1XjYfyqz4S2kXIrT9AOYU8sxgKCf6WCHgBr9ZabivhzbFAruKZ4e1Wepm3BrAv6jAZBb
         K2lF55YQKuGP+v0oRmxgNvwtfd4OlUTL5y18OPBScdQXO8lPH8R/bInZaf+IiNg7Peh4
         SWHsFdH0tcSwStsa1Zt2XSnAGhkuhCJa1iUiE4Kv3sGt739RPYJ44240D9e/jdRDB8Qf
         0hAoH4peImgdUFEQwObsSYZKGjFO7Lo7DupFiWkcbo98H4JoEXoSiNS3MXfhY20/Uvyl
         +TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753980723; x=1754585523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4whMG41aO7BZzSGFF9lLvZmt1LeyhS4Bg583nr5ybY=;
        b=VbSTEWFVbtR6hWWP6UBB1cZhwko6m1Rl+TGadoBHA35/wNLwpg35EUR2SKotXON3L9
         Imn+Y6qUn87/kLgOjuWUDhhryXjDa3NW+nPQjOxRci5LOnF/XpUBum9P4Zg9O9z+nZ3j
         MNXsXvU/JNPZse/aCvLeHjQ4M8p0SvQu48ZuSNbRyx1uCZmYLGnZx1y9vwN2wlfv8Sjb
         hmnO+wo+6tDfeTe8uOLX9oeOpgVFlf6Ba9iZyD6nBVUkGhb/RgNW4KcWzH6BZNZqJ4Y3
         J130X8pajJaTRazBTUshwfc04twpfRbKGY5viS4Z3evMRkQxlqDrRvEiRw8umN1FAARC
         3taA==
X-Forwarded-Encrypted: i=1; AJvYcCWxVPnBuHu1SqB9oBqpaLSR34cWvMRQiGnOAcwW2AOJlrMcuKzjBVQjJFqu4PQMWYXH4knarEdR1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+y804n/9Ii20SF43NfY5f2ziBb1oQftF6vMHOn2CmVsNI6Wx
	TThPFDFKT349HlYsj4B7JpsfipixZVxvvAzmlsi16hQnOaf+n2w+EoBz7RUD49iKFhxVZixVqhX
	AAFKyrPkHg8bVUykLaWaz5pAhXjbEIjEyet3mfU6G
X-Gm-Gg: ASbGncs2JKfbCX8f9LEG46bczLvXXD1KWKftb8ImF/XSrJGnRr51mGlpPwIHTKvpE2P
	/KiBo8NVVHBZDvI112B4r7Hxgd1KRwoFrJhReMUUqzGyQxMy+hNo4AxNtohG3Q3AgKFwiD7SFVL
	rY9oyxxvVJJgVl2tbhKkDKlg4G7fAlVqa7NLXvNqGXP7kPJhu87GQxR+pUJYNx8oPBGtfbpkf/A
	C+pBw==
X-Google-Smtp-Source: AGHT+IGN5lesuD5vZ9hJy4iWUm0qVDfzyxMgkYnG2C5RbaNfFCJP80GSSUgSyAFkVYfgP0uyG5JwLOkNqyZjNKyPcfE=
X-Received: by 2002:a05:622a:cb:b0:497:75b6:e542 with SMTP id
 d75a77b69052e-4aeefcc7238mr3697971cf.10.1753980722713; Thu, 31 Jul 2025
 09:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGuGLu2u7iKxR3ul@arm.com> <CAFivqmJL90xsELhz4tPtkYA9vMzS9C=V__nwo=kWJKjKS=mE_Q@mail.gmail.com>
 <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
 <aHTOSyhwIAaW_1m1@arm.com> <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7> <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com> <aIso4kLtChiQkBjH@arm.com>
In-Reply-To: <aIso4kLtChiQkBjH@arm.com>
From: Prashant Malani <pmalani@google.com>
Date: Thu, 31 Jul 2025 09:51:51 -0700
X-Gm-Features: Ac12FXwKWriH__Xxhuchhq00MXrNkVQyag4R9Ex-pnrD9Hv-p1AJuNiayQaotss
Message-ID: <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Beata Michalska <beata.michalska@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"

HI Beata,

On Thu, 31 Jul 2025 at 01:27, Beata Michalska <beata.michalska@arm.com> wrote:
> In the meantime I'm still trying to figure out smht to mitigate the issues with
> the numbers we get from counters after waking up the CPU.

My attempt at that is here: [1]
It's been proposed before, but it's increasing the delay between samples.

[1] https://lore.kernel.org/linux-pm/20250730220812.53098-1-pmalani@google.com/

BR,

-Prashant

