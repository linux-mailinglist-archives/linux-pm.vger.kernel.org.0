Return-Path: <linux-pm+bounces-8536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144EC8D88AB
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 20:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0691B2249C
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 18:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36DB1386C2;
	Mon,  3 Jun 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9qUq3RU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C21CD38;
	Mon,  3 Jun 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439931; cv=none; b=mKl3BBh1VdY2WGkBkr7R4ctg1SrN8ToKZf2uE6hXH/OBqJ5uKMFLQeNO2bEPsNkyjYqCmaP8klUxX+Z6LF/FhxBJmGw+kFJeKaMKNb9oG4LqDNvCK6JzunhSnXIVWWr8edi1IhGcbyu9tejd7YTJrS5boyUPo0EVCZQqqYUr52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439931; c=relaxed/simple;
	bh=4yr4QQIdurPtFUFFeSUfFHi9As9eyEuhMm4OE8L2If8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tziZvhpQdVHBJ47vZfJK1lgxBUusL/ZyTCg2d/aDRKUFl1me0kzcHgPoNkKV+iz2Khf1ohey51w3/0QyjUCpDkud8AZTmQWXytDYqMz7Swvfze7Eab6uAJKCCwpheAigQHLdfDZXuSbAmOegzuCjtKf4MAXgydyICQX5XcdwODg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9qUq3RU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A2EC2BD10;
	Mon,  3 Jun 2024 18:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717439931;
	bh=4yr4QQIdurPtFUFFeSUfFHi9As9eyEuhMm4OE8L2If8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k9qUq3RUnXeNwmd39li0X8sX8iIaEBGMYnwLDY+/SUQjYkJwi2TLwFlbH/YNw1IRn
	 veSJEVOedXqtdx4Hahp8+rIxs17SqeGAYJg6dXZG4CJ10HPLQ4OQcNwZpKyKKMgOf2
	 xuE3ZvWsqMSgjnODErzkQP0JFolRtCd6Mt3n3aedkTQLKK8OmxzPGdq7NupmlfaJ+x
	 FYuc8jDOBRgl6BvEC8JGJ0z0QH7s0Nyp5qEAXPVkguGWpMcopCPO8lu2Ba0vA+Ya2T
	 KX0e4lIckQ8QUvKWCC0pyoT1F0b/M2L4LXfpI9H50S2DpLy5uIkn4qv2Hjac3oZGlv
	 PDck93zTcpAHg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-250aa23752dso85965fac.3;
        Mon, 03 Jun 2024 11:38:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7QGTD+8e+/VZrAWwpXbpEozZTH8CuMurmcD6PH4BMkqQdSG+h5AVMZLS+cv6PIya/EY0tXFMKQ/WG2XXDFr0ylW+di/tAvTBgn3mPjM4U456OWCv7O+yD8IrRojmiJ++RUdjziZ8=
X-Gm-Message-State: AOJu0YxKWZhqQb9wdNpYUVOgl9Wv4waXGj+nJmNUUod1kadlgh/BUWX3
	4osoCTuh2w5xSChrfN1qX6T2JE2OresDa/IYDbL+cLfqZGStMFFuXoFg4HmDILeiJmrrGDASvMa
	gGrLDQiDw/LsqBH+Ij01RUDKkZk4=
X-Google-Smtp-Source: AGHT+IFXo2Sxmq6NGsIJL4TZKFcFTzyZ2geDQBH/dxhK1Kdg6g6/89vdmXluYReeqUcBM5Oj9uRcXgI7Y1ZlwKtwiFY=
X-Received: by 2002:a05:6870:f145:b0:24f:bd2f:28d0 with SMTP id
 586e51a60fabf-2510281e316mr182471fac.0.1717439930125; Mon, 03 Jun 2024
 11:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1051df4c-067f-455e-8c7f-9dc47dc8ed00@yahoo.de>
 <7f4a777b-88f6-4429-b168-d1337d291386@yahoo.de> <435867b5-029b-419f-bb7f-2d4902c62556@leemhuis.info>
 <a97f9f4d-17f1-44cf-a0f4-634fd38aba2a@yahoo.de>
In-Reply-To: <a97f9f4d-17f1-44cf-a0f4-634fd38aba2a@yahoo.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Jun 2024 20:38:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jwvq6W0u7Zx4GzQxJOnrF4KvN1RHtqqDcaMvN6yp0hDg@mail.gmail.com>
Message-ID: <CAJZ5v0jwvq6W0u7Zx4GzQxJOnrF4KvN1RHtqqDcaMvN6yp0hDg@mail.gmail.com>
Subject: Re: Regression, thermal: core: battery reading wrong after wake from
 S3 [Was: Bug Report according to thermal_core.c]
To: "fhortner@yahoo.de" <fhortner@yahoo.de>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 1:10=E2=80=AFPM fhortner@yahoo.de <fhortner@yahoo.d=
e> wrote:
>
> Thanks Thorsten for the side note.
>
> I have compiled kernel 6.8.11 with reverted commit
> 5a5efdaffda5d23717d9117cf36cda9eafcf2fae.
>
> Battery Status works fine now with reverted commit after S3 Sleep and
> Wake cycles.

Well, the connection between the battery status and the resume of
thermal zones is somewhat unclear to me at the moment.

Most likely, the commit in question changes the timing of system
resume which affects the battery behavior and it seems to be related
to the EC somehow.

Let's first see what thermal zones there are on your system, so please
send the output of

$ cat /sys/class/thermal/thermal_zone*/type

