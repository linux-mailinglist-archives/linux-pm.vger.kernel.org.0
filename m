Return-Path: <linux-pm+bounces-41443-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF3fOsukdmnnTgEAu9opvQ
	(envelope-from <linux-pm+bounces-41443-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 00:18:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CAC83206
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 00:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48622300425E
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 23:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481D30FC15;
	Sun, 25 Jan 2026 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="srvNykPF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB7935975;
	Sun, 25 Jan 2026 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769383111; cv=none; b=Bl9MkGaDhScwU9EORm9Rth7m8RAd4mfrDZDDkYGqUxaVr/Rk9WM0MkF+F9Jpc/4C4c+TUeYFE1fCSX4Ks7gXhommLwN35sUFJ3jhuMvFbprTEWrN39kzuzlISLoVRM7o4ltvflomNq1W5+ty66Ktdef11qBODKVLYLk6mZotFw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769383111; c=relaxed/simple;
	bh=bnHPIDRUoIrORd8liCaWNaG8d6KldAF6D70CR+vyJOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0AdmGhJOfynOVp9GOxbnWSqt4/r+BTMu7Y7klo6Oxik4wG/5shLWglITVTXUbiDk9U7VZpI94uMndZQYAv5GHKGAxU3Dj21bW08y3n2h5EqhQOVjfx4KyQ/CYSLWVYTx8UNBSPLQ5QYiHbnZCwopzoPNxW/RRbY67chMOmcYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=srvNykPF; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dznf26l1pz9tgl;
	Mon, 26 Jan 2026 00:18:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769383099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/asOs9DyQ5THRpDLADk+Y2I0OVr6O6ljdNzMDKMqo4=;
	b=srvNykPFoMbdNkm95JsqCubOCcArIDiK11P92dDAugrfofyLVpxqcubR11bb9blGgbeMFs
	i/9DQg4I3K2zQ55MfVpw/t+tA4zykrLpgreokrW3Umrnj1IEvMhvHDS8z8gnHP2xiDL2ZN
	DPvyYhusuj1yj2mfBxSwG+NksqdkK448uH0bgTW0jBR4SEynmDP9amI/96OC/GEb4PKJC2
	xfS95RmIEfcsiUq4fG9p4ukv/v7ajRSu29SxgelLDYUcoHIR95URZhQ0jSi8pUUGXr/Rr0
	NoiMVRSmTckRoGCjjhfdXwtD1s8k7Z1nqpD9A/c8z0y6RXkKS0dsfsatFr5s6g==
Message-ID: <9efa9daa-6584-44b3-8055-bc160e46d8a5@mailbox.org>
Date: Sun, 25 Jan 2026 21:24:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: drm/imagination: genpd_runtime_suspend() crash
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster
 <matt.coster@imgtec.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Linux PM list <linux-pm@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com>
 <0e9f963b-00e0-43d1-b567-cb10b8f66df1@mailbox.org>
 <CAMuHMdVOUzanEufhWqOL0nv81xCYh4YNAX_waG6y9PyUZ030tg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdVOUzanEufhWqOL0nv81xCYh4YNAX_waG6y9PyUZ030tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: m7z9jqcet3zwhy5m8ud1ex4tencrz7fd
X-MBO-RS-ID: 280231b825f43649aaa
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41443-lists,linux-pm=lfdr.de];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Queue-Id: 51CAC83206
X-Rspamd-Action: no action

On 1/22/26 4:35 PM, Geert Uytterhoeven wrote:

Hello Geert,

>> Can you please test this change and see if it fixes the problem ?
>>
>> The barrier should guarantee that the domain is settled and no more
>> callbacks are still running.
> 
> Thank you, that indeed fixes the issue!
> 
> However, I am not so sure this barrier belongs in the .detach_dev()
> callback.  The documentation for almost all dev_pm_domain_{at,de}tach*()
> functions states:
> 
>       * Callers must ensure proper synchronization of this function with power
>       * management callbacks.

Isn't cpg_mssr_detach_dev() the caller in this case ?

> However, I couldn't find any user that calls pm_runtime_barrier() first.
> 
> In case of multiple PM domains, it is even more complicated, as
> dev_pm_domain_attach_list() (and pvr_power_domains_init(), which is
> basically an open-coded variant of the former) creates a list of virtual
> devices, which all need synchronization.  For the devres-enabled version
> (devm_pm_domain_attach_list()), the caller cannot take care of calling
> pm_runtime_barrier() anyway, so it has to be handled by the PM core?

I am also a bit surprised the PM core does not handle it.

>> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
>> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
>> @@ -24,6 +24,7 @@
>>    #include <linux/platform_device.h>
>>    #include <linux/pm_clock.h>
>>    #include <linux/pm_domain.h>
>> +#include <linux/pm_runtime.h>
>>    #include <linux/psci.h>
>>    #include <linux/reset-controller.h>
>>    #include <linux/slab.h>
>> @@ -656,8 +657,10 @@ int cpg_mssr_attach_dev(struct generic_pm_domain
>> *unused, struct device *dev)
>>
>>    void cpg_mssr_detach_dev(struct generic_pm_domain *unused, struct
>> device *dev)
>>    {
>> -       if (!pm_clk_no_clocks(dev))
>> +       if (!pm_clk_no_clocks(dev)) {
>> +               pm_runtime_barrier(dev);
>>                  pm_clk_destroy(dev);
>> +       }
>>    }
>>
>>    static void cpg_mssr_genpd_remove(void *data)

-- 
Best regards,
Marek Vasut

