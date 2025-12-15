Return-Path: <linux-pm+bounces-39542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68122CBD6CB
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 11:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8A6430041B4
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 10:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2244B32ED5E;
	Mon, 15 Dec 2025 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKDJmtXz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B203164A1
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765796352; cv=none; b=LCfDMfQxdYMQtGhCMWduwjnYQUYcKVAdMk0sQ5zt1GtVAO/voXruzeBfxyhodpmmAdgoMyf/S11H/LpiYU8mitzBGhasINc4AGxjcugtFtXbRtwAXr+owHjf8ZH7G3Hw0211f/FDO7n27UC0poScQBL6scxtI9p7X/oHZZnuyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765796352; c=relaxed/simple;
	bh=S4rPeEDIZIwVJq/NhrUpwMxIVRW5R+/pHkM/PxZ/krQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ZEvE7z4t6m4feTUjhAi86kp5XGbz2W7ubS56AUvXeYkAwL3RpS5o7Qhmq6vse41GUNQfch23kL2SjvqCP7x5O4MUHKaRhjlGv6RcqDXaxpPMa9eT/S+AJpaWOAySSKNpsCN740zGYHvIin8olQOUlpZIzDPDb5K+mntMwdDpCTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKDJmtXz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47755de027eso23043685e9.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 02:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765796346; x=1766401146; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PFFtPLWt5GXwFQD6gQTfn7/fmcFvMDxSdb3CyQqoRRc=;
        b=FKDJmtXzxHjjewFrwCWimB59IQ5FP1p3qacMevOzfAqhvQCyYAu+tMLYJwPc3Em1QO
         oM3z00GOyNvYTDJnUwp+Qse6Fe9h+GX9xDUVNlXhqouYGRS7oXykI5dAGg6nmPc+jZ1D
         g8+kOdAh2TLd7lM42JbbL3hgsgrMWKIO1L4lEG++Ja0EP4w9GPXfLmjyBHfn+frwsB02
         oOnh5n+c3Beba7C3Jf0DTeU6HQx5HoO0YaIRnNId0eG8N2GsdsjV9lyGV6QK0kX6tn6R
         CS9tk4qHl5VoQoprIXdBshNP6l/ifXu236/P+pffWH288ZmXuFelIgNWZabydS84JJnE
         wgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765796346; x=1766401146;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PFFtPLWt5GXwFQD6gQTfn7/fmcFvMDxSdb3CyQqoRRc=;
        b=ug+KbmADKLhN0S13y69hXZjODCaZfEJdm/ikZvMH5YLWFy5rC8ibtRYn7xcLoQ8IjP
         1CNCLdlJHwS6cEjIIuqDHQvCuuBwsSbrtf23KFydO5i0C52X5hkyUwCZz+yrwnmD3CSQ
         qZVoCvSUSlrzU1xvqFZPHVwqRRrPM2axCj8aSm2ujuRdwuEknfQcY61wnYFHDNMP0Ckv
         eJBP91MOyjVAqWKlJH6pR1LfQdd4FZAahHbyrQc2PkWQDQtoloi8mJO7NxGDyac3Gwvv
         zntjkI4uE1TAWYyKiORSDe0uOcjYFL+JY6w51UuWtfc21Qy/xB71xgSsRqgH6t1xS0vU
         /d6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWt/oLVKreZmF1N+F9rw2jlME0BKwuvweOQvi16zY6xD2YKMb2n0dXTbwsJ4TzVzbnknSFYuS6efg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz96PWO0hJblq+Kbr516ExLmnKJEmL+BC0J4oOxRzZwnlv2gfka
	SWsggfpBNSw0qVsHkhVk+EWfT5SuU4M6YCZwzYfvsejtmhHKZg/9oTUC
X-Gm-Gg: AY/fxX6kGzJu30bpJPeHfVX/WbDUrTaLQ7vLiz27Xe2hfGLPeijjz50UCoa3ZrfT2VA
	23t568c86ezgEteKpJK4FjytrzN4yQFotvCkkQyxhahxKRzc2RLbvt6T4W6T9+Yh9dck+38+Azi
	MMUMDiPOf6Y1k05dnbF1JpYZFVdX8QEFc4n3/rrXHa9lTv7PEtq8JCaeLgz0vXCMOkZt8uqNSaK
	vRxvzWlOsF4faTQ3B/pDk54Q6ZlKjVpECHrxEFhwc56/c+T9sMaue5V/FxXvVnG1MBXBQmxVzXR
	VRSD8noKelpJGdGXvRk//278srR42n+DQnLTDBhhPMQHl2+eZ1GOzico/I2QSJOLf+vtqOHre0w
	mCtQIoSCQq01kL1OSeVp9d41ZAWKZWAH4kSyTXPvK1VOi7MPRUM2oDBzZjLm7DJjtFV9ButTMoM
	Q9o7iBrFFxSyVsKRLci/GK6nY=
X-Google-Smtp-Source: AGHT+IFaWJrWyBE9GIVvce2XyPwUKqAlGkmLp8oPaVrPoTGxqsS9OcEy2fJ4pY8O1VJB9+e56d6ihA==
X-Received: by 2002:a05:600c:8b6d:b0:479:3a87:2093 with SMTP id 5b1f17b1804b1-47a8f914528mr96729885e9.37.1765796346286;
        Mon, 15 Dec 2025 02:59:06 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:c497:8f2f:d889:ca1a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b44csm178004835e9.3.2025.12.15.02.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 02:59:05 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>,  linux-pm@vger.kernel.org,
  sched-ext@lists.linux.dev,  Jakub Kicinski <kuba@kernel.org>,  Network
 Development <netdev@vger.kernel.org>,  Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: Concerns with em.yaml YNL spec
In-Reply-To: <5d3c37c0-d956-410d-83c8-24323d6f2aea@igalia.com>
Date: Mon, 15 Dec 2025 10:51:01 +0000
Message-ID: <m25xa8qaqy.fsf@gmail.com>
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
	<5d3c37c0-d956-410d-83c8-24323d6f2aea@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Changwoo Min <changwoo@igalia.com> writes:

> Hi Donald,
>
> Thanks for the feedback. I rearranged a paragraph in the original email
> for easier reply.
>
> On 12/12/25 00:54, Donald Hunter wrote:
>> Hi,
>>
>> I guess the patch series was never cced to netdev or the YNL
>> maintainers so this is my first opportunity to review it.
>>
>
> You are right. I think I ran get_maintainer.pl only before adding
> em.yaml. That's my bad.
>
>> I just spotted the new em.yaml YNL spec that got merged in
>> bd26631ccdfd ("PM: EM: Add em.yaml and autogen files") as part of [1]
>> because it introduced new yamllint reports:
>> make -C tools/net/ynl/ lint
>> make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
>> yamllint ../../../Documentation/netlink/specs
>> ../../../Documentation/netlink/specs/em.yaml
>>    3:1       warning  missing document start "---"  (document-start)
>>    107:13    error    wrong indentation: expected 10 but found 12  (indentation)
>>
>
> I will fix these lint warnings. Besides fixing those warnings, it would
> be useful to mention running lint somewhere. If there is a general
> guideline for adding a new netlink YAML, I will revise it in a separate
> patch.

I have a patch ready for the next merge window that adds a lint target.
For now you can run:

yamllint Documentation/netlink/specs

You're right, we don't have a guide for adding new netlink YAML but
that's something I should add to the series I have pending.

Thanks,
Donald.

