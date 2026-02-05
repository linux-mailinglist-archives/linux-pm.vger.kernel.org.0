Return-Path: <linux-pm+bounces-42111-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ii/DCLog2n+vQMAu9opvQ
	(envelope-from <linux-pm+bounces-42111-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 01:45:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 640BDED7AF
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 01:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D6A33013A4D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 00:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FE313957E;
	Thu,  5 Feb 2026 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="KKAL3hSd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96F713790B
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770252317; cv=none; b=k/nOlQ0YKOI+icNDLfFyfDOE5GJGQLnASK1ylUfThscyo/VroZt+nvxmdQmwbB090pwhxq+Z5zcbWup8Vq4TnVemX9NdDYvJ2FKRer2Z/wEeOlIaGQXUsPe4VmuUgPlP3W/h/5SEauKpvDjcMCDDdw6SsqQd8n1+rCtgEArkEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770252317; c=relaxed/simple;
	bh=cQ/WPxDukKKYwR+3W0GcZJqJXzQDFdAYPmqOo64qgxQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=f00TvQGWEgofOuhKCaTPQkfAbv4QkD/wDE2AV9D9OvD31rXdhBfswHdGLf2HAfrB3vZgo8zkAeADd0fiFs3/dMUcz4fDRrULF3qDde4WCpAvJyMk8WaqypLVdSwQAAN5ROgXP2yOHOKpt/mh/1uPL7v0ru0rKY6Ud2Um30m8PLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=KKAL3hSd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81df6a302b1so468463b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 16:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1770252317; x=1770857117; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=USq1SkpNeqX2htOZXLF0dfWcb51OlHBhdVgjyNb/L6Q=;
        b=KKAL3hSdijxeGoHIzOuR7QXMkbPiMT7tu3TAEbfwLrhPcCSx8Lk1u9863bWTbXgKn8
         oThFL0HKsLkAnvR+4QQNS8eKZlpZdELrIf3g5eDQAPyZsWGj1dQ9L3IUbMzjeHTo9xuW
         z3gf3AkZoB2Xe/IEEqWjmGUAix8xDstmITqL54ZSEK2rPwad4NT+QuwJTa1wcFcV8Pbp
         QhexagWHnMuFoDFIHKggLUcqQknzV0h91OoSvn3aUbF7ufinMTPAuvTqalgRdpLKbc1q
         0jaP0QOupcUqEKUHYP+fvfILADlFadY71uOnCVrjEOc0tLo4D9sdhiFq9i1hKq60YwpR
         w7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770252317; x=1770857117;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USq1SkpNeqX2htOZXLF0dfWcb51OlHBhdVgjyNb/L6Q=;
        b=ntk6k6xmhZUtEK871bsDnQrkPb6qJ40bybvVb5KjYzRdol3RP+tqnC2pnuTpL/lgyZ
         E58BP5R+lumga8VVU7ZwshFbSM4QECGb1Fy8MYtgFnaMqreLDVTxyUsjS8E3UEdK5uS9
         oBCjEcv28rCW8l0URyBE1tjda1zch+ydpSJWojkLgj54UzEbNiHuOxB9/YjKJE1BrzsR
         a3kr2blu3R3GFXBDSk0o9JY5cphS4gzEWOwW7GCyDLuj1lGo9hjKlrc68vIUtR85WY2M
         Hxu3VFH0bHwGwEAwF0hW0IV4NTE74rK/cu4c+CPUAjC/f8pu6GD70wV2wJzzDgQjjKz2
         Cd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTsca7+TwJDDRrDASszVCoe3E8TwIVJyadJvuw2WhXcJniuNLfipeNqjvKElkkcXUDFNXJCcz7Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2egsKmQNao9FWXoATzBZqxPmdUH5QMsotP+WMMFmEgHOXL1m
	a1/psBVIEeJ+UxnUL5s/gvfVlhEDrwuCxHjP4oSR3OH4OCyHbW77A1KndsT5Y0b0Wuo=
X-Gm-Gg: AZuq6aKPSAybJZVYv/Ne/xovhMdOfvCcB5ldRkOWsWfHKh+5lbX8nfRh05wnaYeUkb1
	J2bzctsYgk6ZEtF3sczuiM6qctqGzKrWKmFAOehJk9dXkyRkt31P7IrjEgO0MjrgPapdugbU7Z9
	6BGXx8Mg1FXigQSDiTGMXTOT098KuBjwZsj0fKnixKjjAhY/9myzluQroOUtqaxbtBOeULJQrGD
	30SJ1fmTt2Fg9bibZl/Wc7fodLA2vpU7rqAqjyo7jyKItcwRAkwgAeNMhAab92onhXwf2yODWAb
	vdAByW3kXAtOS8H08edSCX4mEU+tpNTRH0odN6/nx56R8druGuNJRMIjJnISPD0GLm3RKNK3+8H
	lG0HmWhL3vvLH7pUzxqu4sUV+Pwfmj5wyEvDNh4GDnkSB/MOwQ26jWsn/HUMdFLbYsYoSYs9zeU
	L2tmnbM8G4teDYDklKLOd26gdS5XFo0LeDZeIGU6+CdXqsnm2h2lUiP9ZwPwUDD4bwlw==
X-Received: by 2002:a05:6a00:390b:b0:81f:9b09:ad02 with SMTP id d2e1a72fcca58-8241c1b3c10mr4484858b3a.1.1770252317023;
        Wed, 04 Feb 2026 16:45:17 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d1cc84asm3772957b3a.23.2026.02.04.16.45.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 16:45:16 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Harshvardhan Jha'" <harshvardhan.j.jha@oracle.com>,
	"'Sergey Senozhatsky'" <senozhatsky@chromium.org>
Cc: "'Sasha Levin'" <sashal@kernel.org>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	<linux-pm@vger.kernel.org>,
	<stable@vger.kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com> <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com> <005401dc64a4$75f1d770$61d58650$@telus.net> <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com> <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com> <849ee0ff-e15b-4b69-84de-6503e3b3168d@oracle.com> <003e01dc9013$e3bc5060$ab34f120$@telus.net> <004e01dc90b1$4b28f9e0$e17aeda0$@telus.net> <002601dc916e$6acbe650$4063b2f0$@telus.net> <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com> <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com> <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com> <8fd5a9d4-e555-4db1-aa02-8fe5b8a2962c@arm.com> <3395ad0b-425e-40f5-844c-627cff471353@oracle.com> <3f0cfac2-b753-413c-9a7e-0892c23cdbf4@arm.com> <CAJZ5v0j+jfTHog+rVO0816mofk7nSSKCt7dbwSa2QCpYSN013Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+jfTHog+rVO0816mofk7nSSKCt7dbwSa2QCpYSN013Q@mail.gmail.com>
Subject: RE: Performance regressions introduced via Revert "cpuidle: menu: Avoid discarding useful information" on 5.15 LTS
Date: Wed, 4 Feb 2026 16:45:18 -0800
Message-ID: <005401dc9638$b3e2ea40$1ba8bec0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHo/NwLGJZTeO77XmxNlnPhSwOGkAKJCFtJAex1orYBu9KCwgGuBEkcAe/o8FIB5x3ejgFHdCyGAj6zVaYCBiXTGgCgaPhQAgSxF3QCdRKf4wD6zBBnAsuKJa4A5XOx7rSCKx/Q
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[telus.net,none];
	R_DKIM_ALLOW(-0.20)[telus.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[telus.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42111-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsmythies@telus.net,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:email,arm.com:email,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 640BDED7AF
X-Rspamd-Action: no action

On 2026.02.03 08:46 Rafael J. Wysocki wrote:

-----Original Message-----
From: Rafael J. Wysocki <rafael@kernel.org>=20
Sent: February 3, 2026 8:46 AM
To: Christian Loehle <christian.loehle@arm.com>
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>; Rafael J. Wysocki =
<rafael@kernel.org>; Doug Smythies <dsmythies@telus.net>; Sasha Levin =
<sashal@kernel.org>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; =
linux-pm@vger.kernel.org; stable@vger.kernel.org; Daniel Lezcano =
<daniel.lezcano@linaro.org>; Sergey Senozhatsky =
<senozhatsky@chromium.org>
Subject: Re: Performance regressions introduced via Revert "cpuidle: =
menu: Avoid discarding useful information" on 5.15 LTS

> On Tue, Feb 3, 2026 at 10:31=E2=80=AFAM Christian Loehle wrote:
>> On 2/3/26 09:16, Harshvardhan Jha wrote:
>>> On 03/02/26 2:37 PM, Christian Loehle wrote:
>>>> On 2/2/26 17:31, Harshvardhan Jha wrote:
>
> [cut]
>
>>>> FWIW Jasper Lake seems to be supported from 5.6 on, see
>>>> b2d32af0bff4 ("x86/cpu: Add Jasper Lake to Intel family")
>>>
>>> Oh I see, but shouldn't avoiding regressions on established =
platforms be
>>> a priority over further optimizing for specific newer platforms like
>>> Jasper Lake?
>>>
>> Well avoiding regressions on established platforms is what lead to
>> 10fad4012234 Revert "cpuidle: menu: Avoid discarding useful =
information"
>> being applied and backported.
>> The expectation for stable is that we avoid regressions and =
potentially
>> miss out on improvements. If you want the latest greatest performance =
you
>> should probably run a latest greatest kernel.
>> The original
>> 85975daeaa4d cpuidle: menu: Avoid discarding useful information
>> was seen as a fix and overall improvement,
>
> Note, however, that commit 85975daeaa4d carries no Fixes: tag and no
> Cc: stable.  It was picked up into stable kernels for another reason.
>
>> that's why it was backported, but Sergey's regression report =
contradicted that.
>
> Exactly.
>
>> What is "established" and "newer" for a stable kernel is quite =
handwavy
>> IMO but even here Sergey's regression report is a clear data point...
>
> Which wasn't known at the time commit 85975daeaa4d went in.
>
>> Your report is only restoring 5.15 (and others) performance to 5.15
>> upstream-ish levels which is within the expectations of running a =
stable
>> kernel. No doubt it's frustrating either way!
>
> That is a consequence of the time it takes for mainline changes to
> propagate to distributions (Chrome OS in this particular case) at
> which point they get tested on a wider range of systems.  Until that
> happens, it is not really guaranteed that the given change will stay
> in.
>
> In this particular case, restoring commit 85975daeaa4d would cause the
> same problems on the systems adversely affected by it to become
> visible again and I don't think it would be fair to say "Too bad" to
> the users of those systems.  IMV, it cannot be restored without a way
> to at least limit the adverse effect on performance.

I have been going over the old emails and the turbostat data again and =
again
and again.

I still do not understand how to breakdown Sergey's results into its
component contributions. I am certain there is power limit throttling
during the test, but have no idea to much or how little it contributes =
to the
differing results.

I think more work is needed to fully understand Sergey's test results =
from October.
I struggle with the dramatic test results difference of base=3D84.5 and =
revert=3D59.5
as being due to only the idle code changes.

That is why I keep asking for a test to be done with the CPU clock =
frequency limited
such that power limit throttling can not occur. I don't know what limit =
to use, but suggest
2.2 GHZ to start with. Capture turbostat data with the tests. And record =
the test results.
@Sergey: are you willing to do the test?

>
> I have an idea to test, but getting something workable out of it may
> be a challenge, even if it turns out to be a good one.



