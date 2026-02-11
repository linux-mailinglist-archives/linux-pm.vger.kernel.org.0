Return-Path: <linux-pm+bounces-42484-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INsJBUcFjGkeewAAu9opvQ
	(envelope-from <linux-pm+bounces-42484-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 05:27:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 938FC12134B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 05:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 849CD301CDA6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 04:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD566353EF5;
	Wed, 11 Feb 2026 04:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="fXakRn41"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2D1D5CF2
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 04:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770784066; cv=none; b=agff49tdC7Tw54hq9k8UtMF4qgtszuTOmijtx+SdYmOQJfuYkMM6YOIjO6QYPAtPPBOUplonJEq/lJsGRiy7qbLXiYbYXfztPBrCnVYrsYzEaV4RSGZ8uJdpo8IjziulCx+uzkkJwDZZGJP8V2pM/y7EIbaf/IVln6geRfxVmYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770784066; c=relaxed/simple;
	bh=1Oox2N3vRWYyin4SRGWACclv3TTOaPpbMsBdikA6HI4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MukQPyPkC106ZrfEUDGl0Q/4xdnEtTHJD4BzSC1e+FpPgeNMxzPiH7L9lixT0yFBjPXmP78SeOWcni5rEn2nN48Z/K0fH5jaD/GrXqDgRiVIt6V28oetoIfxu5TNl82S11kHe7nVEKK1T7UX7J+QokK9jCiELxtxtdGSgrx679E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=fXakRn41; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-823c56765fdso872073b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 20:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1770784065; x=1771388865; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PeYqAY30/4J7IMO4lbtZzU5S6d2pdo/JpCQlPo26gq8=;
        b=fXakRn41bsgG9mbTtPHhr2s30sxC/Yaw1EfdS1NVsa5xZ93Uh8wl1eK+lgo/GrXRJ2
         FlTyB4Qj1B7w8JBLqUyio34w5NgB9dBzOSTIaFFNUBOK/oossEqfXi34cCzZzjNHWIYu
         6MSiXUQjxf7SJGkU02Sh7OXw0bOy2nu6m9VXEKpcxR+ImRwPtVAJqlXyzRpYLXDClhHz
         Gxh9/WuSmHANZrzI9hzfmFLq2jcFLt5nvMnm7c8CdQ6YqEJ+BoVzwtOsApLwWZljNM0A
         xIkAUkPxVGHeqU7sDHrMZbMqBItZssvbOoRdJd7L4VwkLkAsUNAeqGBSIwAP29oqPAS0
         VSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770784065; x=1771388865;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PeYqAY30/4J7IMO4lbtZzU5S6d2pdo/JpCQlPo26gq8=;
        b=aku0GNXrw5HEETf27lv7kLU5WKFgd/N+EcJ++WqzC3PBSSlRVtMJS5467NbHJlPo0a
         Ic4OvlpWHg+1S21uqJotiPMgDTecz2mQfF4I+W5cSDxXfG2+IhaqRIUUe6m7jX4tSuqn
         DUHuqVw8snce5uZewK97s3mwzNcOgH2zLzyWk2t5cHul8dFAA5piyRKszZO6sn1Al5QB
         9Ub4J1+9tlh3HaPqKYyQtMfauNasqdzQnkKq15+VAHjOQ021cxZVf53XCyKHCO3QuUyV
         GwUoK7Cmht93iskNq5GCSBjfMi8vs7T2Nedmw8bgNk4p+GmhfV560b1RRM0rCzF/zKdy
         8IAA==
X-Forwarded-Encrypted: i=1; AJvYcCXTmQLzFjWvPqcrMfi5BWDsNZyL5krbXfXSvBe9YaDFdn3ZA5Ah3W8dZTBAxYfMDk8+98/Jo8DcFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLz9IPtCfhBNdyQ6lPRJ8soaViNQ1SdfE+sxz9hNYx5rkgaZky
	nSINDRTDzidNJfwLYSWZArgqYleQY519WmtDiCaxKTUJZTNSw7zGTQ84hwuAim0ny2I=
X-Gm-Gg: AZuq6aJrii8WO/DZYUYLOqP/MO7sa8i+J/oin04tOhQvt7+d3rIVORAQ5XQW75Fq9i7
	0vz+20VtGu7DnX/s+mXHftZsIyH8q8UoTlFaarsAGdKn4EBt2hazBcoVFpYZwVF31wA/V7doEHX
	EWXXySkfk3fYk9paTkMZywCoM9w983GzRKgLPhYWDsHZcL8IeKJ/FEfopS0FV/IRUrvCpg8/ZKo
	wKx/bp+3DvVlUVar4KnXX9ZrdiHfDov1DPMjgEfAx0WoZABNwRzvgMw5fRz7B3XGgWYseBO5Jcs
	Ljtb6FscDGwEdnNCwDBygP8rtPlH/7B69glx9FfVWF0gFDCEGOZ0XeQeTmd3Ddsq9Siqjd/gNEU
	+e9LY8kvuX/nkasASETb3S/T/tbN15ezometioqSmdwuG6Ja0TqTey1JDu3NLSyBAXVYsnzVTvW
	6/9lTAo9hpeXbc1RB4CJ8XVW2TNm8/VkkSHg+wFcVxcS6IRFWSlBIRgCcttjsxyZCdqzg+Zjp3v
	CGs4w==
X-Received: by 2002:a05:6a21:e0a7:b0:38d:f6d7:963d with SMTP id adf61e73a8af0-393ad36bbe5mr16564490637.57.1770784065039;
        Tue, 10 Feb 2026 20:27:45 -0800 (PST)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567e9da655sm598657a91.6.2026.02.10.20.27.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2026 20:27:44 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Christian Loehle'" <christian.loehle@arm.com>,
	"'Sergey Senozhatsky'" <senozhatsky@chromium.org>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Harshvardhan Jha'" <harshvardhan.j.jha@oracle.com>,
	"'Sasha Levin'" <sashal@kernel.org>,
	"'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
	<linux-pm@vger.kernel.org>,
	<stable@vger.kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <CAJZ5v0gcSb_6QPMfHkjSMJ6OOF+PaCZrUKOafYQ++tHE2jBB4w@mail.gmail.com> <3b0720d2-9b72-48d0-998a-1fd091cec44f@arm.com> <5d4b624c-f993-49aa-95ab-5f279f7f6599@oracle.com> <8fd5a9d4-e555-4db1-aa02-8fe5b8a2962c@arm.com> <3395ad0b-425e-40f5-844c-627cff471353@oracle.com> <3f0cfac2-b753-413c-9a7e-0892c23cdbf4@arm.com> <CAJZ5v0j+jfTHog+rVO0816mofk7nSSKCt7dbwSa2QCpYSN013Q@mail.gmail.com> <005401dc9638$b3e2ea40$1ba8bec0$@telus.net> <m7pzdjfjcm2gr4gpru3rk26o2wn5iarihff6kz3o7n3slsvonx@k6jkyemuywgk> <29b3287e-0a08-4648-9e54-32889c99b1e3@arm.com> <ioyakugzog4uecwugy4b5ysxdimvh7qtosainou37rwp5bpoks@5csx6sn7ziso> <946c9ff1-a0cf-4faa-aeb9-405f89121b81@arm.com>
In-Reply-To: <946c9ff1-a0cf-4faa-aeb9-405f89121b81@arm.com>
Subject: RE: Performance regressions introduced via Revert "cpuidle: menu: Avoid discarding useful information" on 5.15 LTS
Date: Tue, 10 Feb 2026 20:27:47 -0800
Message-ID: <001f01dc9b0e$c6e89150$54b9b3f0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIGJdMaf/4M855ptbp1U7uUSdSxOwCgaPhQAgSxF3QCdRKf4wD6zBBnAsuKJa4A5XOx7gIlm1O2AkVayRsCE2qbpgFyo9r5Adk03yy0jU4TIA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[telus.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[telus.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[telus.net:+];
	TAGGED_FROM(0.00)[bounces-42484-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsmythies@telus.net,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 938FC12134B
X-Rspamd-Action: no action

On 2026.02.10 00:57 Christian Loehle wrote:
> On 2/10/26 08:02, Sergey Senozhatsky wrote:
>> On (26/02/05 07:15), Christian Loehle wrote:
>> [..]
>>> @Doug given this is on Chromebooks base=84.5 and revert=59.5 doesn't necessarily mean
>>> 29.6% decrease in system performance in a traditional throughput sense.
>>> The "benchmark" might me measuring dropped frames, user input latency or what have you.
>>> Nonetheless @Sergey do feel free to expand.
>> 
>> I'm not on the performance team and I don't define those metrics, so
>> I can't really comment.  But frame drops during Google Docs scrolling,
>> for instance, or typing is a user visible regression, that people tend
>> to notice.
>
> Yeah I guess that was my point already, i.e. it isn't implausible that
> e.g. a frequency reduction from 2.2GHz to 2.0GHz (-10%) might result in
> double the number of dropped frames (= score reduction of 50%).
> Everything just an example but don't be thrown off by the 29.6% reduction in
> score and expect to go looking for -29.6% cpu frequency (like you would expect
> for many purely cpubound benchmarks).

Thanks for the inputs. Agreed.
In my defense, I was just attempting to extract whatever I could from
the very limited data we had.

... Doug



