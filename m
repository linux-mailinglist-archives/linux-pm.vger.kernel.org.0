Return-Path: <linux-pm+bounces-43661-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAscE3tJqWlZ3wAAu9opvQ
	(envelope-from <linux-pm+bounces-43661-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 10:14:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6DC20E19A
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 10:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF300307652B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 09:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41050375F97;
	Thu,  5 Mar 2026 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No4s+tKo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF38C374E79
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701734; cv=none; b=JR3DIdykKBgnmNZHIKbjZZYpEi9aXhkYv8Vub1n5TO1s6WxgotD8MddNqt7z78axAYzmE6eCj5qQvm2goSNvVFVRcQpudIUhZfyswe7s6E4+cSE+p1sCY9/NumSOuQtlEe7fqB1Z1pg3gtwy1NWPQgMrl0GskMhFjsBOd/nt8ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701734; c=relaxed/simple;
	bh=WD/1Fuhw7kTyLzZf1oRx5KLWdjeZPVoCTn3YWmum8Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSNDGZgL9b8KyCA+GrL/4sFVjD2vLY2kHdFgwc3DM/D4R0GJm9JpzhTXfAMsa7O7hVLwWHPyQUmKIE7joo+kLYxzLlRno4A221sY9CUan1U2CqfVyOQWO3dspUhf7x8FGDsqg6q+zQYffITVbf7+a9fsagIVtviKT9SnHWtojqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No4s+tKo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso70884925e9.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 01:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772701731; x=1773306531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HdgzADYdSTQF3KpHo8SgQF1RTtf2xICHD/S64SaK5OA=;
        b=No4s+tKow5nqquHs/O3gkgVs4ghgFfPhMhjUxzzZWADmCPj8+rMAXnI/k75yiEj/Wx
         RIatEkuI0ROnOgrvIO9u3mM55nXccGhm57WYqQQtlJwGUAtvQ0Nzbg+KR+bAomc/QcaV
         YGrEji30VFMtpyFalyT3i+6w9mtHiW7PvkZ6K53/biA/qhqFSXFwvcdnWyNbUvSbyHQF
         HhdNVNNKO9Q2yCA6XA58rgCL78DNDil+MLO9xaHSA+ROpp5PBDCzqZ59fmIgLFWnqaEc
         VwzCzRTzNaQoYsC9J0gnHFggJJ8jZo+s9nBKUyD9xBC2YlH4f6Ry5mOBXMD6M39TVkIx
         JCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772701731; x=1773306531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdgzADYdSTQF3KpHo8SgQF1RTtf2xICHD/S64SaK5OA=;
        b=HnKAD//O+g/YVNG1t2ht7X0ApSCqvuPY5X/oDzQfbOZyiTIQhUA0PGdq2qxpfYP/XC
         5pJQqYh+cgo/HXiMiWplic3/FKw0KIRWq4i/Wxc7M5bUg09QWbl/WHT3dxDT5xFXDTjA
         eXK6OZYfn3WdIGVCjZMIUesNAh7lGa15Cj30qMo2n+MDUackpNWnwWkoJZ80CbSp/eyw
         gFKhUDQzZV9w/EaewBUCAHv9IeBr2tUKb6/o/ERqZoOAWk3RTFS3Q6UoevHAaQAxkS8c
         doHu7194jjFQ3byO4lodurAN8YAPgcmo8QZYso1Or78Gkh8QKofl8bBWFzDAs1PwX3po
         0z7g==
X-Forwarded-Encrypted: i=1; AJvYcCUYa5Tj7YxbOFjdQeXtTTJva072AC+TAwYQlbE1lU5QuSqFBuXpcRFY+UsdoluZn09W8OiCYZVR9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj2O2+5bTRjmeHJrpCwFLJyAEvRm5LtKvd6v5hagPKq8UrnQDs
	9xHIEanJlQ/Kkf2LzjKhBNvMMOhUGUGL+30DvCI56rk3VPmsrAhACZOy
X-Gm-Gg: ATEYQzx/kez2U1MarA7mm8wejZJhGCaM5DVQD6dyDuXzczqp6rSxIFPDLAuX1+cJAwb
	2tvC+uRmCmtRx3VTKE+NifUmhCw1xS+rqVVt7jk+H6EysIxyybP5fme/BGrhAon6/JzNA4Go1ss
	mubgPmejIxlBHqswdR3Vrz/KRWr+fBXXKsi7c9/KnCX7d1DijJE/HrOJPAUiBRC0PvxNYy7Zj+g
	01K6PoBEDE731TibNsvz0RHF3QN75XfWKCPZuP9GbzM7aCVLyTyRHoVUy/doJEIIU/Na9Gr1nd4
	gXNBaGpEfEbatQestOpIJ+QnmNW5Nv24WHtdnu9HbfAGIj1rzllhO6+UKW8zKlhpqBtEUBD48S/
	3ebOHQODEcQ3bpHxG8bOlofZJ1hFaLRTU3EQrlsGBPFcdVY7gVymHK/L7kW6N99wtMgZBaKaKZZ
	WySTqK/UNsn+37+MPH4ruiden2DbCmbSDSH0ZJeo1i+ZXjWVIyAIoH3anG9tAyRm90TYQ8fFoYx
	m67TuvYUtBYiqhNmAqTGjrQWd7GcyuF150twT5Ach9VUbkMKvl+0JYhHPNJWJQADVR1uEKzSg==
X-Received: by 2002:a05:600c:c173:b0:483:acd9:bd18 with SMTP id 5b1f17b1804b1-4851983b401mr89134325e9.1.1772701730851;
        Thu, 05 Mar 2026 01:08:50 -0800 (PST)
Received: from franzs-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb33815sm52248885e9.12.2026.03.05.01.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:08:50 -0800 (PST)
Date: Thu, 5 Mar 2026 10:08:49 +0100
From: Franz Schnyder <fra.schnyder@gmail.com>
To: ming.qian@oss.nxp.com
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca, 
	benjamin.gaignard@collabora.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, sebastian.fricke@collabora.com, shawnguo@kernel.org, 
	ulf.hansson@linaro.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, m.felsch@pengutronix.de, fra.schnyder@gmail.com, 
	linux-imx@nxp.com, l.stach@pengutronix.de, Frank.li@nxp.com, peng.fan@nxp.com, 
	eagle.zhou@nxp.com, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] media: verisilicon: Fix kernel panic due to __initconst
 misuse
