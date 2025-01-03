Return-Path: <linux-pm+bounces-19920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B4AA004DF
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528AE1883BAC
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 07:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472EF1C5F1E;
	Fri,  3 Jan 2025 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXrp7FRZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0E51C1F10;
	Fri,  3 Jan 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735888879; cv=none; b=jPxTyGcfWq9BYHKa9QpqaTJakvE7QGvPurvKFmNSS0Ki5tPn19WJ7ko11nnJ0dvzFPYpdG4rvlVAMONzcPoTz3K6BDbpWj69OcCjTTbAQy4pFXv8iiuux8Sg6YHqHmix6pP4zNjhqgV3AulBN7WZIRscTQT+IVcOLdkdsFbTLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735888879; c=relaxed/simple;
	bh=/NmonZhyt7UVVnL8+8kkFlyh3f/SgH6LULJdQvWrieA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BbT9eaivLsCHFOUS4k4JadC+z7oxsuwNZLMByAAyY9jsTow8GGko6WmEWNN9fliqkhteBpe+/8vB003QSmOcMn67TjJ3sEPT6e+kl8OZMOiBN2+TgXt6codECau4zkEebwBPHyOfN0e1+5A+IsiUexsdQ53alpSsj4wYYgpf0Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXrp7FRZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f4409fc8fdso14223119a91.1;
        Thu, 02 Jan 2025 23:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735888877; x=1736493677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+KaalP+04lAEk1y2vF3gclhFqz2aflk9l3bmJgO7Bs=;
        b=aXrp7FRZ3+zng2fKMow9STvjjiC/G+MO7PVRL+CoDW802MV+gXI64l6YKyIHt+DIkZ
         el34ISwVlCwLQpy/yWGscLy7oxqsfLUuBFg4RHAC0N3tt8zuEQWV+S7h/pYYWdtfIIye
         ywzDpWRgePncJjdGHVKfr1Ou5TEMoka1hcaaRwR5lII8sy0PuEbq7izs3MGgSUv0L5QN
         vHCaEFiqr9ZvST7HHVzBrS3g/zZJIRriJvjkZfGrauwm6UgMcaeP3RXtpZ2ByfI+9ZZy
         jpO+vFOCGHX/Hwr1ZUflHpXxpJwAGTARBD2tcI6bsRgeyrN/eCL26s5PFztdGA+yur1j
         Wkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735888877; x=1736493677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+KaalP+04lAEk1y2vF3gclhFqz2aflk9l3bmJgO7Bs=;
        b=PgzyPWgfxi2PBxtnHtiK6wX+SX8CoM7lbhHYrlPHqoJj/p+Gw4lRucnT5zjie4JDYN
         1cws1brDSCLJkuoEnKKqJZk+C9pUYw42cfUUyNl3QJEHKDEpzMD0LgU4SEI0xcHhWxFw
         wGg94ZLFqkqVH/zgXepouRQsXGetjfcgo7Gmir1y2a9JRx61kMVUFzBboNiqr5sx1fzM
         Eivmbb4ZyfdlSENX+ndbES67USJEi1QbnccdxNGouaeZAu+eiPDZt1rU4UFceK4arWop
         HLFObZEDM6U8v3damw+1rMrfzFAYvStubbNOXFMx0gBr98Zi5ZcbS8rBNcflon6uD9L6
         Pv1g==
X-Forwarded-Encrypted: i=1; AJvYcCU4Gi1c3rowOfEsyo9ayA2sGs5d63TOuIHJ1JjMRXIc3g1lMxkWvSDxJYz5mH53YTYRAYQZ09aoZ7jl@vger.kernel.org, AJvYcCUH3RJ1KAE3t0RCB98QCevGCFNtzk7roK7JgrNGe9ZUwND9freDq8dmsq6zbXpvljzftlqYYOvgpIE=@vger.kernel.org, AJvYcCUfvNqNeHQtzXG/2qn1b+Uvp0gC8E6ePtOHvfmnMayFMlLWKL4qwtHDvEEBljHBRGp+ZDESh5ZLYGgp0jIMeg==@vger.kernel.org, AJvYcCVW3rVGEq1xzX4D0zR6AG3V0STbXaySD0FgnLAukyJW38V9nMk5S/1Zpuhhp59/EKgIA/jIvClkHBXIumuvhEyx7UG9tg==@vger.kernel.org, AJvYcCVsv1GTC7cjw1vJmzEbWd2BK1ERJjHOY3fkpfAZfgU7QUfqozYD2Pfzqzu7wKwORFnrEps+mf198oYh@vger.kernel.org, AJvYcCWm4sn9wEuBdY1Zz+zqNEipm4O1VkQNT+1F9p7SQjY6sqtxuvZNuacbx4vhfbP8n8p7rivAkKZ4EZuw/ByO@vger.kernel.org
X-Gm-Message-State: AOJu0YzTA+ebHTAl9+LN+DL1OVhdR6XLgJzBc7/K2Y951ommPkbZrlXE
	5qeNdvuLBu6eSyVY9JWjKwSbK7ZL1fcDGf9fsyyFLC8DNHxdxSjA
