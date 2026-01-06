Return-Path: <linux-pm+bounces-40328-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BFECF9934
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 18:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 635C03043A7E
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 17:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346673431F5;
	Tue,  6 Jan 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYvtqPyv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98407342CA9
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719286; cv=none; b=H6EPchb8FJcAFWviia32zUvoUblqG85YWa8hoTq4UIMY8OyQYgwol7NAHJk2SdLu4vqy3P4H0KYKpUAPKKjJMfXOPd3RO9yR3ctW9kgjcM65ZzNedkML7aVzMEgsImrqFT+VvxRW9I61xXaetr9jFKqVKfb13DZHYRw03vpzMAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719286; c=relaxed/simple;
	bh=Da1+z6b8uGHwUBBD5JI63a5JdnmV5MD64hW+WWvh91Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LdDfsGEsdB70v4RKGoyaZsF8WkB8JX2xcLc7IE3Kk+cRW1wfg0wsFrtztGFRXPRizCV9Qkbjtn1yLF0prrkYcX1KvnyZ01Q54keuQ4etZ+jd34POr8oYTFFKssTQ8a5LqMO2jrrDQGSO6Z3fANb3XCkjZu69xNW/O0s3v+MGr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JYvtqPyv; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c30f0f12eso975540a91.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 09:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767719284; x=1768324084; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Da1+z6b8uGHwUBBD5JI63a5JdnmV5MD64hW+WWvh91Q=;
        b=JYvtqPyvSAFsBI+eLNYw67akcbkLUgTHpKj5D0BZ8GJIf+UEkAALvEhWUgP2EtiBmH
         Jkp6+b7koZYOXhURIx436inPpylOR9cdzl/05F3yx/rxch4QWmpP4/4ets/0su2EDv4u
         BiW3i633+GeFJEyzCvgl/PQxBS5tQqRZyQoYzcAWHabDQs+oYu6qBywWZkrJQnqTKZ2j
         2E+Y5llzojFAcRTsfCGoPqJg7QXDTG+nfTG2qqdN8T1gnPRK2L6VMZyO+CiJtjUuxtWq
         X6Fss19hoh6V7QcX+WzQfFGZpqnyqlxKk5PTq2v4fq++KnHAa4dquF3vwzhBm936tOwq
         JnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767719284; x=1768324084;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Da1+z6b8uGHwUBBD5JI63a5JdnmV5MD64hW+WWvh91Q=;
        b=LSuD9GdGYDTMptsHsqbUXjH2wLeg/4Ngtlep6ILrvWasqY7FM0p6JKJRKgtIqFzgbC
         2pZ3JZAtxU4WDQq6wziKR8j7D7DQlwiyZfQejc8OUbKw/9AxWudZXzOi7dal3wSgsuCC
         Bjc5Rd0TT61OI68/p0xC4oYrbxeqmjLk4ku+QexspZaEHMqaYkgN72IvLkUXy/+B8Te/
         BMidbDIV6Lf/U5B9Rv4hTT1g0E5xVsmto7R7rO/K3+1ORGbIuO4XLGyHzfEV9tsWCE16
         xLhRo+0EJTr2HihBnisKwE/hdWKi++WicbAir/dbUJ4bwPQxe8bSLj/RGAsDwIR1MkT0
         en7w==
X-Forwarded-Encrypted: i=1; AJvYcCXxLzgNCIzKfi3TaFUl+15T/AiBlA4pqQO0oWQIzaJfSxqyXt/Yj/OqWKOrjO4UHvD0NK4V2FQz9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhnwCGHNKTrtHdChQJWo2wopGXb7ToFuq4EVlzTsgzTF7Y0M4G
	ZuUtksyuOrjAhYdlpdTVftF+GTGcuQprK2RNnakg73oDeLXrh12Tg4bJoq/BP2mRVoA=
X-Gm-Gg: AY/fxX4JE5plmVdJOuGWXLq4qdsSmyeGHe6HPPpRvEeII0hXEiJQugCmwJQEFCvf8Pi
	iP/Ubr4VJLCte8DoDyIEbFnrVR2qcyzV1yMLPUDF3wu0hHvV/y2oqKN9vOvNphWdWDr8OPJGvfI
	F5w/TFqBTb+ZVh3tLEguMDC6TTvvJD5Q2uwNCZvO46CWLd7ECHIbT14RsvJnBZUSTsI67LXwmYl
	MEBYCsP3CSiuLHlmB1spAg1r3Rs7jRolznfvo211HEKU+W1wlsBbK7+VyYaapxp/ZZmyJQod3ze
	gChO9aCNOhZXQW1ZOy8ApcEfCIpbMbyXQtVFLwkRIgooyvgrvZfTJKwgIfprE1oo5pVLwZIdIU0
	k9yl/yMvmbSKf/HMSqMpi4w5sO/DVPVJuAZGLGnQIyrlYvWQ15c2Gz06a5Cq4EVhcvooXA2bwQ9
	4qib7KenWn2o2uRV2u
X-Google-Smtp-Source: AGHT+IF/YyPky1JmsX8trR5QA82S375cVcq4PGyCdARaly/JqyN2JQRlvVwmKUH1OrX5HSLct3ppWg==
X-Received: by 2002:a17:90b:1646:b0:343:7714:4cab with SMTP id 98e67ed59e1d1-34f5f2f8b2cmr2485923a91.22.1767719283665;
        Tue, 06 Jan 2026 09:08:03 -0800 (PST)
Received: from draszik.lan ([212.129.74.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb7442asm2746281a91.15.2026.01.06.09.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 09:08:03 -0800 (PST)
Message-ID: <cd07660f196ce5686b32a67fa5a4edf5dd70dbc2.camel@linaro.org>
Subject: Re: [PATCH v6 0/2] MAX77759 Fuel Gauge driver support
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Thomas Antoine <t.antoine@uclouvain.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Peter Griffin	 <peter.griffin@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 06 Jan 2026 17:08:32 +0000
In-Reply-To: <a6f5c448-d0ab-4119-94ee-201bc3027e84@uclouvain.be>
References: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
	 <8385a4fbb6c10cfe643c2f310f6a67150e260cf4.camel@linaro.org>
	 <a6f5c448-d0ab-4119-94ee-201bc3027e84@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Thomas,

On Tue, 2026-01-06 at 17:54 +0100, Thomas Antoine wrote:
> Hi,
>=20
> > [...]=20
> > Are you still working on this? Are you planning to send out a new versi=
on?
>=20
> Really sorry for the long time since I sent anything. I had some personal
> issues and had to focus on work so I could not work on this.
>=20
> Moreover, after rechecking the files, I noticed that the support for the
> MAX77759 should most likely go in the max17042_battery.c file. There is
> already support for multiple chips (e.g. max77705, max7779849) and when
> I looked into it a while ago, most of the support of my last patch was
> present with some things more.
> I don't know how I did not notice this when I first started working on th=
is.
>=20
> I can rework this patch and send it by the end of the week as the change
> requests were pretty light.
> However, I think the cleaner course of action is for me to attempt to
> integrate changes into the max17042 file and see if anything causes
> problems which would warrant a new driver. I think I can take the free
> time to do this by the end of the month.
>=20
> What do you think?

Thanks for the detailed answer, much appreciated!

I'm always up for cleaner solutions, and unless somebody else has a
compelling reason to not follow your new outlined approach, I'd
say go for it :-)

Happy new year to you too!

Cheers,
Andre'

