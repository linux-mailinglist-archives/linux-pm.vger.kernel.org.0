Return-Path: <linux-pm+bounces-32162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1AFB206B4
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 13:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0EF18C10A7
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 11:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F228935C;
	Mon, 11 Aug 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fyfqeBAd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8D26B759
	for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909924; cv=none; b=brngHegeYI7QG6wHZKmhaF2Fdsv6Od1f4SkMdBcaZg4uZR1xJofuIQ8JLcU0/gXPkrbbloSHri0aX0DFqfMSXgHsA/Vrf5Vmf9jL4tBPTzZMdFW2onxKNoiKr6DerRPssSWqEH1VP0xcumugMm8VEDxdqJUexItxBue4p6fGitw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909924; c=relaxed/simple;
	bh=fK4jfWxAxG8hhrtguRsi7TtKPjAL7Pn0DSb61hYO1/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+c9D8LQNPeu1IcnP0uR/vBY8dJ09X/v5+JVbi9mc+nnTSTTpLkxn2Amn35vw5S5tYOI4QuJg0kTsQpdvJUBr94x7eQ+lKc54E5X/WTKXes8HTNzibThlu21vkbK/NFTgi4DQ9o0nCiU0PGfIxv+W9k8HYX+gd+m0V1vL7pg8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fyfqeBAd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a0d5e4c45so2699805e9.3
        for <linux-pm@vger.kernel.org>; Mon, 11 Aug 2025 03:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754909921; x=1755514721; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2eDfsoEqJXD8CkPjgI5wPgXdl/c/jHhszq1yFHNlj5s=;
        b=fyfqeBAdLauFQlbJ5kIubn3oekJOKh17SaO+8Gyc7rdnhzE94ts9jzCnxmT8dhWmyK
         d+pmOLv4nAWXBiVZEUDPudcHVWhYfSxa+xXCbDJUkaTkhoA9CLtyJ4dA7JVPzfdXvjYg
         gLVuLIYBYXWUlZoknVTMq3uCLlxiQUJMBAwIxCAlpEJukSMgRg+m2sFaRvXF8K8To75K
         ZrlrlSJRXkIME54dny/jdnGbDwFhqQhM1TeULiRDI2+YII4nYeIdJC74dR14gKEAz3UV
         PHLhfrksSnDD57zMZSF/zJsievt3ThOZH6IbqXncG+VLMfpdUDnDkLLwAapWZCG3M6sx
         WtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909921; x=1755514721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eDfsoEqJXD8CkPjgI5wPgXdl/c/jHhszq1yFHNlj5s=;
        b=H5kXDG2qMh3kft3s+snIsdRz25Move0ZrRtVvSqNVpmlXRrWQE+Vn3IhNFaMgDcenv
         F6CVYhDGrlOl2d/R5X5880RhYB1aEFiaq/Bfrnyhq/jQG/iEZUou27M/PvbUivaUAmTV
         afI+eQwC+N2XwMz/b9Onda0+xU0e5UKvI+Yj9gQX0m8vrqF3Ah8cZaohCvXpTCOl3df3
         5hgQSDKoNf1j3gkbKZiKxn4BQkYkpxio4LpRVH0zFq8lhjyv9LlZg3TT8Hfh+xIGtTjO
         ECEu2qCaWRSRIES8khFq2BOLvMVRcEimbKIX7Qm2zkJ16D5N/TZi7uBtotCD9OYix/d4
         ZHpg==
X-Forwarded-Encrypted: i=1; AJvYcCW/TccUaHqg2TasLVsgGNknE5r7j7w5HLQKyOgWIHIcgsumYgLzUhtL5iy34PHXaWiSaYEEWJxrVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKeqpX0NdypICm3rJzgiA70M6tL8O1WbjPrZyu2B39NRJ9u1JK
	QriQ8eY2BEP2gkOzrYS/lbqxo6X2khd3Y9TnnvUisTrTGgdxcLwmcxN25f/CoqupOjI=
