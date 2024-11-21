Return-Path: <linux-pm+bounces-17848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D9D9D4AC6
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 11:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40CC1F22D56
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E80C1D07B7;
	Thu, 21 Nov 2024 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W55cEP6h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F053C47B;
	Thu, 21 Nov 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184532; cv=none; b=WfpWCWKVmTSj24sUP65y6JQNbBRNduQNnugdpaFPVKMnyvQ28QdAE9J8JtOD+N/dsLpKWblVr0afx+b0E/W0PeluWVYWNEqvpcdU8eBlujXimB8ehf5V0sCu3BrH4uMaNULqO6rqP4jcbKv05br6jdHBVGLJ9JjGGJ8qeRDtReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184532; c=relaxed/simple;
	bh=zuHXyJgoGqJBsye9km5bCGjtLmQ4tcRl2042pukyyqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mve1LigTwmdvqMtDGyEQV9bpERFE4/ber7MMbhOkx74VbCt6voVUfmKTaFsQ5rh/zzp89pwQgT+m7LcUD1B2T0HppYR3ojIhpY1AyShqpf7SK54LNDR4TW4JKj9udF4TFNIPG9zZWEE30ivbFGnRWhioshofDjGY45JWSlX3oao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W55cEP6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810ECC4CED0;
	Thu, 21 Nov 2024 10:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732184531;
	bh=zuHXyJgoGqJBsye9km5bCGjtLmQ4tcRl2042pukyyqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W55cEP6hYQITOmZVbqhb9z2Y5bhoQYbPl2qfsJrlYfAMJUJ+ZWboyX9kIexWwUmV9
	 +b8l2A+x53UW98WMOp7MYNySOdgjHdkoxLGmhHp7h/SqkyP7Ev9xWO+kzC+uIJ+013
	 OEptt9969HVpBxuZvD8NkPcrg85cdGjiSpnPILS/ZcMDFPc/zUNyYR8Wr4CCciKW14
	 q/JMx1pENB6X0VsLN3x8yFLsGV7tdHLI/o/HZbVY6OzisH+7ytq9CpAcNYFqDGuuo6
	 d2cvo0r9fd4LyRVDzEPiMy/DIqmZ35f1yXq4E+kosL7hZoZ6V59GwutfyIMfFbmE8d
	 4YBNc9ltjaDrA==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71822fabf4fso340712a34.2;
        Thu, 21 Nov 2024 02:22:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7qBi9ArOHUepVfJF81UYEQPC2hsqGqZDzryiGJVpfjKaaV4x31HH0Iru0jQO0Z0AdIX98q1aeTiA=@vger.kernel.org, AJvYcCXZAY0bt9G4tq+u9rr3gUxnFpUyrZLssn55bl5A1cwHW+pHgwhmLwgYfyqkbCnJn56fQuLfPGwNUKV8kQ8=@vger.kernel.org, AJvYcCXgSdoWkDMnfZZoNROPjEBgx4mgA3v6QSEmEkLUMSdx9uZrcUI5RpvNITyjDYBjvBjZG2whlpOa@vger.kernel.org
X-Gm-Message-State: AOJu0YxjE25I3qc5Rxt8k3YnzZI5uLRpFBCteuxTzIshWXvYk2j3z1WN
	OLYTK3Dac5VK7fSB0qGg9m4kTjho1dd7/HprL18YiE26VElbyuKh5kU2QZXup8ybq6PA5b5iBrg
	omI1dzpOpuXDF37mR2v069w6Fx3Q=
X-Google-Smtp-Source: AGHT+IEDFNyjZYCg7P5ba5VoO9RLm7dU12kagS1jW6IwroPdUYgZWLHTkvuOGEoVrkjH1OgaIyc/BFhL0/L9SY6iPlw=
X-Received: by 2002:a05:6830:1245:b0:709:3431:94c3 with SMTP id
 46e09a7af769-71ab31fac58mr5354895a34.23.1732184531014; Thu, 21 Nov 2024
 02:22:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a4aa8842a3c3bfdb7fe9807710eef159cbf0e705.1731463305.git.len.brown@intel.com>
 <c5f9c185-11b1-4bc8-96be-a81895c2a096@intel.com> <CAJZ5v0iCR5ZbNz=OF1MbJUJdhCRh2P8M_MTF7eszPe5uv9_R1w@mail.gmail.com>
 <95c5a803-efac-4d90-b451-4c6ec298bdb7@intel.com>
In-Reply-To: <95c5a803-efac-4d90-b451-4c6ec298bdb7@intel.com>
From: Len Brown <lenb@kernel.org>
Date: Thu, 21 Nov 2024 05:22:00 -0500
X-Gmail-Original-Message-ID: <CAJvTdKmi6-nEwhq8edPw5g2b+ME2_HX+ctePpcPFoZPbNcXqhQ@mail.gmail.com>
Message-ID: <CAJvTdKmi6-nEwhq8edPw5g2b+ME2_HX+ctePpcPFoZPbNcXqhQ@mail.gmail.com>
Subject: Re: [PATCH v3] x86/cpu: Add INTEL_LUNARLAKE_M to X86_BUG_MONITOR
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, peterz@infradead.org, tglx@linutronix.de, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 3:21=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:

> I'm not going to lose sleep over it, but as a policy, I think we should
> backport CPU fixes to all the stable kernels. I don't feel like I have a
> good enough handle on what kernels folks run on new systems to make a
> prediction.

FWIW, I sent a backport of a slightly earlier version of this patch,
but all I got back was vitriol about violating the kernel Documentation on
sending to stable.

Maybe a native english speaker could re-write that Documentation,
so that a native english speaker can understand it?
Or better yet, somebody can write a script or update checkpatch so that
developers can more likely avoid the Soup Nazi treatment?

ie. I agree with you, and I'm happy to help, but it isn't clear how.

Len Brown, Intel

