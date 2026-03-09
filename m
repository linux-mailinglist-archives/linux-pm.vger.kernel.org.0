Return-Path: <linux-pm+bounces-43954-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF2LA3birmmoJgIAu9opvQ
	(envelope-from <linux-pm+bounces-43954-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 16:08:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF5823B4BA
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 16:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68F21305F4A6
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 15:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D568A3D4100;
	Mon,  9 Mar 2026 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3sKnSn8Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8763B893B
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068515; cv=pass; b=sec+sN5DElWR84gUtMDZOXOnXARWPrW72xG2ZtYc+hoAZdMID2f2Gy1pic49Vvfb8n4KtMncAh5Pq60izLS/y9IXjRtySkdDVzgMMwl1k8H1GO9XdzCy8+sW6vZ1EV+3djJvct6swZeIflMO30+CyplR7T+zWh+XoEfSicmuaeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068515; c=relaxed/simple;
	bh=h7EtG2/RFdznJ5bMZa7pTtYgXQVo9msnCEtSwoMGrSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlipT8/V02DS6MySmil+yPK85bNdlovOp4mfjUo3iWi973XfYThktaNVcl4t05TE+wvTjLFCepDY/o3I4kLYLsVb3Sjarv1638cLXgIUoPnm2dtdvD0ep7K6aCw3IIVPdnOrLjSIsuU0ur8Rqis9J/2vdN//OuGyxwigTNOmcgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3sKnSn8Y; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-509069a7a7fso879831cf.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 08:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068513; cv=none;
        d=google.com; s=arc-20240605;
        b=WVh2qqeuVDqjzG1qpIMqbazbfuMneGI1AT01Mt/NS09TA/hY1p09MvQHOGCnUvTJm4
         aYt62C1BSQ8y7x7i+VUQYu9gQ0rX/nquMHvAVqG/5xSSx7eu8En/Ak0inuhtprgHGltA
         9cR4rGkiGgSOtyIlFBPqN4XUS8aHoroB6hhrG2NOWufqyG3zFR45C2oA0SaH2BnVcysw
         MsulozgOyRW17nCwOdOjXzL+OVriw5jcesTCnKkvN/0pb50JjILpp0h/cXe6Ikq1EV3b
         YaMty1ib4FN5QdxJgkoowxPp5rTG3Mye3czupsWHuhONWHAXcIetCYRRNocHsyqOH+Hp
         ghpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7wNihs39Jd5FXbkJdZd8OCVVLXOnq/532xtOBop5fKc=;
        fh=BNhqLGSAw2r9vopT74OnjSWJhk5IwwZbEmrClba7/WE=;
        b=OdtAOpNzXrfLV/lnR2BZm3Z4DXb3JYwd5Wu/tjxFw0c5ABkiLcq5t46Abi/NnAZHl9
         5ObUehIOY120kYijDPO1FZ/FFhQbBjhmGk3yVTYyGjwDk8bPkRPkoJfqkTTvRBOIiUqi
         pmOBvik1mJvhaZHuJGEg1MI89IstOBxv9Zj2eKhOi8Z+Jx7Jvq8iTW+twj0D9dfw81IB
         FnYtYDfBAlY0Mg4xALMeuhpiMLMMpQ/dYjnZfo/2DoUEiyUT9DqW9nmf9pU8y4Rpg+3L
         Xiz/lSiszREL78s48m2jTHfHc23wK4R8PJwZP6qmwdsEyQvL9yeiR4jicFM5BhkqtPc5
         V6AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773068513; x=1773673313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wNihs39Jd5FXbkJdZd8OCVVLXOnq/532xtOBop5fKc=;
        b=3sKnSn8Yl/VHcMj3QjI7I+CF6SJAhrZhxwCb8jBeUKUgaoIW7sUHgoeUYJdvDkPxuC
         cMOm2151tLbyxOqJleE6zmpCkRbO5ssHNtjwacX+s8LKI8nKz/9hsIvnzskr5H6AG/tj
         UmEneFT3CMSREXPKlQv1Bj2xwMd59weVrV+uLla/VYJIwHStJZ6m4TdUBemjBL34pT7N
         89prFirXkHZMMH8u+FeXt0oC14tSjt94OCvnRqCNBkPL9HJ2V+JF1NdID3TWH2sGNmei
         cvmj9RHcUV+SqcrUUz008iMw1dNZpcFv62ic1zRIrsElKOspTnGLoTUezQSL5LnkYHbw
         Cv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068513; x=1773673313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7wNihs39Jd5FXbkJdZd8OCVVLXOnq/532xtOBop5fKc=;
        b=TIpx08UHCQhMd0H4JASTAYTrRYRFrDK7R6WL7T811x/Jz4FPUdZuJUer0KXo2lxqHl
         W04QL9YCjIgHQ7vT3ce11+ZjtEpmJ6bAJopTYM7Pzb8Z0WiGdKyAG7iL5x5JuzMbx1GE
         fnf+FPXar9+xpb+p09fai5eg6vDbKL2ZACQpN/NLoTeTb8gvNbZCSt1kELCvAApFZ6LW
         ttCyahli5B16+xraFHPbiy66C1+LuOMaUFaVmevDO5yNmGEdOWtOd/u90kw2shlzRuQ5
         kM+zvd81L7AkxM8VvFXZxvSmhvmirghvuDEYrup6meW7umUH7lrktg+ImdHarlGz3ENS
         kRdg==
X-Forwarded-Encrypted: i=1; AJvYcCV+nk6wTvMYUbUL9mkqk5ayI56gL3iy8oIfhGADKDW/rjZ1jkeG8N4ukn5+ithcEWebAsE0MtKxwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzExLtQA9M/je5TrPOlgbCmD4ERQkD+poLmykbkRgO3fU2UIIP0
	w1C6jb+yUxDxyVSl3blwrIN6qefoFeuepUln7OLtADCJpAeQUwWxandwFiDnYKlFc1rNRmu4qe4
	7lMywT7PbweXZMw5IJpgHINNaRl1Ff2LX2ViDLUKH
X-Gm-Gg: ATEYQzzSnvcOpqmxstIkEH3rPfCj/H9yQp8t9wmGl+hi3FDQJeKJAl9ApCwT3fGAl45
	dkuDuer0ncrdzPaL4elObuMEGRKcRRq94UkZenreGbO2/7wITJbm+Hdevx+P/1hQo5xjk/5qyc6
	W5ohO8tUY1qFEg0lCmphRMEBzPJ7iN+8GwF4c7FSp3mayAgPLqJR0deYX7TL/OW+zDKD5byDfXG
	bXGeQPRTYYMhY+3Xd70eIA/8k8ig1swJoqQOLN1jOzwbT43pQn2TylJI1SdYxJGT5Fch3i26xF7
	8fDKW1ECtoZgFsqiw45qisGTibWEgIMjOMyAballcFvLcE0boarFXL/FtTY+Ds4MPpMZG2uy9IX
	R4OaqWN6ze4MM4yQfxuA3Eivc
X-Received: by 2002:ac8:5715:0:b0:501:19b9:42e9 with SMTP id
 d75a77b69052e-50900e74842mr25555001cf.4.1773068512221; Mon, 09 Mar 2026
 08:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309001250.192841-1-berto@igalia.com> <aa6uYoVKegcac2Kq@igalia.com>
In-Reply-To: <aa6uYoVKegcac2Kq@igalia.com>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 9 Mar 2026 11:01:15 -0400
X-Gm-Features: AaiRm51bJne4rROP3TY442ehb60lEM1a0fykgGPZBoPTa_bst6Nk_VgasAAnsDc
Message-ID: <CADyq12z_mhjY9S1_jawX8UuviyYf-ozXn6Q6yB4dHxopD7JmTg@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Drain trailing zero pages on userspace restore
To: Alberto Garcia <berto@igalia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7EF5823B4BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43954-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bgeffon@google.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.964];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,igalia.com:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 7:26=E2=80=AFAM Alberto Garcia <berto@igalia.com> wr=
ote:
>
> On Mon, Mar 09, 2026 at 01:12:50AM +0100, Alberto Garcia wrote:
> >       case SNAPSHOT_ATOMIC_RESTORE:
> > +             /*
> > +              * We need to call snapshot_write_next() one last time
> > +              * before finalizing in order to process any trailing
> > +              * zero pages.
> > +              */
> > +             error =3D snapshot_write_next(&data->handle);
> > +             if (error < 0)
> > +                     break;
>
> I realized that this patch assumes that userspace calls
> SNAPSHOT_ATOMIC_RESTORE only after having written the full image,
> but if that happens earlier I'm not sure that it's safe to call
> snapshot_write_next().
>
> An alternative solution would be to do it at the beginning of
> snapshot_write_finalize() if handle->cur > nr_meta_pages + 1.

I think this makes sense, but if snapshot_write_next() returns
PAGE_SIZE then we need to indicate some error (eg. -ENODATA) in that
the kernel was still expecting another copy page.

Also it appears that the kernel restore path and the userspace restore
path return two different error codes for !snapshot_image_loaded(),
the former does -ENODATA and the latter -EPERM.

>
> If you think that's a better idea I can send v2 of the patch.
>
> Regards,
>
> Berto

