Return-Path: <linux-pm+bounces-41056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 493B0D39525
	for <lists+linux-pm@lfdr.de>; Sun, 18 Jan 2026 13:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0530302553E
	for <lists+linux-pm@lfdr.de>; Sun, 18 Jan 2026 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA41632E13B;
	Sun, 18 Jan 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rww7B9HP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5758B32E15F
	for <linux-pm@vger.kernel.org>; Sun, 18 Jan 2026 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768740840; cv=none; b=PM3R1nEBqN21PCawZxqaaNPJ70RisLZF+oY7dNzblMB9Iw/eWvDDifap4PVRRmbxAwF3ZRxug5y280XOKjIsCzfP+n7bmbogPYpdgHxL8VQtaLq8XzxQet9W3A0mXib6sIbaJklSmlG76OIH9gbUdEICVjGHL6j9rVvO1KKdFUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768740840; c=relaxed/simple;
	bh=X6VRPWR3+I/is3qO7tMIcC/t18XZn9Gh0EvY+axJ2d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTq15pTXEOTtNAKpkSAD+sUq4M+pHnT6/heNYqADnM1/MTxdI/VWsy1WiUYyTvx4TMUwctMMyh3YbQxjRpnNFoCYWcYHz9JDCKI8yMxS87vIsFJ1BtqSxXgOmj7xL48/00UfYR9O6Yl3vaRLfv7XYHnomNd721RLYadHjXIVeyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rww7B9HP; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-792768a0cd3so30910847b3.1
        for <linux-pm@vger.kernel.org>; Sun, 18 Jan 2026 04:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768740835; x=1769345635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nq0ZedcEuNO+ABzh265FROMeuNw22COMEoNCyWJq1yQ=;
        b=Rww7B9HP4OYWbF/SIfUvzkr9y2uMGDH3+QhbTFQHnCzTMY5ZR+IBFapdt8/A73ZwD2
         LUjjaQHqampYQCp49a5QEAxUjVpDZPgMQGTwDuqT5ujqXilTk46nsBP2QB1It2saQQ0U
         s64SZa/8xb9cq7xlMv8qgVHtt3spO2oawidxrIKVj4BFBPDmKqtEYLlg1DxZRRqxvmLB
         SDIe85jKhpbALEGJWGODF3h0CiTQCukiCsyYCkOBTkAwyUF0KetN36SecPqyfs6wxhWP
         AI3U/8rw8BhjT3CaIOXSR7Z9NTdhyqeRyO5hjG2Z9e2maANwYIvz+wtOUVbGu/Ypju73
         Zh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768740835; x=1769345635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nq0ZedcEuNO+ABzh265FROMeuNw22COMEoNCyWJq1yQ=;
        b=VxvznMShW1pZpBXKDkzEcyWSLb4HjN8+CAM4//fbMZn1c+PZ4ECf6neIP5fWGF4MwK
         C7n8Y++YGZbVns7lKs+GJ6RoPFD5m0rWl2ytsrsPBqjTO4AECbKmNQcaDojU3l3OKVmD
         fQgzQSgDXmv0yzUCwOV84CAUjo4EnmW8xdl/qkZeH34xdj+NS8QovAHUtKiIZRxWYkBi
         IBrluhKYCqnrC/hIVmASrzk2125lOc0X6eajvMtJo/UTeAfNdhEhIH5xryDJZXEsBOEU
         D2dmvCf96W2XPC79aQvznejAGrveoOzg7rOHNHIvRhFSLaUuppoAcnkfGxhen4X7VLfH
         JD0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWu2QN6zuLd1YLOIINbcIifxmYyR3c2UuEV7vpiRznXokcbOcqlukkBwk3O+wVrwbZryyEqvGpyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAiKLayvFQWQ62EJaTRH9GzuiIe5EI4MG4UKHbMrqBDmLOQJad
	7PKTC9v6urEFu8IfgRNABuNBTZAi/nZBzwYJ0UYaq8Ozl/8+GHEI5gyCiIQx0M/LEi7rWA8fY9d
	9x3FelDgzdPau1yIwdMS2jNtE2k9HPwQ=
X-Gm-Gg: AY/fxX6sA/h9dhcS24XEBvLw+1uLAEx0wECcLe+wL+GPQu93PNZJD9wtq/PujqN3bws
	p7O7X3l6XXJUVr+lvPiDiltqYB64J5B2ZVlt0dxlM6meZcVy7XG/dVfRSYdo0sKLOrX8+7BKR92
	ygK6XOSkp9XJmG151nxU8Gpr57rfdyha5ep+0mibUWzSEXZP5MoEzNOhE+Z9NUFJzB29k4AUMnj
	iLG9/gbnybNFxZpekIhhw1G3kycuXMB+V7T8j01libek0IK70yKWiYyTOrJanlh8qdw1iNQnb1y
	NcU7dYNKmVAjs4tRAfmr/dR3EDA2j9ZzTN230tw=
X-Received: by 2002:a05:690c:6:b0:783:7143:d825 with SMTP id
 00721157ae682-793c671d3eamr65122677b3.25.1768740835221; Sun, 18 Jan 2026
 04:53:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-b4-macsmc-power-v3-0-c236e09874be@gmail.com>
 <20260115-b4-macsmc-power-v3-1-c236e09874be@gmail.com> <af3204c0-0492-4555-9a75-3716fa264ecd@kernel.org>
In-Reply-To: <af3204c0-0492-4555-9a75-3716fa264ecd@kernel.org>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Sun, 18 Jan 2026 23:53:44 +1100
X-Gm-Features: AZwV_QgnfqxKHc96qGbQRwH3BPdaA4uu6Z9QA2PDHlHd4joF1Pds45iGW_-m9gU
Message-ID: <CANpmGNvNe-Y7mgMEqKYGvyA-v6pKLc_9NZ8LBLuy7__F+k4oGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] power: supply: Add macsmc-power driver for Apple Silicon
To: Sven Peter <sven@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Hector Martin <marcan@marcan.st>, Lee Jones <lee@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Janne Grunau <j@jannau.net>, Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sven,

Thank you so much for looking into this!

On Fri, Jan 16, 2026 at 8:00=E2=80=AFAM Sven Peter <sven@kernel.org> wrote:
[...]
> > +
> > +static int macsmc_power_event(struct notifier_block *nb, unsigned long=
 event, void *data)
> > +{
> > +     struct macsmc_power *power =3D container_of(nb, struct macsmc_pow=
er, nb);
> > +
> > +     /*
> > +      * SMC Event IDs are reverse-engineered.
>
> Any chance you meant something else here? The event IDs aren't special,
> everything here is reverse-engineered ;)
I was more meaning that they are made by correlating when certain
event IDs appear,
so the comments I've added aren't 100% certain as what Apple intended
for each ID,
(unlike keys where we can be more certain because they report a
physical value).
I guess that wasn't the best choice of words as everything is RE'ed,
as you've said.
In v4 I'll make this clearer, thank you for the pickup.

Best regards,
Michael

