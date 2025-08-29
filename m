Return-Path: <linux-pm+bounces-33350-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9697B3B005
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 02:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6163AD096
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 00:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4B8528E;
	Fri, 29 Aug 2025 00:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FwJnLbiP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16704CB5B
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 00:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756428372; cv=none; b=GXFH15jhkDzfBhVWLPOdvx6bVU6vjdOrWhQbwvELPNoyGv/dBCTrGIlfjriS7hVJR4bkFHFoMfur9wLWapUCncEBUn1zLlaMwo8iaGM0Xr+oKKH2RVgw3JzgGISnUjEpiwzZ0ITftSaPtWeypmeX1/W6FqQ/Uiz4zM24D14s2Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756428372; c=relaxed/simple;
	bh=bJ55W++Nxb8oby/pXwaC5lbqs9ejADYEK13crSHx7gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL8MztvG/qrHvwe2ahp2Ua55QfwIbg9mwlnDMQv7f4FXjBO9x8A1szKOZOlIZhlPnztCwhhIW0UD9J57vLfvATj8ftLj8/7kloJ8wJODxDf9e5CCewIt/ww3wwABtCGikbaz2Cj23UGwPhHRQdoHypePXsDCsnxLHWcCp0XtbnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FwJnLbiP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24884d9e54bso15294075ad.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 17:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756428370; x=1757033170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=463VFZy2tj4xoqrvB2n9OHHNXrEPcbp0NV7RQ388lC4=;
        b=FwJnLbiPcIVlfF5s6J+ycP204mH/6If5H7KbHHHOeuknVz8EoCtqYRIO6HzXuemSSR
         zOvd+of6u/WOw9hJCPEgRqKgKE2WhEQH1eF7X6VcPyzLPyztWhGjb4m+8jqXFAyKAVdR
         ecMFsbgpAYXTLp9joBxYCpddCQ9gdG8xZ3Wjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756428370; x=1757033170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=463VFZy2tj4xoqrvB2n9OHHNXrEPcbp0NV7RQ388lC4=;
        b=o3hryYQdGI9Zi1wyElTGFU0twaAnzZmD2w/7SOzR1nXFaiYLV2lT9exXmTCbkAoo+i
         WPbOWfSTv7fsPAWubbLRnaH9Eum/leeMSKxOeNG8MhWGaYbFLgVf0kK6P8ldnNS6thbA
         BigUngBQGZJIaZ3Bz5XLLXGHgpG/YoNdH/FSvfg0talAEfGqC98rdMlAY88vKBgW8slQ
         zOCzceGokhw4GLd/Enh7OAejkUgDUmw4PCXnlQ+E+sgML5NnKs4PrWu/hARwSaV9074l
         ZtdH3iYnAbAC1lm4zKpN7oQ0FiRZkggJj75vJJnE/gnGQC60ZQTt1pW2eeMNgh6Kv3yd
         ogOw==
X-Gm-Message-State: AOJu0YztcMpxeE+o0FfhCUtalVH8F0x6KqnF5xNPfnw8xO528xiDYheR
	tCdKY80sK0rgMJ9x7wClU82HwXjIB5yizVGlqHdVi5MAy3x/Pr587e8/4zlXEXLgFA==
X-Gm-Gg: ASbGncuehTGXoJK8SaAK8m4tLgjDKmctXciqum1NLMXl+XvajQQisASMXpIB58QGOee
	kkjv+av8bUJDKJbOwUx1zgKGplvQrwW2T5SEnBh5RsTRizOVL2ZJ2x4lvFoMgNntz07t8KCDMvh
	JFYmjIBYG+WTmF/A/KrqNfKxtLKAGJ46X4L8M0wrVmRbj7O5KKEi8uJ6u1KNHsb8O61ejPvgu16
	Q7aW7RwBol5yuBggVVHVij43giegA9mHGovG3r/PhyglrQai6b8xe/RKGf17t9gzzUs3bYxkSyI
	lkImaBiaZi6/0JqiY63VxsOE4n0qu9Xuq2tiwJHRUoJqs4a6Icx/Bx518m9Ah6bvV04dWA7xsLX
	mak3UoJInIphxcWDr77Z8wqjYPQ98a32tww0/BNluGCn1XTlIsbdb4LdcgFPu
