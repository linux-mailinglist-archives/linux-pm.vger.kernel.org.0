Return-Path: <linux-pm+bounces-42482-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIRCO/ECjGnIegAAu9opvQ
	(envelope-from <linux-pm+bounces-42482-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 05:17:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 581B012123C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 05:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B54963006B76
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 04:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2023451A9;
	Wed, 11 Feb 2026 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="LxmY+naO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A293161BE
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783469; cv=none; b=GF8UD0KakOKJIUgAEW4AKN60974sbLNxAiZMz/QvSdFKKV0LkxG7eS3fMmq1aPrgk+fPoxJQqR5aqPjsfSdhEF4lM19VHt7ZT+Sk34Ob4mFM7zlvuBW5hKhD1asxHobSrCVTOuX2VcK3XUc122KUx4yh5h1LKJ8/kxSt5B/Q/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783469; c=relaxed/simple;
	bh=PuQCat+yNbRiDGeWvgI2+IxsXXUEUakR8EKgqsPeSoI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZrrj97wkqXcgsoO8CZx7K3uNQTa2osTBVnKmfqQoPTIYDA01FtrTIVXkVTjNetjvXlZG5sBWophuF2vKr/4E2K9YBz4BdcVsUSjGsp9Eozr3IwRPiHTth4lAbuALmnR1+SmPCoao0dTBMv77QstiCGNoXZogR2QS7+TK4Vofyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=LxmY+naO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a90055b9e9so26877325ad.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 20:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1770783468; x=1771388268; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PuQCat+yNbRiDGeWvgI2+IxsXXUEUakR8EKgqsPeSoI=;
        b=LxmY+naODDsqe3gZkoy6WgalBWdrLtIBKctoXdB5brqatA333/y/v/kSoSV2fSqTCN
         MGRE1in2TtYct37VelpaGGbq6tzL5/SVTRzKZvIsREOu033soq6HvyCS4r2Uwu/RpgLV
         S4Uquu8E8huXXoI0ZO5aoUaFTR0aqqRe7EpqoLZrcGc440u6WGDcahp2HZ/gp19M44mo
         ccl2WcsKeT2WoEmBj+MtdNub7tz+0QvYOi1FvzGNE14xK936TBX5roJ8VtKVkkbb8xfB
         sSDOBdXI150g8Xxh5SI73zfBPJSqB3TCoMTgsRq5TOgPmjgH6j6Iiszo3/O0Fci1P0S/
         a0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770783468; x=1771388268;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuQCat+yNbRiDGeWvgI2+IxsXXUEUakR8EKgqsPeSoI=;
        b=GIUH+88liRlcgoUs4sZah0OR3+M6yvCw00MkS+Gls3xg//eQGgFadih6KO2Z2YgLRp
         peEAz0tZ3b79za4h4eMC+3r/nHxpIl7dxPyXBK8q885SCpupEuoUdL7/YxAH7eSoGlLN
         +B3pKEF+ozIm6XmKdVxFeouJAdgRXJTVwaII0gdSoIk73qEEmskJWDVtKfw1sVLo8OfX
         oGd0qxa00i9ukLMEsxJLGg6jQrRVC3QltQrWgajAFWBQcnuchALoSFvbxWw+80mtL5Uc
         gCbxSoOGsWFmwEvO3RrcdsKTCa+gGeQvZ9K3TAgsVGR6xws7MSbRSAt6dL8AQUcDaZg1
         CkdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5IhDPm4TOLY1Ebo0y8W56Flym9LjwQilAN3YQjqF+Ycb4tOe7ZUuuuajJDQKElWsqCgKRDMa9Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3J6h/2iyPhtAPKHoG/1NpzMTZWrJ7F0nFNZyP5H/s7mmRgDTh
	5VMdY+gebugWoaXkAYBUKGWwp3eBvf/8wgX8q2yXVi01GIVLtZv8yjyABQ3BhLeNjdc=
X-Gm-Gg: AZuq6aJ9PwAnG7dyLReiWC3nxvDwDlvy3K0mHAdI0q3EjkyyXalkFphcxNL+eRmmRoY
	vT1tFIBRe8wx4aBS0w01T309GjOyV53KCP//tVwRJGwx7arz8d0Na2wU+Y7WmuPliYllTGs92OC
	XQbQIVdad7qU5i0d0DlbWG2hvdSz4xIFLGK1kiiRJWCbGYo1hIB/Fp9fX9jHGQsJ78JW7tgwieb
	iY6HAET8W7oMBiiaLflzOjRhMmjHmpIHN3MWSh5LqofN4HEtal5DVhORkp5yc3IB7stYUbZcqSu
	BPeNpXWEVxL7gRudFkDcM1zsdl5Ip2Yf9O99LFfDdW+V48HuiTYMnnumrJto02rfMe6/OuzCV2v
	BR+U9tHjl1B7GNr11iwkqYV9Bcq2vxSlMGPfoJDuEEOHDXAzN1BFXhjDVwZE26uKhthgM3o4+QN
	0GbBBsj7YDNtyPGjsBTTBTjWO6UvoR2GroDZtwak64jWeqW+HATFgrrlW8EmVGW+Ndy+s=
X-Received: by 2002:a17:902:ce82:b0:297:cf96:45bd with SMTP id d9443c01a7336-2ab29cb9cb4mr9608735ad.19.1770783467792;
        Tue, 10 Feb 2026 20:17:47 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2986edecsm6410425ad.22.2026.02.10.20.17.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2026 20:17:47 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Sergey Senozhatsky'" <senozhatsky@chromium.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Xueqin Luo'" <luoxueqin@kylinos.cn>,
	<christian.loehle@arm.com>,
	<daniel.lezcano@linaro.org>,
	<gregkh@linuxfoundation.org>,
	<harshvardhan.j.jha@oracle.com>,
	<linux-pm@vger.kernel.org>,
	<sashal@kernel.org>,
	<stable@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <006601dc965c$afe30280$0fa90780$@telus.net> <20260210093321.71876-1-luoxueqin@kylinos.cn> <67clm4sqv5cbqxjhjoyn4eodwocc2jm6piwky6cyv4zncfrp7p@izdkjc5db37j> <CAJZ5v0gxNdQG8O32PrBcSa3GGvQCYObrquuiUXyJ8kgPV=91Sg@mail.gmail.com> <ba2bwuhcua2zakojk2wcksyxol76o7lmmceaunls4436gqh4ry@ys3mpganxhwy>
In-Reply-To: <ba2bwuhcua2zakojk2wcksyxol76o7lmmceaunls4436gqh4ry@ys3mpganxhwy>
Subject: RE: Performance regressions introduced via Revert "cpuidle: menu: Avoid discarding useful information" on 5.15 LTS
Date: Tue, 10 Feb 2026 20:17:50 -0800
Message-ID: <001b01dc9b0d$62e27280$28a75780$@telus.net>
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
Thread-Index: AQHR7wO/JX5ylMBngEY9dRbzh1sTOQJs4mJRAbvJU1kA/AGrfADxq7xetWGIViA=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[telus.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[telus.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[telus.net:+];
	TAGGED_FROM(0.00)[bounces-42482-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsmythies@telus.net,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 581B012123C
X-Rspamd-Action: no action

On 2026.02.10 17:34 Sergey Senozhatsky wrote:
> On (26/02/10 15:24), Rafael J. Wysocki wrote:
>> On Tue, Feb 10, 2026 at 11:04=E2=80=AFAM Sergey Senozhatsky wrote:
>>> On (26/02/10 17:33), Xueqin Luo wrote:
>>>>
>>>> In addition to the cpuidle statistics, measured system idle power =
is
>>>> about 2W higher when this commit is applied.
>>>>
>>>
>>> We also noticed shorted battery life on some of the affected =
laptops.
>>=20
>> Was the difference significant?
>
> I think I saw up to "5.16% regression in perf.minutes_battery_life"

Note: I get a fair bit of noise on my idle tests of recent.

For what it's worth: On my test computer I got:

kernel 6.19-rc8 and with reapply.

Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 CPUs.

CPU frequency scaling driver: intel_pstate.
CPU frequency scaling governor: powersave.
HWP: enabled.
idle governor menu.

Git Branch "doug"

3856f38e5bb9 (HEAD -> doug) Reapply "cpuidle: menu: Avoid discarding =
useful information"
18f7fcd5e69a (tag: v6.19-rc8) Linux 6.19-rc8

Processor Package Power:

average reapply: 140 minutes: 1.783028571
average rc8: 512 minutes: 1.656212891
7.65% more power



