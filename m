Return-Path: <linux-pm+bounces-42073-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML6jCQc6g2ngjwMAu9opvQ
	(envelope-from <linux-pm+bounces-42073-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 13:22:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBFBE5BAA
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 13:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C213304343A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 12:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0F23EDAA9;
	Wed,  4 Feb 2026 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYpao+gt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425603EDAA4
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207258; cv=pass; b=Jj+rBPVYPJJYrWrNlFneJGvVXVi1AapiKGT/1opNuT4Dmexxpw6kred3YFAVlljEAs3cIm2JZzWVuM6B/v3Eh5zh8rW8GcqiHCTToTpD5oX9zcYYlN6TFYYT2Kt1mJRb3frF5k+/KZdSWLPwrdPfkzUUltumbKMGujp1wmx/AM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207258; c=relaxed/simple;
	bh=8MBG04U3QnqDPVnLNJWrfhfSqjRKRLTT5N9P9lWlMes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ql+DTUdWgSZXpsT5qjpzvu4cPU4CMfJNE3nRPvJwdA1bZFvCMo/ZDn1oQW1HwN9Xq9uys7bUXjwczryXBWCwGWlyXoAW7/CIiFSuz0M2bBTNSWUxzl5OTJBvJM/eH3UlXmf56s+0H2nN3Fe7WX93yNILfC96TV7vZ9iYmYpQodg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYpao+gt; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c711959442so72154785a.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 04:14:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770207257; cv=none;
        d=google.com; s=arc-20240605;
        b=XeJJDqTFJWugj+ZUdD/xZ/BGwWXx+xd9JDrvqepzldp7VYiPmerJ4Zl3yaiVxkqH7W
         RdzbKyOdBibMYOYp75LMdFGmDk4HPTgIFNJsYVquFGY/BT7tNxVmWaDpRqF7aJyhwWC1
         3M2O8YY/sHY5+FctNeZf/4iwaoDVimrQ+PZCaohvD9qEL4DufsaQEyYb3pB4ydguxj+5
         dWEk4OWyAsmNsIsa6riKgvOiHYZ/ihYHtmWKTjM8igk3/ZL510Wi1ONUR5exNYjvH7/7
         FClD3EMaIIfDplNpiR3roVWHyUR7FzJsREFxmhi+i0w/wth2ACoGRSl7CFhKe/Luf6va
         Hwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eduYzEJPsJnZXgDJCbQOgrg2ueFR/j81lePqCh6da1g=;
        fh=3A+YfaT2lCHg2b57Gm3LtVRr2H564G6Hy1zUeZFyCV4=;
        b=loNZiAspCZNA9Oi4k6qcBSvt9AUir+T+1A5n5XimgqPyXJRk0fWQETVOvxc4XuApL+
         9w0+KKM9LKDCY+0ia9b8ZPOTWYor+tk/mM0JOvEOp/cMqg71s5J4ozsuWeMquCIoLbr9
         yUvifjvdWzSiNNxlzM4KQK0MMFenvqIt/oydo1FxARq4Yd4ZHOMs9A35PdZ+YPVF+J+c
         Ac5+YBRK9z0juL7EQti/lcRaQCrDGSKkUhVLeg/ZkPTXRVDgDobAdI6YoP5qGES/sRJ4
         y0gNGrIjPnweSjjP0zn+hVUp0NDwWsLIGjMxAaLcUlI7zmjdjlX+1h7obi7fep1bUonx
         4zIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770207257; x=1770812057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eduYzEJPsJnZXgDJCbQOgrg2ueFR/j81lePqCh6da1g=;
        b=jYpao+gto73rIYyZzCOcYyWkHdG1mR49/T0Ex0HEorqoPmK/d+RF7t6RlXisUA8hxp
         fAUq3eqBfSfaYMj9j9uBToFt+4XasMZK8n7z8kZlSqFUikGCWqZwkkJecrplTLixOnYv
         l8tf+Bc23e6gxJFa8uyczJtTDUmH51euiksn92hnv35k54ibc6zfOy9mY+FAdEpXk2xA
         X1Z6MUUDimorsyq3ZJVPiq39up5fmgZoYcuu8qBzkMRcNOp4bRZjcg/vWeVCTF4leWcP
         jlZKsJoZy+hdiniBPfVosU4/Qu0TPIMclUEBeKzQv6EgL2bwX5KCV4YupkW9g3YB9hdh
         yqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770207257; x=1770812057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eduYzEJPsJnZXgDJCbQOgrg2ueFR/j81lePqCh6da1g=;
        b=v532TZsMXpVybPJj5pzj4igL8GTAhQTXPu/QoxbzEhL8SdQbj1GXq91l2bLDqmSiYl
         xstoMq/Wez/LzPPby0GU6YQYlTuZdX6x6eJaHMM+RYBGP97tJrINnzUV50CWIncGe282
         0W6Cn96If6T+7ytYZJElzGtc3ticyE2YxkArVisrq96E1Cdu2P6HejjxXsr/OV/9LYXh
         8BJKMBWWKiQwXDdxlhZT/zyqieiPzjo46LKSo+qr7LLs579W//xkdB84vx/gEAm8yu94
         KrdIXzMJtDZMLUssKVj601iwkIbzK1P0yHbNdO9+4VrpTK8aEs5L2vfVtj+yo9iSgOUj
         IeWA==
X-Gm-Message-State: AOJu0YyifxtbW0FfWwYoo39l8cb2yJmfBgj2NefwQBi5tWhV7K7Uj29S
	hn0cQXcr15YABSZ6Kp+zq+8uxZpOzVPlE2xb9ZwPjVyA7KquMCVB3AddzDYVuW/D6teJ+hCEKFA
	MRfdbChBm25vITqGafH6d6R6GZWx63NI=
X-Gm-Gg: AZuq6aJexL/apQodq5vo0dAopxQIEQS5Uw6rPh30D24QVV6C91Q1VbT6AlhKJ3WC5Mq
	v+HaaXv3Eflez9+pfr4rxYh7sNGAVnRu4GsQ2q+WJ/vbXslB0bgdcmrvNKI5AIW7k+V5ekwtCwJ
	3P8peXuvpRZPIkcX3Tq3vvgIrAbSfAnb0ijnRnEDmEijNrX/6t4QhicRI3yT0VSbB5m2MEWLmRq
	A3AWEZH1jLt2KK4L/zjTRCkaJsC+9sXx8cFM5oznUecIa/AFgt0VSzbeehvxLYIdWe+EQx1
X-Received: by 2002:a05:622a:1a85:b0:4ec:f260:57bc with SMTP id
 d75a77b69052e-5061bb36254mr24074161cf.10.1770207257192; Wed, 04 Feb 2026
 04:14:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12852589.O9o76ZdvQC@rafael.j.wysocki> <CAB8ipk_VX2VPm706Jwa1=8NSA7_btWL2ieXmBgHr2JcULEP76g@mail.gmail.com>
 <CAJZ5v0iScM-1nTXuex3rhhWOhe+NcVj1X-ObKY=c5TnZk_eB7A@mail.gmail.com>
In-Reply-To: <CAJZ5v0iScM-1nTXuex3rhhWOhe+NcVj1X-ObKY=c5TnZk_eB7A@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 4 Feb 2026 20:14:05 +0800
X-Gm-Features: AZwV_QhhaSYVG5wBsBlPGQ75e8_9-tJqmHChVmwpabJZBGZv6rm7XJDVtt9tr30
Message-ID: <CAB8ipk8jYoqP_JF2sP4jvvW=s0cMA7GUOg00XoMeDQ4p9PEtnA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Clear device async state upfront
 during suspend
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Xuewen Yan <xuewen.yan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42073-lists,linux-pm=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuewenyan94@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BBFBE5BAA
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 8:11=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Wed, Feb 4, 2026 at 3:57=E2=80=AFAM Xuewen Yan <xuewen.yan94@gmail.com=
> wrote:
> >
> > Hi Rafael,
> >
> > On Wed, Feb 4, 2026 at 4:38=E2=80=AFAM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > In all of the system suspend transition phases, async state of all
> > > devices needs to be cleared before starting async processing for any =
of
> > > them because the latter may race with power.work_in_progress updates =
for
> > > the device's parent or suppliers and if it touches bit fields from th=
e
> > > same group (for example, power.must_resume or power.wakeup_path), bit
> > > field corruption is possible.
> > >
> > > Rearrange the code accordingly.
> >
> > Could we use the following patch:
>
> Yes, we can make this change.
>
> > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > index 98a899858ece..afcaaa37a812 100644
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -681,10 +681,10 @@ struct dev_pm_info {
> >         struct list_head        entry;
> >         struct completion       completion;
> >         struct wakeup_source    *wakeup;
> > +       bool                    work_in_progress;       /* Owned by
> > the PM core */
> >         bool                    wakeup_path:1;
> >         bool                    syscore:1;
> >         bool                    no_pm_callbacks:1;      /* Owned by
> > the PM core */
> > -       bool                    work_in_progress:1;     /* Owned by
> > the PM core */
> >         bool                    smart_suspend:1;        /* Owned by
> > the PM core */
> >         bool                    must_resume:1;          /* Owned by
> > the PM core */
> >         bool                    may_skip_resume:1;      /* Set by subsy=
stems */
> >
> > Due to byte alignment, the size of struct dev_pm_info remains unchanged=
,
>
> I had considered making it, but I thought it would cause struct
> dev_pm_info to grow.
>
> > while also preventing concurrency issues between work_in_progress and
> > other variables. Additionally, with this modification, there=E2=80=99s =
no need to traverse the
> > device list twice.
>
> Sure.
>
> I'll just commit the above change with your sign-off, please let me
> know if there are any issues with that.

I have no other questions.

Thanks!

BR
--
xuewen