Message-ID: <cq7xvy74ore4wqkdarf2p7tgksrmfdaysajqga5ymrdkklwa7p@nrbu52d4gxe3>
References: <20260305080354.639-1-ming.qian@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305080354.639-1-ming.qian@oss.nxp.com>
X-Rspamd-Queue-Id: EA6DC20E19A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43661-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,xs4all.nl,ndufresne.ca,collabora.com,pengutronix.de,linaro.org,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fraschnyder@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toradex.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Action: no action

Hi,

On Thu, Mar 05, 2026 at 04:03:52PM +0800, ming.qian@oss.nxp.com wrote:
> From: Ming Qian <ming.qian@oss.nxp.com>
> 
> Fix a kernel panic when probing the driver as a module:
> 
>   Unable to handle kernel paging request at virtual address
>   ffffd9c18eb05000
>   of_find_matching_node_and_match+0x5c/0x1a0
>   hantro_probe+0x2f4/0x7d0 [hantro_vpu]
> 
> The imx8mq_vpu_shared_resources array is referenced by variant
> structures through their shared_devices field. When built as a
> module, __initconst causes this data to be freed after module
> init, but it's later accessed during probe, causing a page fault.
> 
> Use __initconst_or_module to keep the data available when built
> as a module while still allowing it to be freed when built-in.

Thanks for the fix. I tested it on our Verdin iMX8MP hardware.

Tested-by: Franz Schnyder <franz.schnyder@toradex.com>

Kind regards,
Franz

