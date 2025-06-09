Return-Path: <linux-pm+bounces-28285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2F4AD16ED
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 04:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37151188A289
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 02:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979082459C9;
	Mon,  9 Jun 2025 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JkFKDKAf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1420A157A67
	for <linux-pm@vger.kernel.org>; Mon,  9 Jun 2025 02:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436621; cv=none; b=Q+10BNsVzxXD/87Spe7UonxICJLp69pvEET/T2tLk3CgyzW2lX6oTL7mLJEwcobn+CrUp4j6jK+deNKsmS5t7RHaDzgsWESnHqwqBkzSrNIsmDPDxoMehXmFyjrd3KYQeheG8GKXhbEBhaw1g/DKPKA90F+qhEx/dRJTWA3BXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436621; c=relaxed/simple;
	bh=R0h5h1bEyC5dQGpMZ5Unuo2nd8qE7BzdDg7UDtUnXbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2jwTeFCHoSBnTUpBjwbU+t14lsQ+ALeJVz5A9uXa6Ww4sTUJcq3Zv0gj3xlAbE8iB3TZWf+YaMKZdNALHzO+GFWuZfxb8o7fpSQ9dTrDRy6uGVPj05g4Qd62fZiZF0igZY1xLY4nYYgaGuQW6y60kQnRYU0g+9QCyQOPS4oTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JkFKDKAf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235d6de331fso45177315ad.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Jun 2025 19:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749436619; x=1750041419; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KGBdjbD+r7EhriDTReRo/vjOU6dpa3NoNVdQ1TG/O+k=;
        b=JkFKDKAfcvsYH97B5t60GWa5kkKSbLe5ugQwFfR4eYHLAPTpo7WVKCUR8+MWtZ308U
         Aryf8NgfoRlNojduD+Iwuiwd1DA2U2O8u2oskJZbhMoUVIlMSHoVbHYvmJ0bThwdWnww
         jdsITV75bW7KY/Sky8mIU7/aMw5WUyqqQ0BnUp1ztFjkK9ffkGzYE6Dda4RqEIxigPYT
         ziEVMqIIJrRTWvBvvgHP5qa10BANa0PqtCqSRlHUEdAiAL95VJ6xPQhjUP+YrZvim0Wn
         LBipMm8BMPvDNXBRnRp70x+G4z3l94inteC5fJ9lOczkurC4vEN/UJBhqXni5lEKf+y1
         m7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749436619; x=1750041419;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGBdjbD+r7EhriDTReRo/vjOU6dpa3NoNVdQ1TG/O+k=;
        b=BuUnDU5lMgdj5qlhwro4RuLXSFawyxnxK1cdMb5vzTZhrbLBp0RP8J5W4Z5lnq0KWq
         oWpIsSJL+JedIVNP+WP+xLtWLGL2J9V99kyqjCVokfV6VvIXohCfg/YP1g2mT9a9X89X
         QveTz5/SiTkWAfpWCN+aP5Px1V5AW+2wHe75xarUVfRdst8hEikXrJWup3/gPYAdCLeL
         YwpIM+SGAuiwN9oCeZEz9wV0LnXEs9kbMFw4CBVzs7zj21MCifWHFKRI7LQ/zn0C5W+l
         Hz5uf63MvG+ABV4WhWeqYddT/qsBiwvyRV6Lji5I15zMOJtvDVu1TpT7R3Rk0LXzioVG
         nABA==
X-Forwarded-Encrypted: i=1; AJvYcCWmRc4aflxlsXDQt5K+F9VnLwLruuSjgCxcUCglQMqsh2De25lmJAMFb2MP84zLtC5Z6s/vrqhniQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDiXF5kSM3frNDrR9f2zNmoY7d8cElHTtD2kxvWO7o3UcJP4PT
	VO+IHPbaYkYIkS4b4caamCP6CiOr6CXUoXTi9F3GQy15IOPl4yTfsrjfh0RCCwBT3DY=
X-Gm-Gg: ASbGncvU3P91inDXJpzZMnB4MxxcKFj/XjHupFLPREw/QS+2C0Y7b82o2LPRnsUMmZL
	yiX5ABwjFIZPEwWW7mNivNwXrPCS6T0qqY6CRiPVZvpsXnqCDOhHd8HoQLFCZLjKijcZ7X4yI0v
	XSWrDYIsfQwk1K9gMcAoWSu1EbtKolspsn/Fo4XzR7Ec9EqceNKbXI0NffO7mJF2WBph3aTS0Xi
	VmWCOfaSpFdpZaqXBfcPUFi0xwEzBE5ZNJLjF4CkTqSU/9qegx32BuIXXSds6pWRLzgEiAFlDTA
	mYtvVBRO+qHBms8DCMiKFqJrSOLqlWlT4+xXeavs55cEIeFZQyQW
X-Google-Smtp-Source: AGHT+IHq1EECm8UAEXoryyssCckiuT1lwiE3kyJ+2cywlbEqvKx4+f1qsF2+KmgK+wPvK5sev7n0AQ==
X-Received: by 2002:a17:902:c952:b0:234:f580:9ed with SMTP id d9443c01a7336-23601cfa542mr151014935ad.21.1749436619359;
        Sun, 08 Jun 2025 19:36:59 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603078941sm45015165ad.7.2025.06.08.19.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 19:36:58 -0700 (PDT)
Date: Mon, 9 Jun 2025 08:06:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: cpumask: Validate CPU number in set() and clear()
Message-ID: <20250609023656.efvgl7efmfxhloxv@vireshk-i7>
References: <8b5fc7889a7aacbd9f1f7412c99f02c736bde190.1749183428.git.viresh.kumar@linaro.org>
 <CANiq72nxs4BTFQQcJLgrbgHDzQLbhAA3=qsycdKu=oxc2V=yqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nxs4BTFQQcJLgrbgHDzQLbhAA3=qsycdKu=oxc2V=yqw@mail.gmail.com>

On 06-06-25, 12:11, Miguel Ojeda wrote:
> On Fri, Jun 6, 2025 at 6:17 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Reported-by: Miguel Ojeda <ojeda@kernel.org>
> > Closes: https://lore.kernel.org/all/87qzzy3ric.fsf@kernel.org/
> 
> The URL is wrong, please point to the original report:
> 
>     https://lore.kernel.org/rust-for-linux/CANiq72k3ozKkLMinTLQwvkyg9K=BeRxs1oYZSKhJHY-veEyZdg@mail.gmail.com/

I am sure I went to your original email and tried to mention that here, looks
like I copied the same link here for both (facepalm).

> I would also suggest adding Inspired-by or Debugged-by or Suggested-by
> or similar for Boqun, since he figured out the root issue.

Sure.

-- 
viresh

