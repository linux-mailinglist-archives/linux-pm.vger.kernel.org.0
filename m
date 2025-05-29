Return-Path: <linux-pm+bounces-27801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74907AC7B35
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 11:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E102D5024A7
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 09:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7626A084;
	Thu, 29 May 2025 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7UR6RFW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44763269B0D;
	Thu, 29 May 2025 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511500; cv=none; b=DldlT+XfDJhYSAcUhX7IV6MnAK6GSoF8uSF8o4TG87cTBzospHqkZ/VlqKZjJFi5iAbmX5+p74lcB4/wdcLTJ2sL+YfsoW3olA3Sj0MOdfO0EkP1BrXXz9ZgXauR72HI0OYKduhehz2KQag0TgtsAiMq6MLwQ1WIjbZOIkjMb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511500; c=relaxed/simple;
	bh=2nK/yh/SYIfkctVJyiNFoFOo9cyV3sOTX72PZP9LLyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJA7S8MKyJ55VpzaKlknLAKeSXtvxCgkXwerS4ngdf1XRr0hqE2DN2I7Ws3YlbrCyiQKBrqvOjKDIc9Y196OpbbHz3Z0NbVKl8TpX2ESzq92HXNwhZocgu5YRZczfGXLPAV0viExHUv6m46avrPXRxQcwBoM4zmK9kRn68oB4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7UR6RFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CB9C4AF09;
	Thu, 29 May 2025 09:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748511498;
	bh=2nK/yh/SYIfkctVJyiNFoFOo9cyV3sOTX72PZP9LLyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y7UR6RFWSbLKBDKPHEE521pmltHWdCEa3f+8j0Oqsa6KbUR4QrpOletBq9sYppIN2
	 MVSr7mdLjS8p7Nk4AU3sq7G4wiClVVlEz5gLQqtbzrQRoTwVAPPTJ+Z0Q1Q00zSRJ9
	 DBMRqULoq2/x1HbZds57pfLtvpEYxzeBSwTToR985lgG6r1YsVMpjpKCyuVrCh0XtU
	 vTV+iMdPCGoS0ZIXMnqYNqkRWpGk86oYomtfeMjlMYoLHFuFykWY/DbwFKzOpjzfrR
	 nbcHefGI0bKVomWpfAFGdt8M9yBOH6w4anlsEIF/SMCQVY+2pWpcnj/137D7Xmu3fx
	 6La8fmt9ou7lw==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-401e77e5443so356842b6e.3;
        Thu, 29 May 2025 02:38:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqioSflywaNqn8ueCnl4FHgknqxaT4p++yQa+zKrMpqPqoV5vBsCCnb79apmhWeVdfiTuX4o/rwy8PmcQ=@vger.kernel.org, AJvYcCWHbwE1xMKRh6uGBVG+tusRCOsPUXDRdK3SPdHqtRLcqf5X+DBOoo1+JWve7qzkVTiqflXQY6MFHco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnlakUYHoSIiGE9vfRR5vOiaHtaOwM9wc4GFQZFzLukT35J4P
	vjD3HTWtE/LfVN/N63yT9rW0c4Z+PoNmvua9X1ClODKsCt5ttEB/WUPaGlMHf+vX9psgNf8SjKb
	DBa2DtHnOlYLFEpHSZhi4OEBJCNapXpI=
X-Google-Smtp-Source: AGHT+IGd6cP01E0ILZ0jIbDmD9tl+URHn3Nvc+z/lzWcuejp94+vqdb9Wm05FY0UAM7r5kuVY56IGmdZUcqqHNRP9ZI=
X-Received: by 2002:a05:6808:330a:b0:3fe:aecb:5c49 with SMTP id
 5614622812f47-4064684cd10mr12438977b6e.21.1748511497918; Thu, 29 May 2025
 02:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2006806.PYKUYFuaPT@rjwysocki.net> <20250528131759.GA39944@noisy.programming.kicks-ass.net>
 <CAJZ5v0i=TWMjPKxGa8eT-prV=dtQo=pwys5amcj3QL9qo=EYyQ@mail.gmail.com>
 <20250528133807.GC39944@noisy.programming.kicks-ass.net> <CAJZ5v0g2+OVdFM-bUCOynNivUc4doxH=ukt9e9Z_nKpoZh6gPA@mail.gmail.com>
 <20250528160523.GE39944@noisy.programming.kicks-ass.net> <CAJZ5v0jzF19rToJMHhEvU6Zbt3690KWCs-B_0sPR=s9xeRiUnQ@mail.gmail.com>
 <20250529085358.GY24938@noisy.programming.kicks-ass.net>
In-Reply-To: <20250529085358.GY24938@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 May 2025 11:38:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hw1910Gsb57POVhax1hAbEGHa7xksr_FygNd_JL-oeOA@mail.gmail.com>
X-Gm-Features: AX0GCFvrawp5enqLd3Ydh6n6eOml_Mrs7wzOdRp8FHlaAuTU5q3oafGDai98bvg
Message-ID: <CAJZ5v0hw1910Gsb57POVhax1hAbEGHa7xksr_FygNd_JL-oeOA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] x86/smp: Fix power regression introduced by commit 96040f7273e2
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	x86 Maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Todd Brandt <todd.e.brandt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 10:54=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Wed, May 28, 2025 at 07:09:21PM +0200, Rafael J. Wysocki wrote:
>
> > And I object to leaving a user-visible regression behind.
>
> So we go fix it differently.
>
> Why can't we initialize cpuidle before SMP bringup?

First off, I'm not sure if all of the requisite things are ready then
(sysfs etc.).

We may end up doing this eventually, but it may not be straightforward.

More importantly, this is not a change for 6.15.y (y > 0).

