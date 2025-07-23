Return-Path: <linux-pm+bounces-31333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8391AB0F184
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 13:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B76567091
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 11:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ACC2E4989;
	Wed, 23 Jul 2025 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFfyCgRY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2950B2E4257;
	Wed, 23 Jul 2025 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270986; cv=none; b=Ec+59GjrU4gvqQk0LP2OrPA71XE55hr3mq9N5fwJIDmRZvi7qnoFi7roAY624Coo1svSYNaiscyQSpPo10v4xzS5Dde45N0oLt2kNaVFu9guWOZtF1l+vwCNgVRViuZSH3wy8XBALPH3cvlafQkW1JQwHHM6bhvyhomSGnYaCfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270986; c=relaxed/simple;
	bh=tu61xYnZ6FrlDWkZ6OMWKUEtmSsADXXPUHEa5nQWmlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UgSiJhSbU3OmIRSj7UPjpuEMBQoRMxyXM4INc3UaKNiSFkYJ1Q3r8Ar11xueong5rCRMyRZWFxJJsI1Ydo4+9jXnPoVnoFMM2mevo/5XNEKyGzRbRBVlIzXoHUznnsoQUPECGY1BuBOI9WUcnkKQf9aRpVsUTSiJ7YpatKAII6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFfyCgRY; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313dc7be67aso789942a91.0;
        Wed, 23 Jul 2025 04:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753270984; x=1753875784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tu61xYnZ6FrlDWkZ6OMWKUEtmSsADXXPUHEa5nQWmlE=;
        b=VFfyCgRY+hkfkNYGOvlVymI+/n9Xcue/FQEX0dSPa7sO0OSMhxvkDblgS1TcWLO+9i
         RfqSda0JWOihUkudYuvyjx2Q9aNFgyqVZPyZ7hprdAHX2nIUEFoLYSIrMJvbi5Fjpw0n
         re5unTsOLD43IxaONtGM2CZhXcQq4kTt6x2K2yMgjyDa537Nt1BkmQ/f2TPnMWYTR33C
         AquIYsHG2fNDRp/pq4OjGJdphapPK3qd1Nx8p8Ayc76Uir7+cWhGiQMgGL5qgd5KmvL7
         StZCcIcmbR1BELIO9MIYd4jgJeAKdNJcugL9AK70rq4dgXGLIWJzpfypKOPJJennYL0h
         LDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270984; x=1753875784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tu61xYnZ6FrlDWkZ6OMWKUEtmSsADXXPUHEa5nQWmlE=;
        b=lrDcR0Y/R0D9waOtWmRX/0BDeGBTDkbuqEXft8PZiwFznWkNb70ZjdCHQb+k65+9To
         XFv4QQt6Q29L3E9c+jKuDI1+lA6vkwXAsdt8mON/XQgFa7pDT7JRdgdNRHITGa2HQQdY
         QdHNz/iOTP8Dbu529x9EyYq0teauFDx7ueG0YamM+EozSmnJin9fx+pvvzb1tneqwaRT
         MTPWkLtZwYm3SwugT+52+nJmOT3/zAHzYrKMhZPCccefERbA1CJiGQfr0p494FKg/7H2
         kQaAEuBOC/rgXN4WRyU05c2wfTBIGHnfaz9eyT7QDtVqB3eUmRu4gYYNQv1O8ISdqzai
         hx5g==
X-Forwarded-Encrypted: i=1; AJvYcCVi7dYpDi0/ikKW5GwQD/qVBZQ937Ba21PQFHckiVLnc8AQ3twl/7CiCBRYZ5BhsYYffrg2G//g4R4=@vger.kernel.org, AJvYcCWWiIvoD8yZTdAu56vD+oPOhHo254/6NQRd439aqpexxnJul+YOUXOjCVFhd9jfktX3bGrph1ZMHQItjlq69tM=@vger.kernel.org, AJvYcCXPq9lV/L/sKbPLKvPklrAhO2zlALehKDBy0cxndKY4UTCbJaqrwrKg2WXp6fnwwFmBLPdxMMiEwdBMfPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaNLSaw1JYwDAL4N/cjYRgPTrHokx5XaZrnbCFQ36lkzL1/lI3
	cQs+8TT6NsePSATT5dDj4LWiqQlEQjDnCd3DKjRq+emI0tBv3MDu5CW8KcSaK7A0DT8rMWZ/Mru
	F5RijtkhxHTZIqlg/2QtWC3PSsE54PEY=
X-Gm-Gg: ASbGncsrmESqYkqDx0X2Bdu+UlAB5gJmq6o4kB5CmGpNC88IZEtRv+6ozFwFoYRXjff
	XB4LTUXmavdMu92zunXDHHIx1tfwOqUrK0FjqsWdM649l1tS/z6BTAwA0bkqDTK7HJwkdwlnwDm
	a7M9dbas9ljSuz9xV5kbwaMBRsNBlVMy46Qn0h2d3tlPDQ5nyeTMyWtCqLghKOflYqpH8EI19r8
	t/lsoW+
X-Google-Smtp-Source: AGHT+IE9iNwA56aqJltOoki9xGHnB3O9ea45Gxe3ub9j/Bg7NUOZIgJ78u8R7B+R9wahUSQT2kIvhL6UBW+IdcA++t4=
X-Received: by 2002:a17:90b:164f:b0:314:2d38:3e4d with SMTP id
 98e67ed59e1d1-31e507e77a5mr1576361a91.3.1753270984311; Wed, 23 Jul 2025
 04:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
 <20250722-topic-icc_rs-v1-1-9da731c14603@oss.qualcomm.com>
 <CANiq72nPLn+3V_DhN9_dmKnRrb5mfjzQ67Utz7HdtOY3McpweA@mail.gmail.com>
 <d80ebfbb-5fb5-4dde-a79b-adb22231a63e@oss.qualcomm.com> <CANiq72m8QZCAC4ouwTCvOE26gmoTSZ5fgc9uTw0pxkcNnX+4CA@mail.gmail.com>
In-Reply-To: <CANiq72m8QZCAC4ouwTCvOE26gmoTSZ5fgc9uTw0pxkcNnX+4CA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 23 Jul 2025 13:42:51 +0200
X-Gm-Features: Ac12FXxG1mN7SNofv6YKFctes78BZl35oi3iSOX_252xqT_VaNu9-cn1vRYe1Ns
Message-ID: <CANiq72mAOZQO1K=qc0AgP-61jETD259kR4H3Gk6vMPwL9bxB4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Add initial interconnect framework abstractions
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 1:41=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> reorganizations makes sense, but I was only suggesting that :)

s/makes/may make/

i.e. I didn't mean to suggest anything deeper than that (how to
organize is really up to you and the C maintainers etc.).

I hope that helps!

Cheers,
Miguel

