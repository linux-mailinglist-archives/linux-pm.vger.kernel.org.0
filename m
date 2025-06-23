Return-Path: <linux-pm+bounces-29413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBB2AE57B3
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 01:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD68444801
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 23:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8F6229B15;
	Mon, 23 Jun 2025 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/blIkzM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773DE3FB1B;
	Mon, 23 Jun 2025 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720418; cv=none; b=K9c7aHnMQNTwfIXjxnhEPbR6MPLiuCoitseQKlWefbCsEvTosWYrClAgMwTgVYM5k2zxc9qjFat25kCazvOntUJlNx0N+qNjroRD/4PQWGzvxMJpB/0DHjpK5SsoKUVxPq6jFUS3i0+n2cvlGcVukkjVSKUqvfvhZ0uVCjAwGJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720418; c=relaxed/simple;
	bh=2S55zo5R3v9w31WkGH9DNMBkgGInmx6hHHs4AgTfmXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spJSDbsh1mp6uLQybyk65GYAm7Ef3isaLDZWzOnPohnnpvQBLbQlDzUBCdVNExrfN+kpbUt1ToLFEEe/8KnVSouauh65BSH8+jDpQkhXZofOS7XNmnVn34Bx7bm9v0tYoWbIDp8I1q+aFzDYYMSG54hB8zcyJwk2l8q2J8d6kMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/blIkzM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313dc7be67aso721999a91.0;
        Mon, 23 Jun 2025 16:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750720416; x=1751325216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HXruGsRkrnO4T0LtQG3CCRxkdrPRNW2kXRz195ROg8=;
        b=C/blIkzM/MUBBN80ra1mWtk0gyA0uns7T5FCl9EePmqEAFOPcBYwAkpdbTpmooCeUM
         VQoXQoBX2VhqUIhLweaehYgGg0Rj9teKesLzgqvSidh9hteJitH9MctZQw5frMtZBfRe
         8xX6pnyll1czxWUjv0jMG8XPWHiHgiLYuTCfROJvHvUCeanzpJUAhOLQcxOLDyXfbNGh
         JLPx+8Kj4+PyYhgU3QerFnADWhRBfOBujSQmYodmkF6vj8WCAnP2UrHvETVbtbKEfXvq
         pX/Gi45uBAq7YqzblXQTEoBasrDTRsFMleioWVskWa1sq3idHgYSQhBxOWfkjKQUwOKp
         q9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750720416; x=1751325216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HXruGsRkrnO4T0LtQG3CCRxkdrPRNW2kXRz195ROg8=;
        b=HLpK2VTNNo5SEdZuJCljLWCWP9KURAAhMS6do1/1e6p71Gex9BG6rSKoFj760qvAcI
         GVT8Km6xr6r91ZI5Uq2UfHdmvdJUN3/2q0egJB76XG3oCbiSayedpbH67g1GvHk/8yhY
         8pdNbGYygQCCc8vg7Y1mElerz2eIe5tveuWCrfVKkN1/XgTZrMqL6/ippRIKMBb5sagT
         gg4UME66vgk1ETbRiIMMOXsANLKerP1vg9rWEX8Moo6u+uSJniShFqtRK93Dx8lPaKyo
         q/FuJH/3EgwOe2XmX0TygMXFTEoqUnQruuQ/z8c5enWAntB/BCKDZNeTMqdm4NiNe8LK
         05pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi6L9Qaw7yeolXEDhJpNcSQCJFPFIXuFLzvlV1SOmGHqIb4bdNvbfQUFye8VUldfLvjmOrlQm4dUnGWZfug1E=@vger.kernel.org, AJvYcCVTpr+PSdMMbMsplnf4G4aTDIVe/X54i9UrTqU7cbkFIWt5Fox/E2yUDTZnR+5huelPr07F/2XLSRU=@vger.kernel.org, AJvYcCX/srR6j/VBXbfrRrmdzo/G527bpDMa0/mWDRUL+KG8B5hO9tN0wgKX8zuNXKg/j939jvatKAeYQ9aS9rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVsiXNyRJIiiIhT2JNcKJXE2KHdKT9W+KDt9kkH2aZge6dbYS5
	aYyM8t6UWRGn274SquE036bI9RfnpXAWKfzx9MtXQ3RknlGZX+IaF7SrXVC77uxv/wr8Snn+O5T
	ZPVasGEsE8PG8Vk2n9rn37nkXEAYzvDU=
X-Gm-Gg: ASbGncuczq0dsfHRvZ6omQ+kaQc9ocG0mxyprN1x8VgVbub48rtsmhogxAgMlmlq0pz
	LEIuIAHQkwj//FLKL7OI69pU45UOiLy85JpA/Gw4HaUx7tSsFcgvDT/WOHL0G/n2W6iyUc4Q/Mm
	FgEJpEZYvjYet4izq3lw3LmmNSitFg5c+YuQXyV5C7b2g=
X-Google-Smtp-Source: AGHT+IH7XVvohyW/cz0YuCPytHgywdDr9SzijVJMsGTdwBGX+kM/pF+FLLchYSGNnYqk9nn2La4vwv67m+JjzET5PAE=
X-Received: by 2002:a17:90a:d64f:b0:312:1ae9:1537 with SMTP id
 98e67ed59e1d1-3159d577d0cmr6882432a91.0.1750720415660; Mon, 23 Jun 2025
 16:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609122200.179307-1-trintaeoitogc@gmail.com>
In-Reply-To: <20250609122200.179307-1-trintaeoitogc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 24 Jun 2025 01:13:22 +0200
X-Gm-Features: Ac12FXzn7V6XJa8kRyU5bxAVt4CroqqcMGg3veONxVG0AI0fCukO93xidJUyyDo
Message-ID: <CANiq72=5XhSd5qbWV5PTWQk18-roFKCs=kqF0iEbcn99tKhOoA@mail.gmail.com>
Subject: Re: [PATCH] rust: module: remove deprecated author key
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, dakr@kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, mcgrof@kernel.org, russ.weight@linux.dev, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	leitao@debian.org, gregkh@linuxfoundation.org, david.m.ertman@intel.com, 
	ira.weiny@intel.com, leon@kernel.org, fujita.tomonori@gmail.com, 
	tamird@gmail.com, igor.korotin.linux@gmail.com, walmeida@microsoft.com, 
	anisse@astier.eu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 2:22=E2=80=AFPM Guilherme Giacomo Simoes
<trintaeoitogc@gmail.com> wrote:
>
> Commit 38559da6afb2 ("rust: module: introduce `authors` key") introduced
> a new `authors` key to support multiple module authors, while keeping
> the old `author` key for backward compatibility.
>
> Now that all in-tree modules have migrated to `authors`, remove:
> 1. The deprecated `author` key support from the module macro
> 2. Legacy `author` entries from remaining modules
>
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>

Applied to `rust-next` -- thanks everyone!

    [ Reworded slightly. - Miguel ]

I don't see any new/missing ones in -next, so this should be clean. Let's s=
ee...

Cheers,
Miguel

