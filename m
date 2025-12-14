Return-Path: <linux-pm+bounces-39486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F2CBBA67
	for <lists+linux-pm@lfdr.de>; Sun, 14 Dec 2025 12:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8CE83007C69
	for <lists+linux-pm@lfdr.de>; Sun, 14 Dec 2025 11:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685C22E040D;
	Sun, 14 Dec 2025 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bUF5wS0H"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED7B1C84A0;
	Sun, 14 Dec 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765712170; cv=none; b=o/H11Xm0ZCKc3drCtHsqmEieG4pqpqBWbrKMm583u7CqNszb1WbDj+wrrhbxzZNiTvuYDX34mU7zVndsgjobEKJB/pgwyAZ+g/N3OwFdpqU4P6nviIbGBeO0Kt7wHu7PoQsGFAeu+T11P1hn8WXt+IIPWhsv9fi4L2EEJGEsKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765712170; c=relaxed/simple;
	bh=aY/8hLQczdtZhqoQy3HUv8F39g3UqechMQ6sT1nsuVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7thr41SGE+TAzb5rCYwiiMXiWk5+ZZojLYx/x9GbJUWjEnnkeD90T0AIFXWT+/p0oRXjlu4n1lJeW4m6WJZMRddXUzVcoX7UGw4hvgThY5wNKCMmSdu0xGbEOkUx6FvyxvzKshzGFFDUMTaAzwJBQiNIaIwHEmjlGUpBCqgjDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bUF5wS0H; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2AWI8+vsS10/WL/nLrVrHfW4flPvgf4fAkFASYswKN4=; b=bUF5wS0HF7Zuu67arKGsHLgzGV
	zLiG/LjGhbTBfxMKlQLh+OYevQNn4/FGUng1h0ChebDzAfDxVSMkq+ODcD3B/co/UL4u9ZtWo15kB
	+cNsdodikqNJ3BHQwWg9Gv4P4njM93KT5rLH8Pr1gibTs9PqLyWqukEDLuRW3wDP8NTOnuWOAv5H9
	Ia5JX4VG/Ny+rsExDkMaC5emfzyGB1hPK63iS2HgIMjqSzXjhnTgVUSNgvZbMmeDInfGf2k17tTyl
	A2Hmmu1Xh6v6kB749xOtq0BMCoUCY/7Rdhc4vmIBNr937oS8CUkFyEn35AFIDBLpoK+NEhE7UM7mt
	+R+V5Pkg==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vUkOP-00CbUO-KT; Sun, 14 Dec 2025 12:36:02 +0100
Message-ID: <4bb1ea43-ef52-47ae-8009-6a2944dbf92b@igalia.com>
Date: Sun, 14 Dec 2025 20:35:54 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Concerns with em.yaml YNL spec
To: Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 sched-ext@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
 <081e0ba7-055c-4243-8b39-e2c0cb9a8c5a@lunn.ch>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <081e0ba7-055c-4243-8b39-e2c0cb9a8c5a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/25 02:01, Andrew Lunn wrote:
> On Thu, Dec 11, 2025 at 03:54:53PM +0000, Donald Hunter wrote:
>> Hi,
>>
>> I just spotted the new em.yaml YNL spec that got merged in
>> bd26631ccdfd ("PM: EM: Add em.yaml and autogen files") as part of [1]
>> because it introduced new yamllint reports:
>>
>> make -C tools/net/ynl/ lint
>> make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
>> yamllint ../../../Documentation/netlink/specs
>> ../../../Documentation/netlink/specs/em.yaml
>>    3:1       warning  missing document start "---"  (document-start)
>>    107:13    error    wrong indentation: expected 10 but found 12  (indentation)
>>
>> I guess the patch series was never cced to netdev or the YNL
>> maintainers so this is my first opportunity to review it.
>>
>> Other than the lint messages, there are a few concerns with the
>> content of the spec:
>>
>> - pds, pd and ps might be meaningful to energy model experts but they
>> are pretty meaningless to the rest of us. I see they are spelled out
>> in the energy model header file so it would be better to use
>> perf-domain, perf-table and perf-state here.
> 
> We also need to watch out for other meaning of these letters. In the
> context of networking and Power over Ethernet, PD means Powered
> Device. We generally don't need to enumerate the PD, we are more
> interested in the Power Sourcing Equipment, PSE.
> 
> And a dumb question. What is an energy model? A PSE needs some level
> of energy model, it needs to know how much energy each PD can consume
> in order that it is not oversubscribed.Is the energy model generic
> enough that it could be used for this? Or should this energy model get
> a prefix to limit its scope to a performance domain? The suggested
> name of this file would then become something like
> performance-domain-energy-model.yml?
> 

Lukasz might be the right person for this question. In my view, the
energy model essentially provides the performance-versus-power-
consumption curve for each performance domain.

Conceptually, the energy model covers the system-wide information; a
performance domain is information about one domain (e.g., big/medium/
little CPU blocks), so it is under the energy model; a performance state
is one dot in the performance-versus-power-consumption curve of a
performance domain.

Since the energy model covers the system-wide information, energy-
model.yaml (as Donald suggested) sounds better to me.

Regards,
Changwoo Min

