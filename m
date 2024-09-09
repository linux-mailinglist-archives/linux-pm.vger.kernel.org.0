Return-Path: <linux-pm+bounces-13902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C050971F68
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 18:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9982B239C8
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 16:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96BC136320;
	Mon,  9 Sep 2024 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK9YhJUn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F871758F;
	Mon,  9 Sep 2024 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899979; cv=none; b=YSG88dHBOQEvTpeS/WqHnIwNVwL69xtL3wQC32wo/8fJhanMPTjXKv5vcRckm7+TXnJ5dhXmVyE1KgsDsMnmaPYo/n7EkqNFMxrRsObzy+RiIjVsOzKDYbZN6G2gFH/AHt0q/yc+DdpibhlFoTakbUP7GFw7mz1+rXo10Og5bo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899979; c=relaxed/simple;
	bh=BBBQHKs07gowSF4qrKQ1rEREPDQYmNrpskFmijSyLvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oC4Rlfbu2//M03qm1OUUUdu9YcfZTeetcs1WS6lvP+s4Euny+Fp7xiOrRxVdFvHmTRV7v37GCFbqvvwG8vzcHeX9/gufUW9HJCMRvtLtJPH4RPOb4WT4rd1dEru53uoEyThsK2s8QrHiYzc+xp75s6GJXtld3xhHkLeJ2U5+8+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sK9YhJUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DF7C4CECA;
	Mon,  9 Sep 2024 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725899979;
	bh=BBBQHKs07gowSF4qrKQ1rEREPDQYmNrpskFmijSyLvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sK9YhJUnd2ub+UCWoScloiyz3u41HIfaBA3tFTgDw5/z9qz29Rez+fYpRX24RqElR
	 MbuDcKXFG78+oCplumhji7eVrD+2RBHGlo76+cXpjzsQlJz9F+oSuiYbRpJ+khPlqo
	 3j9kbVrC9McW3wCFWdzdiCIy+C0lNvHh5ld8EWyd+26boReclLIexaM8eWFHXZqWdZ
	 JWCJ/cumOQ8jq4EhGfXEg97Ul79WWpddi3LoP/rVL34tpTL7goZ9t3WwRp3hg6/ZIo
	 pbyHrdhAQdWNRM3uVaTDHK0gje3N1V9T2SUd2djSoOFqvBvMRICslXUWR3uzXJiyn1
	 kKcmJUf1DwE7w==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-277fa3de06fso2339664fac.0;
        Mon, 09 Sep 2024 09:39:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWL2srnmx7RklGxF3Q3wbwIkHFUXOr/MA7Qj6qc+ahGCEZxPnrUDqSP/IZnMciv210KjjyK3LgLqhLtPdI=@vger.kernel.org, AJvYcCWtI/yaH3yD9e2ttGeLbC3hhxw6Rja/YFcMoRI5JpPo7fTMz715F+imvFWHhf9zs9lqO5mXX6Ke/V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvInTyNN4YLbaW6zqR4XZa+p4td96sgIG0jqe8t4zYOkQmVDSY
	cDVtj1yUsJ6SNxyYAtZ29EtfEEli24I93HjQGjCuPehwjxJoMPiQy//acB36TVkMmZKNRn+G/IZ
	OBO02OTEUgybI6x6w8YzYwC3jzlg=
X-Google-Smtp-Source: AGHT+IFlSv9sF6npnQK8II34iFK5F5tASfgXCuvaog4txdLUUgB71YhiB2kNAWFSdGb5sjI7Ohv2ISzySyuAMzb7sXA=
X-Received: by 2002:a05:6870:658d:b0:277:fdce:6759 with SMTP id
 586e51a60fabf-27b82fac1demr12746899fac.31.1725899978551; Mon, 09 Sep 2024
 09:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813144348.1180344-1-christian.loehle@arm.com>
 <ZruDkw2XB8iXMepz@jlelli-thinkpadt14gen4.remote.csb> <1f5f7643-8743-40f4-80ac-0534affd70cd@arm.com>
 <20240909132508.GD4723@noisy.programming.kicks-ass.net>
In-Reply-To: <20240909132508.GD4723@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Sep 2024 18:39:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7DTW=MVyVa0JXKgHrBJN9duRaPjOZdhZLNNH5-61dFw@mail.gmail.com>
Message-ID: <CAJZ5v0h7DTW=MVyVa0JXKgHrBJN9duRaPjOZdhZLNNH5-61dFw@mail.gmail.com>
Subject: Re: [PATCH 0/4] sched/deadline: nanoseconds clarifications
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vincent.guittot@linaro.org, qyousef@layalina.io, daniel.lezcano@linaro.org, 
	rostedt@goodmis.org, dietmar.eggemann@arm.com, 
	Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 3:25=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Sep 09, 2024 at 02:01:38PM +0100, Christian Loehle wrote:
> > On 8/13/24 17:02, Juri Lelli wrote:
> > > Hi,
> > >
> > > On 13/08/24 15:43, Christian Loehle wrote:
> > >> A couple of clarifications about the time units for the deadline
> > >> parameters uncovered in the discussion around
> > >> https://lore.kernel.org/lkml/3c726cf5-0c94-4cc6-aff0-a453d840d452@ar=
m.com/
> > >>
> > >> While at it I changed the documentation example to chrt instead
> > >> of the schedtool fork.
> > >>
> > >> No functional changes.
> > >
> > > Looks good to me!
> > >
> > > At least for docs/uapi,
> > >
> > > Acked-by: Juri Lelli <juri.lelli@redhat.com>
> >
> > (gentle ping)
> > Peter, do you want to take {1,2} and Rafael {3,4}?
>
> I'll queue the lot if that is okay with Rafael.

It is, thank you!

And please feel free to add my ACKs to the patches.