X-Gm-Gg: ASbGnct59gyopmYRT/nHbBF8+Vth0q2+wQ1OXupUO1X1vaDbeDSPQho37VKvG42lP0d
	BhnGt4pXqVTUp8Ichpnmzq7pMbUCfGbJUF1R/NTo/Ad2gNtFkStR5O0hWNOPTuhsnlFJz9cHGLz
	ta+n0yo2XS1Hspjd5jeuF02E8dyigIqkS4udjdcNQzGJdJkC2+J5iUysD+g9Xp1UdGMMLcH3B1h
	KACtcILU+x4hGyCk8Ij1QmkydAhWOuI0B+oE2qkWS5iPThnLK42Dck=
X-Google-Smtp-Source: AGHT+IHN7UyNPHpNz34kofvC3GSyrLGzQQf861IVEqMXrcuN8G3Q5hI0XBf/hCJBFI4nYQoJXVrjoQ==
X-Received: by 2002:a17:90b:548c:b0:2ef:e063:b3f8 with SMTP id 98e67ed59e1d1-2f4435abac6mr86849666a91.7.1735888876862;
        Thu, 02 Jan 2025 23:21:16 -0800 (PST)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc971800sm238382575ad.66.2025.01.02.23.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 23:21:16 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: dmitry.baryshkov@linaro.org
Cc: andersson@kernel.org,
	bryan.odonoghue@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mitltlatltl@gmail.com,
	nikita@trvn.ru,
	platform-driver-x86@vger.kernel.org,
	quic_aiquny@quicinc.com,
	robh@kernel.org,
	sre@kernel.org
Subject: Re: [PATCH 2/5] platform: arm64: add Huawei Matebook E Go (sc8280xp) EC driver
Date: Fri,  3 Jan 2025 15:19:57 +0800
Message-ID: <20250103071957.7902-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <uqr2hibbl4krkseeal6shmcifctrppimk4tr3y4i64luqpslsq@q3mz2ppencwl>
References: <uqr2hibbl4krkseeal6shmcifctrppimk4tr3y4i64luqpslsq@q3mz2ppencwl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Jan 3, 2025 at 1:38 PM Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> On Tue, Dec 31, 2024 at 03:44:36PM +0800, Pengyu Luo wrote:
> > On Tue, Dec 31, 2024 at 1:00 PM Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
> > > On 12/30/2024 6:44 PM, Pengyu Luo wrote:
> > > > On Mon, Dec 30, 2024 at 5:04 PM Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
> > > >> On 12/28/2024 1:13 AM, Pengyu Luo wrote:
> > > [...]
> > > >>> +     i2c_transfer(client->adapter, msgs, 2);
> > > >>
> > > >> ARRAY_SIZE(msgs) is suggested instead of pure 2.
> > > >>
> > > >
> > > > Agree
> > > >
> > > >>> +     usleep_range(2000, 2500);
> > > >>
> > > >> Why is a sleep needed here? Is this information specified in any datasheet?
> > > >>
> > > >
> > > > Have a break between 2 transaction. This sleep happens in acpi code, also
> > > > inside a critical region. I rearranged it.
> > > >
> > > > Local7 = Acquire (\_SB.IC16.MUEC, 0x03E8)
> > > > ...
> > > > write ops
> > > > ...
> > > > Sleep (0x02)
> > > > ...
> > > > read ops
> > > > ...
> > > > Release (\_SB.IC16.MUEC)
> > >
> > > Could you please share the exact code snippet that is being referenced?
> > > I'm a bit confused because it doesn't seem to align with the current
> > > logic, which doesn't have read operations within the same mutex lock. I
> > > also want to understand the background and necessity of the sleep function.
> > >
> >
> > I mentioned I rearranged it to optimize it. In a EC transaction,
> > write sleep read => write read sleep, in this way, we sleep once a
> > transaction.
>
> Sleeping between write and read is logical: it provides EC some time to
> respond. Sleeping after read is complete doesn't seem to have any
> reason.
>

OK, if you are interested, I explain this in details

First, EC transaction in acpi on this device is doing like
======== this transaction =========
lock
...
write
...
sleep
...
read
...
release
======== this transaction =========

When there are intensive transactions, another sleep is added in

======== this transaction =========
...
======== this transaction =========
...
sleep
...
======== next transaction =========
...
======== next transaction =========

Can we eliminate this? I am not sure, I have not tested it.

Generally, the code in acpi is terrible, it can just do the jobs, so I did
some changes and tested.

The process(reading after writing) and data structure(cmd, count, data...)
are very similar to I2C_FUNC_SMBUS_BLOCK_PROC_CALL(see [1]), see also ACPI
Specification 13.3.7. (It like this in acpi, BUFF = VREG = BUFF)

So I tried to send two messages in one shot without a break. Why not using
a smbus API? Qualcomm I2C driver in kernel does not support it
(Fall back to i2c_smbus_xfer_emulated).

Why not using a I2C Block Read/Write API?
One transaction with this api would send 3 messages, and return the wrong
status in return buffer.

Write:
i2c_smbus_write_i2c_block_data(mcmd, ilen+2, {scmd, ilen, ibuf})

i2c_msg = {
	.len = ilen + 3,
	.buf = {mcmd, scmd, ilen, ibuf}
}

Read:
i2c_smbus_read_i2c_block_data(mcmd, olen)

i2c_msg[0] = {
	.len = 1,
	.buf = {mcmd},
};
i2c_msg[1] = {
	.flags = I2C_M_RD,
	.len = olen,
	.buf = {}, /* the first byte return is wrong */
};

Best wishes,
Pengyu

