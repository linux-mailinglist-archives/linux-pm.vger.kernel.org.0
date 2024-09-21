Return-Path: <linux-pm+bounces-14526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB3197DBD4
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2024 08:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8DD2822FF
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2024 06:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98E9145B2C;
	Sat, 21 Sep 2024 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="VZ1sLFp8"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6061654765;
	Sat, 21 Sep 2024 06:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726899785; cv=none; b=QJ+Dvw8GM5SHALT4ttoj4OidaN9W/r99BcmJfuJFtFekHib+R8++y/fKWLUgAVJY5cQNmFZTVE+K6w9AqAtlA23TwEGdiDKpqqLHByq4W92ItjWitIfpbi4lK43NY48mxfh+QOOQw2Ax6I/dZl0C//RcAdQPHaWGh2kjkHgNz7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726899785; c=relaxed/simple;
	bh=dwMa5VCb+tTQROEPicZ4LMddjyZlkgDS7cOZ5orXEpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ey+Ddl5jdrD3dFQaYb+st5mpEQgDOgTWHT22DvbfZhJ9sDJ4nHpMOZ2iWfX1XG+pDFULVwwD+fnh7HgsrD2QeJX9BAjQ06rKsFBWG9ieMLm1/nC19Mlv/o9nQQ/+w4nR/W/ttgdUnVnySRs/pv5YD0ClixYspuczkcWnYJaxYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=VZ1sLFp8; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 7B7152E03751;
	Sat, 21 Sep 2024 09:22:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1726899772;
	bh=dwMa5VCb+tTQROEPicZ4LMddjyZlkgDS7cOZ5orXEpU=;
	h=Received:From:Subject:To;
	b=VZ1sLFp8FQ5N/R5wbk02YchvVWtikW4cZXDlDbvjH+5A3/ovryhefAmfYmaPQfCTD
	 5AYn/E18KMZr2fxHxDUDumHvpBYHPjyw0kWgPhRwjMsZnR81GVLKTgtxW0olghL2VE
	 CZ2zcuv5GVswvOxfVysqX1EsfRkEf1mDVJ0Gn71s=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-2f74e468aa8so30454341fa.1;
        Fri, 20 Sep 2024 23:22:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCURX+OGClae9oc8oQ6V2fT+rMQAbnrjkg8YjYga09jGYTqAOcTotvcDmdcIcw+m1YIoDxjINVvQHA==@vger.kernel.org,
 AJvYcCVbTtOXv11uQDe3Q84y36titQ8UKz07CuBSUPQ2aRMl7hpeN1FLX1mIc9ck63Knu3ur1FOqtX4IIW2aVM3dZGEIZ+r1Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySrSVnPMMNoSRrUlqfOStjkoM2nFgeyivY0doGhjpAnxRVW3LC
	MA0ezVeytsM8SGRKLli+YJCKJKL8XnV8fMxg8WB/PvNLMr5xyaGyzWU2Dkhkg9XVT2GG3gxpA2j
	59Hqpz8+eVArA6SSdpsC/G92pT7g=
X-Google-Smtp-Source: 
 AGHT+IHRr6sqlrBZcTvZxp5Is7HzjoelcXGZe0wGfW2ZMg00uxHQePROvNfRSxk3la3+GDhWBmZ7zus1yjgCQXbi7C8=
X-Received: by 2002:a2e:a986:0:b0:2f7:7f76:992b with SMTP id
 38308e7fff4ca-2f7cc5c4662mr29204841fa.37.1726899771630; Fri, 20 Sep 2024
 23:22:51 -0700 (PDT)
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
In-Reply-To: <f164e172-0030-48d0-9c33-aaaa6d0cc6ff@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 21 Sep 2024 08:22:39 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGNg8XZcY0AhfMfKXJo4P4Xmvn7e2Bt2gZ-emSAsn24qA@mail.gmail.com>
Message-ID: 
 <CAGwozwGNg8XZcY0AhfMfKXJo4P4Xmvn7e2Bt2gZ-emSAsn24qA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] acpi/x86: s2idle: call screen on and off as part
 of callbacks
To: Denis Benato <benato.denis96@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, luke@ljones.dev, me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172689977283.15884.2026268294298249912@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Denis,
thank you for taking the time to test the patch.

First I want to give some context. I have tested variants of this
patch on 6.11rc5 and linux-pm/bleeding-edge on both an Ally X and a
Legion go. I experienced 0 sleep failures on both of them throughout
my whole series of testing, on all variants of the patch. I did not
test 6.11 final. So I hope you did A/B test, as it is not clear from
your email. We have had a lot of issues with new kernels and suspend,
so please make sure to test 6.11 stock.

The ACPI error in the s2idle report for the _DSM is normal, Asus left
a lid sensor call that goes nowhere below the CSEE call that turns off
the MCU.

I am not that well versed in s2idle traces, but from what I am seeing
is that your controller suspends beautifully, but some suspends fail
due to a PCI error? Then you have "[Errno 16] Device or resource busy"
but no accounting of which device that is. All this patch does is move
CSSE to happen outside the suspend sequence, whereas before it was
done *twice* within the suspend sequence,

@Mario what are your thoughts?

The controller is expected to disconnect and reconnect to the device,
we are not trying to avoid that.

We plan to do a lot more thorough testing next week on Bazzite (on all
devices), however our kernel maintainer is feeling under the weather
so it will take a couple more days for that to start.

Also, a small comment on this new firmware. This patch has merit
regardless of what Asus does with the ROG Ally, it is both a feature
and bug fix contribution. I would like to see suspend in Linux become
a lot more modern, as it is a feature we are often asked about. Users
want to be able to download games suspended for example. The Switch
can do it, the Playstation 5 can do it, but uh Linux cannot? It will
not cause regressions regardless of what Asus does, as this is making
Linux mimic Windows more.

Then, to move on to your other concern. Hopefully, you conducted these
tests with a stock firmware. I think you did. Secondly, to me,
requiring a firmware update + kernel quirk + software quirk (as
extreme mode will be MCU version dependent) is something that I do not
find to be a very satisfactory solution. In any case, we are happy to
hold this patch out-of-tree for our users with older firmware and then
tack on whatever else is required for the newer firmware.

I will post an updated version of the patch later today, although it
is functionally identical.

Antheas

