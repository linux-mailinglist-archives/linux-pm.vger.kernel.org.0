Return-Path: <linux-pm+bounces-27678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DA3AC4A64
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 10:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F8F1890E38
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7DB24A07C;
	Tue, 27 May 2025 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb6/AHmZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC6324A056;
	Tue, 27 May 2025 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335182; cv=none; b=Ra2Qnx7NtsDAaTJeZaoUzNKSa52WYNjFX7FIy1IQbbkDYCTG1s/yHni6w/Il1syl7f8Ha65MpEZkQI1TrHI00jhyJpw3zOSkHL8wmkeRsQwJp3KQjCYxtaVgKhp6Ck6now2jDSoIX9R5xb+GprbUIflFC93tBEqcnAOjKt5KeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335182; c=relaxed/simple;
	bh=an9Dpp+MtkCdkNTGPODtJ1diDg/WTHKHuUIZYnHZllg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSs5eQb95VPusA2j8qoMJN9i89iHnakUZwzJ/qucd2xL9q+oEe7zxIrfGcqp2YJzG2T+YCdP0wJZBLb948N0wW1XNCVVNXFnFzherlv5qvetOrkqVn8D07nhCjlZvWpaCPWSKnxCNTCpo97ee+2WbYOank1qhJryWBJzz5fYFiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb6/AHmZ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-309e54e469cso422691a91.1;
        Tue, 27 May 2025 01:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748335180; x=1748939980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an9Dpp+MtkCdkNTGPODtJ1diDg/WTHKHuUIZYnHZllg=;
        b=Jb6/AHmZfTJ84UMvvofvLPtwJGDWeC6g1sqtR1wjJ86V7O8qhwVSK2PQzQaxdNM8CR
         Pls9kGV8UFpm/ACSK2EvEf/jFCBJovql5QlGnxADdyhBFmNzak2dcQQR6wjXJcW/fmOI
         qzbRvIpOGMmOm/EKF6K3thY8gEUddWSKoVdjBko15raLx91rmaQRAP6+bNG+d8ukdMwe
         Jgw+Su7bDDh2mpEx0wpVKQLCiX7O7mHpZR+fMcoSvTgYg2OCN1/j96CPGCoDcygif2Dt
         0q18LAiIP+iW1ylpYoxhbz0Mxx1WzGUyz/XfCMrZckfxQ3LKNn0lgzjMpPODODK5+83C
         EoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748335180; x=1748939980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=an9Dpp+MtkCdkNTGPODtJ1diDg/WTHKHuUIZYnHZllg=;
        b=gd/8pjYio8VSl461OebOjbvOjDjxzhbZoWUpVz6CRiAryYOxpbkdloq4e/zcVtwNhN
         WNuB6jkwfBw4F+i/ciD4jsS7WAqF2dDqmeQb1LAZb+6vZErI20jpE7WrHCCjo+sfGJQI
         HClf7wUP7lsBWfEXBryp/OSQcRmonKmaKUfss26jeIBW2nQZUnsSNYP38zcAfV0JWZOt
         9hFPELNJXMQHZqpfLWPZzCDX4FmspCqYv+Ksu0N/rQ+fI2YAhIiUsGvMNIsn38CofKTA
         SWBbr/uyCSu0P7ridOBf7y5dSiDHZCPTbM5BmKFPrjeh4EqA9uWpvMsCHGvmA4dxqEYZ
         fjcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCZVoethVPABGGgTqnPg7SiUvl7gm5MnCD2KxqDJe7sgVxEpTlQ+F7jha8EuCG+KO+hCqO7uO7zsG4qHk=@vger.kernel.org, AJvYcCWx/dEKz3iQgeDcXcCz4ESODhGfDidluFbID+SYCu9BTbamIIe+eazda3sEjO0T7XJYUZxwYjtXFgQ=@vger.kernel.org, AJvYcCX6jLs73L/RgoWdqG+CiIkVNyyTnsrAMZ+c8FwJq24Mz7mO1ATmTsWw3AFL4COYAL6dFBzCqOxZgosSAFWI+90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU0LBUuT14btZhLNcaCITuQM8BrsHd532T1eD9sye34qBM9nsq
	G3sVVcYCICQNUSnyzpolaM1ZWO60jc98GijjqdGdtz+Hk1uIlHvHs2wfUpa99QOZwa+PeidOwDw
	lg9xEPZhiYfA4RRWHN5A+45/XHW5SX9E=
X-Gm-Gg: ASbGncscAUIZ6eyY7Ybz50y4teOLcBYknTNvnoVbZ5eXjvjivAiO0h+FgacwEJKkmEa
	oncYffxBzq8vYCOyA/3T5A4GltRIoEg6XzCSP7r9z/XRr7vUd0eywj+Xg4dhxLkB4/NYnZsEKj1
	fm++hHlyd7Y5AIY9sYPG0lQJAEscofUPtd
X-Google-Smtp-Source: AGHT+IGpFpizqB5SfgTl841kY7avc32Mm2bRFLgu7sBidE8M+Mdk2Lh0XtJVawj+sV17S+IlsEid6TIvD5QwAR8C6/Y=
X-Received: by 2002:a17:90b:33cc:b0:30e:7127:644c with SMTP id
 98e67ed59e1d1-311119433b7mr7288308a91.6.1748335179926; Tue, 27 May 2025
 01:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9d93c783cc4419f16dd8942a4359d74bc0149203.1748323971.git.viresh.kumar@linaro.org>
In-Reply-To: <9d93c783cc4419f16dd8942a4359d74bc0149203.1748323971.git.viresh.kumar@linaro.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 27 May 2025 10:39:27 +0200
X-Gm-Features: AX0GCFtaO_BqO83Us9VmFP8uHQ6yFobCe1L4dso7Zu8yoGskjf1j4ixRzeBoOcI
Message-ID: <CANiq72m2jztPbqiH19560RTBW0PUghi8ajjyi6Pw6jmrHFdtSA@mail.gmail.com>
Subject: Re: [PATCH] rust: opp: Move `cfg(CONFIG_OF)` attribute to the top of
 doc test
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:33=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Sorry for the trouble, one more patch to apply :(

Sorry, to be clear, I meant it as a discussion, i.e. no need to send a
patch for this in a hurry!

It is just something we did for another example, but it is not a
guideline or anything yet (it may not be a good idea, in fact -- I was
hoping for others to chime in). Even if it were, there is no rush to
"fix" it :)

Thanks!

Cheers,
Miguel

