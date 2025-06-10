Return-Path: <linux-pm+bounces-28338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F22AD3036
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 10:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D72E166F25
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 08:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AC628469F;
	Tue, 10 Jun 2025 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDRqf8zz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DD52820B8;
	Tue, 10 Jun 2025 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543876; cv=none; b=QmxZKVi2uR2RaAtLr8NZH/HZ/Y0RErn4mQznS02a1tXMLa1L1lQinjo0PnhGaWDzlbstIHDpV4UGR9hjMfeSPzbulwqPT6XfWBhlkG8jS6tFv/7kTWycDKL2wAuIdIiRg6rdie2nqh0bClf6jzBI4rAsOWGyQ709r49aGzuQ2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543876; c=relaxed/simple;
	bh=quoL3/AbdEFxunyDYr3lt/Bd6viOltjUaS68qAqZ3DQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vji9zy5TRrPZnU8KPWUMMVJNUTV+URgiv7Q0p+9NpUuRaIS8c4gqj+Fju4E4JUhet9MLVgiub7SiacBB95MLjJ8f1RnePcKl6fXW1gRDsuKAkmq0Qt4BgDNByZSDvME2Hu0pmNhF1vVTipyShiow+zNM9cOXfEUZPKE6khihVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDRqf8zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804D5C4CEF2;
	Tue, 10 Jun 2025 08:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749543875;
	bh=quoL3/AbdEFxunyDYr3lt/Bd6viOltjUaS68qAqZ3DQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rDRqf8zzpSFUo0jbg2eDk6j3WzKLDA90jIoYg/dklaNpFkx175lQWor1PQ6gKRwJn
	 W3g3usxWTOyIK27uKUaoYOPLGX3IfXzZ/88WSmBgkqoRt9CvADaWOOdvRCT4q1rk/P
	 bx6r5x4zOONF/fMarbOyonJC19vsFGkRPJT8EQsvTCEbOosUKMFs//DW06oRK5wCif
	 bCDE4JycDmqkjFA7L9sOB8JmeBOwTS2Hgf4z054PPsQpwMqvruLAnM1vA+yZm7klDn
	 08Y1sscR8a8Hmx0dTB5Q5ADJftiP7JYUnpKOSK7zwIYcgRygpOh4ORHNgmxoYcZsLN
	 SXz5W6YklVztA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com>
Cc: <rafael@kernel.org>,  <viresh.kumar@linaro.org>,  <dakr@kernel.org>,
  <maarten.lankhorst@linux.intel.com>,  <mripard@kernel.org>,
  <tzimmermann@suse.de>,  <airlied@gmail.com>,  <simona@ffwll.ch>,
  <mcgrof@kernel.org>,  <russ.weight@linux.dev>,  <ojeda@kernel.org>,
  <alex.gaynor@gmail.com>,  <boqun.feng@gmail.com>,  <gary@garyguo.net>,
  <bjorn3_gh@protonmail.com>,  <lossin@kernel.org>,
  <aliceryhl@google.com>,  <tmgross@umich.edu>,  <leitao@debian.org>,
  <gregkh@linuxfoundation.org>,  <david.m.ertman@intel.com>,
  <ira.weiny@intel.com>,  <leon@kernel.org>,  <fujita.tomonori@gmail.com>,
  <tamird@gmail.com>,  <igor.korotin.linux@gmail.com>,
  <walmeida@microsoft.com>,  <anisse@astier.eu>,
  <linux-pm@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <nouveau@lists.freedesktop.org>,  <dri-devel@lists.freedesktop.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: module: remove deprecated author key
In-Reply-To: <20250609122200.179307-1-trintaeoitogc@gmail.com> (Guilherme
	Giacomo Simoes's message of "Mon, 09 Jun 2025 09:22:00 -0300")
References: <4pEkPxIXoND4Ndog7RjFo36DrUhFW-OT8Z6Y21aYvhfqE0rgUEmYEGn2PStTYOsOfpXv0R8aWmboCdc0m8uZfA==@protonmail.internalid>
	<20250609122200.179307-1-trintaeoitogc@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 10 Jun 2025 10:24:20 +0200
Message-ID: <87y0u02edn.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com> writes:

> Commit 38559da6afb2 ("rust: module: introduce `authors` key") introduced
> a new `authors` key to support multiple module authors, while keeping
> the old `author` key for backward compatibility.
>
> Now that all in-tree modules have migrated to `authors`, remove:
> 1. The deprecated `author` key support from the module macro
> 2. Legacy `author` entries from remaining modules
>
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>


Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



