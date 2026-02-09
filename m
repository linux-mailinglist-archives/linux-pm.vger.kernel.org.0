Return-Path: <linux-pm+bounces-42373-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMb0C6dsimkqKQAAu9opvQ
	(envelope-from <linux-pm+bounces-42373-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 00:24:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A691D11560F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 00:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 722A6301FAA2
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 23:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61FB327783;
	Mon,  9 Feb 2026 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuRwjFU3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342620DE3
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 23:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770679458; cv=none; b=IDlDObkK326CiODxBMm9AbCasj9lY0rdMxppVlh7A8dfl1vNCPmMa5JV8fivo4DLon2968i69tnnGDURFDzSFm/MLyTEfgr34A2wj2PUFp37DmXCxAZEG7ZQdn34nQ1oUJwdM8c2uQzvmgNrwwaWChu2yyVewSDjXz4tjYw0pY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770679458; c=relaxed/simple;
	bh=BBTGk6b529pQcQ5ahNj83thUx09UB4cwxP4jhHO1y2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ml1Lpa+yREadIwqOH641cfLwMLUgYC0XL4IkPkC8LhBX2q1UdyfDpF6Dii5GAJZ4ZtbiHt+rZbHJ0mt7NeI70W3bF/cCv3wU96pPo4738MLRcGplGrfs9umcr0ZAy52B5vu9hZKJ4yWzfZWk/Yo+5emvM3xioOzv74uwTb77YjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuRwjFU3; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7950afac0ffso51526307b3.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 15:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770679456; x=1771284256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dh86T8F3rGHGpWfUD88KFpAEHcvoYD6V6bsLPURnOBU=;
        b=JuRwjFU3oJfeEhIl9PxtevSdjlnK4dKIrcS2ye67eDcnX9/QzHROQJJYfxrpCpL+cM
         hIxUVYM2aqmNt5RcRJtzSuuOTlB7w3V79FIZK3woZghFHDsK3/MaZZhlX3gAb/6hBxGH
         ao3gb+KWIiyNXwRySZ5ZAfvjr5cmJIibs+pmpbEt5wM6HdFNuggwOoD4ORPXz/ahQSqv
         uxyKVnN6p8sY1JH/bousj19gBtMkzPXCkOHBuzo8Q4yIJ5AvajEWW0eO6IyJ3q6p/8qE
         k/7bnSiyv6nxNL/A9DLD/bwl4EQtHIJ8niwT29u7x+zQXDS0XH06diK3p4oECfJkwMeZ
         84ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770679456; x=1771284256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dh86T8F3rGHGpWfUD88KFpAEHcvoYD6V6bsLPURnOBU=;
        b=FCCchf2tzjDGlyBag+PvW/ImyBapKtroWEMEcJbXFhkIUEibMMA/oJIkm8qYxLhEJe
         cwYB2qtq8bURt5MzRGvVI5J1E1FKVuIiJv27b3b5NbM27Yko5TJ6m40rzhZo4nL3LDBJ
         yAYICDICOlq0oqaKUznrUmIw2mPsfuPVKJBgLIE8+O/UHJcExNvAsb0/SXiWde+S5nI2
         fT3yae5mXdUju6A81gtGXpECqhwJpvVueAwt2FfFptaTOmW9pujDt6fvH4jliOTN6W+n
         eWVMxytwxOcWLffWwytLszJucnVXrhth0ubfll2y8Ah1zOGrr8xD1J2/Hoea9D0dcr2+
         g2Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWanP8ks3jLly2zeDW1oFBiMZYMKhQrITnpH/T8MDZ21HVkOoVSda+RouMzXcOF27LdJgEvlW/dVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEp3+/AmzeqFtxg0MlZO/CD+KRKtS1G6ujs5kDfvV8o1j/sun9
	iYLjWN6Mu7WdqIkQVxTomSbRhrVzKF2nrPglDqSCKfANbKX57hm76EZS
X-Gm-Gg: AZuq6aL8KrWrUpz0QCl9rFG2uo07vThhIq8esriiKGL6dAdxEntIHxn/kodM/eA5V44
	OsHFVQ6OzRZCYWSuQ+tzh/XVPqRfROAwZKr6lnx0M/lItMhklOWuIlTZ7ztXD+npThLApVul/4b
	eSgBH/uODsIZLiBbFGhoKmw6819xkmJYb+5UA24MPByXB/hRZyRvW/MES/kP46StzwrZkiCehE1
	QL6/qcl6NTO/H/eS7bhx5OSNMej++UrRdMk6rK3BYUT6e8pwXv1nW7G0/ktqagBrEl1pw6cfEnJ
	1p8SHbObp2ftw7jzwOe/+Yuy9P7QJe4njrW5STrpk9mi2LspgWjG6SFYJPB7NzAHcN+70wyTcTh
	VQCTROS/o8kTwgeFwVwjcOE0i4MYC97tMAiiVhDu7+UsgMDosepN3gUKzsNc1wK16hLhFpER/Iv
	vDiWKFFGdiFEY9e/YKM86v+mD1ZF9Kmt6AOul/q31Paa1ABHMwyg==
X-Received: by 2002:a05:690c:6e0f:b0:794:8a60:77da with SMTP id 00721157ae682-7965e1ac266mr6213037b3.11.1770679456546;
        Mon, 09 Feb 2026 15:24:16 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-796401a19c6sm48506387b3.10.2026.02.09.15.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 15:24:15 -0800 (PST)
Message-ID: <83e65606-cbbf-421a-9de6-9e39a7d872dd@gmail.com>
Date: Mon, 9 Feb 2026 17:24:13 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] cpuidle: menu: Fix high wakeup latency on modern
 platforms
To: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>,
 christian.loehle@arm.com
Cc: daniel.lezcano@linaro.org, ionut_n2001@yahoo.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org
References: <20260122080937.22347-2-sunlightlinux@gmail.com>
 <54478318-cbee-46f2-9ff1-9c0ae15a89ab@arm.com>
 <20260126201943.11505-2-sunlightlinux@gmail.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20260126201943.11505-2-sunlightlinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linaro.org,yahoo.com,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-42373-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,arm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yumpusamongus@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A691D11560F
X-Rspamd-Action: no action

On 1/26/26 2:19 PM, Ionut Nechita (Sunlight Linux) wrote:

> I considered PM QoS and /dev/cpu_dma_latency, but they have limitations
> for this use case:
> 
> 1. Global PM QoS affects all cores, not just the isolated ones
> 2. Per-task PM QoS requires application modifications
> 3. /dev/cpu_dma_latency is system-wide, not per-core
> 
> For isolated cores with NOHZ_FULL in a realtime environment, we want
> the governor to make smarter decisions based on actual predicted idle
> time rather than relying on next_timer_ns which can be arbitrarily large
> on tickless cores.
> 

In case it helps, you can write "1" to

    /sys/devices/system/cpu/cpu*/cpuidle/state*/disable

to lock out any idle states that are too deep. That's per-core, although
it's not as "crash clean" as holding an FD for /dev/cpu_dma_latency.

- Russell Haley

