Return-Path: <linux-pm+bounces-24072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833CFA61D9A
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 22:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF7B189E833
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 21:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2B6204C0B;
	Fri, 14 Mar 2025 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDb8zpg0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4972046AC
	for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741986415; cv=none; b=PHdm7oKnBz8NU3cpC9hQwHxJ0tPt9446KELsPq5H5oUOjB2m5FZV4mkeX+kFAWiB0QZyE49nlPVQeVa8qieafVaPK0EcA8AQFGaPpkz4qrsM63QH7SQTk4vxXMJvRNn75B6/PeYZpFUaNnuHN7KVNozwri0OHEBVaIX41krMSBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741986415; c=relaxed/simple;
	bh=EZIOvVzcE/3rVnjN+zLpfwnJoOG7WheSIbDNqh2pozE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6ritNpyCHOyaNuQXyWGP9kv7M3iDEZZSFtEhsaMBRsG4bboWv2Xr1y8dLM1/JVq9GI1zAmQwHfQ/6qAFiAp0meyyZnb2HW0DDsv/+Fv1UmPgoKr0+VM/RhmbFr+c68LywJJpNvqBxVkCyCfxXUIlh3b/Ocq3jOzK7DoLMCBTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDb8zpg0; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5497590ffbbso2641967e87.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 14:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741986412; x=1742591212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUyX2OLLDGDNbSS9bFUituZMJ4sdx+0gIOIlvaqGxug=;
        b=RDb8zpg0NHZPUsyYID+X/cFgKey8abPo9IZfAdbo2ueCdONG8x2eiJuotrWontHXkY
         WLPVEhDSzdqObvhXN/iQUJZNANYZQhkmzM+Tno0xIlITVUcMxnbV3oEyMbDkCUS0oR3l
         iDB1tXkvVNEfmavbSLPP8qrNGWu6mUT5HL30gcx446w2ADw03S8mnYZcukV+rLil3TdI
         4ecexUYoTeVh7wz9c4jn1wOuOO3UlWDo/e+a/DT/ZdOlkVyia8uL59kcfn3KL83C2QJ2
         y79Yp8EICgB9/2lEzPeTOdfmMJD70dGkdI/ZDSHJetnd5K2yfvQE8QD8EbOVFuwEyfTI
         R7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741986412; x=1742591212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUyX2OLLDGDNbSS9bFUituZMJ4sdx+0gIOIlvaqGxug=;
        b=OKyf5Klrb7NfiRBqD/vvNoZD7BZ243/AN9ORGyXeuPuEw9sU4eLQtPOr2s/ouwIwXr
         u+yEBeFGOUX5wd6j5daDNorLORes4xA32h6WheCJzEx4U4VhDL2yHTojNch5yoh8zEej
         ty20Nq6qshX5IKbN6j/IEVRDzXRQDzV73cyYfE8y7Y234fTNasth0WoZEr9vZ+1KeKAh
         QW6oh+jFl8AkcuooY5cq+XAHLNI6t2xpagr29G5R1eng8OpxfqZzzSe6M57RhPGsqfd7
         19OcR5lJa+RzFLRBrylc5EfbYYQqvZoujQxMyzXWaanWZsH6chYvAVWnh9vNYLKgyuxw
         Ma8g==
X-Gm-Message-State: AOJu0YwVtY0Y+Ngi9FBredi6S5LzYV7YBPn1VlIIwljV4YfxZyRS/q9y
	hw4p7rt3/IcCin+Cc3j/X66kuRFeqv6U7pWPtj2Tct/qGHyYnuveoPrOeS9GzU9/DlIMF/+Tnkg
	EpXh+vhbYs6R7OXmZbUoi/p9fkim+MnbBOFD/
X-Gm-Gg: ASbGnct9+09sPT79nTiY6qwI05MGyPnnrwyj7NqGcrCiQbLFH8uBZGCsESly/pZ1Jv6
	EOro/XFMsym0Qgotgqk8lKhU9MQLY4UPWrUGqwSaPEpJ85RGrtnngMVEqzg/sQa3/fa0z0Ig81P
	75Hhg3NgnGUbDC8AggYHc7PrttUtihWXndOlA=
