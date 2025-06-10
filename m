Return-Path: <linux-pm+bounces-28407-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E009AD42A1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 21:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D57117C178
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 19:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C86E262FC1;
	Tue, 10 Jun 2025 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnlCVlSD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549DD2620D1;
	Tue, 10 Jun 2025 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582674; cv=none; b=lpBNqDwd9yXXhNQG/V9sB+nK22yWSaqFpTHVPVJfWd+u/gwv5u+MspnzBxlUtWG+UvAupvorILSOdK3WWe45IzksR9n9pqpCYchXZ1m5wM8EIESxxEhBrt2w7rpXpNxwc6aDbKW8eivyW51Snf+pK14R3xPy4qq+Y8wROFY2PXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582674; c=relaxed/simple;
	bh=D0MxIqHjqDa5WdKcOTIT0fZeAlZX1jGhe4KBuMiWp6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHLqGoC4Bh1xAmyEljJrKlSsGGYr8HWIWEJ8p710Rl4HtCrAmBf6MSOYAGvYcVTMX4n94S6QxTkXXIuhT9HUKxzOG1oEmN8DLvzHru4kv6Irmf4ExOADR51eTIhIhudTCe34ljeECJm6sLgMTqt0EteOql5uqmVWJzJAUWqMA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnlCVlSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14F8C4AF0B;
	Tue, 10 Jun 2025 19:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749582674;
	bh=D0MxIqHjqDa5WdKcOTIT0fZeAlZX1jGhe4KBuMiWp6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qnlCVlSD4jiqq9E5Oou5vw25SRekE0i1FZKWC3JBYPJJX4DLNm1u/M8qIvmNLAaAm
	 jM0XLaThf0r+b7w3JGNRqLX+a4gyiFYK3n4d5yNVaHDUTHBQW90y2GsXbS6hPJA9BX
	 2q1vjEfmpLql1+mwX3Hnc9ub3zqNtWhLUzI8mdJJmPwS7aKhK3eL1rlZnZh6gQuKEG
	 MUecHnJZKfkkX7NytWqloVb4FeIXcsGcVLjsSXzV31SQVoyHE6MoDZIqsr2qg/SRkT
	 i9Yeysiu/higrPQcyYwUtPHoJpRBPsxg9PppnNFD4Ss++HiZlva7Pdr9YDtoYSk+2A
	 PTqxaQcIVUdFA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-606440d92eeso2709689eaf.2;
        Tue, 10 Jun 2025 12:11:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/Sa/1ZSQC0R7xfzdmOEJqAwehZwW+jpfib4HzznYFHAtBylE2XyRT9jv93nDHka+uFolJKGpG+uo0lD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRMZ9Rz3k9QaqWGJ+rPUGw6btzUytGcBqx8eXK5kmQ8Vi4nmiJ
	KR+ppbptTtN7A9dj/S1KXPNxhTa2AQqJn9VxV/MpEkGtRfQxndFslFHk2zMENZxbq7kQaKuEr2m
	9AXHVrbI02zoXISC9H2pXZqg18KzUWcM=
X-Google-Smtp-Source: AGHT+IHz1j5jPlZ3CSUp9S4nqc+ZGrYWTZnc/CxlNi62Jx8kyFWvaCn/y5AQ/0Jjp+84f9tnWyS2isD8anlSXyF07vs=
X-Received: by 2002:a05:6820:199a:b0:60b:c6c6:f69e with SMTP id
 006d021491bc7-610ef73010fmr256418eaf.6.1749582673271; Tue, 10 Jun 2025
 12:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609063528.48715-1-ubizjak@gmail.com> <d8482e4cb4384fa02d61a6d80075be363598734b.camel@linux.intel.com>
In-Reply-To: <d8482e4cb4384fa02d61a6d80075be363598734b.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Jun 2025 21:11:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hOqGGwjJxEipf05LQWLQ7io1BV0yUqZdfBG9qK94NX6g@mail.gmail.com>
X-Gm-Features: AX0GCFuL7cisrNlRWpp81ZsFp7bRFfS034CjzSUxV5GvrYFpzIpYzqXLNoXhxjk
Message-ID: <CAJZ5v0hOqGGwjJxEipf05LQWLQ7io1BV0yUqZdfBG9qK94NX6g@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Update arguments of mwait_idle_with_hints()
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Uros Bizjak <ubizjak@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 9:11=E2=80=AFAM Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> On Mon, 2025-06-09 at 08:35 +0200, Uros Bizjak wrote:
> > Commit a17b37a3f416 ("x86/idle: Change arguments of mwait_idle_with_hin=
ts() to u32")
> > changed the type of arguments of mwait_idle_with_hints() from unsigned
> > long to u32. Change the type of variables in the call to
> > mwait_idle_with_hints() to unsigned int to follow the change.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> > Cc: Len Brown <lenb@kernel.org>
>
> Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Applied as 6.16-rc material, thanks!

