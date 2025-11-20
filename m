Return-Path: <linux-pm+bounces-38323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04001C76630
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 22:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 978174E1F92
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 21:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15AB2698AF;
	Thu, 20 Nov 2025 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIMOAoWK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB5F22F177
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763674521; cv=none; b=EUUAbdoKDQg+AQrnJmBxaWQ5J6I1kgTZ21JXVakTkxWu36HBiJQ5ZYcLQMfGDh6gwEPAZYEP6P3F2V1z+tS8oIVYAU9juC+rA1ZRBANbk/3vh1CyUce9lP301+fOgV+eAWU9dbUykn4WAO1shSfQAqRgpKGD+HIQDlLBfU90ARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763674521; c=relaxed/simple;
	bh=LieaM56IF0xfrNWNo6bCzvcljN997Wt3w5z7Gpkekro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDQvhBcMvbssQgvi9XWmqcyz8QZeOss5RPlRnzNxE7SoiBJUlaZvst6Zq6IXnPvAdNcB1uPLnPhTj3gcS1//mnD9ajeEGHqYWWL1iChLrKv7LJCExh1dflhpCIIv8kjQauw1dkhIpOZSQmrWSBhrMG4+JowKlHR7R9AjY2P0094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIMOAoWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200F2C116B1
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 21:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763674521;
	bh=LieaM56IF0xfrNWNo6bCzvcljN997Wt3w5z7Gpkekro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SIMOAoWKBtVClNYGsL9Let29WuLiKvs7F8gAlkXpdWl5qXoawfcuEfaNnVCHpVOex
	 cBJdFKn9xQtrQVeMzpX838exUSPO4QsU5FTw5suZNQO8bAEfTkRQzyhdf7J9n6hnzG
	 E2bfJuNEcDMaFlhCZqMvS4k1SQY0wq/iLC5hsso4hkpozEllqtFEjK4XpVvHafaG7N
	 ErbkATrYN0/A1WnOK6MIDQNYUZclBCGKxZY76XBvwRVn4fiHQtZ4S/rVSuWQK5hN7e
	 Bco1lQe6bZyFFnqr1Q+u4xi8fupYFZVhioQzePZBkXxyh5PG/Bkb2bBbf7Mhq8K7pg
	 BKJds6cN20aYw==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c765f41346so543618a34.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 13:35:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoidwIpIDgd0ONUN/xDxYz93tbD7XhxtBlr0B/+pisRPIVGA++Xt9q+OhSuUIEJOAFrlSsKEnK2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZpGVYKCxRw4WW0XCPiMCjT8kaXNLta+qlVX9So/kjbl+0Wgj
	nYtdt1GrqMzojXXIUKcYGCdXQCoz3sNN0T5FNp6Tt3bJZ5DeVUoG7Jr9A097jJ1Hw2alZtTkpjl
	4wp8C/+ud1RrsLi/ZlW8yn6wMhbo0tww=
X-Google-Smtp-Source: AGHT+IHLDL8XsIx+FmrvpZU/x3JF0smbnQEXywv4ozYOCr9uNZKY7OAufgPDlPowZn+0aMO8gYbEQgI75NjXsBb3t0M=
X-Received: by 2002:a05:6830:925:b0:7c7:6309:d929 with SMTP id
 46e09a7af769-7c798acb00cmr78416a34.8.1763674520393; Thu, 20 Nov 2025 13:35:20
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119171426.4086783-1-wusamuel@google.com>
In-Reply-To: <20251119171426.4086783-1-wusamuel@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Nov 2025 22:35:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0in-am98cG9VcdO2cCz8swunoV-M6517wb37+BOKAh6tg@mail.gmail.com>
X-Gm-Features: AWmQ_bnP1TSE5bjcH02piBlYl6qM_CPmx8Ske7saypSi4D0cjpI55oW6MYx9bI4
Message-ID: <CAJZ5v0in-am98cG9VcdO2cCz8swunoV-M6517wb37+BOKAh6tg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] PM: Support aborting sleep during filesystem sync
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	tuhaowen@uniontech.com, Saravana Kannan <saravanak@google.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 6:14=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> At the start of suspend and hibernate, filesystems will sync to save the
> current state of the device. However, the long tail of the filesystem
> sync can take upwards of 25 seconds. If during this filesystem sync
> there is some wakeup signal, it will not be processed until the sync is
> complete; from a user's perspective, this looks like the device is
> unresponsive to any form of input.
>
> This patch adds functionality to handle a sleep abort signal when in
> the filesystem sync phase of suspend or hibernate. This topic was first
> discussed by Saravana Kannan at LPC 2024 [1], where the general
> consensus was to allow filesystem sync on a parallel thread. In case of
> a wakeup signal, the suspend process will stop waiting on an in-progress
> filesystem sync, and instead abort suspend before the filesystem sync is
> complete.
>
> Furthermore, in the case of the back-to-back sleeps, a subsequent
> filesystem sync is enqueued to ensure the latest files are synced right
> before sleep. The framework still allows for an early abort in this case.
>
> [1]: https://lpc.events/event/18/contributions/1845/
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
>
> Samuel Wu (2):
>   PM: Add framework to abort during fs_sync
>   PM: Call pm_sleep_fs_sync() instead of ksys_sync_helper()

Both patches applied as 6.19 material with updated subjects and
changelogs, thanks!

