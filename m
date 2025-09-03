Return-Path: <linux-pm+bounces-33755-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4812CB428E2
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 20:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89961BA7323
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27911368092;
	Wed,  3 Sep 2025 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbF+4tJ9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F5D368088
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924861; cv=none; b=F2l1R6rmoL9m48ydT//mmSVhsp/4Ek51fyeaJrPpuSQhRxqHnb1wxlsqDCYnS+l3gWjhiaKnB/KpVAzNNquh+aLG9sIuTKtebN03LPaGDcPM7GR5mWoZ8QmTsk6qI3J+iVk/8g3rlfdcAdLd4VdDJow/Oq+1V2cNGT/beDazJGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924861; c=relaxed/simple;
	bh=zJjGGqpmPeznMGKNyFMQ/xpPauRsREJRf3zX5sbLYGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=It4vkC7bRIVmoryfUvttKzRLh0JKgbmDC0I3Tdl3jlqHLt2mmuxWzH2M1aBg9F0z7aHIMhT/RxmQ3GWSajhhMmnHsam6u67gMOzzp9ceZwgJ1oSAkfOxk8LsOz6c1LnReqJaZzm0/J/nv4aFo7Hbk2So9E6/iFiSIjKQ98cyULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbF+4tJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC76C4CEF7
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 18:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756924860;
	bh=zJjGGqpmPeznMGKNyFMQ/xpPauRsREJRf3zX5sbLYGU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tbF+4tJ9JBTZRrO/bKfG3N/Q+D6rFAeqNF36Gw85VzeV6ZbsNyjpDXddc7DSSsQd7
	 G+sjGpZyBSYlObcc+AtZUreI6UEhQQ2k66lFPvQekaL+3BU2GEbdNrX0mcgKgLzJnR
	 1ZvQ9VcML6V+V2JXf+jzpvC3syZqma0F6EWKQ4JSKr8uADSaMY9FHOjXL6babZznLb
	 N8sSww+M2ZlgN0gP0dW7SAd8MOfvVJ4W/1WxZDj7549ISWgc9Onzf1Mh7UzApV0PkE
	 PctJ1M0TExCitHgnXnxEHpNH6m7WFRXwwuiveF49HBU2gAqEEok1G0CQz2Z79+VdaH
	 vEOfzYy0P65Kg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30cce8c3afaso162547fac.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 11:41:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcDi3mA3ZEh4jcYM8+kyRRbJzv3LM71+9u/HmaGw3M3EkTi2W+r2msENs5MeopMheIv8fs/51ZoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXFtBWVILvbnyKz46gLIJS1LyAINio7GnjdJUv+ZMUxcYHjbIZ
	q3JxOZRJBBowjnGPIR8Nwpa0RmWJPk6b+L24Nu2gaV04lWCYSWPeFrKdhResDJhfRxIG4pJD8BU
	4DaXT0RzFVhvMpJf/kggraYB0oDszq0E=
X-Google-Smtp-Source: AGHT+IF2MT9Gzl7TuNMNncNhuDxN7VPHslNv4OSuH3PIYoa7ZeVej8J/4lJ/Xw/7tFNdsARaNzvkNlKHS+9dkPUkYYw=
X-Received: by 2002:a05:6870:1582:b0:30b:85a0:eb66 with SMTP id
 586e51a60fabf-319630c7ab2mr7027992fac.12.1756924860163; Wed, 03 Sep 2025
 11:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
 <27809ad9-2a35-475d-bef8-47a06e81d647@arm.com> <3d87a8c3-ecb9-4ee5-917c-f944915ee684@panix.com>
 <d23e3fe9-a8b8-49fd-8198-8868b41ee57f@arm.com> <03d67820-1e21-4361-b539-10b3ad346155@panix.com>
 <fbf349ec-f200-4eff-9a5b-6674a1eef52a@arm.com> <d9e8f92f-08d1-4006-accd-7a2b65b0bc6c@panix.com>
In-Reply-To: <d9e8f92f-08d1-4006-accd-7a2b65b0bc6c@panix.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 20:40:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jmMbWjFZUZe56ZYzjsHYE1=fSb+5MWNLMN_K4ZCJPu+Q@mail.gmail.com>
X-Gm-Features: Ac12FXwYA8JVDtyA134MbjxCn3mdhOpAv11AN_Kl986ygEP7yBUdvgQnqwXPkaw
Message-ID: <CAJZ5v0jmMbWjFZUZe56ZYzjsHYE1=fSb+5MWNLMN_K4ZCJPu+Q@mail.gmail.com>
Subject: Re: I think there's an issue with e3f1164fc9e ("PM: EM: Support late
 CPUs booting and capacity adjustment") if there's "holes" in your CPU topology
To: Kenneth Crudup <kenny@panix.com>
Cc: Christian Loehle <christian.loehle@arm.com>, lukasz.luba@arm.com, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:39=E2=80=AFPM Kenneth Crudup <kenny@panix.com> wro=
te:
>
>
> On 9/3/25 10:26, Christian Loehle wrote:
>
> > Yeah looks like we're dropping that debug message.
>
> Huh. Then I guess the whole thing's a non-issue after all- but that
> being said, the whole point of the reschedule is in case cores come up
> later, right? So in a case like mine, won't it just keep constantly
> rescheduling?

It will, but that's a separate issue.

I think that it needs to back off exponentially or something like that.

