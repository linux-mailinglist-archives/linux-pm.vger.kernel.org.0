Return-Path: <linux-pm+bounces-513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A33C7FDC13
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 16:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF0BB20F7A
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCD439860;
	Wed, 29 Nov 2023 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="EHLykenN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7B1D54
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 07:58:21 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc9b626a96so53570965ad.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 07:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1701273500; x=1701878300; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UfaOOrbpJ7lrOL49Zhqqje49MqZuDPKdRWdRlAyDs3I=;
        b=EHLykenNTJ4PkUX2q8mVPRIyDeF41WJ0W0rwu+kq3uMYt0NFxcq1IeShOeXfyCO0c2
         +r1IvkldVpdO0LFSkQIwiddj3AznS/GqMuaKTQhmcFRnZMSR2E14IknywwXPLfsV+8eI
         MiJk1QpjhCfl8IROpIggAzOch4npGnQYQqjK+C0ge2OO2nJoNBih+r5w59dPqBi0wE/A
         BopUIsB2u31XIavHhUw+bKMjhVuFhurg855nMzoFuBzrzIRs7Ki2CcNFf7qbYoMShbey
         YGEk0fV0PiJXVbCGV8iXbkKjROn2KF2iEdK2PrLRPlIqTHgTDUyHNFR8+ST6iaFmrLxT
         D2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701273500; x=1701878300;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfaOOrbpJ7lrOL49Zhqqje49MqZuDPKdRWdRlAyDs3I=;
        b=PNqahEEzrj+8TEQIxbCfIR0Qmjim7r1LdVswFMCWqn6xACoKWuIMsz3lKTt3V3h+m8
         0bpJn4ctGjkaFTjyJ4bRv3WZdTfgVysPMnYaT0UffOqEwwoZxGZ/MkcO+hIqJkxgLVV2
         lRO8KyD5gMzlIVdm+j+65CFTIQUOgH96p6HoNP0+CorVGZFsMjUwGwob1RxW3SOaJDHW
         mr+9YSpRUqd7SxF220iRVWm9OFW+JDk8pypJygN74gcJSaNMe8BkynUk2G3m4YS27FTW
         x2XLBgegH3+UOgrKDlfSqw+XhtdVI27qp/ySi4z5doNJ2pgq/PvgaC5FOLUKmW+3Pf8W
         qiGA==
X-Gm-Message-State: AOJu0YzmgDsLYT12Xb/E9FcuxPVrTwszrio23e08d70T9JpEWCcycZBL
	A2MvC78I57EVjdGBtWwIXQh26g==
X-Google-Smtp-Source: AGHT+IEKUfx7RYN1QCWBGNy2jZYmiMw5PjdOZmyHn5DRbJh/h/0wYl3A7xX/97gwiFtu+VQrJjxRBQ==
X-Received: by 2002:a17:902:db06:b0:1cf:c376:6d8d with SMTP id m6-20020a170902db0600b001cfc3766d8dmr13097406plx.32.1701273500603;
        Wed, 29 Nov 2023 07:58:20 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id jc11-20020a17090325cb00b001bc6e6069a6sm12423481plb.122.2023.11.29.07.58.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Nov 2023 07:58:20 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Len Brown'" <lenb@kernel.org>
Cc: <linux-pm@vger.kernel.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <00d201d96670$e15ab9d0$a4102d70$@telus.net> <CAJvTdKmv-6rp=z=emS1VGdWgTmRfhSUrmUPLk8Hj+5=CvH0+nw@mail.gmail.com> <CAJvTdKmG2JkJBy4UNc101JZUHzUaC=a=U9Xwg9MgQs7wcDvYrA@mail.gmail.com>
In-Reply-To: <CAJvTdKmG2JkJBy4UNc101JZUHzUaC=a=U9Xwg9MgQs7wcDvYrA@mail.gmail.com>
Subject: RE: [PATCH] tools/power/x86/turbostat: Fix added raw MSR output
Date: Wed, 29 Nov 2023 07:58:21 -0800
Message-ID: <001b01da22dc$e0f764b0$a2e62e10$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJigUPX+JE/C/rArcKUKaY8eOCGfwDAEwE5AhpcgS+vaeDLUA==

Hi Len,

Thank you for having a look at this.

On 2023.11.27 18:44 Len wrote:
> On Mon, Nov 27, 2023 at 9:31=E2=80=AFPM Len Brown <lenb@kernel.org> =
wrote:
>>
>> Hi Doug,
>>
>> I recall puzzling what to do for the system summary row for a RAW =
added MSR.
>> In your example 1-package system with a package-scope MSR your patch
>> does the trick.
>>
>> But if there are N packages, the summary will ignore all but the last
>> one, which it prints.
>>
>> Similarly, if the MSR is core or CPU scope, the system summary =
ignores
>> all but the last one, which is prints.
>>
>> So I concluded that printing nothing, er, zero that is, on the system
>> summary row for a RAW MSR was the least likely to confuse somebody.
>>
>> I'm thinking that the first two hunks of your patch for thread and
>> core don't make sense because of this.
>> I'm thinking that the last hunk, for package, makes sense, but only =
on
>> a single package system?

I played around with it, and simply can not recall why I did the first 2 =
hunks.
The 3rd hunk seems good enough, but I have yet to figure out how
to determine if it is a one package system.

>
> Oh, one more bit...
> "turbostat --cpu cpu-set" can accept "package" as the cpu-set.  This
> will print out one row per package, and will give you the information
> that you really want -- even on a multi-package system.  However, it
> isn't as pretty as the system summary that you printed, because it
> pre-prints the headers (and the system summary) every interval.
>
> It may make more sense to tweak (or simply filter) the output of
> "--cpu package" to produce the output you are looking for....

Thanks for that.
Yes, the format of the information isn't pretty but it is probably
good enough. I use --add MSRs rarely.

... Doug



