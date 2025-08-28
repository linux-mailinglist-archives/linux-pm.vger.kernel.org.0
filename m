Return-Path: <linux-pm+bounces-33337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AD8B3ACBB
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 23:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D14566E31
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 21:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517C728B7DE;
	Thu, 28 Aug 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNZ4DFAE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A076A2701DC
	for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756416592; cv=none; b=axeJVlaNkD38CWoO19smd3roEd4IRNGuGbqL8X5Z8tFVX5N6ThYW8L7mf5A4M/id6iU9koZqqZj4rZc6R/4d3U512ZQDVx/qOX3PJ0GPQugjpGUYoPfZbcn6yNDnDv+sz1BOZtq1W92MH0VGZ+9pd99RUUVGEAp53AYgq8tgblE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756416592; c=relaxed/simple;
	bh=a1Y9Qfe4Ntinmu3qdU/LpvLv9GNDTobrJhavD8m/SRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+GolwbCrvzXcQD1yFR6E2pefDUQ4eXQ3OXnxHsN1Hnmt/a+ru7NzUB9j4xz8EIqsje+AtKqD9cai7I1j+ulXGBqqQTEKSz4Pew3VXiWpvd3a29Q8+EAFoKsbojO0/V7TN74S6Q0Wnc+5xxvHleS8Byv4gnlyjXNJU1xjx5BhTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNZ4DFAE; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b12b123e48so119711cf.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756416589; x=1757021389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a1Y9Qfe4Ntinmu3qdU/LpvLv9GNDTobrJhavD8m/SRQ=;
        b=NNZ4DFAESVNWOnyl0gTJ1GCbHyKscENFJ/c57hWklzspCL/F8x48/0WMTMvBLfskjq
         zIYcYO+7g+jRmVbyFNUJbH9m5uNWUhTL4r4oGDnul0F5ZLV5NeyRlqiHmuNOUYVfVePT
         +nSx18AqQc8rcwKMwzo+xjTWkeydlow+xsEA/HkOX+0UHAOtgkzwD2I0yVvDFDKg5+Wa
         XF6rFwyLy9hnZ0+y4UJrqOHNeEjBOXrMYFF9xb/gV1YKPxn7N5hp+nhsdrBgKTJq62cX
         TmNPmgsp4riRSMHTJFXSrAqGmEcCpoXcJoXemJ2iB3s7KC7cxAW9r5AgMwa3W82xLH28
         DCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756416589; x=1757021389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1Y9Qfe4Ntinmu3qdU/LpvLv9GNDTobrJhavD8m/SRQ=;
        b=WqT/DlYyEQLjgTS/AU+66fklqRx2Y17weCEUdvCz0C9ixShlCd/qP++rvB4M7jQfHf
         Atl1IL+TkCp4vI0rxd0SbC8tLOWuxFmPl+j9yeO1bWE1SVsWmLPvwIGH3qT3nTT3bxf0
         YfLEwZ6ey4mibr4pL6SRI+PecV9vzBcEU71+PUlUmVDxREOPZBTUHHm6nqs0vU9D4DzL
         hF2zN3HGQDujlRsa/E0tPMu+ycxF9EoaWbRUofrvz6JBsW2zVXkJqmLIO+DpJ6PBOoh6
         Io91SM9ZWL3O0Mdvzp9cTe3ooTcgKEQ8hGyt5Lo9BkYOHerHS/7mdOxhA9zeiYKFha1I
         32JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5cl2S1hMd66L1mQT/Q9nCOyjTkTc99C8ncA5AxC7fwZUguXLRTOZ/RzEc8CUp2qUnmTVtEScWTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOaHOiWkijCi74/bggmFXC7zr7WRCk03+LD0M6T7ESmeD/JbiT
	LpZisZo/IS15DjH7KBTRr3WMdgOy/DCoUlLwejKBUdo428iwvrHkLAoJO0UbGjla2ZBCqLgPvzZ
	6rSOhQxLVPyS4WVsaLdijUSGd6JBkmtMw0H4sqW/2
X-Gm-Gg: ASbGnctZc6zrctfUrTAT7OxTewzwa6s3BD0MPkRd96ci7iO3QTaIXsI4jT/gy7Wce9H
	7YDJ0vfoMzYwIow4Io++2QddiZeLVjXK8gfsHl9uysLAq1P2wRZ3oC1WUtXQ3+OvkKNovx4nHM+
	YkiK3HkLEADn2oSMtGlUg15jP1plIz6ZRVPJHa1MRhaLUkuyqsfhN+ixlkoZrt6B+JGuEfRHf9W
	nmCvNeD5hwnwvKar/kUC2gEKE3oxFDt6eVE9t/JiFBY
