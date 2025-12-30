Return-Path: <linux-pm+bounces-40044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B33CE9B5D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 13:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22FDA301BE84
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1475A1A0BF1;
	Tue, 30 Dec 2025 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0eVuIVQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514818FDBE
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767099400; cv=none; b=J6QnfNWb121zak8qJtXAeheZWsHMzd0ImkIJEsBrYKQFFLFX2cLw37ewxttOmxQF5LsfOJdz9rzDaZq4KiqVx/LeLO6hukpJKcCFqn1+E99YSVdqjSf5V881qvP5UBEGl+q5/gCJn1e34D/4qJ1NowYTUni5HKzDqDHHM/fKWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767099400; c=relaxed/simple;
	bh=qA+Llm8/LCWJPs0YBfi84Z6KAfPrxe6ryFR18gOX7Lo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=IqtO/5tDu5220is5TCu6RfBJe2I1fTJcKmJsPygr1HYrduCkOQPlRru022urNvwkBNFD10yfGjMeWv9zLaQoFAC1N1MH3pGNoOZT9+/6Hqp4KmZiCaZWUizvOJMipaDLp3A3T25EwaYLH/mGM5KhSr09gi5yjS739zlhl+UXX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0eVuIVQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so65180125e9.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 04:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767099396; x=1767704196; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1g1kb/JOi9XsJPGmGm57a9CaF95ijegnXyJMo6Mx7xQ=;
        b=M0eVuIVQDXLgtFb0RSfTRIefHUd2B3yf2xVI9XuDNUQtg9i2Jjr/BAfv62IIiHoXlE
         3ybRYxDwOh5SmfLM7sbo0Gvc2AB8tdJiXgo/8exI9biloB6h1O8LvG7laS+khJXumr/w
         MTeNGywJnzUb/qmnog9KgaO5MV1Bf4F55si7DQ5ZnGwMLd4MoqwjJ3X562XV0fTyDsHL
         Sltyr+xx9O+BB8QmY+C5ARMi3JRjuPc8QjzTVPYR/guhFpdCNswTpGw7p3KgkgiHCfal
         sVlkEcB0lfnI8hlh23vF1RPKuL6Yq7T8T2X2NNyWIYV5VeFYPVUIj9f7W94EZINe+3Kg
         hGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767099396; x=1767704196;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1g1kb/JOi9XsJPGmGm57a9CaF95ijegnXyJMo6Mx7xQ=;
        b=meS9LecW6XjuM1CWRtzxzlh4CFraLdQT27Tmd0zWytBx0Rd/8lak8ORsZnGUUDTmwU
         VqKteDUotDNZfy8niNCL7mQuYKlhI5kUo0tyJdUUOXhBbVDFfqsBqRnmSqSTH1F2Ctkn
         WuAoLrq87/+Ln8xxae8iMyRLud6VnqSNU2CH9OgK6mSdH0/Qj2GoBsD9XDP55GsGIudp
         VXGa60M0x4ZHek4eIk+4fJt76NpxUPZS4i4Y3ia+NXwjEVdZxIuK0bFvn50gsuEjvyV8
         x3HORAoVIP76nVbP4XV6Sk7PjYWgzszsWOPKFdKDy9evxjYIJ/lxLMuNFa5MG53mfSjJ
         6QZg==
X-Forwarded-Encrypted: i=1; AJvYcCXgrtgnDJe/jUBA6nqNGaZZWz6gtKYEYzEwIn8qzjyjNOPppYrTkNoIsIFfmdDTR7AhL5zO3s2wFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxd8xa03KnO2sXsQF/JbUnIb92NW/JV8mQxw4Y8jOzCKLNMumt
	rs6SBmC9zmdN7iaUF8vDCGYdjQ/Fj19SZo1pp9DpVdeaxqOMmcsS3yjq0uPMjg==
X-Gm-Gg: AY/fxX4H75AWDs2jqGWjZpXdsO9ZGpBTwWPGoF0sx+gz036ZZON09OllqLQhxR+WBH7
	QTreIaiUwaj04FrGSayFmesbudcWh4aw0df4+jgvuKY+LgC87GiP6WRjDS2RSOACM5WU8C5G99v
	TdNldDcvnM4SbKAMiN13L37yb/In3C4S2rjJ/5vIX1McEUCaij/szrzgP/Z4A+mPizSwJJnR/sf
	jZb+Rz9u7fY7/Mgn9F5RJ3l7W/3qsuHMd8sudiQuaJLvUdQWMSdwh5I+yymKiILPqYGqiOuwU5y
	/JJH19XzU/6WrkMYLKMJeKiatZ9GC1Lll8TNmT3KGfr9eYzsPBnNy94dAz0Ewq/rQP5Hbai+zI5
	cqbcUADq2+L0XjouMihwFqlkHScNOGKlqVwhpd7SpFWuM5Sjk5tLgMAp6X4pap6MQKf2Db7zeKR
	/HaEIT97uQZNU+QuVWCm7V2v6uwPq7NxwEbRKZSdGhacMe
