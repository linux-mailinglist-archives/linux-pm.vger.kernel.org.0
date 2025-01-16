Return-Path: <linux-pm+bounces-20561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC215A13EF1
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FEB3A6BAF
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C948422B8A0;
	Thu, 16 Jan 2025 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjP2KtRN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A922C9F1;
	Thu, 16 Jan 2025 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043867; cv=none; b=hAdzUKGvdyr4VsHsIWCDLah0gOrXPFo5lutLrQuyqtYkMqwogkMYAAXOhFN4S2zn+Q+Qfa2GHmiXz6NukJkXRdtKt6/mapGhhOxiD1IPxpZwINhxEkbY24iv/cb5v9sjZV8Vf1OWNcv4QbMUtAGMU3+aC4uZdd11fzb49cyPXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043867; c=relaxed/simple;
	bh=vQPjsuN6FQji3BEBE8K8dx+hbZAUbUP9ZCtbbWZvkwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAVhONVQVUyVRHiEsEGlaxSUZfnbKe2/KzoAwcKq5pga9o/FOiFSoDn6+jI33LNWMnib4aexK97bXfnINN5GnVWNdhrXgWTO1KgBHmWjZNy32GGYKaGdekfFbzKSlWT90IJGjh19tDe2uiVVgyi7FILT/hntskrYLdt7+M/pBPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjP2KtRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2855AC4CEE2;
	Thu, 16 Jan 2025 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737043867;
	bh=vQPjsuN6FQji3BEBE8K8dx+hbZAUbUP9ZCtbbWZvkwA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bjP2KtRN3WJXsvNBprn4d5TZ/sw9MyNZDZVt08Jbt9/wW5pwKFlbA9vfHpLhN9zJm
	 q0bzTwYOhbpQ80Z4LeshMQatt4HjhTYDWHOcPD8jOfTKQlyg+oPW7lBawqlihPDUyU
	 puhw2EfPKFNLYmXB4FJrY3x6KbcjXYZumnvrIG5FAEb2/OIn5/y7G+yDfP3+zlis7X
	 SxDNfg3oMsdam8yED9nfwapSII6QgHNL/a/ewzmWuQpAnm01LjYQPyFw3W4XwfAWOb
	 rt+vPwoDtVA7LfR8UmPRpcaEq+UbycIGH7nX4XDLIg+QAEEBE9fxDHQsoCWq21/mB4
	 H7qJM9MrcyBng==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eb9a0a2089so585587b6e.1;
        Thu, 16 Jan 2025 08:11:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4YGw0sfBKWzTBquuqxUzjYe4qweW/kX6lL64OcX5o50M4dDzU1keFNi+6IYOtpLuad8oNa68UGwAr1cY=@vger.kernel.org, AJvYcCXKcNbE2cpPytPD81fQXR1OTApLxsluyqDBg1qC6XhDFhN+xoErZHsDntrski8mdT4CNl09W7sQQnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/qpbgDPXaqezRKgmQ+Sn3+GA5pZ74SDZXQMQGDZHKWq+mo7Pc
	IV1Bcwg+BLEdxYISLQllEeXZb9X6v3mes07QVIx5RQlwiLDaDGFkG8Nq5nesvo/lnI3fW7GlREB
	dvq0w8XKfJGh0Fitz6uHfN8MmvWY=
X-Google-Smtp-Source: AGHT+IG+PH3z0Y7Hf/brP+skAArWJjojmnf4tgK7ah04xOzOTncqp+79yN6VTBPwS/HALKHThyR/ESaOi5vufeUrgoQ=
X-Received: by 2002:a05:6808:3c8d:b0:3eb:7492:63be with SMTP id
 5614622812f47-3ef2ec267dcmr22025668b6e.24.1737043866525; Thu, 16 Jan 2025
 08:11:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110115953.6058-1-patryk.wlazlyn@linux.intel.com>
 <e6c49f30-b32a-4ad0-98e2-634113011f90@intel.com> <5f24fe01b6dd0ae0e6d91209e143f2faff6ae017.camel@linux.intel.com>
 <860da841-fa82-4984-9e34-fba02e7aa556@intel.com> <fbdaf69ec121836db4d4611842bd0c1b93224bf6.camel@linux.intel.com>
 <ac0babd8-2c05-4fe9-a2d0-9972172e1e92@linux.intel.com>
In-Reply-To: <ac0babd8-2c05-4fe9-a2d0-9972172e1e92@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Jan 2025 17:10:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j9mx694gN-jk90hHPNDjHHFs-rpwQm2zkeKT_QpAeH9Q@mail.gmail.com>
X-Gm-Features: AbW1kvaijP8Q1y8Z6w1skOVMRgf-JaMhfm8nOyZYuZpoO5lcSf52YCpkSjulY38
Message-ID: <CAJZ5v0j9mx694gN-jk90hHPNDjHHFs-rpwQm2zkeKT_QpAeH9Q@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] SRF: Fix offline CPU preventing pc6 entry
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:02=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> > * Because version 6.12 is LTS, there is a good chance that users of nea=
r-future
> > new platforms will run 6.12 on them.
> > * If a near-future platform happens to miss the firmware workaround for=
 this
> > issue, having these patches in 6.12 will likely mean that most users ar=
e OK.
>
> Make sense to me. Any objections to adding "Cc stable v6.12"?

Well, that's not what you add anyway.  "Cc stable" is a maintainer thing.

