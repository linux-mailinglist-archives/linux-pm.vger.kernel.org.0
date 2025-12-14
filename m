Return-Path: <linux-pm+bounces-39485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E7CBB9ED
	for <lists+linux-pm@lfdr.de>; Sun, 14 Dec 2025 12:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A99753005AB5
	for <lists+linux-pm@lfdr.de>; Sun, 14 Dec 2025 11:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D952E8B9F;
	Sun, 14 Dec 2025 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gsxZ6ZNm"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7948A2E1C63;
	Sun, 14 Dec 2025 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765710873; cv=none; b=d8GJDkEiqvMmJx0oGA2kqGs5iK3Ty//HQbTuXunh3ZUGqtfiXHxv8+C0Cwih1YerFa7HZWhsNvKlg6gAvvALcNh5tXHNnOMs8icmeng7Pkt6loQzAR45QJN70sMs6vOR7VEXlBlkeI29K7/v3uPNTaNBdfd6WPcNcvWHAWDC7xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765710873; c=relaxed/simple;
	bh=c5VQYxr5JqD/oNlw2O8F7jQLXBCfxoFdZ43pxvhAmEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rphdRXvCbgcdT1P0dnjQsx9lPNpjboY725NAi9q3/M/SYbT2w8In4VtA4lCr5qTuheqV0ZlyaQFDG1BuKdT2dWn2mOUAl3HXa/A4I6RqgrQcTwZamaRNpsOmGCLpt6fB05wpUAJv4FGxyc1QIc40Csg4mBJiKeC5zMd53+STR5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gsxZ6ZNm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=00Hod9YODnzuvLj0b4qaA29sJmwUi1Uw33mu0srG3R4=; b=gsxZ6ZNmVhF9WO3NIQjvZ4Ih0f
	vHRJNB/MqdPzD0VKJ0oWpFI1T6wkpZPUHzwtAoaArR5KED/c23ssSLrSEEaYcoMF7zRD3XoTxdhI4
	LzunYRmrW0lF6JeSwgMKHjtOpSpAmDjGGsnY5nxRVUUOfaPxGZ4SLC7XZzKIHcDa7Qs9hALU05mDn
	yVQDzi959f1i12m78Dbikj7iUxji3yFkSAAEfZ5mheKhbB0baw8i+JpvGsMV6oq6bv3uqa0rR0Z91
	D7HOuJFurDhZh/tdJ5anWViDjzdYA9PcVloB78NRDO9ts2KINoXCeertiwWIUByQYiQCa/NTZC8KR
	dx6r4Qew==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vUk3N-00CbDN-Ok; Sun, 14 Dec 2025 12:14:18 +0100
Message-ID: <5d3c37c0-d956-410d-83c8-24323d6f2aea@igalia.com>
Date: Sun, 14 Dec 2025 20:14:08 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Concerns with em.yaml YNL spec
To: Donald Hunter <donald.hunter@gmail.com>, Lukasz Luba
 <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Donald,



Thanks for the feedback. I rearranged a paragraph in the original email
for easier reply.


On 12/12/25 00:54, Donald Hunter wrote:
> Hi,
> 

 > I guess the patch series was never cced to netdev or the YNL
 > maintainers so this is my first opportunity to review it.
 >

You are right. I think I ran get_maintainer.pl only before adding
em.yaml. That's my bad.

> I just spotted the new em.yaml YNL spec that got merged in
> bd26631ccdfd ("PM: EM: Add em.yaml and autogen files") as part of [1]
> because it introduced new yamllint reports:
> 
> make -C tools/net/ynl/ lint
> make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
> yamllint ../../../Documentation/netlink/specs
> ../../../Documentation/netlink/specs/em.yaml
>    3:1       warning  missing document start "---"  (document-start)
>    107:13    error    wrong indentation: expected 10 but found 12  (indentation)
>

I will fix these lint warnings. Besides fixing those warnings, it would
be useful to mention running lint somewhere. If there is a general
guideline for adding a new netlink YAML, I will revise it in a separate
patch.

> Other than the lint messages, there are a few concerns with the
> content of the spec:
> 
> - pds, pd and ps might be meaningful to energy model experts but they
> are pretty meaningless to the rest of us. I see they are spelled out
> in the energy model header file so it would be better to use
> perf-domain, perf-table and perf-state here.
> 

That makes sense. I will change as suggested.

> - I think the spec could have been called energy-model.yaml and the
> family called "energy-model" instead of "em".
> 
> - the get-pds should probably be both do and dump which would give
> multi responses without the need for the pds attribute set (unless I'm
> missing something).
 >

TODO


> - there are 2 flags attributes that are bare u64 which should have
> flags definitions in the YNL. Have a look at e.g. netdev.yaml to see
> examples of flags definitions.
> 

Okay. I will add the following (from energy_model.h) for the flags:

#define EM_PERF_DOMAIN_MICROWATTS BIT(0)
#define EM_PERF_DOMAIN_SKIP_INEFFICIENCIES BIT(1)
#define EM_PERF_DOMAIN_ARTIFICIAL BIT(2)

> - the cpus attribute is a string which would appear to be a "%*pb"
> stringification of a bitmap. That's not very consumable for a UAPI and
> should probably use netlink bitmask or an array of cpu numbers or
> something.
> 

Okay. I will change the string representation to an integer array of CPU
numbers.

> - there are no doc strings for any of the attributes. It would be
> great to do better for new YNL specs, esp. since there is better
> information in energy_model.h
> 

Sure, I will add doc strings based on the comments in the
energy_model.h.

> Given that netlink is UAPI, I think we need to address these issues
> before v6.19 gets released.

Sure. I will prepare the changes quickly.

Regards,
Changwoo Min

> 
> Thanks,
> Donald Hunter.
> 
> [1] https://lore.kernel.org/all/20251020220914.320832-4-changwoo@igalia.com/
> 


