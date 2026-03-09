Return-Path: <linux-pm+bounces-43965-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMpCLV0Hr2kUMAIAu9opvQ
	(envelope-from <linux-pm+bounces-43965-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 18:46:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A78B23DD1E
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 18:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E80723016505
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 17:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F225771;
	Mon,  9 Mar 2026 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ySv9XbhG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A7336892
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078350; cv=pass; b=addm2YGbIF7wVv8X9630aHrRBJ+JOVsKRSZPSWcLsmgpxHcP+Lr9qnw0lnis+QIFfYnSRTgn7clByqDelYQxtUM69nZZnbMB/3kMUFjf/WQuURQtpErvegZqGyYM8tZ8Y/0EjjMPDgboMNTDTGpxi7C3q6bCTacbBoomMg1nf9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078350; c=relaxed/simple;
	bh=Sp1ck38XPEQvPtY9OgUCuXEuFvSUdtH0/Fcq4OWQtLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UN2QvP7fxCb1LCETLZDKKFA8rY2dYX8h3avrWe8fuK/CqeV23b+j1FrVbH/usy9MJGMUuAFEzxkyncLcchQtE5+4JmcO6uA3cQJh95Re+76LFjufCAWBO4sCYNK6b85VfZEHfBEih0KP6R1G4V9Xo5qmAH8yswPVANUWUYi+QeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ySv9XbhG; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-509069a7a7fso66081cf.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 10:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773078348; cv=none;
        d=google.com; s=arc-20240605;
        b=bJASqwIo0lVyrX52U3EUgvw3tsUHCExto1VlW9mdUZW1MHMHSlpuQcLY1Cse4pYKME
         CJpN0yYAVl0iS6ibfOnYjzHPqbYgmzyscgrlfJ0tq/kRHpFT2tO+XkAdqRmHQBYpigPv
         PNGAST+CL6wdmjp6S3vCLNQ7uc7KRYC9YdeW8vuIaSL63gy/rP5Sn91ZihNYutsNultA
         iolQ7ZSJ0PXJNQsQYOh7hu+8PNAPtIVClCvyubt7NQ590MWO5WRfccXZfhq1M7ra7R4d
         nJ+e6TAtsFZDLhp3slY9miiX1FSIZATM9oYw5cDwTLLBtLJ7AxNaiMytWmHTOWzVq4+U
         AKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LLXx0j2j2ZSRGR7qhdKFEOApUsLXz+X63h2dAzslUKw=;
        fh=Z1AosPxSo1pBcoe8Mc/WVf3YUIUf0PGxgoylgqgkE8U=;
        b=lc+5sm9d5+IfeE/NskFlJsyHQ1sjGSwTn84MDPGYl8Kb1WY+pWjszQPC9d/NQMOsCf
         FC18Q8pCyJfnSXOjTXsk1HEBNbnPoSUyJUU3gTYyfE1rFTfFziEm8FN/uY1GSlty4rMI
         jJMfAHet6vdO5TA80G0mlwxbEEolhmI/krB9MMxRc4Bo2dqsXZanSPA6tGSix4Y1hXrR
         vnoqAhyDRzOmN/6MBktbNLi2rGVMCrilvs4ujx0GT7ukW62a+4OEJ94IgZLfeb9/0qDn
         B6ofux0vB9w+hB/qSvPXag+8Jiv4ty8Du1hr1+EoxgWRnAZpYLEbovYyJLgpPd0EZJsq
         IjqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773078348; x=1773683148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLXx0j2j2ZSRGR7qhdKFEOApUsLXz+X63h2dAzslUKw=;
        b=ySv9XbhGVJvs7rmGNUTCsFT9IhIXj+0H2Q9MBsFcAvxzSqQLxo+khkL9jnGEmkfWAY
         psvVfwpqkwtrlmdH2uvmxsDcqjdvGof5eQaQsq6FwXlE5vw6vjOaaL1uC4tPT/nGzkqp
         m3hhrA+QOGatodPVYRHc33ef/+CIbrI8oKzmiPhCkJJvY2LYMzdj04DJdAwL/K75D6bQ
         qc+g68bdfMzvaMu5EMmXzkFn4hIVmo4HCVPdcRPQoX5lxm09GMoT+ohjV7CYmKuCcC6D
         cnMpkbtyTBXh8kDtm82cNgg0qaNugFMG9kWTOOh/z0bOW6umZAM6wucCve20NImVa6Zl
         U9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078348; x=1773683148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LLXx0j2j2ZSRGR7qhdKFEOApUsLXz+X63h2dAzslUKw=;
        b=iJGi48LTGMPOQ11S0MEStGcHTxnhWrN/dj3w8WetGq5kiehwkitH4hcIstby99ia3d
         gSwdVz4RZTtBRWccCMqvm6OfpHNQ/41K7STLdSAT1mPCYVUF0WuDddjV61rS+MqCZ0Mz
         uZJvS8dc4Zw2GYKp1F8lAUA5ow7agyid/dOwgT1RhHs+myW2lMCn84HYe2067JK9H4bt
         2adEFPlKQpaa3KbE8XNQijCNsGpbTTh96fgtwdTTL6FTdaCkQxe/nmHYgGc3Rf+AgEiT
         EjWHT51jysR+SDswjy7oB+J+F/ZblywuGjflzj1HdV3jAiniqafLCMTBGbDU8O0xhdjD
         je8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMIb17VIbA4OeQE1NAdkRSdV3RoeXp3kWTHhmMoxkxgjJBfBwHIiQP81lmTDmN+G0GMV38QYleog==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ2sgJvV013/rAkSETCwQTsuV3m/M1EHx0LUOg53v0ct8UFo5E
	GgXm6S75RB0e33SeykUO9rfFrsM1qcP4O2KBN+zlhKoIzdOurY8l3X5BFFL9Fs9VpAebveBru3c
	aKM/0ITz3HXiM09tr0iwgGxTzQLMy/J2y3ha+N6Pv
X-Gm-Gg: ATEYQzwoofrZ3x3RuV824QoeX9PiM5SGEEEbLqNst7BcJfPTu8xiOOGjuicNykyZ2xk
	ZyRfM5YeiQas5mSZ5j73lM+NBltxiYLY0Mec+XGHPTZWUmAhy1db917R7CCtyT7BCuAmPsiWtrT
	vO09gQ2fU0OTnZfTOAGkuJmz8nv3N8Kj03slsGw+c/2WbgiXCEL1NTCHOiFMjoLvvqSDOccjqEN
	DhEuKMO1Q161QYVKPQg5BT+XgrOwmQH3A0yzpDwWLDuD/CEHGfI/KM9jB5F1EN/OcNOyvD90lM+
	tP2sKJiHNqHXGVotdL8j6yZMHFcvqp7IFCV9hLQ3g1dCGc+h5l3OF1q8zzoWoXCKUz5ul9chx7J
	31wq38kane7B47LLtjrrIFcNw
X-Received: by 2002:a05:622a:2ca:b0:508:fd42:fd05 with SMTP id
 d75a77b69052e-5092703e6femr591641cf.15.1773078347433; Mon, 09 Mar 2026
 10:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773075892.git.berto@igalia.com> <8cfda38659c623f5392f3458cb32504ffd556a74.1773075892.git.berto@igalia.com>
In-Reply-To: <8cfda38659c623f5392f3458cb32504ffd556a74.1773075892.git.berto@igalia.com>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 9 Mar 2026 13:45:09 -0400
X-Gm-Features: AaiRm51nzeunSTsG_dDc8Px8SPmPgpSb1F8WDJaz-zWlzoxaxtBnCT4KSch_nTw
Message-ID: <CADyq12y84YNagLTKGnRiP=UZF049uFjz4FJX5Mi9mNzG5hx-qg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PM: hibernate: return -ENODATA if the snapshot
 image is not loaded
To: Alberto Garcia <berto@igalia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1A78B23DD1E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43965-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bgeffon@google.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 1:40=E2=80=AFPM Alberto Garcia <berto@igalia.com> wr=
ote:
>
> snapshot_image_loaded() is used in both the in-kernel and the
> userspace restore path to ensure that the snapshot image has been
> completely loaded. However the latter path returns -EPERM in such
> situations, which is meant for cases where the operation is neither
> write-only nor ready.
>
> This patch updates the check so the returned error code is -ENODATA in
> both cases.
>
> Suggested-by: Brian Geffon <bgeffon@google.com>
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Acked-by: Brian Geffon <bgeffon@google.com>

> ---
>  kernel/power/user.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 4401cfe26e5c..be77f3556bd7 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -322,11 +322,14 @@ static long snapshot_ioctl(struct file *filp, unsig=
ned int cmd,
>                 error =3D snapshot_write_finalize(&data->handle);
>                 if (error)
>                         break;
> -               if (data->mode !=3D O_WRONLY || !data->frozen ||
> -                   !snapshot_image_loaded(&data->handle)) {
> +               if (data->mode !=3D O_WRONLY || !data->frozen) {
>                         error =3D -EPERM;
>                         break;
>                 }
> +               if (!snapshot_image_loaded(&data->handle)) {
> +                       error =3D -ENODATA;
> +                       break;
> +               }
>                 error =3D hibernation_restore(data->platform_support);
>                 break;
>
> --
> 2.47.3
>