X-Google-Smtp-Source: AGHT+IFqkD7ft+jmAQsaqJOxgwKm4Qy2o/YaSs3yFiKSnw9xPjJPZVBKQytl3x3ukUzsLWLbu6Pj2Ju4p4ZQAl6heVA=
X-Received: by 2002:a05:622a:5cb:b0:4b3:8ee:521b with SMTP id
 d75a77b69052e-4b308ee5cb3mr3721231cf.0.1756416589198; Thu, 28 Aug 2025
 14:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730220812.53098-1-pmalani@google.com> <8252b1e6-5d13-4f26-8aa3-30e841639e10@os.amperecomputing.com>
 <CAFivqmKZcipdc1P1b7jkNTBAV-WE4bSeW8z=eHHmtHBxuErZiQ@mail.gmail.com>
 <aKRDxhirzwEPxaqd@arm.com> <CAFivqm+vzkbDEadJEF2So9ZWcRyVT_-Yc+8VWWwsgGW+KD4sNw@mail.gmail.com>
 <aKY0xuegI1S4X2uW@arm.com> <CAFivqm+Xi9FYtzPmT0QkAUxC2Kx_AkrH2NuQE_sVnJVuo48ypA@mail.gmail.com>
 <aKx4nZWsRPTXK942@arm.com> <aKzGlD7ZDIS4XMsF@google.com> <aLAGQk3nOcEI0qJ2@arm.com>
In-Reply-To: <aLAGQk3nOcEI0qJ2@arm.com>
From: Prashant Malani <pmalani@google.com>
Date: Thu, 28 Aug 2025 14:29:37 -0700
X-Gm-Features: Ac12FXzF-O6zQOCkRkRzG9C45ZMqIXcRsxfuzSsPwNBmBGM430lN7FJsPUYpVhM
Message-ID: <CAFivqm+r41cRhsZWjXdOhGhTsQ3nmr50cACk27y-PLee7ZGKeA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Increase delay between perf counter reads
To: Beata Michalska <beata.michalska@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Ionela Voinescu <Ionela.Voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Aug 28 09:33, Beata Michalska wrote:
> On Mon, Aug 25, 2025 at 08:24:52PM +0000, Prashant Malani wrote:
> > On Aug 25 16:52, Beata Michalska wrote:
> > What you are saying holds when m,n ~ X. But if X >> m,n, the X component
> > dominates. On most platforms, m and n are typically 1-2 us.
> > If X is anything >= 100us, it dominates the m,n component, making both
> > time intervals practically the same, i.e
> >
> > (100 + 1) / (100 + 2) = 101 / 102 = 0.9901 ~ 1.00
> True but that does still influence the error - in this case that's ~1% so
> negligible. But the overall error magnitude does increase when the range
> between min and max of the possible values of m and n gets bigger.
> Question is what's the max error that can be deemed acceptable.
> And I'm pretty sure there are platforms that would require bigger X still.

I think 1-2us is the typical m,n value for most platforms looking at
past measurements in related threads here (it
might be a little less, but it's a little challenging to measure this
accurately with ftrace, since the timestamps have usec precision).

Even a 5% error would be a great improvement from the current state.

>
> >
> > > >
> > > > There have been other observations on this topic [1], that suggest
> > > > that even 100us
> > > > improves the error rate significantly from what it is with 2us.
> > > >
> > > > BR,
> > > Which is exactly why I've mentioned this approach is not really recommended,
> > > being bound to rather specific setup. There have been similar proposals in the
> > > past, all with different values of the delay which should illustrate how fragile
> > > solution (if any) that is.
> >
> > The reports/occurences point to the fact that the current value doesn't work.
> Wasn't claiming it does.
> >
> > Another way of putting it is, why is 2us considered the "right"
> > value?
> Looking at the history, the argument was pretty much the same as yours: was
> considered sufficient for most platforms [1]

Thanks for that link. It provided helpful context.

> >
> > This patch was never meant to be an ideal solution, but it's better than what
> > is there at present. Currently, the `policy->cur` is completely unusable on CPPC,
> > and is cropping up in other locations in the cpufreq driver core [1]
> > while also breaking a userfacing ABI i.e scaling_setspeed.
> >
> > I realize you're working on a solution, so if that is O(weeks) away, it
> > makes sense to wait; otherwise it would seem logical to mitigate the
> > error (it can always be reverted once the "better" solution is in
> > place).
> >
> > Ultimately it's your call, but I'm not convinced with rationale provided
> > thus far.
> Actually it is not up to me, I'm simply sharing my opinion, which is:
> we should fix the problem instead of hiding it.

I think both options can be pursued concurrently :)

> Setting that aside though - this change seems rather harmless.
>
> Aside:
> ./scripts/get_maintainer.pl --m ./drivers/cpufreq/cppc_cpufreq.c

Yes, I use this for all mailing list submissions (including this one),
so I believe the maintainers should be on this thread.

BR,

-Prashant

