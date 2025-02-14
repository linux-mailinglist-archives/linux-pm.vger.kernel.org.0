Return-Path: <linux-pm+bounces-22082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FFBA35DE1
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 13:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DCA3AE72F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 12:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D9E1E89C;
	Fri, 14 Feb 2025 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyupKxZV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444BA17555
	for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2025 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537472; cv=none; b=mWAq4VDQirSzWLTdBMG2FQsNelN6NObfWMuyWJlx85oUPYyZ9Tga84q5S4xqNZhY931Ot87nkRojkuHrvXnoz18e3SuaEUGfbp5SzCuTpjHiKYto2bUJT1fZji3dIizZaCl7f1kyeFbLIQorgwC4M6QCOOweTjoaY7AvrcSS6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537472; c=relaxed/simple;
	bh=JGTc+Sf0Feuosm0Je9PJuzw2tVCZLsSqS+uLvp78470=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fh5glfA3DgPzK0xDhzijveyJhnfVsvLGrJKWpn8qvm05pp0wnVN0ACVgQIXElE/EvpT09NYrG/Rbzvsdymz38BrW1gX7Z0oC6WEUL3jSSdLKNzEqg+G3quUBWM+qfVes94lOaPO38ckwZraGT5SLYEC0XJXX7y4/8KAJPjXPDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyupKxZV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5deb0ea1129so3216317a12.3
        for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2025 04:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739537468; x=1740142268; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGTc+Sf0Feuosm0Je9PJuzw2tVCZLsSqS+uLvp78470=;
        b=HyupKxZV4FTSgwIND0HjY9Ub8Elo+7R7XfOiiqYuMpynJZCM7Ir/0zJevTlbvD1l2F
         jr9KTsRMhBYzDGzhE00KewhrXMQ9hqxv/0jOcfDLZg12LLR7TdPAtdCoBUr40c6+5cFb
         vZbL/QVjN4IjWGOFPAaWut+kxCGs9ik2pigx4sucqPl5lIvYh9RnkmBp7f/3vO0PNVDv
         6VYbsEWP8NwTrkYRNXAm9S3qQFKBypFyovsy3Slgqb0jCFIjYPDeImD2i/7HHxZySooi
         dMkAV5VdoOnKDdbBFwlwcScMU97TSfR+hqlt+CVYzt/6XvhDC5eHh6groAdLEjut0VRx
         gl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739537468; x=1740142268;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGTc+Sf0Feuosm0Je9PJuzw2tVCZLsSqS+uLvp78470=;
        b=CX5MZ6L46PlZFX0N2Q3d2g6UmtmKhKCF2qVrweqQDPAPBDKZ0Kw6n+V0uhMu47OMxB
         mX9tZwYWEqbG1/quxYVulyeJY20JO+p4fmsVZ66tjdmbcWM2bN8BOe3wJwb/52jPKouz
         SM056qoE9JJs92CUmefk8xa+p1EPKs24MIum0Yhf+F872jNQvawV5OqOGJV1Kv8JA2xF
         sGdUO8q5soC5uLkGc2/s220MyHBw5Xe1rAJRUZqPxMqk7VfWvnEtmGfTYgN6zoioSmuC
         B/q3NjBxFx3UQrsjX0WnOPeQ9co+aNWCPMhe1cyD7u1EejgidYRjlhrpv5VOA/QMLwqP
         tUhw==
X-Gm-Message-State: AOJu0Yyk0QUhsjwqdQt8GRQi++7zync0zuPk5detHy/CKK2dAVf8mpF7
	tncX8bJW8XSWg4uhCgL58RC6xjQ5siHEKl8ngKrNzcnjttozVV45HawDWsts
X-Gm-Gg: ASbGnculuf4XQkWFQpK6rWgjn6hbFyURPTn3Cb2rzj7ekd26V84pIxiFg6GC9D0jRoH
	MwtFVkzGVj8De0EoRJg7UKTkLX6w694SZd4YtZKhlODh7P+r3EkXExtVd7iVi4W0Eez3+ii21TR
	G77Ab+APH8CDaxSs3YzuJurIqtUztbidemkimDSZPJOu7RZv6nR+nwqmcP+FZzfh58qMnTWRIHI
	bkVKR6vZgJXbu69rTx+8uw01ANpuN8Pk4S0J9kHFZaUxoLamg23LPnlQMS6mIi7Wabxa4ilmRtz
	Pm2H6Xxmq+kJr4feFApB+/8NAY9Bj91FE3C0Uvha4CwMCQ==
