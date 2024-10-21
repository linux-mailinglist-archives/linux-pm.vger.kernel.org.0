Return-Path: <linux-pm+bounces-16078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6859A6664
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0AF1C21E42
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E9D1E47AD;
	Mon, 21 Oct 2024 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSCmy9gt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A701D221A;
	Mon, 21 Oct 2024 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509381; cv=none; b=PM0JcL7ckNBJpX/L8VG7iD4+2ZhTAmFGQeOF1rPLyFtRUVNOU81RrlJO5qkKrenyVSoNK5buNX6CnyrKnj6XjDOCIQF6n8tPB/BI7Eq6zVfIeSQquOqNGayJ+fcycG7cGHXTVGh6mgWGVMYI0is0Nxf3IETp84cJ7O0PcYCrHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509381; c=relaxed/simple;
	bh=FXMKF0x3pLRWghRqjicLkR5xFXNDlk9ezTRxo7rl6ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJh8KvAtOyvIg0LMAf1xTKG6i4JiEcRPyDvgs/OnI4jCZuIOb/uMUQUA4+csUYBOD45QGF2GI0zUr41fwmnmjwJ3Yg+B/CUa3fD/2dALfAhHKJ1SJZApi4pW6Zq89evyHw6cLuGPlG22NEuka7wyvtQhiXLq5m/ZdgzDHgY0Zew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSCmy9gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA54C4CEC3;
	Mon, 21 Oct 2024 11:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729509381;
	bh=FXMKF0x3pLRWghRqjicLkR5xFXNDlk9ezTRxo7rl6ks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FSCmy9gtrdhZEy5l+mNIBVkLXG6mWs4Gc1w8n/PJNT6/VNGUSu4anGX+07MtYAeOw
	 pZa0VzY0RxM+1IXwmiri9ldCCiRSXriTMpz4FmYg8RY5ShZ8+S0blC+ioTNg/GO+pZ
	 DSCwf9RwLIFZIOxGc52Rk/WVOn+98QHBgLFLj+YxLb9YNio3DzhwK4v+DQ7Hs676ki
	 i+LfzozVfWy14rwEH3bu1SpADYIUT6fSG3iTUn2FAog+d3dlqabiqL+XdlviCMDo7u
	 mM9s8ReD7/FehU9VZSSLhjZlhYNwodf/wiD6PjuDdHvZaNgDWuS4gIbNyvWmFLDvQU
	 HJxTw3I28dY3g==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-288dfdaf833so2035420fac.3;
        Mon, 21 Oct 2024 04:16:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YyORZkVFAzQP+hY06Ibj+GcFfgTYqortinWysMTL1G5oXQqodes
	QtKi/Fyt0DYt6FA25oqp8SlZXNbIYgjRCWNAeN2Ui3pC9jJr/f7F/PrNuAUWLc6FDHljyQW3mTg
	eJX8mJd3oDf5//3Jvsby3r5/2ZK0=
X-Google-Smtp-Source: AGHT+IE7Y18PjDlwjRnyNjeDvx+G55f22d+COSDhu7XbrReHy5no4QHiXjP3WP4pNIbW69mb7Y+E3hxZm5lmIjO00z8=
X-Received: by 2002:a05:6870:40c7:b0:261:1600:b1eb with SMTP id
 586e51a60fabf-2892c4f0b20mr7810015fac.31.1729509380637; Mon, 21 Oct 2024
 04:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4958885.31r3eYUQgx@rjwysocki.net>
In-Reply-To: <4958885.31r3eYUQgx@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 13:16:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g_ALycyT7Y2GwebF_ON-EMP_WGoTn4+1V0ZisK1vwROg@mail.gmail.com>
Message-ID: <CAJZ5v0g_ALycyT7Y2GwebF_ON-EMP_WGoTn4+1V0ZisK1vwROg@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] thermal: core: Use lists of trips for trip
 crossing detection and handling
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:37=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> Hi Everyone,
>
> This is a continuation of
>
> https://lore.kernel.org/linux-pm/4985597.31r3eYUQgx@rjwysocki.net/
>
> derived from patches [3-7/8] in the following patch series:
>
> https://lore.kernel.org/linux-pm/4920970.GXAFRqVoOG@rjwysocki.net/
>
> but mostly rewritten.
>
> It is based on the observation that putting trip points on sorted lists
> allows to reduce overhead related to the handling of them in some cases.
> Namely, it avoids the need to walk all trips in a thermal zone every
> time the zone temperature is updated (including invalid ones) and
> generally leads to cleaner code.
>
> Patches [01-08/10] are preliminary, patch [09/10] makes the key changes,
> and patch [10/10] is a super-cosmetic cleanup on top of the rest.
>
> Please refer to the individual patch changelogs for details.

This material is on the thermal-core-experimental branch in
linux-pm.git along with

https://lore.kernel.org/linux-pm/2215082.irdbgypaU6@rjwysocki.net/

and

https://lore.kernel.org/linux-pm/4985597.31r3eYUQgx@rjwysocki.net/

which are also present in the thermal-core-testing branch.

