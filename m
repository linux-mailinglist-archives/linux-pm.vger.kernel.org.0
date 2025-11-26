Return-Path: <linux-pm+bounces-38732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C5DC8B1B5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 18:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7737B35AEB7
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3B134217C;
	Wed, 26 Nov 2025 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1vVRVBb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8349D33F397
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176360; cv=none; b=BEQSEjXPsNpFsRiM1EibfX5U8T5Z1pU/aJPHXOe0UsRNl2eImgzQpBGUVoE/pSLhLJhakv5OQoyuzvxEXL58B0secBU74VScf8vgm/Qah02o2Jl5A7YEbdL+7rFWGtIx4GRB7hku1ZwPdINlo7IxlLTKw8Wq32Fd7AFG+NJ6Umo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176360; c=relaxed/simple;
	bh=JtHa1eBw20+UqXssfnm2Q1wzu/b9nvvROyd2V+/iCKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOrAUbwiC5JKtDfIILRCWJ34xEJf1w2PXxQVrVfx1na52grMCcmjkU/6RLpppmWBwjUR8fIrbPW1P+9znYUL0aW197I6V3ZUCABDTIS67M0QFZVbCisEJNFPMyCyB/mEdEAqiqTf8LET5gCjd54TKN92y9YocaRQJOPK7B6nAgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1vVRVBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16651C4CEF8
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764176360;
	bh=JtHa1eBw20+UqXssfnm2Q1wzu/b9nvvROyd2V+/iCKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V1vVRVBbS5XguzZ8axfcL7O1cHkywPIYfWBKovFn8zTwMhVhGEeD3CSG8wc70vQhN
	 K3BJyQ4ffiF7/k588CzwWL2Kcz6cWDjwIKSNvCxjvchQNnYSBc/ekR77XUDdpH70Ph
	 cGtiCV0FePvqrXYAbO3Nh45PITjaM3cn6MfzbLo+kz2kICf6UQfOJ/cbBU9ygw9f9m
	 HSR2QbCR0jrujMbbMqyJUtTfuHXsDcbs+Oi3WZSkJBLFnFhyF2IZuYeRREdfdzMqra
	 WtrgrjTO/PjyFS+LVcnSXoDXQxbBwK6mXv3V0rOQYqw/QI3an66a7HBLLJJxGvQUk7
	 7hrFBBDJODuhg==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-450b2715b6cso3275509b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 08:59:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuF+aXytdjH04JgeYLmGLyAvQn+gOxqluTqh4gLHDsoZ0nLoWpK423xIUZ3OA3lribqW9Eet5ZUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YywQYa9Ga6HAAZlhhFadGL7fOcM/kji7LXUZRSm3kWO0HB+4kHN
	600mR3zrv9hWMJDFYJuvUgON+FEGur512N0lO8cmFSE5GVSocqLmtxlUCtXpxkAr7djvFD2UyYu
	06b3EfTqLzWnhcNkqZPlHPfPOeBNNFQM=
X-Google-Smtp-Source: AGHT+IGW78DT5+rWtvuv7xZT+8p2tS494C+mRgf00VXOtNlTMQyiHAPuVhueXfiGrICZFe17jXpQgA7JFFFV8PU0YiM=
X-Received: by 2002:a05:6808:2287:b0:450:340:2693 with SMTP id
 5614622812f47-4514e79dfb2mr2793241b6e.42.1764176359389; Wed, 26 Nov 2025
 08:59:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <CAJZ5v0jsdsyVd3hPWni1Vj+daQS8PdWJCjboJHHHbBjBMeSxzg@mail.gmail.com>
 <94c6680c-1b86-4cee-8e9c-860daf629b59@acm.org>
In-Reply-To: <94c6680c-1b86-4cee-8e9c-860daf629b59@acm.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Nov 2025 17:59:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gbmXKrUi6RzW5jHLedCpDcMwCj=+4zZzq0pXwnFMkDEA@mail.gmail.com>
X-Gm-Features: AWmQ_bkmDLaFrZdDvx5_PEHhvUT_Zqp9AI-VHwwqkA-t6VtaCJTYXg0zU5KKNuY
Message-ID: <CAJZ5v0gbmXKrUi6RzW5jHLedCpDcMwCj=+4zZzq0pXwnFMkDEA@mail.gmail.com>
Subject: Re: [PATCH 0/2] PM: runtime: Fix potential I/O hang
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yang Yang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 4:48=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 11/26/25 3:31 AM, Rafael J. Wysocki wrote:
> > Please address the issue differently.
>
> It seems unfortunate to me that __pm_runtime_barrier() can cause pm_reque=
st_resume() to hang.

I wouldn't call it a hang.

__pm_runtime_barrier() removes the work item queued by
pm_request_resume(), but at the time when it is called, which is
device_suspend_late(), the work item queued by pm_request_resume()
cannot make progress anyway.  It will only be able to make progress
when the PM workqueue is unfrozen at the end of the system resume
transition.

> Would it be safe to remove the
> cancel_work_sync() call from __pm_runtime_barrier() since
> pm_runtime_work() calls functions that check disable_depth
> when processing RPM_REQ_SUSPEND and RPM_REQ_AUTOSUSPEND? Would
> this be sufficient to fix the reported deadlock?

If you want the resume work item to survive the system suspend/resume
cycle, __pm_runtime_disable() may be changed to make that happen, but
this still will not allow the work to make progress until the system
resume ends.

I'm not sure if this would help to address the issue at hand though.

