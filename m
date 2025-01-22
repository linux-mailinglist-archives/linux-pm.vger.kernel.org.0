Return-Path: <linux-pm+bounces-20814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E48D3A19427
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 15:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C792A16B8E3
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 14:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36938214219;
	Wed, 22 Jan 2025 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiA/xtXx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC08E214213;
	Wed, 22 Jan 2025 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556872; cv=none; b=iFnSpU1nvtAylzhqf02adZRMfwFl/AHOs9Tc1p+cqc3WDufTWFLWTZCozPnZN9DG861YxA3yz2XFfoWNQPmfcOFn+Pj83Dxf3d++niqPH31kBYwS/EnS3JKw4+Vm1HyhyMawpObK/i8KVW7E2wXQMuHiKcjIvwStZqpIJc10ZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556872; c=relaxed/simple;
	bh=WzeMoyHd1wFsHDterrGjwsnfp50qClo7wGf/DnyO0bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTDmy6oy4rMEVprhqNa+7CqXy318TVdsqOrfZRPBcE4uJOCv0EJ8FtbVWFvXdotjvbo0P0+hGpH+EsKolwm8ftxYGy8crXoqvunrXRlxhKu3HOPSXtvzzpfdqUcAPMOLj7O0d7Xl3c6U4fjGnIwsbjb6ZlsBdHfinIwP4irBq18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiA/xtXx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso1505221a91.2;
        Wed, 22 Jan 2025 06:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737556870; x=1738161670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+1QocPpy/Ji1I5ChsjBOFNMdehE79/sywFufbbFRM8=;
        b=aiA/xtXxNKJCNHfd0p+Z6hQuH5M61Ras5b+Ls98xHN4GSjXBIoNlx66gF8jdEh8nVV
         bW0zR42UkO3KYhgN28uAoazipu6WHatY8yTW+OtRpPdwwUo/G4YykfPKcLC+B4g34Dar
         BuEinm5Pz0hRbzWH9J9kLyv2/QlU3IniiHrFx1Sm9i76INUz8ZTGIJzZQsftPzLhe3Bk
         1BEbNf1uh+QJBxaBIYjRJkkd5X8MrWBwpQHrpjakCbVv2dlMeYM7NTUcO3GCla8XIrIh
         Q0rpvsD5Il0OgAsgvVzc2Ubr9Ea5RaiN9lGs+q+IIR9FEA31RSWIHl3AbaH/vTiMZ3eC
         Gkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737556870; x=1738161670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+1QocPpy/Ji1I5ChsjBOFNMdehE79/sywFufbbFRM8=;
        b=BfRTJfYrj/1xroKG4hJcKQGAxEakaUZD+2BoP+trINklPaZPsRoSl6sUkyZ48dnFSs
         mUdJdNN7UQnsQ1kcUgBHDKKvx3iwQRtsVvxR+tC1OVehuToisUd/1nvFF7cMX9ZBQgI3
         TH9RGReUoceJcjwOi0ZLuya0BDX91kpKOImUel6DlshbH57Y8U5Z1rhgmfocWn+DvegE
         ZDQWmAzCdUfj8yQn/CLu/77FyxYDRBmvg/qT8LdFX5w8vDalv+OZd7hSZUdWACzcth72
         n7Ev2EsYhmhZfz8UHD8s3XDkah7qXfFmvvNGcLH2C5ZKrlrN1HK+mByiy+SOK6c3a0FA
         +rrw==
X-Forwarded-Encrypted: i=1; AJvYcCVVL7jMSUXlAyu1r8mBT360xwOniVNFfwdmJQ0iZQ200+UcXvTS8zpjuSXaO1KraBjsToVPmlgytc5CVEBDAqU=@vger.kernel.org, AJvYcCVYk+m4XnSpX0dRV/8iDeOlDVQMXxDKJTdamkSIK+B2Ku6URaYKJh+2YWJaALKmJUYOIugw2pqaHrt3ewo=@vger.kernel.org, AJvYcCWEZDcBJ17F9SbJm9FCpp6VNhlgCa0Nw+uu+STj4E1U2UGUpzpmhPphezW8NTNCEeawhEQKvM/s3LI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCmfHmDuYPmGYlWuVUYUU1OEBbUa81CE9mMirfJS0pA5Iqco8k
	sWeq7mqXBSyY2k012EF/mmd7HKO6cI22IOwwf3IBuS8WoEod664LhdiAo/OMm/hWsbjkNawAGqf
	M0iZbHK54KxoNFmfp69XHNceLc0E=
X-Gm-Gg: ASbGnctoq11/UtsHp6DW+pYWZrE4AjPsIeMr99WQR6Mq972Ngw9p25rfqaGsMKmkGAS
	dzCxS33UTOzGoKzxYW6gOR7DGj/w+T6rxn7KDCiSFHxwx/QI6HkE=
X-Google-Smtp-Source: AGHT+IHIfO+wodwugTtvtNkYRwRVzoYlETwNdGJihJNuv1FhUSqVk6PBN0fVo8//5I+ZPRBR+ehGjC4d7UPh+HZMzXA=
X-Received: by 2002:a17:90b:5306:b0:2ea:5e0c:2844 with SMTP id
 98e67ed59e1d1-2f782dac91fmr12094612a91.5.1737556869970; Wed, 22 Jan 2025
 06:41:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736766672.git.viresh.kumar@linaro.org> <4f233d3f6d593ba2e1cdde68af44200cae74f6f2.1736766672.git.viresh.kumar@linaro.org>
In-Reply-To: <4f233d3f6d593ba2e1cdde68af44200cae74f6f2.1736766672.git.viresh.kumar@linaro.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 22 Jan 2025 15:40:57 +0100
X-Gm-Features: AWEUYZkZ-PSVosHfypTqzn1iaCdrjjSfVRa6pkJNhyCCF0FK9Ek-FMfdalJhfuM
Message-ID: <CANiq72=o+uc3ZnNrdkuoSGSL8apNE4z4QwpvsiLfGzXFywSLrQ@mail.gmail.com>
Subject: Re: [PATCH V7 06/16] rust: Add bindings for cpumask
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 12:23=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
>  rust/kernel/cpumask.rs | 85 ++++++++++++++++++++++++++++++++++++++++++

BITMAP API maintains `cpumask` on the C side -- Cc'ing them, since
they didn't seem to be in the loop?

Relatedly, should this have a `MAINTAINERS` entry?

Thanks!

Cheers,
Miguel

