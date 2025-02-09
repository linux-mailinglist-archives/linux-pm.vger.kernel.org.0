Return-Path: <linux-pm+bounces-21598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22689A2DBBA
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 10:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59945188719C
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 09:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51B21487E1;
	Sun,  9 Feb 2025 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkH3L8eg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A003FD4;
	Sun,  9 Feb 2025 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739092096; cv=none; b=DcB98+pxCu6Ge9yDYLTI7iO6NYidpQVuI3cHdUQP+4/TkEX5H1uADkiHkGveAyqaA/JguMKRjZB0NlrD09dRCaASAwZcSu85LMepEyp3uoX9461gomb9zVifZQaNC84nZQTnG1cJGTiuE6jcwjfpAPyULur+qXXG7L2l4ISg0nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739092096; c=relaxed/simple;
	bh=u5j8QcfxyKzcU8BsJtEeghuI/Py78/NxxL+MwBij7N0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FSO/VR0L03QiqF7QobGwMpttPFZ12/vGMTLEr5lHhvGWfvaP5G63jk3VyYKmjJgMok/vC6sdKRQn58KVq67g9OOy7/A7aHtv8+ew0S5VaJSihGUJxWudtJp27AUh/934ElBxkBF5SNv8TtABm4//W4PjZrSCiFZ4rwnoSRMTy+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkH3L8eg; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5de56ff9851so2791444a12.2;
        Sun, 09 Feb 2025 01:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739092093; x=1739696893; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5j8QcfxyKzcU8BsJtEeghuI/Py78/NxxL+MwBij7N0=;
        b=FkH3L8eg4LvgneekwXrjFvQ5xvXW6CkcALZUkYid6g3zYyWbSSaLk0kNpEObsHukpT
         wkE7WZnetNA7wDmc8+x3ph3w61qr7Q5cKYEAtvF0UA8xOkNM+/xjc9OcZNQPQWTvMjEB
         NWRP9YNrRZ7jPphUGNmnbyF2ZTweqsJ38HP7V1lQbwQiyTm8Holhw88Iv4I6BRnAurVQ
         b1aYjfFMCMKv3GRSj1MGbYVZHje7iYZmD5e2KMoNqs7wgdZT71NIcWp2xikvcYdzgptF
         6VLXzzYpjkeNjwgnDQqhC5hY45H0h/00QOK8miooq0PN4Bt5kY+iXjpiE9sAn/38fNZa
         lvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739092093; x=1739696893;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5j8QcfxyKzcU8BsJtEeghuI/Py78/NxxL+MwBij7N0=;
        b=cjv6H05U3veGGP55OIpzhGb5ZUYfRyuL8fMEXPXls4DFmILZmGr1E7ZAE43QPClOs9
         VgT2nwjrJTLRazkcvYU61SaOOZ8V9JMU2IyEDDwYSWVcyopyX9I14KzfZ1A1I4fQiLjZ
         uNEFLhOmbsXP8Qy3awDDQkVNQyD7XzEAvlMZ5kAJYqoUfM1fskRxaYy2sNR9fIFUdzne
         fYBt6ejGL+Feuq7XE8s43cfXjLrPUZeFTl/L8L0qTP4p8IU/a8X++KGanHpnER1g99dR
         rFjvtZ5LwC+IxQEDYY4ho1iP+o1mnwRbeC6jhStBoRQ3HsHGXqCOJj/MCmbb/jTllc96
         7hYg==
X-Forwarded-Encrypted: i=1; AJvYcCU+txa1kofnZmKvLBsavwLEhf3YylPHoJqMzTfFuEKhYkEzpUimOaxoQKFFwjST1SplK+skOj7CSN4=@vger.kernel.org, AJvYcCUHo7XLJOHETKww+yKejj5aLZAG/iOEBV4Sz+leyBLmKcZ/0wwW8A1S8sAawMwrLsC3YZagtexyQ7SeKo7t@vger.kernel.org, AJvYcCWaczNqjEmN6VICmhuYGW2wCF4uf5TWQRdtUVrZRn09ciYsHz4Gigfamq4B0ASumDEwVw6Jb3AEzcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqlWH+cILhCsO+ckKEkXnAyTep2rMprHQ2qqsgMNgZe0EXMTOZ
	iIrvQBb1m8Tl1YE+8tXsuU+bek2JH24D6C28aWlbHK2JBpoOwGxK
X-Gm-Gg: ASbGncvBj7OE2Nt+hbxvdkyAe+VwXtrdhexMony6IFqfua/8vX3UVk+dcqSDlpsHMkd
	IzZ9kywqEuYFhZwPmlVHuU9FmwNJ9FDalLkKowbOBsQdvCs5w2jDEZ8gUuggUfwjEd7Cz+t3NDf
	YB/le+faL0YP0wv3J+ySeXHSIL+G4M9Wt0by5bS5OnHncTmePpqBfu7aCYSIJJ2rBkxQaWdigDu
	YqkmxkNbISQPdrCI6xv69kbQO01ibI8HLDSYQ9916viw29ewb2UJ4xqEWT2s+Nmubpze61NlVBS
	UlLQXYJe2MN45N8RGPzQanrhdY4Mq40kw3Zlq6b7kELSXQ==
X-Google-Smtp-Source: AGHT+IHFySFmIybAcA7DUUGmF3MTWuZOtCcDX0Whx4UzudEVO+Sxbtco1tCKOWIoDiJPzt7hj6H3JA==
X-Received: by 2002:a05:6402:2106:b0:5dc:80d5:ff28 with SMTP id 4fb4d7f45d1cf-5de45018846mr9972757a12.14.1739092093049;
        Sun, 09 Feb 2025 01:08:13 -0800 (PST)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de525f35b7sm3518585a12.53.2025.02.09.01.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 01:08:11 -0800 (PST)
Message-ID: <bd8d6350c1539130e54b3a087502a083204e6723.camel@gmail.com>
Subject: Re: [PATCH v2] intel_idle: introduce 'no_native' module parameter
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: David Arcari <darcari@redhat.com>, linux-pm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>,  Len Brown <lenb@kernel.org>, Prarit
 Bhargava <prarit@redhat.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Sun, 09 Feb 2025 11:08:08 +0200
In-Reply-To: <720944c4-48b2-4d1c-8a02-d81416ed7484@redhat.com>
References: <20250128141139.2033088-1-darcari@redhat.com>
	 <20250206164009.816232-1-darcari@redhat.com>
	 <6c258775cdf2f8f3c370c0cb81daf22dacf6aeed.camel@gmail.com>
	 <9241eff1-0c2d-4c82-a77d-cb8b67cab6f9@redhat.com>
	 <c25d3b9abced9263da463b3ef4f31fff73878189.camel@gmail.com>
	 <720944c4-48b2-4d1c-8a02-d81416ed7484@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-02-08 at 14:56 -0500, David Arcari wrote:
> I actually took that from what was already there.
>=20
> So I can add "In the case that ACPI is not configured these flags have=
=20
> no impact on functionality."
>=20
> Does that work?

Works for me!

Thanks,
Artem.


