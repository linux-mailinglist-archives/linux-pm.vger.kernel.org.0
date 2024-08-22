Return-Path: <linux-pm+bounces-12746-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA1695BB21
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 17:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167EB283D02
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73C01CDFD2;
	Thu, 22 Aug 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnUY0Ow4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE61CDFC5;
	Thu, 22 Aug 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342094; cv=none; b=Ljh4eZ+Yq6FPV9/j4d/QME2E0gJKXOyM8VqGKafWIhx4QwBeyHPkaFCHLRBYQaTA/0K60fzYzI2GT9b8M+HTev9eB3BykJSCZ1jy8/UmogSLoxrb1TscxzL1mFYHR8Sb7oA+TvYbf81hzIk6pwSHtPkVZCOlli3ZyrshL/mG+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342094; c=relaxed/simple;
	bh=WKec4NlHrgBQuKQObzf8ueKRngkKynh+ktRXrK59aFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZ6wJUUw1diDbZGjvbDZbW449brzLw4iHHXtk7KMojNTuvoHSG6r12hFIxujw3ZBmwMD5W9n205Q0Mojd44zueAqicbJZKdM+maQSVZvQHO+rhXDm8JdC6EMdPmaRoOzA8pwmpPQlDe5HyR3MtzoecmJgkXY4Z14Xy47RgR53uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnUY0Ow4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDC5C4AF0F;
	Thu, 22 Aug 2024 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724342094;
	bh=WKec4NlHrgBQuKQObzf8ueKRngkKynh+ktRXrK59aFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lnUY0Ow4yaKrViI3wX/7/mwJJS30tLqaELObTwwKG4r1Zl/FH7LbtIN2aOfa3M9ni
	 yIaaZtQgcxg7akCgkZSdjiefcfUvBVCJFnbnbsORHqeVU4flxQotyqIIyJb/nVOlCd
	 smmkCpH/6pPRe6hlPD1hYs0FcSNX0BWrGYUmcNc17C7AXqfnNLe1VHwG8L+rk/yEEm
	 tKu0s4ggiGITx2mR0AQVE/zGTz70rEoJn798Nxbr+S99OFChcVjWub0pyoZE+ftVVE
	 cmT/CnOj+lfPiMOUWmfpguXbED4DHGkVaV3YhxjpjXQKNYhfXkW52OjLqC6mQLCVXb
	 VOhYq/h0ujUZQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5dca9cc71b2so675621eaf.2;
        Thu, 22 Aug 2024 08:54:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUD/bCN3MhKM491QZ2ITOMq6EmCI0foBWLNoafPa8FjnUDrol+tgggFI9TafJl0vFRNhuMKrd58gU0=@vger.kernel.org, AJvYcCWPJndB1vdu77q5P5hCK7GyvMBTI7cIrLgz6txpncotsCFkjSz9v2ZehozbwZ8pTtHBPEB+J8HQHlGU7Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+iAzX/7a6EHnDYIcW5ofaBoMFZ0d8SS1Wlo5dYcK8XTHWF8MD
	+ia8By6Nwi1ZN3NQVj6lJQIPlrZXREhZTzPnG6Yy4HgVzhAStQ/JJBh7eJZGflijd/0E3gEQeLs
	UQXXuD806CsKYuD/GJeuPeHGUOVM=
X-Google-Smtp-Source: AGHT+IFmZe/6vpQVg89XlmYsFsnE9NnHUr6WCVNNJY71s5kEfCnwT9IBGKKooPjPJpl2Wm6W9DpJUCQmzXHhAXZ8AOU=
X-Received: by 2002:a05:6870:4414:b0:25e:129c:2223 with SMTP id
 586e51a60fabf-2737eefc3c7mr7227853fac.19.1724342093537; Thu, 22 Aug 2024
 08:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
 <f3d2c104-360a-4da0-8d77-59af89ebda2b@linaro.org> <CAJZ5v0hiR0sqgfR1WiuT=tXx3XRWgAE-j3biEMMaV5FjiSZwbw@mail.gmail.com>
 <9e6d817f-1fcf-4d31-b0c5-d68753e1f949@linaro.org> <CAJZ5v0jU4xOwgA8neFVMijV+T9=oiOBoEjD9viaCq=g51wFGkQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jU4xOwgA8neFVMijV+T9=oiOBoEjD9viaCq=g51wFGkQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Aug 2024 17:54:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iGkGeHV5a_LpeVFTnzKAZf9ynmpYWfH4D95jw2t6sFOg@mail.gmail.com>
Message-ID: <CAJZ5v0iGkGeHV5a_LpeVFTnzKAZf9ynmpYWfH4D95jw2t6sFOg@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal: of: Fix OF node leak in thermal_of_trips_init()
 error path
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 3:31=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Aug 19, 2024 at 3:22=E2=80=AFPM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 19/08/2024 15:20, Rafael J. Wysocki wrote:
> > > On Mon, Aug 19, 2024 at 12:12=E2=80=AFPM Daniel Lezcano
> > > <daniel.lezcano@linaro.org> wrote:
> > >>
> > >> On 14/08/2024 21:58, Krzysztof Kozlowski wrote:
> > >>> Terminating for_each_child_of_node() loop requires dropping OF node
> > >>> reference, so bailing out after thermal_of_populate_trip() error mi=
sses
> > >>> this.  Solve the OF node reference leak with scoped
> > >>> for_each_child_of_node_scoped().
> > >>>
> > >>> Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately=
")
> > >>> Cc: <stable@vger.kernel.org>
> > >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >>> ---
> > >>
> > >> Applied, thanks for the fixes
> > >
> > > Is there a place from which I can pull these?
> > >
> > > It would be good to include them into 6.11 as they are -stable materi=
al.
> > >
> > > Alternatively, I can pick them up from the list.
> >
> > I'll send a PR for fixes only. Let me double check if there are other
> > fixes to go along with those
>
> Sure, thanks!

Sorry for pressing, but it would be good to get this material into -rc5.

I can still pick up the patches, I don't believe they are controversial.

