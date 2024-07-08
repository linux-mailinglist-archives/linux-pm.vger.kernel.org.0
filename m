Return-Path: <linux-pm+bounces-10795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A0592AA2B
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 21:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F117280F99
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 19:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388CE14D444;
	Mon,  8 Jul 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSTkVmkw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA88E1DDF4
	for <linux-pm@vger.kernel.org>; Mon,  8 Jul 2024 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468282; cv=none; b=AXZplDDx1d4S8+n/2qzaYg6DfXgH91PvZX6iVHbxHrCtPkl8MlvUQdiwRm3tDSnm5uvFoWDDlhR3u2P1sIcnTIWOJVTzRH/A2vMprSxFjX89y0L+c7sMsqD3i5Rm7+Alk3f9XhIJvHkV/aSCWl+vRFJS2p0WmavDZxZyej5Rl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468282; c=relaxed/simple;
	bh=8X9bK0XUzYMuIB1GdfKNqGafAd/FFfRUhMSqUretYa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHPnedzMrheetvQlktDciMAWwr6RsXbQWjXZdwIl0UTGzAhNVwy+lOX/P4+xwyr7q5gDMaYaDbFAVH9DQ0IMMwsTa+PZhLlIUWV58gmZCbYmLgM0hsVL1Rs+k2CIrtbLCMPVdxwUvFAmhvqNpEYmqDnrSS8h4iHpemzUov+9EQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cSTkVmkw; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70af81e8439so3559212b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2024 12:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720468280; x=1721073080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8X9bK0XUzYMuIB1GdfKNqGafAd/FFfRUhMSqUretYa8=;
        b=cSTkVmkwlqiPa7D43n2CxETa+xFYTAIlxsh5d47iyyxcHC02gQ6AtSUh/acBC7JabJ
         XNNesLhc6cLt8sGpIAfMYo8l9OqEiKNBSMbJE/fEGUmCIbg/VcI5b8a6Lb7cSvfHRQPD
         T3LTnG/jBz/MpDBWw9QbtEoZ+ZP70MVI1JtvCykNyYPxwL8g/ub42+4cv6vx7BHsk694
         pCZPwlKEOd48g6GlBCsz056T0o84zTPe8PjHweaw78Cu6xL6s3r1qvi3d+99hVN8JqLs
         EALZMJ4iYKA8wZ8sfJFpTm9IGKr8GiRsZ14ktmZPRrIDfyHKN1SVHzjAUPi7J/Md6avq
         Lrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720468280; x=1721073080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8X9bK0XUzYMuIB1GdfKNqGafAd/FFfRUhMSqUretYa8=;
        b=eMR+DZOzaZYAi/uQNZs53PiJR0o8KjtB+YMQyt3q77sdSZeu+MzX9SstOR/K/jFKq+
         ooXPdpNnhfgRx9Vd+PyT6RbMQBezh05iROrrS9j2rQ+T7TwCBCHZGMkBKLSMgGs5inou
         9Gw9qDS8TNBktWvK+YMiqvBqSJU+lPgN+e/QZzX6BsJ1p0C4bGXY0HYnfjUWyTTfTX6v
         jGUaCZR5t4QTTcU7hW3ErMpEDUIoTwD+kk9pvlqyu3aWNBspq0XvJEFkiS1rL4z/mJoy
         3Axe+tr5BZUXC7w4glOBCN+w/ywsPyHUoD2g93YRvxACKwWD4k8X0hlslksg2QG6LqrI
         UqFw==
X-Forwarded-Encrypted: i=1; AJvYcCUWyRmy719MbxgA1xAyhp4IBjOmOjuS383pOUTFG3cEbEBraHtnghLTsWvzhJ2hmkrztH5F8TE2gejdR4I7HT11lvhrr2tZnuo=
X-Gm-Message-State: AOJu0Yyk811wDyPgDkwL6Q0nHy687ypHFJdEj9IzGssEN8kNrdAdh/R8
	6Rj4Bwc2GfvRCzcE6anjYZPUZJIU42l/Wqc+5iAXxHXivW5QYW6fJv5EJvIvp4onGlA+HQYaP9R
	nhKLQuaO4KIcXNRy6tmHpacO2/hKxUmf5sn/mmA==
X-Google-Smtp-Source: AGHT+IGwK1fsuaerAwZ7Lfb5nwlt5kbLQoUQfH/PmZaRy3CJf5sSqawqyBE+y4GU5auXRGAihVauG7L4gNx6sxfnSF0=
X-Received: by 2002:a05:6a20:3d89:b0:1c0:e699:fa13 with SMTP id
 adf61e73a8af0-1c2984d8c30mr509029637.52.1720468280070; Mon, 08 Jul 2024
 12:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619031250.2936087-1-tj@kernel.org> <20240619031250.2936087-3-tj@kernel.org>
 <ZnM2ywDVRZbrN6OC@slm.duckdns.org> <CAKfTPtBPObGdcaQF5nKqr4042f-+5obTMm_S6S+=3_Ct33ZMyw@mail.gmail.com>
 <Zog5-Yd5wV0-Y76y@slm.duckdns.org> <CAKfTPtDeA4OTPJmEHd-wKToYwDVizcny-_qxEuDUA-OcaVm2Uw@mail.gmail.com>
 <ZonzAdyd6zb2Sm06@slm.duckdns.org> <CAKfTPtDE2rWbRouf8zRyM3UpTfK1k_xrWmvAs-zfoRZqM3zGsw@mail.gmail.com>
 <Zowt7pVWFB-Of-me@slm.duckdns.org>
In-Reply-To: <Zowt7pVWFB-Of-me@slm.duckdns.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 8 Jul 2024 21:51:08 +0200
Message-ID: <CAKfTPtB=77c-RsJ23suNZVf7qByeGSjYQJbiEU4JpXU6DezNLQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Add cpuperf support
To: Tejun Heo <tj@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	mingo@redhat.com, peterz@infradead.org, David Vernet <dvernet@meta.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 20:20, Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Vincent.
>
> On Mon, Jul 08, 2024 at 08:37:06AM +0200, Vincent Guittot wrote:
> > I prefer to minimize (if not remove) sched_ext related calls in the
> > fair path so we can easily rework it if needed. And this will also
> > ensure that all fair task are cleanly removed when they are all
> > switched to sched_ext
>
> Unless we add a WARN_ON_ONCE, if it doesn't behave as expected, the end
> result will most likely be cpufreq sometimes picking a higher freq than
> requested, which won't be the easiest to notice. Would you be against adding
> WARN_ON_ONCE(scx_switched_all && !util) too?

A WARN_ON_ONCE to detect misbehavior would be ok

>
> Thanks.
>
> --
> tejun