X-Google-Smtp-Source: AGHT+IHqRlNf/oMWPkXGiZZ/bQyY1Zyz7JykPKV0OzC4Wc0dfe4AMxnxEnKTPIXDC0llj17xKy+nfLfC93GpVvAQMyg=
X-Received: by 2002:a05:6512:3e14:b0:545:48c:6352 with SMTP id
 2adb3069b0e04-549c3988015mr1487985e87.43.1741986411635; Fri, 14 Mar 2025
 14:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net>
In-Reply-To: <10629535.nUPlyArG6x@rjwysocki.net>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 14 Mar 2025 14:06:15 -0700
X-Gm-Features: AQ5f1JoBBtBAAibKOwIryP0j59INA8ZBHFZCuGpPvRGBvm7KfnRM5xkSK4IkLbU
Message-ID: <CAGETcx8VmzU9xy39=_QAQ0pf5fZY=EbGOKrdy0_wLEW1pQ2oKw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] PM: sleep: Improvements of async suspend and
 resume of devices
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 6:24=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> Hi Everyone,
>
> This is a new iteration of the async suspend/resume improvements work:
>
> https://lore.kernel.org/linux-pm/1915694.tdWV9SEqCh@rjwysocki.net/
>
> which includes some rework and fixes of the patches in the series linked
> above.  The most significant differences are splitting the second patch
> into two patches and adding a change to treat consumers like children
> during resume.
>
> This new iteration is based on linux-pm.git/linux-next and on the recent
> fix related to direct-complete:
>
> https://lore.kernel.org/linux-pm/12627587.O9o76ZdvQC@rjwysocki.net/
>
> The overall idea is still to start async processing for devices that have
> at least some dependencies met, but not necessarily all of them, to avoid
> overhead related to queuing too many async work items that will have to
> wait for the processing of other devices before they can make progress.
>
> Patch [1/5] does this in all resume phases, but it just takes children
> into account (that is, async processing is started upfront for devices
> without parents and then, after resuming each device, it is started for
> the device's children).
>
> Patches [2/5] does this in the suspend phase of system suspend and only
> takes parents into account (that is, async processing is started upfront
> for devices without any children and then, after suspending each device,
> it is started for the device's parent).
>
> Patch [3/5] extends it to the "late" and "noirq" suspend phases.
>
> Patch [4/5] adds changes to treat suppliers like parents during suspend.
> That is, async processing is started upfront for devices without any
> children or consumers and then, after suspending each device, it is
> started for the device's parent and suppliers.
>
> Patch [5/5] adds changes to treat consumers like children during resume.
> That is, async processing is started upfront for devices without a parent
> or any suppliers and then, after resuming each device, it is started for
> the device's children and consumers.
>
> Preliminary test results from one sample system are below.
>
> "Baseline" is the linux-pm.git/testing branch, "Parent/child"
> is that branch with patches [1-3/5] applied and "Device links"
> is that branch with patches [1-5/5] applied.
>
> "s/r" means "regular" suspend/resume, noRPM is "late" suspend
> and "early" resume, and noIRQ means the "noirq" phases of
> suspend and resume, respectively.  The numbers are suspend
> and resume times for each phase, in milliseconds.
>
>          Baseline       Parent/child    Device links
>
>        Suspend Resume  Suspend Resume  Suspend Resume
>
> s/r    427     449     298     450     294     442
> noRPM  13      1       13      1       13      1
> noIRQ  31      25      28      24      28      26
>
> s/r    408     442     298     443     301     447
> noRPM  13      1       13      1       13      1
> noIRQ  32      25      30      25      28      25
>
> s/r    408     444     310     450     298     439
> noRPM  13      1       13      1       13      1
> noIRQ  31      24      31      26      31      24
>
> It clearly shows an improvement in the suspend path after
> applying patches [1-3/5], easily attributable to patch [2/5],
> and clear difference after updating the async processing of
> suppliers and consumers.
>
> Note that there are systems where resume times are shorter after
> patches [1-3/5] too, but more testing is necessary.
>
> I do realize that this code can be optimized further, but it is not
> particularly clear to me that any further optimizations would make
> a significant difference and the changes in this series are deep
> enough to do in one go.

Thanks for adding patches 4 and 5!

Let me try to test them early next week and compare your patches 1-3,
1-5 and my series (which does additional checks to make sure
suppliers/consumers are done). I do about 100 suspend/resume runs for
each kernel, so please bear with me while I get it.

Thanks,
Saravana