X-Google-Smtp-Source: AGHT+IGXIOQiYhgHUXu3tLRwuadO2gEnm0hRaSS+QlqjvGD/CbRO6q8KjLwpAqdJ7Xfc/tDhstFhvg==
X-Received: by 2002:a05:600c:8b06:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-47d3b011b03mr234735265e9.19.1767099396343;
        Tue, 30 Dec 2025 04:56:36 -0800 (PST)
Received: from smtpclient.apple ([2a02:8010:60a0:0:7880:449e:4715:b158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346e48sm578531675e9.2.2025.12.30.04.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 04:56:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Donald Hunter <donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH for 6.19 0/4] Revise the EM YNL spec to be clearer
Date: Tue, 30 Dec 2025 12:56:25 +0000
Message-Id: <BA1D25E0-F4D8-4FFA-92AA-FE58FB3622C1@gmail.com>
References: <849b576e-9563-42ae-bd5c-756fb6dfd8de@arm.com>
Cc: Changwoo Min <changwoo@igalia.com>, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 rafael@kernel.org, netdev@vger.kernel.org, edumazet@google.com,
 davem@davemloft.net, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 lenb@kernel.org, pavel@kernel.org, kuba@kernel.org
In-Reply-To: <849b576e-9563-42ae-bd5c-756fb6dfd8de@arm.com>
To: Lukasz Luba <lukasz.luba@arm.com>
X-Mailer: iPhone Mail (23D5089e)



> On 30 Dec 2025, at 09:44, Lukasz Luba <lukasz.luba@arm.com> wrote:
>=20
> =EF=BB=BFHi Changwoo,
>=20
>> On 12/25/25 04:01, Changwoo Min wrote:
>> This patch set addresses all the concerns raised at [1] to make the EM YN=
L spec
>> clearer. It includes the following changes:
>> - Fix the lint errors (1/4).
>> - Rename em.yaml to dev-energymodel.yaml (2/4).  =E2=80=9Cdev-energymodel=
=E2=80=9D was used
>>   instead of =E2=80=9Cdevice-energy-model=E2=80=9D, which was originally p=
roposed [2], because
>>   the netlink protocol name cannot exceed GENL_NAMSIZ(16). In addition, d=
ocs
>>   strings and flags attributes were added.
>> - Change cpus' type from string to u64 array of CPU ids (3/4).
>> - Add dump to get-perf-domains in the EM YNL spec (4/4). A user can fetch=

>>   either information about a specific performance domain with do or infor=
mation
>>   about all performance domains with dump.
>> This can be tested using the tool, tools/net/ynl/pyynl/cli.py, for exampl=
e,
>> with the following commands:
>>   $> tools/net/ynl/pyynl/cli.py \
>>      --spec Documentation/netlink/specs/dev-energymodel.yaml \
>>      --dump get-perf-domains
>>   $> tools/net/ynl/pyynl/cli.py \
>>      --spec Documentation/netlink/specs/dev-energymodel.yaml \
>>      --do get-perf-domains --json '{"perf-domain-id": 0}'
>>   $> tools/net/ynl/pyynl/cli.py \
>>      --spec Documentation/netlink/specs/dev-energymodel.yaml \
>>      --do get-perf-table --json '{"perf-domain-id": 0}'
>>   $> tools/net/ynl/pyynl/cli.py \
>>      --spec Documentation/netlink/specs/dev-energymodel.yaml \
>>      --subscribe event  --sleep 10
>> [1] https://lore.kernel.org/lkml/CAD4GDZy-aeWsiY=3D-ATr+Y4PzhMX71DFd_mmdM=
k4rxn3YG8U5GA@mail.gmail.com/
>> [2] https://lore.kernel.org/lkml/CAJZ5v0gpYQwC=3D1piaX-PNoyeoYJ7uw=3DDtAG=
dTVEXAsi4bnSdbA@mail.gmail.com/
>=20
> My apologies, I've missed those conversations (not the best season).
>=20
> So what would be the procedure here for the review?
> Could Folks from netlink help here?

I will review, hopefully later today.=20

What hardware can it be tested on?

> I will do my bit for the EM related stuff (to double-check them).
>=20
> Regards,
> Lukasz

