Return-Path: <linux-pm+bounces-15550-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DBF99AB9E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 20:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2F92B231BB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 18:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F5E1CF7AD;
	Fri, 11 Oct 2024 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XekxK868"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB697868B;
	Fri, 11 Oct 2024 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672721; cv=none; b=G7gf/NpP1YKLMwtGkTCHCAMWKZgrMcKoiULYFI5jSA6HG6La9LYqv9VFBK/0M0ZS2glncFAqP1tsaP47N62kkOG4A1jtw2MEzgb9bywBcNvuIiLNvGFSAxogPH19Gh4aBC7tZ+1/9W7H6gE76k/ZqvZa2DOkK6KqHmN1RNStdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672721; c=relaxed/simple;
	bh=Jc/nk5LTKrWWlFX/B0O6+1ZZuWFZCL6ha1DyHuXXhvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0P4B86BZ3xw5K1ZlW5to8d33gixsqZD7iKifJNWywttR4nqKzfNcslenHfXHdnJm3899Llh9DxHhCjDVMtyJEy9DV95lvFO6VJm0H+VyhhVMuBptRMd5blwdNNWFdQFgfv8GKsIq15pAlgUE6++tVd73oex8HsYyyK69zsxeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XekxK868; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C653AC4CECD;
	Fri, 11 Oct 2024 18:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728672720;
	bh=Jc/nk5LTKrWWlFX/B0O6+1ZZuWFZCL6ha1DyHuXXhvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XekxK868/qmIr+WV4Gdx643wi/FAPj1+Dr5/cd5E1nBZ7arwhUMgMH8lay+xOSN7L
	 Axo0j9S+xZLB617xe5K7YTctJlA6eGUaa/a6YT9MQZEmftga4m04tH1hHiWw2aH+BG
	 n+dsUqyfrSRF4OJOEnvwTc9A7tjRi4bpFRk96mHPYK1UlODShOfj4Mhmpt5jOLPBU+
	 A+fHU+sjXRPEl22W5+AeWx9WqxzfLMCG92AFGH0Dx7QzoOgPN/JJDHvCly1GMDxIru
	 JS53WiZItW0dicO5fISih4iAbma1zYB1AAzPQ4FMumTzN4oATSYhUe874Zb+g2xCfZ
	 zM4to4FOOKUWA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5e98ea02c9dso1013092eaf.2;
        Fri, 11 Oct 2024 11:52:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YwFinu3UG7yIMmowMEJ/rfsqVNUTDj5Zh5EzhJXpNsfSEi7xL83
	Cu3E6bztZSSQxnBDCVdx6SuyGykas8Ld+WhwEA0F2+AJ0DIZJ/jRt4tle29jdHGzFwjpShb421S
	ZsLFWeVt8UMDR6bFR+UK7s2ZDlZk=
X-Google-Smtp-Source: AGHT+IEd67iJL9BcP9kjnUS1DPfAWINDJ9CFPDmjc8Imw0r0o5tqFW+CEMI0HOFVpbVlrJcCb2HUIW2I+X77ucbctsI=
X-Received: by 2002:a4a:ee85:0:b0:5e5:b652:9d14 with SMTP id
 006d021491bc7-5eb19edd573mr2166175eaf.1.1728672720097; Fri, 11 Oct 2024
 11:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4985597.31r3eYUQgx@rjwysocki.net>
In-Reply-To: <4985597.31r3eYUQgx@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Oct 2024 20:51:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iV4-3-sqmK12ZoRQXzUSgO0NDySe5LZ3z7FMQOFJCymQ@mail.gmail.com>
Message-ID: <CAJZ5v0iV4-3-sqmK12ZoRQXzUSgO0NDySe5LZ3z7FMQOFJCymQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] thermal: core: Reimplement locking through guards
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 12:22=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.n=
et> wrote:
>
> Hi Everyone,
>
> This is a continuation of
>
> https://lore.kernel.org/linux-pm/2215082.irdbgypaU6@rjwysocki.net/
>
> and (quite obviously) it is based on that series.
>
> The majority of the patches in it are new iterations of patches included =
in
>
> https://lore.kernel.org/linux-pm/6100907.lOV4Wx5bFT@rjwysocki.net/
>
> and there is one new patch ([02/11]).
>
> All of these patches are related to locking, but some of them are prepara=
tory.
>
> The series as a whole introduces guards for thermal zones and cooling dev=
ices
> and uses them to re-implement locking in the thermal core.  It also uses =
mutex
> guards for thermal_list_lock and thermal_governor_lock locking.
>
> As usual, the details are described by the individual patch changelogs.

This material is now present in the thermal-core-experimental branch
in linux-pm.git.

