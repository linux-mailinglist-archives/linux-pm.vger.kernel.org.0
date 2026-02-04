Return-Path: <linux-pm+bounces-42081-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFgpGftEg2nqkgMAu9opvQ
	(envelope-from <linux-pm+bounces-42081-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 14:09:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3ABE6341
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 14:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A512B308A85F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD1940B6C0;
	Wed,  4 Feb 2026 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="pCfs27vd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6083D3CF8
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210178; cv=pass; b=U5vBOsdzqYwOfAMIzNYYhZHCI9ymzpZNXH56HQ2W8tlN0/adMrLgjbYlaAQX+nzqbw07VIeOxwmlc4ekwnaM24ZAFU5qhhqibcdst0+qfvI6Ze4x2noL16S/rEmJaaFhezOvoYNLLaTB6PmqJv424snVXsHnV7DONFtQql9SnJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210178; c=relaxed/simple;
	bh=jqB50L1VPXgD56TAUS5qWxfi8WyhK/RAKlozHuVqM+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PItZ7y8eRms55w6oaz6wvzS36yADk7oqiX2GeTmyaLS8sairEtaXSbPIul+x5JpBsY9JNsC8SaV0VOOQqBaTU01WM1SPh7gWldLtj93gfCUHjYRJJyxWSu/ItB1CVjBPdwQCIJSehd21mVXjoR6a0y5bvVRYx1/XFvT0WhdIKOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=pCfs27vd; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso3654710a91.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 05:02:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770210177; cv=none;
        d=google.com; s=arc-20240605;
        b=jJZo775iv3xgwFdJG0xkhapAoBXQO5jkxiI1y2qhe0LibAOOeuwpX0lOnexXadUxh6
         xavniLS6gxu2brDBaW39Clivjpf/ZBVTZ6EGuufGaNoPJ6+AJQQqkAvg+VpWtzgu8k+Y
         ZwauxKWeiw+GmP1p8WsCiCN2PYUZT72atj5BpGwRgFhfP6/UkCjLzblPmQYw99cGYy10
         PD7E3OJIuZiReLXSOmkVucrL4uWKLP5j59aHbiYCYf8ax6Skz/wKfEVc502g9TqPK/Mn
         A7ITAx8prqzgF6S4G7Ff9Q5eFAU7FJXMKTaXdea/bY1SSOgzMAhRf3fiwm19C6XsDY8I
         /DUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jqB50L1VPXgD56TAUS5qWxfi8WyhK/RAKlozHuVqM+E=;
        fh=an0+osjGDIvqUNZzPppfIv+P+HJrqGpf3u1461hsgVo=;
        b=UL2XYMnd7xGeF2ME278jTNXK040jkyVAMgJv574fMgqh1IoX40XbEaDnM+MKWIDD05
         usAF/l6wPt1HPXBejkWuLWLD+ZP1ixd+tcuaCHTA3txrjX6ulvNDBKFf9EO/sWgqWD3/
         DYMj/AwIA7TWck8hu1sz7NpoWs3O6p9twbIVrsqEy5M3sg/IFV9IquEIm3E60VLuKMOl
         uc7CRnrmvK00gonz9cfdSd5bM5sFbBX/XiBZg8i8n3D0Pu4tpL4uorL1JXccSQG1+MIQ
         I9EbscsHMJ7Ng+iT7Ji61vpRVAL+NBnCqcNPgFTocbXRpoNI8bv4N6gEOERw7sGpKHRg
         Ow5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1770210177; x=1770814977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jqB50L1VPXgD56TAUS5qWxfi8WyhK/RAKlozHuVqM+E=;
        b=pCfs27vd2Urzkj8tJ7K8/ouPKEgTalhMwIgbDbQERtPG0SnJTHuI/yWVYN4qqT/sXH
         a2wGrATIWpaLIvhjm5izA6AgUsBKRKgOJnSl9P7WBlz7wXNnhTibP3r/I3vNFojjJN5P
         uvM066dACXe4rRmBXqK6uZAtD5zNsZYmiVgNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770210177; x=1770814977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqB50L1VPXgD56TAUS5qWxfi8WyhK/RAKlozHuVqM+E=;
        b=OwaPMsQVaXduMryf48DmQh0qWoJpHkOrXTTB5hGKpZkwsrhiFY39g5yBKBYy0x/UE6
         n8gGPdDR3TdhafU8Teo10iqs604s7dI97hEtUNWJojhCHL7iHLn+AKEaH+CDc32jk28P
         D4nE9mcpnSI8QgG2mEsVk/lVpTFgKHiz3LyljtfdhUl9CuS4sXZ24FeFGM0DY3M/ilNg
         B1wixCnG0rJg7K8+khwPe/iCICyTwXq6ZzK7ia47T0gIS9tq3Z2x6E/Pzh9bEP9DV+l2
         A2Pk+fY6N9YZ7ySpjPDGCsxyvarAXZ6xS9yRWMwGTnQYLL4z2eaCjR0aSK3rd395PcDm
         lXRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0/Z+7MGbl0F/Y15HdyyhjgJ9Bj5F59+nLF01SUtgcTSMBI7LU0Udo5M1+m63LBRif7AFXanrGMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzySxXLpM41EMwhLehQRqU3m6awNL+Q00eFTyLY1H1SuL3AH1FY
	mEeHrcnjVPHg90OcO7R8Ex0suPEbZFjAFpUwLCqQSZf0YFEX5RSUQsnS3v3UGIXtyRzOfvkn77v
	Ny9jPXp9d2WxfNyKA2KcCcGrse+zYmz/Cw3oDCcVOMA==
X-Gm-Gg: AZuq6aKnlaLIVcAbc6YNIIhmV715UPHV9/nW4/CEggBVZPVK/PghZnCq8r3fzlX1MbW
	hDJEYeovEGDyLhkswmS72EPOTNSpab4cJ7vGQJiHblLFX63iMryhBml4qBZc4wkcnH+6uNRTLmm
	+NFPwuPEk/2XCXNdfS7pXVq59cgVKGFnkDzWt8WxVCJ2hkBvRn5OZrQddqCxY+zR/fWAgZw/RTp
	vJzOlOOBujXW4fyLMnDAqRmIEhflSOMkOR63iw75LOWsnMeTkQpIeomLr7iNQ/bHBSax87Pgg==
X-Received: by 2002:a17:90b:350d:b0:341:315:f4ed with SMTP id
 98e67ed59e1d1-354870eb613mr2584532a91.10.1770210177520; Wed, 04 Feb 2026
 05:02:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203170824.2968045-1-visitorckw@gmail.com>
 <CAMuHMdUMBoLd8cKXMK64qjGfTqQfK21mDAXMh8DdJHkL7QbDVQ@mail.gmail.com>
 <e7ddd671-6e25-4114-9d4c-21ecebe82ef5@vivier.eu> <CAFr9PX=heS=ywLCidd8o_BzS4TS5U=GA8yv7itzNFp5nuwf2XA@mail.gmail.com>
 <2a4ebbea-12c9-4362-aa09-dd3a7de1be46@vivier.eu>
In-Reply-To: <2a4ebbea-12c9-4362-aa09-dd3a7de1be46@vivier.eu>
From: Daniel Palmer <daniel@0x0f.com>
Date: Wed, 4 Feb 2026 22:02:46 +0900
X-Gm-Features: AZwV_Qizyl8upErpfnTfEOGA157wPCSy37URTJkgip2hxCDhdYxq0FUzjc6r6AU
Message-ID: <CAFr9PXmqSv00Dt=fwwGsDcr8DgpELsa-X=beqazcQOJvxB0=1w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add QEMU virt-ctrl driver and update m68k virt
To: Laurent Vivier <laurent@vivier.eu>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, sre@kernel.org, jserv@ccns.ncku.edu.tw, 
	eleanor15x@gmail.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[0x0f.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-42081-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[0x0f.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ccns.ncku.edu.tw,vger.kernel.org,lists.linux-m68k.org,linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[0x0f.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@0x0f.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BA3ABE6341
X-Rspamd-Action: no action

Hi Laurent,

On Wed, 4 Feb 2026 at 21:53, Laurent Vivier <laurent@vivier.eu> wrote:
> How to use it with QEMU? Do we need some changes in the code?

You just load u-boot instead of the linux kernel. I don't think you
can actually do much with it because there's no virtio support to load
linux etc yet.
But I have that all working in my own branch and now Kuan-Wei has got
the first parts merged adding the remaining parts to boot linux
shouldn't be too difficult.

Cheers,

Daniel

