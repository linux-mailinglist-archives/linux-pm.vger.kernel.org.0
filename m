Return-Path: <linux-pm+bounces-43038-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJvPGHdcnGmzEgQAu9opvQ
	(envelope-from <linux-pm+bounces-43038-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 14:56:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C912B1777D4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 14:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 596D23055632
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BF0265CD9;
	Mon, 23 Feb 2026 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAIMnGzd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF1221FB1
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854759; cv=pass; b=SslFBThZxKi1U+VyYwm1CdvxScWW4JUkSQ1ajWB8NM5C6Lddf/o0VqCodZRDEX+abIILLXtTOHGrYoU77HR01B9jb3RSATQwiIeqdY2fo40wQ5XQMRkTq/PR1del+gnmr/WHxx+kEybdVYkYklYTFSylTwWQCwMFtbJMIamLZpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854759; c=relaxed/simple;
	bh=EzUfziwHN4t+6rCJqNdkZVs8Vyi2IIgFGGSz1ptRO/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8YsDUAzLPop3nLfVFvRjKjA0S4msoCmca4o/HstKspi/C9r/aJdCAQOr6D0oSFWtNlJPmBK+EgnfoENah/y+JtUR0/3zbGkDGG3b3Xx+kO/Ukskzc70zC0Gy3HlNL9o3BDdRy2a8i/GY55hy67nvRV/axQkDxVPrhqeDdWb1gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAIMnGzd; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c6c444e89bcso1540710a12.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 05:52:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771854757; cv=none;
        d=google.com; s=arc-20240605;
        b=Ynbwaw61ngAhAWjD5FPqHLDaikhNdHbjaiAPeofSj+ikADmp3SWHpInXtz/RcaB5QU
         Dc3ntbPRhkbS4bkgNHtq6uJHQJrSQJtYExanRWe4bFe7Pk41B/cebfqL17ZG8MvcLcid
         3gbynePHzVB5yVKhkblCG2WJSt7r/rR3Gmn5uESNBz/j/faI33q6NDkiqe09q2noXkCR
         KktNmA5kq/BA6tqqGpayR6oS0QZ7lyywdskomjocMlae+PpWc42yFuCicWhKEjQ3SzEA
         fwiFUJvA7j9YMmCGY8XQ8qsuyVGdiTk609jKvFSTvmUcqGaE4jxSIFuTVrJkFy1TZzge
         x3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TWwsfQSmrc7KhlI2G6haDBaCjFdQ6FTDQCYdiKWJd1g=;
        fh=lz8zZLv1oxXzXeW9QYq9F1JFzCJK/sUKmGLO0606iYc=;
        b=VLcgQTGHkGciH1+r8FyKtUtR0z0jsvt5nAWLnm4ZAYaI+GLHQ3WkQVji8RmhXcjieh
         K7zEn2+x3nmqRtlwFttOHIE9daZ2N67hWfUBUQ1sMYXLBKkCJ8Xu8EEiIbWcXfc3N4r+
         Uctqb5HZK94nfZ3hF+xNvqQ7NT5NLXENlEnlffmYjVifncEtD/9Eba7yH/J/PJAQaUwH
         ddp5FiVatzsCpsY95/4rfnweA8NSSJCATynoPxL93JHg8rSubD6xUIOW66pARPe9caZ7
         foQqkNpf8IYSmATpEE1VnQIDidA7V3ymzrCcKfPG0/DpYUSPNSX2/EhmuAFrHq7LOBBO
         Vi9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771854757; x=1772459557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TWwsfQSmrc7KhlI2G6haDBaCjFdQ6FTDQCYdiKWJd1g=;
        b=GAIMnGzdKb+9RlhqFTfnXAPgym/2/FUa416bD+iaOKiv7G/6hqDcjmrjs6lN1PqkpW
         BzELjWp34G2p4X9s9owiVPAHlZoGYYqXQcyKZVv7cYFm4KeswgvlU59IO3yOR0/JaqsU
         ZPonPPi542AP18vWk1Xfq9PYYckD8kC6fAJOm0Xz3XcujhwFoZU3f/25DZEifzd7bUQe
         7CeS/MeYxGgWldWoWUsCk0//OoWFGshKIoKr1QCSXbOy1T9sm0TxjAYpwDbE4kpyDejs
         ikAHpHAILgXyV0NoQ4fVut1yziMs+QLijEWpbxx7dCCZ9GoQchNXCTMG37EjAdHf3MTh
         AXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854757; x=1772459557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWwsfQSmrc7KhlI2G6haDBaCjFdQ6FTDQCYdiKWJd1g=;
        b=lD6Q78jHQw26XZ3VNqODVmCOa2EvuLq51cBaMP8IdlEmg2qJZRIjJ9T1fO49j8p2Mi
         xw4EM1Nk/gR+zJQ/9/s1B6rbns1Cf1VNyEkUrFD3HP3aWjFCIX6ym1SQ7qDfgiOfZtu2
         btCscKa4u8GVSlZl+vpHyh614ihQ5AIs8aTcKX7YyYzqSAZxH4WLQ/J332Waf88cFWjP
         aKAloWqktjxkmAN61vT54XRHKHM1dP2ibr/1p9uS+/tWwrmlQwWfgPVityF4AI69F05Q
         CuyI85vqtM+CKxpm+CqAvhDD3pSDJGqF4quJLVoOAvMD88BA5PKA8RRKcQd4ektL5jgw
         pnxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIoVnc8wqXpyVo6ffBqklCE7V6uPKdMrsZNfJOT7SflvvIKZ3I0kIJY4sPbMW3I+Ml+IaEJrkPBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/1xNtnLy6lfOTYE9Kvm+iOitlvPvMETTblMib4ruZKj7eWNL
	hJvo9C7ldztQvj/Vyw3fM1BHwrAI+HD665A0rZwzBnskhmTXoOJS8bUE4wRuGLZCticTSHxCoon
	ciwHJR3//Z8HGm6/KEDgTMMRsRBupDdw=
X-Gm-Gg: ATEYQzwx+v+tKNCaBJUeuDAYXemgY908xZ292YhN8GWokf/J/2qOQBL8L5L0I6KWnHO
	jb5dEIA7RnlutuK8c+zO8Otjx5omUK2kodDBwebuwyTPcIbi8aiGDUsfb9aUuOuiqTRhswPPVs4
	r4Br7C09LLGE9mufLYjHQKzxJFbOvWiUetHjViY60Lrevlwg94sqQdmC6SQWIO1CJubywbkXC55
	J37p5bqeV/HKHUxs2xuQNGOSx9hp8w/MrB/CJ7gs3vexTesqof7G18e1+oDxQJ6Hb89SU9DRN9c
	FMue8egJ
X-Received: by 2002:a17:90b:5447:b0:356:4ea0:e9e2 with SMTP id
 98e67ed59e1d1-358ae8d3a09mr6084454a91.34.1771854756912; Mon, 23 Feb 2026
 05:52:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
 <20260223-workqueue-devm-v1-1-10b3a6087586@oss.qualcomm.com>
 <aZwWMiYEvr3DXi3E@smile.fi.intel.com> <9dd377f6-3565-4c0c-8c98-1b5ac4982f5b@kernel.org>
 <aZxES35K3hSX4KEx@smile.fi.intel.com>
In-Reply-To: <aZxES35K3hSX4KEx@smile.fi.intel.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Mon, 23 Feb 2026 15:52:25 +0200
X-Gm-Features: AaiRm53PjY3r4YJJgRdEcXeF3wEcS_dn51myeI6Bp2rdVCy5EIQxm03JMpsksBU
Message-ID: <CANhJrGPWxgFddKaqdFM+DGKYTXaPxeBZLMhxBfXT-ZU6SrsbPA@mail.gmail.com>
Subject: Re: [PATCH 1/9] workqueue: devres: Add device-managed allocate workqueue
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Tobias Schrammm <t.schramm@manjaro.org>, Sebastian Reichel <sre@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Lee Jones <lee@kernel.org>, 
	Dzmitry Sankouski <dsankouski@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, driver-core@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43038-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,linuxfoundation.org,lwn.net,gmail.com,manjaro.org,linaro.org,collabora.com,chromium.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mazziesaccount@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: C912B1777D4
X-Rspamd-Action: no action

ma 23.2.2026 klo 14.13 Andy Shevchenko
(andriy.shevchenko@linux.intel.com) kirjoitti:
>
> +Cc: devm-helpers maintainers/reviewers
>
> On Mon, Feb 23, 2026 at 12:52:14PM +0100, Krzysztof Kozlowski wrote:
> > On 23/02/2026 09:56, Andy Shevchenko wrote:
> > > On Mon, Feb 23, 2026 at 08:27:29AM +0100, Krzysztof Kozlowski wrote:
> > >> Add a Resource-managed version of alloc_workqueue() to fix common
> > >> problem of drivers mixing devm() calls with destroy_workqueue.  Such
> > >> naive and discouraged driver approach leads to difficult to debug bugs
> > >> when the driver:
> > >>
> > >> 1. Allocates workqueue in standard way and destroys it in driver
> > >>    remove() callback,
> > >> 2. Sets work struct with devm_work_autocancel(),
> > >> 3. Registers interrupt handler with devm_request_threaded_irq().
> > >>
> > >> Which leads to following unbind/removal path:
> > >>
> > >> 1. destroy_workqueue() via driver remove(),
> > >>    Any interrupt coming now would still execute the interrupt handler,
> > >>    which queues work on destroyed workqueue.
> > >> 2. devm_irq_release(),
> > >> 3. devm_work_drop() -> cancel_work_sync() on destroyed workqueue.
> > >>
> > >> devm_alloc_workqueue() has two benefits:
> > >> 1. Solves above problem of mix-and-match devres and non-devres code in
> > >>    driver,
> > >> 2. Simplify any sane drivers which were correctly using
> > >>    alloc_workqueue() + devm_add_action_or_reset().
> > >
> > >>  include/linux/workqueue.h                        | 32 ++++++++++++++++++++++++
> > >>  kernel/workqueue.c                               | 32 ++++++++++++++++++++++++
> > >
> > > Hmm... We have devm-helpers.h. Why the new one is in workqueue.h?
> > > Can we have some consistency here?
> >
> > Answering with update:
> > I don't think this should go to devm-helpers.h. The definition is in
> > workqueue.c, thus the declaration should be in corresponding header.
> > It's logical and consistent.
> >
> > Otherwise, I could move it entirely - definition and declaration - to
> > devm-helpers.h, but then the release (devm_destroy_workqueue()) will be
> > essentially exported to everyone through the header.
> >
> > So kind of conflicting choices.
>
> Hmm... An alternative I see is more intrusive but should make it less
> inconsistent: Treat the devm-helpers as devres like header for workqueue
> and collect there all devm_*wq* related stuff with maybe something putting
> back to / holding in the c-file.
>
> OTOH we may leave devm_destroy_workqueue() visible for now with a comment
> saying do not use, it's internal or something like that.
>
> Hans, what would be your opinion as you IIRC is the author of devm-helpers.h?
>
> Matti, I also Cc'ed to you, you have usually non-standard thinkig and
> insightful solutions (besides being reviewer of devm-helpers).

Thanks Andy for Cc'ing (and flattering!) me ;)

My personal opinion is that the devm-helpers.h as a "collect 'em all
here" -place might not have been the best idea. Perhaps the original
author didn't know what he was doing :) Problem lurking there is that
such a file collecting misc devm -interfaces in one place, will end up
slowing down the compilation while some people put effort on splitting
the headers.

Currently the devm-helpers.h contains only workqueue related
devm-helpers. I'd consider renaming it to something like "devm-wq.h" -
and then just stuffing the devm-wq stuff in it. Optionally, I'd
considered adding all the wq-devm stiff from the devm-helpers.h to the
regular workqueue headers - but I think this was not liked by
everyone.

So sorry, I have no helpful or strong opinion on this. Besides, You,
Krzysztof and Hans all probably have better insight on this than I do.

Yours,
    -- Matti
-- 

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));

