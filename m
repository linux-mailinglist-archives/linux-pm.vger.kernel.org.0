Return-Path: <linux-pm+bounces-21582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E55A2D59A
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 11:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810763A4BAD
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 10:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019521B3936;
	Sat,  8 Feb 2025 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+I9CRvD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6A21A8F71;
	Sat,  8 Feb 2025 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739011033; cv=none; b=VFeG++JIEUuSCkl8NwPtWi/j9j7xGWsZStwB5w18KQA+dHChv1sznEp3XLYvnTIlNxlGBs2AHpl31tjKuijt1cO2NTW//90NrCSLkQqBdqdCZzMROCWvUHWQIO5QSHGVWFCXGTpe8zeOO0zP6ntTvz7YYHevir8xOU95oVpWOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739011033; c=relaxed/simple;
	bh=fbTAEHxKYAB+zntHxdQR3V8tZP+Ebuo9IaCwxPfpeWM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JyLX3/Pv5N8H0u+dxnYCkCuDn7U80DUXWkF35e58m6+4X5mxjuqPwHyrP2N7hW2x02nE9s73WW8FCK01kize8Mt9nuHDj1ZIUp8y6uNeD/iW2sv0L9Nqt0cM70A9L0NS0sPoS60ZvSHMVLSSmLoYr065B/o6KIJ2Yy+/fUcwEos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+I9CRvD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5de594e2555so1264998a12.2;
        Sat, 08 Feb 2025 02:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739011030; x=1739615830; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lqq5OoJ+h980raMJOy0T0Ud0ZH+rb/gmRb99fFAaT6Q=;
        b=Z+I9CRvDr3axEtu9pR9hiWXEo32jZuwRWrPvEpUBsbZUeKbcM4hHbnzXB/PjEkBaJ6
         l2r+ol+0Eh6MYIRfzEQ/Cmn/wP7oK5R2jYGQDqv3KxsDN/C0K0NX5Aw4IhwluaS91x+t
         f/2aPA1W3BdQsPUCrJZ46bEKbVqgs76Dg517N0KR5iGCY9uze75pyR4hWAhYQPoDa1Wi
         rKeb1jCNBBGuolYcO8H5vZThC66BqYHIHUbUUq+1eWkg1aPZBWOjjtLA754jRbwi7N/x
         XRx2Hem0JRjJnKOr7YY2YEzGdTTi9LJsdHwLhMkyKGP/NL8drUknAH9D+8nmdcABPBla
         Br3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739011030; x=1739615830;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lqq5OoJ+h980raMJOy0T0Ud0ZH+rb/gmRb99fFAaT6Q=;
        b=dsvzVOnTLXbyA5+vENzxuIUqTmVi5F0HTHdFE3AWZRK/Q1By6lBmsHftItJ/2oUWty
         p+MDrMyR5dnydB7Ow1jrVeRit6jZzN+0jZhcAjBR0MMxWZy/5C8SRsvWct1ugCEHYoYD
         htE5IL2zP34Cmm39i/BNSf6Jt+d8aBl8qinmDeMUGJj08ItruFMYcIOg1Vdguae0nw0e
         TuYla4iOpeLvDNsOp0SbuuN2vhM7csaSNSNBexvB3z/ZWT22zFcGJDGjIULDd+uHW0Zd
         wqVqMWCu7k4qH/Ia9hzo99UyCA2yRb0VO/xKlftgvjFuuFL6Yd4PzPPQypGVadJot5XN
         5tvw==
X-Forwarded-Encrypted: i=1; AJvYcCU3M1A5FhAwDKMPplzQMvlJHfevHItFBblEtqxAKwddHZNDNMAH2i6AdlsWDBvsiikplv/6dndyWxM=@vger.kernel.org, AJvYcCUT+aJf1KxeZvJqPHfAe56V5clbCTgOrNmWie69TAjQjF3j+8Er/TVoS0CNzyfuZla2We7WlwqKNeVVPi9t@vger.kernel.org, AJvYcCVvuC1zzFuMtatFn0Bf1KJ/OYmTYGkRhqOAfBWz/BjpWib0037+1FssIB+jquNrjNEQCxzak06bqR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhuctIz9Xea7kquPi1pN1n9ZjOOmXCIJlaVwt372syut0LgP4e
	5YSiQhHVhXcCcV2kCj83nyEYf3EzeVRNzW704XdDaK+82uTtyVjpUQO770Rz
X-Gm-Gg: ASbGnctWFBYkNT1T+0ofXKPFRCiqXZjC/ZPI9Zu7qMr1VxhU1cPGNDNBoPXjgIArQFa
	J7xqEpYSjPLzxswYO8NGgxhDu3uCk78Gkcn2fIdcXtkmj+LDQUN/wkbayxfbXz0iwj/KnSKwGKs
	NPDKRWp4GgnRnl0F3I/80UJSY+Ow3GHwR5HqtHKQQqV8iQxn7fCuO1G/IuccTfMYfXOL7PEfzc5
	9SB5JEHodbk9t0aDiVFd7sT1wpLp66ZSyCMoGDH6yNIJ9fYCWbQAfDYfM5KxJhB+QTtDg/9lUTl
	I5syBLQCgc/lQTP7lZx6LGs+oqbsVqjeGXzDtB5DnF/OUw==
X-Google-Smtp-Source: AGHT+IF7wQRnc4J9ubjIAS64xIxUH7T3gYgY1o1PxDnZ0PIwuxSosqX96dunVxzMghowYFQ2GxIymg==
X-Received: by 2002:a17:907:3608:b0:ab2:db7b:5db3 with SMTP id a640c23a62f3a-ab789c6e8efmr543532166b.54.1739011030301;
        Sat, 08 Feb 2025 02:37:10 -0800 (PST)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a275537csm110939466b.66.2025.02.08.02.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:37:09 -0800 (PST)
Message-ID: <c25d3b9abced9263da463b3ef4f31fff73878189.camel@gmail.com>
Subject: Re: [PATCH v2] intel_idle: introduce 'no_native' module parameter
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: David Arcari <darcari@redhat.com>, linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>,  Len Brown <lenb@kernel.org>, Prarit
 Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Sat, 08 Feb 2025 12:37:06 +0200
In-Reply-To: <9241eff1-0c2d-4c82-a77d-cb8b67cab6f9@redhat.com>
References: <20250128141139.2033088-1-darcari@redhat.com>
	 <20250206164009.816232-1-darcari@redhat.com>
	 <6c258775cdf2f8f3c370c0cb81daf22dacf6aeed.camel@gmail.com>
	 <9241eff1-0c2d-4c82-a77d-cb8b67cab6f9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-07 at 12:13 -0500, David Arcari wrote:
> > And if kernel was not configured with ACPI support, are these not
> > recognized? Or
> > they are just no-op basically?
>=20
> They are a no-op - the flags are all set to false so ACPI C-state tables=
=20
> are ignored.

It would be nice to mention this too. Otherwise it sounds a bit incomplete.=
 Like
this:

	If A then B. (nothing about "else").

Better way:

	If A then B, else C.

:-)

> >=20
> Sure - so is this better:
>=20
> ``use_acpi`` - No-op in ACPI mode, the driver will consult ACPI tabees=
=20
> for C-states on/off status in native mode.

Yes, thanks!