X-Google-Smtp-Source: AGHT+IH1POJ5Rg3D85FKr+OyMJiv/8EuDicyZmrNA23GytDsxqyu3xxadgpHNeChRIpDwGZFHFcbwg==
X-Received: by 2002:a17:907:94c5:b0:ab7:c6f4:9529 with SMTP id a640c23a62f3a-ab7f33781f4mr1299803466b.7.1739537468121;
        Fri, 14 Feb 2025 04:51:08 -0800 (PST)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.196.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba9cf8a262sm58618166b.22.2025.02.14.04.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:51:07 -0800 (PST)
Message-ID: <f6922e38fd83433d60c0f7d9dc9a6effb967cc8a.camel@gmail.com>
Subject: Re: [PATCH 1/2] intel_idle: Add C1 demotion on/off sysfs knob
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Date: Fri, 14 Feb 2025 14:51:05 +0200
In-Reply-To: <CAJZ5v0hnm_Xx-NQfOiOFWNYJoeOr-LbgTcd1u0SxNM=EbyQQTA@mail.gmail.com>
References: <20250212084232.2349984-1-dedekind1@gmail.com>
	 <CAJZ5v0hnm_Xx-NQfOiOFWNYJoeOr-LbgTcd1u0SxNM=EbyQQTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rafael,

thanks for reply!

On Wed, 2025-02-12 at 21:11 +0100, Rafael J. Wysocki wrote:
>=20
> > +static ssize_t c1_demotion_store(struct device *dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *buf, size_t count)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool enable;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D kstrtobool(buf, &enable);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return err;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&c1_demotion_mutex);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Enable/disable C1 demotion on =
all CPUs */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 on_each_cpu(c1_demotion_toggle, &=
enable, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&c1_demotion_mutex);
>=20
> This is not the only place where MSR_PKG_CST_CONFIG_CONTROL gets
> updated.=C2=A0 The other one is drivers/platform/x86/intel/pmc/cnp.c
>=20
> There is no real conflict because the PMC core thing happens during
> system suspend/resume on client platforms, but this is kind of
> duplicated code.=C2=A0 Any chance to consolidate this?

Thanks for pointing this out.

I'd propose to leave it as is because it is such a small amount of
duplication and also trivial. Since the two code paths do not interfere
with each other, I am not sure consolidation is worth it in this case.

I was also hoping that this patch would be backported by OS vendors,
because it makes a very significant difference on recent Intel
server platforms, so I wanted to keep it simple for easier backporting.

But I did not dare to CC stable, because it may not be perceived as fix.
However, in practice enabling C1 demotion fixes performance issues on
recent Xeons in some workloads.

If you really think the MSR read and write code should be consolidated,
I would propose to do this as a separate patch-set on top, so this one
stays simple and easier to backport.

To recap:

* I propose not to consolidate it.
* If you insist, I propose to do it on top of this one.

Please, let me know.

> > +static ssize_t c1_demotion_show(struct device *dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr, char *b=
uf)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long long msr_val;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rdmsrl(MSR_PKG_CST_CONFIG_CONTROL=
, msr_val);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return sysfs_emit(buf, "%d\n", !!=
(msr_val & NHM_C1_AUTO_DEMOTE));
>=20
> This reads the register on the current CPU with the assumption that
> the specific bit value will be the same for all CPUs.=C2=A0 Is this alway=
s
> true?

Yes, anything else would be either a BIOS bug or a user toggling the MSR
bits directly via /dev/msr. I was trying to keep the driver simple and
avoid detecting different values, because the only think we could do in
that case is just print a warning.

> =C2=A0 What about systems with more than one package?=C2=A0 Do they alway=
s
> initialize this bit to the same value in all packages?

Yes, anything else would be a misconfiguration or bug.

> =C2=A0 I guess so,
> but then I would add a comment documenting this assumption and the
> reasons for it.

I'll add, thanks!

> I'm not sure if the attr name is clear enough.=C2=A0 I guess reading the
> doc is really necessary to get an idea of what this is about, but it
> might indicate that the demotion is done in hardware, like
> "hw_c1_demotion".

Well, let's see. I propose two approaches for naming this attribute.

1. Follow the Intel name, documented in the Intel SDM: c1_demotion.
2. Try to come up with a better and more intuitive name. I would suggest on=
e of
these:
* demotion_to_c1
* auto_demotion_to_c1

I followed approach #1. I agree that C1 demotion is not an intuitive name,
because it sounds like C1 is being demoted. But I am used to it, and it is =
also
old and documented in the SDM.

However, I can rename it if you direct me this way. In that case, I would
propose one of the above two. Please, let me know.

Thank you!

