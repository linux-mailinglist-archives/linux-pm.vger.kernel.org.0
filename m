Return-Path: <linux-pm+bounces-28374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CD5AD36E8
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 14:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 232137A5E4C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 12:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8342729992A;
	Tue, 10 Jun 2025 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfZ7yYJe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD2B299923;
	Tue, 10 Jun 2025 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559067; cv=none; b=IMkbkoB1uGNm0Q/+AmylUVXQ2SW85H5PhjmhFUzHnmWwZzfdEv/Fq84ZGT5FHK9dmDfVTLizbXBlLBK9ohCfmExHsTVhs2hMIdfcaV5rF6achcWckjN2qXTmKvkmMixkvVvfQDeU7g20tm6PX6BZEPQQJPpHkIXEGXIPYnryP2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559067; c=relaxed/simple;
	bh=XmJMk1hfrUZqF1m2NlC+hcdw8EIJOMQVVA2Itp1gGcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSYdgGzTodgSkx1mIsy+5ViptO4LzSBOF1MX+6OIzL7E4DfzSqb+ZBcH7s3ylx2l/gDOGeTh6OJ8vvhaUsjaN4kuHWC8Q2MLFG++yxvG86M1K+QaxJTRAnZn/yRFRQpMcJsFsB50vCDIlzV6erOfcJbalWK2QfOd+H2fxdTlIZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfZ7yYJe; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c7a52e97so4557788b3a.3;
        Tue, 10 Jun 2025 05:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749559065; x=1750163865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRQOPbrVNqSVVdbbGZatVj1/1oRXPCI6nL+WDn+7b74=;
        b=cfZ7yYJeLnNPtIRcJ7h6PhYT5HJtxrOjpUiKsuYbjFThR/2VYz6g5cCKrN7GGjmGDM
         Ldz3kNlHaj76VBbN62KW2T44v53p39i8i0U3BKGHvrLsybPuTyhWwMiQ3tX+7L0KPagX
         AzQcYFYJKouBJPLXzZAnd5MdjszULU6d1PLxC7fy0kqCjZzHh0QFxXBlY8jXKObjPw3v
         hxQiWqWNOjr0XsmuzzRYAuQya830uEAlMyK2fqrEaalFejaWHn1oTRZrUNjnACSWke6v
         r0ePSyiSZAGhkbv5zf/36SVlPhq8jUlQLbegC/4tEucYhbKhYcGdzgbQGpmAEJRonENj
         5Wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749559065; x=1750163865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRQOPbrVNqSVVdbbGZatVj1/1oRXPCI6nL+WDn+7b74=;
        b=bp9gU9z4YeoKa4Kj7VbZe5d2KNkeqvbUK0dO70s0o1pdQms+OsisrrIi+6+gD3n34Y
         yotN7TFIo7qyD7gcBFUclv6gSd2WlBT7iqqvgy0pX61Bc544ITOraw7p+ZYz6LglVJDc
         2iuFpGkQEyYODblPXB/mEO7fDPzika0QJ4rF0YywGyjh1JmoX0hFgyUUUVxI3S4H8X9/
         YNeaTwlqgSIAe1ZcJ7bDwUwQc4zGmEAL8wZdJWHHEEERd6PRqVp1jBBQWuxPYrPv3neZ
         cVLuV/1qHGygEh62yYs4Z4ltxVfXvWAKNjXq0WCLxlZMi2eFQAgnbhZtOn9KhKXkCu3w
         cx1g==
X-Forwarded-Encrypted: i=1; AJvYcCUEMUTJc0Te9O6kjJaycgE7Be89X3ooW/rKcyvnvABNtFniAccnsuncnUmpRnrZdVoCZVTl+mvIvOqyfmk=@vger.kernel.org, AJvYcCXGFjwSS/pRcXvvJqKRPyp0sw92oQVi00pjfRaXTgAg5ffmsFS2zIIzLjbHrNX26yTOdG//EirL7XE=@vger.kernel.org, AJvYcCXZbucCidw4BoBi/3KN5FOIvKDwgW0AGHjRWUH9UqL0E+XCkBZnUdNmYFk+h7qfqErJ5i7Tn/ZnceV3TVhN5lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyltr8s2WkDKex6Q3FANelAa1PJePO/RrT3RNQFP3/2uexc3I7E
	g7b6UPZtNhciHK1ZSJqjZmuvQGtRlIJwIoYyZiddVWE5ufJQTlkkG58t
X-Gm-Gg: ASbGncvYeoMaw0WwZG6wj+5RSB+UMPc33wgcYzNXFzHtniL6fwAtK6mGovkT58IrFIB
	jrE7dsMxVG9E1gqajg1fSYoG5qF4M6ClKxeLt04SVfaUsC+qPxhxAdE/8jBJ91lbe5qBCEiaHS2
	slg3JAHCOVKxvu9E1u7sY0D0RmYupkgXVyI5adiR+oQ5mkONnQl+PC5Mr/Iu4tKSW6XNbm/7w/d
	5qJekyPvP5XyIOJ9ltuua7VW1IwHBbG2pWLKUqrj+9WhTbOzqMvDuw0SCttQ94RoNWlv+BDFydH
	frZKTi0G7LPionZhJjusMN8KfvwPWh2wEpztR0b6F9KQYC4kocw16hE/ccrMjw==
X-Google-Smtp-Source: AGHT+IHMtYtVG5PabZhuHRmGJDtif89AiGbDOj70nrBza0cLJnhQteMI3FHrOV9iM3nIwFTlh0+ugw==
X-Received: by 2002:a05:6a00:13a4:b0:736:5725:59b4 with SMTP id d2e1a72fcca58-74827e51491mr24120722b3a.3.1749559065038;
        Tue, 10 Jun 2025 05:37:45 -0700 (PDT)
Received: from pop-os.. ([201.49.69.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0e9d36sm7318995b3a.157.2025.06.10.05.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 05:37:44 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org,
	airlied@gmail.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	anisse@astier.eu,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	david.m.ertman@intel.com,
	dri-devel@lists.freedesktop.org,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	igor.korotin.linux@gmail.com,
	ira.weiny@intel.com,
	leitao@debian.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lossin@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mcgrof@kernel.org,
	mripard@kernel.org,
	nouveau@lists.freedesktop.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	russ.weight@linux.dev,
	rust-for-linux@vger.kernel.org,
	simona@ffwll.ch,
	tamird@gmail.com,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	tzimmermann@suse.de,
	viresh.kumar@linaro.org,
	walmeida@microsoft.com
Subject: Re: [PATCH] rust: module: remove deprecated author key
Date: Tue, 10 Jun 2025 09:37:31 -0300
Message-Id: <20250610123731.194853-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72kORZjTe3tPEBueDi57TGF7KfxgTSw4Tn0DQeK_X5hi5A@mail.gmail.com>
References: <CANiq72kORZjTe3tPEBueDi57TGF7KfxgTSw4Tn0DQeK_X5hi5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrotes:
> On Tue, Jun 10, 2025 at 12:12 PM Benno Lossin <lossin@kernel.org> wrote:
> >
> > Hmm, I guess a checkpatch lint fits better then?
> 
> Yeah, that would work.
> 
> Probably for the C side too -- from a quick grep I don't see it.
Maybe, after this patch we can make a checkpatch change for check the `authors`
key (and MODULE_AUTHOR for C side), and throw a WARN if the author is a name
(not a url, or "rust for linux") and don't have a email address. 

Unless you guys tell me otherwise, I guess this is not so priority.

Thanks,
Guilherme


