Return-Path: <linux-pm+bounces-32051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E357B1E2BD
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 09:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07EE6188957B
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 07:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FE0226CFC;
	Fri,  8 Aug 2025 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d8msOVmU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF3221558
	for <linux-pm@vger.kernel.org>; Fri,  8 Aug 2025 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754636444; cv=none; b=cQCYyUvRIx4zJNA31b5nHkdc4/CfE63R9ilmPbwKVj8Ihw/HuBvOeprgePYKxmW3i+KiGNW6dSE8R8wOLpOt4kF8FFIcc5s7M8eTZUIHbZs2/HWYQLUAFSbZ7aNJagBYBjhKcKjAqG+Ytr2I+1gVw7rQFluEoWLV0L/p1adyhHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754636444; c=relaxed/simple;
	bh=EVo3hfbeuPKUpx3HiKtclFoPoJrpFgA+aUM1ynHlZmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av47WZBFPnTSiJUwqMy9WC5kmNfBBzKTAt8s5fc2QvGtG+/RtGANjP0x9I9OES+vJ2DnZlQ7xdmxS8DGwgWxbbHn1iUeFsSV7lU5Srv4RYAIwkHeAkAb5PcsoWJ8YNVJ0QF5F6OYyNx7qDjm3xEdDNIUAm7vq2PfyhF3cLxxWyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d8msOVmU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78310b296so862863f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 08 Aug 2025 00:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754636441; x=1755241241; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pVEu9GErkIXG3eJ2AqWu2ENhgTXDL/O6jQUo/mg7Ei4=;
        b=d8msOVmUPmcg83koC6x68IFpe4d3nQKnCyDM551GtWEz9SYNVh/bjGpPINhEOxTNy1
         tzwX7K/qOqtpOvKY8yKOWjJEnuY7sMrY32JnQ2kt5aOd+fYrn7jH7YQxn1BYMumKtaLL
         GBxqW51MHMS4SmaXVIcSb16g/l2yI+AVCyPJvF3rn6BDWH/XRVIE9EWTiRZvFT49gsrU
         27AyszXmn7V1ViRVpvoVlDub/eI6INVZuLQKO5oeNMJC591byaMkR4TO7ADPCRgJmAHG
         y6QRfld4DeXzIcPtf6P8b3TYAUu++KblKEbJFDWVqBetqJFdbtefjoCDNnX4qLfCZK8i
         pLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754636441; x=1755241241;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVEu9GErkIXG3eJ2AqWu2ENhgTXDL/O6jQUo/mg7Ei4=;
        b=T2iSlOKQWm1yMVHWmQSH+Dq24MQjsW3R+LpmmjWmtlInTbcA9ni1ilJD6iBr4pm0ZU
         DdUhaGbCYHWC2Q+07YwSLh1R+vdcTmWisId2yELuf++m4Nro5KiWm1Mez1DNUCM21oU2
         WxEiR2B2+BoWRlQxscxUtwYefxjoqLUEPsMcwK77niS8gcet3d9mZyw0PVz5RY7qqgRL
         LHVD4qrAz6vkC+r8layaJvIqYxpjz1mGv0k0jXEEy8QHOmdPsKPp9SONFJeH/KHfzI3F
         tVVHKqTw9dHKHrl8NVT77eyLdaseI1V8eXUHoq5sWJEmabGL+DetepXPJ7HSecaJbwON
         y8/A==
X-Forwarded-Encrypted: i=1; AJvYcCVr/wICX95RRJ6MTBXLgYK/+LFrpRxG/7/Q20upW9WVtyyx32YBC9mZ/nEWIiyxcneP+Pqim4dYrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLaXCKI65a0TFCwGVei8gBM9XhuTlJywS1ym3oweuT/sFtQDxj
	kyNBIXHaW2ujr1qj8mUqTXaACgXOSWL/ALQAzCjGfQl1K87/efyG7IQdnY4Zj15mks0=
X-Gm-Gg: ASbGncuWKGRqVDEKmGA5tbTAbjaYHaIK3wflCKlRvF+/bGkevpsnTKcM56ulrqZlsDP
	Wtu1UsL5SGb+lUiV2seGpp4f2nRGOniO+PIRiRKlGk4m76mg4ss2iR0ZFba7vhDslaaAKJFXGT7
	cLh21dsexrQQcu6160IXqZYd+iRj06lFwq9GEUngZZIPjH23DukfK8N9SKhdAO7hMkfjhkEaqDf
	K7Zol87wVn/mnuE+t55b8Duz3RSbue3OuXaLe8sGanVDoUZmuw8xF5m6f2Szef+e5OPqa46uJSW
	B3EwVjm1Bib4X9e5lTr4/7L6U+SuMCXuoUUqJCgAt7xJ3gT1WerNdKgmqYZlqVxBtOQDCjDdY7a
	97jTJDffQIxDmp+yByixAf73KQYCGOp15NPM=
X-Google-Smtp-Source: AGHT+IEJk4yevy9+HAy0KW8ZE8r8h3He+ydCFV/7Q/AXZWGxTkl97mbZhRDgapiuoxoRlq32dlvmJQ==
X-Received: by 2002:a05:6000:400b:b0:3b7:7cb5:a539 with SMTP id ffacd0b85a97d-3b900b2baa8mr1256578f8f.18.1754636438515;
        Fri, 08 Aug 2025 00:00:38 -0700 (PDT)
Received: from localhost (109-81-80-221.rct.o2.cz. [109.81.80.221])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e586a011sm133293865e9.19.2025.08.08.00.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 00:00:38 -0700 (PDT)
Date: Fri, 8 Aug 2025 09:00:37 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nico Pache <npache@redhat.com>, xu xin <xu.xin16@zte.com.cn>,
	wangfushuai <wangfushuai@baidu.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Adrian Ratiu <adrian.ratiu@collabora.com>, linux-pm@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] freezer: Introduce freeze priority model to
 address process dependency issues
Message-ID: <aJWglTo1xpXXEqEM@tiehlicka>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
 <aJSpTpB9_jijiO6m@tiehlicka>
 <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>

On Fri 08-08-25 09:13:30, Zihuan Zhang wrote:
[...]
> However, in practice, we’ve observed cases where tasks appear stuck in
> uninterruptible sleep (D state) during the freeze phase  — and thus cannot
> respond to signals or enter the refrigerator. These tasks are technically
> TASK_FREEZABLE, but due to the nature of their sleep state, they don’t
> freeze promptly, and may require multiple retry rounds, or cause the entire
> suspend to fail.

Right, but that is an inherent problem of the freezer implemenatation.
It is not really clear to me how priorities or layers improve on that.
Could you please elaborate on that?
-- 
Michal Hocko
SUSE Labs

