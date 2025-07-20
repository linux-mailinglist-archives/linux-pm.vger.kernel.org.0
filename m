Return-Path: <linux-pm+bounces-31137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC191B0B92A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 01:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACDF3B3397
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 23:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F127223DDD;
	Sun, 20 Jul 2025 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY756J/k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E99BA27;
	Sun, 20 Jul 2025 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753053565; cv=none; b=ZIKokbHfSWBnt0DqDYS8cjzjOe3bhWf1eZ1KVWEWDdc+KfGkXmTIH0UzP9QE7udiPCk6Q9MunEhKKQLwl3ul/EMDMxeU51R4Mb1Pw9Nh7fIBi9fNhf0Wv8Fug4Keo+sLNda3Mga+8y/8xrUWtQoiZxso/ASIPCq/FyGW9qZ2TrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753053565; c=relaxed/simple;
	bh=xDAokI7VKG3qDXjdagIu3rwbLTsdtMxhhRz34acfjGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gy8epWbgb8pGxQolgsLxMFRHbXx1+2iB2rtCyBH6FOW6ttN4W+WoqdjzuVRHifw/avcZNY5kNc0f9fK8PYzbad5yMoKP3KrNkhG3l+uCvIhbTrG4ZOfhIjK3GNz30MdjUnCsHPwTeE+d560E/lY3+zdTMtaT0QC8JoTGNntPZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY756J/k; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-558facbc19cso3094789e87.3;
        Sun, 20 Jul 2025 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753053562; x=1753658362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDAokI7VKG3qDXjdagIu3rwbLTsdtMxhhRz34acfjGk=;
        b=SY756J/kDsQz773IZiSx+op1zXzawDij2+hYibx9rgYTVzeMPY07fLv+kN//+JkQDT
         d9UFAc+ocLpMw80geWBq3W3EueMgcobpJq5BOAGQG0qCg/d2NcZZtVMQ6yL+ehDcBXkN
         2VKn52rKqwpcXtiPsYRh3L4lHXQwFGInjacIdy4RInls9VpKSKfB43jMMee3FXkDtB/P
         4BcvmjGK5U0FEyvfDg1L9k7akfeY/2V9gvRWqO4d0BaPGvmfLqQJViatly4Wkjt1yUUX
         ucVNENpjmVo3P4S/Hr7nm7YF/RvQy3aSf5sZ5OaFalhqm4ixEDcgTCVlREIBoho6cTYp
         W8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753053562; x=1753658362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDAokI7VKG3qDXjdagIu3rwbLTsdtMxhhRz34acfjGk=;
        b=vMNepCBiLAMKtQW8w09uX5sEBsa0U8vw6vOAXpiCseDqt0gDTkLtfVDLXHO9nlqkhM
         /6PCg7/ahTq+BQ7xGjq1/FnkcvP+A4oPmyVyh3Ea/vG0R33Kt7nlx08wr0jlo6sqCqp+
         u2KQn787F/8MwI5kFOGKILUK6TW8S6pCvkhFLgYm3plf9juAJ5CFYCz8FB7TKtzWYVPp
         jn0+iXL0/KpS3jND/yJrbObnkTQLXUP1Byl0zelRWZdCpfhH9n0btMHZ38o4tnCwHDC4
         dYfinXxW6uwL53/9TfS+B6/uzdszxtVrY+VMqC82sVU61RY+f8m3SzZmVyiyuCipDznc
         8sTw==
X-Forwarded-Encrypted: i=1; AJvYcCVnhewABzO4fbuS3DWm9Kr4SeDB36LgGl6deI+fwBU96E1oNeEU3uUKZkej0Ggk/VomrmGxVF0NUI8iS1LJLKQ=@vger.kernel.org, AJvYcCVpCRa6+ZKR+SBvMwFUzerk7Na23dycjYlCvOHVJrdkiC/o2Q0prq1ABf1JlSTVtNFBVS0br/k/Mi1NDAw=@vger.kernel.org, AJvYcCXzsArgkyySdbctM2BCSVNiMyrEVbbxuIS7zxBScpkI1fguQ2/mhLO+n3EiCytGuOeX8jih8kr70Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVUC5WSWxwR8xrOJXWZWZDVFi9qlpJwk/aAp/her5JXHvvq7kK
	TZln9fucldMhizADCp5+y3RVPmWjcFFbnYCykRFeWRp4Bc5bZxMKh0pQCP1QqgfRF2mHtnQSP0J
	f9qKkpup8rSwD8uhLX4ctjZ0ISCXVLgc=
X-Gm-Gg: ASbGncvmm4nvTG6lbMAI5W2Ms4DJYK+RzKIRqN+Eapu98wuUAC1q61bqJROjL3m55FM
	hvzPnmgVfJG5Fi3OGZPNarX/izNYXtp5JhRDuGZoXiBw965qegpxEH88W2tUL/2fkvJ81FkdssP
	EAlvDE+HdrmB4cLy6M6MzpoWMqXeTE4SaP53K2lPZnKD83XPHaahlKAAqGLaSxmsjEYIo5JuRSn
	UCYg0jkkBcSigBWgOIRcwUMGDzSvAwcHHPUCEt9/g==
X-Google-Smtp-Source: AGHT+IGncn/UOc3MBb99EG9F6oXxwGB/WmBF9SrY2hp0XbPoeHN72PD8Hhix3KJ3ohY4uA9MMfu2RuCp7hWDXpSP5rc=
X-Received: by 2002:a05:6512:3da5:b0:553:2ef3:f73d with SMTP id
 2adb3069b0e04-55a23ef8338mr6237754e87.14.1753053561595; Sun, 20 Jul 2025
 16:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
 <20250704-core-cstr-prepare-v1-1-a91524037783@gmail.com> <CAJ-ks9nBrT4C5xYk4eWUFX_nX5XXBYHEGo+fLtLWJE-D9Y5hKQ@mail.gmail.com>
 <CANiq72=pS1iPePhi2Vs2AkLs3+tV=TASStPuSCnRNnHNHaawsw@mail.gmail.com>
In-Reply-To: <CANiq72=pS1iPePhi2Vs2AkLs3+tV=TASStPuSCnRNnHNHaawsw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 20 Jul 2025 19:18:45 -0400
X-Gm-Features: Ac12FXz7n_zGqqSP_crmNt9QLWB3OIlBXY-oQtBefFezfU4rnULUsaaSqCUStUY
Message-ID: <CAJ-ks9krjd2kt8G9e12Fh2Nu=XtKWRZspOkHsmKQdjEU1j2XiA@mail.gmail.com>
Subject: Re: [PATCH 1/6] rust: kernel: remove `fmt!`, fix clippy::uninlined-format-args
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 7:17=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jul 21, 2025 at 1:04=E2=80=AFAM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Just noticed a tiny typo here: it should say "can *be* taken".
> >
> > Miguel, if you can fix that on apply, please do - but if not, no worrie=
s.
>
> Done! (We could also have removed that sentence too, since it sounds a
> bit like something one would write after the `---` line).

Yeah, agreed. Removing it would be fine by me as well!