X-Google-Smtp-Source: AGHT+IE4zG96b+vw9XU2y7lGHAioz8CC/WUSnsGj+dZ7PSXPdUtLEClJCcwmzZ7OFtFgpmAUBfI3/w==
X-Received: by 2002:a17:902:e552:b0:247:b86:548f with SMTP id d9443c01a7336-2470b86560amr180954795ad.11.1756428370097;
        Thu, 28 Aug 2025 17:46:10 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2893:df0f:26ec:df00])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2490375b3efsm7519815ad.64.2025.08.28.17.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 17:46:09 -0700 (PDT)
Date: Thu, 28 Aug 2025 17:46:07 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 1/6] pm: runtime: Document return values of suspend
 related API functions
Message-ID: <aLD4TwJftEAeCJyf@google.com>
References: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
 <20250616061212.2286741-2-sakari.ailus@linux.intel.com>
 <aJ5pkEJuixTaybV4@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ5pkEJuixTaybV4@google.com>

After reading and rereading ... and then writing unit tests, because I
can't trust my reading ... I think I can answer my own questions:

On Thu, Aug 14, 2025 at 03:56:24PM -0700, Brian Norris wrote:
> Hi,
> 
> On Mon, Jun 16, 2025 at 09:12:07AM +0300, Sakari Ailus wrote:
> > Document return values for device suspend and idle related API functions.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> I appreciate the documentation attempt here. I've often found it a maze
> trying to weave through the indirection and figure out the actual API
> contract for some of these.
> 
> But I have a few questions below:
> 
> > ---
> >  include/linux/pm_runtime.h | 147 ++++++++++++++++++++++++++++++++++---
> >  1 file changed, 138 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index e7cb70fcc0af..9dd2e4031a27 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> 
> 
> > @@ -464,6 +525,17 @@ static inline int pm_runtime_resume_and_get(struct device *dev)
> >   *
> >   * Decrement the runtime PM usage counter of @dev and if it turns out to be
> >   * equal to 0, queue up a work item for @dev like in pm_request_idle().
> > + *
> > + * Return:
> > + * * 0: Success.
> > + * * -EINVAL: Runtime PM error.
> > + * * -EACCES: Runtime PM disabled.
> > + * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
> 
> ^^ Is the "usage_count non-zero" true? For RPM_GET_PUT, we drop the
> refcount, and if it's still nonzero, we simply return 0.

It *is* possible, but it would only occur with the following:

(1) we've acquired our usage_count by way of pm_runtime_get_noresume();
    and
(2) some other actor is racing with us, acquiring a usage_count between
    when we decremented usage_count to 0, and when we check again in
    rpm_idle()

IMO, as-is, the language is a bit misleading though. But then, the
behavior is pretty subtle and hard to describe succinctly...

> > + * * -EBUSY: Runtime PM child_count non-zero.
> > + * * -EPERM: Device PM QoS resume latency 0.
> > + * * -EINPROGRESS: Suspend already in progress.
> > + * * -ENOSYS: CONFIG_PM not enabled.
> > + * * 1: Device already suspended.
> 
> This part isn't very clear to me: can we even hit this case? If the
> usage count was already 0, we'd hit EINVAL, since this is a PUT
> operation. If the usage count was non-zero, we can't already be
> suspended. At a minimum, we'd be RESUMING (e.g., an async resume), no?

This is sort of possible in the same scenario as above. But it doesn't
actually return 1; it still returns -EAGAIN.

Confusingly, pm_runtime_put_autosuspend() behaves differently, because
it's based on rpm_suspend() instead of rpm_idle().

I plan to fix this, because I don't see why pm_runtime_put() and
pm_runtime_put_autosuspend() should differ here.

> >   */
> >  static inline int pm_runtime_put(struct device *dev)
> >  {
> 
> If these are indeed errors, I expect they're repeated on some of the
> other related APIs too (like pm_runtime_put_sync(), pm_runtime_idle(),
> and probably more).
> 
> I ask mostly for my own understanding, but I might consider patching the
> docs if I'm not hallucinating these errors.

I've sent a patch series to fix some of the inconsistencies in the API
and to fix the API docs:

Subject: [PATCH 3/3] PM: runtime: Update kerneldoc return codes
https://lore.kernel.org/all/20250829003319.2785282-3-briannorris@chromium.org/

Brian

