Return-Path: <linux-pm+bounces-42684-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAutJz7Jkmm6xgEAu9opvQ
	(envelope-from <linux-pm+bounces-42684-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 08:37:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F13381414CF
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 08:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F03B300A8FF
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 07:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73F92DEA6E;
	Mon, 16 Feb 2026 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB3RGwdk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F58242D9B
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771227451; cv=pass; b=hVpT3P2VMp/dARiRhZBulwukv9tOdr4QCHQ+eS2+lc8oPihN0ZJoLt7GI5iK8x4zYSq7cr2K7OrPzXJb3ZDxbWPnYrlUMxMqLMVGq54pTgB5iNraKYKV3ATnz+snW5HZCgQ5z3fN3RCBLEL637skEEC4UvcAVDWE9hn30mirsjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771227451; c=relaxed/simple;
	bh=3mdtFi7kHDGYAGP6vZbRHhVyoBLcRsEiHS32hMdjpuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrYIrlRVkkjZlzJXrNUPfpo7FcHJVkJbaGAXpN9rt7iV1mTmpgz+97ocxP6l4v0fae+MYsG3Jn4lzAIm11g0RwU+w08z+PglJCAPSX+P88gFoGlPb1e56X108x8dLlpNBHcpttIhoZ/ig9zBKnrB8jToRuKaiS8TUXFpqWvsGbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jB3RGwdk; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-896f4627dffso37821466d6.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 23:37:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771227449; cv=none;
        d=google.com; s=arc-20240605;
        b=eJ3lwib1t6Nij9or7jyIYLYRpxitfo2PEOjyZdaO+RH0MoQnAhLbDE+Udf36Pwajhi
         VG+/rngZ5OKTHJ/fcR+SavG2IzWzmKoep3RT9+pVawwQ+66M/MTSZYQwtOjPGkeeppNY
         j7t/YwPlfQ/vr2b7CsLVuwydyQc4A9gR0X2peBJj1sGlnn5EEk9Qo+sQcgOfE1ZSXW0U
         1otqFEZdcKrdpbw6wAq0p6kaNbeUGylx48IjyIJstb63wxFynGd/97EuwfdjPNGQV08O
         DJ2GhCa9CsQ8+CSPRaTjzzeXfKPXPd/NRJOOFxTgkxdZaK0MQqzNq75euRlwceHzwoNb
         WNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nbrx3mvsNH1uOFqxGGT/csf8lky+5VJEXXssPMAdppM=;
        fh=oXDWqrjQgHeosrW67vP/cQHADo3mhwY546DAM2ZvSf0=;
        b=NcMJgSIOa4WAKJO7fmzEuEZTnzPAwAHnap5JPcB3ECw2rQ6R1W3mma7u+bRwRwBlru
         d/bjOiPo7lhkR390ji8Ii0QC2nZpILLUhcZAUYqERnirh5pgTIgQ/1bIH9RsoHzOOqTX
         ouTN54zelZOHf9PwQJfM2jcQgresT/1Dhb6pLrOpSA2ooh1oir6DmtO9/UjTL1NOnfMr
         gwLTX/3yLbAgkhoVfOrFKs+pzegnZfYDI2wnzclQOH7m7UuMqHtYSVqEz/vU6sFuNeNC
         fz/BkznpteDgWnZBsX40RsPZeW2pedbXLF1k0eUDHtyEK3QhPCynoNDT/5hwOy1DqefF
         FqzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771227449; x=1771832249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbrx3mvsNH1uOFqxGGT/csf8lky+5VJEXXssPMAdppM=;
        b=jB3RGwdkro7r8v4cinWI2kGv26LgtzpWqknrWr7NukZTQ8S9FZePWk3sEXuuzwQm/X
         pNFsXqh5usk4ri4KZxaUF3SLNTU45WBL9BPjcWDu5D3Hky8U7YxZcSxQJDMyQQ5XXt8m
         gEgrdHYzF8yzOybYGoPCBd0f4OYKU80mcTGSfkL/tslCUjs+JDfdnBtfUp0OX2V1T/a2
         ENUvot7bSDANFpPH9PZ9WJoxUxWkENNN9nWV3bIIFuBVBe0ImcMIrRUFzZL73au685uE
         cwtEBhX3axEDZZjLvlXKiy2FLselAberXLCDI23q69j8FfxiFUpuJrBulB+bNev04Q8o
         wewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771227449; x=1771832249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbrx3mvsNH1uOFqxGGT/csf8lky+5VJEXXssPMAdppM=;
        b=J8RMx/wjzLxOnKVg8HeUGv/AH2ES1EXsWIynSCUFzE04pBSdQJepRMX1LbMeV09D7v
         3bpiQ8cYJkMoDCUQi5xuP1F04aWw1fLlUD5z2d5izFy9a9s6zbQWJBO5FZBxmqiOQdLZ
         bmt+U7rWFc+/9UmYKu3Sfm0u6THqbutShGXdasn1kN9ya02eD2grPnbgxU3+Iq7zrztn
         M73vAoc7UqkJLTg4qgG873HHO/169Lk3IkQWT8/KfjkQvbF4C8QojUf9wn34HaFlp6rU
         6pNdhpZXFT/1BODQ3b4GyM4jAR+JkQdOTdu8ovDicZhCIn32aa6gWMQtkf0WOQq6j2JL
         zA3w==
X-Forwarded-Encrypted: i=1; AJvYcCX/nGVRIrb1ErqzzxdvPqcH5XR1E8F0jwlJ0g37zlnO0ujPR3PyoD4V9J5D5qHOPpNrhDrhIydoWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTuhEAI+mP7whvHhVQSG1rncdtF7U5mnFqdms5x9W/2SshJX0
	bc7o7D+FeaqbdcroZy1g/ORI9WcA58btM5EADobyOOuOunyGQpnQNYMLi8oJGf/Sz8o/YRppxPa
	J78GJKMrcMR0qwo9f9HENlOti8MHdBTs=
X-Gm-Gg: AZuq6aKGA8cKwVe7wyLTBExC21RfsaMYUEWd/+Op+qxfc5p/Bz2wBE1h98hJ0DakLch
	NR2O2NOotMcyvtTP/FViTbLHN87L7AX7D7vEm8q6bqTydDusJ/qyr3cgxp1JCQYK9pz1H2PpQDd
	2O9qrAU4vShcwLXPn+2QdtSfIHcuxXP8mrhZgx4mTnzcsG5AxYpEHLM9D2CqHBPGm2DDT5KCJsl
	j8sKdEIw2vKoaUVO786KCSBObBQXSTZ/Yqul/U7ktXCDWwu9LHjjbr2Phe1M8hjd99y5MmV52Ht
	0oQC6AAMOD5f2KtJ
X-Received: by 2002:a05:6214:1c0a:b0:896:fdcf:731e with SMTP id
 6a1803df08f44-8973606f266mr117873926d6.9.1771227449326; Sun, 15 Feb 2026
 23:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com>
 <20260216-hibernate-perf-v3-2-74e025091145@tencent.com> <CAGsJ_4ynCA_w4Xcwu1k=2Hw3bMnURBxC2FeZEzN+uzBp+9YJcw@mail.gmail.com>
 <aZK0B841VeaDQ5w4@KASONG-MC4>
In-Reply-To: <aZK0B841VeaDQ5w4@KASONG-MC4>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 16 Feb 2026 15:37:18 +0800
X-Gm-Features: AaiRm51YL07XwCLRpDnl1bzYmcZGhOriLqlRjp6yzM2ZWVDai3YuU-_kptZhK_U
Message-ID: <CAGsJ_4wkFZ-uxXO9Rp_Snzym_uXUGD9HDyGF74dF8HmobLfJ3A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm, swap: reduce indention for hibernate
 allocation helper
To: Kairui Song <ryncsn@gmail.com>
Cc: kasong@tencent.com, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Carsten Grohmann <mail@carstengrohmann.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, Carsten Grohmann <carstengrohmann@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-42684-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[tencent.com,kvack.org,linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,carstengrohmann.de,vger.kernel.org,gmx.de];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: F13381414CF
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 2:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Mon, Feb 16, 2026 at 07:20:49AM +0800, Barry Song wrote:
> > On Mon, Feb 16, 2026 at 3:00=E2=80=AFAM Kairui Song via B4 Relay
> > <devnull+kasong.tencent.com@kernel.org> wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > It doesn't have to check the device flag, as the allocator will also
> > > check the device flag and refuse to allocate if the device is not
> > > writable. This might cause a trivial waste of CPU cycles of hibernate
> > > allocation raced with swapoff, but that is very unlikely to happen.
> > > Removing the check on the common path should be more helpful.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  mm/swapfile.c | 38 ++++++++++++++++++--------------------
> > >  1 file changed, 18 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index 32e0e7545ab8..0d1b17c99221 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -1936,27 +1936,25 @@ swp_entry_t swap_alloc_hibernation_slot(int t=
ype)
> > >
> > >         /* This is called for allocating swap entry, not cache */
> > >         if (get_swap_device_info(si)) {
> >
> >
> > I guess we could further reduce indentation by doing:
> > if (!get_swap_device_info(si))
> >     goto fail;
> >
>
> Agree, I think we can make it even simpler by having:
>
> /* Return empty entry if device is not usable (swapoff or full) */
> if (!si || !get_swap_device_info(si))
>         return entry;
>
> Then the `fail` label is also gone.

Yes, this looks even nicer to me. :-)

>
> I'll post a v4 later today combined with your another suggestion. Thanks!

