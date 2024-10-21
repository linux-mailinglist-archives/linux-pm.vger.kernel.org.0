Return-Path: <linux-pm+bounces-16087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED6F9A6777
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 14:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747911C22170
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 12:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C5C1E885D;
	Mon, 21 Oct 2024 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OZU6GZBe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835E1E6DFC;
	Mon, 21 Oct 2024 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512174; cv=none; b=G/eNeEVWm5s3cQWrFPj3LLw/KaPq9RdUaP9OK75VzJBadJS2HTvUiCKJalu92HFaclHWT4TCsw66d1hXw7ynk/59NJ5wcjP6E6QzoucCApP9kGZgBcUY7kryu7sR08HOo2LA9nysN/4fKAc76Zltoi7WgnJMbtpM3vz4jYd3obA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512174; c=relaxed/simple;
	bh=vbJ5KWwS11/GGOAN03ct3LE9sOvbCOnmGxDHxDpehnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nID51axqFgKalp5LhYtBJ2CHd/woo1YfQ2kdPgJtes1/GKXVnKVmOHyyCW6OmUixRCISpsaEOVAf29TWSsGECo5IM++zVhxbP2uU+eyj2SA/wvwlTrRzphmm8mIBLHfOOkeFisA4fvVYj6JI+oIhqzUctUm8nm/bl2Pwn181ArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OZU6GZBe; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729512149; x=1730116949; i=markus.elfring@web.de;
	bh=vbJ5KWwS11/GGOAN03ct3LE9sOvbCOnmGxDHxDpehnw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OZU6GZBeYNuREKBHewINOHj5U0wYmAzN4wmHPuZZ2Eua+IRjSbmr6LbHsiOjXkJ2
	 W3ijVskGzfcEg6Y72D2O/zbOOq8AJhhz6rTEAfYPI4AimqtuuFqFODzzANDQ4gZjQ
	 1qE4AEBzJI8qm8WkkgX4ELIIV4Tb7cRWCBdTqgAcL4lh0NU5uDPuDihhSnRUZ4XHU
	 5W6+z65KdrnE7PAPAiyAPgz2ysLte3tOLBH6GWukzjQQ5DlPezj1ZV0YUKxaYf8fJ
	 XbspJkLn4SS9a/sqxdKrTpXH/LkMfgb+6hQIeHVC/B5DJ6pJBZElZ76SC7P5y/ssW
	 IvLMzIxw5+sFY+14ng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mft7t-1taIBg392H-00gEUk; Mon, 21
 Oct 2024 14:02:29 +0200
Message-ID: <45cbf165-770e-4e28-8936-edd6f18964fd@web.de>
Date: Mon, 21 Oct 2024 14:02:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 01/11] thermal: core: Add and use thermal zone guard
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML
 <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <1930069.tdWV9SEqCh@rjwysocki.net>
 <40ec7bb0-02ef-4af7-8934-9f960fa15355@web.de>
 <CAJZ5v0iaR1e6OMpY=wMBKhqg8F6DAX5KUqa+YACEr0z3EZxo-w@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAJZ5v0iaR1e6OMpY=wMBKhqg8F6DAX5KUqa+YACEr0z3EZxo-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h/jhpDNmC+IpF15U0DTky+VEjVMWHNYNtu25pmwOVahW5J5OOZ8
 nmb870hojisngz4J3b395Ur3CXvC3fgE7nYTW6aM+gWgybJ2WW3JcAICAIqkSzoJpSI3fpF
 mbGPLkF6diDc2bETq8vm2mwW9GrBbSY2BwS1vsKJSdTOSKUfu6qR5mz7CfvyHqVICyCQDEB
 MDiLvrwjyBx++WAC0NFug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XxoJzX8BMsk=;SBp6JccNSgZMDmiwuyztSLz/EEq
 pReD2KdVIN1d4yUPmXj0Z7AFGQLXz2SEsIxV5eOguH03xWsfU2Gw2POhcZBjopfE6VE1C0snT
 aPDNhTstx6zi6HbkzPzCrSqgMLG8PIVK2oQTq8Fi7oBkRgkQIUdjHTkqU71HVlDvpAJGHLxSV
 M5H6vNya7CGNfOfknmUQXGxFBjHHfVxSCJABvql2vCMpynwG9fBvquffasQAgnvTUxXQ8IZs+
 xsPmbfqA0wdZ6TIB3zdMnvZWzhM+fItrZ4pIuFNiNK+IxAwrMi/4rw6JDdY7u/256Y99EXjYt
 BGvL1j9IfuSPix6qW7dAglcHxg55Sm3e/t6uA/Qx6i/h3N5g/8Q17iZDzyJ8ifY5gRugEx6Iw
 chX/Rw9sT1JZqoSjdH/hsDNcmdpSLYySNe/kjuvOEK/6uVaupEhtEBLyUleBPaKhUxZWVWCAE
 eUCoGcWkvS0fL2MUkWta6Tho3hMY2KoFz6STofOdq1In9gqbORjhGEDdzt2OBXtqar2Ah7m+j
 CINwSzpwn5PctbKzGyv4g4Rm15wBlcNzME4wYg6U5yylSISrGuspGd3E1pFEO45OErC1iZFfE
 LWw2XfLXSw8zmboSAJtDKVgoqSiUp1X0hj2Va9Ok2lQo9Pqr5FNm3FrvYEt7V/62EEHKr2bkH
 AfqEUVZc96EY3GTRQytmqPQxVlS0F4OczzZcrSSGEWcJXrz6m0+g0jhCgiFMJoK2LWNsLZXi5
 hRtKLhvk8OvMkiWWdml/aRujTk05AfEReGBSoQXi5wUp2JLOaXKBgnPAP1RvJZUs9vHa8nuQ1
 +6aCk/FJIwNuubF/i5Nv03lw==

>> =E2=80=A6
>>> +++ linux-pm/drivers/thermal/thermal_helpers.c
>>> @@ -60,13 +60,13 @@ bool thermal_trip_is_bound_to_cdev(struc
=E2=80=A6
>> =E2=80=A6
>>
>> Would you become interested to apply a statement
>> like =E2=80=9Cguard(mutex)(&cdev->lock);=E2=80=9D?
>
> Well, please see
> https://lore.kernel.org/linux-pm/5837621.DvuYhMxLoT@rjwysocki.net/

Will the separation of source code adjustments according to cooling device=
s
and thermal zones trigger any related clarifications?

Regards,
Markus

