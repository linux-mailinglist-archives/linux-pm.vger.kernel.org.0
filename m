Return-Path: <linux-pm+bounces-14528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F8997DE9B
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2024 21:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7E628158A
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2024 19:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA3633080;
	Sat, 21 Sep 2024 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="YKYczCBn"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A532207A;
	Sat, 21 Sep 2024 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726947924; cv=none; b=gMFF4yCUfSmj69zo1DPWagT7GdyYwnJrwq58wAZtywtfimDrhjP3+M8adjr4FSaQ82btxt/7tFA5ZliTNA9iEzNjiGoB6h9RwrE2UvPqpVXG7BcyikkreMYvzG8YnyIIL6p61ndJJgp6Jk98gPi+x2KNHDo9GZG/f7NM6MN7B3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726947924; c=relaxed/simple;
	bh=vcqOfZ1cldAxTPI8iONwxEBLQwvIPgcY8TBUrJvwYNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkpF+lYHUWu6D+AdnO9F6isShKQzCOtzilkKA6Oia1MqcPHG6mARxo3PytXHzUfSNh5kUvNiIUYm7zV5m6Iu+0/1bb60/dtRoplAmRaa7941sLMEYqH2cnIUptiVIz0hMeReZivnmPccdxQcRz1ZAZTxogpo1vtzWyQrovK2Tg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=YKYczCBn; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 01A1F2E09882;
	Sat, 21 Sep 2024 22:45:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1726947916;
	bh=vcqOfZ1cldAxTPI8iONwxEBLQwvIPgcY8TBUrJvwYNM=;
	h=Received:From:Subject:To;
	b=YKYczCBnrepIYEk9jNpzExJCsTIodY68nuOo9sxgLZCVkkCTW/RrnDfN8wavIBhaD
	 +X9tAnj6z7d2H9DmS7sSZttl6d8b/lUdyCBpK2uJjVHpaCiIQQjkU7LzavcRh/VTa3
	 IIZwQFwfnN/WBZVMg/1WqrxB9UFbL3YA8dQqgwu0=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-2f759688444so25299131fa.1;
        Sat, 21 Sep 2024 12:45:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCV6sVj6q4p2vfVPjb2iyrN9fIX7Z75hSBeI0uVA13CyKYKmbK+0ujVHsN6iESHb/uZS93r8HJZo/g==@vger.kernel.org,
 AJvYcCVRMZ028aUhkOiYIgZYBHcvJuaZn3Bo7B3AlfxMHf2lNrYK6u5+TQizG7aJAvZnl2P3s7E70ryAiGOuKw/ZYmVQ63YDlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBOOnloLJkq3PRMiT8LX88ysJrkyB5/IFaMNWUdcmKUDvNYOCB
	cKn+Pz5aNaqcwoD2VBcUSGo53c7LsqEHssocJl2r+bDjLhsg4tvQci1e1rK1IKmK+hn41M8z8ns
	nERNXNQbvyTMFc4TR1viOlLMRitw=
X-Google-Smtp-Source: 
 AGHT+IEQe7zRrSnFiFpkrmlfSvVyKALPTVvWjFrEVXlyeMujOeIjF0DSZxEctkwM84SeE26J1TIMrwjqK0uceWQ14pA=
X-Received: by 2002:a2e:83c4:0:b0:2ec:637a:c212 with SMTP id
 38308e7fff4ca-2f7cb348cd7mr30980651fa.39.1726947910453; Sat, 21 Sep 2024
 12:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919171952.403745-1-lkml@antheas.dev>
 <20240919171952.403745-4-lkml@antheas.dev>
 <7c604018-59a3-4b70-83d1-06f0ed858b73@amd.com>
 <CAGwozwGSVAExH_9zCCKreC88J0FRU4ZM3RkBk==HvRwCUuuqLw@mail.gmail.com>
 <25b14b4f-96b7-453c-b876-6a46c4f3789c@amd.com>
 <CAGwozwHmd8yHzjbutOd4T39h5CZRh2rOWYH4V4AnLN+RXrRRnQ@mail.gmail.com>
 <f164e172-0030-48d0-9c33-aaaa6d0cc6ff@gmail.com>
 <CAGwozwGNg8XZcY0AhfMfKXJo4P4Xmvn7e2Bt2gZ-emSAsn24qA@mail.gmail.com>
 <31eb2289-633d-47d8-8609-e9994d7f8353@gmail.com>
In-Reply-To: <31eb2289-633d-47d8-8609-e9994d7f8353@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 21 Sep 2024 21:44:58 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHDW_m7gx8Fb-CQUz_TtSA=G7hx37NCqntm-hYKhRf8WA@mail.gmail.com>
Message-ID: 
 <CAGwozwHDW_m7gx8Fb-CQUz_TtSA=G7hx37NCqntm-hYKhRf8WA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] acpi/x86: s2idle: call screen on and off as part
 of callbacks
To: Denis Benato <benato.denis96@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, luke@ljones.dev, me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172694791641.13648.6367072771866107030@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Denis,

> Beside, as for necessary kernel/software quirks, the new firmware is
> expected to require none, at least for asus-wmi, so I ask you to leave
> csee calls where they are now as in the future those will be used only
> on non-updated firmware.

I'm happy you said that, as it means this patch will not conflict with
the new firmware and will just fix older devices.

The only change my patch does on the Ally specifically is pull CSEE
earlier and remove the extra call. There is nothing in this patch to
explain what you are experiencing. There are a lot of causes I could
point my finger to, but there is no point.

We will conduct our own testing, and this will include the original
Ally as well. A lot of them actually, and after initial testing this
will include thousands of devices, as we plan to fully dogfood this
patch.

I was a bit busy today, so I did not update the patch. I want to
rewrite part of the cover letter, as it includes some inconsistencies,
and rename some variables. The inconsistencies have to do with how I
describe the sleep stage, as I read up on some additional
documentation, it is not related to the contents of the patch. In
addition, it seems those sleep _DSMs cause problems on the Ally too,
related to TDP. And no, I will not wait half a year for a BIOS update
to fix those.

I am also looking into how to integrate Modern Standby into the
kernel, in a more full featured way. Downloading games in the
background is a very requested feature after all, and since looking
into the Ally's _DSM entries, it seems like it is built to support it.
Background here would mean the fan will be off and the suspend light
will be pulsing, so you can safely stow it in a bag while it is
downloading games. However, this is conjecture until the patch for
that is built and tested.

Antheas

