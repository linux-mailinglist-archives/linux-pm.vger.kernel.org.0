Return-Path: <linux-pm+bounces-18314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7409DF9CA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 05:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7908B16275F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 04:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6DB1D356F;
	Mon,  2 Dec 2024 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KCwUc3i0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE386EC4
	for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2024 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733112637; cv=none; b=VHj9lfRFLHrc1jxOXuXLhnWhDIE8z67Fabgkxv+ekS+gGCkfXbzCGG2yBkgsKEcZkv0QjSk1tn5UhIWMnOfDPvfuTNdb94L6y6ilPtqOwHb3Oocy8hSoAJjUEi4xYKkp3zcnwDVUOlgdeyOC/oUjEaru7ZJGPjP7FsDgFz9NkGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733112637; c=relaxed/simple;
	bh=vMWGWHg/et5CqkIdQLtUU5ObJLzO5NosJVeARTBqbag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uttmwql98aXrGkBmmk5xiCzc23GW1dJBlHx75q9s1HpveReL1uOUO1J6A5Ld/0NuETFb4v0aeW6zDu7pNDgXYsDLcahr8ESPszdsAm+C6B87azn/MGTS3a7qL9TUnYRokJ4vGR6GR7tPklexG7cZdU1aiarTGVSbvrjfnfdIgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KCwUc3i0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7251abe0e69so3108432b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Dec 2024 20:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733112635; x=1733717435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=76F7lD0eouVg6d3auGQDcfuDktfWQWRUnQNVSJA2ubk=;
        b=KCwUc3i03mNYEK0a5dofjhlYqiVD5sd7+Mqn7AgpUcETYbTWRo7SOsSXUKKxfxx7UJ
         SHyJWF5FvA1vjn7+utOgL9vrKI/9ue+EpkmWsAJ6DA/iGHXGXWfqb0Vp6Aw3tOxcccsi
         lO6o/Y+KgpI184wI77H8nvGxk6ukX6XHInVyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733112635; x=1733717435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76F7lD0eouVg6d3auGQDcfuDktfWQWRUnQNVSJA2ubk=;
        b=baFLuu9QHQp2i6impDDGg/N6VXmvHkFm5S4r5+G5EYKyqWBuVCqpD/N9qhy8kER6O8
         XjNgINujzWX/xPYtf7523gEIpHEl/WTVfcL+SWmSvBXvVMoz3rDre1/y5kfWGMUkH8bE
         E/kLVPwUL8+q2QgzvSdvLQcs6g9ZhKLSh2IvT9EreZb1yRZlj9YnQwzEl6d/Ik/2ZztZ
         MukclU6CWGGAdIEt7OjFrQfh+yBVwbwKqprHWdp6mDqVb6wBpzJduPhoFYt8maZT/OI9
         R1ypLy2VcVgnyBsN/y4aMV/G05YrtiEyOO0UiXJabs/boInzVhBfU+uOGcQ7wBf6yB8m
         uvjA==
X-Forwarded-Encrypted: i=1; AJvYcCWYyyWRQmjOmuqn0vk8F0r/mYio+E1IhoIhLwTZEFV+jx/E0vYmQoyXxjeQlWygGlcCNttR0q8xIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfhTjqbkaGq+P+wkcco/vOUPf1Orb8VbMnghVQiUtJQsJd5T4F
	cCL55k2BNVd52vuN7iXCibQMuJXtd44R5++UNd/0i+K/4/eEu0JMmTTJTRG+pw==
X-Gm-Gg: ASbGncu0saxN1ZfHE8OyAoth9jEw8Qr3cPCGxB2fBgf4Ha0tQ/kdyw9nX/Js37tu1Rb
	G04z3xLxHSiMN9qRLoEynXLxY9OKah+rLdT8tGYVmEpInWU7k/93OBXOtFNNGiXhw3tcCRekf8r
	5wxYCUgOYFhTScZGrYJX64hUHS7IaklT7ufGGGrq+8Q4z87hX+pLuYkkGqYJJjvYjYvQp00lXuU
	Dbhoa9342jRQ1TgVLO+0VPob9CyX36UjKbBYMtz6WvVRVxuUxc8Wg==
X-Google-Smtp-Source: AGHT+IE880m9aaD/PfpcfjpV+6a29yccMszSLvtOM5pzxyZnHHZv7iq/hZ128/DKx4K03e9uIlt/rQ==
X-Received: by 2002:a17:902:ce08:b0:20c:da66:3875 with SMTP id d9443c01a7336-2150175eb06mr346021735ad.24.1733112635088;
        Sun, 01 Dec 2024 20:10:35 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:13dd:b39d:c5ab:31c2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521905f2bsm67078175ad.93.2024.12.01.20.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 20:10:34 -0800 (PST)
Date: Mon, 2 Dec 2024 13:10:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	20241015061522.25288-1-rui.zhang@intel.com,
	Zhang Rui <rui.zhang@intel.com>, hpa@zytor.com,
	peterz@infradead.org, thorsten.blum@toblux.com,
	yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com,
	srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com,
	x86@kernel.org, linux-pm@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] modpost: Add .irqentry.text to OTHER_SECTIONS
Message-ID: <20241202041028.GJ10431@google.com>
References: <20241128111844.GE10431@google.com>
 <87o71xvuf3.ffs@tglx>
 <20241130114549.GI10431@google.com>
 <87iks3wt2t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iks3wt2t.ffs@tglx>

On (24/12/01 12:17), Thomas Gleixner wrote:
> The compiler can fully inline the actual handler function of an interrupt
> entry into the .irqentry.text entry point. If such a function contains an
> access which has an exception table entry, modpost complains about a
> section mismatch:
> 
>   WARNING: vmlinux.o(__ex_table+0x447c): Section mismatch in reference ...
> 
>   The relocation at __ex_table+0x447c references section ".irqentry.text"
>   which is not in the list of authorized sections.
> 
> Add .irqentry.text to OTHER_SECTIONS to cure the issue.

This works.  In fact, this looks like a local fix which we applied
here on our side, but we were very unsure.  Thank you Thomas.

