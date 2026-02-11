Return-Path: <linux-pm+bounces-42519-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLBIOe/VjGm+tgAAu9opvQ
	(envelope-from <linux-pm+bounces-42519-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 20:18:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6D71271C9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 20:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DCFC3005A94
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E334F261;
	Wed, 11 Feb 2026 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="N5y4TIAj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23003303A35;
	Wed, 11 Feb 2026 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770837482; cv=none; b=oVxUJ7/+OVVhVnW8IjxPLtdevKGSE+uXsM96DVM33wcNEY4rTN3K8FCXVblj5+8s/RaXzBLeZSN+sfvaJ9Ih0aNIAAnHdwMExbmydeVJQJxKB+35fVvCt1GRrURYpnasogSN69LtT7WmUlwj7FiqLVvf+xZCfEd/fb3NTffTB7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770837482; c=relaxed/simple;
	bh=lDh8dX0kpuo2VFAo5YwZs9ID0zMqXXMty5OMGfVSOaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ep2OKiB4Ivk6iW/M2mlhi6Jj9XlhFRZucrHBz4qwvVqWF3s5jcGLBla6Jo5PFQl0GWI+8tEVQIyXwt5iwPKVQsiKRukCA/mgBmjNUHLbR3DIEA4zOBwQUyAXeQ7k6ToMbbs4We5H5xTBImbLvTFnxiMNxUwfvBiRNQmXk/VP6ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=N5y4TIAj; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fB7Vs2h8Zz9vBY;
	Wed, 11 Feb 2026 20:17:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1770837477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5M1b+oSA0YS4SriAeQJke7xSD+ujiJ75qVTi/6MjTI=;
	b=N5y4TIAjyvdzKisa1jI3YmkiMgSMkt30boCG7jtAgt3N6CtAAoanhTl2BG3lT3e9qjMjBW
	7geMYHLA6SAaS3RddyGOhcE5YubSEUSFdw3FHDJ1bddtWGYwiUmYD3i5uixltsxtci5pSA
	TYRQeb8kG40qtVRKRXTNmU+BjEa7HEcLXVQxauHywLkZvnwy5BW1wNltIGkaTFrnLG/Q/U
	MFf1Vk1GGNGTyJQqwYjeuycfBO/oZElO0OtyqPOu7Hge4nBk9QlFGC2rwX9k02OCnkhN6P
	ZOJVw/qYtI4yEIVPI9cKNwQAPD1fFYxfAMdAzMRi314NaUTwkceKMj4P5Ny0UA==
Message-ID: <b3b4f10e-1222-44f7-b308-db7199c67147@mailbox.org>
Date: Wed, 11 Feb 2026 20:17:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/imagination: Convert to
 dev_pm_domain_{at,de}tach_list()
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Matt Coster <Matt.Coster@imgtec.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Frank Binns <Frank.Binns@imgtec.com>,
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <194465eda54d1f852a9226cf691ddc5aa208e0a3.1769097977.git.geert+renesas@glider.be>
 <ffdf3982-e22c-4d01-afa6-5449ed381000@imgtec.com>
 <CAMuHMdWMh_oJFg-KtapcTDGvYWZ-hg_ZEJ2=E5Tp1apOEc8tnQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdWMh_oJFg-KtapcTDGvYWZ-hg_ZEJ2=E5Tp1apOEc8tnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: hfo1ysp6dxn384tk37dfppkcoc1of6be
X-MBO-RS-ID: c00b551ddfadc58db55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42519-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[imgtec.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:mid,mailbox.org:dkim,imgtec.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D6D71271C9
X-Rspamd-Action: no action

On 1/23/26 2:50 PM, Geert Uytterhoeven wrote:

Hello everyone,

> On Fri, 23 Jan 2026 at 14:36, Matt Coster <Matt.Coster@imgtec.com> wrote:
>> On 22/01/2026 16:08, Geert Uytterhoeven wrote:
>>> Call the dev_pm_domain_attach_list() and dev_pm_domain_detach_list()
>>> helpers instead of open-coding multi PM Domain handling.
>>>
>>> This changes behavior slightly:
>>>    - The new handling is also applied in case of a single PM Domain,
>>>    - PM Domains are now referred to by index instead of by name, but
>>>      "make dtbs_check" enforces the actual naming and ordering anyway,
>>>    - There are no longer device links created between virtual domain
>>>      devices, only between virtual devices and the parent device.
>>
>> We still need this guarantee, both at start and end of day. In the
>> current implementation dev_pm_domain_attach_list() iterates forwards,
>> but so does dev_pm_domain_detach_list(). Even if we changed that, I'd
>> prefer not to rely on the implementation details when we can declare the
>> dependencies explicitly.
> 
> Note that on R-Car, the PM Domains are nested (see e.g. r8a7795_areas[]),
> so they are always (un)powered in the correct order.  But that may not
> be the case in the integration on other SoCs.
> 
>> We had/have a patch (attached) kicking around internally to use the
>> *_list() functions but keep the inter-domain links in place; it got held
>> up by discussions as to whether we actually need those dependencies for
>> the hardware to behave correctly. Your patch spurred me to run around
>> the office and nag people a bit, and it seems we really do need to care
>> about the ordering.
> 
> OK.
> 
>> Can you add the links back in for a V2 or I can properly send the
>> attached patch instead, I don't mind either way.
> 
> Please move forward with your patch, you are the expert.
> I prefer not to be blamed for any breakage ;-)

Has there been any progress on fixing this kernel crash ?

There are already two proposed solutions, but no fix is upstream.

-- 
Best regards,
Marek Vasut