X-Gm-Gg: ASbGnct0BcI/nE3pRsjV0PhD5Z/f+AooOfWGtIKQCNZO/4BH+Nx/hY1t2aWvrymRwN9
	f1febjjtWmo/zQdmmAQwvOv0/bxsGiGyziy+fetnrDnXn20H6XhBpV7zaSErjTTEV2bWmeuatq5
	V1sPhWuVN1WMz3NqOURsg6FX5ddz8XAzmqfpHdnwBfvGCcglXI9LEiLNVo46MAtdbWWHQQDo9eS
	MwslN3CoorejMITctX4RhJCE1RXHUIw/ScN37yfQ6yJ1+kYJtJe+//WT2Fe9kKPXnGB/JTXnTcI
	LI/V6IpiXIyttriimRhvNb4dAgvhgYoGNfbkCkbakNlmzNzpOEo0bPXt/EUCSTLFknSomDI6hBd
	vY6pQKDbwMe9/BiDjRIo/iR/RDAhI95/X
X-Google-Smtp-Source: AGHT+IFbmWJMYJQaNs4CcNQms0cyi9FBgsOYAQyUhMd4iBen9JAGKCb/WkfFa3wB/d3Zu4x8mcv7UA==
X-Received: by 2002:a05:600c:5254:b0:456:13d8:d141 with SMTP id 5b1f17b1804b1-459f4f282damr96805005e9.27.1754909920821;
        Mon, 11 Aug 2025 03:58:40 -0700 (PDT)
Received: from localhost (109-81-30-31.rct.o2.cz. [109.81.30.31])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c48105csm40496846f8f.64.2025.08.11.03.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:58:40 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:58:39 +0200
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
Message-ID: <aJnM32xKq0FOWBzw@tiehlicka>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
 <aJSpTpB9_jijiO6m@tiehlicka>
 <4c46250f-eb0f-4e12-8951-89431c195b46@kylinos.cn>
 <aJWglTo1xpXXEqEM@tiehlicka>
 <ba9c23c4-cd95-4dba-9359-61565195d7be@kylinos.cn>
 <aJW8NLPxGOOkyCfB@tiehlicka>
 <09df0911-9421-40af-8296-de1383be1c58@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09df0911-9421-40af-8296-de1383be1c58@kylinos.cn>

On Mon 11-08-25 17:13:43, Zihuan Zhang wrote:
> 
> 在 2025/8/8 16:58, Michal Hocko 写道:
[...]
> > Also the interface seems to be really coarse grained and it can easily
> > turn out insufficient for other usecases while it is not entirely clear
> > to me how this could be extended for those.
>  We recognize that the current interface is relatively coarse-grained and
> may not be sufficient for all scenarios. The present implementation is a
> basic version.
> 
> Our plan is to introduce a classification-based mechanism that assigns
> different freeze priorities according to process categories. For example,
> filesystem and graphics-related processes will be given higher default
> freeze priority, as they are critical in the freezing workflow. This
> classification approach helps target important processes more precisely.
> 
> However, this requires further testing and refinement before full
> deployment. We believe this incremental, category-based design will make the
> mechanism more effective and adaptable over time while keeping it
> manageable.

Unless there is a clear path for a more extendable interface then
introducing this one is a no-go. We do not want to grow different ways
to establish freezing policies.

But much more fundamentally. So far I haven't really seen any argument
why different priorities help with the underlying problem other than the
timing might be slightly different if you change the order of freezing.
This to me sounds like the proposed scheme mostly works around the
problem you are seeing and as such is not a really good candidate to be
merged as a long term solution. Not to mention with a user API that
needs to be maintained for ever.

So NAK from me on the interface.

> > I believe it would be more useful to find sources of those freezer
> > blockers and try to address those. Making more blocked tasks
> > __set_task_frozen compatible sounds like a general improvement in
> > itself.
> 
> we have already identified some causes of D-state tasks, many of which are
> related to the filesystem. On some systems, certain processes frequently
> execute ext4_sync_file, and under contention this can lead to D-state tasks.

Please work with maintainers of those subsystems to find proper
solutions.

-- 
Michal Hocko
SUSE Labs

